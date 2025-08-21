import 'package:flutter_bloc/flutter_bloc.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<BookAppointmentEvent>(_onBookAppointment);
    on<CancelBookingEvent>(_onCancelBooking);
  }

  Future<void> _onBookAppointment(
    BookAppointmentEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());
    try {
      // محاكاة عملية الحجز
      await Future.delayed(const Duration(seconds: 2));
      emit(BookingSuccess('تم الحجز بنجاح'));
    } catch (e) {
      emit(BookingError('فشل في الحجز'));
    }
  }
}