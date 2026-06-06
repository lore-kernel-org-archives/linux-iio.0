Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0829E3859D7
	for <linux-iio@vger.kernel.org>; Sat,  6 Jun 2026 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780745896; cv=none; b=kXTpdZm+s8aL3At7q75pIttYwhMePzCvppo4bf+m6wJYLMyUvx6Fq5zZVKUhN0ZFgywGNlxstcaEBcWEbCTGBDvbutWjpYaCBp879lEdlDllEv1A7HPxUc2acOdD1M5iy6vSLwVD+Iqvzhz/vc/ETz2ApLWkCt7KyYlfdb7nRXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780745896; c=relaxed/simple;
	bh=ff0ydlbObc/H3M0SwnPzFnKsj50WYoQR9JEzihmmciE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZIDLrwFXMwDamllnc45wZc+ai+yp0tQCGQkIOIidz2H9GAU+8wY5zpOJSm3nVzno0OpcDqGMIUFEov+ARrnwnSLMFyY0dmF81WuoSVNZYvMt47GxIrMF1w0ZWqq9Fuy/hfLvPqiZd8UM9NkTN9z2YVny5hxJDaZ+QyxqJUXB16E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQxLh2iB; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQxLh2iB"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36bdda53d99so1220967a91.0
        for <linux-iio@vger.kernel.org>; Sat, 06 Jun 2026 04:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780745894; x=1781350694; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/MHiUlYgig4GdSzSIIBUKvbsbnQklzRwQhWCjskiuk=;
        b=XQxLh2iBj7mPN4taL248dJzK7lM+4LKdshpMvjszx25yFCIF3h4t/CCuEmPgcF5M+v
         EQTG6KGbkJa41ykds2cWxDOgmWoZw5UJ1KtRG8DkrEirNS+snTRVofd6g1cViabr7yXv
         b3mwcbMH7IV6WT/avc/gXo/Ki3Bw8EDIBufp+9cq1zv8jk+Zq8uamMPPhuwQ9Ooae8Vf
         ulyFoklLIlmoS6szPuv70iTmVIpUVPzz2dSyDOxW+oLU0KLGV4xeJ5TlwCzH0wATFcI1
         unHCsZvYTl1Y/eXNZvAZSocW/gO9nDNGotbSHRP+ThSyOwnEqr1Hql66iFcwfMLMdGNY
         I2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780745894; x=1781350694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L/MHiUlYgig4GdSzSIIBUKvbsbnQklzRwQhWCjskiuk=;
        b=dMuqUgpO6Z6hOTV9bqmpqtG9pZbnf3heC/Q9NH2GTs1GHMFfKI8p7w38welRjrgMla
         Ntqv/TJxh6yi166efxNAAXEwypgtDraIborPXuy1kLj1A6APa8ybE4mT4yc6/CmFVnou
         WFDt3w8QWz1ywFulO/bq3S8VHrBqAdsawaicjR3NLbz4sp7IKMfeFjGiDogord/nlWuA
         I+GZxDvmKYGMvivVPgfhtrMLF0Br3dMd8I3YM8AnHzFO08PRMLroEgPE2fj4JLzmMhbi
         x08B6QdtJS8QvtHLwuqjbgk3pXfJA7A24mw4oxvo+42k1YGJXICkt4XzWCRSsHkS5S9O
         v2rg==
X-Forwarded-Encrypted: i=1; AFNElJ9KZMuRh6k6Oq85vnTF2L5MQDm/Z9so8SnoL2kv310mzUOYIjyif9Sl3tOpcqnmG5d5XMd0+Y4XuEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmY81S0HJKTU4sThqR+TdzPulI+UOKF40uhlgYVsOd7hjwqG7p
	i1Hr6CE5I7pVLiyUI1y0Q2KrMS3w2zIpa6LOQ8zS2fs7ZF1S9iCVov3I
X-Gm-Gg: Acq92OG6LGmxElbDiaL0x/6s0dKLaByMQz4m1TRpjOShhWvK0NVP7drBJtrJQGBA2IC
	12MphhJgp2HeZLLj17DT/ZHu0f2935Mwvj3hNb9mlvDSZQt93nxnSFl9694bgMADrAj1JKhiz0N
	K+aBnyboNiqIiyK7sEksanXWFfm7xSwD/HdkXsATuuR9ufgkB530znaVGzJ+yi7hmQbLQzLJt2G
	rOwDlhmb5epE/DfHKLpZtOf7sjjVlBmpgkjxOCK+2mP0MJg8Is7C0vtNlyUpzdiDjb9OJzwer1i
	UBMVuYsb+WBv8JA5cjQ8qbJKizrMGSWtN637/MJD3r5m8ySz8xTLL+OecNaAKOZOsAE/2bVQaIM
	ye3jLLysDJzwTuO8UnytE9cysOhfnqPZLcmeTCQyA7PSrXLk+p48A1pkYfnVn/V3cY6uBQFcS4U
	d+nqUne4ezMQD6rfnUX1vX+n5hjFI7A6N8xOEYk2sAC8CPypwPuswbAPlZRp8=
X-Received: by 2002:a17:90b:548e:b0:369:c5f4:9681 with SMTP id 98e67ed59e1d1-370f1339fc0mr8710167a91.22.1780745894325;
        Sat, 06 Jun 2026 04:38:14 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-371358615aesm3220830a91.2.2026.06.06.04.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 04:38:13 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Sat, 06 Jun 2026 17:07:17 +0530
Subject: [PATCH 8/9] iio: magnetometer: hid-sensor-magn-3d: Fix race
 between callback registration and device exposure
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-5-june-hid-iio-race-fixes-v1-8-27a848c5758f@gmail.com>
References: <20260606-5-june-hid-iio-race-fixes-v1-0-27a848c5758f@gmail.com>
In-Reply-To: <20260606-5-june-hid-iio-race-fixes-v1-0-27a848c5758f@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Archana Patni <archana.patni@linux.intel.com>, 
 Song Hongyan <hongyan.song@intel.com>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 srinivas pandruvada <srinivas.pandruvada@intel.com>, 
 Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

The driver registers the IIO device before completing sensor hub
callback registration and unregisters callbacks while the IIO device
is still exposed during teardown.

This creates race windows in both probe and remove paths, which can
lead to NULL pointer dereferences or use-after-free.

Fix this by correct ordering of callback registration and
IIO device registration in probe and remove paths.

Fixes: bc1d57ba0669 ("iio: hid-sensors: Added Compass/Magnetometer 3D")
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index 23884825eb00..acae77273bd5 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -513,12 +513,6 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
-		goto error_remove_trigger;
-	}
-
 	magn_state->callbacks.send_event = magn_3d_proc_event;
 	magn_state->callbacks.capture_sample = magn_3d_capture_sample;
 	magn_state->callbacks.pdev = pdev;
@@ -526,13 +520,19 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 					&magn_state->callbacks);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "callback reg failed\n");
-		goto error_iio_unreg;
+		goto error_remove_trigger;
+	}
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "device register failed\n");
+		goto error_remove_callback;
 	}
 
 	return ret;
 
-error_iio_unreg:
-	iio_device_unregister(indio_dev);
+error_remove_callback:
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);
 error_remove_trigger:
 	hid_sensor_remove_trigger(indio_dev, &magn_state->magn_flux_attributes);
 	return ret;
@@ -545,8 +545,8 @@ static void hid_magn_3d_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct magn_3d_state *magn_state = iio_priv(indio_dev);
 
-	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);
 	iio_device_unregister(indio_dev);
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);
 	hid_sensor_remove_trigger(indio_dev, &magn_state->magn_flux_attributes);
 }
 

-- 
2.34.1

