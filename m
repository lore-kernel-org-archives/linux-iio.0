Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B651A40682A
	for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851320; cv=none; b=u+JegExEU/8gR7fR/Ed0ACKfX/4EQHCBLqqkzQBKkm5Fc219lFKiXASFUtG8ZawQg7HlR7m7FIVRyo9l3XxvvmEWuR/i9FmmBaLUdwS3MVZtJKjXn75owtyDxjF3klAANo/A2zw8XDKDaS054/KNU74FG3conixZWzNCDneeaXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851320; c=relaxed/simple;
	bh=lXuGALADpdYx0vO4VSK8tnkYBICnr5QRqUa7sGpDYUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DTK0x157NsuzFw+g94CRbrSMspXtLnMjXo2eMJQDYW4MVsy5AibGuu5H6CC/bLsJu/ZzDV2oHA75Tz/1bz3nv/epT3A7kDcXp+QsJvwH9MCGoDKp2BJU6h8bkqXBUZ4RgDa0kLZrrUamqsOXY+BuN8wGJ4C6zrJPlBpKeFBmlNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HU5r6rJ/; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU5r6rJ/"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3964e76d0f4so219580a91.3
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 10:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787851318; x=1788456118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gw3dvZrCiTdARZjyeMDfU+Lq93+rhoJslG7bH+ap744=;
        b=HU5r6rJ/MlNZhwGSamRiFC+QCpdTHstCmx16xh4AaXhPvY0ACJHGClhC7bFqgacDP+
         I/nBiPvHdH+dfrR23fYGD9opvIjRZkNLSNg1zp/BIOMzADaapAbYL3B5LUOYIRu8nXE9
         edqjxYcNt3WpePJPW+OiNxwU5D/mBq2Cf+rhdpEfTMm4AWft3z/8sOggdKuLMAr3z16D
         +San9h92BJG4vgtyX/R3/viF03F8dQhpeOtYtMEZOBCYAVEDASQCyNr1H1Q3hq0nO/ro
         azg4wkG+j7JODInTXeABJOizdsc8jQ4YIevLyGgxOMywymdxqUVw9tNk0nm29GNPDuYc
         iCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787851318; x=1788456118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gw3dvZrCiTdARZjyeMDfU+Lq93+rhoJslG7bH+ap744=;
        b=Hs9+AIKO3t9LDF+KvR0ydoVqV0gy8T3IRewwo3/i2UFH/EPflNbqXmzbAffLCUpoGy
         OPli5jBPQ2Sq5SYd22EAhqrGXcHZSZxanQRqHJ/hmRz4t9prjsLVhVS9RRDwsbnEezBq
         E+0bjD7hOQyHNmolW40Bf69WDXUZorhKDwOgRc8mapNylm8FUaJGqDvcrPf5rrBbS0Q1
         gF1+DYf4EiTFPApVy0vVldZMlOnZs/LJG7uNr/E0hy56zZDKBWkPRzHsjmFmKyAypkbH
         A0ORFMG29A9mEEGFoqAyAZq2UbGyUAraydRL9IDI6PpqzO6/+tLmPxHdm4jgXg4kQGmc
         evsg==
X-Forwarded-Encrypted: i=1; AHgh+RoyqCX11EVNOiuNOdkObxYaDyKtJ5jNFEcO+RPdlN2eMx/HxbGT/jgM7KNooiKam2dXoMef4lbJmXM=@vger.kernel.org
X-Gm-Message-State: AFuF++nDnmNwjVDqYtLTJ7YFNKPKSRLdFCVhuibaCMPgrig0ApaS3Mms
	/HDsFBiVLX/cKt+jj6kb3t1Z9vF5sHBRwEJI4GD2+xev3pc7c5c7b5gB
X-Gm-Gg: AR+sD11YCNfJJ2fQfYK/hFo7/MxXHFs/TG4zVPvE7w7hpTI4urqDZ3EFQ3H68/pvugg
	BQR9b0IfHR6K7MWydbJzbaCbP3aRimlLtsrkjTTyIAF4TiqBi0YuG33SyGF39E06LP3iNLC5F9i
	hmUqknhag+31Y7F8vUbVBvmbkozA7k8pQdHWKBz1RvJZEr0+ODQuK8HfpBqVCj/fI54iMmQ2KBd
	+zh3nkpqK7kENxZbnJRptzz9xuh2pVU6nQiXwhRq6+XNMqW2+OOaC/uSVhbawy+a9Bs1bMpfhmB
	U8MBzboYrbXKzKGU8ivQeoDFRKqgCsgN5b/bJkzp0W7QjZq78h1HeiqaNdDCVLEpbdUmcZeUH76
	rbHYUs6EJta1BlmQ7ECKFvDmWHzLgddlblBoFcuYWMBSZjFTLavudE+9pqAO1p0Vy9tOgTICHjY
	Tr6b8hbvpDyFK832xUf+eD1oitKMHJoxioaIF2uxfi775MVH8Yq/lp8lExLYim4R2iGeALWKwu2
	qte8socQI+z3pLOH5gsG1QCP/Dozu5r3Byx
X-Received: by 2002:a17:90a:e7cf:b0:38f:dec8:f7e9 with SMTP id 98e67ed59e1d1-396d0fccec0mr1155735a91.12.1787851317751;
        Thu, 27 Aug 2026 10:21:57 -0700 (PDT)
Received: from debian.ari ([47.30.51.191])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8eedd13sm17797165c88.1.2026.08.27.10.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:21:56 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v4 5/8] iio: adc: ti-ads1015: drop unneeded < 0 error checks
Date: Thu, 27 Aug 2026 22:50:57 +0530
Message-Id: <20260827172100.39176-6-architanant5@gmail.com>
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

Several functions in the driver only return 0 on success
or a negative error code on failure.

Change the error checking to align with standard kernel
coding style.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 0d1006041819..ba4a01850531 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -539,7 +539,7 @@ static int __ads1015_read_info_raw(struct ads1015_data *data,
 		return -EBUSY;
 
 	ret = ads1015_set_power_state(data, true);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	ret = ads1015_get_adc_result(data, chan->address, val);
@@ -727,7 +727,7 @@ static int ads1015_enable_event_config(struct ads1015_data *data,
 		return ret;
 
 	ret = ads1015_set_power_state(data, true);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	ads1015_event_channel_enable(data, chan->address, comp_mode);
@@ -994,7 +994,7 @@ static int ads1015_probe(struct i2c_client *client)
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      ads1015_trigger_handler,
 					      &ads1015_buffer_setup_ops);
-	if (ret < 0)
+	if (ret)
 		return dev_err_probe(dev, ret,
 				     "iio triggered buffer setup failed\n");
 
-- 
2.39.5

