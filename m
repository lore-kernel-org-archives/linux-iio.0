Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09973890E3
	for <linux-iio@vger.kernel.org>; Wed,  4 Mar 2026 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611615; cv=none; b=NoGXpiAV0bKX42Hsc1j5xrCtJG3d156F1lCV3+TvRlEkR9xShpp0c2eiVcJsQghcSUS5kbYVuLgeVwF3HqYcyuS1gVUL/v14p+6AjYQ/+iCr9U8s7kHVrGd60fnoA7Ke5pdllzJSAkmxWWsPted/4nrnvyZcnRkmTqLxS/S0sWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611615; c=relaxed/simple;
	bh=+VTQz46EOKW2Um5JmqDbjWtJ4+tNkrLXbwXC9v6BvGc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z+H1sfQKi+rt3Zx8Dhsl6DcJECL7oGebOEi4qf6AzAGdtE2pLOQoEUh7X2jXmS6JqCqPUarb1b+v8f+2HFjff2X5NsySUGn1yujnlNz0GKvshM/agalWU+wUCSJybk56ounVYau9RUMvzUZ9EytfSGTaI6EeGkB3oL87JZpRpdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RDi/GzrL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RDi/GzrL"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48336a6e932so40077235e9.3
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2026 00:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772611612; x=1773216412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+TMotMzaSW4Oh+VOEFs9Z8B+kUyDiiMOR5H6kPqUxcM=;
        b=RDi/GzrLJlAAOsPznAFCKpS0arKPn4uLArwLYj/oFLqbShu0Qp4wyf+fwVw9lbCc3I
         3a7zeJJb1RKnWZc7WtzIkzpCfde8MI46PA9DetI7bsOjzydJW0KsjxZz08tMAw9IrZxv
         sxoElF0TTT+JKZA5FB5RdunrkdLbKTw+O9jOPlO7YO14J942cv3UBDEqssfgbPKBL8lq
         R3HZLWSoarjda77m2zby/yIDIhR7kVhZIOVsg7AbbKAlFiqhGxAPZmN6DgJQXkvmtWdJ
         vNby1QCxqd8m4/AI5vJsGpxufHMb8eYdtbUoITtDbcfnZ1mLtHxBB0w1eiJuCMRiOPcq
         qOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772611612; x=1773216412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+TMotMzaSW4Oh+VOEFs9Z8B+kUyDiiMOR5H6kPqUxcM=;
        b=gca8T0v44CuvxCS04/Y/VojLR23ZsHO27ndrnKdSt8VqJbkDfAtBJvWOf93U9EeY+v
         w1kVAS8ytQJkIuGOVxt0YtxSPBNThQ+n1j3aNvrR08Ss1zX+g9006yUKf/5Ht9wKkyt2
         pMzlOWlKlbIcuPQ4taNzYf7rhaMsCLGphrfpN1zGLHUumaEScMii3dzUZlzwcSjJ/IcG
         sobPGQo1veMoT4gow8L9TusLaxFTk+Tk04C1kmLRRQteMxQu+WXcF0OPuUCFDMcvGNxV
         ZNgH8jCxApUIM9H7Q3R2AgANC1TlKTRMEhnYbsMfTQlSCBmOfl4nJZ5whLwDKDQk8ui/
         VoZg==
X-Forwarded-Encrypted: i=1; AJvYcCVyjBbQZTrZBh/VKzPKHFjtNk2o1lc7nEz/sd+oDpvAeiXP95Xf0jcPVzpIbflbpcf9QJuLHNhOo4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu89PGrySlzafLK6zdzvZlstZv964nnmRXEk4gQT/ryWNfHirw
	9h9YIwCshg2+l6XES/VblSwNX7lKMohpx+y8CCOkt5io4xLthm4OHKevCJi4e75InJIcFTgFljt
	+7QPFQIM=
X-Gm-Gg: ATEYQzzBLh9A2LtglibGfffI81zlcgnhD5YK3oq+aE8OYqUuUonU2vHqOK1iDWJQJfY
	Kf0z8I0o4kVb3jfkWkRHaSotTyseaS4ZRZKG0yHgQFPO2V03cY1NPJBMRtI2aRInMPEVQOcX+wg
	qgKrZ32XRrPTbJVrHZHu8UDLo4z4s6Lj6yQEuCcAio2E1XOJvQ0x5UiI2+t6t6QuM+zdxET5D0y
	sLyQt0RgefN3wvEQi8+3FAXii86zEH5NCayBo7HRVKvDba8VUdscDtROZqTeCeRerpn4fcs3wQc
	uMyvyEsoh5CouvUxJO7uCuvD4Rec/cAwXI0tJdrc6BwvILeh2TLBoDAGP7aNkt5/luZ8kWBPYZe
	8AX1LwnjOa69CJ2MF30zuxL56jICCoPiK3l2/TbWg7Hi5zCMnOJ1A+QjcMbjuPlEIOh44
X-Received: by 2002:a05:600c:6305:b0:483:6de6:37ad with SMTP id 5b1f17b1804b1-485198c0f13mr15807855e9.34.1772611612150;
        Wed, 04 Mar 2026 00:06:52 -0800 (PST)
Received: from localhost ([151.19.177.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851889322bsm30526075e9.13.2026.03.04.00.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:06:51 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/6] iio: tools: Add support for floating-point numbers in buffer scan elements
Date: Wed,  4 Mar 2026 09:06:50 +0100
Message-Id: <20260304080650.2844401-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260304080519.2844101-1-flavra@baylibre.com>
References: <20260304080519.2844101-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5677; i=flavra@baylibre.com; h=from:subject; bh=+VTQz46EOKW2Um5JmqDbjWtJ4+tNkrLXbwXC9v6BvGc=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpp+gapVKFxU+E52FqXhhcoV8BK2/kFJ0s/Abse cqUilczh26JAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaafoGgAKCRDt8TtzzpQ2 X/gJC/45XxRJat2G5uf63pyQ+kI8sVYHxXkMELVPYYGl5QzuuRVSpMGT5+N7/Vv8rYpvbtUVhzY fJEf3EJjgfmAnBJp5VTHyY6Yc2/7Q6dzz9elIpjT7x5ycihSgh4XM+FNP7CxiYVVNw+35UY4y1w zxS7WvxQfZd9xjZEGH6dc3mL8Wjz+oY2DFI0i2TnCPEpBSxuuDxkUXzc4LPtRGAljSzEHGiyFFK qLb2N2o66kzEHGaUOuYUdYd+bj/WRXZl+AQWxa7qmYQszuqVsiNVYcYVAdSJ2bvDU96UtAzGEUU TRCeOgmFbJBomwh/rLdVA9E8b93n9dVDP2vgdoQUwdaN0nfPNLdfY41JfrHUNKn3vGEzhR644cd fvahuTD3YwJyAGE83heWI1w506fBlialdRvu+dH8i7x/Oa8CQB75p9rN4GHjWhkThpvZuKn2Lwb XwqPPaWwcwUyF4d2wVXNpU+VHq1kB/3WT9Tr2dfrNB/+fqkY/K+2SCoWw9qZZYSvIDlok=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

A subsequent commit will add floating-point support to the ABI; enhance
the iio_generic_buffer tool to be able to parse this new data format.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 tools/iio/iio_generic_buffer.c | 56 +++++++++++++++++++++++++++++-----
 tools/iio/iio_utils.c          |  8 ++---
 tools/iio/iio_utils.h          |  4 +--
 3 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index bc82bb6a7a2a..39c13b9ad20b 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -89,7 +89,7 @@ static void print1byte(uint8_t input, struct iio_channel_info *info)
 	 */
 	input >>= info->shift;
 	input &= info->mask;
-	if (info->is_signed) {
+	if (info->format == 's') {
 		int8_t val = (int8_t)(input << (8 - info->bits_used)) >>
 			     (8 - info->bits_used);
 		printf("%05f ", ((float)val + info->offset) * info->scale);
@@ -112,12 +112,26 @@ static void print2byte(uint16_t input, struct iio_channel_info *info)
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
+	case 'f': {
+		union {
+			uint16_t u;
+			__fp16 f;
+		} converter;
+
+		converter.u = input;
+		printf("%05f ", ((float)converter.f + info->offset) * info->scale);
+		break;
+	}
 	}
 }
 
@@ -135,12 +149,26 @@ static void print4byte(uint32_t input, struct iio_channel_info *info)
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
 
@@ -158,7 +186,8 @@ static void print8byte(uint64_t input, struct iio_channel_info *info)
 	 */
 	input >>= info->shift;
 	input &= info->mask;
-	if (info->is_signed) {
+	switch (info->format) {
+	case 's': {
 		int64_t val = (int64_t)(input << (64 - info->bits_used)) >>
 			      (64 - info->bits_used);
 		/* special case for timestamp */
@@ -167,8 +196,21 @@ static void print8byte(uint64_t input, struct iio_channel_info *info)
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
index c5c5082cb24e..0643a943b2ad 100644
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
+static int iioutils_get_type(unsigned int *format, unsigned int *bytes,
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
index 663c94a6c705..e09116af194b 100644
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
+	unsigned format;
 	unsigned location;
 };
 
-- 
2.39.5

