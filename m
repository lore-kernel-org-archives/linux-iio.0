Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795594187;
	b=j1gyqXmg54+OkCGFl38t0zx7Z+SJNQ9C7eoDcithZFhDFXr7SwjlzPWEv58KccFpheLo
	 rfq+MQFUvVo7Op5TIXP+AaYUnsb01qC3Dn7MsajDpFFSIcwq+V+0ly8YXO7FG/EgDNYKg
	 5sEm6KhaCfEi41g0LuRjWQC/iAYfNXxirtbVZtfq4jLd3/OMc40yOdRj6galjYDXThK9d
	 Lbdr2ZcbKjfqN6To1UHq7XqW36g/kL/fC0+HMYy8DuapfN6ODfu9mEi0/s/zAbFuTdjnx
	 1JmLdk9+c/4t02ihWXV67MVgoWvwkh6gsGiNCG5+OIdB4XzRQvYDmSFGkX6u/7sm9Xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795594187;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=bUH7XhYRcN0ZSzmqSkUpoFs7FYnuAGT+laP6+sfdijk=;
	b=ZX1JHqCSrBcq/ImX4XhqfsxNvoxuBZEeoYmIRNeGi02pXQe9rJuW8YULTc9iVf3Bl5s6
	 fDgPmYChFaa+a+v+vwypqBl3iJo7vRXyc3Cxq9WneLzPrOXPynRSKgvt9fOrkzilF6I51
	 6KHROpkCUAUto510bhMhxMHFfNAA98x6Rtk8PSZhcK278qfEgpa5JTnwavtAKrE2qT1Qz
	 6ICB9c++TXw/yyS3bDBGR/RoboWtLPMTmb78Ux5hm3yGhwrph153xqsoG0cDeNGY3KaBb
	 vnlRC0gmysGFhT9FdkqexBwluJ1BvjMwWQoSV4xbMgL1o2YxZih4+ktk/PT9ZDh+JNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVEXjbgG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA27606A323;
	Wed, 25 Nov 2026 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVEXjbgG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795594186;
	b=ju4heASjKSnjyyWQ8dBtfCIX7UxfyqQhxB710JYl9Vzm/RcgDoZld4uEzR/PSLMpuJ0z
	 KrGVMKpYOv3s/JVBipjW96s+2GMuz23bZdL6/EGDdjxBqcmQBAJNcHa/8JovcmASV0LLt
	 srfmJpYqdkRUFz3muAmOr/DZzpZqi92iF+HeYHlDApg8A5vpgqjgcfbtlRz4zBHbfcjq1
	 3KjlclwloUfWZoyRoYwzkh7Ly+TzrjUp6+0nHbPh49yVDHwVe/7I9LNPnry5eZkWea3Qc
	 gsRkblG+1tMBBG3sm/Ex1UBnTRjkVvfk0ffoj/dVfvsmgJ6FoaFxhEfgplyfKe5ZWCw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795594186;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=bUH7XhYRcN0ZSzmqSkUpoFs7FYnuAGT+laP6+sfdijk=;
	b=MCNDgXITY2hdwIq39bMgVr9pId1oUqW+mhPrLQ3Bj0Kzf9grY+3eHX0YwzYVYTkME0do
	 qVkouM4YRsfp6wqTndh9QTRpfP8LKkJvnWdDqMIT3xCmOz846bM9OhS1F2+OyiKNfVUPs
	 H+mZDeZOkrEFAARsh5aPJP1D1yula+NYEdI7floC9Qw47tL+eBKw4HqcgCVfDFA74Ni+O
	 3bqzr9YlhF5iEyxW5oIncQJQyd4xmqP4WvzHnpwjpFp8vNDMWitW14hvtRPT9FdiOxhX/
	 6+goapr6tpMyxlQTLC6c1l0jrj09mTII4yNLxn8zmrCzlG7UXXQYAxVrxV5s8Iq8lrA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EE4751F000D8;
	Wed, 25 Nov 2026 08:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795594186;
	bh=bUH7XhYRcN0ZSzmqSkUpoFs7FYnuAGT+laP6+sfdijk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YVEXjbgGC+5THpx3TPMemxJ87pLCHYE0tjc8zmB89z4JuEJ6TX/L0HKEQgN+e2FLU
	 OlSdnxXgRd8rHiAYKM6e9vshW7ABqKlpZlJQrUetw8Osrut4WO2nu0BxnFkq3nLgcC
	 lPWJS8OAKiTppX/ECQK1uhklcMPX7W7jvI2ksffberWlWexaHaClBteOS7UcNoC+z4
	 1iqDWb+f3IOhwyVZ9Ghpm0iQTmElW9NIhi2Uj0ih9qSxBBWIbgdx676phH+Nl3g1DI
	 2YNKCynVLQGJGz/BRisnmdZjnXtIpzrdK20RQSg71LC4uDOU8INl4gz3k3c8dJ6m+C
	 WnBCSOJ3w2qjA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 778DA4CDAF;
	Wed, 25 Nov 2026 08:09:34 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Date: Wed, 25 Nov 2026 08:09:32 +0000
Subject: [PATCH v2 3/3] regmap: kunit: add tests for values wider than
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
Message-Id: <20261125-regmap-kunit-val-bits-v2-3-81db3b79cd3f@gmail.com>
References: <20261125-regmap-kunit-val-bits-v2-0-81db3b79cd3f@gmail.com>
In-Reply-To: <20261125-regmap-kunit-val-bits-v2-0-81db3b79cd3f@gmail.com>
To: Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-sound@vger.kernel.org, Neo Chang <YLCHANG2@nuvoton.com>, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795594173; l=3961;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=O/bSq8ATRnJpAzSNzffwCRkaLe7Q98YDcHwxyFy4JF4=;
 b=/DGtjIuBeVus/HvctOSVZo7v3yNnwtSu8S2bLD2z51pi9Aq59jfoUKZXMhVKmbx1eJSpVIjji
 /ED7tGdJQv7BFN6cmpr9Y1GEh6acoxal5dRyO9Uff+8/WI+TB0aUPYc
X-Developer-Key: i=raffaele.tranfaglia@gmail.com; a=ed25519;
 pk=mweuSGNM6vguCTdqa+aiHwMXdgk70suj2wolzCp6XGM=
X-Endpoint-Received: by B4 Relay for raffaele.tranfaglia@gmail.com/20261011
 with auth_id=1160
X-Original-From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Reply-To: raffaele.tranfaglia@gmail.com
Content-Transfer-Encoding: 7bit

From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>

Add two test cases writing 0xffffff0f with regmap_write() to a regmap
with val_bits = 16, and check that only the low 16 bits reach the bus
and can be read back:

- write_wider_than_val_bits uses the RAM regmap, a bus that only
  provides reg_write()/reg_read();
- raw_write_wider_than_val_bits uses the raw RAM regmap, which goes
  through the value formatters.

Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
---
 drivers/base/regmap/regmap-kunit.c | 60 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index c948219f46a3..b8b14995a548 100644
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
@@ -2004,6 +2031,37 @@ static void raw_write_read_single(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, val, rval);
 }
 
+static void raw_write_wider_than_val_bits(struct kunit *test)
+{
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	void *hw_val;
+	unsigned int rval;
+
+	config = raw_regmap_config;
+
+	map = gen_raw_regmap(test, &config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	hw_val = data->vals;
+
+	/* Write a value with bits set above val_bits */
+	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 0, 0xffffff0f));
+
+	/* The "hardware" should only have seen the low val_bits bits */
+	if (config.val_format_endian == REGMAP_ENDIAN_BIG)
+		KUNIT_EXPECT_EQ(test, 0xff0f, be16_to_cpup(hw_val));
+	else
+		KUNIT_EXPECT_EQ(test, 0xff0f, le16_to_cpup(hw_val));
+
+	/* And that is what we should read back */
+	KUNIT_EXPECT_EQ(test, 0, regmap_read(map, 0, &rval));
+	KUNIT_EXPECT_EQ(test, 0xff0f, rval);
+}
+
 static void raw_write(struct kunit *test)
 {
 	struct regmap *map;
@@ -2249,6 +2307,7 @@ static void raw_ranges(struct kunit *test)
 
 static struct kunit_case regmap_test_cases[] = {
 	KUNIT_CASE_PARAM(basic_read_write, regcache_types_gen_params),
+	KUNIT_CASE_PARAM(write_wider_than_val_bits, regcache_types_gen_params),
 	KUNIT_CASE_PARAM(read_bypassed, real_cache_types_gen_params),
 	KUNIT_CASE_PARAM(read_bypassed_volatile, real_cache_types_gen_params),
 	KUNIT_CASE_PARAM(bulk_write, regcache_types_gen_params),
@@ -2286,6 +2345,7 @@ static struct kunit_case regmap_test_cases[] = {
 	KUNIT_CASE_PARAM(raw_read_defaults_single, raw_test_types_gen_params),
 	KUNIT_CASE_PARAM(raw_read_defaults, raw_test_types_gen_params),
 	KUNIT_CASE_PARAM(raw_write_read_single, raw_test_types_gen_params),
+	KUNIT_CASE_PARAM(raw_write_wider_than_val_bits, raw_test_types_gen_params),
 	KUNIT_CASE_PARAM(raw_write, raw_test_types_gen_params),
 	KUNIT_CASE_PARAM(raw_noinc_write, raw_test_types_gen_params),
 	KUNIT_CASE_PARAM(raw_sync, raw_test_cache_types_gen_params),

-- 
2.56.0


