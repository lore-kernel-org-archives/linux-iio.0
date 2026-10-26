Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793015664;
	b=wqEarbBTJYL+6SdjcoFF55mdSKaxLPLf+D7fKsQSJuI8JX4Lz7FLEnee9M5dhQxdP647
	 yX1f3viZ3qjkPdnxLHtkB5uTRqUHf6KmwGxLkIjC1F4B+M/UimaranKyC0mDZDW74VhdK
	 EvUyYt5wZqj8mvezeWl7xZcX7aKgbQI+kwmT118oZTuPiYAHF3Ez/Tci94ScXYBSEzyDm
	 0W0GGiZvNkwFTbtZWozugFlNQQiDjWt3PSw3uHhBWKgkcp9AIY0on6mfD3gVo0EJPH9zM
	 aNTbedWjyM+izRywcej5w7ICOOd1UPjj9kxtF3uHc+IhZa+BeomEXcQ5bMtpr3sQ2BA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015664;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0jOcNFVVqTnbtE0AuLh8XjAAlZpL9TwlHpubfkYfO0A=;
	b=5AraAXWqG5FPTZjCYc6nQFtzayd7/0NT0nKD47xMYLyEcuESMWi1Kvvi+88RrIGztJDm
	 49531nq1KG1ry1656C9UTYaIA0YQ2gXERdilU9IwKqqeJfvtAUUwxXk63CDOrgjN0nEIz
	 X5NUmgSelupC+onsVeibXK2aUTL46rLHE/nTe7Ibvpqo3KnN5ha5wxvgA9cRDdmM1X8io
	 sSB+2AahAOu9f+Y9AUIwhimNrU02rvE2l4VzlkaQw39yd0ob9AHx+fYt+IYAue6rIgCgb
	 KuJA17Uk3dqQX8QTFUBptDBh/IlAuV2ALfNi7/ocge8B42siEYtlNCDIEtHa+Bd59RA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jo+tU1XN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDAD60A2606;
	Mon, 26 Oct 2026 11:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jo+tU1XN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793015663;
	b=kR8KKoJPnhuZkf+sjeePOu+Fojfkz69pe64z2d8y/sMovd2pgrYD0iuBqw/zRqQMll01
	 03MXrSZNHG93qqH5XWTjZfA59cIH9BL65nf44X6lgStJxDtma9b515VlBInKdO1oHpkdZ
	 Tx0mVuyGd5Nrp0CupV4YPUzGbTemH7l0cW742sGfEohjEcSJ3gNPLaWucF4x8K6eZdebS
	 Cljw42TKKfwjM+lk9xdie04A4m6VnQNdLzXatYN2zOJc86SrHb4qktPXxM8dQ4Cm5tH27
	 5McXrCv1D0lQ557nQeQUuhApKYbbykhQQzw90M5DARu2sRkx5Qq7A966TmVWBTu5NXw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793015663;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0jOcNFVVqTnbtE0AuLh8XjAAlZpL9TwlHpubfkYfO0A=;
	b=iQopkUu6LGVEsqJDa7heQxcnznpAUZMefapaa6M8/9Kf+bHOg5HG1VlK0Isn4PXdm9X/
	 h8Z+K3Wm13g5SKbDF6qDhxL0jPt6dQzN/fSQrdkiPyMCRcDsGUUEFUfrpdDfpvuohlglA
	 VJfjcaTjVGXs68OLOVT48EdqQtePxxgynS7YS4EcKqxrUzNHGgk8lmxMFYm5v2HIleKV6
	 7GSKhO6UCQGHvvCDu1me2yAzY2q0rcB11bc5hM6aBv/BX2LvvfIKUGGhxmjvMek4B3GLg
	 1VPdpPWSDnIXa2PlGT3rhQrB51Gchsl8hOI589p+tPd8gmwF63dt3eQpNx+uyOjQDag==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8BEAD1F01828;
	Mon, 26 Oct 2026 11:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793015663;
	bh=0jOcNFVVqTnbtE0AuLh8XjAAlZpL9TwlHpubfkYfO0A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Jo+tU1XNR7sqSrkcIdIlsQtTbV8cioYwD/7uEt7KKN96V0acy1iF1ZztVb7GDmF4q
	 7lGqn8gFnYx4b4IG2PNf+kfGsRzpFuRy3Wi6rzFXsodKeRXsvqLN5vYek6fXBBRcHM
	 g/4f4Q8BzSsYAxEuklb37IY5F7MNUPvpLQ6B60+E6FRjqxpvjOO8aomBgNH22lYyG7
	 AYPqUVmTsna6D1+jMVyqUmw02ERTTSOi5ci3sYKSNs6/5PCp15AlDGdRgJUn2c/IdH
	 YhGIw7pStcNrdxTCZe59OH5kTqdki1jmdSnJdAYCS4MnvFSV4f0YVXaTmz99wwNeMc
	 UPwmIz6V/QWDA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 118E944CF6;
	Mon, 26 Oct 2026 11:54:21 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 26 Oct 2026 08:54:09 -0300
Subject: [PATCH v4 5/6] iio: core: use kstrtodec64() to parse fixed-point
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
Message-Id: <20261026-e-notation-v4-5-a366a6d14d57@analog.com>
References: <20261026-e-notation-v4-0-a366a6d14d57@analog.com>
In-Reply-To: <20261026-e-notation-v4-0-a366a6d14d57@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793015661; l=6612;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=YUHZ2MysY8e+VgWXsYE4WNrhQ7OIuDMn1878U8UTPqY=;
 b=q7cijAK36IzjNuJJnEpk1Z/6Z7RlXblffkCVj8CEAOgbGDgG1nItNCBTrlaKdY8qIYrshfHuk
 qkUwYeAZHalBlA/7K2b2cQoKn+WkAwlGp0G2pytrz4/i6YYeT+qbOLn
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
__iio_str_to_fixpoint_units() helper. It strips an optional trailing
newline and the "dB" or " dB" suffix before parsing.

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
 drivers/iio/industrialio-core.c | 162 ++++++++++++++++++++++------------------
 1 file changed, 90 insertions(+), 72 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d73f2541375f..3f5190ddddef 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -994,75 +994,21 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
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
-				i = i * 10 + *str - '0';
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
-	if (negative) {
-		if (i)
-			i = -i;
-		else
-			f = -f;
-	}
-
-	*integer = i;
-	*fract = f;
-
-	return 0;
+	int ret;
+
+	/*
+	 * Keep hex/octal support for integers. E notation and decimal values
+	 * result in -EINVAL from kstrtoll, due to unexpected termination on '.'
+	 * or 'e'. It falls back to kstrtodec64 for decimal fixed-point numbers
+	 * with zero scale.
+	 */
+	ret = kstrtoll(str, 0, val);
+	if (ret == -EINVAL)
+		ret = kstrtodec64(str, 0, val);
+
+	return ret;
 }
 
 /**
@@ -1078,10 +1024,78 @@ static int __iio_str_to_fixpoint(const char *str, int fract_mult,
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
+ * @units: The units to expect at the end of the string
+ * @fract_mult: Multiplier for the first decimal place, should be a power of 10
+ * @integer: The integer part of the number
+ * @fract: The fractional part of the number
+ *
+ * Parses a fixed-point/decimal number from a string, optionally with units at
+ * the end. The string should be in the format "<number>[ <units>]". For example,
+ * The input "7.2 dB" would be parsed as the number 7200000 with units = "dB"
+ * and frac_mult = 100000.
+ *
+ * Returns:
+ * 0 on success, or a negative error code if the string could not be parsed.
+ */
+static int iio_str_to_fixpoint_units(const char *str, const char *units,
+				     int fract_mult, int *integer, int *fract)
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
@@ -1146,14 +1160,18 @@ static ssize_t iio_write_channel_info(struct device *dev,
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
+			ret = iio_str_to_fixpoint_units(buf, "dB", fract_mult,
+							&integer, &fract);
+		else
+			ret = iio_str_to_fixpoint(buf, fract_mult, &integer,
+						  &fract);
 		if (ret)
 			return ret;
 	}

-- 
2.43.0


