Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3FD4A2E1E
	for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851329; cv=none; b=Rg2Sq8mpHZZSOeHuUVp/Nt/kLqvnxGurU3CLRaQce4FSuczk57ozIgYz7hKxCSf4ruj98Sxtqx5LbcXKguIMsJDa7BcpxYSZq/3lIBRy75bKOn1iz5Qgl8S2Cv1hoSjv0RqJdD3bIxsvFrkV3ZwMhIzmQo2SW6RKUhQ6njQKBO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851329; c=relaxed/simple;
	bh=0k5RIH93Yjz24ksL9fHu9qf1zYGBe+t//mBUH0aQddc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AcpLCW4UloTSHIacarbTstpE+vFcNWZVOb4wd2a9a8T3aHR38wmDt605kGHCwwhkJRnrD3MR6eI8VFnRDD8RjIw29nwO9US4QzutYbEs4zd/sxHL4Yz6xRjIbAJXQKQ08mj+jV5UwNWb+9yUvR826mYFM4c/sJw5AptWcbeTU8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sk6kih+4; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sk6kih+4"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3965d3d9ab8so214783a91.3
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787851327; x=1788456127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ext/cEoySzDhvG6GqDZxdkuFYWzU30RhxhzVbTbp7aI=;
        b=sk6kih+4q1q9x3tu2rRpEdIALNDyAuPNgB+/84rNjDmwiirDezG8YI/g7f1I/2WxJl
         UPiXLtPU4BMiAdhWv/3VbHGYhpQTk+TRmsVygNvWFYkjfltrXvVBMrDxJHwKjvZExmvt
         CWJV+9onglqlcyCKXnQzS9NvWovWDNezf7tbqD9q8RJ15RsK4fbkHVk3TP+ZrpiZJGdZ
         VMsrRBKoJ3Wdr+DArLhjKahXxi+rcHybfpBB/AupzBwpnHYOjwdnGBZOs4GKbMCuMV3C
         omXCuk3/WVp5TCwpWzbHw8rcRbnleb2JyOe+JqPRU8oWcuBvIzxQ4DPGTAJId9UkRw5s
         95uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787851327; x=1788456127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ext/cEoySzDhvG6GqDZxdkuFYWzU30RhxhzVbTbp7aI=;
        b=pQgkFM1Mi1K2E9JhWRnZeO5HXHYMFPD/6aQr68QKlbSu/r5wIi5+nIaT1vwu11d1xm
         i+9QjCB2ol0hPdJ4fP7ZC5ZT3L4Q3JsaHx3Vd2hDV/M/+8ZEu3C0lggxfwG7AAqkmMIb
         r5X/6zmEPqVEP3zOFvjuv9Tjd0vPYONDBmrGnizvXWZA14E5O5yihCAn4asfVjLFRJ6n
         w9u25RHGXBzAQ4wi//ReBlEBdUVyDREHNttVRlQy7VB+PUnEkRZ3nQdQVhohpx+UCfeX
         gAWg95AFblar5z52clC1NrXuE2FxSC25fchqB4XWKZLBAj24RC5fFMlHVYg1K/FHqPoy
         qC8w==
X-Forwarded-Encrypted: i=1; AHgh+RoUSActFozZem4Dj5Ni1enR/C1g7lKZBi/Y7P/V4FlHatPsO7QJgARv3K3e+d/3RTZzToAi7IR2n7A=@vger.kernel.org
X-Gm-Message-State: AFuF++mWNVWTyXF2yKJf/bVpAVnKpUNENaK0pFGtiERZsIZkfK+Z/mwZ
	u5oEbE0i906AGb8Zf2Xf/BHyUlWV0r5SEVrG2bRbzW/DxRemWRSdBOxD
X-Gm-Gg: AR+sD13xEpBdi3UbFYi7ucFvFR6AOZ+NldjcuI7Q6OGLvDrjT2PfTIfGmpcFYqR9pSL
	sxO2erk4440ezMYlACMSwoEM371kzDFwGVEYHTMQNHC4tz1aVQqgf1BhIw+xMT0ZHiJz7V1jYnI
	RfqMXUp0ZEAirROIAFSBJYfXKmF6GTIexyDnq2ajCmF7OficSZnOfVGPgBNupdQrajOzDNYfWW9
	8FQbK5uAIS/SAVNZVvPxtHqXh9pGqMeY6duvi4IW1ad48ES0AoFbQ0lQs1095mqrHLBuYIHTZhE
	J+oviKJrw4YbPuiEqFIZkinY+9JvI2p8WEaJJaEaNJRvazus3AhrPXbKem08lLNjHWMfUe0jaN/
	UBbcJWx7gFl+oFPxAzOUryaX/SG7t1px9AMSLUjBqTWqb3MGhoXUjW0BdCKN49/Z4CG19gLYlNl
	JFiez0A/WXmAAPI1YgCfd8u3dMlB5ZKMUXYKrE2b8LBRU9DlX+I/oWfdtc7Z40HIRVeV0pvKnj2
	Qe2uF3bLZj6s9myyISvU2ZTIMVbSl2nVCtMRN/BT/Nixzm+
X-Received: by 2002:a17:90b:1a8e:b0:396:4c63:7193 with SMTP id 98e67ed59e1d1-396d0fe45damr1226750a91.11.1787851327313;
        Thu, 27 Aug 2026 10:22:07 -0700 (PDT)
Received: from debian.ari ([47.30.51.191])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8eedd13sm17797165c88.1.2026.08.27.10.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:22:06 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v4 7/8] iio: adc: ti-ads1015: replace custom shift macros with FIELD_PREP/GET
Date: Thu, 27 Aug 2026 22:50:59 +0530
Message-Id: <20260827172100.39176-8-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260827172100.39176-1-architanant5@gmail.com>
References: <20260827172100.39176-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently uses custom _SHIFT macros and manual bitwise
operations to read and write to the configuration register.

Modernize the bitwise logic by replacing all manual shifts with the
standard FIELD_PREP() and FIELD_GET() macros from <linux/bitfield.h>.
This improves readability and prevents potential bitwise errors.

Remove the now-unused _SHIFT macros from the top of the file.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 40 +++++++++++++++---------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index a6dd85debc0e..d675f82c0bd5 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -11,6 +11,7 @@
  *	* 0x4B - ADDR connected to SCL
  */
 
+#include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
@@ -39,14 +40,7 @@
 #define ADS1015_LO_THRESH_REG	0x02
 #define ADS1015_HI_THRESH_REG	0x03
 
-#define ADS1015_CFG_COMP_QUE_SHIFT	0
-#define ADS1015_CFG_COMP_LAT_SHIFT	2
-#define ADS1015_CFG_COMP_POL_SHIFT	3
-#define ADS1015_CFG_COMP_MODE_SHIFT	4
-#define ADS1015_CFG_DR_SHIFT	5
 #define ADS1015_CFG_MOD_SHIFT	8
-#define ADS1015_CFG_PGA_SHIFT	9
-#define ADS1015_CFG_MUX_SHIFT	12
 
 #define ADS1015_CFG_COMP_QUE_MASK	GENMASK(1, 0)
 #define ADS1015_CFG_COMP_LAT_MASK	BIT(2)
@@ -408,15 +402,15 @@ int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
 	dr = data->channel_data[chan].data_rate;
 	mask = ADS1015_CFG_MUX_MASK | ADS1015_CFG_PGA_MASK |
 		ADS1015_CFG_DR_MASK;
-	cfg = chan << ADS1015_CFG_MUX_SHIFT | pga << ADS1015_CFG_PGA_SHIFT |
-		dr << ADS1015_CFG_DR_SHIFT;
+	cfg = FIELD_PREP(ADS1015_CFG_MUX_MASK, chan) | FIELD_PREP(ADS1015_CFG_PGA_MASK, pga) |
+			 FIELD_PREP(ADS1015_CFG_DR_MASK, dr);
 
 	if (ads1015_event_channel_enabled(data)) {
 		mask |= ADS1015_CFG_COMP_QUE_MASK | ADS1015_CFG_COMP_MODE_MASK;
-		cfg |= data->thresh_data[chan].comp_queue <<
-				ADS1015_CFG_COMP_QUE_SHIFT |
-			data->comp_mode <<
-				ADS1015_CFG_COMP_MODE_SHIFT;
+		cfg |= FIELD_PREP(ADS1015_CFG_COMP_QUE_MASK,
+				  data->thresh_data[chan].comp_queue) |
+			FIELD_PREP(ADS1015_CFG_COMP_MODE_MASK,
+				   data->comp_mode);
 	}
 
 	cfg = (old & ~mask) | (cfg & mask);
@@ -427,7 +421,7 @@ int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
 		data->conv_invalid = true;
 	}
 	if (data->conv_invalid) {
-		dr_old = (old & ADS1015_CFG_DR_MASK) >> ADS1015_CFG_DR_SHIFT;
+		dr_old = FIELD_GET(ADS1015_CFG_DR_MASK, old);
 		conv_time = DIV_ROUND_UP(USEC_PER_SEC, data_rate[dr_old]);
 		conv_time += DIV_ROUND_UP(USEC_PER_SEC, data_rate[dr]);
 		conv_time += conv_time / 10; /* 10% internal clock inaccuracy */
@@ -744,6 +738,7 @@ static int ads1015_enable_event_config(struct ads1015_data *data,
 static int ads1015_disable_event_config(struct ads1015_data *data,
 	const struct iio_chan_spec *chan, int comp_mode)
 {
+	unsigned int val = FIELD_PREP(ADS1015_CFG_COMP_QUE_MASK, ADS1015_CFG_COMP_DISABLE);
 	int ret;
 
 	if (!ads1015_event_channel_enabled(data))
@@ -756,10 +751,7 @@ static int ads1015_disable_event_config(struct ads1015_data *data,
 			comp_mode == ADS1015_CFG_COMP_MODE_WINDOW)
 		return 0;
 
-	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
-				ADS1015_CFG_COMP_QUE_MASK,
-				ADS1015_CFG_COMP_DISABLE <<
-					ADS1015_CFG_COMP_QUE_SHIFT);
+	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG, ADS1015_CFG_COMP_QUE_MASK, val);
 	if (ret)
 		return ret;
 
@@ -1005,19 +997,19 @@ static int ads1015_probe(struct i2c_client *client)
 		unsigned int cfg_comp_mask = ADS1015_CFG_COMP_QUE_MASK |
 			ADS1015_CFG_COMP_LAT_MASK | ADS1015_CFG_COMP_POL_MASK;
 		unsigned int cfg_comp =
-			ADS1015_CFG_COMP_DISABLE << ADS1015_CFG_COMP_QUE_SHIFT |
-			1 << ADS1015_CFG_COMP_LAT_SHIFT;
+			FIELD_PREP(ADS1015_CFG_COMP_QUE_MASK, ADS1015_CFG_COMP_DISABLE) |
+			FIELD_PREP(ADS1015_CFG_COMP_LAT_MASK, 1);
 
 		switch (irq_trig) {
 		case IRQF_TRIGGER_FALLING:
 		case IRQF_TRIGGER_LOW:
-			cfg_comp |= ADS1015_CFG_COMP_POL_LOW <<
-					ADS1015_CFG_COMP_POL_SHIFT;
+			cfg_comp |= FIELD_PREP(ADS1015_CFG_COMP_POL_MASK,
+					       ADS1015_CFG_COMP_POL_LOW);
 			break;
 		case IRQF_TRIGGER_HIGH:
 		case IRQF_TRIGGER_RISING:
-			cfg_comp |= ADS1015_CFG_COMP_POL_HIGH <<
-					ADS1015_CFG_COMP_POL_SHIFT;
+			cfg_comp |= FIELD_PREP(ADS1015_CFG_COMP_POL_MASK,
+					       ADS1015_CFG_COMP_POL_HIGH);
 			break;
 		default:
 			return -EINVAL;
-- 
2.39.5

