Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0085B480DDE;
	Wed,  6 May 2026 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076530; cv=none; b=IBQXrqEGp8nQaQS3YNem7qBSLtNycHYeOvWbL4WuZ/Knzxrp46OL9PqmiIq1iGNvDhhKO3MzsaWRnm2cNbsYxgM09mZa+9h9UjvLFKOX+liHv0UbVIwMCP6dcauyGmXQWHtn4KLUa+djR+WtT9i3KOgAo28XdrbqxeyVXRI7um4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076530; c=relaxed/simple;
	bh=ZSgaOdUQupu8XrSCIqi0SgGUr/OnCwKgYZzyveNu1K4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tzEQnZaY0T/865lYNc+cwSuuFr4LjJ6NsCJ//LBc0rr4CX8fT5g0Kw5He276h/o+4HePM5jxW/rC1lUuUd89OAjqN4L0ZlW7u8310qfN6JEh2+0qqwX0HiTEpucAIl5+sxq5ACifcHG52Kzv76AStvAw4wKAGAvVxlOPWSo8SNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpR95CxZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpR95CxZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF55FC2BCF5;
	Wed,  6 May 2026 14:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778076529;
	bh=ZSgaOdUQupu8XrSCIqi0SgGUr/OnCwKgYZzyveNu1K4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mpR95CxZmWzugw510uhbYOig/cso2TEzsfX0nP6fx2lS9P9Lvd7KAEwnZ4PCziEMq
	 jlAeDbJx3/EFJUMhKrb2OJbhxP7B/RJ+sybnTR0H0XbgBYRWqkEywCOudHsrF3DaOK
	 YEcjFVY9i1fNEoGPn7HU3fPXUNdw+vZmtz9DxBvgWHDdpnvnJ+F4XLf8MT5OEDXndE
	 dKVSar4P+0InvhAuBTpYP9tHapHK7TK794npuVkVj5hQhCIicqBiwAeRikbR9iNWXc
	 LVgGRgUTA3Viql4gnAEu0YXKh0bGMWWGDHntXIS5QdY5AV3OB9p6/TkniIp9dvFKhJ
	 brGespppsBjyA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C656ECD343B;
	Wed,  6 May 2026 14:08:49 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 06 May 2026 15:08:49 +0100
Subject: [PATCH v11 05/11] iio: core: add decimal value formatting into
 64-bit value
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-adf41513-iio-driver-v11-5-2b7e99cfe8f2@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778076527; l=5768;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=1r7wBeRsvAbKs6Q8cqgV1ynf3N20gmEGvnU090e1IMY=;
 b=+ryDbDjBcVO3B5f/uu+ahML1IvTYJ9ebhkz0o/7ugd8PVIf/XfXRxuAvwBwLCiF99FX+3fZ13
 BZYB6bCJIEcDZlw2T95QeLT7Q857dSj1Frq9B2lvOx6qWRfWZbOklP+
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Create new format types for iio values (IIO_VAL_DECIMAL64_*), which
defines the representation of fixed decimal point values into a single
64-bit number. This new format increases the range of represented values,
allowing for integer parts greater than 2^32, as bits are not "wasted"
in the fractional part, which can be seen in IIO_VAL_INT_PLUS_MICRO and
IIO_VAL_INT_PLUS_NANO. Helpers are created to compose and decompose 64-bit
decimals into integer values used in IIO formatting interfaces, which
creates consistency and avoid error-prone manual assignments when using
wordpart macros. When doing the parsing, kstrtodec64() is used with the
scale defined by the specific decimal format type.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/industrialio-core.c | 46 +++++++++++++++++++++++++++++++++--------
 include/linux/iio/types.h       | 28 +++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index bd6f4f9f4533..24bc1577fdac 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -19,6 +19,7 @@
 #include <linux/idr.h>
 #include <linux/kdev_t.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/poll.h>
@@ -26,7 +27,6 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
-#include <linux/wordpart.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/buffer_impl.h>
@@ -707,8 +707,25 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
 	case IIO_VAL_CHAR:
 		return sysfs_emit_at(buf, offset, "%c", (char)vals[0]);
 	case IIO_VAL_INT_64:
-		tmp2 = (s64)((((u64)vals[1]) << 32) | (u32)vals[0]);
+		tmp2 = iio_val_s64_from_array(vals);
 		return sysfs_emit_at(buf, offset, "%lld", tmp2);
+	case IIO_VAL_DECIMAL64_MILLI:
+	case IIO_VAL_DECIMAL64_MICRO:
+	case IIO_VAL_DECIMAL64_NANO:
+	case IIO_VAL_DECIMAL64_PICO:
+	{
+		s64 frac;
+		unsigned int scale = type - IIO_VAL_DECIMAL64_BASE;
+
+		tmp2 = div64_s64_rem(iio_val_s64_from_array(vals),
+				     int_pow(10, scale), &frac);
+		if (tmp2 == 0 && frac < 0)
+			return sysfs_emit_at(buf, offset, "-0.%0*lld", scale,
+					     abs(frac));
+		else
+			return sysfs_emit_at(buf, offset, "%lld.%0*lld", tmp2,
+					     scale, abs(frac));
+	}
 	default:
 		return 0;
 	}
@@ -977,7 +994,7 @@ static ssize_t iio_write_channel_info(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int ret, fract_mult = 100000;
+	int type, ret, fract_mult = 100000, dec_scale = 0;
 	int integer, fract = 0;
 	long long integer64;
 	bool is_char = false;
@@ -988,9 +1005,11 @@ static ssize_t iio_write_channel_info(struct device *dev,
 	if (!indio_dev->info->write_raw)
 		return -EINVAL;
 
-	if (indio_dev->info->write_raw_get_fmt)
-		switch (indio_dev->info->write_raw_get_fmt(indio_dev,
-			this_attr->c, this_attr->address)) {
+	if (indio_dev->info->write_raw_get_fmt) {
+		type = indio_dev->info->write_raw_get_fmt(indio_dev,
+							  this_attr->c,
+							  this_attr->address);
+		switch (type) {
 		case IIO_VAL_INT:
 			fract_mult = 0;
 			break;
@@ -1006,12 +1025,19 @@ static ssize_t iio_write_channel_info(struct device *dev,
 		case IIO_VAL_CHAR:
 			is_char = true;
 			break;
+		case IIO_VAL_DECIMAL64_MILLI:
+		case IIO_VAL_DECIMAL64_MICRO:
+		case IIO_VAL_DECIMAL64_NANO:
+		case IIO_VAL_DECIMAL64_PICO:
+			dec_scale = type - IIO_VAL_DECIMAL64_BASE;
+			fallthrough;
 		case IIO_VAL_INT_64:
 			is_64bit = true;
 			break;
 		default:
 			return -EINVAL;
 		}
+	}
 
 	if (is_char) {
 		char ch;
@@ -1020,12 +1046,14 @@ static ssize_t iio_write_channel_info(struct device *dev,
 			return -EINVAL;
 		integer = ch;
 	} else if (is_64bit) {
-		ret = kstrtoll(buf, 0, &integer64);
+		if (dec_scale)
+			ret = kstrtodec64(buf, dec_scale, &integer64);
+		else
+			ret = kstrtoll(buf, 0, &integer64);
 		if (ret)
 			return ret;
 
-		fract = upper_32_bits(integer64);
-		integer = lower_32_bits(integer64);
+		iio_val_s64_decompose(integer64, &integer, &fract);
 	} else {
 		ret = __iio_str_to_fixpoint(buf, fract_mult, &integer, &fract,
 					    scale_db);
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 4e3099defc1d..bc0e6f66bd9c 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -7,6 +7,7 @@
 #ifndef _IIO_TYPES_H_
 #define _IIO_TYPES_H_
 
+#include <linux/wordpart.h>
 #include <uapi/linux/iio/types.h>
 
 enum iio_event_info {
@@ -34,6 +35,33 @@ enum iio_event_info {
 #define IIO_VAL_FRACTIONAL_LOG2 11
 #define IIO_VAL_CHAR 12
 
+#define IIO_VAL_DECIMAL64_BASE		100
+#define IIO_VAL_DECIMAL64_MILLI		(IIO_VAL_DECIMAL64_BASE + 3)
+#define IIO_VAL_DECIMAL64_MICRO		(IIO_VAL_DECIMAL64_BASE + 6)
+#define IIO_VAL_DECIMAL64_NANO		(IIO_VAL_DECIMAL64_BASE + 9)
+#define IIO_VAL_DECIMAL64_PICO		(IIO_VAL_DECIMAL64_BASE + 12)
+
+static inline s64 iio_val_s64_compose(int val0, int val1)
+{
+	return (s64)(((u64)val1 << 32) | (u32)val0);
+}
+
+static inline s64 iio_val_s64_from_array(const int *vals)
+{
+	return iio_val_s64_compose(vals[0], vals[1]);
+}
+
+static inline void iio_val_s64_decompose(s64 dec64, int *val0, int *val1)
+{
+	*val0 = lower_32_bits(dec64);
+	*val1 = upper_32_bits(dec64);
+}
+
+static inline void iio_val_s64_array_populate(s64 dec64, int *vals)
+{
+	iio_val_s64_decompose(dec64, &vals[0], &vals[1]);
+}
+
 enum iio_available_type {
 	IIO_AVAIL_LIST,
 	IIO_AVAIL_RANGE,

-- 
2.43.0


