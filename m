Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C83A254B
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 23:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779234497; cv=none; b=Ix7CnHGBKy+SmguILQTtGUDEpiIgcLeJKWH/yFylQhrVXHgaGevJzgs4S2KpRotfyeczeibORRfkvGdz8IpWGJhx+whHXiF8E3rcVovHy9GMN9owy9lLP8YpLC/6dAOwZqm+SgKXcF4T1UGEnebnifyTs1MsAjgUcJIZiw9w7Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779234497; c=relaxed/simple;
	bh=VLq+OnlqkiTSPOlR+NkVS+pKlfsiY5f0O/xbmXPX4+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nF5pipjY5RLEgRlatttvO6/7g2QGlskt4iuzCV0R05g5xfq0F53smiuGt6hMgicLbxmmllhySel9rM87MQWU+m6wukgJoX+6KV5euyZMU+VCHU7jA6Kejhizu3BBYJx0CNLD7lAIEJ5/4kyErLDq49NI7206hmLA2oimhIM1rNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=ZyUA6qyE; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="ZyUA6qyE"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8b74b460d77so55067156d6.3
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 16:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1779234493; x=1779839293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhuMcTLWdNNuDcBNZFMFTCgFJ/UCWdePWMH+rdEL30s=;
        b=ZyUA6qyEHZqFadwVNIJEFRbDYP37gmFnNf9tcv/0bGjOIR8OFM2euWokMK5o+dcDjk
         xNQ/1BKdUd7fYkIJVVRTkgN0WMN4yRRWetujckycGj2/mvCXDARanx7b7GVWaGP8IPIf
         OCW/I109VsxcYB5yPiGwy3f//+8bI1sZMhCIUevTu0ILKSQnyrc+i4YIbQYr2VMFUVVX
         4xvDQG4djEeDYkBT5Z3ibjDULmcgC5rMsneY42NH2eqF+k/0fxnJ4KZxGTMDtwwJUEU6
         /6CGRi4wdsw8P8U6Zo2J5YcurHBV3V+1ArXjPMGdCRPheR9m9CjPwUoA/hQEiht0+/yW
         D4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779234493; x=1779839293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RhuMcTLWdNNuDcBNZFMFTCgFJ/UCWdePWMH+rdEL30s=;
        b=Ok37vvKgZfj66gUORnLE49wAMxEoMBpF4+6nex/VNVzTQDXO19/tdECHT89SltF/ew
         QzgDAyn/a29plk56XPsjD88Iy8la0aV8h+vEbq8dk0ZLcG/rOGEaiVSc2O77bABxDVPw
         T3popHDeHonFZaD4swVaD905zzLFiDzN+B+yPHnmqb5SfNdESsCpycCM/ipaB0kufarf
         vi9+7xdzG/Cfx/a5leo4G1Sbo4ZuZBSrMSQKLj6nZSPmas2ecHYbCC8XxUolq3zJAehL
         q1Jdrfg0XBz6tMJp2x8yx6b8RxrnN79iJeMRDej97fNa4Ch+eHXfZNEKXQKgJ7XRdx3K
         z8cg==
X-Forwarded-Encrypted: i=1; AFNElJ84Mb8KlgIKtMwydTBU8SAY2vBT7PAHeaQWaxrWlFN+kxlOvLOnmdsDf2qCwTBgOOkYMIJKGL697t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM+zlmH9q1s8x8y2ifcAWe668SVhOXHBz305g02NkkGWIqXS1H
	kMkIg8AZG3JDv+T6U8kP1z+Y+TSHR1gqvcbt7Zq8dtstgY9FIgR9XKX21N+pGR8KJlc=
X-Gm-Gg: Acq92OE8fYHLe8ZG6cL0hcddc5vlit4PXJ6rRkj2EX+NqzPWsk4Qu8ijgiduhbscul0
	JxDglnHRkXzZp1DZtgprCV62XfcQK+ud32oBevYR9cWVwjVMMdl7ax1ygGjUfXYbxYA+vo6Ko0I
	fNsBZuQJNjZiSBEibqbx1wUzVnReVRgNKpZV73sBpOYt/jzZjIVeU2jCkO7NwVYC8gizFq4GerD
	gATDA+r5t20CfWKaXsKLNNCr8SVdS0k1i/auRsHInpwNz0+hcbGW5g9Bv+3aeGrUvjz/wa0HZmj
	gF9frXO39H1SaesgZ2U1UBl8RiQhJ5eiO6jkNWIJ76vkFSLgstVgp8/8Gw42VKMZ1YXhiH4VWtB
	clt2pHVfDMgHZR62JdlCODzSZHRYumZ886D4dieS3bgB5yO91EyObYXVi2ZevmIEs3XoY0k8xez
	2khuJqg8qkcV0bGM2iVZ5N2JoG4wuCfmswpVQ9nxI=
X-Received: by 2002:a05:6214:54c7:b0:8ca:1753:90c0 with SMTP id 6a1803df08f44-8ca17539460mr338639726d6.29.1779234493271;
        Tue, 19 May 2026 16:48:13 -0700 (PDT)
Received: from natalia-pc ([179.162.246.45])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36095326sm107301896d6.14.2026.05.19.16.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:48:13 -0700 (PDT)
From: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jikos@kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com
Cc: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v4 1/6] iio: accel: HID: hid-sensor-accel-3d: Refactor channel initialization
Date: Tue, 19 May 2026 20:40:43 -0300
Message-ID: <20260519234752.23911-2-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260519234752.23911-1-natalia.andre@ime.usp.br>
References: <20260519234752.23911-1-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Clean up the channel initialization loop and replace the local
accel_3d_adjust_channel_bit_mask() function with a compound literal
to improve code readability.

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 27 +++++++++----------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 2ff591b3458f..2bf05ab5235e 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -3,6 +3,7 @@
  * HID Sensors Driver
  * Copyright (c) 2012, Intel Corporation.
  */
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
@@ -119,17 +120,6 @@ static const struct iio_chan_spec gravity_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP),
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void accel_3d_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-						int channel, int size)
-{
-	channels[channel].scan_type.sign = 's';
-	/* Real storage bits will change based on the report desc. */
-	channels[channel].scan_type.realbits = size * 8;
-	/* Maximum size of a sample to capture is u32 */
-	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
-}
-
 /* Channel read_raw handler */
 static int accel_3d_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -297,19 +287,20 @@ static int accel_3d_parse_report(struct platform_device *pdev,
 				struct accel_3d_state *st)
 {
 	int ret;
-	int i;
 
-	for (i = 0; i <= CHANNEL_SCAN_INDEX_Z; ++i) {
+	for (unsigned int ch = CHANNEL_SCAN_INDEX_X; ch <= CHANNEL_SCAN_INDEX_Z; ch++) {
 		ret = sensor_hub_input_get_attribute_info(hsdev,
 				HID_INPUT_REPORT,
 				usage_id,
-				HID_USAGE_SENSOR_ACCEL_X_AXIS + i,
-				&st->accel[CHANNEL_SCAN_INDEX_X + i]);
+				HID_USAGE_SENSOR_ACCEL_X_AXIS + ch,
+				&st->accel[ch]);
 		if (ret < 0)
 			break;
-		accel_3d_adjust_channel_bit_mask(channels,
-				CHANNEL_SCAN_INDEX_X + i,
-				st->accel[CHANNEL_SCAN_INDEX_X + i].size);
+		channels[ch].scan_type = (struct iio_scan_type) {
+			.format = 's',
+			.realbits = BYTES_TO_BITS(st->accel[ch].size),
+			.storagebits = BITS_PER_TYPE(u32),
+		};
 	}
 	dev_dbg(&pdev->dev, "accel_3d %x:%x, %x:%x, %x:%x\n",
 			st->accel[0].index,
-- 
2.51.0

