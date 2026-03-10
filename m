Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69F53D091D
	for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 20:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173187; cv=none; b=bD+J6vhEqWtsJLH8FZEnx0sZ0SdSTmOVrFRYPtAmibRhmtyQNnRDOcQnsYYlIo0wA9sLwhqOjeiBCrN2S7eONn8S+0GZi30DrdEH4FRsUULHgRfiiVOdjfZO5Jt6ME+pY1MlINLa8uUdyWOUDYawfttBDk2hpq8upD3HHntCLnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173187; c=relaxed/simple;
	bh=T2a2fDI+lpfSbpuOM83tDaRUsM8l7LwGUzwFcjl1mvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RZdE/TJwSP7SvA4jd4yzDDJJUIV5f5uvfiWK1X7tuM7Fl+1Qy3gIUgnFqf9FBOdKOxx//7dF6tmayhUIKro3wgA2Y6kyQaHhAsjlfQVXaU4TA0MgFd4fKG2s5G/Q+gXB7vkpbqu1olmq8oF+qK78rOkvymsy+UdCJP+8ID74p7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EY1ZSqZV; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EY1ZSqZV"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-829ac8d56c5so3915658b3a.3
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 13:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773173186; x=1773777986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Cqt8CNmVHlobpg7w55yWqsOaWHWtGYPmo0BwNs9xzs=;
        b=EY1ZSqZVsBCAb8yoTv5Ro9tbbJ85U8wJ7rMaYZN6RFEv44YiQZ8MnnSeQBFiV4jjyL
         kFMmZf33bS1P+gg5/bs9gzWzsv6soRyNNHZr4yS9ZMpLCZCdzMqtfeC/Hgpy4X3fJUQN
         kdvCDyTvs8NmC+qUPElxzg3pkNLJ7wlnyARHjCvYaQcL95wb2bQQCeHJQR+V08I6ExGO
         BoOkC78d3OTqWbFvUjxbI2RlaV1qRHovEfgn7Xv/OdOFbStjruIodWOIypjZKsD65eM+
         wRQlxOsUQ56vcGsRLoqNF3S5ku1Q8JfNeqSWwM6e/CIBqWSxC+gpPK3mKIb84vE4/iVR
         IGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173186; x=1773777986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Cqt8CNmVHlobpg7w55yWqsOaWHWtGYPmo0BwNs9xzs=;
        b=W0SPhe4CMlFPN7tHNEqRMP5SaEteIU9yXNqqx2VywhdRnGDIk8mirQ9SY/dzyfnnzf
         76C391thA7EOltZvOZu3cfPNGqubFc8t16QdI5HYvjRdmgqI4JCVn1FcMP1l7+zsg5nI
         gs09VcV9eAoksKZxjJjcI4CZZz8C/N0DkmQupuwXuOjMMlqIeqiRKczSYjs0gooEH+B6
         Ndu05LM7Yv60duf4itDqXuJIWYx+u02CPyySFkFYmGw1L/q3FOZDaAOhywMzmVXEeDPr
         Xx35Hmn8Aj6rz0wVSMMdVrp6hOqZk0m0IyjCZOTGRV9xTCg0G8ybbhkGt7PbfODOXoxA
         DIGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWXtvPC49mJzMS2fOdb6Ql3M9V+wGmawpeloPqDb9f9bkKLS7YsD/U0P2wT8oNJPDCCKV5JO1Hla4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHYhUnVPLXtYMhvbl1T2IWR/N1n+4QZ5HWKdgeD/JN+N2nPEDn
	BIGWwwtFTMkcAqnsjfO5BkqssX/Jfjz7EP0v0bbUunqOpu26y4ZwAnNN
X-Gm-Gg: ATEYQzw23yquoa+Iy6+HoS9Ut+5SXeLh9hSG35pPldaTp0m/Iq12KSnu+PuMw/ymRGE
	8MJ8qgSE0rhGxP5d4vPzWxRWECdxn2WtEIkROXbdCHqjvTnh0nQpxi5PrMyylzoz9eZWXM7SY9x
	2oZjJiibYrgP4ujIX8B8R+ZYb4MpLe9RWS5pdCdL0lLZ/b4XA99nfUuvbNdT0Qq1Gtu8eW96DzW
	tb6XgFnDqqQJfb7ytsyHCu2wCEKN9YoblZtGZSZUry0lQx0A68OBtXrMihG32IiP52busV3jydQ
	dQvnBQTXgDQwULIrHmQLHLN1MDo2jih0g9xobnAIOx+/SfWF0OsQsZZh3Vp9dTNX89Te2HVAV3x
	TQIxA5o3ds7It7Plg6WjUOanJTirljIxqUeOJ7QI9/yyt72RdC6ay9KjaVxbghG8zS4JQ1cPFeB
	J0Lzo2WczSaVOafVW6BMXnGXU1qnXf81//+VCN2AXBR6lP7PFn
X-Received: by 2002:a05:6a00:13a5:b0:824:374a:1424 with SMTP id d2e1a72fcca58-829f71b3f03mr122810b3a.58.1773173186006;
        Tue, 10 Mar 2026 13:06:26 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc2d0asm101660b3a.13.2026.03.10.13.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:06:25 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org,
	m.tretter@pengutronix.de,
	mchehab@kernel.org,
	p.zabel@pengutronix.de,
	tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com,
	yunfei.dong@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	johan@kernel.org,
	elder@kernel.org,
	gregkh@linuxfoundation.org,
	pure.logic@nexus-software.ie
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	kernel@pengutronix.de,
	kees@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz,
	marcelo.schmitt1@gmail.com,
	maudspierings@gocontroll.com,
	hverkuil+cisco@kernel.org,
	ribalda@chromium.org,
	straube.linux@gmail.com,
	dan.carpenter@linaro.org,
	lukagejak5@gmail.com,
	ethantidmore06@gmail.com,
	samasth.norway.ananda@oracle.com,
	karanja99erick@gmail.com,
	s9430939@naver.com,
	tglx@kernel.org,
	mingo@kernel.org,
	sun.jian.kdev@gmail.com,
	weibu@redadmin.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	sanjayembeddedse@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH 5/7] media: chips-media: coda: simplify cleanup using __free
Date: Wed, 11 Mar 2026 01:35:11 +0530
Message-Id: <20260310200513.2162018-6-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310200513.2162018-1-sanjayembedded@gmail.com>
References: <20260310200513.2162018-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Replace manual cleanup logic with __free attribute from cleanup.h. This
removes explicit kfree() calls and simplifies the error handling paths.

No functional change intended for kmalloc()/kzalloc_obj().

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 .../platform/chips-media/coda/coda-bit.c      |  4 +-
 .../platform/chips-media/coda/coda-jpeg.c     | 39 +++++++------------
 2 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/media/platform/chips-media/coda/coda-bit.c b/drivers/media/platform/chips-media/coda/coda-bit.c
index b0559303c40f..958e245d0698 100644
--- a/drivers/media/platform/chips-media/coda/coda-bit.c
+++ b/drivers/media/platform/chips-media/coda/coda-bit.c
@@ -183,19 +183,17 @@ static void coda_kfifo_sync_to_device_write(struct coda_ctx *ctx)
 
 static int coda_h264_bitstream_pad(struct coda_ctx *ctx, u32 size)
 {
-	unsigned char *buf;
 	u32 n;
 
 	if (size < 6)
 		size = 6;
 
-	buf = kmalloc(size, GFP_KERNEL);
+	unsigned char *buf __free(kfree) = kmalloc(size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
 	coda_h264_filler_nal(size, buf);
 	n = kfifo_in(&ctx->bitstream_fifo, buf, size);
-	kfree(buf);
 
 	return (n < size) ? -ENOSPC : 0;
 }
diff --git a/drivers/media/platform/chips-media/coda/coda-jpeg.c b/drivers/media/platform/chips-media/coda/coda-jpeg.c
index 835225383aa1..11f2800014e5 100644
--- a/drivers/media/platform/chips-media/coda/coda-jpeg.c
+++ b/drivers/media/platform/chips-media/coda/coda-jpeg.c
@@ -584,16 +584,15 @@ static int coda9_jpeg_gen_enc_huff_tab(struct coda_ctx *ctx, int tab_num,
 {
 	int i, j, k, lastk, si, code, maxsymbol;
 	const u8 *bits, *huffval;
-	struct {
-		int size[256];
-		int code[256];
-	} *huff;
 	static const unsigned char *huff_tabs[4] = {
 		luma_dc, luma_ac, chroma_dc, chroma_ac,
 	};
 	int ret = -EINVAL;
 
-	huff = kzalloc_obj(*huff);
+	struct {
+		int size[256];
+		int code[256];
+	} *huff __free(kfree) = kzalloc_obj(*huff);
 	if (!huff)
 		return -ENOMEM;
 
@@ -607,7 +606,7 @@ static int coda9_jpeg_gen_enc_huff_tab(struct coda_ctx *ctx, int tab_num,
 	for (i = 1; i <= 16; i++) {
 		j = bits[i - 1];
 		if (k + j > maxsymbol)
-			goto out;
+			return ret;
 		while (j--)
 			huff->size[k++] = i;
 	}
@@ -623,7 +622,7 @@ static int coda9_jpeg_gen_enc_huff_tab(struct coda_ctx *ctx, int tab_num,
 			code++;
 		}
 		if (code >= (1 << si))
-			goto out;
+			return ret;
 		code <<= 1;
 		si++;
 	}
@@ -632,15 +631,12 @@ static int coda9_jpeg_gen_enc_huff_tab(struct coda_ctx *ctx, int tab_num,
 	for (k = 0; k < lastk; k++) {
 		i = huffval[k];
 		if (i >= maxsymbol || ehufsi[i])
-			goto out;
+			return ret;
 		ehufco[i] = huff->code[k];
 		ehufsi[i] = huff->size[k];
 	}
 
-	ret = 0;
-out:
-	kfree(huff);
-	return ret;
+	return 0;
 }
 
 #define DC_TABLE_INDEX0		    0
@@ -715,15 +711,14 @@ static int coda9_jpeg_gen_dec_huff_tab(struct coda_ctx *ctx, int tab_num)
 
 static int coda9_jpeg_load_huff_tab(struct coda_ctx *ctx)
 {
-	struct {
-		int size[4][256];
-		int code[4][256];
-	} *huff;
 	u32 *huff_data;
 	int i, j;
 	int ret;
 
-	huff = kzalloc_obj(*huff);
+	struct {
+		int size[4][256];
+		int code[4][256];
+	} *huff __free(kfree) = kzalloc_obj(*huff);
 	if (!huff)
 		return -ENOMEM;
 
@@ -732,7 +727,7 @@ static int coda9_jpeg_load_huff_tab(struct coda_ctx *ctx)
 		ret = coda9_jpeg_gen_enc_huff_tab(ctx, i, huff->size[i],
 						  huff->code[i]);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	if (!ctx->params.jpeg_huff_data) {
@@ -740,8 +735,7 @@ static int coda9_jpeg_load_huff_tab(struct coda_ctx *ctx)
 			kzalloc(sizeof(u32) * CODA9_JPEG_ENC_HUFF_DATA_SIZE,
 				GFP_KERNEL);
 		if (!ctx->params.jpeg_huff_data) {
-			ret = -ENOMEM;
-			goto out;
+			return -ENOMEM;
 		}
 	}
 	huff_data = ctx->params.jpeg_huff_data;
@@ -765,10 +759,7 @@ static int coda9_jpeg_load_huff_tab(struct coda_ctx *ctx)
 		}
 	}
 
-	ret = 0;
-out:
-	kfree(huff);
-	return ret;
+	return 0;
 }
 
 static void coda9_jpeg_write_huff_tab(struct coda_ctx *ctx)
-- 
2.34.1

