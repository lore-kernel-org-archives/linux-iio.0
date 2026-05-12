Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A0A3B1019
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590264; cv=none; b=AvYUWYVdCPV9b3vBaRv1kdszJshJOX0bouxaZFo56raxcFZjIBhoiAMpOZgOZ06F6VwgWi4AEu8hzhZ66b26pseVl3hcfQVlvz+f8ogt1RhkSvyK7YWTnsIX/9irMAG+FymQ2+mZC9AgefeH0wJhpu/cFEDB9/p7ORX5QRtgSbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590264; c=relaxed/simple;
	bh=P6WJBWVk/AYGVD2iDvgFs9VxHbByPo/vw8XkLrthBzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYgCnfThvazSXuGzpRoES1W0UMB/S7EutzkTR2Wt4SUxb9sIKzyx1pDK/6yGcnFdKOkA2DI73OZkQTmF2stdWqd+xtFkH+VqQubOuU88GaApa1gOPEXEjlaw/VseAGdk/rHiml8qVGDk0gHs/iJM2ftmJSAnyFbQF9c3apr4t2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=kN2vWzIl; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="kN2vWzIl"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso63807705e9.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 05:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778590261; x=1779195061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6u6ckoYuRTe6EuUn2jyVBOE8hQkJls/nvi7cB3Wx+c=;
        b=kN2vWzIlk1V4MZiXNwbNYVQGyBf8KgoqRUfAA/fwZdMLI0upkY712frkgxdgDsmpIr
         Q4z5zaioFGhJIxhWF5Dl8qF32HkZlHTGpYLzJEue7NT5rr1dovx1m3oCt7PcUlptOlGA
         LhW9jmP6nAOs8h0lzzJr2b2zwZSKR1X6gfOx+JBbQn7Iwc/w7PXCWJnkyX8++HTLwtwY
         AS0NoL04MFXne07upQg1lh7WRkTYg8jB/34r0QmA8vrKJc+2vCiYeyZcV750WLkmpUx0
         hfIfjfkULDJVpq4eH+W4dnGvHL7NYza4HwmcydfhIFCgH8S/8Eckuxw5+nwiyBXDLSNs
         KWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778590261; x=1779195061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K6u6ckoYuRTe6EuUn2jyVBOE8hQkJls/nvi7cB3Wx+c=;
        b=sZzA5awG/WmmVduZ2pqae/KfQ1dPlq3h+5bDkCo5Jp0X79AioZkBkFUZqc/5JFvxJK
         QZf/IUuzNUj2/KTQ9OlVSBw+rcnKwKrUNjq67aoNFjvMGJNHGyFCMa/JWwvQW+v/AVS4
         nbkxDYqE+ZbAbhHtQxLChcgPmjMwSvhaNcmH52bVodsbJTWq2qtWNqPVqmZXnhaXDNIm
         KMq+Kze/u2lOGIBLIvdfX/Cc3XbHDzxE1mZNq8Imp9g0FB0lB3Ae5cA9NpQaA33LT3IB
         Z4Zn9Y+VPP4acpG7OSPzWzkwfTrl0rxK31QK3F0WvBbEpPrApQyAo1DFih85gpeUMFk5
         1tlQ==
X-Forwarded-Encrypted: i=1; AFNElJ+zUMWqTleP1NOU7nzy669MK7DuS+Uokttt+FcaJCWGBI/ybwgmLuEMcaactF0Behk7iem91M1KieU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxlCJXVTQTbLc/c2tGBsQfxdSDBjcV1LB789UCNy2yoWXo3ehd
	N4fpYVaG6I4EGlWUrkGCJmoq4JCRjoU8VDV2jV1xim6LKICCzZ8+SXAjy4wyVUIMloQ=
X-Gm-Gg: Acq92OE+ugE/++Ni87r966z+6MR3vb9cr5K/hmIl0+tkPM8hBdOMvghhOXdNL1AM9oX
	6Q3nHobC19M9dv+RgwIbfqhhr9Kf5TvugcMEiVShUd2NUh37eH07HVq8NaA54+OmP9HaDTHs26W
	NFT/6hPI211+cEeVZDQorn+zXKRfbpzxmTpEhLDhPMTOeNu0oPRsuajl+0Fq+Bz6faZG04eMer6
	mq9U3R09KuCPWP7nnF2qCLA3KDvC+RmYhXDHZ0IzYQVl28DEa00Q6IF+6m1EfjaRj54BbBf2hvZ
	byzuDew2UmEHA9bPnLZD1Z/wp0aWT1o+eYNl88tGsbMt3kqFFPtKoWSqy854Ur71Z+zDqA3S1au
	Tusz0rScwNWEOa1/pMDuoZo7/hZ/fsvG8jvxdkXS8PybBX5CfBLTIktKeP5oQUOlLkwTRVb96gf
	YtBhKrFn+0r5iCYzEScHu7VIoILswvkVeUntYsh8vT6Z7/hSuA7+kIHdB4A/Aj6A9b3BL5LoKjJ
	Ig0DZKpebAqopGOum9T68PlTQ==
X-Received: by 2002:a05:600c:1da8:b0:48e:635a:18d7 with SMTP id 5b1f17b1804b1-48e635a1ba0mr344990135e9.0.1778590260593;
        Tue, 12 May 2026 05:51:00 -0700 (PDT)
Received: from localhost (p200300f65f114e08229f8c404acd2182.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:229f:8c40:4acd:2182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48e8f4247fasm23789615e9.9.2026.05.12.05.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 05:51:00 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matteo Martelli <matteomartelli3@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] iio: Drop unused driver_data in four i2c drivers
Date: Tue, 12 May 2026 14:50:34 +0200
Message-ID:  <8e07be10e69b5699bba7ef70533a0d49f8cc1eb1.1778582187.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1778582187.git.u.kleine-koenig@baylibre.com>
References: <cover.1778582187.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2587; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=P6WJBWVk/AYGVD2iDvgFs9VxHbByPo/vw8XkLrthBzI=; b=kA0DAAoBj4D7WH0S/k4ByyZiAGoDIiag3ikHOYMUNjITtTt/34mGswbo4deXbITCPAZn1lICm 4kBMwQAAQoAHRYhBD+BrGk6eh5Zia3+04+A+1h9Ev5OBQJqAyImAAoJEI+A+1h9Ev5O7vsH/1An kru0+YfKBezqAbNphrMAivBP2g9kUFYHkfsCwO3/T6kc2bhfPt/JuSuI9Qt090ggINKyl+LPAkp wSNW0rzP0wpBEOTs/kWfyPh4lMjYtj30EoSEVjP5HJaJ3sMVIzSZB6mqO96y3VeR+xK22GHYj4f BVDxydvGG/330OFHHe/XQVC9G0EqmviTXbbraUS6DCgh6WfTU61yPpWln6hErpo3IbIOAuvYGWy If8/dugJi0doPQHaSspFKJYFebWaOvooLAf4cMyYqkVzME6uf17JMN4B7vdsXZr7CGhpdom7Oa+ VvupPQw4fXXrfcqr33GB96QOBrjzPD4ELhGaBhM=
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

For the four drivers the .driver_data member of i2c_device_id is
write-only. Drop the explicit assignment.

While touching these arrays use a named initializer to assign the .name
member, which is easier to parse for a human.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/pac1921.c    | 2 +-
 drivers/iio/light/apds9160.c | 2 +-
 drivers/iio/light/tsl2563.c  | 8 ++++----
 drivers/iio/light/tsl2583.c  | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index bce7185953ec..68bdd2f30bad 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -1310,7 +1310,7 @@ static int pac1921_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id pac1921_id[] = {
-	{ .name = "pac1921", 0 },
+	{ .name = "pac1921" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pac1921_id);
diff --git a/drivers/iio/light/apds9160.c b/drivers/iio/light/apds9160.c
index 3da0bdac04cf..8dacb1730429 100644
--- a/drivers/iio/light/apds9160.c
+++ b/drivers/iio/light/apds9160.c
@@ -1572,7 +1572,7 @@ static const struct of_device_id apds9160_of_match[] = {
 MODULE_DEVICE_TABLE(of, apds9160_of_match);
 
 static const struct i2c_device_id apds9160_id[] = {
-	{ "apds9160", 0 },
+	{ .name = "apds9160" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, apds9160_id);
diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index f2af1cd7c2d1..7e277bc6a8b1 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -839,10 +839,10 @@ static DEFINE_SIMPLE_DEV_PM_OPS(tsl2563_pm_ops, tsl2563_suspend,
 				tsl2563_resume);
 
 static const struct i2c_device_id tsl2563_id[] = {
-	{ "tsl2560", 0 },
-	{ "tsl2561", 1 },
-	{ "tsl2562", 2 },
-	{ "tsl2563", 3 },
+	{ .name = "tsl2560" },
+	{ .name = "tsl2561" },
+	{ .name = "tsl2562" },
+	{ .name = "tsl2563" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tsl2563_id);
diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index 8801a491de77..a0dd122af2cf 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -913,9 +913,9 @@ static DEFINE_RUNTIME_DEV_PM_OPS(tsl2583_pm_ops, tsl2583_suspend,
 				 tsl2583_resume, NULL);
 
 static const struct i2c_device_id tsl2583_idtable[] = {
-	{ "tsl2580", 0 },
-	{ "tsl2581", 1 },
-	{ "tsl2583", 2 },
+	{ .name = "tsl2580" },
+	{ .name = "tsl2581" },
+	{ .name = "tsl2583" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tsl2583_idtable);
-- 
2.47.3

