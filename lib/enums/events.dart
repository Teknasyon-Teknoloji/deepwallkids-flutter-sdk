enum Event {
  PAYWALL_REQUESTED,
  PAYWALL_RESPONSE_RECEIVED,
  PAYWALL_RESPONSE_FAILURE,
  PAYWALL_OPENED,
  PAYWALL_NOT_OPENED,
  PAYWALL_ACTION_SHOW_DISABLED,
  PAYWALL_CLOSED,
  PAYWALL_EXTRA_DATA_RECEIVED,
  PAYWALL_PURCHASING_PRODUCT,
  PAYWALL_PURCHASE_SUCCESS,
  PAYWALL_PURCHASE_FAILED,
  PAYWALL_RESTORE_SUCCESS,
  PAYWALL_RESTORE_FAILED,
  PAYWALL_CONSUME_SUCCESS,
  PAYWALL_CONSUME_FAILURE,
  ATT_STATUS_CHANGED
}

extension DeepWallKidsEvent on Event {
  static const values = {
    Event.PAYWALL_REQUESTED: 'deepWallKidsPaywallRequested',
    Event.PAYWALL_RESPONSE_RECEIVED: 'deepWallKidsPaywallResponseReceived',
    Event.PAYWALL_RESPONSE_FAILURE: 'deepWallKidsPaywallResponseFailure',
    Event.PAYWALL_OPENED: 'deepWallKidsPaywallOpened',
    Event.PAYWALL_NOT_OPENED: 'deepWallKidsPaywallNotOpened',
    Event.PAYWALL_ACTION_SHOW_DISABLED: 'deepWallKidsPaywallActionShowDisabled',
    Event.PAYWALL_CLOSED: 'deepWallKidsPaywallClosed',
    Event.PAYWALL_EXTRA_DATA_RECEIVED: 'deepWallKidsPaywallExtraDataReceived',
    Event.PAYWALL_PURCHASING_PRODUCT: 'deepWallKidsPaywallPurchasingProduct',
    Event.PAYWALL_PURCHASE_SUCCESS: 'deepWallKidsPaywallPurchaseSuccess',
    Event.PAYWALL_PURCHASE_FAILED: 'deepWallKidsPaywallPurchaseFailed',
    Event.PAYWALL_RESTORE_SUCCESS: 'deepWallKidsPaywallRestoreSuccess',
    Event.PAYWALL_RESTORE_FAILED: 'deepWallKidsPaywallRestoreFailed',

    // android ONLY
    Event.PAYWALL_CONSUME_SUCCESS: 'deepWallKidsPaywallConsumeSuccess',
    Event.PAYWALL_CONSUME_FAILURE: 'deepWallKidsPaywallConsumeFailure',
  };

  String? get value => values[this];
}
