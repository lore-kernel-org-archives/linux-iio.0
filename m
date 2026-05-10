Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9039C382F2D;
	Sun, 10 May 2026 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778416954; cv=none; b=iLmb+Yn22Sqb/TkDdUELCXtOCCei/Ewd5G8CdFQAKJBDMCISQGCaXbG7ma0Br6hYVFYtSQLCxu9brTIPtROyYjt8mpEqRsFVS7pFbG1TUtAXSvqUomkQ+BvvOkmDhXEeRw9pYzMHjmqIYnqKgBl76sIYH3q202CF40Si5gUvUgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778416954; c=relaxed/simple;
	bh=JYMvvV9kEoUo4ixyGxEEOStHDHETRyXjQhoHsXlYHWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lPaDIq9g/z08Om1Ho/qhQ1v3FlqG3mCigM6xfDXRYF1s8z8WnisW9YUBAjvFJfaGeN5tJVz+h/vHSa7ovxgpuKD4qX/uiAfxotLqRBRsyasPNEJ1DvwJu0nWbShPRSmgrZ4/q2EMdZbYeDVGcvXMibhl50mZnxCFlpAQaKAyGME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCtJjDI5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCtJjDI5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B476C2BCB8;
	Sun, 10 May 2026 12:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778416954;
	bh=JYMvvV9kEoUo4ixyGxEEOStHDHETRyXjQhoHsXlYHWw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TCtJjDI5rqthsJIAoGovouY1siGWTJEbvNfE80ZYtVxaeQu54lO+AxqoN0winYYx8
	 OTMiOhU4+ZHpzEHtnTucoVQL55wv61o17DivflfVlJ1X7MC3ssFIKp/urOu9Yzvr5n
	 ZHDYcImxvvKsmgY6FRZd2rbM7alxeQCU9hf62tI2JCWkTxyqqUXRl/+FSXYxHoIzsh
	 0NaEP3Vp7Ak0qdpDal8McduMdPW5X6mcG/YjFOnMRX9hs384Qj+/ddbW8+suUc7S5M
	 p30w+9OD8oxdCeS4wsjv/UJlU5BjPz9IRc1NukPfdmsEQG9+1Y//0DKwWuU2eOMY7u
	 0G6wucCRzWF0w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471F3CD37BA;
	Sun, 10 May 2026 12:42:34 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 10 May 2026 13:42:20 +0100
Subject: [PATCH v12 02/11] lib: kstrtox: add kstrtoudec64() and
 kstrtodec64()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-adf41513-iio-driver-v12-2-34af2ed2779f@analog.com>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
In-Reply-To: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778416952; l=5013;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=bfxEiBTybcnSmFHQsPmGvhUNRsDbjiLCPlXgEF2s4Ig=;
 b=QcDCQboWkgn9txE6S3gg5cKg42R9opLiUERDeDWYEj3UJ7FVydYvzJZNlYhXQMbSI53u6yrHk
 PJJK6nIle1/CWDwI9LuKkE3xLEgTJbJ7+4jXXI/Vam3TfjZ31IpTOt/
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add helpers that parses decimal numbers into 64-bit number, i.e., decimal
point numbers with pre-defined scale are parsed into a 64-bit value (fixed
precision). After the decimal point, digits beyond the specified scale
are ignored.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 include/linux/kstrtox.h |   3 ++
 lib/kstrtox.c           | 107 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
index 6ea897222af1..bec2fc17bde0 100644
--- a/include/linux/kstrtox.h
+++ b/include/linux/kstrtox.h
@@ -97,6 +97,9 @@ int __must_check kstrtou8(const char *s, unsigned int base, u8 *res);
 int __must_check kstrtos8(const char *s, unsigned int base, s8 *res);
 int __must_check kstrtobool(const char *s, bool *res);
 
+int __must_check kstrtoudec64(const char *s, unsigned int scale, u64 *res);
+int __must_check kstrtodec64(const char *s, unsigned int scale, s64 *res);
+
 int __must_check kstrtoull_from_user(const char __user *s, size_t count, unsigned int base, unsigned long long *res);
 int __must_check kstrtoll_from_user(const char __user *s, size_t count, unsigned int base, long long *res);
 int __must_check kstrtoul_from_user(const char __user *s, size_t count, unsigned int base, unsigned long *res);
diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index 97be2a39f537..da7b5f83a3c5 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -17,6 +17,7 @@
 #include <linux/export.h>
 #include <linux/kstrtox.h>
 #include <linux/math64.h>
+#include <linux/overflow.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
 
@@ -392,6 +393,112 @@ int kstrtobool(const char *s, bool *res)
 }
 EXPORT_SYMBOL(kstrtobool);
 
+static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
+{
+	u64 _res = 0, _frac = 0;
+	unsigned int rv;
+
+	if (scale > 19) /* log10(2^64) = 19.26 */
+		return -EINVAL;
+
+	if (*s != '.') {
+		rv = _parse_integer(s, 10, &_res);
+		if (rv & KSTRTOX_OVERFLOW)
+			return -ERANGE;
+		if (rv == 0)
+			return -EINVAL;
+		s += rv;
+	}
+
+	if (*s == '.' && scale) {
+		s++; /* skip decimal point */
+		rv = _parse_integer_limit(s, 10, &_frac, scale);
+		if (rv & KSTRTOX_OVERFLOW)
+			return -ERANGE;
+		if (rv == 0)
+			return -EINVAL;
+		s += rv;
+		if (rv < scale)
+			_frac *= int_pow(10, scale - rv);
+		while (isdigit(*s)) /* truncate */
+			s++;
+	}
+
+	if (*s == '\n')
+		s++;
+	if (*s)
+		return -EINVAL;
+
+	if (check_mul_overflow(_res, int_pow(10, scale), &_res) ||
+	    check_add_overflow(_res, _frac, &_res))
+		return -ERANGE;
+
+	*res = _res;
+	return 0;
+}
+
+/**
+ * kstrtoudec64() - Convert a string to an unsigned 64-bit value that represents
+ *		    a scaled decimal number.
+ * @s: The start of the string. The string must be null-terminated, and may also
+ *  include a single newline before its terminating null. The first character
+ *  may also be a plus sign, but not a minus sign. Digits beyond the specified
+ *  scale are ignored.
+ * @scale: The number of digits to the right of the decimal point. For example,
+ *  a scale of 2 would mean the number is represented with two decimal places,
+ *  so "123.45" would be represented as 12345.
+ * @res: Where to write the result of the conversion on success.
+ *
+ * Return: 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
+ */
+noinline
+int kstrtoudec64(const char *s, unsigned int scale, u64 *res)
+{
+	if (s[0] == '+')
+		s++;
+	return _kstrtoudec64(s, scale, res);
+}
+EXPORT_SYMBOL(kstrtoudec64);
+
+/**
+ * kstrtodec64() - Convert a string to a signed 64-bit value that represents a
+ *		   scaled decimal number.
+ * @s: The start of the string. The string must be null-terminated, and may also
+ *  include a single newline before its terminating null. The first character
+ *  may also be a plus sign or a minus sign. Digits beyond the specified
+ *  scale are ignored.
+ * @scale: The number of digits to the right of the decimal point. For example,
+ *  a scale of 5 would mean the number is represented with five decimal places,
+ *  so "-3.141592" would be represented as -314159.
+ * @res: Where to write the result of the conversion on success.
+ *
+ * Return: 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
+ */
+noinline
+int kstrtodec64(const char *s, unsigned int scale, s64 *res)
+{
+	u64 tmp;
+	int rv;
+
+	if (s[0] == '-') {
+		rv = _kstrtoudec64(s + 1, scale, &tmp);
+		if (rv < 0)
+			return rv;
+		if ((s64)-tmp > 0)
+			return -ERANGE;
+		*res = -tmp;
+	} else {
+		rv = kstrtoudec64(s, scale, &tmp);
+		if (rv < 0)
+			return rv;
+		if ((s64)tmp < 0)
+			return -ERANGE;
+		*res = tmp;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(kstrtodec64);
+
 /*
  * Since "base" would be a nonsense argument, this open-codes the
  * _from_user helper instead of using the helper macro below.

-- 
2.43.0


