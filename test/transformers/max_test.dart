import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';
import 'package:matcher/matcher.dart';

/**
 *  Max
 * 
 * 	Stream에서 방출 된 가장 큰 항목으로 완성되는 Future로 Stream을 변환합니다.
 *  이는 목록에서 최대 값을 찾는 것과 유사하지만 값은 비동기 적입니다.
 *  반환값은 Future입니다
 * 
 *  completion
 *  성공적으로 완료된 Future 와 일치하는 값을 찾습니다 matcher.
 *  이것은 비동기 기대를 생성합니다. expect 호출이 즉시 반환되고 실행이 계속됩니다. 
 *  나중에 Future가 완료되면 기대치 matcher가 실행됩니다. 
 *  Future가 완료되고 실행될 것으로 예상 되기를 기다리 려면 expectLater를 사용 하고 반환 된 Future를 기다립니다.
 */

main() {
  Stream<int> _getStream() =>
      Stream<int>.fromIterable(const <int>[2, 3, 3, 5, 2, 9, 1, 2, 0]);

  test('max', () async {
    //given
    var a = _getStream();

    //when
    final result = a.max();

    //then

    await expectLater(result, completion(9));
    expect(
      await Stream.fromIterable(<num>[1, 2, 3, 3.5]).max(),
      3.5,
    );
  }, timeout: Timeout(Duration(seconds: 5)));

  test('max with Comparable', () async {
    //given
    const expected = _Class(3);
    var a = Stream.fromIterable(const [
      _Class(0),
      expected,
      _Class(2),
      _Class(-1),
      _Class(2),
    ]);

    //when
    final result = await a.max();

    //then
    expect(
      result,
      expected,
    );
  }, timeout: Timeout(Duration(seconds: 5)));
}

class _Class implements Comparable<_Class> {
  final int value;

  const _Class(this.value);

  @override
  String toString() => '_Class2{value: $value}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Class &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  int compareTo(_Class other) => value.compareTo(other.value);
}
