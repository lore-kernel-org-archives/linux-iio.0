Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6263A3807
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 23:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779234500; cv=none; b=uWF/tam7JKu8LHzqP9bpuyeaqxV+jgOz6C4DOOaSIJdxeYSue9Vtuk+nBQoP1H+kHhUfH+3DjEefOiaBxW2laWHoCX5sp2fwz+m2K31JbAiSnV5OHWmZ49RC8a30VKm+6MadjBxjljtk/4Sb14kgtwc4fcssHsXlEznm3xYNBnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779234500; c=relaxed/simple;
	bh=3ApyXcATJZb78nPHHHdP725U2EJZWyGQUHqJdrNZckI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0GFaYtmjW3fgBLeSTq5EdzPcQL7r04zM/7nx7o+982dRz2NPFeNlgLNZRtbv+Z0W8UL3WhEYUW8RXqKlvHGNCVmddy+v1d6KLx/5jYoGGJ2YRCPhHFIN3/Zd348GlsMsbfDIjRUgXZnNq9DWjiOcr7MSNwN9AMRp73NGCQp5r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=kvk+1dSG; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="kvk+1dSG"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50e63771eb0so44979711cf.3
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 16:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1779234498; x=1779839298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvT864S82Fo9HErNXXZXDbRGPrbybgU9p7aJmKXm2Tw=;
        b=kvk+1dSGwyy/ON8okWuQO1Hofpv1VQQU34aYrXWCl51cLHNMCbDv32/q7g/Shfhcy1
         xQC3pyQlbEFjseDCPfTIwOPloK4IipjbwZH++GUVE81+pcOepPe52mbsYz0/GXS9iBSm
         xK77r1SaoptzaK6a2rJxw0S5qaol9GfQKgo2LQRg35In3PJa1wT+eg8v3uyPW5TQEGKx
         xTxFzSQ82o1PxEeAa92cIlBc2KbjFbqxz7o/Hn5FhdDB5YG+YjExsXIynnYr8bdMnDDg
         KyZyW9VqXoUMCQE43zG4PJlgepKNzGXvfkCW1RKXTbRkj2HBu7i5HszsWWoGk0HpLTR7
         dKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779234498; x=1779839298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vvT864S82Fo9HErNXXZXDbRGPrbybgU9p7aJmKXm2Tw=;
        b=gmgOWrGobU91uCzQlt2Bn34LdZTeHc5DpDuDJR2Vl/LXiZchbDUeqAHTFIjU9xyoEj
         GQ7/9ebz81C8Kyov/6SxO5/CHzI145w2FXHlhaR1jrHDM09LpSptYsy3DKXjwLPUWJkP
         slH1yf3JlBUQRSn2q9qL30Epg+bLcCK30kAjwydaPRyeaTSSdeosEW3klergiVONjRRC
         VdQlXBJudwI34meVI7wd1sjtFtOi7l91gXYLJPlgSW4hXX0vMfbz8i+5JJnGJBI7CY/Y
         4gyAiHAOGZzrL/or51Cx2vfnDTvkEA8OLiyMn5tBYmEGBjtRh4xUI19JHrOApVgnw0ot
         11Cg==
X-Forwarded-Encrypted: i=1; AFNElJ8YJx5MveO9mtqLx62kNX9EdG5faPcyLzE+bg3DHWcER1wOkhzJ45Hv+po6l3cJYDN0a2xEDIq8q24=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ1aPH+A4XGAypE+jp0KHRQJ2v6ExkhB9v2mNNFUe+S5t61r7b
	DJp4n4n2WD/6tkNCd6bvfV5jlcO89zY2WF2Kon9NAAz1d+fVq2bX4vLWsmJ65JpBcAY=
X-Gm-Gg: Acq92OHYQxOaHyB7L28LJ2/1Yw7oBxDTSNVKOe9toRvTX1sglrJYa1eAOky/uDv/Jzv
	qItvlKYk8q+xo0pVkxEcAFpGF/Zv/LNo1mqopK31tKDPdPpfrRMKY6pGur+//ngYlfe8djUJ1Vc
	qninWApDf1CKIJrq9cGbis8G7lXY5usmTKW/FMHfrnkoY21Ye3mkhEe9Tvf3PGde4ZIEBakm1UE
	qY4Z5mrZxMaruueVJ6+6nOiRXLeye5lMcji9/99HEbW8PrH0MWrWkWyro67KGBEJpRPahb/GEcX
	qlqUSjeSgA5j3Tqt4RmxOtiE/FKYb2FLaEPkPIYW0w2+uzAJqpd8qlm4SSd6YcEdR6packKNaoH
	AIyCpmS+FWFcYm2XJoccG98WIkEJ2JDhceikkFOWEEOCytMUGUqEjn4leLfFoZ3TF2oHFGDmsMb
	oLriq2txbwgvMxaxS80X4kxim8OIMW
X-Received: by 2002:a05:622a:8d1c:b0:516:a040:373b with SMTP id d75a77b69052e-516a04038b9mr100168621cf.58.1779234498001;
        Tue, 19 May 2026 16:48:18 -0700 (PDT)
Received: from natalia-pc ([179.162.246.45])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36095326sm107301896d6.14.2026.05.19.16.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:48:17 -0700 (PDT)
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
Subject: [PATCH v4 2/6] iio: gyro: HID: hid-sensor-gyro-3d: Refactor channel initialization
Date: Tue, 19 May 2026 20:40:44 -0300
Message-ID: <20260519234752.23911-3-natalia.andre@ime.usp.br>
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

Replace the local gyro_3d_adjust_channel_bit_mask() function with a
compound literal for scan_type initialization to improve code
readability. Additionaly, clean up the channel initialization
loop by iterating directly over the channel scan indices.

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index c340cc899a7c..e48c25c87b6d 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -3,6 +3,7 @@
  * HID Sensors Driver
  * Copyright (c) 2012, Intel Corporation.
  */
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
@@ -82,17 +83,6 @@ static const struct iio_chan_spec gyro_3d_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void gyro_3d_adjust_channel_bit_mask(struct iio_chan_spec *channels,
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
 static int gyro_3d_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -248,19 +238,20 @@ static int gyro_3d_parse_report(struct platform_device *pdev,
 				struct gyro_3d_state *st)
 {
 	int ret;
-	int i;
 
-	for (i = 0; i <= CHANNEL_SCAN_INDEX_Z; ++i) {
+	for (unsigned int ch = CHANNEL_SCAN_INDEX_X; ch <= CHANNEL_SCAN_INDEX_Z; ch++) {
 		ret = sensor_hub_input_get_attribute_info(hsdev,
 				HID_INPUT_REPORT,
 				usage_id,
-				HID_USAGE_SENSOR_ANGL_VELOCITY_X_AXIS + i,
-				&st->gyro[CHANNEL_SCAN_INDEX_X + i]);
+				HID_USAGE_SENSOR_ANGL_VELOCITY_X_AXIS + ch,
+				&st->gyro[ch]);
 		if (ret < 0)
 			break;
-		gyro_3d_adjust_channel_bit_mask(channels,
-				CHANNEL_SCAN_INDEX_X + i,
-				st->gyro[CHANNEL_SCAN_INDEX_X + i].size);
+		channels[ch].scan_type = (struct iio_scan_type) {
+			.format = 's',
+			.realbits = BYTES_TO_BITS(st->gyro[ch].size),
+			.storagebits = BITS_PER_TYPE(u32),
+		};
 	}
 	dev_dbg(&pdev->dev, "gyro_3d %x:%x, %x:%x, %x:%x\n",
 			st->gyro[0].index,
-- 
2.51.0

