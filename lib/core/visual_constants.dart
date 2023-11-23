String formatSize(double sizeInBytes) {
  const oneMB = 1024 * 1024;
  const oneGB = 1024 * oneMB;

  if (sizeInBytes >= oneGB) {
    return '${(sizeInBytes / oneGB).toStringAsFixed(2)} GB';
  } else {
    return '${(sizeInBytes / oneMB).toStringAsFixed(2)} MB';
  }
}
