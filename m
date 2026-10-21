Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627269;
	b=pWY+xNfmz7T7xRGqgx0CAxToyLdf0NDWLHcjc0ScoYdS/tiPLmY+tMZb07MzIuP7Y+YJ
	 AODZRdbmSGAnfI2ajUBLxAhy2PuR0F5l+0t5jjq+B/hGyiab+vNwdGolzsVEQjtnl+vTd
	 WHxs26TVGPZ4IJkdTwjJ3dkfZok5qPt0mftg/sVqFPSOmP7x44Mz4JMbFQJ3L4PSz4nu0
	 WiM3RGOQJ+gGGOcx1qlDs+d9s3Hw2aNNizHsB2CVtSrugwmidH30sK5sRSFDjggHvNbUv
	 B+b1gsWRuE2PgMq/KHyYdMFxc7mu3/23VK3VareWTVqI11caR0cHRaZxgAzHCXPBiTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hMGgPP85DFQu9hbngVx2g7BpXJDGYisOgRGo0IKCMAU=;
	b=uPleyJ6cW8ZSWSRhiCz67/UfBjK0Pcwp2HAW9qVjIMFGOrB5BPrHBLWWjQprnTCfatP/
	 64WE1IiPoE9Lf/We9PpjcONdnz/kdJJjTuxiMY0+zZFSTZJDnpfH5+IQ9u209rVg4TrZr
	 5+Js/aMeXEp9INepEilQ3UfBKxY6B8sRtv5Uh102594aovdHNhQpvIzDXmVfO7QXqjV8V
	 khabqD1Z6s+cqXTRfpHb26ydLfSr+qK5I+5tVImA8lOZpBX+kWr2J12RnKOgz2ox5VcgU
	 T1k7uoexyR9AHjDJk6UgLPN/UE5D6tXxDilr1se6cENF2EjLk89zwgS3V/oElhDkY4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=CI2KYKat;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E8E606A339
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 00:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53E8E606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=CI2KYKat
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3535a54bed9so1800675eec.1
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 17:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627268; x=1793232068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hMGgPP85DFQu9hbngVx2g7BpXJDGYisOgRGo0IKCMAU=;
        b=CI2KYKatbUKrY8dO0Lb+6UX/nnuMlRRPgr+fuUGKfA88XIqIcL+uJhB2YF3HL8jIYj
         G+46SC7OdS3XuCMHRE2sPiYJxe4QRp7DFHIB7DPcukm+AYkkpyKdxVocnCOWpM0VK5QX
         q9n6MBZ64W4GP9pMzy9lU246pzZhiy1jiumgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627268; x=1793232068;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hMGgPP85DFQu9hbngVx2g7BpXJDGYisOgRGo0IKCMAU=;
        b=fMNMm0OOiRuQMMZ9A0ahPaMUnnTv6+9gbXHb8tV7RePCLKmbS52P/9RYwST12YJI8y
         0r4M71D+T7ErDoUknERXe3FXVkQsWw9xbOW03W6AzTPwb3ADppxfrR3ec8o4Y2gkNzK2
         QPJvwTN02p3n5reZoqEjyZexofjSaCT4nteDr7szOZ2ecCoBADbuVnGTXfqIkN/bkV9x
         0nXgR8Lz70AFyjttX9GPvDgdBBxXbUaueH51l7Qo/p5RWwL+/SrjZi0eibG6fQLnqxtr
         17eOdO3ahLlXs7PxV7p5MGh8fWX3BvKUUzwJWsHqyCqN2oO/+GtpwWu8w9yRTeRvNoJI
         ANWQ==
X-Forwarded-Encrypted: i=1; AKwUvBwrCjasUzVZENZm3y0Zl/wZdv+TG0XJMaWLh3nvleGcTz3wc5nrsezuT4hypRZqwNOF2zFD2luMyqQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLly9DvuSemafvDOefj+6+omcrusm8WIhcFvzQweHKEQ8/2wr00
	dBY5/ervmUL9VC8ypAVl3GMPk4TPTRjoxHWzLiHI7JNirEYXDw/usFaML/THunpOzg==
X-Gm-Gg: AYBFou20CN+RqRlMB3L7qvIL25s/P01CMQrY+cIVkCvXFA/1cV1HwLOqTHh2E30VQPD
	p09ENjJue99L6Ygi6wYnar8A4B/UQZcIcMcsIFB/3FFttqr6henlTLhpBOK/VKAMCTUe5x/Kcyg
	7isqo6TwsyY49PLTPAgvraj+HUEELH6dgFb+C4y9ELm5k0vD85At5jt0ue/1CXm/6q/DAdnBmk6
	O+oPxq1ewxojwiYb2Eao+IANyHJ/zcjdQ2yyGDJ/Sul3QmPIj/m7fq5zf/f5+JvWaNBx+7aOfIG
	qw+I3OJxzKzkFyI7FJ4Lwf8J/Z71XHFfxFetYMCqkcPHMn2ybo/zVuHEbEHx+anKGgXsdqmFLEK
	imDY5YyiA73sDK5gjqFosuGb6wbVwDoziaUynaq2+6atyphN4Vo4Sfz9O2+wuvJeSsdCnVQUGrX
	VL+wMPHDRr6haYkkmd+7yNoEKHlYiEk9pMM4Bg1dwrqg5wP1G9ECS2luJd2BS50LhHlOus6DvGZ
	KEc0k95wfSFMZ2hu4xT40Hf+UWbThR3wuZuHjBHPrklKTXiO1P5sYQg+CwMK69Jvv3eFiNxFlVf
	xs3hUtYLBzYCbuS3Z+E=
X-Received: by 2002:a05:7301:7105:b0:351:5151:95d9 with SMTP id 5a478bee46e88-3674a407399mr5510609eec.3.1792627268226;
        Wed, 21 Oct 2026 17:01:08 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3674198fb21sm10838784eec.23.2026.10.21.17.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:07 -0700 (PDT)
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
Subject: [PATCH v2 02/17] iio: accel: kxcjk-1013: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:03 -0700
Message-ID: <20261021165858.v2.2.I7751f8c9dde6f4a576a17dcfa13a4c729fa748b4@changeid>
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

For this reason, modify this driver to discard the
pm_runtime_put_autosuspend() return value, and inline these pm_runtime
calls for simplicity.

While doing this, it becomes obvious that kxcjk1013_write_event_config()
and kxcjk1013_data_rdy_trigger_set_state() are intentionally mismanaging
runtime PM reference counts and instead are relying on (racy)
autosuspend delay for correct ordering. Undo this choice, and instead
properly drop the reference count only after we're done touching the
hardware.

Use guard() for managing the mutex in kxcjk1013_write_event_config(),
because it helps simplify the above refactoring, making it less
error-prone.

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Split iio patch into per-driver patches
 * Inlining
 * Refcount ordering fixes

 drivers/iio/accel/kxcjk-1013.c | 118 ++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 61 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index b3d753bd9476..3b1a8e67b266 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -13,6 +13,7 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
@@ -628,25 +629,6 @@ static int kxcjk1013_get_startup_times(struct kxcjk1013_data *data)
 	return KXCJK1013_MAX_STARTUP_TIME_US;
 }
 
-static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
-{
-#ifdef CONFIG_PM
-	int ret;
-
-	if (on)
-		ret = pm_runtime_resume_and_get(&data->client->dev);
-	else
-		ret = pm_runtime_put_autosuspend(&data->client->dev);
-	if (ret < 0) {
-		dev_err(&data->client->dev,
-			"Failed: %s for %d\n", __func__, on);
-		return ret;
-	}
-#endif
-
-	return 0;
-}
-
 static int kxcjk1013_chip_update_thresholds(struct kxcjk1013_data *data)
 {
 	const struct kx_chipset_regs *regs = data->info->regs;
@@ -895,20 +877,22 @@ static int kxcjk1013_read_raw(struct iio_dev *indio_dev,
 		if (iio_buffer_enabled(indio_dev))
 			ret = -EBUSY;
 		else {
-			ret = kxcjk1013_set_power_state(data, true);
+			ret = pm_runtime_resume_and_get(&data->client->dev);
 			if (ret < 0) {
+				dev_err(&data->client->dev,
+					"failed to resume: %d\n", ret);
 				mutex_unlock(&data->mutex);
 				return ret;
 			}
 			ret = kxcjk1013_get_acc_reg(data, chan->scan_index);
 			if (ret < 0) {
-				kxcjk1013_set_power_state(data, false);
+				pm_runtime_put_autosuspend(&data->client->dev);
 				mutex_unlock(&data->mutex);
 				return ret;
 			}
 			*val = sign_extend32(ret >> chan->scan_type.shift,
 					     chan->scan_type.realbits - 1);
-			ret = kxcjk1013_set_power_state(data, false);
+			pm_runtime_put_autosuspend(&data->client->dev);
 		}
 		mutex_unlock(&data->mutex);
 
@@ -1033,39 +1017,35 @@ static int kxcjk1013_write_event_config(struct iio_dev *indio_dev,
 	if (state == data->ev_enable_state)
 		return 0;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	if (!state && data->motion_trigger_on) {
 		data->ev_enable_state = 0;
-		mutex_unlock(&data->mutex);
 		return 0;
 	}
 
-	/*
-	 * We will expect the enable and disable to do operation in
-	 * reverse order. This will happen here anyway as our
-	 * resume operation uses sync mode runtime pm calls, the
-	 * suspend operation will be delayed by autosuspend delay
-	 * So the disable operation will still happen in reverse of
-	 * enable operation. When runtime pm is disabled the mode
-	 * is always on so sequence doesn't matter
-	 */
-	ret = kxcjk1013_set_power_state(data, state);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
-		return ret;
-	}
+	if (state) {
+		ret = pm_runtime_resume_and_get(&data->client->dev);
+		if (ret < 0) {
+			dev_err(&data->client->dev, "failed to resume: %d\n",
+				ret);
+			return ret;
+		}
 
-	ret =  kxcjk1013_setup_interrupt(data, state, false);
-	if (ret < 0) {
-		kxcjk1013_set_power_state(data, false);
-		data->ev_enable_state = 0;
-		mutex_unlock(&data->mutex);
-		return ret;
+		ret = kxcjk1013_setup_interrupt(data, true, false);
+		if (ret < 0) {
+			pm_runtime_put_autosuspend(&data->client->dev);
+			return ret;
+		}
+	} else {
+		ret = kxcjk1013_setup_interrupt(data, false, false);
+		if (ret < 0)
+			return ret;
+
+		pm_runtime_put_autosuspend(&data->client->dev);
 	}
 
 	data->ev_enable_state = state;
-	mutex_unlock(&data->mutex);
 
 	return 0;
 }
@@ -1073,15 +1053,22 @@ static int kxcjk1013_write_event_config(struct iio_dev *indio_dev,
 static int kxcjk1013_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	int ret;
 
-	return kxcjk1013_set_power_state(data, true);
+	ret = pm_runtime_resume_and_get(&data->client->dev);
+	if (ret < 0)
+		dev_err(&data->client->dev, "failed to resume: %d\n", ret);
+
+	return ret;
 }
 
 static int kxcjk1013_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
 
-	return kxcjk1013_set_power_state(data, false);
+	pm_runtime_put_autosuspend(&data->client->dev);
+
+	return 0;
 }
 
 static ssize_t kxcjk1013_get_samp_freq_avail(struct device *dev,
@@ -1224,32 +1211,41 @@ static int kxcjk1013_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	if (!state && data->ev_enable_state && data->motion_trigger_on) {
 		data->motion_trigger_on = false;
-		mutex_unlock(&data->mutex);
 		return 0;
 	}
 
-	ret = kxcjk1013_set_power_state(data, state);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
-		return ret;
-	}
-	ret = kxcjk1013_setup_interrupt(data, state, data->motion_trig != trig);
-	if (ret < 0) {
-		kxcjk1013_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
-		return ret;
+	if (state) {
+		ret = pm_runtime_resume_and_get(&data->client->dev);
+		if (ret < 0) {
+			dev_err(&data->client->dev, "failed to resume: %d\n",
+				ret);
+			return ret;
+		}
+
+		ret = kxcjk1013_setup_interrupt(data, true,
+						data->motion_trig != trig);
+		if (ret < 0) {
+			pm_runtime_put_autosuspend(&data->client->dev);
+			return ret;
+		}
+	} else {
+		ret = kxcjk1013_setup_interrupt(data, false,
+						data->motion_trig != trig);
+		if (ret < 0)
+			return ret;
+
+		pm_runtime_put_autosuspend(&data->client->dev);
 	}
+
 	if (data->motion_trig == trig)
 		data->motion_trigger_on = state;
 	else
 		data->dready_trigger_on = state;
 
-	mutex_unlock(&data->mutex);
-
 	return 0;
 }
 
-- 
2.56.0.218.g1ec904b173-goog

