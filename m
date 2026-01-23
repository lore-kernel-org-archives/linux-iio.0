Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934EF2F547F;
	Fri, 23 Jan 2026 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769183638; cv=none; b=pM97bkwkVuf2ds8sQucBQlyvwLnhO4xnqWS6FDntcjbXfH38PuyeFCzvVwa1+nCPoxd5CYph+us3vylKs2HcA3HJiKRNHLnZtvimz0/v6pPyEd3dMeuIupBEWdM8nm2UFkO4JgxPIFoFQIA6bIJa0yirF6Yu11v5C8jjkqOdZxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769183638; c=relaxed/simple;
	bh=R7vm4aZOBiDNx/wHB/tpHckhIayyxKVEOFE8hcpvIDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rCDQ9QKEmToeRud8DjbxDx5pRXBb8/7Nn/0+afU5jf+d6Ngyy11uKOVPH6ZlTbW85xtX4Eb8c9t/apqikMQPu3GQgIBFqTE9AjGXKNL5cuhEAWnMzbVXncZfL5jGbkWDzotzjZFQOdWEFsr9wKTnraURirO7UT5T6RVEf1u5OsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQUcC6/u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQUcC6/u"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55D86C2BC86;
	Fri, 23 Jan 2026 15:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769183638;
	bh=R7vm4aZOBiDNx/wHB/tpHckhIayyxKVEOFE8hcpvIDc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CQUcC6/unzL2ZueF+21+wDupWUh2pAT8yhhQlShP4uIyN9i+XRyXRKpb0yOCn6dB4
	 H96qO1b26jgkvT+gRFtdxA4QVMcWC29Iv1j9UbYqZeKMSdpOv2cAsJAjWJWVMMB5lb
	 DHtNdIedMSM7pJ7r4+wI7nyoqmkOHcNVNRduOYbiuo+26Sded49ITEtcEv701JLnJq
	 1sOPiq+j1yB6fBV3p2tbQWaWx2EceT8u+VMVFhSKqDnowj9e4py7kaF8X27ERWo2xc
	 ZCqTcUJaFS8FKIcuewjJVTyDpVI9htPl7LllwTugVzhoCTw75PwTzrerjVSqVUbyVJ
	 AezjWI6x2FBPQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C1FD74EF3;
	Fri, 23 Jan 2026 15:53:58 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 23 Jan 2026 15:53:07 +0000
Subject: [PATCH v5 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-adf41513-iio-driver-v5-2-2dce812a2dda@analog.com>
References: <20260123-adf41513-iio-driver-v5-0-2dce812a2dda@analog.com>
In-Reply-To: <20260123-adf41513-iio-driver-v5-0-2dce812a2dda@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769183636; l=5726;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=FiReBaiuJATL+Y1igulBqy6KALX1/IMCZ9XVcyWaYR4=;
 b=gIsHt1MgZgLQtJF1hn7ZhKruszvDsacZs621EBCtIrv3Ect1ON0pACf1cua87qzu2+iEgY/vc
 K16QguQNTjtBb7TnP8wNg3N2OP4FyJ5dYSbr1kLheXfQ7Wvrih9LwJ0
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add iio_str_to_fixpoint64() function that leverages simple_strtoull()
to parse numbers from a string.
A helper function __iio_str_to_fixpoint64() replaces
__iio_str_to_fixpoint() implementation, extending its usage for
64-bit fixed-point parsing.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/industrialio-core.c | 151 +++++++++++++++++++++++++++-------------
 include/linux/iio/iio.h         |   2 +
 2 files changed, 103 insertions(+), 50 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f69deefcfb6f..4ad4f1b29421 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -881,6 +881,77 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
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
+ *
+ * Returns:
+ * 0 on success, or a negative error code if the string could not be parsed.
+ */
+static int __iio_str_to_fixpoint64(const char *str, u64 fract_mult,
+				   s64 *integer, s64 *fract, bool scale_db)
+{
+	u64 i = 0, f = 0;
+	char *end;
+	int digit_count, precision = ffs(fract_mult);
+	bool negative = false;
+
+	if (str[0] == '-') {
+		negative = true;
+		str++;
+	} else if (str[0] == '+') {
+		str++;
+	}
+
+	i = simple_strtoull(str, &end, 10);
+	digit_count = end - str;
+	if (digit_count > 20)
+		return -EINVAL;
+
+	if (precision && *end == '.') {
+		str = end + 1;
+		f = simple_strtoull(str, &end, 10);
+		digit_count = end - str;
+		if (!digit_count || digit_count > 20)
+			return -EINVAL;
+
+		if (digit_count > precision) {
+			digit_count -= precision;
+			f = div64_u64(f, int_pow(10, digit_count));
+		} else {
+			digit_count = precision - digit_count;
+			f *= int_pow(10, digit_count);
+		}
+	} else if (!digit_count) {
+		return -EINVAL;
+	}
+
+	if (scale_db) {
+		/* Ignore the dB suffix */
+		if (!strncmp(end, " dB", sizeof(" dB") - 1))
+			end += sizeof(" dB") - 1;
+		else if (!strncmp(end, "dB", sizeof("dB") - 1))
+			end += sizeof("dB") - 1;
+	}
+
+	if (*end == '\n')
+		end++;
+
+	if (*end != '\0')
+		return -EINVAL;
+
+	*integer = (negative && i) ? -i : i;
+	*fract = (negative && !i) ? -f : f;
+
+	return 0;
+}
+
 /**
  * __iio_str_to_fixpoint() - Parse a fixed-point number from a string
  * @str: The string to parse
@@ -895,63 +966,43 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
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
+	if (integer64 < INT_MIN || integer64 > INT_MAX ||
+	    fract64 < INT_MIN || fract64 > INT_MAX)
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
index 872ebdf0dd77..432cd26fc9d0 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -940,6 +940,8 @@ int iio_active_scan_mask_index(struct iio_dev *indio_dev);
 
 ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
 
+int iio_str_to_fixpoint64(const char *str, u64 fract_mult, s64 *integer,
+			  s64 *fract);
 int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
 	int *fract);
 

-- 
2.43.0


