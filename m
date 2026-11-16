Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794869299;
	b=MV+rggGZQY0En5NJzjYYoFKe7Cm/YqPv9/OuxRhPb0NcWOuOrTrE0USMHRGDP+4MyB9w
	 LEtUvvbxdcwZiX/BSd24uVad+PaxbuhhJOgeFiqs+VawR6XBl9MXSJTuadFL6HGPqREJ4
	 GbJonq4muG8+Vi3j0M72NH0hz/IIV01iqYBwSc6AH4nHSCqbABiQL0102LnjYVqNvIvCy
	 VqR9oBXH+bOgeyPI05SHOC/WPz1KqI/5vzbTanyqWJdF5FfZao46+dXAT/PIqAGU1ppfd
	 YiwfiOW+/Siti5ghSVDyVgI7YCmvoGSnYqoZXESpxTXlWfC/slGiVWfxj7rp41e6VXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794869299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oh/bkFp2nuSyz5ivDEaIwr2GT3sFP3wzg1ta0b9US0w=;
	b=EyNe9USeGh3zIMu5HDLDSlq9z2i8XpiLFz2t/UHtZIhVZkhtPUHnjhL3W4C6lMqHWU70
	 BfqMnT/P/UK+AqpwTqfwa01JLugt470Cxjqd0D7AtuZ0sjrq1Kq9siW68xBBRErrdF3K7
	 WI9ig+6Nomdy8dLrJwYM04edAjkWW3Vl2i1bx3zUyhg5PLiMAU3VCz6NhXdSi5lYYzggM
	 vz58TbWzv32tgiftglNFTRNrjjl+WR/Y66Yz+SM2f9x2cAP6HxgS0VyNiM9/A+wM1as5b
	 hYk/fMsa74S8gjsNjw0gvsMZs0rSJqmdZ3ICs8bY5r6I+cvS6hyFVY0AjCV5ZrgJ/OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IiXNKing;
	arc=none smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE62606A331
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 22:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EE62606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IiXNKing
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67da62357acso2279905d50.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 14:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794869298; x=1795474098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oh/bkFp2nuSyz5ivDEaIwr2GT3sFP3wzg1ta0b9US0w=;
        b=IiXNKingPriUTAV8ay/gm81l0sS/gFH1loXiJBYR6J8KGZweXPHVJ8W9aNx4+ivJq4
         KLjxhGWfMUIA8UOElTq0tHtR0naPyZBpuOSmOzPQkPveHY7nwvCSCxt+djbuymNG65g5
         bg1l0AHbuyYk9yghtSIkhe7uWfa2KRhCVjTzI3VQT4TNnSXr4E9oXbT0Wf7epLu9MXu2
         LgQulTcheNGGG9XIix/4QZdZWsu4V36NnAABmT/t9wtRp+NPT0TohhqjIzOOrgmqo+99
         dGrSOYH9ViP/yC2ecuiLZB/7oAaxBsbEwLje5JsT8XCU4Zo1CZKH0e18+X4uUApzJCwn
         HNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794869298; x=1795474098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oh/bkFp2nuSyz5ivDEaIwr2GT3sFP3wzg1ta0b9US0w=;
        b=gjKz2jIf2rFjpKcivWSYKz1q4Y+AeA3Kc5WQGHHXM2TcDn8rAVEPO8Cv/X5b7Aul9A
         bgGCLRtHoaUpASyeMpy3WTs7VRrDn31Zq5XhQixkbdUMtTxEzWOzLdftFG9yDs6994TY
         cViwJFQIHkXDHy2REc7k1Ie48SpqYKvln+pDFQq1DjweTmU5/03cQk2itcc8T0W76yBk
         zmZG3BHGLihkHCmRKGd+nMfg1MAQLW9ZU1IB7gB/Hrl/dCuBudjB3Kj6GtmMe5WNypZY
         1fTVg6QMr6ngnfmQwVB4CItFu5uViKj0sgww3WDXPhoVdPxL55P+vE3a2Ka/6HOZrgmV
         ozrA==
X-Forwarded-Encrypted: i=1; AL+hErF+dRlvrhwzA7zS4BJTaa/cMRYZPQWAx5duDRuOg3hz9nsfEB2q8N3PIu050ZZ74u1mHgsdp+8zhrg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9aaXtkjNzeWQEAdvEU1hWndBAu9v/ztGLDxL3GuE7fjiEqNqmB
	p2BKVtlijZlTIS1TcOo5eOKJjDvYfZkRTwXuLxzzU1BPoXLaIWGJonL6
X-Gm-Gg: AZFdTZdJgLFBz/arspdEZs217YUNrZmDnzdfjNUAroX2qjTCAFzM9eEfMfD8dzshTCx
	elVW5xLdpiYdDevT+KGZ/cN2vyfVfkyNi4Fre5rCZXFMqyZjTYosYIKLJqgRAYjrdwdP/fWJVMd
	cm04Pn+VL5j9ZzmuKLEJAOEdGF4LyxV8gtBOVZmgHiujFmFYfwD1QDZ6Vi20FdTeeI4eQ/KmuCs
	vU7uCcfDzjkLNGDM6n/WDUZ+MIBvy3R16tZEvTEJVSFC45dbQROp4xqeb2NojHisQH9GpbwsH+G
	rWB81W4i+NufapwVz4yNmioLgAVeeq5vSn3YIu/G8TY/tP5MQoNFEx9Y7vOR3iifY9JrOfX55kQ
	vG9XXoA/284uN5a9uyLCYIXVWqhUz80tp5By12FJKrqrVniTWx56MhVVchXTbHi8KKZRXviLAPy
	Z4w8V7ndrkbRnIpt1xv5k6tklaadK/iAq+eERRYN5j6jl+7cWXPi34sC8k1nwA5gS8A1oX2rULf
	AlrtZzR7ZVZMYlJ+qwrgVcU3U0ZCW6PBgxgaTGcRFp+0Z2fPm2+4ksYYGNUM9oCWt8FNKEZPzAi
	9Fyr1iLXkyie0PHv2prhy0iRswvEgHQ6DHkfIN+bQOwxponsQraAxoNzfUgfJoBzOJmrqrrWQyO
	Zx34oum1DDfJX6M//z5260T0=
X-Received: by 2002:a05:690e:a49:b0:67d:a8db:2821 with SMTP id 956f58d0204a3-67da8db2967mr3475909d50.103.1794869297941;
        Mon, 16 Nov 2026 14:48:17 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net ([2804:1b3:a803:1afe:e1c3:da60:db44:d0c8])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67db0361f39sm5259534d50.19.2026.11.16.14.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:48:17 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: lee@kernel.org
Cc: maz@kernel.org,
	andy@kernel.org,
	jic23@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-iio@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Fabio Estevam <festevam@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/4] iio: adc: mxs-lradc: Fix trigger use-after-free on removal
Date: Mon, 16 Nov 2026 19:48:01 -0300
Message-ID: <20261116224803.61154-2-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116224803.61154-1-festevam@gmail.com>
References: <20261116224803.61154-1-festevam@gmail.com>
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

The LRADC trigger is devm-allocated against the IIO device, but it is
manually unregistered after iio_device_unregister(). The latter deletes
the IIO device and releases its managed resources, freeing the trigger
before mxs_lradc_adc_trigger_remove() accesses it.

Since commit 699fb50d9903 ("drivers: base: Free devm resources when
unregistering a device"), device_del() releases managed resources.
Consequently, iio_device_unregister() drops the trigger's allocation
reference before the driver unregisters it.

On an i.MX28 EVK with KASAN enabled, unbinding the LRADC parent with:

  echo 80050000.lradc > /sys/bus/platform/drivers/mxs-lradc/unbind

reports a slab-use-after-free in device_release_driver_internal().

Allocate the managed trigger against the platform device instead. This
matches the trigger device's parent and keeps the allocation alive until
the platform driver's remove callback has unregistered the trigger.

Cc: stable@vger.kernel.org
Fixes: 699fb50d9903 ("drivers: base: Free devm resources when unregistering a device")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v3:
- Newly introduced. After Sashiko's feedback in v3:
https://sashiko.dev/#/patchset/20261110141934.42490-1-festevam@gmail.com?part=2
I ran KASAN and spotted this new issue.

 drivers/iio/adc/mxs-lradc-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index dda5182a5076..64dd3a9995ff 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -454,7 +454,7 @@ static int mxs_lradc_adc_trigger_init(struct iio_dev *iio)
 	struct iio_trigger *trig;
 	struct mxs_lradc_adc *adc = iio_priv(iio);
 
-	trig = devm_iio_trigger_alloc(&iio->dev, "%s-dev%i", iio->name,
+	trig = devm_iio_trigger_alloc(adc->dev, "%s-dev%i", iio->name,
 				      iio_device_id(iio));
 	if (!trig)
 		return -ENOMEM;
-- 
2.43.0

