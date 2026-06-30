// Shared data structures for the sync protocol between hub and clients.

class SyncChange {
  final String table;
  final Map<String, dynamic> payload;

  const SyncChange({required this.table, required this.payload});

  factory SyncChange.fromJson(Map<String, dynamic> json) => SyncChange(
        table: json['table'] as String,
        payload: json['payload'] as Map<String, dynamic>,
      );

  Map<String, dynamic> toJson() => {'table': table, 'payload': payload};
}

class SyncRequest {
  final String deviceId;
  final int sinceTimestamp;
  final List<SyncChange> changes;

  const SyncRequest({
    required this.deviceId,
    required this.sinceTimestamp,
    required this.changes,
  });

  factory SyncRequest.fromJson(Map<String, dynamic> json) => SyncRequest(
        deviceId: json['device_id'] as String,
        sinceTimestamp: json['since_timestamp'] as int,
        changes: (json['changes'] as List)
            .map((e) => SyncChange.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'device_id': deviceId,
        'since_timestamp': sinceTimestamp,
        'changes': changes.map((c) => c.toJson()).toList(),
      };
}

class SyncResponse {
  final int serverTimestamp;
  final List<SyncChange> changes;

  const SyncResponse({required this.serverTimestamp, required this.changes});

  factory SyncResponse.fromJson(Map<String, dynamic> json) => SyncResponse(
        serverTimestamp: json['server_timestamp'] as int,
        changes: (json['changes'] as List)
            .map((e) => SyncChange.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'server_timestamp': serverTimestamp,
        'changes': changes.map((c) => c.toJson()).toList(),
      };
}
