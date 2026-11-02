Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793608469;
	b=d3t1K/10JrRa4fcG4vtwTH8/QN93n1ZM21dUtEc4ZDF2VUbpyokJg18urXbZFeHl+2lY
	 1gWiKRea1OjwHsN8y01JGqTyxn4Mmg9N0RVn9RMnrvKAwniSrkNKIkOM306w+tvfap4UZ
	 ELSA5n2M/q78Ivc8dscax9hgpsft+I0OcG4b4+5Nz8/2sIR/jI4rDelNhYpja781M77Ca
	 SaEwo10RgfN/FBxZuUe14dbfzxWc7oc+N7YYyMcI9yPiwkupuEQkRfk1YE03DxmEcBUiJ
	 mv5N1GIRhrhHUPXjBVBStXI3JrTRDWFmZYKMcjGbXPzRYz980fSLFicHLVfaSOMeEXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608469;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yPialvn8pP9y7gaBrhECNrk+0Ew0QfzfkxE9sq21voo=;
	b=p9ZPF0CNMNcYK8I1ixW4WKnOCBUGTOJFECnCOcnzizRDuD6d7uK40i79nHo4taKjNI7E
	 PARu9LxY/RhXVwdPBuPt3LuYpDjRlg5E2cQ8fGw0pVl9HwB9CYWYTXmVwUmNIfeKxCufY
	 ZGVcVhVnpmeAIFVDl1dxPg6gmjfNK8M85JYVoz7x3I437NGFquh3e+FfxHwEux9xMckeT
	 Yw0ot3/aXD4LlIG4nrgu68r30mkusunOBwEVYFOv8NE5nfU8nBpG//e9GKi8f5f3ktgfy
	 fPQFEs89FIRCDjAviGsVJKkReqPDzYp8VQqryiK/PaARe+a9wIcNSQ/9+i2g8x+VYJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bS7LIzuN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39027606A32D;
	Mon,  2 Nov 2026 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bS7LIzuN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793608468;
	b=xGEjGPXA/Qfg4G3MxiFhPGSVW3wscfDWVBA9f2drHRn7N9Xh9sWBDGf0pFbe7BZ0gCJz
	 FBVziNjdwyhyIxG7Mvg/y5eS1/fsgfXf40VLIRynvGC+rtF6yt7kYhpfeO/xRHc5fWWN9
	 WNhymfSM8ZfDLgHnf+ce1wBRNfS5tzfpHe9BOZSMnycOMIOG2hgnL1amnFtNHvtMmEREw
	 kKFnhoegjaV0r+DCFqDXm7yzwNT1IDb7ydFT+JrmpRpjWeFYKxxjaMOBGtClOt3Uu0j4Z
	 KbuLPML+DbPrjxJtLKnLSozbyaUBofEdpgkNUia5lkiR9Au+KkSwpdl9U09uzanze/g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793608468;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yPialvn8pP9y7gaBrhECNrk+0Ew0QfzfkxE9sq21voo=;
	b=tcjdbGoZmHsTRpDOkC3dRX/SQkf4TRMR4BlEWXI4mM6/Em0SRRBqeAeyQNZngNKXGeMF
	 wQsDbGIPNsXMSpOGJg2+gIYKDVmANNrb46640sspyFXfPyJeSqZl8unsEw3RCNQRgSqVZ
	 jqNWNF11YcsXUJsXzIB+/JBkazI2myc96lXhLkTZLzz4fuPkK8IGWngZ7oK4RKgBWddD2
	 d0f3pqopmR2H+I9atkt3M/eQvk3xKBDyYjO/+uVkfWXCUPV3s6GPsWrs69bdNsuX+R9Fw
	 J+DBcNqoTcXiNCHIBTW8Ad1OOpZwgkjhIW0rhaGwk0AZ54YBc3Jjh+81fJWI7jA5JDA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0F1391F000C1;
	Mon,  2 Nov 2026 08:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793608468;
	bh=yPialvn8pP9y7gaBrhECNrk+0Ew0QfzfkxE9sq21voo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bS7LIzuNlSQKQkLeWsHeIw8+4BK1K/1E5ZFvHO7nb74J1KHGtn3FlMEwLHgPA7HRA
	 6qBOD/30Qs3cf468CHOGC/V4JzLxqokhZxPfuB9BM3XuTPy6+r9H3rnbBABebbk61Q
	 suS+X91X5XAPRx/TeXeRN2zzPH2sGGwE5hOZVbeqSIo+qjtRl6ISe2rXJa68Td2fwC
	 UfGx4Yhfqb40F6KQxq01f4FGvAto3cGNN6Lg+lQOJPWcvQA9z1sGNGFRKeMwY9gIVu
	 CdKoqEtB/rzV/TRCG08DINt41KqxyBhnQ3m9B3U7QnvE0wwF/VTG2Do7gE4kT1Evt/
	 x73plcJ8T7mGQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8735646424;
	Mon,  2 Nov 2026 08:34:27 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Date: Mon, 02 Nov 2026 08:33:56 +0000
Subject: [PATCH v2 2/2] iio: test: iio-test-format: add test case for char
 format
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
Message-Id: <20261102-iio-test-format-char-v2-2-926100689e62@gmail.com>
References: <20261102-iio-test-format-char-v2-0-926100689e62@gmail.com>
In-Reply-To: <20261102-iio-test-format-char-v2-0-926100689e62@gmail.com>
To: Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793608466; l=3409;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=D/m37rYBfLiANR6mS/4JjUHXvyxkW1PG39W3icdF7Pc=;
 b=dZVAXhJqHx5q0y/yQWkuOQWgx4uGS3NUob5Y/5n04QK6bdzxvBcGhk4S2bHiA5t3st2YVEMbe
 l/V1zm/JtOTBcbRQiuPLibiQGYIIkzITsaInitkMRrjCVVcyN/u67uR
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

Add a test case covering printable, special and non-printable
characters, a NUL character, and values that do not fit in a char.

Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
---
 drivers/iio/test/iio-test-format.c | 67 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/iio/test/iio-test-format.c b/drivers/iio/test/iio-test-format.c
index 35b30420d995..0faafa09f32b 100644
--- a/drivers/iio/test/iio-test-format.c
+++ b/drivers/iio/test/iio-test-format.c
@@ -215,6 +215,72 @@ static void iio_test_iio_format_value_multiple(struct kunit *test)
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1 -2 3 -4 5 \n");
 }
 
+static void iio_test_iio_format_value_char(struct kunit *test)
+{
+	char *buf;
+	int val;
+	int ret;
+
+	buf = iio_test_format_alloc_buf(test);
+
+	/* Printable characters, e.g. a thermocouple type */
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
+
+	/* Special characters are printed as is */
+	val = ' ';
+	ret = iio_format_value(buf, IIO_VAL_CHAR, 1, &val);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "\x20\n");
+
+	val = '%';
+	ret = iio_format_value(buf, IIO_VAL_CHAR, 1, &val);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "%\n");
+
+	val = '\\';
+	ret = iio_format_value(buf, IIO_VAL_CHAR, 1, &val);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "\\\n");
+
+	/* Non-printable characters are printed as is */
+	val = '\n';
+	ret = iio_format_value(buf, IIO_VAL_CHAR, 1, &val);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "\n\n");
+
+	val = '\t';
+	ret = iio_format_value(buf, IIO_VAL_CHAR, 1, &val);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "\t\n");
+
+	val = 0x7f;
+	ret = iio_format_value(buf, IIO_VAL_CHAR, 1, &val);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "\x7f\n");
+
+	val = 0xff;
+	ret = iio_format_value(buf, IIO_VAL_CHAR, 1, &val);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "\xff\n");
+
+	/* A NUL character is emitted and counted like any other */
+	val = '\0';
+	ret = iio_format_value(buf, IIO_VAL_CHAR, 1, &val);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "\0\n");
+
+	/* Only the low byte of the value is used */
+	val = 0x100 + 'K';
+	ret = iio_format_value(buf, IIO_VAL_CHAR, 1, &val);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "K\n");
+
+	val = -1;
+	ret = iio_format_value(buf, IIO_VAL_CHAR, 1, &val);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "\xff\n");
+}
+
 static void iio_test_iio_format_value_integer_64(struct kunit *test)
 {
 	int values[2];
@@ -324,6 +390,7 @@ static struct kunit_case iio_format_test_cases[] = {
 		KUNIT_CASE(iio_test_iio_format_value_fractional),
 		KUNIT_CASE(iio_test_iio_format_value_fractional_log2),
 		KUNIT_CASE(iio_test_iio_format_value_multiple),
+		KUNIT_CASE(iio_test_iio_format_value_char),
 		KUNIT_CASE(iio_test_iio_format_value_integer_64),
 		KUNIT_CASE(iio_test_iio_format_value_decimal_64),
 		{ }

-- 
2.56.0


