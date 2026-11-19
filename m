Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095664;
	b=TDlrCztbGsiimimHq9sF5f84zv/dG7caxZP7z5mWvMjQVXwE5T1nXjrmQbKCR3hDRgHa
	 imA4WAWvMiGqQENfJyV9Y5hlB+aI4zbEaccXKbf1DmIkFnFMhuiXYhKatzY/6F8DN5AA7
	 02pvjc9fNO++pVzW5A9wzqjsjpVDiWBZfPPKSb/3ETLOCA2MqKOakJQbW3tWh+mC5k6DK
	 8rWpPqG5hiGYT4iy3o30E6NFKyPa8c2R/9FcztV0CuXT49NbaTAsNB31pV0YTJgpiN9+C
	 YP5+5HoIyc0gUOXhUOwB6wUyKgg8nsvM6et0CZKUBggueTS88uOUMk4V8M5Oz0WDaug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mhjd7qCe3jh9JBU7wRsKPF670mA/VW55TzY1RTvEnYI=;
	b=yyCbioYgfcSsEXqekaHzLVsETdoEhLflgE+HzoxkdehDo8npxUGBH89RpfY02NH1KGXV
	 tZ6z1jzgvEPbKFuHEJ8RT3aokrwJf4RifNPo6If0/aGPYbcgNoD6MV06uTZVfRTzYhUZf
	 I7aoNEOYbTG2ZNV5WHX0RnXo2uISIMrz7wtgoL7tgM22yy2Edk+H12OFx5zP+871m1DrT
	 kI3r5wby4YW8DOTBMEXPF90kJrrDBkYrKxyLgvny4VO3jujoLcRuc1oBNx3lPUeW7LJAk
	 ydZjS4MfWcx2D5PQ0JorNmVwo4oxYLFt1cITcZjeOhHA7cSpIYhzfaeWxIGwweaWuGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="e/U05xbt";
	arc=none smtp.remote-ip=209.85.222.48
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB86E606A339
	for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 13:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB86E606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e/U05xbt
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-98301b325c4so735022241.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 05:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795095663; x=1795700463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mhjd7qCe3jh9JBU7wRsKPF670mA/VW55TzY1RTvEnYI=;
        b=e/U05xbtSd5otnBRhSiLYb+iTFeJTRE5BGOH6JDpCrPI1tCFJwmhSxgCrWtid+bsCt
         SoVcOibC0+QUBOfu4+XtDZ2Dj7UMPUmNjiv+zlAsddzHWkM1+U+qv79x896tQdrqO2Xz
         AfW6HKqDmotgN1VrKLRA1u3udVKhLw+fMsrri8JnN/AnmfGhtmcH97/ED6DGjsEyHWUn
         rGEo71AaZyzQ4bBbusDudUZ1VpTsl22I7vE9QVxWRd6uGfHbVcjRyZ6Nixc/OO0xCA3d
         /0tjfc8h2I9/xz0a104M7JuH9h2jQFE0+psja0IrLv5w6o45VywGiOukFkvDn9XBovKG
         DjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795095663; x=1795700463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mhjd7qCe3jh9JBU7wRsKPF670mA/VW55TzY1RTvEnYI=;
        b=QxNyzvYK4dN6WskqRSYIB2+7Ca1YrTg0VhVVazcH/FV16n8wQodejhWlkyUo8+TpVl
         ngvPjcIutEGEdBtqsWfq1ElSoK9nMhJIjYgKH7x3lOA2xrIAnCQ4jStk4YnCwXgxtkT7
         3/+teBKPgAKahD21NDrj84Q9wySn9iTLYjoQdzWwihaVyaTQwEec1XyTrhQf7RAnNAL9
         8L+49hAepopyKujRfLxslTrZw8Qi9DIIKaSQg8o4zI+x6CIj4BVyeR7RJxbJRUSaKUGA
         N0RjC+as6L+AyY/dksT9UfIldmTy22qxFYuZsI1dOdeBGV6fJrZCPlHD7cmK9dQSv+9I
         GiTA==
X-Forwarded-Encrypted: i=1; AL+hErFG1aSW4xvuVOVmw61N236Ix5dAbY6EZz1ZLnph6+iZ+EnyFEZHprzZdKNJcz+JwfNyZODm3q/PxtI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7da3rejDvYi1ayb4jOuE3GduwbSDAMR3Wy0aO63wnF5ycNEX4
	KKjk7Z6H/kQQx1azQZvC6gzjCHM3A4blRYFhHCG/g0aJJWveGtjHPGPTxfXiUQ==
X-Gm-Gg: AYBFou0J92BigJ/go2KioumVChYijj0quJXzzTUkrV0dTQCRzWoDGSK7Th80b1BSYgL
	v4pquwwfeZ3npnjg5um5yLfRHlj1DWQVWk5DMk0qXYjCUeDVk+K84sbGAesywM6dKQj0S9HXPE8
	ENkQzLiQiFZ3APwjt/9JDewT3Ekuq/6CIy+XlFTnWBO/G+9J1wFFHiXmjGTl3iI5r1Ma0sIhtcT
	HxE1uEZ3Gm4htmmUqigVKlDiWGRIW52gq9fOERlE8nBOCLtQ5s6gLX23wi/tzx4V/9N0Z6fb740
	7wBe4Bq4J1NY2ms7IVxcpONyXamVLMQoKxegIztjjW8vo8DT/17CPHqVh6I8udWSuBm6nuDdFVY
	VcQkgUdccdZzfWnQRTIOPyTIsPXl7PlWn+r3kp6BhapP2iwGW0VlA3sN7GvpnPXh6qFyOOR5UW9
	ujxJ310u6AMt093K28SCkwtyLOpbHnKJOpMX/N1XjnqOoev46ArbuAbK00t0KvaA7A/8VUX6Spe
	9sKcj+Bg0dTYhAi4Gt2DJ42vbmuL8v/2CKFHYbCaF4AefuCpOkfNMhERRHxyn189cH4O87M24JP
	2jXHFYv8DFfonTdyY+oEyeJRo5Qwn+QSTkAd1JKG4HwgwoLJAceLkGiXBXEcA2wsp+w0cr1fQUy
	8FZdETG63Ygm+KGP7y54=
X-Received: by 2002:a05:6102:54a8:b0:7d0:6db8:dc3d with SMTP id ada2fe7eead31-7d6ba191168mr2215348137.5.1795095662707;
        Thu, 19 Nov 2026 05:41:02 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net ([2804:1b3:a803:a13e:f40:91:660f:4d51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a240ac5sm4134862241.7.2026.11.19.05.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:41:02 -0800 (PST)
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
	crofts@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Fabio Estevam <festevam@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 2/4] iio: adc: mxs-lradc: Fix trigger use-after-free on removal
Date: Thu, 19 Nov 2026 10:40:39 -0300
Message-ID: <20261119134041.16611-2-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119134041.16611-1-festevam@gmail.com>
References: <20261119134041.16611-1-festevam@gmail.com>
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
Reviewed-by: Joshua Crofts <crofts@kernel.org>
---
Changes since v4:
- None. Only collected Joshua's tag.

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

