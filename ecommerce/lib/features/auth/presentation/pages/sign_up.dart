import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/widgets/input.dart';
import '../../../../core/presentation/widgets/button.dart';
import '../../../../core/presentation/routes/routes.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _acceptedTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(AuthSignupRequested(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.user != null) {
          context.go(Routes.home);
        }
        if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => context.pop(),
                          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          child: const Text(
                            'ECOM',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF3E50F3),
                              letterSpacing: 2,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text('Create your account',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 24),
                    Input(
                      controller: _nameController,
                      label: 'Name',
                      hint: 'ex: jon smith',
                      validator: (v) => v == null || v.isEmpty ? 'Enter name' : null,
                    ),
                    const SizedBox(height: 16),
                    Input(
                      controller: _emailController,
                      label: 'Email',
                      hint: 'ex: jon.smith@email.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => v == null || v.isEmpty ? 'Enter email' : null,
                    ),
                    const SizedBox(height: 16),
                    Input(
                      controller: _passwordController,
                      label: 'Password',
                      isPassword: true,
                      validator: (v) => v == null || v.length < 6 ? 'Min 6 chars' : null,
                    ),
                    const SizedBox(height: 16),
                    Input(
                      controller: _confirmPasswordController,
                      label: 'Confirm password',
                      isPassword: true,
                      validator: (v) => v == null || v != _passwordController.text
                          ? 'Passwords do not match'
                          : null,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Checkbox(
                          value: _acceptedTerms,
                          onChanged: (val) => setState(() => _acceptedTerms = val ?? false),
                          visualDensity: VisualDensity.compact,
                        ),
                        const Expanded(
                          child: Text('I understood the terms & policy.',
                              style: TextStyle(fontSize: 12)),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3E50F3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: state.isLoading || !_acceptedTerms ? null : _submit,
                        child: Text(
                          state.isLoading ? 'SIGNING UP...' : 'SIGN UP',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => context.go(Routes.signIn),
                      child: const Text('Have an account? SIGN IN'),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


