Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243501;
	b=nhgVv6kAusdLmUtvJT545WZ1rairNKhOZEo1cyIkiSyPo9EdOlqOlaDdmroL0aFLMGcI
	 O4Vp+k/rdD+CUCK4kIq3Dsz2rWuBWXBU0+7iU8q/DDkz40HaR1g92GK5Aj1VCXAfOR6e0
	 9xzBuxcb+MbAzJM6BrqNs0ME36wogclpj6ku5QkofEzeGvdD4ghb+SxhreYzLz2WWvRBg
	 74FsjoibI0BrtRHh8IbySizhMneePrM8X7PWilKrtAh1WCvsaSp9mwywthaRlh9rbWeYs
	 rxSBQt1OVBgHRakH51RCfaRRO3/GrR8UHSKe77SxeBaXaRQonmI9UGfskqPBmt9RgvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243501;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AjZ0gkuST9kJnYFKaJfinARuiAaOZL0xMfhNAvmAhqM=;
	b=FmfwDg+soYzN6HX0TciHKRe7nmux3hENBAEfsRTXP5dkcDkfnfIjwMct3q4J0pCekMkp
	 CoXskKZbjZExuXXop66LaSzq2hC8P2As/IbMuqyhqzYyuFv78FdKaaFehJnEBa/ALUi3x
	 Ddf8EJDbvECZboNdA2xR1lfpioXr++kUzlvkyvlSRQLsbY/w6ZeOQaHC1OMv+hzwsBCVu
	 gQjnO3kKqcS/J6+1p4NDQGrsLvu3861nFjEXmwGq41Tj2wW8+eW1JyciyRoF09LOo5Y1C
	 j1m03crDBsRRuup7epLxbDhoKAsM7HwzJsda1kZgMylFRYJ3Tmfd76dHmR9NBkIRKXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l7kQuGUK;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA1B606A433
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 16:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FA1B606A433
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l7kQuGUK
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso628824a91.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 08:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243500; x=1794848300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AjZ0gkuST9kJnYFKaJfinARuiAaOZL0xMfhNAvmAhqM=;
        b=l7kQuGUKcub1ZV97fvktn/GUOJUXtjOg+LcyhTWzGFtMo2yRArgz4schVwFw9Vm0Rm
         QPWP/5yhu2Y7kwZ5mMBUdljQwynDg0eGVElnWRqN0jhoCdpnY/Nz3eAFdngNoQQdfL6y
         0icFLmQUVo7Lq8rDnaSfD1fun1Z4zrN7IurNV/i/iKiS8peCVE6F1B38QUSmQ89pZhDh
         VUwxgFsayFy4RQzKKl+Jcm7wO3dwElTUCs32J+sf3iWPuhPLU6aqkE+bU/3xRAtbuEpj
         oEQl4+SwOKba1OTvC/KYhyKCQQCIEw425kwplG/RU2qL53zWiXrOFS4ecFZc7PtAP90C
         VBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243500; x=1794848300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AjZ0gkuST9kJnYFKaJfinARuiAaOZL0xMfhNAvmAhqM=;
        b=cet14oXIkiar9ThpviPEMSJGTVHgGB0L9I37orHl7ZXi5v9woEsPLp9OH+Of/Kmu2P
         df/wpP0b82JNPX0TPcuo3p1/tBmegl0XtGUj+bx9T76/Z75gWrGtlq/Vsm/TYltZFuHW
         OyLOx8UoUNmyyKyZAU1xKgpVlkZCQPacJqbJPfArSW78ubnfN+6uPzSLbedOC1MOSEfa
         ItRrtfM9nfhpL/zVyauzZjf6Sr1XUj3EcL92p54z0I3O8lylGmenlTuucrhPsIP8mMT6
         bDX/HTLoJ56L15wFFHnYl87funlbMQDGqLQjK5nhXyEnNoS1ZxeI+qUgSynKXaf5EjLJ
         ueOA==
X-Forwarded-Encrypted: i=1; AL+hErHuLkfpnj9awkEC5B97GwFMGxgE6VlOA81k2UyWo4QDXVChNoqWx3kl0GaC3eNq3kZSgzeK9kXNDaA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TdeNs66NN+DcMqaiYvNj7ifRQEFxY3eFKcXUXohFquMtyiCrW
	0VV5tpEUPfN9GhOnlegZb3BOFdO2q1TzjE7WAml9HLOpOwRCk7YgCk+S
X-Gm-Gg: AYBFou3JwDoDELZvylcZUFB6SIrllAh452umzTEL4OG9YAmsMcfUe7fO+lUqvtJstc5
	dMoeA863y7KIWIYRSgKg9hxtzWscbsnQSUNIncln2LvK7Xy/y0zOKR9ZIm5bIJmbvh4PANH2qmf
	A/b1WsghbW4wEaYvlEgHDCUFf2xDgF+Lv6sKYSDeJGIYQ0sPLTc+lhoLEZYx/iEBbDDh26UCpFw
	pWWB0UGHJPFGfhYPKrO0cqfTtYqD9SwBPdgJDZQRP6y0aj5vc8W+etaft5GBdOXB3b+P0E/9uxc
	FaMSPulAcVkO59OK23bz+TeMahzoqKsBbNTxmAna4FICGa2ehoSsRo2zKC+yVwxgOeidwNl5jZi
	AyGAoNW/pO/WqE/zfetAL8BQSll1r6X22diB0Y85R+QY1HXk4UUDLG+1YCNLDSy2zAqWIBESmzx
	bDb1g+GjY9xRvwbpuOSS2LMbyjYsTowYQIir3PvazIArFYfCBQOeMZS9Xx0kJEOM7kMUJ0+qncO
	k75wVsiaqC96LFFN1W156jl+t9g7IPJYZQBTMsJKxOOdOHhJs3uF03jZxqG2ZgMqay8wX9BiOrs
	uA0I9W76vys/E+tmnlsksl71dHfc63fPAzUMkk6rQZhqKkomV1LmNFF+OHQKPgrgoLEvPHYlou4
	a+2va
X-Received: by 2002:a17:90a:e7d0:b0:3a8:5fd6:cb6 with SMTP id 98e67ed59e1d1-3b166a5fb0bmr272689a91.0.1794243499914;
        Mon, 09 Nov 2026 08:58:19 -0800 (PST)
Received: from debian.ari ([152.56.156.124])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16779cf05sm138766a91.3.2026.11.09.08.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:58:17 -0800 (PST)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com
Subject: [PATCH v6 06/11] iio: adc: ti-ads1015: Remove ads1015_set_power_state()
Date: Mon,  9 Nov 2026 22:28:00 +0530
Message-Id: <20261109165805.31160-1-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
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

Remove the unnecessary ads1015_set_power_state() helper and
use runtime PM helpers directly at the call sites.

Use PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND() to manage the
runtime PM reference in __ads1015_read_info_raw(), ensuring
it is automatically released on function exit, including
error paths.

For event configuration and buffer operations, retain
explicit reference management as the runtime PM reference
must remain held beyond the lifetime of the respective
function.

Mark the device as last busy before putting it into
autosuspend.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 59 +++++++++++++++---------------------
 1 file changed, 24 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 9fd07ee21ede8..2e6bf45871340 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -366,30 +366,6 @@ static const struct iio_chan_spec tla2024_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(ADS1015_TIMESTAMP),
 };
 
-
-#ifdef CONFIG_PM
-static int ads1015_set_power_state(struct ads1015_data *data, bool on)
-{
-	int ret;
-	struct device *dev = regmap_get_device(data->regmap);
-
-	if (on)
-		ret = pm_runtime_resume_and_get(dev);
-	else
-		ret = pm_runtime_put_autosuspend(dev);
-
-	return ret < 0 ? ret : 0;
-}
-
-#else /* !CONFIG_PM */
-
-static int ads1015_set_power_state(struct ads1015_data *data, bool on)
-{
-	return 0;
-}
-
-#endif /* !CONFIG_PM */
-
 static
 int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
 {
@@ -532,26 +508,26 @@ static int ads1015_read_avail(struct iio_dev *indio_dev,
 static int __ads1015_read_info_raw(struct ads1015_data *data,
 				   struct iio_chan_spec const *chan, int *val)
 {
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
 	if (ads1015_event_channel_enabled(data) &&
 	    data->event_channel != chan->address)
 		return -EBUSY;
 
-	ret = ads1015_set_power_state(data, true);
-	if (ret < 0)
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev, guard);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&guard);
+	if (ret)
 		return ret;
 
 	ret = ads1015_get_adc_result(data, chan->address, val);
-	if (ret < 0) {
-		ads1015_set_power_state(data, false);
+	if (ret < 0)
 		return ret;
-	}
 
 	*val = sign_extend32(*val >> chan->scan_type.shift,
 			     chan->scan_type.realbits - 1);
 
-	return ads1015_set_power_state(data, false);
+	return 0;
 }
 
 static int ads1015_read_raw(struct iio_dev *indio_dev,
@@ -709,6 +685,7 @@ static int ads1015_enable_event_config(struct ads1015_data *data,
 {
 	int low_thresh = data->thresh_data[chan->address].low_thresh;
 	int high_thresh = data->thresh_data[chan->address].high_thresh;
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 	unsigned int val;
 
@@ -735,7 +712,7 @@ static int ads1015_enable_event_config(struct ads1015_data *data,
 	if (ret)
 		return ret;
 
-	ret = ads1015_set_power_state(data, true);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		return ret;
 
@@ -744,7 +721,8 @@ static int ads1015_enable_event_config(struct ads1015_data *data,
 	ret = ads1015_get_adc_result(data, chan->address, &val);
 	if (ret) {
 		ads1015_event_channel_disable(data, chan->address);
-		ads1015_set_power_state(data, false);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
 	}
 
 	return ret;
@@ -753,6 +731,7 @@ static int ads1015_enable_event_config(struct ads1015_data *data,
 static int ads1015_disable_event_config(struct ads1015_data *data,
 	const struct iio_chan_spec *chan, int comp_mode)
 {
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
 	if (!ads1015_event_channel_enabled(data))
@@ -774,7 +753,10 @@ static int ads1015_disable_event_config(struct ads1015_data *data,
 
 	ads1015_event_channel_disable(data, chan->address);
 
-	return ads1015_set_power_state(data, false);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
 }
 
 static int ads1015_write_event_config(struct iio_dev *indio_dev,
@@ -830,17 +812,24 @@ static irqreturn_t ads1015_event_handler(int irq, void *priv)
 static int ads1015_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct ads1015_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
 
 	/* Prevent from enabling both buffer and event at a time */
 	if (ads1015_event_channel_enabled(data))
 		return -EBUSY;
 
-	return ads1015_set_power_state(iio_priv(indio_dev), true);
+	return pm_runtime_resume_and_get(dev);
 }
 
 static int ads1015_buffer_postdisable(struct iio_dev *indio_dev)
 {
-	return ads1015_set_power_state(iio_priv(indio_dev), false);
+	struct ads1015_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
 }
 
 static const struct iio_buffer_setup_ops ads1015_buffer_setup_ops = {
-- 
2.39.5

