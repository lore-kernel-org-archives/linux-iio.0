Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5A051A14A
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790788367; cv=none; b=IcDDNQ8ms91cIiwpNU1rvC8ygLddrz8/TfEIPSdlGy4sGjR4I+mfNpa0p4UkmAtNyyUgGCLdXrj7Q/AQHKC55/YobVfbutzkUgUsL3JieRLXJfDqfuBQCIvdQ21YmZL1nbpOQgi0pDpza3bmGt7uP08q2p5D7T8mEPtuVKyNBmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790788367; c=relaxed/simple;
	bh=VRY54Bp24CMiSqVN+aAIvjHgWCp+bx38PBzd7hShuEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uh4yuqsCaBHNasC7s8wNFL4evYlWy3VQHLbA3Nef7ojUgEE9cUnz+IVMi8TZsAOikviIgO30ZWDTgn15XwIUYpIiOhW3pNveDqdKdkK721gd6WNYCR0lO/HR8WN7ATQr3Mf/wps741GpgEBUhJ1DZclp2va+wVZlKzDDCsURiN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUOy6adG; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUOy6adG"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8633a38df87so2406010b3a.2
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 10:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790788366; x=1791393166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YTeufGQidCjsvqwpn1tRvvD0Docs/Gc7we1s3u6LYnc=;
        b=TUOy6adGCs+JdkjN7lY5lZISuE55iNRPxEg2U0rGtrrjY3gS1nFrUNeBVw/mb1ji7u
         97Q+ApL6sUEAUKyIMkrY0aHFfAgZdGjEvUO4CsH0EYLMfsMqe8DLoNSOWwq8yjyK9htd
         H1qDjrvegJyTR7yL0jYOQCmcI+FSsNZZY2Y5WNDBTG2x3LRB2O5sPp02qkOyFk3lfo9W
         e1xkUE36XuRKrnYnYEOXH6oKsPoGbNoNNkaE4A9l4ddoO/MT/OyamDmuU/OuCaxSUwAC
         zYuiaB0/aXIFiYCgxziLtE7h/mtpaO58j4vafu6klIsPpoPpKTjdkX1kChkWk3px13Y1
         T6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790788366; x=1791393166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YTeufGQidCjsvqwpn1tRvvD0Docs/Gc7we1s3u6LYnc=;
        b=wZmzo6hv8m9wk6HuQze/tqIT/KMnYxiefBFZzkq18NCylNnB0susD5rQsPyDZ9GdHN
         F91Xd6iQSOdLjzPqrCsnE6jbcuQioRc4gQwfd/b2k00HXCL6NfCPBh4CGc+IKLL6BHbR
         Xa6nj6iD6mr2MNxL+P0hl0v55bmanuaLuqWTn2gx/lJqJd98qMhfPDau+1dL3MqLmAzv
         Ad2Aujl9TeDf7TaD2WqMsp0lgAttm0M7KW02T7sTP2IuoRBzx06/04OqvcDwIhJVULaA
         s02BaS3ztnA4JosDsufMP+Fue31GPUwPtMmYvJ4Od3ZFTeudsbKNtgNGGPC9cYQn/ZpT
         DyTQ==
X-Forwarded-Encrypted: i=1; AKwUvBwnPeepnDoGJCXsANwpIpUKwpmFyWD/cIV9d6AK318tH/Q7juGX+hYpr3Tm644z+PaG2gig+5n7Ivg=@vger.kernel.org
X-Gm-Message-State: AFuF++naRV2yAK6KtgVTY+q/bot+ig0+d1eh27ge6LbrsNUA75iEe790
	Qt6YwSaI+ofwCF1IC/i72cY+guKzwhZGL2kBTjGWNZAdJ940HMF1UT8M
X-Gm-Gg: AYBFou0vF7AGD05Vn7Wwd5t2uTGRn3LEDIfdP4WxHMIOFgqo3h/Zke5BqfNUo3ULfco
	pHcCl3S4pLm1NI3NE6Wzgk06uw7rf+35Ti9R2mIq8SPp7/El9shiVB2cj2hD7CW4iHzdGCUgRFu
	KZwq0kHHe334GY1eNfGeNclXgZOV51wlnsz/I0k71ugd3O4fgmQ0g0OBzG+qPDqJJ9Ar5V8v9og
	prq/fFZObudFgv+MpKf50y9v113gDSjFSQyZ6i7gSWFyKaG64PNB6K9BJjWa9iH+/BCEQ2R9q9M
	4xr0fhwZzBji5waJzYqJIC+79EfKFWpJvO8qrfyrFrlLdoxN4TXm+4ZMAap1Y6stsUHYYFCckmW
	psjtCn/fSIGkNy9OPS+iNr+BCPekfFRbLLecKtMr1iNU6ZJSxwtR1xrpTv3+KzGyu3YGdsPbNiu
	naO0dZpxBUB9xqNbEXswMDSXX/CeghB5fHjBq1j4xDu/UOhsJ28jAdVYf6CM/mdGw4FmJl8ID/E
	2oGa/t7SI/jFYZ0+kCsSl/Y7J6viZqTPTtmghts9LLpo2+k+8s=
X-Received: by 2002:a05:6a00:3926:b0:87d:430:1437 with SMTP id d2e1a72fcca58-8874e830b2cmr1452636b3a.38.1790788365419;
        Wed, 30 Sep 2026 10:12:45 -0700 (PDT)
Received: from debian.ari ([152.58.182.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-887bc2bd404sm636872b3a.46.2026.09.30.10.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 10:12:45 -0700 (PDT)
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
Subject: [PATCH v5 06/10] iio: adc: ti-ads1015: drop unneeded < 0 error checks
Date: Wed, 30 Sep 2026 22:42:00 +0530
Message-Id: <20260930171204.12863-7-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260930171204.12863-1-architanant5@gmail.com>
References: <20260930171204.12863-1-architanant5@gmail.com>
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
index 34d3d31b5ddd..6637c42e0506 100644
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

