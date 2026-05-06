Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D9847ECE2;
	Wed,  6 May 2026 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076529; cv=none; b=bQcY8YAN1tajjPIZZKgZ5mWzc2CHCYXVrCvrw8QAvEl9H7QC2/1wyzyIhgO91N7DX0jWHPXUEj/ujG4igI5RdtmAengyJ5C/6THxVNoRsB6QF1Bzi2dStr+zuPjEqsDeGdxVTZudX1pu7W1trsum0iszVd2rvmnzggKijSt1FeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076529; c=relaxed/simple;
	bh=2+TerP07gtH1TPPTrBAvH+uY0hepaE75kcSpEWfPvAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rT987PinvuXo5fmgcp4n8sZIPuiCczhk9j7d/wwfDRJwWFDsuLvBpkE/1p36Kxa9xL8DWKUXS43DY1YZnhxZKr+6JTCGTkAa8iX04LngcexpDEzfc7HkRzK4Q4sVqGt6CcOeS8mjUNOD2ROxP94FQddVunPucDH2vI4Zo4SpI64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvVxyYLE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvVxyYLE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E54CC2BCF6;
	Wed,  6 May 2026 14:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778076529;
	bh=2+TerP07gtH1TPPTrBAvH+uY0hepaE75kcSpEWfPvAU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZvVxyYLEMdVUOfJ6EKWNRn1yGzVGfjNg0APr88Ts7NtuQxjott6u1G8rIUU2pHOR2
	 xrZwOkUZ6OW9UAAsMXV3sE52l5PHWnwTp78qLv0P8WrPNB2Z/lqgZ18M2csHVE64Ys
	 wEbvQZj1y7aTDI14j9XnXq04rstXYyTkJsoGiZyGP5mvjFjVl2UnqQPWpKzJr21fYr
	 K/fnrxbs4E33LhR5QcqzNFBLkWUBnqRtQnTRiL51zd4cWaZu3s2VNZ/tHE3eKxJmt8
	 YWuNlxCG9UURUumFRHiST4eBnYlBUVMmooGMk+WVKO1OaLObDI4FGb2lFsufxVirfA
	 hxa6hHvOm2BLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82328CD3442;
	Wed,  6 May 2026 14:08:49 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 06 May 2026 15:08:46 +0100
Subject: [PATCH v11 02/11] lib: kstrtox: add kstrtoudec64() and
 kstrtodec64()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-adf41513-iio-driver-v11-2-2b7e99cfe8f2@analog.com>
References: <20260506-adf41513-iio-driver-v11-0-2b7e99cfe8f2@analog.com>
In-Reply-To: <20260506-adf41513-iio-driver-v11-0-2b7e99cfe8f2@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778076527; l=4926;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=gkjWYVr90c95wpp/Yql7eG3M6Wm527JyFFIrkEU+vqo=;
 b=q3wp4MRP57BnQWAY4EvmaCMT3U+i2gIem9Sy6eSFRnKaXWiUDqaZIrTdXiGlSKCxL8ZwH4xF+
 Xi5wlXwsuC5CBC5JrXM8/Pi5xmcSI4eJNLgCS/s9RyMdDhR8vazU6CF
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
 lib/kstrtox.c           | 105 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

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
index 97be2a39f537..c7625ba4ac88 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -17,6 +17,7 @@
 #include <linux/export.h>
 #include <linux/kstrtox.h>
 #include <linux/math64.h>
+#include <linux/overflow.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
 
@@ -392,6 +393,110 @@ int kstrtobool(const char *s, bool *res)
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
+ * kstrtoudec64 - convert a string to an unsigned 64-bit decimal number
+ * @s: The start of the string. The string must be null-terminated, and may also
+ *  include a single newline before its terminating null. The first character
+ *  may also be a plus sign, but not a minus sign. Digits beyond the specified
+ *  scale are ignored.
+ * @scale: The number of digits to the right of the decimal point. For example,
+ *  a scale of 2 would mean the number is represented with two decimal places,
+ *  so "123.45" would be represented as 12345.
+ * @res: Where to write the result of the conversion on success.
+ *
+ * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
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
+ * kstrtodec64 - convert a string to a signed 64-bit decimal number
+ * @s: The start of the string. The string must be null-terminated, and may also
+ *  include a single newline before its terminating null. The first character
+ *  may also be a plus sign or a minus sign. Digits beyond the specified
+ *  scale are ignored.
+ * @scale: The number of digits to the right of the decimal point. For example,
+ *  a scale of 5 would mean the number is represented with five decimal places,
+ *  so "-3.141592" would be represented as -314159.
+ * @res: Where to write the result of the conversion on success.
+ *
+ * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
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


