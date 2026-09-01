Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304BC39023C
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2026 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788259377; cv=none; b=t2eZcm6JJVTvsNA9llmsYBisZOtQsGJmGtkUNd/UGFOLI2FAIZXFYZxArepTioJkWH8vSRlF/mYiiU3ZNWtJOLj+fsDmPkkJpcb24vC1OqbHwniHNAwkhJkoxalEh4N8sF3cYQzDOaN0fMHIur1DL/Hi+1ampMm1WNTtPl+ouHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788259377; c=relaxed/simple;
	bh=xqoGEMIQVT1d3A9wTX3gMVQnA4z7jnDXvURpr+qYg4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OsPec9iUh0xrpcbo5jQSPsn2/Qfl3lqBTv2LngO/b/aVPFhygkwrGw1qJwlD6l4zgbZdYQRLu344bMEHdrbm/H/HeywWYeng1nq+hJcjBHGatXjL1MoBKtPFYVW7V8RjJNSLzRDk9YVVnI+KCHckgpltQMBmcQz4lktvwUsnyRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHeEs1S5; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHeEs1S5"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-499b2981a7bso52832565e9.3
        for <linux-iio@vger.kernel.org>; Tue, 01 Sep 2026 03:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788259374; x=1788864174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uu7ywtYgst/k9O0Fu+h9ViYiyjKPBkfjcMSBZusirJA=;
        b=WHeEs1S53BFKxj+IawgMhOw6aLTzVHi6qtpq99VYsDWMTqru/NV+sLbpSg81QnzAqV
         7jg1iSHyuCSWZRz87MqQxpBBxe8GEDR7s0DGh2QqrTxAPHZDOwW3xT9lAetg8xFxRL4M
         7hxM8HGrvHudE2b69WwPRbvgalSWkWJAy7uvjZa9bGmrge3W8iajtUaLrZYoBByCiR1V
         jCml8Plp39P3EfN+kXQenCDkxiHvckgNmnHR64zmQT2+Ppaf476L66SKZS64LTokhrYV
         FDOeEdosHiIlnGTmQunumgvh3r3Q/qZNcQWEFlgYUrK63+N305c48ODAn8HySTbRoq+z
         7S+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788259374; x=1788864174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uu7ywtYgst/k9O0Fu+h9ViYiyjKPBkfjcMSBZusirJA=;
        b=HajFOL5u9hSIFRc35b4qZGo/1za5QwGHooaKjFUkJBZC2EB2A7AOsh7iacuNFEhhql
         yDOQkkK+deOjBTEEoyNN4d0UHvSemc5gFfF27986v98NgU69e4ENh2LPxVT+rl+DzOgw
         3Gg2NKnDmFXLAaBepaNz3EB9azJCRa9DtBHm/lAS8tXyXr2cPlsz4hFYTnMIFzhz+nlw
         R3dtnfMqrY7p9etu2JJhh+VVxTl9wQ/DG19NHYTYRVvGqGphL+21vyd0c1IlvjIIAQSe
         AoGz4E6eUvAxl7NQdLDCv0IDswP2T9BIg3l/2gN1kL0zQ/RGGxxkL0btGqFdk8kGUeKR
         Cdgw==
X-Forwarded-Encrypted: i=1; AHgh+RrLAw/3eFVV1iDzuSKEsTOjw7FMf/0uLQoJ8F5+l6hCZ0pvOUPUqJObJ5Jc5jdVyEJXR4T9TsSPAIU=@vger.kernel.org
X-Gm-Message-State: AFuF++nXuAmZ7wHGjH5zVfdqLvkR3+yxsiuWLd0imJZy46oByeuskm6S
	OZmMpZ/XQm1heh62PUEVyE99tbfE+PweqzWBOQR4U2zX+iL4L09wa0XP
X-Gm-Gg: AR+sD111YRuOl8cryJsNoL+5WX+7iVXtEysBeB7sdOIgUT45e3EeZ2/Ih+9RfwwVCWw
	RLpB/Wd5/Oiht6w5GR9qCTM1Db0+Ow1kt3AWAWQ6P0QenWBKm50aTexGBcJUOdDu+qpG567vGjk
	NE1q8Bec7hnn3GTyo8mfgPFxPhatrfoKdBv7p+shXFqUomGyIYPTne9ius7V3ZzTwwGgutYD6Ww
	NZM9LZ8TFcnspAmR2QePsJmW3H7rkUWR5mh3IcN8+2Vc2RnzntLKc2Ak1h2eICJL+tnx77mMXh+
	NkRxl98WaSgGtSchYgySI0KLP06mtxadUs4FUDLJxrmxKheg6gADRmqGNf2/AGvAPCmQ6T37SmF
	UfNLotsrI6RUVTDFs/Sl1IGqFeG1epvjpxdM7lN9IdhYOeeg1O6rTIGLPkPa+VPfq6lT24A8+mP
	rMR+IpU4A1bfH0taT2POUsjnKuY0d8K8agCcbeLjRTGtM8sLsepJjXEt/Yz4tSK7yGKvQ3numaE
	Q==
X-Received: by 2002:a05:600c:3f19:b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-49cdc43d444mr144963275e9.6.1788259374119;
        Tue, 01 Sep 2026 03:42:54 -0700 (PDT)
Received: from localhost.localdomain ([196.235.159.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9267c369sm238972235e9.3.2026.09.01.03.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 03:42:53 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v4] iio: adc: ad4030: fix invalid oversampling_ratio validation
Date: Tue,  1 Sep 2026 11:42:43 +0100
Message-ID: <20260901104243.48732-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ad4030_set_avg_frame_len(), the logarithm is calculated before input
validation. Passing zero or negative values leads to an undefined result
from ilog2().

Validate that the input is strictly positive prior to computing its
logarithm to ensure only valid values are processed.

Fixes: 949abd1ca5a4 ("iio: adc: ad4030: add averaging support")
Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes in v4:
  - Reordered local variables to enforce strict reversed Christmas tree layout
  (per Andy Shevchenko).
  - Rephrased commit log in plain English without C-specific terms
  (per Andy Shevchenko).
  - Converted AI assistance note into a formal Assisted-by tag
  (per Andy Shevchenko).

Changes in v3:
  - Dropped the !is_power_of_2() check to preserve standard IIO attribute
   rounding behavior, per feedback from David Lechner and Jonathan Cameron.

Changes in v2:
  - Added note stating the issue was identified with assistance from
  Claude AI and verified manually.
  - Removed initialization of avg_log2 at declaration.

 drivers/iio/adc/ad4030.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 9c5f19321e3b..17b0ca7f1cce 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -746,14 +746,16 @@ static int ad4030_set_chan_calibbias(struct iio_dev *indio_dev,
 static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
 {
 	struct ad4030_state *st = iio_priv(dev);
-	unsigned int avg_log2 = ilog2(avg_val);
 	unsigned int last_avg_idx = ARRAY_SIZE(ad4030_average_modes) - 1;
+	unsigned int avg_log2;
 	int freq_hz;
 	int ret;
 
-	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
+	if (avg_val <= 0 || avg_val > ad4030_average_modes[last_avg_idx])
 		return -EINVAL;
 
+	avg_log2 = ilog2(avg_val);
+
 	if (st->offload_trigger) {
 		/*
 		 * The sample averaging and sampling frequency configurations
-- 
2.43.0

