Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E43F382379;
	Sun, 31 May 2026 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780216298; cv=none; b=Gr+n5SGm8gkCm5dkN62K6qo5TE5uq32Qg1/9LgYTvU1CgzeRlM70nwGv9JqpDsJALCPgv5dk4d4OEaF+SM1pV3Y7iFT7c9YGXj4DgMvh7ozlujB00T07b8+hDPQ7dIyfXmEl11H7n1Waj0s77rnaEw+4pth6RHFKAlzgwXepD0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780216298; c=relaxed/simple;
	bh=jmpMYdIAUQwMXnymSTHrAyeNBIsURcIx4i7V6hRSHI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r1+/RI1FCxbrhqHhw/7snAuQG+60Uvpls5i+ejyY4z6vcvOTvIbbsIvUYtDwXyWRY+ZlES31IIJyG8YPv/llpyLLF/MXWiB6wFBlKBjc/mI/iB/rD1grXHilC6SHdZqTDh/o8nzseop9CZFfX3WBcks40oYb61wB6HXsV9lqQ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duWQTJLs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duWQTJLs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9B71C4AF12;
	Sun, 31 May 2026 08:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780216297;
	bh=jmpMYdIAUQwMXnymSTHrAyeNBIsURcIx4i7V6hRSHI8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=duWQTJLszvUFRuP4DKW0q570AEkroKX0V/9FJxg5/EhlOU0LXKLnvDbaDRf5dJ+aC
	 5fpBJ+E62+V/v4zRMF1QrDTl0K5NptrGWGFojRcB+Ika8TdEej02KSCEQqWqPa9Jui
	 wjF72HW8efz1Y4e6PkoTHn8fUIp00xEIDGxkPdjs0Ia4cLWRWhQqY9uWbRzs825enB
	 TTTRpUxgrJE/MqFAg6zCN8NtdUYXOuRNKBxb3+sT+yLEGLOFpfAhBkXwB8EWz1KT8l
	 WjKGnTcFtwv/gcb2uFBPaYKfGcZ4ToP5d4I0Y8AgsBkYN/CHm34TyYBN5IJ1Ad4DRT
	 0uQVLitQMED0A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A240DCD5BD1;
	Sun, 31 May 2026 08:31:37 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 31 May 2026 09:30:49 +0100
Subject: [PATCH v15 06/12] iio: core: add decimal value formatting into
 64-bit value
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-adf41513-iio-driver-v15-6-da09adf1c0dd@analog.com>
References: <20260531-adf41513-iio-driver-v15-0-da09adf1c0dd@analog.com>
In-Reply-To: <20260531-adf41513-iio-driver-v15-0-da09adf1c0dd@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780216295; l=6182;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=QMpUYZEXYXwnvsDVpW1EnRH1hiYPiI4UJaERVqd0EzQ=;
 b=cYaHOwBBXOk3VeFNnOmCHCyW63QLaiH2HJteO9pZnyjztIpVKt+4Ck6XM7esiZZyw1cUWzuY0
 Rhbz9DtlUr2CTxgC4Tcyx48gaScOgVWUxH26kqd65U9FJfz/V0SpTyT
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
 drivers/iio/industrialio-core.c | 47 +++++++++++++++++++++++++++++++++--------
 include/linux/iio/types.h       | 30 ++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index bd6f4f9f4533..a88088cac641 100644
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
@@ -655,6 +655,7 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
 				  int size, const int *vals)
 {
 	int tmp0, tmp1;
+	int l = 0;
 	s64 tmp2;
 	bool scale_db = false;
 
@@ -698,7 +699,6 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
 	case IIO_VAL_INT_MULTIPLE:
 	{
 		int i;
-		int l = 0;
 
 		for (i = 0; i < size; ++i)
 			l += sysfs_emit_at(buf, offset + l, "%d ", vals[i]);
@@ -707,8 +707,25 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
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
@@ -978,6 +995,7 @@ static ssize_t iio_write_channel_info(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret, fract_mult = 100000;
+	int type, dec_scale = 0;
 	int integer, fract = 0;
 	long long integer64;
 	bool is_char = false;
@@ -988,9 +1006,11 @@ static ssize_t iio_write_channel_info(struct device *dev,
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
@@ -1006,12 +1026,19 @@ static ssize_t iio_write_channel_info(struct device *dev,
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
@@ -1020,12 +1047,14 @@ static ssize_t iio_write_channel_info(struct device *dev,
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
index 4e3099defc1d..a47a3d7500c9 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -7,6 +7,9 @@
 #ifndef _IIO_TYPES_H_
 #define _IIO_TYPES_H_
 
+#include <linux/types.h>
+#include <linux/wordpart.h>
+
 #include <uapi/linux/iio/types.h>
 
 enum iio_event_info {
@@ -34,6 +37,33 @@ enum iio_event_info {
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


