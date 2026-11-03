Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793740631;
	b=zO036wBG0NzaFsKwsb7WB2Xw1+6hlaKIdt0/Fa+NCwr3ByfDeOOhny2qqARgssgDhm9p
	 bws4fyXFbVSLciNlfhg0fv4W6mtMdExs8tBoZIsUFCqLnWz/n3mu5rCBxeXkfW6TK/LFz
	 lD8epUYWgX/fS3IfR8dDtJOS4bxCHZnY6+X0ui6CXmKFbwnCxVeuwPYlTZjtlEbn8diH7
	 YK2wsyxOqr3c7fPFDB1OdgJ5ytvzBWlCi2SW0S2yKCD1nlaZ5O6vNiB9hYvKaiVib5irO
	 jUu1BbZkQsPaFNOHnacEkh3ZzV+pu1VRe/p6rd0mSyJ9i93ADaihP1zdoEoVRLzji5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740631;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=17Xr34YktVCIPxD8sT9ELbr3cOLrvKfvPe2J49V593I=;
	b=jqYjiYNN4B/y5CS3KudiURJ2KjBO+Yzn6oThNlEdMXT6ZnZ3z6547GE6kfllYG+83h4g
	 L+U6Zp6QfES9VfQlGTwtAmMYkdSxSi6/50gEmS8ByX0Ft73sI87wcsJTkRGr8wYXcGX25
	 +lQpQ4tP72vp+DulZq2oeLaRjO5L2ipPWuv+RDkTb8cjxN7lBOBRITH5TLBi/kXdIFS6u
	 iqGe4ru1RRMEzcRiHjZIHzV5XNJcLkMHRq1FjNi6SM6STmnsvdx5WD36TfuDwsvPc4d2M
	 kjsLh9MIo0AMoG74IWoRvncNxQmA/dp/vP5f14CdaQ7nBxhjDoB+DV51AQNyZuKExiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AAk8HwD2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FC5606A324;
	Tue,  3 Nov 2026 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AAk8HwD2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793740631;
	b=ztXfjyS+535K2Z6Anc6OgwT7zRg4mwZ7up9wEIDN2TrEGxm3KC+b1vUz62D5wKb9iloh
	 afmlhHZTsxbQK8iCZTN2rIfSXbA7vHWU8iM6hFbGL/5vYDl6X7W8fB2za0woWKQgDOA/3
	 UhJtkdsf2igDCVZ4wwTDMFwpJE0hrbrLohrrzr3nkVOH41R+rN4nsGlihcVtR+M4qmZnL
	 jHk+kNkSGbQCy/vJTJqkZnpydxZqwclqB3TAS1L83YCf00hMjiJtSY7vTCjoMeO8EOjEb
	 O1njheMAz+UIlZZqRggvSeG74DKIMCEXuEuuDPRmuVFtDO29EAlQHAgcYZrM+H8fj2g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793740631;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=17Xr34YktVCIPxD8sT9ELbr3cOLrvKfvPe2J49V593I=;
	b=bV3ZwLmijhWjWobh/SUh8/hl6nlI1Fw+iJXT9zDipRjuqnCXoMDLR6AyKlxwb40fTo3v
	 HJN27ilerGByy2Cf5YZC9JOLpfzxwVnCwaiX44hAUz5Zlin1zX+fPRdz4Zj9+seqkEsXV
	 pXbbnNpW+7/ckSb/+0DCyacbKDMr64K0FlGe1uiE6oOCuK0LoktRwVkR4Ny11R/nXTTyZ
	 ggbawIpoEaouLriWOq0bnUcBjeFjK1xNQrtQkvrYOke/yI+DvreSgCGNTsFTEzeNIubbY
	 QtN/Lgp0JorQ1l/d+E3xci/KvR/NJmXFnb9U1ehz/chxtlM70tegvzEIhiuLeUguwLA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 272851F00919;
	Tue,  3 Nov 2026 21:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793740631;
	bh=17Xr34YktVCIPxD8sT9ELbr3cOLrvKfvPe2J49V593I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=AAk8HwD2qGhwXSkVUSdbJymPIDmgBic9VgV88BdH5oCiDQyv5F1QXWie5c5KEytsP
	 ksdD5EHCJSQsbdVbRQCvs7s8jZKtsCMqDD0eXT4MpWJ3rD1Y4EE8ZZJ+TupHEk4Kpa
	 1wSXPBW+rRL7QCNF3u0Yi7jstPG3dj/u4rKX1Jbw2nQMf3aw1dDhjWcarr+jLGPrbR
	 M4DChVxkiyYD2jROiD/WJfAb8jPzRxawHcbrNcGT/SWvrXSdMsSU2K/jn57YSkmOeI
	 iQGQ/NfGp+qIjMDAh6Sko9ZzT4FRQaJR7p484FSWyO6IOSzJIbgPE4L3AcybC1or3+
	 TFgAoboMwTRZQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A08E346B34;
	Tue,  3 Nov 2026 21:17:09 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Date: Tue, 03 Nov 2026 21:17:08 +0000
Subject: [PATCH v3 2/2] iio: test: iio-test-format: add test case for char
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
Message-Id: <20261103-iio-test-format-char-v3-2-d44074ecca70@gmail.com>
References: <20261103-iio-test-format-char-v3-0-d44074ecca70@gmail.com>
In-Reply-To: <20261103-iio-test-format-char-v3-0-d44074ecca70@gmail.com>
To: Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793740628; l=3409;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=j6hp8T4Cjj/hWoDuvMg1i82+SSxt038YUR09cQQDDKc=;
 b=WLm3iidZxvUdA1MiDT4VYRulYg8QP01l9ov1EBzX2cFq5dj2IhiYIGd4eBnAACcf5yyZ75Nqg
 Yw/Y38FIv04CfiZDJqCbXejkm5FWMH4w8TpQK81oAerZw2/rWLHH8OV
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
index 90cd23f25fd9..781ead359bab 100644
--- a/drivers/iio/test/iio-test-format.c
+++ b/drivers/iio/test/iio-test-format.c
@@ -217,6 +217,72 @@ static void iio_test_iio_format_value_multiple(struct kunit *test)
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
@@ -326,6 +392,7 @@ static struct kunit_case iio_format_test_cases[] = {
 		KUNIT_CASE(iio_test_iio_format_value_fractional),
 		KUNIT_CASE(iio_test_iio_format_value_fractional_log2),
 		KUNIT_CASE(iio_test_iio_format_value_multiple),
+		KUNIT_CASE(iio_test_iio_format_value_char),
 		KUNIT_CASE(iio_test_iio_format_value_integer_64),
 		KUNIT_CASE(iio_test_iio_format_value_decimal_64),
 		{ }

-- 
2.56.0


