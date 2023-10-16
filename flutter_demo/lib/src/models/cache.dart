// lưu trữ các thông tin tạm thời dưới local để tiện sử dụng, 
// thay vì nhiều lần fetch user từ backend về khá tốn thời gian, 
// ta chỉ cần fetch một lần và lưu vào cache và chỉ cần update 
// cache khi cần thiết

class CacheClient {
	// lưu trữ dữ các value
  final Map<String, Object?> _cache;

  CacheClient() : _cache = <String, Object?>{};
	
	// Thêm một value vào cache
  void write(String key, Object? value) {
    _cache[key] = value;
  }
	
	// Đọc một value từ cache
  T? read<T extends Object>(String key) {
    final value = _cache[key];
    if (value is T) {
      return value;
    }
    return null;
  }
}