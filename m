Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627267;
	b=nGrgpcrSvyTDGnG2tbXnbmZWcS43LWP0OqyhIuqP4YM1/gqwZfVpbmS0nIz3EQRxWLhW
	 LkOV1Ht8rYYThKHmPfRrdZihiwYC0hrpw59K4lWdj3QUTfmrNWFBvEqd828y9aw6+ycnQ
	 k6TWnPPJN9Q4IxCfdWgG9r6llbFnKaOCsTYPQQDxNGXQk9uKnD4XHF709JrA6AbGfqms9
	 CAHuUNQh/Nsm9tqZzm6PXtaN2ZGYUmeGxPgKb/BWkIP6S/jA9mHdRgbHwCJxB+NpYh0Jg
	 lox18KsnR5aYG9QPF6Yb+Ccw0arRSdZIwTRer+4HXEqXpKVHLp6xhOuk56+03ztNAjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Mf2nUSBZHg9n9GyE2dcfq2rqWF1N/c1mtDtHbnucmkk=;
	b=LBIcnpxcoPR/KKXyfji3SUbyFrg70Zv1jBAPjRj9nxLUTTjwTiHKS9kPsh7ZGFISTk5m
	 02lcpXCjJowb340Wpr7FZNProXJ+K79GaweLI8uA91kA4NQO6Tz6brdCYt+gwiwO04kjC
	 zxofOm1bKPmk2Ov8rWL2sWTCd3HV5EzfBgvuuB7YgcnKS+zhsg6IgnS0VsnJ8j+twFgc4
	 3cC+MZ20quj+EjlK6HWVtrkBLrKO8qMu7k4g/uvMBfcgo794HiqbJ+ZQt+vTk/Y5vbWHW
	 OF4r1VLKgA3H6sGiFRNEZ98elJ8qOOZfRAc2ta+TEINMNOGUh6SldVqGBsWHiXCfGhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=bs7IRrXP;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EFC606A31D
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 00:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8EFC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=bs7IRrXP
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35943f55c06so479756eec.0
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 17:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627266; x=1793232066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mf2nUSBZHg9n9GyE2dcfq2rqWF1N/c1mtDtHbnucmkk=;
        b=bs7IRrXP6KaRq8TCe+cmiL9uWNrA0bUEqu7Jsy8dC0OibGUFzA89HuC9kx0yu3s8sJ
         MJtavlPsc87FCp8GTTmg+P5qrcB8tFQJGops1yPhXwKmvBUlP05CJxV4vEbpSSSnYYN/
         113QKNtG0m2PCxLRcpmSzPcL3C9UgoADd1XsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627266; x=1793232066;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mf2nUSBZHg9n9GyE2dcfq2rqWF1N/c1mtDtHbnucmkk=;
        b=u0fJYYRRCtVxCmbREEkaLjoNlW6lTfXhlOAIArSnDmgQa7fOzmCIBHRchUfgPAE1b8
         IZ8qcPf1dUfbND6kH+//QPIsi6JMLPBxXgaosKdW1vtVZOewOwXjA/CNVp/eXZ4oMeI4
         RiNQWBhSK0+9Gi5V7Cof63u9zwKSMDrtLaBJESWdkxuMxJ95dX59gZDlnkLpBbl+DHg4
         GOXeGpehZLZb79zzqBMLIfUHXbnYeOtzKMCEI/FB4MRoF4Nu18dXUmr/W4CVbN8kdGqg
         OQkqcaUxQSJTJgm4M+zG/FtHMtAyqO8zTAyo+FkcRC+OvVVIVY9AEZ/b19uo6B7Q1GuR
         Mjjg==
X-Forwarded-Encrypted: i=1; AKwUvBwdZRp9ZY9RdLDim0GSlFWzU3RpbdZ3DJDJzZMvefZuWPotxqrW6ANSiuFVQ5EisbfT3XzvmFoBgrQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbp4XNm5YqZOqLAGM58OYfb2ZZUkoi3Pwsm3tUsdFLCo2PZTTd
	uRPfk9VhHqQjglQyLZRzv2f0apz/O88b0IGsIY++PCN3GHR1W7f1X3Yh2x9mWY3M4Q==
X-Gm-Gg: AYBFou27JmnSRQlIQEZ25u/gRDVe8ySqv0Qud6j9ipHcKoLsWwt/vqVq6KKTLFFGyxO
	qyiNK3LEqvereyWUxt4Bue3RSAAf7nf5S5v3iHlL3dlTHC88HdpW47vs4plX44nRV3c/7xaaCnz
	aEfwKcQHJSVxux880WVCkQzbwdJXO7dqy4NEqcN++6EUbp94/758fMZ6ILLlX4Yi8PbvKV7HAaw
	nes3YG3luCuPYptl3QJlGCNybGrQiW5vaScp62AlaXjJVOSdcKC0ryE+0ZWD71vN67u1wv1rZmh
	IJIHqUVntQP7zIRIac89+wfsTe4IjJXvTs5Hk617U2+xIRW1KNwtKrZH29WqiPL4bQB4uOCDLjz
	hB+8JVBqbrr20BLTVnlYWKVicxisrPNie7ERkQCTm9c4fQDweCl8ZJZ9e5PmGDOqfDSPSfyrf66
	RR3Q1Bd1JrUeturM3CcSucw6EC4P8PTibJFakhh+LLiVV5rCu6XdUajKsPdbsZFwcKnrbfK38HI
	3MfrRtA5kZHuap5Xb5zJi+hJt2vqGmhSfVrugk2RtZbnGRNHqZxzgCwuND6DbLfpfElumdXwKk3
	O/iP7ssiaKpWNXiYLx8o
X-Received: by 2002:a05:693c:400c:b0:367:a092:3c73 with SMTP id 5a478bee46e88-368b065757fmr1049136eec.12.1792627265560;
        Wed, 21 Oct 2026 17:01:05 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-367411bc89fsm13244263eec.16.2026.10.21.17.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:04 -0700 (PDT)
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
Subject: [PATCH v2 01/17] iio: accel: fxls8962af: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:02 -0700
Message-ID: <20261021165858.v2.1.If2263e6ae9eaa4493881b72922dcde031ce9d81d@changeid>
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
pm_runtime_put_autosuspend() return value, and inline the
fxls8962af_power_off/on() helpers to their callsites, as they're even
more trivial now.

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Rebase to linux-next properly
 * Drop a few drivers' changes, as they stopped checking
   pm_runtime_put_autosuspend() return code already
 * Split iio patch into per-driver patches
 * Inlining

 drivers/iio/accel/fxls8962af-core.c | 56 +++++++++++++----------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 55183c69465d..496e9bf2c4ea 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -205,30 +205,6 @@ enum fxls8962af_int_pin {
 	FXLS8962AF_PIN_INT2,
 };
 
-static int fxls8962af_power_on(struct fxls8962af_data *data)
-{
-	struct device *dev = regmap_get_device(data->regmap);
-	int ret;
-
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret)
-		dev_err(dev, "failed to power on\n");
-
-	return ret;
-}
-
-static int fxls8962af_power_off(struct fxls8962af_data *data)
-{
-	struct device *dev = regmap_get_device(data->regmap);
-	int ret;
-
-	ret = pm_runtime_put_autosuspend(dev);
-	if (ret)
-		dev_err(dev, "failed to power off\n");
-
-	return ret;
-}
-
 static int fxls8962af_standby(struct fxls8962af_data *data)
 {
 	return regmap_clear_bits(data->regmap, FXLS8962AF_SENS_CONFIG1,
@@ -263,16 +239,18 @@ static int fxls8962af_get_out(struct fxls8962af_data *data,
 
 	is_active = fxls8962af_is_active(data);
 	if (!is_active) {
-		ret = fxls8962af_power_on(data);
-		if (ret)
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret) {
+			dev_err(dev, "failed to power on: %d\n", ret);
 			return ret;
+		}
 	}
 
 	ret = regmap_bulk_read(data->regmap, chan->address,
 			       &raw_val, sizeof(data->lower_thres));
 
 	if (!is_active)
-		fxls8962af_power_off(data);
+		pm_runtime_put_autosuspend(dev);
 
 	if (ret) {
 		dev_err(dev, "failed to get out reg 0x%lx\n", chan->address);
@@ -628,6 +606,7 @@ fxls8962af_write_event_config(struct iio_dev *indio_dev,
 			      enum iio_event_direction dir, bool state)
 {
 	struct fxls8962af_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
 	u8 enable_event, enable_bits;
 	int ret, value;
 
@@ -687,18 +666,22 @@ fxls8962af_write_event_config(struct iio_dev *indio_dev,
 
 	if (data->enable_event) {
 		fxls8962af_active(data);
-		ret = fxls8962af_power_on(data);
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret) {
+			dev_err(dev, "failed to power on: %d\n", ret);
+			return ret;
+		}
 	} else {
 		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
 
 		/* Not in buffered mode so disable power */
-		ret = fxls8962af_power_off(data);
+		pm_runtime_put_autosuspend(dev);
 
 		iio_device_release_direct(indio_dev);
 	}
 
-	return ret;
+	return 0;
 }
 
 static const struct iio_event_spec fxls8962af_event[] = {
@@ -840,7 +823,15 @@ static int __fxls8962af_fifo_set_mode(struct fxls8962af_data *data, bool onoff)
 
 static int fxls8962af_buffer_preenable(struct iio_dev *indio_dev)
 {
-	return fxls8962af_power_on(iio_priv(indio_dev));
+	struct fxls8962af_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		dev_err(dev, "failed to power on: %d\n", ret);
+
+	return ret;
 }
 
 static int fxls8962af_buffer_postenable(struct iio_dev *indio_dev)
@@ -889,9 +880,10 @@ static int fxls8962af_buffer_predisable(struct iio_dev *indio_dev)
 static int fxls8962af_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct fxls8962af_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
 
 	if (!data->enable_event)
-		fxls8962af_power_off(data);
+		pm_runtime_put_autosuspend(dev);
 
 	return 0;
 }
-- 
2.56.0.218.g1ec904b173-goog

