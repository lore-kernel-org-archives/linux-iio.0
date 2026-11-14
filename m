Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794665403;
	b=IJ867XjlctI2iD61AQIfPCb3++LKYOKpFcCUbKAsmbYjAgSKRP++B46tw5kMW44cLdDW
	 HNAw41JIrETSCBQPemGuFH5eG2uDf3GvIMiErCR4huWDU7EvDptq2yFg4yRscgm1YDBkP
	 PCRBvo52jYMICLWHy6C3j4xYI6roBzOQjywxpDgvNybFBSgOIjmHwxtat9IpLS0WEfflF
	 WJFlGKbSpr3UQ5FVNH5BGmxV1T/mGR7h8DQEnOF6ZshNmykjeuxAAFRY1McDkaiCQbffy
	 vMsLwjPEWDWJypaem6y3NXhskhVCZbyMb1AcIaxEjqjoAizkl4lzwCajzaORTiBKXdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665403;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vzj+jA01EuEL068uwUK/rwQNRm9/WnhyJYzSFm4zh+Y=;
	b=RSW850i2BFlvgh5OHUUYTl6VLbh/oH9HaIaJAyUNtUcD+jUE9BswpuwyRmvFx3dupRJc
	 3GlYOLCQ6k/H4BLZu01tESSkUmxYb/i1OlfY/4og+QyRQEbsUSe+aw+8zdnEFHxDuGPkj
	 X4TETFVYT0enopYr1mukopyu7OXPlo5gR3psjLCcFzWR0WxUjoqkcDCmR1nAzDy5xg4F0
	 3v8ePqZrO+GQ6IJlqzv2W24DeGHdtnuRIOy6MetEoZoyzqt5fwjyQEMezWeYkjcgl8cGw
	 kMGSKm2MuM0IXe6NLCC+ny/1wHWeHOQ9zskG3EcuUOOlMhWyHgySBuNrTs0CGQI0cgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gkA9MJzz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4401F606A884;
	Sat, 14 Nov 2026 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gkA9MJzz
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794665403;
	b=uADKJV3dgztyyP2/85ZtN5IDSVvGeetQ3vhiP5+Qjp9rBlaJ81iHaWWlPxOidg+tqWNE
	 GBrVBRk6fifQRlhwa81Wd6DvGb3Rni2vRZ+b8QCUDOmxrurXwUqpysp/25r94tIM4vxFk
	 +lgcXaE45fS5HbmI+vTiaHAYxpG4ulNMrz+41keAch5bcDCRU/RRkVl5mt2XVUn9kczNB
	 RH+0nwuBYT/itvQJbmhWiZPhEJYG3pRfSUt4z2Hrvb8B+O2N7OYRtALlzzt1/8i0QvtUT
	 lQL9CNMyOzpeZvOEphQz2LCvgdfDj7ihOkKMk4rHjMC6xFk0HbmFnBgNUTsLBgvIdpQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794665403;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vzj+jA01EuEL068uwUK/rwQNRm9/WnhyJYzSFm4zh+Y=;
	b=fHjPqX95u0KPxBRXlFlqtpyiq8zMvPWBr3JJ1k0hzux/RFJB29WWyfpOYfsTWte+e2+l
	 VqwR7qy3GirunOtACl9DSNJfGtZyr1TQoX/ncPHZH81ZoAPJc9zWFOsLl05jKdhd0cfxq
	 Z4NxAgkYnD+rj+EoDMPHbJPKe0yh8GFZpWEK7fKB+Wkk8X22heKxE+uUAORUhkHI09KSH
	 ETKnfqzx7nssyX4N3xK9xXkK4caZETkntFC4F/ojddIhna/aWWE9Pz60UancIi5lu4ga1
	 132ESMoWK/xdw8c5+DxjJY3OC11dZ66pmo4aj5nEV3GCTpNxiYjF1fLL1W4yDSsKb5g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 683421F000C5;
	Sat, 14 Nov 2026 14:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794665402;
	bh=vzj+jA01EuEL068uwUK/rwQNRm9/WnhyJYzSFm4zh+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=gkA9MJzzspgB9vk5GaX6srCUOhO2EwguLkk44ALZfnIt9OQm2NiFTq6ujrfMcWwOf
	 4w8cWHwUv/SJE10+x5kzNPc8qbo9CoXuwIxoqs5LqTVXjetOegWRgN6axCmrQJtQpw
	 AgenQI6NwOOCTC4ZuIdKVkoGd/KKg/sG6BUGiCsNTugCbfs4iTdjwe4A7fnywj3sJb
	 MzRqrcGNUEwXkzowzludeGyCMrYufiZuSw8Clg6UQ/6QRz1w1kk4aQGofTqxccThTt
	 7D8Y3UjkufYpnAK8/Lgo73U0w8QGGo4Y7zPPh/mLQX8ZkOAY9VsR2vimwymBOrl3iN
	 wjPLzZdUS+G3Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EEFF249DFC;
	Sat, 14 Nov 2026 14:09:59 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sat, 14 Nov 2026 14:09:58 +0000
Subject: [PATCH v6 6/7] iio: core: use kstrtodec64() to parse fixed-point
 values
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
Message-Id: <20261114-e-notation-v6-6-205ca9a1438a@analog.com>
References: <20261114-e-notation-v6-0-205ca9a1438a@analog.com>
In-Reply-To: <20261114-e-notation-v6-0-205ca9a1438a@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794665398; l=7786;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=DewUrKfXOkpid75Tpnx0McgzCCdHJCPPflM0/bgRSWA=;
 b=rZZIst12+Yb175Cxf9JWVVVtFySUrHsWVP/p0KW8a5LU6aDbF57g9g74VM2Gpum/vaQyak+xb
 JWWs8c1/Dl5BQqMvF3zgSjev417rKfKPxcbi1YFgsT9OZqbNl9zbKFU
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 7bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Replace the open-coded __iio_str_to_fixpoint() parser with kstrtodec64(),
so sysfs writes of fixed-point values also accept E notation.

The fractional part only keeps the sign when the integer part is zero,
as before. The dB suffix for scale attributes is now handled by a separate
iio_str_to_fixpoint_units() helper. It strips an optional trailing newline
and the "dB" or " dB" suffix before parsing.

When there is no fractional part (fract_mult == 0, or dec_scale == 0 for
64-bit values), try base-autodetecting kstrtoll() first so hexadecimal
and octal input keeps its meaning ("010" is still 8). Fall back to
kstrtodec64() on -EINVAL to accept E notation.

As a side effect, inputs that used to be rejected for integer-only
attributes are now accepted. An invalid octal number such as "08" is
parsed as decimal 8, and a fractional value such as "1.5" is rounded
to 2.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/industrialio-core.c | 177 +++++++++++++++++++++++-----------------
 1 file changed, 104 insertions(+), 73 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index ed7aa7fd9391..4214eb77f312 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1014,76 +1014,21 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
 	}
 }
 
-/**
- * __iio_str_to_fixpoint() - Parse a fixed-point number from a string
- * @str: The string to parse
- * @fract_mult: Multiplier for the first decimal place, should be a power of 10
- * @integer: The integer part of the number
- * @fract: The fractional part of the number
- * @scale_db: True if this should parse as dB
- *
- * Returns:
- * 0 on success, or a negative error code if the string could not be parsed.
- */
-static int __iio_str_to_fixpoint(const char *str, int fract_mult,
-				 int *integer, int *fract, bool scale_db)
+static int iio_str_to_s64(const char *str, s64 *val)
 {
-	int i = 0, f = 0;
-	bool integer_part = true, negative = false;
-
-	if (fract_mult == 0) {
-		*fract = 0;
-
-		return kstrtoint(str, 0, integer);
-	}
-
-	if (str[0] == '-') {
-		negative = true;
-		str++;
-	} else if (str[0] == '+') {
-		str++;
-	}
-
-	while (*str) {
-		if ('0' <= *str && *str <= '9') {
-			if (integer_part) {
-				int digit = *str - '0';
-
-				/* Accumulate with the sign applied so INT_MIN fits */
-				if (check_mul_overflow(i, 10, &i) ||
-				    check_add_overflow(i, negative ? -digit : digit, &i))
-					return -ERANGE;
-			} else {
-				f += fract_mult * (*str - '0');
-				fract_mult /= 10;
-			}
-		} else if (*str == '\n') {
-			if (*(str + 1) == '\0')
-				break;
-			return -EINVAL;
-		} else if (!strncmp(str, " dB", sizeof(" dB") - 1) && scale_db) {
-			/* Ignore the dB suffix */
-			str += sizeof(" dB") - 1;
-			continue;
-		} else if (!strncmp(str, "dB", sizeof("dB") - 1) && scale_db) {
-			/* Ignore the dB suffix */
-			str += sizeof("dB") - 1;
-			continue;
-		} else if (*str == '.' && integer_part) {
-			integer_part = false;
-		} else {
-			return -EINVAL;
-		}
-		str++;
-	}
-
-	if (negative && !i)
-		f = -f;
-
-	*integer = i;
-	*fract = f;
-
-	return 0;
+	int ret;
+
+	/*
+	 * Keep hex/octal support for integers. E notation and decimal values
+	 * result in -EINVAL from kstrtoll(), due to unexpected termination on
+	 * '.' or 'e'. It falls back to kstrtodec64() for decimal fixed-point
+	 * numbers with zero scale.
+	 */
+	ret = kstrtoll(str, 0, val);
+	if (ret == -EINVAL)
+		return kstrtodec64(str, 0, val);
+
+	return ret;
 }
 
 /**
@@ -1093,16 +1038,98 @@ static int __iio_str_to_fixpoint(const char *str, int fract_mult,
  * @integer: The integer part of the number
  * @fract: The fractional part of the number
  *
+ * Parses a decimal number with an optional sign and an optional E notation
+ * exponent. The string may end with a single newline. Digits beyond the
+ * precision set by @fract_mult are rounded to nearest, ties to even, so with
+ * @fract_mult = 100000 the input "0.0000025" results in 2 micro. The sign is
+ * carried by @integer, or by @fract when @integer is zero.
+ *
+ * When @fract_mult is 0, the number is an integer and @fract is set to 0.
+ * Hexadecimal ("0x10") and octal ("010") inputs are accepted with their usual
+ * meaning. Any other input is parsed as a decimal number and rounded to
+ * nearest. For example, "1e3" results in 1000 and "1.5" in 2. Leading zeros
+ * that do not form a valid octal number fall back to decimal, so "08" results
+ * in 8.
+ *
  * Returns:
  * 0 on success, or a negative error code if the string could not be parsed.
  */
 int iio_str_to_fixpoint(const char *str, int fract_mult,
 			int *integer, int *fract)
 {
-	return __iio_str_to_fixpoint(str, fract_mult, integer, fract, false);
+	s64 dec64;
+	int ret;
+
+	if (fract_mult) {
+		/* scale = ffs(fract_mult) = ffs(10^n) = ffs(2^n * 5^n) = n + 1 */
+		ret = kstrtodec64(str, ffs(fract_mult), &dec64);
+		if (ret)
+			return ret;
+
+		dec64 = div_s64_rem(dec64, fract_mult * 10, fract);
+		/* only carry the sign in fract if the integer is zero */
+		if (dec64)
+			*fract = abs(*fract);
+	} else {
+		ret = iio_str_to_s64(str, &dec64);
+		if (ret)
+			return ret;
+
+		*fract = 0;
+	}
+
+	if (dec64 > INT_MAX || dec64 < INT_MIN)
+		return -ERANGE;
+
+	*integer = dec64;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(iio_str_to_fixpoint);
 
+/**
+ * iio_str_to_fixpoint_units() - Parse a fixed-point number with units from a string
+ * @str: The string to parse
+ * @fract_mult: Multiplier for the first decimal place, should be a power of 10
+ * @integer: The integer part of the number
+ * @fract: The fractional part of the number
+ * @units: The units to expect at the end of the string
+ *
+ * Parses a fixed-point/decimal number from a string, optionally with units at
+ * the end. The string should be in the format "<number>[ <units>]". For example,
+ * the input "7.2 dB" would be parsed as integer = 7 and fract = 200000 with
+ * units = "dB" and fract_mult = 100000.
+ *
+ * Returns:
+ * 0 on success, or a negative error code if the string could not be parsed.
+ */
+static int iio_str_to_fixpoint_units(const char *str, int fract_mult,
+				     int *integer, int *fract,
+				     const char *units)
+{
+	size_t units_len = strlen(units);
+	size_t s_len = strlen(str);
+	const char *dec_str = str;
+	char buf[64];
+
+	if (s_len && str[s_len - 1] == '\n')
+		s_len--;
+
+	if (s_len > units_len &&
+	    !strncmp(str + s_len - units_len, units, units_len)) {
+		s_len -= units_len;
+		if (str[s_len - 1] == ' ')
+			s_len--;
+		if (s_len >= sizeof(buf))
+			return -EINVAL;
+		memcpy(buf, str, s_len);
+		buf[s_len] = '\0';
+		dec_str = buf;
+	}
+
+	return iio_str_to_fixpoint(dec_str, fract_mult, integer, fract);
+}
+
 static ssize_t iio_write_channel_info(struct device *dev,
 				      struct device_attribute *attr,
 				      const char *buf,
@@ -1170,14 +1197,18 @@ static ssize_t iio_write_channel_info(struct device *dev,
 		if (dec_scale)
 			ret = kstrtodec64(buf, dec_scale, &integer64);
 		else
-			ret = kstrtoll(buf, 0, &integer64);
+			ret = iio_str_to_s64(buf, &integer64);
 		if (ret)
 			return ret;
 
 		iio_val_s64_decompose(integer64, &integer, &fract);
 	} else {
-		ret = __iio_str_to_fixpoint(buf, fract_mult, &integer, &fract,
-					    scale_db);
+		if (scale_db)
+			ret = iio_str_to_fixpoint_units(buf, fract_mult,
+							&integer, &fract, "dB");
+		else
+			ret = iio_str_to_fixpoint(buf, fract_mult, &integer,
+						  &fract);
 		if (ret)
 			return ret;
 	}

-- 
2.43.0


