extension ListNumExts<T extends num> on List<T> {
  T max() {
    sort();
    return this[length - 1];
  }

  T min() {
    sort();
    return this[0];
  }
}
