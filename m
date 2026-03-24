Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7257F3D88E9
	for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342071; cv=none; b=Ep7zvmXlgjq/xFl01O4SA1bgcC2svuyrrZABoh5UOPDxZENTFVmNnaQbG4c0/VkZUOSFCaU8+jYIksGm7dXnCzd2UgYhoLs/AnjqkekYqEeMAAGrfUS9ZHJNBRDJwKru3MuA3NTuxfbcQUCJtkUPpNe/twGylU7whwPj2ULyyqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342071; c=relaxed/simple;
	bh=Pmx09FjUuabFWsJvX9ZIiyJWEPRXSi3I/1OkkdhbSUY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oCbvtdzSV1Ivhtg9lFKCQ9NsVULc7dPzPTvyJV7vFgeWCRMrYKktvm12kDbUd5fr7Wsd9BJ15nC65Y7TijAdk5vZNWwvdYzBnqZ6axPdCmojpBL1B5pvVRRuD5XBc8g382BtjMVCpmUMWQEq4pTx7GoaVF1MDY/FmQVyu2cwJ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LghlXToY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LghlXToY"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso32742615e9.3
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 01:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774342068; x=1774946868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r00Ss0X9VzFEuDRGE5q7OfOKcRugbWSqniqvg/LPyQ0=;
        b=LghlXToYcVJwwPS4uuhLR3fSgimoJ9WWjWJwWUHhL17gztjxEK0HOLPlUYT1N/aMTv
         cGg+jk3icATChIJtBznLZSukyIm4th66uMt3GloxJ5zOadCT4WGTU2WzlpfH4e7/I+sX
         joRjxM67/egRggWjemwcCGIWwQ2mQn1LhEXoK5bPeyvtv7QV8eGLprKZoO0rfa9SXswK
         aP1/L5iL3HqJyc7eQHxgiBdvYJJQLp1yf3HjFjXTHVPUg0HmdPSMi9yf1Awyu/aJmp7x
         R2nB8N7xDgrQDDobqnp+8qk+CTgv3wK5lWxoaGOUuoIy3oDRapa+VEjsqe5TMxN+d8t4
         NdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774342068; x=1774946868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r00Ss0X9VzFEuDRGE5q7OfOKcRugbWSqniqvg/LPyQ0=;
        b=RxPNz+UxsspRdjqCR3J7dHwckcUNe1txX/Q2ZFVn8eXeOf7g4J9C16kosLAR1cRypG
         bZpE0M1Ut+6Jk1jC1m4iKJxOJUUrAFdjF+8f5prOr3L/AGf3svBCPMC3yLAHzLgQDmz+
         ZlQTPEEbfo5W51W8DLybKtR/JY5qc2TWlaoHU4DSnhOqaEXxy9lmVTcrSjhWZsnPqJZv
         NPq37PTAlf6ubxrJBw/Xu4z9dAChuFviH81cO4Z54GaNyp3eGPyZfWdQqwnd/LpZRBBX
         pYOEyRuu4TOo1b8PFeatv/0y40VbY8GX8/iJnTsDWfkSg8H+ulf5ZWLE5KLSL1HbqLqJ
         sErw==
X-Forwarded-Encrypted: i=1; AJvYcCU+rm7+3IgEyu0KdFs626OS9JsgOX3mO2vmEPYvF5IA9FvSww/2aQF7rN8HKFASIWhwZkCqosImqSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnKn4MQZhr6rvH++uR8bncTt7nPq8GLVGdLXwDz/o2CVg0YfaS
	+YseZL4AP22qf5MK2jej5vjcIeYf4kmC1gOeg5R09nK/vvc87897FDtaKEsWj8lG660=
X-Gm-Gg: ATEYQzwdv9sJEyDgSpUsofMC7xJt4hvU1leQjR+My1OKiitO7LoCt7lrNCpwQRnGMuj
	wQvSIj7WMpBWhaKPMey0WHd+usqklffYYwumnLvC4tWPqzkJQRyZm6vf53w1++yk0Lmf73LoLLy
	nji/XjmBErgfp+FzZcNdaqtKbL7vFfkOS8DLkXGd3gwUhrgpobyKpl97//dO8xDmfMFwB+QSnNJ
	x6Gp74driahXdkpuYIIjoi33HhU2D3iFhX84h52tEXI1jqHbDD8FAZA1NL75wFvciCisq6TOuKC
	/7MV0vZK5MW9OQSd/MtkTxc07pfJtC6pq4uZO2MJs1YI7gdyeCIZWpGqT6EB/VGUl09ZmttuMkq
	b18zWfBSvt3M6TjnZxgeHmlhzB4r99/S6mSHaadd21rx/6eS95FpWj1f70R7JYu102ID+rwtI94
	1jvA==
X-Received: by 2002:a05:600c:5294:b0:486:fe46:b647 with SMTP id 5b1f17b1804b1-4870334cb27mr162699155e9.10.1774342067728;
        Tue, 24 Mar 2026 01:47:47 -0700 (PDT)
Received: from localhost ([151.43.230.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871174f2desm42738755e9.9.2026.03.24.01.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 01:47:47 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 3/6] iio: tools: Add support for floating-point types in buffer scan elements
Date: Tue, 24 Mar 2026 09:47:46 +0100
Message-Id: <20260324084746.653984-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260324084655.653781-1-flavra@baylibre.com>
References: <20260324084655.653781-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6732; i=flavra@baylibre.com; h=from:subject; bh=Pmx09FjUuabFWsJvX9ZIiyJWEPRXSi3I/1OkkdhbSUY=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpwk+yvAIzq2SkukP7iiVaZG3ChhyjyTILdbl1o IntpAUDUOuJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCacJPsgAKCRDt8TtzzpQ2 X+x3C/9jcXLhig2HmXyjJ4uTsWGddZHaV4l20UtvgR6RzulQHZ3Qo+DeA/LGvD5xibYz9YACxng f7czaBF+mdD5SOxB12FYKujod7WD8gCmp6U1O0NUvY21YkhrB36b1okQHvqsNTEzSn6hckmWbo4 vAzRG64eWtxIjJk2oITn+Mw9zg2tYjoRNA7UCpb+1/XbgXA4IxyLbz8O/4J6bx12IC57qwI//DX sBtvu4KReW4kegDK2fAPrflfWYEHzTRdHj5+yBmfgqc9bS5nPCNNWk1JMCpW2QhWvYH2S3xwBhR UPL7K57UNURVw+Dj0bOg/5g4Qb/8KyGfjd7gtzJYB/g84Wc4C/ZlyQt84Raa4/7YfnxhmHHwrlq sMbAOvmfcslYEBBrnWu4ZYHgFJ7ZRQ2e4KnYlp+y6JfxvCdg2xrb51+rIjdUHYn72z9xPU3Yyg9 cIUedYihR52VycF4dlN8OeXLmzfxM8SJD6GRhroOtGgBlX6WGBmOEOO9AFvlaTN95HC/U=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

A subsequent commit will add floating-point support to the ABI; enhance
the iio_generic_buffer tool to be able to parse this new data format.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 tools/iio/iio_generic_buffer.c | 70 ++++++++++++++++++++++++++++++----
 tools/iio/iio_utils.c          | 12 +++---
 tools/iio/iio_utils.h          |  4 +-
 3 files changed, 70 insertions(+), 16 deletions(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index bc82bb6a7a2a..000193612aad 100644
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
@@ -89,12 +90,19 @@ static void print1byte(uint8_t input, struct iio_channel_info *info)
 	 */
 	input >>= info->shift;
 	input &= info->mask;
-	if (info->is_signed) {
+	switch (info->format) {
+	case 's': {
 		int8_t val = (int8_t)(input << (8 - info->bits_used)) >>
 			     (8 - info->bits_used);
 		printf("%05f ", ((float)val + info->offset) * info->scale);
-	} else {
+		break;
+	}
+	case 'u':
 		printf("%05f ", ((float)input + info->offset) * info->scale);
+		break;
+	case 'f':
+		printf("<invalid 1-byte float> ");
+		break;
 	}
 }
 
@@ -112,12 +120,30 @@ static void print2byte(uint16_t input, struct iio_channel_info *info)
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
+#if defined(__FLT16_MAX__)
+		union {
+			uint16_t u;
+			_Float16 f;
+		} converter;
+
+		converter.u = input;
+		printf("%05f ", ((float)converter.f + info->offset) * info->scale);
+#else
+		printf("<unsupported 2-byte float> ");
+#endif
+		break;
+	}
 	}
 }
 
@@ -135,12 +161,26 @@ static void print4byte(uint32_t input, struct iio_channel_info *info)
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
 
@@ -158,7 +198,8 @@ static void print8byte(uint64_t input, struct iio_channel_info *info)
 	 */
 	input >>= info->shift;
 	input &= info->mask;
-	if (info->is_signed) {
+	switch (info->format) {
+	case 's': {
 		int64_t val = (int64_t)(input << (64 - info->bits_used)) >>
 			      (64 - info->bits_used);
 		/* special case for timestamp */
@@ -167,8 +208,21 @@ static void print8byte(uint64_t input, struct iio_channel_info *info)
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
index c5c5082cb24e..e274a0d8376b 100644
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
@@ -93,7 +93,7 @@ static int iioutils_get_type(unsigned int *is_signed, unsigned int *bytes,
 	int ret;
 	DIR *dp;
 	char *scan_el_dir, *builtname, *builtname_generic, *filename = 0;
-	char signchar, endianchar;
+	char formatchar, endianchar;
 	unsigned padint;
 	const struct dirent *ent;
 
@@ -140,7 +140,7 @@ static int iioutils_get_type(unsigned int *is_signed, unsigned int *bytes,
 			ret = fscanf(sysfsfp,
 				     "%ce:%c%u/%u>>%u",
 				     &endianchar,
-				     &signchar,
+				     &formatchar,
 				     bits_used,
 				     &padint, shift);
 			if (ret < 0) {
@@ -162,7 +162,7 @@ static int iioutils_get_type(unsigned int *is_signed, unsigned int *bytes,
 			else
 				*mask = (1ULL << *bits_used) - 1ULL;
 
-			*is_signed = (signchar == 's');
+			*format = formatchar;
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

