Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CBE3E867C
	for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759853; cv=none; b=ESVqg7kYHCGBn2SINN/xl8hrsTsOCBMfnyASoh/g6pK9wQbi+oCDbyMpwQieoFppid3d2pndNM6gc6eWSJngys1Z9QCrCJDLLLiN8igWznRaenadbMctl+WcQ/tnXOA42mSJ0Wt0yc0iTSy9tq5q7RSBbH6+Ukoo+KLNSFmyM+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759853; c=relaxed/simple;
	bh=6a+Xn6NnG/8MprGOzF86J6ycUeL5AAW7PxS2qczBlu4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ShnXu3NzXN+ysJRFT+HWts1EJuJaWa8vFBwS77Hsr4jV+sn5+pl//TrytdRa4F309+RY9EIZy6L9gMobfFMQseY0/mGlWmnnHrpLeW5aNRAEZHz4CYfdUJH2YwNQ9yhU01G9rOh6RmLNDr9wDUNtoqSg6ns9cP7kp5mzv13aJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NHy1q47L; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NHy1q47L"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a126c8aab9so7993032e87.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 08:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773759850; x=1774364650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r21/87fWkstXATGZU1YjKqhkHTuYYucKq7beo3fBdD4=;
        b=NHy1q47Lv80XssXv1bXZ1Q+gSs4yKeRe/jL08uTjUujnDq3V4fulTcQMoll1PWmHxm
         GG4fHbeuFhXHtBqBlNxsHALx9Aw9Y1wPHQV8OkpkeYfAtL4xR+hrZJ9XJM/UVpXu4Mlu
         SavJw+6/CYwG9kE2H/DPI0vY1TBRIDwgQXmMedwOehPlwianmufZkZj6YAEYb8mE01fs
         c6QrFDUxAb1wnw4wJyW+4v5NQe/tfI0o9faw4kiG3nHqehpZ3NS7nPHca8i65SZKF5G6
         NOJSgqnJLCuPvTn7EI9mZLi9zzA6ahCZzwRiycwxlWwOD6GVfjjAxcsv9cU4JmI9eIU3
         /+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773759850; x=1774364650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r21/87fWkstXATGZU1YjKqhkHTuYYucKq7beo3fBdD4=;
        b=RTvGtNpkAW9XVPcBAlOWS4NzgfVYVx2qHDjn5fHqr8ogDNjrxnNBXhg+AfpLQK525C
         KyN3z4/5HIYfy+Tf+dTPKBmzeTh+I0Q9l3oTXZxrHiI+G4gRJHcFomg+9lVquR8Sy0Tp
         DmhrZUI1vHm32XULO+jy/aUuTpBisfZGVl3/XpkLxgkslCKZ+tmgDhs9wfSc87Uc9O+M
         nyVSInlyN7UhipczTm3lrtRz5MG96dOr41VIRFQw+xz/0P3uKhrVhEdpDYPTAgNjOp6b
         T+dWR9AwpYPpWr6M3PBdyibdQxAEgr8Avv8gedyAa4nDzKowDl18NioexU8OHSEb/DEE
         3sDA==
X-Forwarded-Encrypted: i=1; AJvYcCV7eMv3HeBGHdxSkvIuSKyjTUpYnfaAP7pFzdrtEv6rZUtNRBFmL1dYN3hrTUwUYnbLWnPLQwIqrEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlBIpJMFu2ECmKaxR19AU71T0RimjeRjdaXep4/VY4SxQS0W1x
	6wzRZmrm2+iLuz+TrJJ/EPc0kICysbPDmMYFQTtDtbUmT5sUsJFVsczxkCnMhemZzxQ=
X-Gm-Gg: ATEYQzx0IDiMsH2n5GDUkxGjy1dCeEqmhKfwrM3q1lDhw8twwMPyM19Go6aPH5tgj4z
	jI7ArMtfue6ceifuPvnERZDwpxbauoLYDsJ+0uIOeXykAHHcFkhyWEtdoFh7tr2QmFZBvCRaVdi
	PJ+UVyfD+mQE30bmD/lF7s7Jd9icSkfGhvL8zW+8Vq+q2wAzrnd4SRUDFVjbz5VyveKsSif5k8r
	qDKQkLGqJ3zsjAgo3TbBuRXN8q4WuGkz0WHVLVDDI5rKFiX6Omapk7cxiVS0LrMMPIT5NJwKgYk
	tVYY645KcGn5dKBgR/8d7WRvjA1YAm+UjvhNFjwM+wp5vWy6ccycuGH2CLsgAE0U1Kbzh60ESYY
	6m0XPivV+2eoXguD3eCD+k2rD8i99wwuroilrgYTh9fq//Ow7a0obnPXfp9uNpBHasfx31Q==
X-Received: by 2002:ac2:4e83:0:b0:5a1:4473:bb44 with SMTP id 2adb3069b0e04-5a162b12580mr4573766e87.33.1773759848791;
        Tue, 17 Mar 2026 08:04:08 -0700 (PDT)
Received: from localhost ([151.37.101.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51852097sm104795f8f.9.2026.03.17.08.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 08:04:08 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/6] iio: tools: Add support for floating-point types in buffer scan elements
Date: Tue, 17 Mar 2026 16:04:08 +0100
Message-Id: <20260317150408.3878335-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260317150316.3878107-1-flavra@baylibre.com>
References: <20260317150316.3878107-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5878; i=flavra@baylibre.com; h=from:subject; bh=6a+Xn6NnG/8MprGOzF86J6ycUeL5AAW7PxS2qczBlu4=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpuW1ngtBo1B9Hy5EL0X1iDU+Zh8q1yasMlCqGN +ghrVMIeciJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCabltZwAKCRDt8TtzzpQ2 X75jDACKVpDjf9TWI33WXpoWG71eq4jtbJ4CtB4pAPmc+kqfdWtIMIatKtFsf4WS9cljpWgWPPt 3pckJjP1KYEOpQnmKue1LVNjOGb6vOGJ2CrHgKpWxnSXw0BVmgTPN6pLeaTpoENNZFIbYeCXO44 iz9iJddl2wN8NnV8SaR2RjKr+dlVZH74Pytza2hKmkF4zQuXuKmANcqmhKC2lEk2X9cRcQMr8Dw 5AEHykS18AAmMDLHniMLhqnbfdsi71WKR4GczJjDvEGTxcFZl7brToMPKT2/Jb/V7GvL1i0thqI tRpV689r0RdqUkZ4tFFzxaNUT455z5wQ+XkC48SKtW53alKZk0U7rhQ+Rv4BRLK7H9ntxoMlUIj FRtwlaLEEec9DOnOQEUxxrf6E1oCgaZYMP/WCp9RORG7Phd1JugMjYTJeImpQRZAzJyH83RQrpp xINDlHb1Jklj9t6CqJ4Wbg9JSyoAKeSz/TVRLkVLfpZwIhVJTZmkt3989yMOe7MRltIXk=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

A subsequent commit will add floating-point support to the ABI; enhance
the iio_generic_buffer tool to be able to parse this new data format.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 tools/iio/iio_generic_buffer.c | 59 ++++++++++++++++++++++++++++++----
 tools/iio/iio_utils.c          |  8 ++---
 tools/iio/iio_utils.h          |  4 +--
 3 files changed, 58 insertions(+), 13 deletions(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index bc82bb6a7a2a..a21552c2b190 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -26,6 +26,7 @@
 #include <string.h>
 #include <poll.h>
 #include <endian.h>
+#include <float.h>
 #include <getopt.h>
 #include <inttypes.h>
 #include <stdbool.h>
@@ -89,7 +90,7 @@ static void print1byte(uint8_t input, struct iio_channel_info *info)
 	 */
 	input >>= info->shift;
 	input &= info->mask;
-	if (info->is_signed) {
+	if (info->format == 's') {
 		int8_t val = (int8_t)(input << (8 - info->bits_used)) >>
 			     (8 - info->bits_used);
 		printf("%05f ", ((float)val + info->offset) * info->scale);
@@ -112,12 +113,28 @@ static void print2byte(uint16_t input, struct iio_channel_info *info)
 	 */
 	input >>= info->shift;
 	input &= info->mask;
-	if (info->is_signed) {
+	switch (info->format) {
+	case 's': {
 		int16_t val = (int16_t)(input << (16 - info->bits_used)) >>
 			      (16 - info->bits_used);
 		printf("%05f ", ((float)val + info->offset) * info->scale);
-	} else {
+		break;
+	}
+	case 'u':
 		printf("%05f ", ((float)input + info->offset) * info->scale);
+		break;
+#if defined(__FLT16_MAX__)
+	case 'f': {
+		union {
+			uint16_t u;
+			_Float16 f;
+		} converter;
+
+		converter.u = input;
+		printf("%05f ", ((float)converter.f + info->offset) * info->scale);
+		break;
+	}
+#endif
 	}
 }
 
@@ -135,12 +152,26 @@ static void print4byte(uint32_t input, struct iio_channel_info *info)
 	 */
 	input >>= info->shift;
 	input &= info->mask;
-	if (info->is_signed) {
+	switch (info->format) {
+	case 's': {
 		int32_t val = (int32_t)(input << (32 - info->bits_used)) >>
 			      (32 - info->bits_used);
 		printf("%05f ", ((float)val + info->offset) * info->scale);
-	} else {
+		break;
+	}
+	case 'u':
 		printf("%05f ", ((float)input + info->offset) * info->scale);
+		break;
+	case 'f': {
+		union {
+			uint32_t u;
+			float f;
+		} converter;
+
+		converter.u = input;
+		printf("%05f ", (converter.f + info->offset) * info->scale);
+		break;
+	}
 	}
 }
 
@@ -158,7 +189,8 @@ static void print8byte(uint64_t input, struct iio_channel_info *info)
 	 */
 	input >>= info->shift;
 	input &= info->mask;
-	if (info->is_signed) {
+	switch (info->format) {
+	case 's': {
 		int64_t val = (int64_t)(input << (64 - info->bits_used)) >>
 			      (64 - info->bits_used);
 		/* special case for timestamp */
@@ -167,8 +199,21 @@ static void print8byte(uint64_t input, struct iio_channel_info *info)
 		else
 			printf("%05f ",
 			       ((float)val + info->offset) * info->scale);
-	} else {
+		break;
+	}
+	case 'u':
 		printf("%05f ", ((float)input + info->offset) * info->scale);
+		break;
+	case 'f': {
+		union {
+			uint64_t u;
+			double f;
+		} converter;
+
+		converter.u = input;
+		printf("%05f ", (converter.f + info->offset) * info->scale);
+		break;
+	}
 	}
 }
 
diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index c5c5082cb24e..f1d58db69942 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -70,7 +70,7 @@ int iioutils_break_up_name(const char *full_name, char **generic_name)
 
 /**
  * iioutils_get_type() - find and process _type attribute data
- * @is_signed: output whether channel is signed
+ * @format: output channel format
  * @bytes: output how many bytes the channel storage occupies
  * @bits_used: output number of valid bits of data
  * @shift: output amount of bits to shift right data before applying bit mask
@@ -83,7 +83,7 @@ int iioutils_break_up_name(const char *full_name, char **generic_name)
  *
  * Returns a value >= 0 on success, otherwise a negative error code.
  **/
-static int iioutils_get_type(unsigned int *is_signed, unsigned int *bytes,
+static int iioutils_get_type(char *format, unsigned int *bytes,
 			     unsigned int *bits_used, unsigned int *shift,
 			     uint64_t *mask, unsigned int *be,
 			     const char *device_dir, int buffer_idx,
@@ -162,7 +162,7 @@ static int iioutils_get_type(unsigned int *is_signed, unsigned int *bytes,
 			else
 				*mask = (1ULL << *bits_used) - 1ULL;
 
-			*is_signed = (signchar == 's');
+			*format = signchar;
 			if (fclose(sysfsfp)) {
 				ret = -errno;
 				fprintf(stderr, "Failed to close %s\n",
@@ -487,7 +487,7 @@ int build_channel_array(const char *device_dir, int buffer_idx,
 			if ((ret < 0) && (ret != -ENOENT))
 				goto error_cleanup_array;
 
-			ret = iioutils_get_type(&current->is_signed,
+			ret = iioutils_get_type(&current->format,
 						&current->bytes,
 						&current->bits_used,
 						&current->shift,
diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
index 663c94a6c705..8c72f002d050 100644
--- a/tools/iio/iio_utils.h
+++ b/tools/iio/iio_utils.h
@@ -32,7 +32,7 @@ extern const char *iio_dir;
  * @shift: amount of bits to shift right data before applying bit mask
  * @mask: a bit mask for the raw output
  * @be: flag if data is big endian
- * @is_signed: is the raw value stored signed
+ * @format: format of the raw value
  * @location: data offset for this channel inside the buffer (in bytes)
  **/
 struct iio_channel_info {
@@ -46,7 +46,7 @@ struct iio_channel_info {
 	unsigned shift;
 	uint64_t mask;
 	unsigned be;
-	unsigned is_signed;
+	char format;
 	unsigned location;
 };
 
-- 
2.39.5

