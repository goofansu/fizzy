require "test_helper"

class BucketTest < ActiveSupport::TestCase
  test "revising access" do
    buckets(:writebook).accesses.revise granted: users(:david, :jz), revoked: users(:kevin)
    assert_equal users(:david, :jz), buckets(:writebook).users

    buckets(:writebook).accesses.grant_to users(:kevin)
    assert_includes buckets(:writebook).users.reload, users(:kevin)

    buckets(:writebook).accesses.revoke_from users(:kevin)
    assert_not_includes buckets(:writebook).users.reload, users(:kevin)
  end
end
