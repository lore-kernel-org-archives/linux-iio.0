Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1593F54D0;
	Thu,  4 Jun 2026 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567183; cv=none; b=Wpz3g+BiRryVC29LYYsNaBoBr07Gv5pXg4yD54dNU4Dzktnwy+E33BnheXKE6ozWsjJ0KyusF2L/pQJ33XLDQyyupBlcEMX/VtffEFd5cqewXgg2FHwJ7ZCqCn7Y9lhGEQm1qdIuYG95mndmHILXg2WlZ959LOtngs5GoSJy4Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567183; c=relaxed/simple;
	bh=ed8kRASVhwic8a52ZYnd3NQWFKrdS33lCefZWKvN3D4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MPb52tFhT1nQBsIuQC7tiAabQYuWbjBAYITSN7CVlQkpWfgrPfIQ3C/QsNav0PRbaz/8cM0bEBtK/hLmBmwqJElUkELWjKwLrSF6elObnqlXimm5O9oQcv5+F+EQndo+Fdl8ugEMAMMM6htdXtMSd4oQQ9OWc2OlBaVtcjMChBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hf4/pXdm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hf4/pXdm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22547C2BD00;
	Thu,  4 Jun 2026 09:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780567183;
	bh=ed8kRASVhwic8a52ZYnd3NQWFKrdS33lCefZWKvN3D4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Hf4/pXdmCZ1xizleM+E2F3w1lyTM5N29Erve7myyO5ULmB5Wc68Mbn3o01qGJBtUQ
	 B6WnLl8kR6DwE3mjagCLCYJexWeLPvZEggmNDZVJMXaPK5ZE9DVqlI6jfqBCyd+SN8
	 BwClZw4WGJnRGY26K6TtC1DFH9ax50pQ9bxyaJ7BRrZrh4Xu6aWWDQrgFvM8C6zZSp
	 +BQIFHLyUccWG8I2hBLYxp1Zt7TrsKfqaK/e8bg91yCM0Z7G0V7aOANLgB/vOm15Y6
	 UysSr1WnuclI0+PH7UNczBxb2F4j6irkcWdtvEUlbBKv5XzXvPRSFE92aChw+FS1wG
	 j19y8pnm8ilBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19916CD6E6B;
	Thu,  4 Jun 2026 09:59:43 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 04 Jun 2026 10:58:59 +0100
Subject: [PATCH v16 05/14] lib: kstrtox: add kstrtoudec64() and
 kstrtodec64()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-adf41513-iio-driver-v16-5-1a7d09143bc2@analog.com>
References: <20260604-adf41513-iio-driver-v16-0-1a7d09143bc2@analog.com>
In-Reply-To: <20260604-adf41513-iio-driver-v16-0-1a7d09143bc2@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux@analog.com
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780567181; l=5049;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=jkjWKrpazdHOL5wYa0w8oz3c/kjzCgC9AxyBAR3TDZo=;
 b=IeJBj40aZ2O02+nz8TdyIg5lcv58Xbos8qwJU8vinyodSKv8zrcjDOV1QD1j7vDQ5bLXD+80X
 /TqoQqa5IpwAkqXeBPPcZS6k1jPk2LiFfgpYIOalmL9ND+PCm3k7KmB
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
 lib/kstrtox.c           | 104 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

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
index cc6869a97bf2..4ea0da1e0753 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -17,6 +17,7 @@
 #include <linux/export.h>
 #include <linux/kstrtox.h>
 #include <linux/math64.h>
+#include <linux/overflow.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
 
@@ -386,6 +387,109 @@ int kstrtobool(const char *s, bool *res)
 }
 EXPORT_SYMBOL(kstrtobool);
 
+static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
+{
+	unsigned int rv_int, rv_frac;
+	u64 _res = 0;
+
+	rv_int = _parse_integer(s, 10, &_res);
+	if (rv_int & KSTRTOX_OVERFLOW)
+		return -ERANGE;
+	s += rv_int;
+
+	if (*s == '.')
+		s++; /* skip decimal point */
+
+	rv_frac = _parse_integer(s, 10, &_res, scale, _res);
+	if (rv_frac & KSTRTOX_OVERFLOW)
+		return -ERANGE;
+	s += rv_frac;
+
+	/*
+	 * Check input beyond rv_int and rv_frac to cover cases like ".5" with
+	 * scale 0, which is considered a valid input, being parsed as 0.
+	 */
+	if (!rv_int && !rv_frac && !isdigit(*s))
+		return -EINVAL;
+
+	while (isdigit(*s)) /* truncate digits */
+		s++;
+
+	if (*s == '\n')
+		s++;
+	if (*s)
+		return -EINVAL;
+
+	if (_res && ((scale - rv_frac) > 19 /* log10(2^64) = 19.26 */ ||
+		     check_mul_overflow(_res, int_pow(10, scale - rv_frac), &_res)))
+		return -ERANGE;
+
+	*res = _res;
+	return 0;
+}
+
+/**
+ * kstrtoudec64() - Convert a string to an unsigned 64-bit scaled decimal value.
+ * @s: The start of the string. The string must be null-terminated, and may also
+ *  include a single newline before its terminating null. The first character
+ *  may also be a plus sign, but not a minus sign.
+ * @scale: The number of digits to the right of the decimal point.
+ * @res: Where to write the result of the conversion on success.
+ *
+ * For example, a scale of 3 with input "123.45" results in 123450. Note that
+ * trailing zeros in the fractional part input to match the scale are not
+ * required. Also, digits beyond the specified scale are ignored.
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
+ * kstrtodec64() - Convert a string to a signed 64-bit scaled decimal value.
+ * @s: The start of the string. The string must be null-terminated, and may also
+ *  include a single newline before its terminating null. The first character
+ *  may also be a plus sign or a minus sign.
+ * @scale: The number of digits to the right of the decimal point.
+ * @res: Where to write the result of the conversion on success.
+ *
+ * For example, a scale of 4 with input "-3.141592" results in -31415. Note
+ * that digits beyond the specified scale are ignored. Also, trailing zeros in
+ * the fractional part input to match the scale are not required.
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


