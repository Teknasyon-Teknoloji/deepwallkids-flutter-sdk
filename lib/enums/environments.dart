enum Environment { SANDBOX, PRODUCTION }

extension DeepWallKidsEnvironment on Environment {
  static const values = {
    Environment.SANDBOX: 1,
    Environment.PRODUCTION: 2,
  };

  int? get value => values[this];
}
