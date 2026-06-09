import bcrypt from 'bcryptjs';
import dotenv from 'dotenv';
import { ensureDatabase, pool } from './mysql.js';

dotenv.config();

export async function initializeDatabase() {
  await ensureDatabase();

  await pool.query(`
    CREATE TABLE IF NOT EXISTS admin_users (
      id INT AUTO_INCREMENT PRIMARY KEY,
      username VARCHAR(100) NOT NULL UNIQUE,
      password_hash VARCHAR(255) NOT NULL,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB;
  `);

  await pool.query(`
    CREATE TABLE IF NOT EXISTS settings (
      id INT AUTO_INCREMENT PRIMARY KEY,
      site_name VARCHAR(200) NOT NULL DEFAULT 'YesyStyle',
      site_subtitle VARCHAR(255) NOT NULL DEFAULT 'Eventos que cuentan historias',
      hero_image_base64 LONGTEXT NULL,
      whatsapp VARCHAR(255) NULL,
      instagram VARCHAR(255) NULL,
      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    ) ENGINE=InnoDB;
  `);

  await pool.query(`
    CREATE TABLE IF NOT EXISTS events (
      id VARCHAR(64) PRIMARY KEY,
      title VARCHAR(255) NOT NULL,
      description TEXT NOT NULL,
      image_base64 LONGTEXT NULL,
      event_date DATETIME NOT NULL,
      attendees INT NOT NULL DEFAULT 0,
      location VARCHAR(255) NULL,
      category VARCHAR(100) NULL,
      is_visible BOOLEAN NOT NULL DEFAULT TRUE,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    ) ENGINE=InnoDB;
  `);

  await pool.query(`
    CREATE TABLE IF NOT EXISTS products (
      id VARCHAR(64) PRIMARY KEY,
      name VARCHAR(255) NOT NULL,
      description TEXT NOT NULL,
      image_base64 LONGTEXT NULL,
      price DECIMAL(10,2) NULL,
      category VARCHAR(100) NULL,
      is_visible BOOLEAN NOT NULL DEFAULT TRUE,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    ) ENGINE=InnoDB;
  `);

  await pool.query(`
    CREATE TABLE IF NOT EXISTS blog_posts (
      id VARCHAR(64) PRIMARY KEY,
      title VARCHAR(255) NOT NULL,
      content TEXT NOT NULL,
      image_base64 LONGTEXT NULL,
      tags VARCHAR(255) NULL,
      is_visible BOOLEAN NOT NULL DEFAULT TRUE,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    ) ENGINE=InnoDB;
  `);

  const [settingsRows] = await pool.query('SELECT id FROM settings LIMIT 1');
  if (settingsRows.length === 0) {
    await pool.query('INSERT INTO settings (site_name, site_subtitle) VALUES (?, ?)', [
      'YesyStyle',
      'Eventos que cuentan historias',
    ]);
  }

  const adminUser = process.env.ADMIN_USERNAME || 'admin';
  const adminPass = process.env.ADMIN_PASSWORD || 'YesyStyle2024!';

  const [adminRows] = await pool.query('SELECT id FROM admin_users WHERE username = ? LIMIT 1', [adminUser]);
  if (adminRows.length === 0) {
    const hash = await bcrypt.hash(adminPass, 10);
    await pool.query('INSERT INTO admin_users (username, password_hash) VALUES (?, ?)', [adminUser, hash]);
  }
}
