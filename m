Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5846B13A258
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549009; cv=none; b=BfHKH8UMRXB609U/R/UuWVnWR/GuXTptQFVjccqngpg5FMwD0Mr0tOoNH7SPcFJQTjEzdorgWi9WEG1cmDcGsGOJXE65fJxYQE9AWzPsoJhV76iK3LJtHYFRzQSXc4an6vYwav9zofFL2biWFuuZwHab5m00xIATG/2afiFbOEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549009; c=relaxed/simple;
	bh=bGF3SOQGWINSFtgAIzXnB14gPqPP8mmWpdvWHwpXStc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0ZuhkuFmstVzyqMnbMj/RachXl3luPfUz3jiaIHs7cKORIZ5EeKXAWeavmbFoB3/u4G0FwNUmmlhWs4WjV26k+uGHkdekT5xzzEEAw5T3w8+nmwjMVrmlvMBMILOTnHjLwV/8ArNzDTnFSIWaaFHSPyYdEp85KJpdqLJCrca1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=RFLxmv+V; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="RFLxmv+V"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2f3c623322bso8329214eec.0
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 18:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778549006; x=1779153806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGAP2uNSb2ABD3/WN+PryrBLAUiNs2d2P0FijTLRFBw=;
        b=RFLxmv+Vla5cRgPtXEFHZjpLPxkjczIuTWVZtVbjURYeM9OgjbFGkkcMHzjisS7MgA
         l54tLPS+/a0Yaf6Am4ILYYTp4LrYrEvEvePLCoxe4Fr6OuBJTZ+4fbOTPUJcwZfWpOeG
         7D9hE2TgNWXf5lhkimrx2bUYpUIHDvkq/GHLur8J6hVyLB+2s4zLzzrjAIxL+pLEGi1J
         zptYlp/6TP+WZQzk5etRp7wWkIPR3GT/oCjImtUfGOegyOkYp9+r2Dk0FQLgG4cP5/ti
         9GZHUR7tDXzhGaJVLJnljdZQzf4cTZoWGjwP8jkRSx0fietqlfeAcS9WFKcOTln6axeN
         IYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778549006; x=1779153806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bGAP2uNSb2ABD3/WN+PryrBLAUiNs2d2P0FijTLRFBw=;
        b=OkE7fZ7YQCzp87jQPK2pWBv8LaDvmpntoRN4ZYjor/QfnWJVRh1P7MeqW2lxMLplvr
         KktA/pMbJ0nwkf6g7OhnbbggmRIZ2vEeCMeErvsCLSFQtlYeUNd97O4h9p6Xu0IMLcXV
         CcmP79EIrINlnT7IohQV21MuxNh8B+VcbEljJ/5BxUgSfISB5xykKLjyJYhDltABaPFy
         nFX/31L7GoqCTOZkfGwiVW0Y47UeraIpjECBYRGux4TBNf9/7fhFjp9baD5rqknCrJt8
         Ah2RzndLFy6OLjsHWg+cyyQA+G+E1WKl1hn797RgBLYpUkmsZGSLWOWAUH2EuTPcGBL4
         9k8g==
X-Forwarded-Encrypted: i=1; AFNElJ+JBhIHPeKdtbVkK1xD55vu8vPkL073wRTFAre4dozw+kuI5tOCILoPfp3KP0+9oi4e/0tHiETHdg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIwVu7HUCb2rWhDysIzGYsNO3hnhybdzr7RGnyC1TDL98lsmCj
	1zC2FWooxkKEjA5PkdMyfMuFkcheMkL4FcaetyIiXgkENsZz/z7DL4TNQ+JljoROHK0=
X-Gm-Gg: Acq92OHrtDpM9VWy01BvA2bjOTbFL+VdEpxFQHP9qMxpAL2nAc62TN8r2LGQsg9yxu3
	JB/IGoYAsLUsLMG78HuK0lJHtuRSn4ultTimMq3LwYV67ucgfWwLtL1UCgaqclvGnt/fKW8lNe/
	qguiC9npFU08EBKLSAiO/0sZ1bWQ8kYAi3fm7ldVcX70H7xQadNj4wMGmoc5rc60bOPJB/L7Yab
	3+06Sda5XImeYmXfO48gVa2PxWZP17yz7gm8vXQMR4paU1hsl/IAI+0+T8sGfQVkiwL/SfaeqoS
	qlTYvl4M0CnFP2Zfvv53CXjO9ryFQOUvGJWP7kfbrfVFv/aXvjM6jSz4uMiLf226KRUDNvzYKZh
	DcAgTYbGEWtlCkCV4rOubtySZnoHQu1Lirb7bn+hQuHRnVRAPAeYkIxncLOOWUAVDSKFoz55U+l
	83bvGjhAzjDRx/9I3xmsxJ2TxDcgGpJX+BFLy3RtUp
X-Received: by 2002:a05:7301:3f16:b0:2c8:6361:ab2e with SMTP id 5a478bee46e88-2f54b35faf5mr12485989eec.8.1778549006517;
        Mon, 11 May 2026 18:23:26 -0700 (PDT)
Received: from natalia-pc ([191.205.196.185])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847506fsm19484481eec.18.2026.05.11.18.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:23:26 -0700 (PDT)
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
Subject: [PATCH v3 1/6] iio: accel: HID: hid-sensor-accel-3d: Refactor channel initialization
Date: Mon, 11 May 2026 22:16:17 -0300
Message-ID: <20260512012302.20883-2-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512012302.20883-1-natalia.andre@ime.usp.br>
References: <20260512012302.20883-1-natalia.andre@ime.usp.br>
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
index 2ff591b3458f..99ca67732bbe 100644
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
+				ch,
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

