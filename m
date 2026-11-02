Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793616087;
	b=JBsU0p09mhAix5GMSu8cVvKIWxZbrXiQC//SrupBH3eJHeDGMzpA9lmOsDSz9OVjpdcI
	 mcGliAmizPwXxX3FVEKQDYsu4i7YVOuzFkhOUIYKftdkQsVzDd0YWduMziutCaBYeLFzN
	 YG9CplDiKCBBK0PqSj8QWnZEwju6KRR/tH9rdNfV3jBfiFKh2EF4USWAitf6jeMHnXRhU
	 Bwp0/8T85HxTsjeEP+DNxWpEMjSJ7Fc/gXwM87fjZlWvqqIERZVMln3J3+6WhocwIN1zb
	 LhnONBAPUkFh7xGWlu22XY6pbPwthXTJM+2fbBoyFECRCBePbLA8OWeM0LGEDO494pw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616087;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HuLSnLMm9GYqPqeD3K629Jr9kR+SZjzBYmFvNzWyecE=;
	b=do1yepjt9tnhMA2RgzghhmpQjXU9LjjE2ebqcXoldzP5B/IvVFwcK309HhvUzE1ehfDX
	 0UZxmKsxsIcM5TQIKwz80jR2Htq+0d0NI/eXB7oIn0aySmb5Nme3EyaC1zkgWtYEb702N
	 4AuPO4a5B4GULDatR3zPysm/YEI4tJsohWlCkFe/jZFFDm/KHOa4tvNVL5KOqCeer1/el
	 VHBxbk6X4iMgfJfRKemPgWw3fbBVy+GuGR6OVhUyUrvAOOCCFAAvt/oNNrOJAkxqAUAGm
	 36wCVn9V9VtFJj4DqAyOKzCx/akcyqebS6CjkgWW+eUK5TMy5xKHf+wjlezOuuvzlQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6ES+T20;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B434360A2600;
	Mon,  2 Nov 2026 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6ES+T20
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793616086;
	b=Ejhi4s0ScJ/fEcnqJNfB+ju4bDc1O1c5AnmRyOuVdyceOZqzEMoS973ABal0farIY1yU
	 LCGorECb8e845rRK9kxLLmcL+GQFtE0nQr8rKNGzsjRN60gKGhylhfB87LxdJK+txuoTA
	 NNUoxxmoT+HE6PS6LsLIoV9To31kTM6ZZz2nXfTaygnt3yXYZadWJCOlmqCeShMlpayQU
	 O/Gwj1n7JkkCr9hcsWf8tkHstgyCgGQ8VuCpKFUdNuUocfG92hyea4Gc1URVNf2P5cZqA
	 vzMj4LidqKdmG3KMnLZgxh3PFoTY9bdHVToEHs9H13Ay85AaHD1mbRBWWcf5W4ZFOzQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793616086;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HuLSnLMm9GYqPqeD3K629Jr9kR+SZjzBYmFvNzWyecE=;
	b=ZJqMibeKz+llP3jBOihAdoi9ci6PYjfZWoLlebYfdGkClITSPuDBHWitg00cjEHPJDHp
	 D9ruS5sP1HbtrWAOc0g46iIgPgAWNbIWWQajQKaZs9+UfEdsepdiSed0VscdzXHhr+KqC
	 yzzPYPJmpCAUDsST8t0P4sgT/eWRgod3M28TZZMhTLs4b+MmRIgbu8XG7KBFlZPPsQfjs
	 VAmEi2hANan3+vN4pnAPAxPsz7TuQMPWaiXS93xnWi3BrHBC+nF8xYmVcDqofwtcW2wkZ
	 UsMjFjTAX3oWYb/amd4RjsseWOkm/j51MowQdQzV971Hi5cXhdHXNnSObXc8zl2mT6w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 527F51F00A1A;
	Mon,  2 Nov 2026 10:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793616086;
	bh=HuLSnLMm9GYqPqeD3K629Jr9kR+SZjzBYmFvNzWyecE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=h6ES+T2082LIMrBois3oMw3Q8V2LmyGJ439KyMIrFVtcbcuyj6Wvh4Vh4fs7jRTzg
	 lvpDadpJfspTz0NNtF2Tfb7COqrRo+018aAO4k6e6Ctn6WyqlL1/sdxL5cp7UpOdqg
	 OImuO6ofrwwV6gPOdJn9rm9QVPNT92Z4IBMNvnA9a5eKYFixEEDMaCzp74qkU1QAS3
	 PmB2yH19OW1VKmccuV26IJUpciWY1fuGkwDcvzaFtZBnBOueZvH9vglrIDSS+BAKzZ
	 mwDcibB/72RnroCmfLT9RJWkxbV0+l7QQaba8mZLNy2AlKaugQt0uqcsVpd1BfyxzI
	 TtOQ94PJbUoJg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D3BA346494;
	Mon,  2 Nov 2026 10:41:23 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 02 Nov 2026 07:41:04 -0300
Subject: [PATCH v5 6/7] iio: core: use kstrtodec64() to parse fixed-point
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
Message-Id: <20261102-e-notation-v5-6-d399e544a982@analog.com>
References: <20261102-e-notation-v5-0-d399e544a982@analog.com>
In-Reply-To: <20261102-e-notation-v5-0-d399e544a982@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793616082; l=7784;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=dUhNeZXo5vFzXntF/nMNYwVrkSGbdT2vPYrOiXpyQTQ=;
 b=Mq2OoyL0WKj+I52nUPvdIMaNYqQ8FtHcphsTDxYTZOWtDucvKpH1jXatvIQfqsUS3rUp8G7KA
 Cb/vfITm8vwDqVPlkmA51tD+z4eQa/s8dE/y8XphSgc2BYixsKAf0An
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
index 825cf7f32059..71e9faad4049 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -995,76 +995,21 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
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
@@ -1074,16 +1019,98 @@ static int __iio_str_to_fixpoint(const char *str, int fract_mult,
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
@@ -1148,14 +1175,18 @@ static ssize_t iio_write_channel_info(struct device *dev,
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


