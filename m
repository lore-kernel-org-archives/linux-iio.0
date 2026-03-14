Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967B12D0C72
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773522765; cv=none; b=fgi8oHC2/lIoRByCVdhB+fCweiFHMWLe/XHv8GnjfEueNjFOXkCEwqj2ChkcpBYmMdvdAUA+Vri265DLgMWSH70GmMqSfKZ6a6kCeIh20G5pk/86bNjTURlAsFIowUaBwqTKSszgp/4I16aH0cczyKkl6HwjY9WXtDfoWztMswg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773522765; c=relaxed/simple;
	bh=UjIIYg2kVWpb/cG3eChFsyq18uKV8EkcjudkwaNjpAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mhTOJd4t6Rh4nsGyMpyeiD0z772Scxgx6bpTCC7zuftfRcSgOaKtzk79j3fqBF7Z5MGTgrqFTlj7yJZjsOIiuaPQWNIEP3rNuRtVcdLrojgi/Q2ljJyxCpKcESsmtcRxsIYveEaDvr1rTfvpDrwXgOXXoguDBZ1dkUsbWUCxgmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HU6WU26W; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HU6WU26W"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-67bac077116so1758093eaf.1
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 14:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773522761; x=1774127561; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ulzdKVlcsNl87tenyXgz5EvJuSO4615gLT3TGIxTUuk=;
        b=HU6WU26WfDEGX8rpdx0MsX597axYUPmXnTn4c1jcMFRW9aXh/dJaQyqTQWq+cwp+L1
         h7eioAV/DK9caBBXQx8MqOlCSg9EfaV2c0DGpavUCxKVsm+hz/S192kYdTQhj0d9LPk5
         v64Sg6kLnGxPt8gAdS3hahRu0e/FxWUgWkV/HriGBnVeDDiBWb5tJLhzYDmS06AJax/7
         HB+5YX5tliUPoDzfjaI/WorJ3FwpSBFUadBL8qYePL23+r2+/APJ7sQtHRIMH62mI5Xl
         +B6dgYQFdH2AmQaBpUTm5IudhfRyfSXww35pRb5azRLlGqix4adFjTd+466YxjVpZ5ec
         S8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773522761; x=1774127561;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulzdKVlcsNl87tenyXgz5EvJuSO4615gLT3TGIxTUuk=;
        b=ONb1S7Z9FEINlny6Yb60qV7r9skLpPqNaOfxrM0DztiFtuC6rrTRI0UCdBgyvz1SG5
         hU0M8MUwaSmVCuKJe28ocAO13mzD4h8NB2cS5r8VA4S8jg8ac3h9IzjETjyW4Lb+OW/U
         dVYGn4+drlQau46eWhQH9xIFlMJH3UiUSlFssdgkrwwbcoyDFjLRYO0MpiRl1nt2eyx+
         F9BRDst53z69nYXtD0EtMKnggZkJa5bfJhe+jnbGPJILdYoy+lJ5FwtLtpG0daC2DHYN
         Yp4CfIE1JlYU5oUO3qylGiHZiNLWesFdNqR7/m8lRBy2HxGbxh68zAd9tCDVaE0QJ5J/
         6tZA==
X-Forwarded-Encrypted: i=1; AJvYcCVSApiTsr86THcY1ka+BVZvto4KPTEzvD629ixbAWTA/k3C/LSgmKXdeLrAPxDcU0gDZoT3aTPJo/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm6p1Iahp1B4mXR59rlVo10lHqZ+JHp0R1BVEWYE0Z7N8cWjdf
	6fZHEsUb31F6qzGcvM7v6JywHTKm0TYoShl0Ly/MexT25Tf6dh5/k+EZcFsukQ7ZxSs=
X-Gm-Gg: ATEYQzxdXwM/l9UbNQrEpgzMfIEnEZ6VX9LkerWZJWLgXfYwLMBe4jN4hB8qKaVDdPH
	rN/p1nETxiCAtOVQaqAFyGDi50xZ0btmcq31kSSVmjCJvubMehNDjJiKeSDOhFrpYJ/5/3etWbr
	hv1Tw3+DIsKbiS9rXBoqV8i19XWpUGoCk33WeptiuUzdzNYyR44ZWMO+cybz2l3ZZ6ENDRkd7hU
	9uJKI/Yhe9vdOKMkqQKc4XszNpqReleB+5Jggmwty4zvAzMdXzYNSzYbVK5sikT6wCZR3M2OEB4
	v4s3LM61oO/UVhYz7sQBDVw7BPVc5vjAl4b5rPYveejQtF7j10LX2nqIAixlA5WcDLwzjwPnt5c
	vaQtcJAKkEHs6ouMVfNjDffmHSDAGZs9yD5GWv9FkH8AAs2VIY/O8vofvk8nZJgtyT5IRjLGDKQ
	ArzG+mN3/3ZfegaKw2Q2A1cZ1xyteS
X-Received: by 2002:a05:6820:1789:b0:67b:e1ef:7a11 with SMTP id 006d021491bc7-67be1ef7dc9mr4302914eaf.65.1773522761518;
        Sat, 14 Mar 2026 14:12:41 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:14a9:db6c:e65a:4287])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bc9336db1sm6822618eaf.14.2026.03.14.14.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 14:12:40 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 14 Mar 2026 16:12:24 -0500
Subject: [PATCH v2] iio: adc: ti-ads7950: use
 iio_push_to_buffers_with_ts_unaligned()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-iio-adc-ti-ads7950-declare-dma-buffer-v2-1-2087fc18b077@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOSwqDMBRFtyIZ95XE4CcddR/FQT4v9RU/JVGpi
 HtvtCvo6HLgcu7dWMRAGNkt21jAhSKNQ4L8kjHb6uGJQC4xy3lecskrIBpBOwsTpYiVKjg4tJ0
 OCK7XYGbvMYByRV4q73VtDEuud0BPn3Pn0fw4zuaFdjrkR6OlOI1hPY8s4uj9u7kIEFApIyRXU
 tbO341eOzIBr3bsWbPv+xduGQZ/7wAAAA==
X-Change-ID: 20260307-iio-adc-ti-ads7950-declare-dma-buffer-9d5269ffa8bb
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2895; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=UjIIYg2kVWpb/cG3eChFsyq18uKV8EkcjudkwaNjpAM=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBptc8/Z6hpyf9du13QWXT5GmO9KQ8fyMb36mujn
 VRQTTEoJciJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabXPPwAKCRDCzCAB/wGP
 wPq7B/wLRQi/AX0NzAnwyYWGZAaqgqT4Fs9RP9osU9BGPXBuKMi+NKgRzIkBOk1Q/KyvaUpH6IG
 oEl8SYnFroVXRT8nhqZqz/XurAc5z9U5CUA0tcSwkF9IzFJSxy7NaaTJB0n7n+/c1+UpfQhmUlA
 RKrPJF63AuNyEXhLzMzaWCvfj5jkIJtKg1oSa9TC4hLsX7d0A9uIwR0srwpJB4wRtki+TJ37W3o
 qtKzDY+G9kXxA4ApdyVUzF5W6TnpertqTdcmZr3A/X1kuaRN+RkT6Sc24gDtUez+2tlo46XTOzi
 Y9HhSeykRO2bgYLuQJ4Vw9Za2CsorKupVKXuXh5JMuIMc3KU
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use iio_push_to_buffers_with_ts_unaligned() to avoid unaligned access
when writing the timestamp in the rx_buf.

The previous implementation would have been fine on architectures that
support 4-byte alignment of 64-bit integers but could cause issues on
architectures that require 8-byte alignment.

Fixes: 902c4b2446d4 ("iio: adc: New driver for TI ADS7950 chips")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Since we were looking at this driver, I was going to convert this to use
IIO_DECLARE_DMA_BUFFER_WITH_TS() but then I noticed that we actually
have an unaligned access problem with the timestamp since we are
ignoring the first two elements in the rx_buf when pushing the data to
the buffer.

Unfortunately, this will cause a merge conflict with the series Dmitry
is working on. I don't think there is any rush to get this backported
since no one has reported a crash from unaligned access. Since fixes
should go before improvements, we could apply this to iio/togreg then
Dmitry can rebase his series on top of it.
---
Changes in v2:
- use sizeof(*st->rx_buf)
- Link to v1: https://patch.msgid.link/20260307-iio-adc-ti-ads7950-declare-dma-buffer-v1-1-79b1309338df@baylibre.com
---
 drivers/iio/adc/ti-ads7950.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index cdc624889559..418452aaca81 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -47,8 +47,6 @@
 #define TI_ADS7950_MAX_CHAN	16
 #define TI_ADS7950_NUM_GPIOS	4
 
-#define TI_ADS7950_TIMESTAMP_SIZE (sizeof(int64_t) / sizeof(__be16))
-
 /* val = value, dec = left shift, bits = number of bits of the mask */
 #define TI_ADS7950_EXTRACT(val, dec, bits) \
 	(((val) >> (dec)) & ((1 << (bits)) - 1))
@@ -105,8 +103,7 @@ struct ti_ads7950_state {
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
 	 */
-	u16 rx_buf[TI_ADS7950_MAX_CHAN + 2 + TI_ADS7950_TIMESTAMP_SIZE]
-		__aligned(IIO_DMA_MINALIGN);
+	u16 rx_buf[TI_ADS7950_MAX_CHAN + 2] __aligned(IIO_DMA_MINALIGN);
 	u16 tx_buf[TI_ADS7950_MAX_CHAN + 2];
 	u16 single_tx;
 	u16 single_rx;
@@ -313,8 +310,10 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf[2],
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts_unaligned(indio_dev, &st->rx_buf[2],
+					      sizeof(*st->rx_buf) *
+					      TI_ADS7950_MAX_CHAN,
+					      iio_get_time_ns(indio_dev));
 
 out:
 	mutex_unlock(&st->slock);

---
base-commit: 79a86a6cc3669416a21fef32d0767d39ba84b3aa
change-id: 20260307-iio-adc-ti-ads7950-declare-dma-buffer-9d5269ffa8bb

Best regards,
--  
David Lechner <dlechner@baylibre.com>

