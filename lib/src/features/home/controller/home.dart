import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gian_ticket_task/src/features/home/model/response/ticket_model.dart';
import 'package:gian_ticket_task/src/features/home/services/ticket_service.dart';

typedef HomeNotifier = AsyncNotifierProvider<HomeProvider, List<Ticket>>;

final homeProvider = HomeNotifier(HomeProvider.new);

class HomeProvider extends AsyncNotifier<List<Ticket>> {
  int ticketCount = 0;
  @override
  Future<List<Ticket>> build() async {
    ticketCount = (await TicketService().fetchTickets()).length;
    return await TicketService().fetchTickets();
  }

  // Future<void> refreshTickets() async {
  //   state = await AsyncValue.guard(() => TicketService().fetchTickets());
  // }
}
