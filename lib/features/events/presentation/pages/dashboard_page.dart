import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/breakpoints.dart';
import '../../../../core/constants/user_roles.dart';
import '../../../../shared/widgets/event_card.dart';
import '../../../../shared/widgets/animated_calendar.dart';
import '../../data/repositories/mock_event_repository.dart';
import '../../domain/models/event.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  late List<Event> _allEvents;
  late List<Event> _filteredEvents;
  EventCategory? _selectedCategory;
  EventStatus? _selectedStatus;
  String _searchQuery = '';
  bool _showCalendar = false;
  DateTime _selectedDate = DateTime.now();

  late AnimationController _listAnimationController;

  @override
  void initState() {
    super.initState();
    _allEvents = MockEventRepository.getMockEvents();
    _filteredEvents = _allEvents;

    _listAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _listAnimationController.forward();
  }

  @override
  void dispose() {
    _listAnimationController.dispose();
    super.dispose();
  }

  void _filterEvents() {
    setState(() {
      _filteredEvents = _allEvents;

      // Apply search filter
      if (_searchQuery.isNotEmpty) {
        _filteredEvents = MockEventRepository.searchEvents(_searchQuery);
      }

      // Apply category filter
      if (_selectedCategory != null) {
        _filteredEvents = _filteredEvents
            .where((event) => event.category == _selectedCategory)
            .toList();
      }

      // Apply status filter
      if (_selectedStatus != null) {
        _filteredEvents = _filteredEvents
            .where((event) => event.status == _selectedStatus)
            .toList();
      }

      // Sort by date
      _filteredEvents.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    });

    _listAnimationController.reset();
    _listAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = Breakpoints.isMobile(screenWidth);
    final isTablet = Breakpoints.isTablet(screenWidth);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // App Bar
          _buildAppBar(),

          // Search and Filters
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: _buildSearchAndFilters(),
            ),
          ),

          // Calendar Toggle Button
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Eventos Disponibles (${_filteredEvents.length})',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _showCalendar ? Icons.grid_view : Icons.calendar_month,
                      color: AppColors.roseGold,
                    ),
                    onPressed: () {
                      setState(() {
                        _showCalendar = !_showCalendar;
                      });
                    },
                    tooltip: _showCalendar
                        ? 'Vista de cuadrícula'
                        : 'Vista de calendario',
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // Calendar or Event Grid
          if (_showCalendar)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: AnimatedCalendar(
                  events: _filteredEvents,
                  selectedDay: _selectedDate,
                  onDaySelected: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              sliver: _buildEventGrid(isMobile, isTablet),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),

      // Floating Action Button - Solo para organizadores y admins
      floatingActionButton: UserRoleManager.isClient
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                // Navigate to create event
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Función de crear evento próximamente...'),
                    backgroundColor: AppColors.roseGold,
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Crear Evento'),
              backgroundColor: AppColors.roseGold,
            ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      actions: [
        // Role Selector
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: PopupMenuButton<UserRole>(
            icon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  UserRoleManager.isClient 
                      ? Icons.person 
                      : UserRoleManager.isOrganizer 
                          ? Icons.business_center 
                          : Icons.admin_panel_settings,
                  color: AppColors.roseGold,
                ),
                const SizedBox(width: 8),
                Text(
                  UserRoleManager.getCurrentRoleName(),
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_drop_down, color: AppColors.textPrimary),
              ],
            ),
            onSelected: (role) {
              setState(() {
                UserRoleManager.setRole(role);
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: UserRole.client,
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: UserRoleManager.isClient 
                          ? AppColors.roseGold 
                          : AppColors.textSecondary,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Cliente',
                      style: TextStyle(
                        fontWeight: UserRoleManager.isClient 
                            ? FontWeight.bold 
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: UserRole.organizer,
                child: Row(
                  children: [
                    Icon(
                      Icons.business_center,
                      color: UserRoleManager.isOrganizer 
                          ? AppColors.roseGold 
                          : AppColors.textSecondary,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Organizador',
                      style: TextStyle(
                        fontWeight: UserRoleManager.isOrganizer 
                            ? FontWeight.bold 
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: UserRole.admin,
                child: Row(
                  children: [
                    Icon(
                      Icons.admin_panel_settings,
                      color: UserRoleManager.isAdmin 
                          ? AppColors.roseGold 
                          : AppColors.textSecondary,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Administrador',
                      style: TextStyle(
                        fontWeight: UserRoleManager.isAdmin 
                            ? FontWeight.bold 
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.background.withOpacity(0.9),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      children: [
        // Search Bar
        TextField(
          decoration: InputDecoration(
            hintText: 'Buscar eventos...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _searchQuery = '';
                      });
                      _filterEvents();
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
            _filterEvents();
          },
        ),

        const SizedBox(height: 16),

        // Filters
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const Text(
                'Filtrar por: ',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 12),
              
              // Status Chips
              _buildFilterChip(
                'Próximos',
                _selectedStatus == EventStatus.upcoming,
                () {
                  setState(() {
                    _selectedStatus = _selectedStatus == EventStatus.upcoming
                        ? null
                        : EventStatus.upcoming;
                  });
                  _filterEvents();
                },
              ),
              _buildFilterChip(
                'En Curso',
                _selectedStatus == EventStatus.ongoing,
                () {
                  setState(() {
                    _selectedStatus = _selectedStatus == EventStatus.ongoing
                        ? null
                        : EventStatus.ongoing;
                  });
                  _filterEvents();
                },
              ),
              _buildFilterChip(
                'Finalizados',
                _selectedStatus == EventStatus.finished,
                () {
                  setState(() {
                    _selectedStatus = _selectedStatus == EventStatus.finished
                        ? null
                        : EventStatus.finished;
                  });
                  _filterEvents();
                },
              ),
              
              const SizedBox(width: 8),
              Container(
                width: 1,
                height: 24,
                color: AppColors.surfaceLight,
              ),
              const SizedBox(width: 8),
              
              // Category Chips
              _buildFilterChip(
                '🎤 Conferencias',
                _selectedCategory == EventCategory.conference,
                () {
                  setState(() {
                    _selectedCategory = _selectedCategory == EventCategory.conference
                        ? null
                        : EventCategory.conference;
                  });
                  _filterEvents();
                },
              ),
              _buildFilterChip(
                '🛠️ Workshops',
                _selectedCategory == EventCategory.workshop,
                () {
                  setState(() {
                    _selectedCategory = _selectedCategory == EventCategory.workshop
                        ? null
                        : EventCategory.workshop;
                  });
                  _filterEvents();
                },
              ),
              _buildFilterChip(
                '👥 Meetups',
                _selectedCategory == EventCategory.meetup,
                () {
                  setState(() {
                    _selectedCategory = _selectedCategory == EventCategory.meetup
                        ? null
                        : EventCategory.meetup;
                  });
                  _filterEvents();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
        selectedColor: AppColors.roseGold.withOpacity(0.2),
        checkmarkColor: AppColors.roseGold,
        labelStyle: TextStyle(
          color: isSelected ? AppColors.roseGold : AppColors.textSecondary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildEventGrid(bool isMobile, bool isTablet) {
    if (_filteredEvents.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.event_busy,
                size: 64,
                color: AppColors.textLight,
              ),
              const SizedBox(height: 16),
              const Text(
                'No se encontraron eventos',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  setState(() {
                    _searchQuery = '';
                    _selectedCategory = null;
                    _selectedStatus = null;
                  });
                  _filterEvents();
                },
                child: const Text('Limpiar filtros'),
              ),
            ],
          ),
        ),
      );
    }

    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: isMobile ? 1.2 : 0.85,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final event = _filteredEvents[index];
          final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: _listAnimationController,
              curve: Interval(
                (index / _filteredEvents.length) * 0.5,
                1.0,
                curve: Curves.easeOut,
              ),
            ),
          );

          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.2),
                end: Offset.zero,
              ).animate(animation),
              child: EventCard(
                event: event,
                onTap: () {
                  context.go('/event/${event.id}');
                },
              ),
            ),
          );
        },
        childCount: _filteredEvents.length,
      ),
    );
  }
}
