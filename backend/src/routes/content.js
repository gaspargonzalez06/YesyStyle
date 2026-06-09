import express from 'express';
import { randomUUID } from 'crypto';
import { pool } from '../db/mysql.js';
import { requireAuth } from '../middleware/auth.js';

const router = express.Router();

router.get('/public', async (_req, res) => {
  try {
    const [[settings]] = await pool.query('SELECT * FROM settings LIMIT 1');
    const [events] = await pool.query('SELECT * FROM events WHERE is_visible = TRUE ORDER BY event_date DESC');
    const [products] = await pool.query('SELECT * FROM products WHERE is_visible = TRUE ORDER BY created_at DESC');
    const [posts] = await pool.query('SELECT * FROM blog_posts WHERE is_visible = TRUE ORDER BY created_at DESC');
    return res.json({ settings, events, products, posts });
  } catch (e) {
    return res.status(500).json({ message: 'Error interno', error: e.message });
  }
});

router.get('/admin/all', requireAuth, async (_req, res) => {
  try {
    const [[settings]] = await pool.query('SELECT * FROM settings LIMIT 1');
    const [events] = await pool.query('SELECT * FROM events ORDER BY event_date DESC');
    const [products] = await pool.query('SELECT * FROM products ORDER BY created_at DESC');
    const [posts] = await pool.query('SELECT * FROM blog_posts ORDER BY created_at DESC');
    return res.json({ settings, events, products, posts });
  } catch (e) {
    return res.status(500).json({ message: 'Error interno', error: e.message });
  }
});

router.put('/admin/settings', requireAuth, async (req, res) => {
  const { site_name, site_subtitle, hero_image_base64, whatsapp, instagram } = req.body;
  await pool.query(
    'UPDATE settings SET site_name=?, site_subtitle=?, hero_image_base64=?, whatsapp=?, instagram=? WHERE id=1',
    [site_name, site_subtitle, hero_image_base64, whatsapp, instagram]
  );
  res.json({ ok: true });
});

router.post('/admin/events', requireAuth, async (req, res) => {
  const id = req.body.id || randomUUID();
  const { title, description, image_base64, event_date, attendees = 0, location, category, is_visible = true } = req.body;
  await pool.query(
    'INSERT INTO events (id,title,description,image_base64,event_date,attendees,location,category,is_visible) VALUES (?,?,?,?,?,?,?,?,?)',
    [id, title, description, image_base64, event_date, attendees, location, category, is_visible]
  );
  res.json({ ok: true, id });
});

router.put('/admin/events/:id', requireAuth, async (req, res) => {
  const { id } = req.params;
  const { title, description, image_base64, event_date, attendees = 0, location, category, is_visible = true } = req.body;
  await pool.query(
    'UPDATE events SET title=?,description=?,image_base64=?,event_date=?,attendees=?,location=?,category=?,is_visible=? WHERE id=?',
    [title, description, image_base64, event_date, attendees, location, category, is_visible, id]
  );
  res.json({ ok: true });
});

router.delete('/admin/events/:id', requireAuth, async (req, res) => {
  await pool.query('DELETE FROM events WHERE id=?', [req.params.id]);
  res.json({ ok: true });
});

router.post('/admin/products', requireAuth, async (req, res) => {
  const id = req.body.id || randomUUID();
  const { name, description, image_base64, price, category, is_visible = true } = req.body;
  await pool.query(
    'INSERT INTO products (id,name,description,image_base64,price,category,is_visible) VALUES (?,?,?,?,?,?,?)',
    [id, name, description, image_base64, price, category, is_visible]
  );
  res.json({ ok: true, id });
});

router.put('/admin/products/:id', requireAuth, async (req, res) => {
  const { name, description, image_base64, price, category, is_visible = true } = req.body;
  await pool.query(
    'UPDATE products SET name=?,description=?,image_base64=?,price=?,category=?,is_visible=? WHERE id=?',
    [name, description, image_base64, price, category, is_visible, req.params.id]
  );
  res.json({ ok: true });
});

router.delete('/admin/products/:id', requireAuth, async (req, res) => {
  await pool.query('DELETE FROM products WHERE id=?', [req.params.id]);
  res.json({ ok: true });
});

router.post('/admin/blog', requireAuth, async (req, res) => {
  const id = req.body.id || randomUUID();
  const { title, content, image_base64, tags, is_visible = true } = req.body;
  await pool.query(
    'INSERT INTO blog_posts (id,title,content,image_base64,tags,is_visible) VALUES (?,?,?,?,?,?)',
    [id, title, content, image_base64, tags, is_visible]
  );
  res.json({ ok: true, id });
});

router.put('/admin/blog/:id', requireAuth, async (req, res) => {
  const { title, content, image_base64, tags, is_visible = true } = req.body;
  await pool.query(
    'UPDATE blog_posts SET title=?,content=?,image_base64=?,tags=?,is_visible=? WHERE id=?',
    [title, content, image_base64, tags, is_visible, req.params.id]
  );
  res.json({ ok: true });
});

router.delete('/admin/blog/:id', requireAuth, async (req, res) => {
  await pool.query('DELETE FROM blog_posts WHERE id=?', [req.params.id]);
  res.json({ ok: true });
});

export default router;
