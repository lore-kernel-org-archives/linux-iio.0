Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4231A3557F3;
	Sun, 17 May 2026 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779009281; cv=none; b=RlEZaMORpbKsMKv80MjwX7IO4tyNEJTgTt/1/OnE7A1YooW8zSlT2UgzIeXLKJlgRw65iCI1VWlpix66MPgWQeb32vo8HTodi+V8LE/Ixm4+5fFoXTg9eYziHbMCljxf9uqAVyzEzHQQqvNnbDMcyu1VRkojn1J5i5J3aALtZps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779009281; c=relaxed/simple;
	bh=6Ss4wcSzCvtm+9578SDofXJKyxx/4Tiif2EzWY9ByS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=igkJWwsmxmWxDGHVfVitUvL8ifl/5KkTx4GLAkOsEvZAt8VGExTE2or1Fj9iAt0w4MV5/+vtWb7NgwarqDC3jrQ3FGkOKynRlq+gUrmaU3I0eDbedaIvlRCQg/ZM+9C6J23Z5l/sVOXaV5ooZA60IL7pkEZLZ+ylik0vdlrT4bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtRXWqUz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtRXWqUz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1465DC2BCF6;
	Sun, 17 May 2026 09:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779009281;
	bh=6Ss4wcSzCvtm+9578SDofXJKyxx/4Tiif2EzWY9ByS4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jtRXWqUzixcOSLYTu0Q7dUcaKobXEQQ3t+ZADY/UDIKvhbF/TYztunHbt5zlXVKhl
	 QxRucCjme5DCPWgmLpYkYQBOucsPz7X/p5kidKtipyWBzbozwQbIS/Mfhriz1Zf+iZ
	 EfgNq5H4SjDwtptqhqVg/d0AW81szykXemJytE71YkR47NJzrZYo1gbyRh9OBgRWPi
	 CaF+qGyDy0YKonE/qcB72/Bh2eetaWBuPTQK8eYGFZ2Lljb3z0HOLzXxXZMue4LrJM
	 dXj7p8VuB5+cVr6ekSfTVCQnig+djVkJr6qxa49NMliRx7xGKA4vHF+9i8ZzIBGXfz
	 IzWGhM0xI0WJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB84CD4F21;
	Sun, 17 May 2026 09:14:41 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 17 May 2026 10:14:01 +0100
Subject: [PATCH v13 06/12] iio: core: add decimal value formatting into
 64-bit value
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-adf41513-iio-driver-v13-6-bb6e134a360f@analog.com>
References: <20260517-adf41513-iio-driver-v13-0-bb6e134a360f@analog.com>
In-Reply-To: <20260517-adf41513-iio-driver-v13-0-bb6e134a360f@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779009279; l=5703;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=VBPLKWxUDrnFST3MHN0D4NgtmmQCQls3Sf8quoeuQNE=;
 b=K1+kKCZGX6jMYpKYXS6+xI8Kj96bON2F4J8z8RcN3dTYUM2dr88tWjXLy4c15dc9ZNlDEK9KC
 j4ZX0L3lCdTBP0BFF/PJ28PWgujDnk0GlAtN3dwAmYydWqavp8sgqHS
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
 drivers/iio/industrialio-core.c | 46 ++++++++++++++++++++++++++++++++++-------
 include/linux/iio/types.h       | 29 ++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index bd6f4f9f4533..336aedc1fbab 100644
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
@@ -707,8 +707,26 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
 	case IIO_VAL_CHAR:
 		return sysfs_emit_at(buf, offset, "%c", (char)vals[0]);
 	case IIO_VAL_INT_64:
-		tmp2 = (s64)((((u64)vals[1]) << 32) | (u32)vals[0]);
+		tmp2 = iio_val_s64_from_s32s(vals);
 		return sysfs_emit_at(buf, offset, "%lld", tmp2);
+	case IIO_VAL_DECIMAL64_MILLI:
+	case IIO_VAL_DECIMAL64_MICRO:
+	case IIO_VAL_DECIMAL64_NANO:
+	case IIO_VAL_DECIMAL64_PICO:
+	{
+		int scale = type - IIO_VAL_DECIMAL64_BASE;
+		int l = 0;
+		s64 frac;
+
+		tmp2 = div64_s64_rem(iio_val_s64_from_s32s(vals),
+				     int_pow(10, scale), &frac);
+		if (tmp2 == 0 && frac < 0)
+			l += sysfs_emit_at(buf, offset, "-");
+
+		l += sysfs_emit_at(buf, offset + l, "%lld.%0*lld", tmp2, scale,
+				   abs(frac));
+		return l;
+	}
 	default:
 		return 0;
 	}
@@ -978,6 +996,7 @@ static ssize_t iio_write_channel_info(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret, fract_mult = 100000;
+	int type, dec_scale = 0;
 	int integer, fract = 0;
 	long long integer64;
 	bool is_char = false;
@@ -988,9 +1007,11 @@ static ssize_t iio_write_channel_info(struct device *dev,
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
@@ -1006,12 +1027,19 @@ static ssize_t iio_write_channel_info(struct device *dev,
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
@@ -1020,12 +1048,14 @@ static ssize_t iio_write_channel_info(struct device *dev,
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
index 4e3099defc1d..16e0a0d002ac 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -7,6 +7,8 @@
 #ifndef _IIO_TYPES_H_
 #define _IIO_TYPES_H_
 
+#include <linux/wordpart.h>
+
 #include <uapi/linux/iio/types.h>
 
 enum iio_event_info {
@@ -34,6 +36,33 @@ enum iio_event_info {
 #define IIO_VAL_FRACTIONAL_LOG2 11
 #define IIO_VAL_CHAR 12
 
+#define IIO_VAL_DECIMAL64_BASE		32
+#define IIO_VAL_DECIMAL64_MILLI		(IIO_VAL_DECIMAL64_BASE + 3)
+#define IIO_VAL_DECIMAL64_MICRO		(IIO_VAL_DECIMAL64_BASE + 6)
+#define IIO_VAL_DECIMAL64_NANO		(IIO_VAL_DECIMAL64_BASE + 9)
+#define IIO_VAL_DECIMAL64_PICO		(IIO_VAL_DECIMAL64_BASE + 12)
+
+static inline s64 iio_val_s64_compose(s32 val0, s32 val1)
+{
+	return (s64)(((u64)val1 << 32) | (u32)val0);
+}
+
+static inline s64 iio_val_s64_from_s32s(const s32 *vals)
+{
+	return iio_val_s64_compose(vals[0], vals[1]);
+}
+
+static inline void iio_val_s64_decompose(s64 dec64, s32 *val0, s32 *val1)
+{
+	*val0 = lower_32_bits(dec64);
+	*val1 = upper_32_bits(dec64);
+}
+
+static inline void iio_val_s64_to_s32s(s64 dec64, s32 *vals)
+{
+	iio_val_s64_decompose(dec64, &vals[0], &vals[1]);
+}
+
 enum iio_available_type {
 	IIO_AVAIL_LIST,
 	IIO_AVAIL_RANGE,

-- 
2.43.0


