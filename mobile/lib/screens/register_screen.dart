import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  final String role;

  const RegisterScreen({super.key, required this.role});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _currentStep = 0;

  // Paso 1 — datos personales
  String _gender = 'mama';
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();
  final _numberController = TextEditingController();
  final _floorController = TextEditingController();
  final _phoneController = TextEditingController();

  // Paso 2 — familia
  final List<_Child> _children = [];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    _streetController.dispose();
    _numberController.dispose();
    _floorController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Color get _accentColor =>
      widget.role == 'parent' ? AppColors.parentMain : AppColors.sitterMain;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.blueMain),
          onPressed: () {
            if (_currentStep > 0) {
              setState(() => _currentStep--);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: Image.asset('assets/logo.png', height: 36),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _StepIndicator(currentStep: _currentStep, accentColor: _accentColor),
          Expanded(
            child: _currentStep == 0 ? _buildStep1() : _buildStep2(),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Soy:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textMain)),
              const SizedBox(width: 16),
              _GenderButton(label: 'Papá', value: 'papa', selected: _gender, color: _accentColor, onTap: (v) => setState(() => _gender = v)),
              const SizedBox(width: 8),
              _GenderButton(label: 'Mamá', value: 'mama', selected: _gender, color: _accentColor, onTap: (v) => setState(() => _gender = v)),
            ],
          ),
          const SizedBox(height: 20),
          _field('Nombre', _nameController),
          const SizedBox(height: 14),
          _field('Mail', _emailController, keyboard: TextInputType.emailAddress),
          const SizedBox(height: 14),
          _field('Ciudad', _cityController),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(flex: 3, child: _field('Calle', _streetController)),
              const SizedBox(width: 8),
              Expanded(flex: 1, child: _field('Nº', _numberController)),
            ],
          ),
          const SizedBox(height: 14),
          _field('Escalera, planta, puerta, etc.', _floorController),
          const SizedBox(height: 14),
          _field('Móvil', _phoneController, keyboard: TextInputType.phone, hint: '+xx xxx xxx xxx'),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () => setState(() => _currentStep = 1),
              style: ElevatedButton.styleFrom(
                backgroundColor: _accentColor,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Siguiente', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Datos de tu familia:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMain)),
          const SizedBox(height: 16),
          if (_children.isNotEmpty)
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _children.map((c) => _ChildAvatar(child: c)).toList(),
            )
          else
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'Según se vayan añadiendo hijos\nirán apareciendo aquí',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.grey, fontSize: 14),
                ),
              ),
            ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton.icon(
              onPressed: () => _showAddChildSheet(context),
              icon: Icon(Icons.add, color: _accentColor),
              label: Text('Añadir Hij@', style: TextStyle(color: _accentColor, fontSize: 15, fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: _accentColor),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: _accentColor,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Finalizar registro', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddChildSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _AddChildSheet(
        accentColor: _accentColor,
        onAdd: (child) => setState(() => _children.add(child)),
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl, {TextInputType? keyboard, String? hint}) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboard,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(color: AppColors.grey),
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _accentColor, width: 2)),
      ),
    );
  }
}

// — Step indicator —

class _StepIndicator extends StatelessWidget {
  final int currentStep;
  final Color accentColor;

  const _StepIndicator({required this.currentStep, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          _Step(label: 'Tu\ninformación', active: currentStep >= 0, color: accentColor),
          Expanded(child: Divider(color: currentStep >= 1 ? accentColor : AppColors.grey, thickness: 2)),
          _Step(label: 'Tu\nFamilia', active: currentStep >= 1, color: accentColor),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  final String label;
  final bool active;
  final Color color;

  const _Step({required this.label, required this.active, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: active ? color : AppColors.grey,
          child: const Icon(Icons.check, color: Colors.white, size: 16),
        ),
        const SizedBox(height: 4),
        Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: active ? color : AppColors.grey, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

// — Gender button —

class _GenderButton extends StatelessWidget {
  final String label;
  final String value;
  final String selected;
  final Color color;
  final ValueChanged<String> onTap;

  const _GenderButton({required this.label, required this.value, required this.selected, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isSelected = selected == value;
    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? color : AppColors.white,
          border: Border.all(color: isSelected ? color : AppColors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(label, style: TextStyle(color: isSelected ? AppColors.white : AppColors.textMain, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

// — Child avatar —

class _Child {
  final String name;
  final String gender;
  final DateTime birthDate;
  final String allergies;
  final String comments;

  _Child({required this.name, required this.gender, required this.birthDate, required this.allergies, required this.comments});

  int get age {
    final now = DateTime.now();
    int years = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) years--;
    return years;
  }
}

class _ChildAvatar extends StatelessWidget {
  final _Child child;

  const _ChildAvatar({required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: child.gender == 'nino' ? AppColors.parentMain.withOpacity(0.15) : AppColors.sitterMain.withOpacity(0.15),
          child: Text(child.gender == 'nino' ? '👦' : '👧', style: const TextStyle(fontSize: 28)),
        ),
        const SizedBox(height: 4),
        Text(child.age.toString(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textMain)),
      ],
    );
  }
}

// — Add child bottom sheet —

class _AddChildSheet extends StatefulWidget {
  final Color accentColor;
  final ValueChanged<_Child> onAdd;

  const _AddChildSheet({required this.accentColor, required this.onAdd});

  @override
  State<_AddChildSheet> createState() => _AddChildSheetState();
}

class _AddChildSheetState extends State<_AddChildSheet> {
  String _gender = 'nino';
  final _nameController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _commentsController = TextEditingController();
  DateTime? _birthDate;

  @override
  void dispose() {
    _nameController.dispose();
    _allergiesController.dispose();
    _commentsController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 3),
      firstDate: DateTime(DateTime.now().year - 18),
      lastDate: DateTime.now(),
    );
    if (date != null) setState(() => _birthDate = date);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: MediaQuery.of(context).viewInsets.bottom + 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Text('Añadir hij@', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMain))),
            const SizedBox(height: 20),
            Row(
              children: [
                _GenderButton(label: 'Niño 👦', value: 'nino', selected: _gender, color: widget.accentColor, onTap: (v) => setState(() => _gender = v)),
                const SizedBox(width: 8),
                _GenderButton(label: 'Niña 👧', value: 'nina', selected: _gender, color: widget.accentColor, onTap: (v) => setState(() => _gender = v)),
              ],
            ),
            const SizedBox(height: 16),
            _sheetField('Nombre', _nameController),
            const SizedBox(height: 14),
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: AppColors.grey, size: 18),
                    const SizedBox(width: 10),
                    Text(
                      _birthDate == null ? 'Fecha de nacimiento' : '${_birthDate!.day.toString().padLeft(2, '0')}-${_monthName(_birthDate!.month)}-${_birthDate!.year}',
                      style: TextStyle(color: _birthDate == null ? AppColors.grey : AppColors.textMain, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            _sheetField('Alergias/Intolerancias', _allergiesController, maxLines: 2),
            const SizedBox(height: 14),
            _sheetField('Comentarios', _commentsController, maxLines: 2),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.grey),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Cancelar', style: TextStyle(color: AppColors.grey)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_nameController.text.isNotEmpty && _birthDate != null) {
                        widget.onAdd(_Child(
                          name: _nameController.text,
                          gender: _gender,
                          birthDate: _birthDate!,
                          allergies: _allergiesController.text,
                          comments: _commentsController.text,
                        ));
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.accentColor,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Añadir', style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sheetField(String label, TextEditingController ctrl, {int maxLines = 1}) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.grey),
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: widget.accentColor, width: 2)),
      ),
    );
  }

  String _monthName(int month) {
    const months = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'];
    return months[month - 1];
  }
}
