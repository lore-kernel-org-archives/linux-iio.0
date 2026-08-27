Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798F23CA4B2
	for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 22:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787869421; cv=none; b=R/9s/9Wsv7szxUlP3bG+u8LmD0dtlWNiW9jpwRZygpuSoTaOjOlqXR1bv+orH3AYq8up6wv1VBNs9KLzVFMZzqHXqpAuXJPcutQbMz4Z0RW2ANdFyA424Zt5kC0yjr0zDV7xY5euNNpYkEGQDHGjtdJT8ScXJ7cq7C/aKga+KK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787869421; c=relaxed/simple;
	bh=0jleKfSV4x8zSuizbp6O6ni4ujngh47YqjL22y19AbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JBtVuTcVGZplOIFEoEGlrDZrOWCvSgTMgDneX6taX3vW3muZj0rfD4WexQ5oRUjB9k07jM9JdUVvpH19I13JwAzr3A5CL5YEVxNe1aJG5fXckC2CS3qFGiiRFWgsdaA+QUzITySwP2m206hA4V8uUrqk/LARo3M4qtEScDB3lL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=d/gLtfZp; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="d/gLtfZp"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7f4cc6797b7so76125a34.0
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 15:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787869413; x=1788474213; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cEY7r8lduCT2nc4feVvWUral7NtsjaDfgRTqImYybck=;
        b=d/gLtfZpjDN8EUweE9273ciG25S1rmPJvfzppvj0Vus1u5l3PaRs3lpqLFwXEdAzEV
         5MN16BefFFNhZIwZBL4AI6erYIq943I31Gaeicc45s0Fu+uAjuM8odFHknbZMYDoPXAC
         K0dIBoHYiXP09f/LEF8jxDGER3JUfZRg0y5ehy7B1Rq+t2Jaq+6woUyxvJHmNzdHEsKB
         riZCGU4TjaQk6U2ySaaEpUjoDvm9xTuAehG9rmMiMtmYp3s6tm0tMOU3hhfW4nykgISV
         8umfZsTE6EdoP3yOzPDGtEvYetQr6TIUpAqmdNTvBUDvVFzcE4fK0YCS1SkdAa9bzgSZ
         VkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787869413; x=1788474213;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cEY7r8lduCT2nc4feVvWUral7NtsjaDfgRTqImYybck=;
        b=iBGBo+fSe+yoShdBOTHSecky1oPrqOkc7FQgHtlndpo7q4RV/Ua/cTj4Krd7pxv/Ub
         mq2ByWlRGnIIQcy6ltluS0pEfyZ6ZijHSQqrHYhvZoJ0RVFGo9EYxk2RqPHrVhB5Rb1S
         dY3Y7WKjQ99w5xJfUSQfC8DA0jkLCcd8aq89nmg1IdTl2HSiXOSicvEyrvl0t2bewITT
         iLhMGn/OqwwT+P4X9cnr/HBnifZWy5x/qm6MWtghtcr9Vn+X2xcCCGZqErPdlNrsre85
         wwe/YX8+8NOJo9Oe3PaG2peDa60v2Z/nVx7r5EyofF/wfT+fXK53hpEBuuJnVdE1e1pR
         ex3A==
X-Forwarded-Encrypted: i=1; AHgh+RrtxdINs3gkMVxYeGnPwAXmcl26oRcHsRzbMlR4Uggpe8+I1uX7wI/7G/ofYzMfndmPKX+a9yL8u/w=@vger.kernel.org
X-Gm-Message-State: AFuF++map27MHLNg11c1DnhNQk8RMP2RXGp3+dPesP+bqNJDasxiSYBa
	SDS0ZDQRuh9tmTz+6ffbVzcE5Eb+eOy77pQc5AtLlj4Jw0beXNa4SQGAT190ElG2z5Fa/DwXCZ9
	AQKcIBOI=
X-Gm-Gg: AR+sD13pVWom5IY6YpUivZMXncBhlakcrT2hlWZ/kx0wFUBB4+KsVSUo5VrqbcfwgqS
	XUyUztjwjwCsZt9L6x0GK973CCHyl9mCcqPmwxYSA2qZfMj5SpAyDV5ZgKLpyczClV+NNE4tIuV
	tuRZ3E4dr8dYFIO829mLzG4C2C7nbb4AQPMaGVxRPwSQ8SsvP3wusVfidtjIhmqlQawQkUQYZkh
	WyTSrRZTcJYCqOjWDKvXhZ9xqlEQ0Wf+xacLzD5rWPpVNjdJUyG3DSAQmxy+t6UANOTH5K9wor/
	fj3di4ZmzArSjJSTzbrYloWFommxlZx4qs+Ot/Jhg7NqOtN+cBOWDdyLVGG00g5rT4l1BNtDpqm
	yvqZtycfjWxGbd4Uo7qdAUT7RmbIexqXZOy754zFLzDHIwJSTm/HdnPH4LHy+GUUTH9GU+SIZp5
	pj1zyyxt+fDCEiAd5eXSxlsEgqkuYiguZ2RoDidW21XmAg//gQOmw359koItvs+ZII2g==
X-Received: by 2002:a05:6820:180d:b0:6b0:589e:42f4 with SMTP id 006d021491bc7-6b1c66b745cmr2087523eaf.20.1787869412938;
        Thu, 27 Aug 2026 15:23:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d288:6f77:e285:6925])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46736445d6csm3176880fac.2.2026.08.27.15.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 15:23:32 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Thu, 27 Aug 2026 17:22:54 -0500
Subject: [PATCH v4 2/3] iio: adc: ti-ads112c14: create data read helper
 functions
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-iio-adc-ti-ads112c14-continuous-mode-v4-2-1e51a6e20a69@baylibre.com>
References: <20260827-iio-adc-ti-ads112c14-continuous-mode-v4-0-1e51a6e20a69@baylibre.com>
In-Reply-To: <20260827-iio-adc-ti-ads112c14-continuous-mode-v4-0-1e51a6e20a69@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=0jleKfSV4x8zSuizbp6O6ni4ujngh47YqjL22y19AbA=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqkLjRt+57QHCBq9DY1dUxKl9CAbewfpRgKexdv
 ATvT2wVQuOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapC40QAKCRDCzCAB/wGP
 wG1rB/4/YNCn57DiCj4OkZtFS5CtosxGX9k49ZBaandtp7f/c5scfN6rjqMEVPYLN9phPgMJbwt
 PddvBwQNGNA1EHRDaXztfOgXS9HKzzOlpr7TVft3t80+DscmbpnNoI8zKZz5tiYONnemJKZgtw4
 4F+HHBVAyDW+sD2ck2btRdnZECy0RIP7dxNbgrSFQ499dPKFw8f/mRnGSd6lRf7EULMqP7DXOtK
 Hv5Z1CDaBcaTA7du0Xga9QrW6+MtC6rWOA1XLsI5IZjeutdv/oABHw7Fs4+sKeeHP01PieburaD
 aoCZm4ptT0JbA4POrRHgALL9fwoiYYIpl2snU60pVdp9lvr0
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Refactor a few bits of code into helper functions. These will be reused
when continuous mode support is added in a later patch.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads112c14.c | 51 +++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 63b819339788..23f15be303fb 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -601,6 +601,32 @@ static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
 	return 0;
 }
 
+static int ads112c14_prepare_channel(struct ads112c14_data *data,
+				     const struct iio_chan_spec *chan)
+{
+	if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE)
+		return ads112c14_prepare_measurement_channel(data, chan);
+
+	return ads112c14_prepare_sys_mon_channel(data, chan);
+}
+
+static int ads112c14_scan_read(struct ads112c14_data *data, u8 *buf)
+{
+	struct i2c_client *client = to_i2c_client(regmap_get_device(data->regmap));
+	int ret;
+	u8 len;
+
+	len = BITS_TO_BYTES(data->chip_info->resolution_bits);
+	if (data->i2c_crc_enabled)
+		len += 1;
+
+	ret = i2c_smbus_read_i2c_block_data(client, ADS112C14_CMD_RDATA, len, buf);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int ads112c14_wait_for_conversion_irq(struct ads112c14_data *data)
 {
 	unsigned long remaining;
@@ -644,15 +670,9 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 
 	guard(mutex)(&data->lock);
 
-	if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE) {
-		ret = ads112c14_prepare_measurement_channel(data, chan);
-		if (ret)
-			return ret;
-	} else {
-		ret = ads112c14_prepare_sys_mon_channel(data, chan);
-		if (ret)
-			return ret;
-	}
+	ret = ads112c14_prepare_channel(data, chan);
+	if (ret)
+		return ret;
 
 	if (data->drdy_irq)
 		ret = ads112c14_wait_for_conversion_irq(data);
@@ -667,17 +687,8 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 	 * with CRC errors, but rather leave it to userspace to decide what to
 	 * do.
 	 */
-	if (for_scan) {
-		u8 len = BITS_TO_BYTES(data->chip_info->resolution_bits) +
-			 (data->i2c_crc_enabled ? 1 : 0);
-
-		ret = i2c_smbus_read_i2c_block_data(client, ADS112C14_CMD_RDATA,
-						    len, buf);
-		if (ret < 0)
-			return ret;
-
-		return 0;
-	}
+	if (for_scan)
+		return ads112c14_scan_read(data, buf);
 
 	return ads112c14_i2c_read_bytes(client, ADS112C14_CMD_RDATA, buf,
 					BITS_TO_BYTES(data->chip_info->resolution_bits),

-- 
2.43.0

