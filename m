Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627287;
	b=I8MTj+wYQ0dGvCjnm64B83lOERYzxhWDNYWNILYXx7Io63RnYEXbEBd3xoN5MZz1dMKO
	 eJN1YYrD3vnKRZL8P0gPnZE5Uu974Gx6Uqy5UkPxhxXKlIYQnTdNv2XClEiOtWJD+wftf
	 +2Ziu3m++dDLKACkCCMHgiRe8bQk9EUbfAOIBKxHY0pPQLrSfM4cAE6r35K9sANNBa9Sq
	 Q5iNUYhGktpbhHPmZjTBl0+piHhZoD5Lwtco/V8coY0740zLxqjqKYV5spyh/xqskczr5
	 op7Udx/nxqHg3TTmkZ27jB1VI5a4kZ4+jmKtsqEnNWResEX8nNpdJDMSzzKJg6hR8QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627287;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1uqPCq3qxm+fw1hPGBE2UXSjTZOflrZR/TS0Ft0vAgA=;
	b=i7Z6SJQKWRCIpNb7i3AletHFUB00qEsrSZUj9KlMIZNJliu2SnDzbCS9gj4+stVPSH26
	 p99vAPJoWJEDd4KHnmpCR2zEOVmx4VDUZEo7/uqoE6/29YsS0QcOZNRYj14H/8lHDuEdJ
	 h3dt5EmLY7hEnehZGPgS3VTVoop0Ix19Rjp+Dm2JxFcBksyaKS5X2ZNtR9B4TmeVUdDIf
	 NYVYJpM0C7690cUtvjd/s9bADa3wVdLgb1CHBJbDu5Ex5ge/POPbgtQljZ01MaRjHir3Q
	 MPvJ0awTL34ai6GMCS3Lh4NEj8Fj1JCmYViajpX+uSOnWsjSCukuHMZQs+M4T2d+Fxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="buQiQ/D3";
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAE460A262F
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 00:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECAE460A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=buQiQ/D3
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35c76e9614aso2320827eec.0
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 17:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627286; x=1793232086; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1uqPCq3qxm+fw1hPGBE2UXSjTZOflrZR/TS0Ft0vAgA=;
        b=buQiQ/D3DAXlEypzLtAc/t9usf8mNTUED8VNz4jhlaYhRYbrcB8G2APPcGr7JXYBdV
         z6cysmNgjTPY/AjuXOHTwA+xfg/2i/tYOGz4RyyEXjexC2X6BmAYFze6sZ2cYSaX9Xq9
         q7Yo4+2gAFIsEEy6rcf9nfXlWOKkDSqe4UmqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627286; x=1793232086;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1uqPCq3qxm+fw1hPGBE2UXSjTZOflrZR/TS0Ft0vAgA=;
        b=Hpmsme2Wk5QIu04DkUmAFrYS+3i3n8ng02OWLdIigiIX1XYHu/NzAnfDnq6rsSNLLx
         SToRUovNnI5kXgXz5U5ehp1MzWAoQk1tCih0ebF/1grGZI5MGax3SchgDbtE1lt3hvti
         KSlX8jcAoCwYIRY4jzP01nStlZfYQkCPGDQuiDfjULtaGve3+A+VKfESKw1W2IY79OGL
         f1VAZZeyLx5tZmkT149h5sr7oDYACcH1i0182gZLY0AlynhIanp8R1TV+td+9enfKd1U
         3Y5OB5EpmLMwVLeIze2waXMLs2aNIvYlvjvTWAdULhCVMxcO+CMg4CqsizE3y1wCv0tW
         cA3g==
X-Forwarded-Encrypted: i=1; AKwUvBxGah0KYTeB0DM67PZpxcCMxWjQN/4mYjHuegB1h3l+Krra8WMaBpSzlsF2B+pzYQly8oaF9Yaytjw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5yRKXiHIFMmnGDAyCgs9DvzcyGdrtIwEyMOxwBml4y0O6jY24
	ROJ/mrDw3KT1D/JBs5vf6wJFLWDmVnDkvbbb8B+4Jyb+Ud2mCqW8GBJ8DL4IsLL22Q==
X-Gm-Gg: AYBFou0BcfVXv3bOisHA9LjF5FMYkoREFSC4G6rAMwE1JxU3nBWaowJXZ6ZSD4bPiF5
	E1MH6a4eDZnwsaxVeL7QaAkDjN6T3dcaTD9wwS4Cbwt4Mdo4RSIMxHM6PUvRpm5XYl/02Yz5Fzh
	BDGURvNtLClY99aAm0Od02BiuovCDcuRkkTNizeuN7zwE2SKZCV8eEt0T8APaeK4NVdEthD8Dxj
	hIn9vncKBIbAiBt80HgbAaXaAI2zPK26yJooMCmf+qcTNdGwaB37cUhWbDwRGqC6iZeWZC7TGxz
	un2Xz2o1m1XRHP3jAlQ3X8eFr9ZKNmo/6hTuVpcLESMeByDdP+aaufqlAxrUnJDS8tYeV2nuGVm
	kD/KtbrQxcLewZMT+oWm/fe6JaOVRrQvtoUie1sQj9P8tO4TW7q3kNhOaQTCghfV5rJ8RxmK9Se
	m/EuGDJZGwY3upJ4IlHOijCO4WcHs4bLwsQwJizrXn5U/QxLqeER/rVqQnGNFUaeAnh3xES2D75
	DuPq2fIGppNLgLfsbgkRI2nFSWXEc0/SLBzouqNaIN4GhPH186yIlg9Y8DCJCM25aUCO9b/G8bU
	psL+fC0ZvVovIT82r1f2EpaSdl4NIIKiT5v9AGIq
X-Received: by 2002:a05:693c:41c2:20b0:366:2893:7429 with SMTP id 5a478bee46e88-3674e0501e2mr4574299eec.24.1792627285985;
        Wed, 21 Oct 2026 17:01:25 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3674198f1d8sm15879892eec.24.2026.10.21.17.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:25 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/17] iio: adc: ti-ads1015: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:08 -0700
Message-ID: <20261021165858.v2.7.Ib4e8fc11192ec5721b98bd85fa9a68d3349ba9e8@changeid>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021235818.3059519-1-briannorris@chromium.org>
References: <20261021235818.3059519-1-briannorris@chromium.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This driver propagates the return value of pm_runtime_put_autosuspend(),
which is not particularly useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

For this reason, modify this driver to simply discard the
pm_runtime_put_autosuspend() return value. Inline
ads1015_set_power_state() while we're at it, since its behavior is now
the same with and without CONFIG_PM, and it is otherwise trivial.

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Split iio patch into per-driver patches
 * Inlining

 drivers/iio/adc/ti-ads1015.c | 50 +++++++++++++-----------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 0f9244107c6d..a677ec7abda2 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -367,30 +367,6 @@ static const struct iio_chan_spec tla2024_channels[] = {
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
@@ -533,26 +509,29 @@ static int ads1015_read_avail(struct iio_dev *indio_dev,
 static int __ads1015_read_info_raw(struct ads1015_data *data,
 				   struct iio_chan_spec const *chan, int *val)
 {
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
 	if (ads1015_event_channel_enabled(data) &&
 	    data->event_channel != chan->address)
 		return -EBUSY;
 
-	ret = ads1015_set_power_state(data, true);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		return ret;
 
 	ret = ads1015_get_adc_result(data, chan->address, val);
 	if (ret < 0) {
-		ads1015_set_power_state(data, false);
+		pm_runtime_put_autosuspend(dev);
 		return ret;
 	}
 
 	*val = sign_extend32(*val >> chan->scan_type.shift,
 			     chan->scan_type.realbits - 1);
 
-	return ads1015_set_power_state(data, false);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
 }
 
 static int ads1015_read_raw(struct iio_dev *indio_dev,
@@ -708,6 +687,7 @@ static int ads1015_read_event_config(struct iio_dev *indio_dev,
 static int ads1015_enable_event_config(struct ads1015_data *data,
 	const struct iio_chan_spec *chan, int comp_mode)
 {
+	struct device *dev = regmap_get_device(data->regmap);
 	int low_thresh = data->thresh_data[chan->address].low_thresh;
 	int high_thresh = data->thresh_data[chan->address].high_thresh;
 	int ret;
@@ -736,7 +716,7 @@ static int ads1015_enable_event_config(struct ads1015_data *data,
 	if (ret)
 		return ret;
 
-	ret = ads1015_set_power_state(data, true);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		return ret;
 
@@ -745,7 +725,7 @@ static int ads1015_enable_event_config(struct ads1015_data *data,
 	ret = ads1015_get_adc_result(data, chan->address, &val);
 	if (ret) {
 		ads1015_event_channel_disable(data, chan->address);
-		ads1015_set_power_state(data, false);
+		pm_runtime_put_autosuspend(dev);
 	}
 
 	return ret;
@@ -775,7 +755,9 @@ static int ads1015_disable_event_config(struct ads1015_data *data,
 
 	ads1015_event_channel_disable(data, chan->address);
 
-	return ads1015_set_power_state(data, false);
+	pm_runtime_put_autosuspend(regmap_get_device(data->regmap));
+
+	return 0;
 }
 
 static int ads1015_write_event_config(struct iio_dev *indio_dev,
@@ -836,12 +818,16 @@ static int ads1015_buffer_preenable(struct iio_dev *indio_dev)
 	if (ads1015_event_channel_enabled(data))
 		return -EBUSY;
 
-	return ads1015_set_power_state(iio_priv(indio_dev), true);
+	return pm_runtime_resume_and_get(regmap_get_device(data->regmap));
 }
 
 static int ads1015_buffer_postdisable(struct iio_dev *indio_dev)
 {
-	return ads1015_set_power_state(iio_priv(indio_dev), false);
+	struct ads1015_data *data = iio_priv(indio_dev);
+
+	pm_runtime_put_autosuspend(regmap_get_device(data->regmap));
+
+	return 0;
 }
 
 static const struct iio_buffer_setup_ops ads1015_buffer_setup_ops = {
-- 
2.56.0.218.g1ec904b173-goog

