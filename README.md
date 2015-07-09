Vending Machine Tech Test
========================

This is a Ruby solution to the first 2/3 features in https://github.com/guyroyse/vending-machine-kata 

I used a feature-test:unit-test cylic approach of writing a high level feature test for each feature and then writing the related unit tests, followed refactoring, which ultimately involved extracting two additional classes, those of Coin and CoinManager.

[TODO UML Diagram]



Outstanding issues
------------------

### Code

* Reasonably happy with CoinManager class as far as it has got, however one line in `make_change` stands out as being somewhat unreadable, i.e. `coins.delete coins.select { |c| c.value == -remainder }` - would likely be refactoring as subsequent features are added so leave for now

* Coin constants create atomic pennies, nickels etc., might need to be their own objects in future, but fine for now.

* Product is just a data holder at present - could become a struct or is there more functionality to be handed over to it?

* VendingMachine hardcoded to work with certain products - in long run we assume vending machine needs to be loaded with different products

  * not very happy with `ready_to_insufficient_payment_reset` variable name - would like to find better - perhaps as part of extracting a display class?

  * some strings hard coded with display - would be nice to pull out to CONSTANTS or even international language file

  * not keen on `self.ready_to_reset = true if @display == 'THANK YOU'` in handle_purchase_completed_state method.  Ideally we shouldn't rely on display as the state.  Going forward would be nice to extract state machine: https://github.com/pluginaweek/state_machine

  * handle_insufficient_payment_state could be improved by extracting a few more methods and also relies on state of display as above issue

### Tests

*  vending_machine_spec - invalid coins context maybe should be in a integration test ...

* want to get to `CoinManager#make_change manage multiple coin overpayment` and ` CoinManager#make_change manage coins in ascending order` pending tests

* helper methods for vending_machine_integration_spec
