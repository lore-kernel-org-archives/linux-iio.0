Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D6B392C2F
	for <linux-iio@vger.kernel.org>; Sat,  6 Jun 2026 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780745891; cv=none; b=r7wpd1Ch74+ztHTeJAML/Z3YPN4frqqOOu7LfcTH2ZKixqVtKeEDH1lZUxRSffkFp/GAZv1iEDeKsHXo2Pk22HF+R3RY4NhIW8VEzu0d9BH+mXXleAAwaINSZkwPlN/tQN0i7W/u8kFy38vwnbrFRZU/ISy2tEBfM/HY0etUBqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780745891; c=relaxed/simple;
	bh=YdwH8OoKSk44T5rJd3P/7+DNbTCSOxu8TkOwBfLzI0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qz1pZmGTz7Ixv22GHSwVaMQMV6ZIFA68O5V2SBYzZ8nt7/wsVlaWi6QhrdKw5GwHIIjp7gtxmYl8S/5r8KATaI0DJQdo5xV/mgAS/UqaoZkVgDHaTwBP3Z/GuO/Oic6Ui9oXhKAV25iMXu7tIGLlEis9K+xVpx5pxnxv6ECnrB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7X+Edf0; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7X+Edf0"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-372b4330deeso17350a91.0
        for <linux-iio@vger.kernel.org>; Sat, 06 Jun 2026 04:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780745890; x=1781350690; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhNwJ+gs7E9ihqXUs2Y3jA0VKn3cDSzTwU3DSDgrU6I=;
        b=L7X+Edf0/zRCy97vV0EugYAZ4OpNAiLT4DoiVjahD8nmovrJ4vcKS9hcylzvotH/7q
         JCW2QCOvpyLahW76tajZaVYpKlZEppv9PlrIYGudPiHcrdX/ONA43xw76AW7dPzmfCby
         kvsRjYa384eAX6oHp2qfkud6VieVH35bL25Szu3njG/0KPeSaGP+cXDOOkRmv+eU7gxV
         tvF5oduZ7XAcTr9NdZFROXF1lNz0k79uCH4nOFGc4QGlXrQh0Sx6Aojxac8SrjTY+5EC
         8vNFNpJtXJB6Du+Yv5vlOV2qTWeUkmBLnLg+oxgvU9z93SfxvSXinVaUPHX6XpNpXas3
         +8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780745890; x=1781350690;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fhNwJ+gs7E9ihqXUs2Y3jA0VKn3cDSzTwU3DSDgrU6I=;
        b=Ce2pV3QEe6GbC9YioWTpy+zKY4U57jwsYNG3Sx4buHO9uxVeDD7kKVzjZ52F97MUVT
         Vbec9lST/V/hQ4cmgU63RZqdiqaqENgJsjjXes5nmk/AWiGad/g3qluaI9xTqTpzMMRw
         X2xEWDYIG8QxvY8j+Yfor8jV8U/nr8OsGGlY/ezAJ6paib8QYe0kHqfYecmdU8a3pnX6
         fA9xQOK/QylT50GYblqkjZJY6N0Idw55ANrV4B45jsa17nWLJ09uCTwUfjxldjWE0cgl
         Ed0ub4Tc8A6gfx8gExHd8A5NhBU7EH3/epeFHT+yGKrSLgaOLnHn58G//zqi3wLDbDeo
         UXaA==
X-Forwarded-Encrypted: i=1; AFNElJ86Y3J3ryqcw44FpkfTXl8k8d4kQwJr3GkU0oeQy6WynKixC/hcepFgqC2+RE4f5mJCeyLzf54J1bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTbQe/N7Fzir/UbUDUKAy7AH4IkklV/IFB2HgycABqYraWGA72
	LUzUPck918jl8XabjFfzE/pzdDYUX9hjtKo+sIIqEoZwoWkWu2Q4A+y2
X-Gm-Gg: Acq92OE56MUIemACPkngXMhnFu9oQw07+wgoMS89jh3uM2mbcD4MAdu9sjx0UgHLJ9B
	Cjgdak6Fb5iD54tq+1IG9DhIkSq5LA0ZwULPA9Swpe7AYBzIzqZ8tFviEd/1jyjM8A8Ge10f3LW
	4z1didoVjzzCkR8zy9KC9BiJu8Vr4EqPOb29k17GMq5yYgGvie/PCB8aO68gZ5RyL8PAjK5odrd
	OEH6rjl2Ui11pzvqyOCgX86HZn2bGzy0BU2LiMcCJwR6t3yRV1h4fxvm6+MuVIzUPus8jtVHtfX
	2x250wQGPIbQKniZsRuUTIGNKUHQUx8QbRnO7/b3XJSCsdWwaWXNMv+UO3kGQq4oV7egWuhdlRF
	DWd+tKpLCnZxqgHYghr3KAuqkc30K/flDAnywmEX1btBJQMgBQvnkvDPyLa6dH2JGm82RI6hFqS
	vvnIXDlo74OIPm7jn5I0GAq56ZZVZMxPVvqxdcfzMMzQtUivPDfgxtgt8SqwE=
X-Received: by 2002:a17:90b:350e:b0:36d:79c6:1562 with SMTP id 98e67ed59e1d1-370f14305fcmr9575910a91.25.1780745889652;
        Sat, 06 Jun 2026 04:38:09 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-371358615aesm3220830a91.2.2026.06.06.04.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 04:38:09 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Sat, 06 Jun 2026 17:07:16 +0530
Subject: [PATCH 7/9] iio: light: hid-sensor-als: Fix race between callback
 registration and device exposure
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-5-june-hid-iio-race-fixes-v1-7-27a848c5758f@gmail.com>
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

Fixes: ed5514c925a0 ("iio: hid-sensors: Added ALS")
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/light/hid-sensor-als.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index d72e260b8266..93d603848690 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -406,25 +406,25 @@ static int hid_als_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
-		goto error_remove_trigger;
-	}
-
 	als_state->callbacks.send_event = als_proc_event;
 	als_state->callbacks.capture_sample = als_capture_sample;
 	als_state->callbacks.pdev = pdev;
 	ret = sensor_hub_register_callback(hsdev, hsdev->usage, &als_state->callbacks);
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
+	sensor_hub_remove_callback(hsdev, hsdev->usage);
 error_remove_trigger:
 	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);
 	return ret;
@@ -437,8 +437,8 @@ static void hid_als_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct als_state *als_state = iio_priv(indio_dev);
 
-	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
+	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);
 }
 

-- 
2.34.1

