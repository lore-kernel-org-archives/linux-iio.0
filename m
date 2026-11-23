Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417313;
	b=dqbUwSxV9SaVTdwkXneK5G26W0bmuyjRC2oCL8srTvqXXawiFbVsYK8EekSHsf7Gy2Vq
	 hVpaEjGoaaF+6WySWWBRPdtt/lKoNZStKFhoW0WiJuShapaLCe3/ymrNLcmoLstX3toOR
	 pa7H1HnFfyys4WSGP8WfqS/Y17mzq5xVtZQ1e8DOVSYaiGoUmoaZb9clPESMXv2B5toQY
	 bXbeZQ1x+QVienje1djlViZwiLJ7O1NzaV9wx5t0hz4ZDpsfTkd0qSykoQyvTJayAfKjj
	 fRDYdSrfT2ToiF26EgW77ffPdvU+UeIxwYnSWpsdE6L7kV9PpyQM4sbJcS9tfE+MmbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BaHVj1vymyANMIuaDlnAd/LpWMipmRDfZVKqcVMgeBQ=;
	b=T09f0F5uO982e+nPpzyH30wQ9NkqJH94jhIiLvp1b3fRnR/XsDg1cqqOjCiDuR0luauf
	 kyC1L+zhHMm4w/U9k7zIuk2XHRKTZUusPatNQVMV2vZBB9RvmHjQ6APlCRhMBFBXCFEiJ
	 l+lSEFR4Ja4ganrxvymAMHj+9TwvOgHUa2afRRDJ2ZoYNlw20IyAJ0+Uro7Oysx4IbSQc
	 dJju8qeaTkhtRskBnlYmM9KJ9ymqSzupChQYE4GhXA8Wxuj565ZDd4o0BBWg4ke5Oml+P
	 jRWOiWXHqb1xVsOkLVUSU/4JlAbFVug9IpWUe8KfJgt6ldpN5Iyp7HI2EOzGGHmq1bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CVkYng4x;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E8B606A31A
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 07:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97E8B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CVkYng4x
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so21600795e9.1
        for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 23:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795417311; x=1796022111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BaHVj1vymyANMIuaDlnAd/LpWMipmRDfZVKqcVMgeBQ=;
        b=CVkYng4x4mEQ5lXZmAniDlM9/OoBk5AFW1ldYs+5E0C7TfuPXvtewxUDzoTf0izWu+
         58k4A39TAfQjaLr70kjJZ8qe/cbVT2MSxDycuJXoIRSaMVidCxJr+wzwDiZdAE5vHesJ
         6M48Oh8012gQY6kklaGIcPYcecJA9TBR5r46206WzyzGuguCUMBdKEQhc6Mq2Nkxcr9o
         CN1mW62lU+xuSjrTTLfGmcTNFQr52e5qqLn9+s3aPLOOiZ46DMBpSEg1h0DUPGYUcMFq
         0pDJRPrcXQ2Z4yjbMDJqTZxYotfD43HWkZob1Ls5PU+u2fP7E/s8UUsaPNCrsl0vusjv
         5zCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795417311; x=1796022111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BaHVj1vymyANMIuaDlnAd/LpWMipmRDfZVKqcVMgeBQ=;
        b=OCo7EfZdXmVFYZzk7d4oDYE3yx7srs1okihZBjp4NSd+S17jpakPs6Xgxd9C1QS2Fk
         gBH/fd3zYeR9jN59DEg6TTKalJqcji4+341z++h7Q1jMrzWIBl6VR+BRfrj6zUjvkVbA
         vc2BB58IhBsqyQE8rGIRoXO8CuI5iFrYavUncTRrq24917rm0TPjPyGXxQa8zINnti5J
         DzJNqoDICrHWdaxl2QfcqK1o1iONsT4qvzYbRuaojZx5I+62UdbYEtbEHYnAyQxT9Ia8
         CasAmcrjKjGznU/fmFJlwqfAm/YuV7TF4XeIMpa0m2IIF1Es+mnJ6fv27cxzmKf8wmFs
         fuhw==
X-Forwarded-Encrypted: i=1; AL+hErFErwnztvw+gTvYZIIUNoxVvq3tHK/lcQm6BuJ8n3acPlo9tbnCNpgv6U5V0uLBr1tX+O+SuI4S7bk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8mArthF+rxaj8PuKsgWzm+1Yei7spyu3ahlcApd5fShEK4sJfZ
	Fe+8cph5QmVKH0QbTCAfF+HCaDVH/y3RoAj6awO02jxd2RZ9q7RAQgee
X-Gm-Gg: AZFdTZc0BNuvUhKQFcESo44KyGCXQN65LLOKbtcP6ukeIAvAhNvpU0bFkp6VopexcQw
	Dv7ljFV5zY/AHq/aatTUNmFb8PTP8Wi56pz1ELmgrsNqf/5Ac4suaaPa9U8Y7PLrphzXTrLGWhi
	CgRrwFYXEYINdhhUGEzq1RgGrrSvTlxzJ8CmDjT0NBXrefrlDDJ0ZamZYLDUIGf9d1W2PaZRa5z
	Dalj/PjjvR1o70zm8/Rpz27jGa/lwogzVJ5q2jX7qzjgQjlzaMS8rySyNbgXJxsU65DEAXzJC+s
	XGn+uTKxNdNfUegHYCohldb9VyjTDEt7qqFopB3aTeKHzw1OGjCa6kSauJ/CPmxKL1hMhdzDWAU
	MYFZWeCL6Ey7l+AUg9zRjBIKPbQFPOdL3fPGiAX3Zc7Gk8OyT20p7mmsrjR+oBwWA7wrpdn5Q1m
	deqFBNjUpjitEFs3Dc2ZwgZm5SPLw2IwyPOEnywKVuFOiccSgJmN1XxwyN4NgQ/zwVF57Xo1qpo
	EFEUqcv20zTucECx8gqH4mhiU/TBafGgiZ04QqFZhcd67nhUvAjy8lWRnK4afuTXImt4MyvSVaV
	G0/86tYIaTlwz7NS/IUFKlT3Qdw8l7mRBigz
X-Received: by 2002:a05:600c:4e0d:b0:4a5:e6fd:65e5 with SMTP id 5b1f17b1804b1-4bb88922a67mr213919275e9.31.1795417310939;
        Sun, 22 Nov 2026 23:01:50 -0800 (PST)
Received: from fedora ([154.182.66.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm20779007f8f.3.2026.11.22.23.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 23:01:50 -0800 (PST)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	giorgitchankvetadze1997@gmail.com,
	amin.gattout@gmail.com,
	antoniu.miclaus@analog.com,
	gregkh@linuxfoundation.org,
	mripard@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v5 4/8] iio: adc: at91_adc: convert to device_property_*() APIs
Date: Mon, 23 Nov 2026 09:00:57 +0200
Message-ID: <20261123070101.53868-5-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
References: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the firmware-agnostic device_property_*() helpers instead of the
OF-specific property readers, so the driver does not depend on a device
node being available in probe.

Update at91_adc_probe_dt_ts() to take a struct device and read its
properties through device_property_read_u32() as well.  Since the helper
no longer uses DT-specific APIs, rename it from at91_adc_probe_dt_ts() to
at91_adc_probe_ts().  This removes the need for a struct device_node
pointer in at91_adc_probe(); as a result, at91_adc_probe_ts() now logs
against dev (&pdev->dev) instead of &idev->dev.

Drop the " in the DT" suffix from the missing property messages to match
the firmware-agnostic property APIs.

With no OF APIs or struct device_node left in the file, drop the
<linux/of.h> include and add <linux/mod_devicetable.h> for struct
of_device_id.

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/iio/adc/at91_adc.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 2a378540837d..b6e6fa77c782 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -15,8 +15,8 @@
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/sched.h>
@@ -790,13 +790,12 @@ static u32 calc_startup_ticks_9x5(u32 startup_time, u32 adc_clk_khz)
 	return ticks;
 }
 
-static int at91_adc_probe_dt_ts(struct device_node *node,
-	struct at91_adc_state *st, struct device *dev)
+static int at91_adc_probe_ts(struct device *dev, struct at91_adc_state *st)
 {
 	int ret;
 	u32 prop;
 
-	ret = of_property_read_u32(node, "atmel,adc-ts-wires", &prop);
+	ret = device_property_read_u32(dev, "atmel,adc-ts-wires", &prop);
 	if (ret) {
 		dev_info(dev, "ADC Touch screen is disabled.\n");
 		return 0;
@@ -815,7 +814,7 @@ static int at91_adc_probe_dt_ts(struct device_node *node,
 	if (!st->caps->has_tsmr)
 		return 0;
 	prop = 0;
-	of_property_read_u32(node, "atmel,adc-ts-pressure-threshold", &prop);
+	device_property_read_u32(dev, "atmel,adc-ts-pressure-threshold", &prop);
 	st->ts_pressure_threshold = prop;
 	if (st->ts_pressure_threshold) {
 		return 0;
@@ -990,7 +989,6 @@ static void at91_ts_unregister(struct at91_adc_state *st)
 static int at91_adc_probe(struct platform_device *pdev)
 {
 	unsigned int prsc, mstrclk, ticks, adc_clk, adc_clk_khz, shtim;
-	struct device_node *node = pdev->dev.of_node;
 	int ret;
 	struct iio_dev *idev;
 	struct at91_adc_state *st;
@@ -1007,32 +1005,34 @@ static int at91_adc_probe(struct platform_device *pdev)
 	if (!st->caps)
 		return -ENODEV;
 
-	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
+	st->use_external = device_property_read_bool(&pdev->dev,
+						     "atmel,adc-use-external-triggers");
 
-	if (of_property_read_u32(node, "atmel,adc-channels-used", &prop))
+	if (device_property_read_u32(&pdev->dev, "atmel,adc-channels-used", &prop))
 		return dev_err_probe(&idev->dev, -EINVAL,
-				     "Missing adc-channels-used property in the DT.\n");
+				     "Missing adc-channels-used property.\n");
 	st->channels_mask = prop;
 
-	st->sleep_mode = of_property_read_bool(node, "atmel,adc-sleep-mode");
+	st->sleep_mode = device_property_read_bool(&pdev->dev,
+						   "atmel,adc-sleep-mode");
 
-	if (of_property_read_u32(node, "atmel,adc-startup-time", &prop))
+	if (device_property_read_u32(&pdev->dev, "atmel,adc-startup-time", &prop))
 		return dev_err_probe(&idev->dev, -EINVAL,
-				     "Missing adc-startup-time property in the DT.\n");
+				     "Missing adc-startup-time property.\n");
 	st->startup_time = prop;
 
 	prop = 0;
-	of_property_read_u32(node, "atmel,adc-sample-hold-time", &prop);
+	device_property_read_u32(&pdev->dev, "atmel,adc-sample-hold-time", &prop);
 	st->sample_hold_time = prop;
 
-	if (of_property_read_u32(node, "atmel,adc-vref", &prop))
+	if (device_property_read_u32(&pdev->dev, "atmel,adc-vref", &prop))
 		return dev_err_probe(&idev->dev, -EINVAL,
-				     "Missing adc-vref property in the DT.\n");
+				     "Missing adc-vref property.\n");
 	st->vref_mv = prop;
 
 	st->res = st->caps->high_res_bits;
 	if (st->caps->low_res_bits &&
-	    !of_property_read_string(node, "atmel,adc-use-res", &s)
+	    !device_property_read_string(&pdev->dev, "atmel,adc-use-res", &s)
 	    && !strcmp(s, "lowres"))
 		st->res = st->caps->low_res_bits;
 
@@ -1043,7 +1043,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 
 	/* Check if touchscreen is supported. */
 	if (st->caps->has_ts) {
-		ret = at91_adc_probe_dt_ts(node, st, &idev->dev);
+		ret = at91_adc_probe_ts(&pdev->dev, st);
 		if (ret)
 			return ret;
 	}
-- 
2.56.0

