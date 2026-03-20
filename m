Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1B03D090D;
	Fri, 20 Mar 2026 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774024052; cv=none; b=XoYJScC30qrj2knF9BxHUf3B53gVpN7RJF4AuuLRkW14Z64/52a25Emrfg8/6zorfiOiM4x50G4lZAh/iSN7hqEbTix2M+kRYO4E9S7JXzpSFKEz82a7zmpS8rUnEJOypxFIQ6p1ZXpwql6WVJPOqsA+S1aUbfRA4M9LODbTKqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774024052; c=relaxed/simple;
	bh=tcxW2KGMQxeN7j/80ixGlmuXDonndQIJFDc8FtxgG0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EIdoXB5GAaw0yVVbxjrIg99NQCMgRutKSKUDGnFQfLNQtdUtpic84/E87UHsg8T6mPkqQIF2kii/kOG8sQGxCV++sn+VYlpOZOOcwyL90/FpQzwY8Rqn2YhF+VUQM5RSldhHqBGDdn2yM0Qu17SD7GZ55VJUBLWFAER7D1nTECs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOXRrQOf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOXRrQOf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A89D5C2BCB2;
	Fri, 20 Mar 2026 16:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774024052;
	bh=tcxW2KGMQxeN7j/80ixGlmuXDonndQIJFDc8FtxgG0A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qOXRrQOfuN/fMJxqN452g2IaeCvlDw/oLVlxOwzZxiKb1ip1g3SSChps2VRf0CmH+
	 SpCJTdfsSjIA3m6v8BRMi3CyBSdyZEU9bL9fEEJQoLZysPdYY+ZlumOucbRDtI4dS6
	 /LycLBHrhfoZkABvQCmSvN9E7EqHmUQB7m9YJEdjowt8RgC6rPlhk1SL7B32JbcgN4
	 uG+VJ77/oPOBTGS2fWQhQF3PBX4Oo7r6NPhUp2KU3Uln4cyjDMFenREaizbm/vhkKZ
	 vHUjFZHTRZeE4JF2qiZ0rgO24OHqGQYPyn8nyf7V5AGmXU8NvwpKHu/HsF1hOqJu40
	 IR4k+qqTvN8dw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3D210987A8;
	Fri, 20 Mar 2026 16:27:32 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 20 Mar 2026 16:27:28 +0000
Subject: [PATCH v9 3/9] iio: core: add fixed point parsing with 64-bit
 parts
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-adf41513-iio-driver-v9-3-132f0d076374@analog.com>
References: <20260320-adf41513-iio-driver-v9-0-132f0d076374@analog.com>
In-Reply-To: <20260320-adf41513-iio-driver-v9-0-132f0d076374@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774024051; l=5973;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=Ksnd2aTUQTR8CkiKxAGTVTTHsBtY2D2AzT0O1EeNwBQ=;
 b=4UeOZDXkJ+Rd3L+AB4SwQtyOx2Uy6O4a5By+kvjEeFiLlnRhjlnKJw0fUOxVT5Vor9hgPXLIA
 V5Ap0ncBNEhAuodFOaus37QOATqlKHMgS3V9v7Nbh/GAwuqf6rU/H2o
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add iio_str_to_fixpoint64() function that leverages simple_strntoull()
to parse numbers from a string. A helper function
__iio_str_to_fixpoint64() replaces __iio_str_to_fixpoint() implementation,
extending its usage for 64-bit fixed-point parsing.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/industrialio-core.c | 165 ++++++++++++++++++++++++++++------------
 include/linux/iio/iio.h         |   2 +
 2 files changed, 117 insertions(+), 50 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 22eefd048ba9..69cb0355526c 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -881,6 +881,91 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
 	}
 }
 
+/**
+ * __iio_str_to_fixpoint64() - Parse a fixed-point number from a string
+ * @str: The string to parse
+ * @fract_mult: Multiplier for the first decimal place, should be a power of 10
+ * @integer: The integer part of the number
+ * @fract: The fractional part of the number
+ * @scale_db: True if this should parse as dB
+ *
+ * This variant uses 64-bit integers for both integer and fractional parts.
+ * Parsed positive values greater than S64_MAX are returned as-is. Parsed
+ * negative values less than S64_MIN are treated as range error, so -ERANGE is
+ * returned.
+ *
+ * Returns:
+ * 0 on success, or a negative error code if the string could not be parsed.
+ */
+static int __iio_str_to_fixpoint64(const char *str, u64 fract_mult,
+				   s64 *integer, s64 *fract, bool scale_db)
+{
+	u64 i = 0, f = 0;
+	int precision = ffs(fract_mult);
+	bool negative = false;
+	ssize_t len;
+
+	if (precision > 20) /* ceil(log10(U64_MAX)) = 20 */
+		return -EINVAL;
+
+	if (str[0] == '-') {
+		negative = true;
+		str++;
+	} else if (str[0] == '+') {
+		str++;
+	}
+
+	if (*str != '.') {
+		len = simple_strntoull(str, &str, 10, SIZE_MAX, &i);
+		if (len < 0)
+			return len;
+	}
+
+	if (precision && *str == '.') {
+		str++; /* skip decimal point */
+		len = simple_strntoull(str, &str, 10, precision, &f);
+		if (len < 0)
+			return len;
+
+		if (len < precision) /* scale up */
+			f *= int_pow(10, precision - len);
+
+		while (isdigit(*str)) /* truncate: ignore further digits */
+			str++;
+	}
+
+	if (scale_db) {
+		/* Ignore the dB suffix */
+		if (!strncmp(str, " dB", sizeof(" dB") - 1))
+			str += sizeof(" dB") - 1;
+		else if (!strncmp(str, "dB", sizeof("dB") - 1))
+			str += sizeof("dB") - 1;
+	}
+
+	if (*str == '\n')
+		str++;
+
+	if (*str != '\0')
+		return -EINVAL;
+
+	if (negative) {
+		if (i) {
+			if ((s64)-i > 0)
+				return -ERANGE;
+			i = -i;
+		} else {
+			if ((s64)-f > 0)
+				return -ERANGE;
+			f = -f;
+		}
+	}
+
+	*integer = i;
+	*fract = f;
+
+	return 0;
+}
+
 /**
  * __iio_str_to_fixpoint() - Parse a fixed-point number from a string
  * @str: The string to parse
@@ -895,63 +980,43 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
 static int __iio_str_to_fixpoint(const char *str, int fract_mult,
 				 int *integer, int *fract, bool scale_db)
 {
-	int i = 0, f = 0;
-	bool integer_part = true, negative = false;
+	s64 integer64, fract64;
+	int ret;
 
-	if (fract_mult == 0) {
-		*fract = 0;
+	ret = __iio_str_to_fixpoint64(str, fract_mult, &integer64, &fract64,
+				      scale_db);
+	if (ret)
+		return ret;
 
-		return kstrtoint(str, 0, integer);
-	}
+	if (integer64 < INT_MIN || integer64 > UINT_MAX ||
+	    fract64 < INT_MIN || fract64 > UINT_MAX)
+		return -ERANGE;
 
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
+	*integer = integer64;
+	*fract = fract64;
 
 	return 0;
 }
 
+/**
+ * iio_str_to_fixpoint64() - Parse a fixed-point number from a string
+ * @str: The string to parse
+ * @fract_mult: Multiplier for the first decimal place, should be a power of 10
+ * @integer: The integer part of the number
+ * @fract: The fractional part of the number
+ *
+ * This variant uses 64-bit integers for both integer and fractional parts.
+ *
+ * Returns:
+ * 0 on success, or a negative error code if the string could not be parsed.
+ */
+int iio_str_to_fixpoint64(const char *str, u64 fract_mult, s64 *integer,
+			  s64 *fract)
+{
+	return __iio_str_to_fixpoint64(str, fract_mult, integer, fract, false);
+}
+EXPORT_SYMBOL_GPL(iio_str_to_fixpoint64);
+
 /**
  * iio_str_to_fixpoint() - Parse a fixed-point number from a string
  * @str: The string to parse
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index a9ecff191bd9..cb30d153465a 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -1055,6 +1055,8 @@ int iio_active_scan_mask_index(struct iio_dev *indio_dev);
 
 ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
 
+int iio_str_to_fixpoint64(const char *str, u64 fract_mult, s64 *integer,
+			  s64 *fract);
 int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
 	int *fract);
 

-- 
2.43.0


