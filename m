Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794902119;
	b=oigHZQXTty97IaO2gsWsUhZseygwh4MQi7wOIDvycnv2cjBhOC7NmPiCB6iP4RSAWr2T
	 c4K2t0n69Pc9oWE3TSfXTfm0PNprXl7eu7U57sf8JBbGD2Wolj+TdOrqFnME80G3VOPuL
	 TzMMdAPiX2D7hdoic1A3lyZ8rObfAALZyPTysjJmWFwDMY84KAIkPNwKGNMjJsOrbckIm
	 qox5N/0m+qCwiZXijvHgNbW6o5zdnapMNqKGWIo37+AVt1Rx6a04gR/3DxjfA3X7dQ4Ix
	 X/D2yKANo9Pxc/KJdtL2oL1seIbVpRgMaI8z0h3YQePJd0uFhbtmn9JqHEYQqKivyAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794902119;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gQ5jNNaD4mkGwzcMPPwN2+p4gr50KSGDaJm/fNLGsrg=;
	b=qAcs1b5k2JoRJDzmyG2lJzw0ZLHReJ28Z3UK2U7h/snIil9f0hMgJe+tuQfTi3zbgW6+
	 qLHqQxfa+9D8vs/oPI/GTQ14OKOPBOw3NzD5RFRTGlY3q5gCgRfgs6EzrGF/DQMvbQv+4
	 yCtHHutBvQwlImUTUdKL74tGEU6H5tvVUcKp8nqWZ/BlWDziNhQi9wLgcC+k9g501+/jE
	 cNsCqIMtSx/ilPBmr3ehGH8yuOewOJ/W+okA4Y+z62S/mlxnJG01IDGQBa+sndlZM4ej+
	 lg3XhzWmYmRCdUz2c7SUUul2bJDwibDH1d8Lelw424iaq8KHvjShX2SGpCEenFEaJMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQoQ2pY2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4144606A31C;
	Tue, 17 Nov 2026 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQoQ2pY2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794902118;
	b=27NwjAcNMzKTE5ZvApF7ATZANpaFQbch29bjI6rwRXxjJbyO+gjyf/bgFMFmSLZ9tCkW
	 V7IPxGfgtI9zqd9rmjGIGFG3ur49Etzt/JQXxlpNJl4/k+Ts4EyqWLQwCkg9ogh2ybpId
	 7rYgVy2aVgwX5AHXIieBD8PAq7fXunU6dyq3yHUq+6DlSTXk8EIOg//zcNpOpJ13ZAlJ7
	 qsqjIM4bYwtrzwsFbNV+udESSsSaG6l9pPtBABlxuZfs0WDhu9pNxsfYbvH7/VyEda+w/
	 IimHzV1EMvTWJD3jm4wFTHON4pz12sqcnso9yojK/p4NpspCtN40kTVTucTgGFjcLzA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794902118;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gQ5jNNaD4mkGwzcMPPwN2+p4gr50KSGDaJm/fNLGsrg=;
	b=de/rVjRKJRl3AfwEDk4l+XOjObA1t3o4wWfSifKC9pr5N6D7/iLEPOrrOE9xhswgwZyz
	 AxL3OEmIrYD5sLiUecQwpgnDieFWS2bTftkvZ6J7+mufxN/yokyui/mNWA31yIOKzNkCL
	 pKZM648rasrEgvjXx3z6ZJz5NVWAIOvkHjisj/Z6NMJKy1TtvTfl/pYZONTZvfBEJbwGc
	 c2baqTLKNhRzxQdHocybLbqDQouM+HFRY1TfMl9E0jTebkly1DCrLByXxim+dJJJ6HXne
	 RqKqf6L++pU7gSGgHXcR84ihd2UKMb1KJkD4brpE/WDV0/D7tYgGMyX6ycnDBawLR+Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DF7411F000C4;
	Tue, 17 Nov 2026 07:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794902118;
	bh=gQ5jNNaD4mkGwzcMPPwN2+p4gr50KSGDaJm/fNLGsrg=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=IQoQ2pY2jZ5bHClm4/P5zec+NiE+klPoklZKAQaAS7x1Q+HTZFarMMqq9b1JlzsVa
	 9BCNXEY5cmEaHGNG5bHBra6ELmZLtU8fl4i7TxwNgpmHK7YrDz2IB+nEVYa7FbFVx6
	 B9yE0gJMyJ0mqKr09u5JjqMjDnmImt+zvAPsIllE5r5wZJmqUgQ43HFrPQJ5SM0kjw
	 C2y2WC91xxVlNIi7MKiA29aId7jkeJsyC42WR2C/j7t3ZPS24F8O1NfOs9ial2m9lP
	 plm3myngDbQ3ilai+NzNWH2DUYHNTto7EmXJi55ajFAnu4OoGYske8e02WOXED+gFH
	 zpcu/833v9H/Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3FCB94A72D;
	Tue, 17 Nov 2026 07:55:17 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Date: Tue, 17 Nov 2026 07:55:14 +0000
Subject: [PATCH RFC] regmap: kunit: add tests for values wider than
 val_bits
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261117-regmap-kunit-val-bits-v1-1-a1cd02063217@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6CMBAAv0L27CYtRTBeTXiAV8OhxQVXpZBuI
 SaEv1vlOJPMrCAUmATO2QqBFhYefQJ9yKB9WN8T8j0x5CovtdYVBuoHO+Fr9hxxsW90HAXLojJ
 GHUmdjIPUToE6/vy/N7jWF2h2KbN7Uht/R9i2L9Ah5bl+AAAA
X-Change-ID: 20261117-regmap-kunit-val-bits-6473305e083b
To: Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Johan Hovold <johan@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794902116; l=5896;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=sa63Aup+aU28axygQ8eJYjxlMYwC6XzaZSpCzUHWHO8=;
 b=K6oYsRALgdvBPyAAmXvIrsv6TEUhkPOLaUS1pYxsmI2JTDFmXQcH+tBpdSPYps4XXFNnwp7zC
 6oyXoSXtRRQBNeVRJR/dVqelTiahE1fkbHr5cNPcAnhkpadJUO3VgV1
X-Developer-Key: i=raffaele.tranfaglia@gmail.com; a=ed25519;
 pk=mweuSGNM6vguCTdqa+aiHwMXdgk70suj2wolzCp6XGM=
X-Endpoint-Received: by B4 Relay for raffaele.tranfaglia@gmail.com/20261011
 with auth_id=1160
X-Original-From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Reply-To: raffaele.tranfaglia@gmail.com
Content-Transfer-Encoding: 7bit

From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>

Add two test cases writing 0xffffff0f with regmap_write() to a regmap
with val_bits = 16:

- write_wider_than_val_bits uses the RAM regmap, a bus that only
  provides reg_write()/reg_read();
- raw_write_wider_than_val_bits uses the raw RAM regmap, which goes
  through the value formatters.

Both expect that only the low 16 bits reach the bus and can be read
back. The raw test passes, since regmap_format_16_*() only store 16
bits. The RAM test currently fails: _regmap_bus_reg_write() hands the
value to bus->reg_write() unmodified, so the bus sees 0xffffff0f. With
the rbtree cache the value is in addition truncated in the cache only,
so the cache and the bus disagree.

Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
---
regmap_write() takes an unsigned int, also for regmaps with
val_bits < 32. What happens to the bits above val_bits currently
depends on the bus and on the cache type:

- buses with raw write() go through the value formatters, which
  silently drop the upper bits;
- buses with only reg_write() get the value unmodified. regmap-i2c's
  SMBus backends and regmap-fsi then return -EINVAL, others (like
  regmap-ram here) take the full value;
- with a reg_write() bus and the rbtree cache, the cache stores the
  truncated value while the bus got the full one.

This was found in the adux1020 IIO driver, which writes ~u16 (promoted
to int) to a 16-bit register. It works on I2C adapters and fails with
-EINVAL on SMBus-only ones [1]. I am raising it here as other drivers
can hit the same thing.

The tests in this patch expect masking to val_bits on both kinds of
buses, so the reg_write one fails today. This is only to show the
difference: should regmap_write() mask the value to val_bits for
reg_write() buses, or should it reject such values consistently for all
buses? I can send a patch for whichever is preferred and adjust the
tests accordingly.

I prepared this patch with the help of an AI coding assistant, and
reviewed and tested it myself.

[1] https://lore.kernel.org/linux-iio/20261109-adux1020-measure-fixes-v1-1-fe1ba63f28bc@gmail.com/
---
 drivers/base/regmap/regmap-kunit.c | 62 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index c78772b660d6..ed51a98efeb0 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -319,6 +319,33 @@ static void basic_read_write(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, config.cache_type == REGCACHE_NONE, data->read[0]);
 }
 
+static void write_wider_than_val_bits(struct kunit *test)
+{
+	const struct regmap_test_param *param = test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int rval;
+
+	config = test_regmap_config;
+	config.val_bits = 16;
+
+	map = gen_regmap(test, &config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	/* Write a value with bits set above val_bits */
+	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, param->from_reg, 0xffffff0f));
+
+	/* The bus should only have seen the low val_bits bits */
+	KUNIT_EXPECT_EQ(test, 0xff0f, data->vals[param->from_reg]);
+
+	/* And that is what we should read back */
+	KUNIT_EXPECT_EQ(test, 0, regmap_read(map, param->from_reg, &rval));
+	KUNIT_EXPECT_EQ(test, 0xff0f, rval);
+}
+
 static void bulk_write(struct kunit *test)
 {
 	struct regmap *map;
@@ -1984,6 +2011,39 @@ static void raw_write_read_single(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, val, rval);
 }
 
+static void raw_write_wider_than_val_bits(struct kunit *test)
+{
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	u16 *hw_buf;
+	unsigned int rval;
+
+	config = raw_regmap_config;
+
+	map = gen_raw_regmap(test, &config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	hw_buf = (u16 *)data->vals;
+
+	/* Write a value with bits set above val_bits */
+	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 0, 0xffffff0f));
+
+	/* The "hardware" should only have seen the low val_bits bits */
+	if (config.val_format_endian == REGMAP_ENDIAN_BIG)
+		KUNIT_EXPECT_EQ(test, 0xff0f,
+				be16_to_cpu((__force __be16)hw_buf[0]));
+	else
+		KUNIT_EXPECT_EQ(test, 0xff0f,
+				le16_to_cpu((__force __le16)hw_buf[0]));
+
+	/* And that is what we should read back */
+	KUNIT_EXPECT_EQ(test, 0, regmap_read(map, 0, &rval));
+	KUNIT_EXPECT_EQ(test, 0xff0f, rval);
+}
+
 static void raw_write(struct kunit *test)
 {
 	struct regmap *map;
@@ -2229,6 +2289,7 @@ static void raw_ranges(struct kunit *test)
 
 static struct kunit_case regmap_test_cases[] = {
 	KUNIT_CASE_PARAM(basic_read_write, regcache_types_gen_params),
+	KUNIT_CASE_PARAM(write_wider_than_val_bits, regcache_types_gen_params),
 	KUNIT_CASE_PARAM(read_bypassed, real_cache_types_gen_params),
 	KUNIT_CASE_PARAM(read_bypassed_volatile, real_cache_types_gen_params),
 	KUNIT_CASE_PARAM(bulk_write, regcache_types_gen_params),
@@ -2265,6 +2326,7 @@ static struct kunit_case regmap_test_cases[] = {
 	KUNIT_CASE_PARAM(raw_read_defaults_single, raw_test_types_gen_params),
 	KUNIT_CASE_PARAM(raw_read_defaults, raw_test_types_gen_params),
 	KUNIT_CASE_PARAM(raw_write_read_single, raw_test_types_gen_params),
+	KUNIT_CASE_PARAM(raw_write_wider_than_val_bits, raw_test_types_gen_params),
 	KUNIT_CASE_PARAM(raw_write, raw_test_types_gen_params),
 	KUNIT_CASE_PARAM(raw_noinc_write, raw_test_types_gen_params),
 	KUNIT_CASE_PARAM(raw_sync, raw_test_cache_types_gen_params),

---
base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
change-id: 20261117-regmap-kunit-val-bits-6473305e083b

Best regards,
--  
Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>


