Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792947626;
	b=gvn+k9QrSqC9ynUOr8sj1PYPKLtAGKU7bsReuklKVvumoF5r77I97AqDXPXRr+9rO+io
	 vcCIjyYEo3EdxCQxtPNbMyJ/PhjJqPlyVvnUOfSaCMusTZkZSGl8V+oqS+qyyW10Kamjx
	 6XjxE2ouNBzV4cN28QIuUEtnQspItBOqHJM5uDXzb+xSlJMfH3EZY0+WJlMTxctoeU6oK
	 U8W7UEGI1NYamblpqPQ25SoUC4nbxLjC37lVed4so/7OPwk4UOOFZcuAz+GhqWAxXubwS
	 5M1SnmsQfeiZn0s+pBKmD70riWztQdGzLEDP7bSrv53aSsm5aY3DIZlDP2ZTbdZLOVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792947626;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2kaGId0jyBB2Z9Zn37kzMz1TDKdpgYpw9Y9lXWn779U=;
	b=osxm7lXDIKC99qmW0fzXml2EUkYEDn0bcsQphqYRE1BPIIZk23nNS/Os9pTA4yjxOFYf
	 PITA8P5M9CNPUXvbHsF4dis+0LC7U5jm3Ki0wV81Cz3sZCmkcC/LmERPvkl8L6e/kNDf4
	 YhJxICNOsTKNvMwF3sapfTsTK0HuxpqCcWo/7aVXIXB+lLG3m6SHXvTksgl9HIKBhZOwO
	 JwzWY5KLQnNVOeADIt1UxGVCTF1v4KXe6L20F/HM2WRwELJ3cbcV9gk1IRkb/mjC8/+uo
	 byxrWgUigVpdmmtjqaLXMlPkLJ/bjgxi5hgx6u2h6Oxg+mWxs6CRwm3gCT2g9KyOK7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IfUVcSv2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9A6606A31F;
	Sun, 25 Oct 2026 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IfUVcSv2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792947625;
	b=RIBYkbyKxxoxK7upH5Dyn+qqQwTxzG1lfAtam9lKz2eIfvtr8vx877XNmNiyxuxe6pyx
	 FbAKcb8oQiUiWAZGi9xFpW3JiGmsA03ZaKRydOCTb446rmQDG/iltcZ2Bz9UFXQ1P61mu
	 bEFuZYd/VZ2HK9FvMf9dT5ed+R8OD7OHSdl0RXksg/s+ptCEQjZfBXhUeNV8X+jz+9B7i
	 MmFR24ouDYxta7iirPNMa2X5jSelgBBjSPx4i3iYyZt0wWJI4Apm1xHSNGkDKW3Ukncs3
	 8q/qMO4tL3uOUjegMiA8wBYEz+s7IIOzAQbbqnXJ6wjz4Yma/bu+XI3Jfcw4aisgxPA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792947625;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2kaGId0jyBB2Z9Zn37kzMz1TDKdpgYpw9Y9lXWn779U=;
	b=VXFqLDswjaNvUZ1TS7TfcrjSMA1PK+qMzil7eo5/5J8EV8Z4jlRziawfup9G371i+GYP
	 hLSdcFwiipU8paY+XDXcucF5GB6XGUFQ589gTMe4vZEnduyvphk53E9FWko4Vhu1o77JJ
	 qNVE8PSSWav5Zn7wRisiVkkNXvC1JyUraOLO+gQw4h9yuKE/ejdqhCB+AWPwPvT6NJFzq
	 Yl9+feDkMOQzwMrpNq5tPex4S51qvZHpWsAw8MafWnxOm8avVUvbniED1aAeo1zYvhq6U
	 Q9jesyj9rUUUiZqtKv9eAiF70oBtCd7afgtloPDNqgDRsROE2yPwIre6bNCNGDwAcMg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 58D0A1F01825;
	Sun, 25 Oct 2026 17:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792947625;
	bh=2kaGId0jyBB2Z9Zn37kzMz1TDKdpgYpw9Y9lXWn779U=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=IfUVcSv2jVTNBkiLx4m7R7ScfN00N88OPau14IUmapjq/3wuFWKbOTcMNgC19xigM
	 ksCxcxVXJkxWkNgqKG/m/UUz8wCkYe05uBnC/2PGUvd3a1A9zbCBNsuf+ZeTST0XVP
	 ivjjA/YBqUtJZkf15FjtqDZwewc6VFqQBDkHBFZHq1QYbHTw4vQDuYt4dLaypPonUx
	 XX7vJVPcbtEQjWC89y8J9ve7+97YRKFs4pSrfGNKc7Ch625MuimofaT2t7FmCsiwhN
	 g1GjxgaxcN/sbDNiyfGQh7eKA27Z853BcGpmZBlQexps7rt7MTIXq2oKDUeBRv5+YR
	 iFepICpwN3yFw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CB96D44A74;
	Sun, 25 Oct 2026 17:00:24 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Date: Sun, 25 Oct 2026 16:59:41 +0000
Subject: [PATCH] iio: test: iio-test-format: add test case for char format
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
Message-Id: <20261025-iio-test-format-char-v1-1-e2c208f90e87@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrB1IAq3aq4iLqBMdQSMzaSmId
 zetyw/e+w9QEiaFV3GA0IeV45ZhywKG2W8TIY/Z4Ix7WuMeyBwxkSYMUVafMK8Ea2+r0IfGO2M
 hX3ehwN9/tu1u67tfaEi/FpznBdGu6/R4AAAA
X-Change-ID: 20261025-iio-test-format-char-8a17fbf9a201
To: Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947624; l=2121;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=uYIGztgLiYRny/7kylD4MRCRKqn6ok2BmKnYkqfKVcI=;
 b=xBDuRUL+yDkde1Lwh9CMrp33F0cJH9ggpOK2GKUdDyWWatBvnmFIWACQ3CzvcSdm/a8Rao18T
 DiA2jJLpvZ0ByTE3W8YmcmNq4CskLZRb6u7LVZ3J6OlAbTJ0qu0kVwm
X-Developer-Key: i=raffaele.tranfaglia@gmail.com; a=ed25519;
 pk=mweuSGNM6vguCTdqa+aiHwMXdgk70suj2wolzCp6XGM=
X-Endpoint-Received: by B4 Relay for raffaele.tranfaglia@gmail.com/20261011
 with auth_id=1160
X-Original-From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Reply-To: raffaele.tranfaglia@gmail.com
Content-Transfer-Encoding: 7bit

From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>

IIO_VAL_CHAR is used by thermocouple drivers to report the
thermocouple type, but iio_format_value() has no test for it.

Add a test case that checks a single character is printed followed
by a newline.

Assisted-by: LLM
Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
---
Tested with KUnit on arm64 QEMU: all 8 iio-format cases pass.
---
 drivers/iio/test/iio-test-format.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iio/test/iio-test-format.c b/drivers/iio/test/iio-test-format.c
index e5d0a2ac4670..701c362695f3 100644
--- a/drivers/iio/test/iio-test-format.c
+++ b/drivers/iio/test/iio-test-format.c
@@ -197,6 +197,28 @@ static void iio_test_iio_format_value_multiple(struct kunit *test)
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1 -2 3 -4 5 \n");
 }
 
+static void iio_test_iio_format_value_char(struct kunit *test)
+{
+	char *buf;
+	int val;
+	int ret;
+
+	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
+	val = 'K';
+	ret = iio_format_value(buf, IIO_VAL_CHAR, 1, &val);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "K\n");
+
+	val = 'j';
+	ret = iio_format_value(buf, IIO_VAL_CHAR, 1, &val);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "j\n");
+
+	val = '0';
+	ret = iio_format_value(buf, IIO_VAL_CHAR, 1, &val);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0\n");
+}
+
 static void iio_test_iio_format_value_integer_64(struct kunit *test)
 {
 	int values[2];
@@ -308,6 +330,7 @@ static struct kunit_case iio_format_test_cases[] = {
 		KUNIT_CASE(iio_test_iio_format_value_fractional),
 		KUNIT_CASE(iio_test_iio_format_value_fractional_log2),
 		KUNIT_CASE(iio_test_iio_format_value_multiple),
+		KUNIT_CASE(iio_test_iio_format_value_char),
 		KUNIT_CASE(iio_test_iio_format_value_integer_64),
 		KUNIT_CASE(iio_test_iio_format_value_decimal_64),
 		{ }

---
base-commit: c9dbe2a47f635465c9985b7af74d2ae310e98125
change-id: 20261025-iio-test-format-char-8a17fbf9a201

Best regards,
--  
Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>


