Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26192436347
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605618; cv=none; b=YoKEkc4kZtmFV98p3E6ylWSmyCKHFomj1Ico/E9/4ftBSUi4qOn36dWmA0Z7jsubgRpJxXZp0lbyUJ9d9+uMlvAglNqySWND8pTvvHBRt0/QThKMhdCVGfMfExSf2NVeN8CL3FvjKHIkK1e6O+R3jCLVgOVh8Wh0Vrafc1OA1Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605618; c=relaxed/simple;
	bh=wg26RhGdHDg01DgrTxebKBv2YHtcTfKpPmvV/wk8vk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=en64w6ddHGFUqa7Z5nalxRgZsCJwlOhEwp0BI1WOaW3VH4HzN2Dc0HuP8rZpjaWuGk7N7KqUi4KmamqZKGGesrwbYRZ8HZVINl3XVYoXW46P9noonHlcatAmfvrbxNPk5u2lwJnQjEp8PveVfl1Gl2lYuY3UzG1TzgFbXgPO1QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUNeQJ4E; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUNeQJ4E"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-372b4330deeso2813409a91.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 03:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781605616; x=1782210416; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIRwhAGV5hxx8Gm1XDKNLxqpI0J55iNfuPNL2PF+/hA=;
        b=rUNeQJ4E2zzSmhXaEwA5ardYldxggmukchHTM8UtLdSF1YFCrpbgYHvTsCh9QS+UKJ
         vRsI6LYFnBrgGWbI075rmEDjFfRnD/5rZFYPDkozzdfEF0dyNRCMAzGrqMpHwg1iIdh5
         lIDeBOp2yOp276ISDeH53/QtcF4XfDfK+DKQUs4gCwyAjqvakggwrp2OUohZyN+1jjwN
         CgvC9ZjfSAiPMr20X9Cy59jznbg7Qmmg+dWbAZvNofzbZ359GnrwXRPIBaegMQuSXB1z
         AcsGr8REVqfDI20epe3DI0ig+c2Z+xSq3fJ3TGF50i+GnJ4WDrGKeAFfB4U+snu4RZq7
         2UHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781605616; x=1782210416;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IIRwhAGV5hxx8Gm1XDKNLxqpI0J55iNfuPNL2PF+/hA=;
        b=TiNPDreGneZry1iD7tJEGN20mdqjY32ZeMe3/sgRt76bRFYWC8TdIyUs8GxgUM/t5N
         E4P3lBWb5fM+LZ2ehK4O2rgUwjJk57zr0h5AVxIX2IOGfno9g9vryefOOVQChCUkt8Qi
         oK63fbh7yWV72pky8DE1jL/YFYNvvlYEYnQCxdmX8ejuBW9i8I/0o9EA5Mhc4BDYSGCD
         P1KwSxkSA9x1oHqCfCRB56DiaWLKPAZqUBuDjgKkbl4VY8jMbkgwUwRWVSZpdPfcyaem
         n/6zdzGZ8UkJMWCx8LWd53NCchadP5clfu504bhJpI8QUU1xjKOOU/W4FYbp8waouCi9
         +XRw==
X-Gm-Message-State: AOJu0YydFjuPvFRQaI6uanY0d94gy3Oi7ecFe3RHLUP912zjmkRYCM2b
	BHiwayZp6jLM5P+RGwxxBpp2Hgpkd5DYqUGIT040VI9NJTli8sf1ILq/45sfcw==
X-Gm-Gg: Acq92OGI4I9qAV4NXQhmBWJ80RMJSm3gI5VS8Kp+UnCFD3eft0Z2GTCBZi7gC72Ul8J
	EBC4YqJEVzn2eC6IOL7odHw7aOh5YW+Ny6/0snA9aYwRS+WXxk8SBFFKTOVhz4GeMDGzdk+Q1le
	VrEJXtL9UrTrUxMPXS6sppnOhd/5qqEB7X7IoH1d1qRqEPUkCmRBT1yccHQnCphU5PxH4stt4v8
	8tY4KJF2IEcfKKu1YBjJl2zwBsLCeXDmdS/B8XkO8Mb9TcHrVLNy0CIM/XsJPxAh0crHaag7l1J
	M9C4LPD7tsd3WtFPVJL3W79ZoQwEhe0W5uePASDdpcE7UwmAJ8DUDq28R6ow8pa3vH6aCC/dNa2
	AQOlYgA9tIaopetey+oge73Kc2tcVDFOiAuDmMqYm9yvwWAUGogucu6nrw5C1RLJN2vvdoKaISv
	aKpAyUFgMjYp0Zylxc07rOLqqUNrQ9JkHUc0x1gflhR79tqtYO
X-Received: by 2002:a17:90b:1a8b:b0:36a:5d1f:7b6 with SMTP id 98e67ed59e1d1-37c2bc5d322mr14244142a91.2.1781605616572;
        Tue, 16 Jun 2026 03:26:56 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e88d546dsm8079269a91.2.2026.06.16.03.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:26:56 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 16 Jun 2026 15:56:11 +0530
Subject: [PATCH 06/11] iio: position: hid-sensor-custom-intel-hinge: use
 common device for devres
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-15-jun-hid-iio-alignment-v1-6-0cd544286575@gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

kmemdup() is used for memory that is logically tied to the HID
platform device, even though the driver binds into the IIO framework.

Using &indio_dev->dev for devres allocations works functionally, but it
results in two separate devres ownership trees—one for the HID
platform device (pdev) and another for the IIO device (indio_dev).

The devres framework is intended to have a single, well-defined parent
device. Since the memory originates from HID sensor probing and is not
IIO-specific, &pdev->dev is the correct and logical owner.

Switch to using the platform device for devm_kmemdup() so that all
resources are released deterministically and consistently.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index a26d391661fd..0ba9d2d43913 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -292,7 +292,7 @@ static int hid_hinge_probe(struct platform_device *pdev)
 	}
 
 	indio_dev->num_channels = ARRAY_SIZE(hinge_channels);
-	indio_dev->channels = devm_kmemdup(&indio_dev->dev, hinge_channels,
+	indio_dev->channels = devm_kmemdup(&pdev->dev, hinge_channels,
 					   sizeof(hinge_channels), GFP_KERNEL);
 	if (!indio_dev->channels)
 		return -ENOMEM;

-- 
2.34.1

