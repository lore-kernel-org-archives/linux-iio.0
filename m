Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794610971;
	b=cpU51D/gyF587MALnoE4SFLnQ/+bL78AMdfjLbjJDb9rmgJk3tafBjk3x2+dZQ+Qdbza
	 2Fzhm9+4j+m806zh60NYP7VFJn5H18X2XBsYaK9q06n4eYAHqzZ+Bp7wcs5vbUCZWI0Do
	 i/UzMGJvkdRHpcVC84lvCRoNxOveXYacJNkRqq5JXvdqcCP7Ua75HhgKYnTvl8jAPYvoa
	 rJWHYAq6MzQpgIpq7AiLotf2mM+DPFKTj3pJAQ1awXzQgRhU0VbvxgIdtBZvoIjs3iaNo
	 y1XVyztmp++eC6sl4dswVv7ijcZCOPeluFnSLLrfZznfNcGtGnTVomFLAT3aYRKiOAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794610971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=75A5kNao/8hiq8uHxtP1L7BaRjFLXZ5Ia6WGhmfWzYs=;
	b=cs4b54m9lJ9nIA4TK9sP5bmogfddrictw4JtZy0Z4dIOUWFTaQAVwiCyo/nsoOa5RA7/
	 GtBm8KYYLhq9ScCuzIoWyhbfVauIztJ3mqqygJbrAqYkDYoON1sXew4rX9d6sd/g0t0+J
	 sWDBQITb55Ms2kubncd+InB2/mBN3mqUqVHQI0bEVS+sjMMbXGVQLv/f+g6TwuY8sfLgv
	 Gdnu4TBUC5bGHV9QEzXUdklpMgaJFpDvkYzPD4SNVsOMcX1V21Ob4wilJwNRUbVlYGIc0
	 blvIijNWTIlz7cUaw0BpdAEA3ZbA/9vk1vHVXiFk/usyYP9ijtOWT3WoMVIn/+DftgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H8hPk4bq;
	arc=none smtp.remote-ip=209.85.208.182
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A92D606A323
	for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 23:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A92D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H8hPk4bq
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3acd523a802so19685511fa.2
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 15:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794610967; x=1795215767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=75A5kNao/8hiq8uHxtP1L7BaRjFLXZ5Ia6WGhmfWzYs=;
        b=H8hPk4bqqv2uzLN1+SwOiPXsjRSVw7VvBDQlpXBb7s8jZwnJYk1tKzdVd8x2K9ShTu
         3JIFR9A1ZBBCmclZpa6i022vPlUfg9EHk9C2iMTA82vWp+vL9owY4HDLmH25x4Fv7TaN
         FNUPiRml4Igung9MUgW4ce212oks1b+VXUIb2MjRAphfdjamySyo1AHmHVRQrRw79uR6
         HIJduxqVE0a0+K54sXswycvlGEbLSDAl8z3ZMVsyWZSHggW2MVhLCXiHCAU3l8hMu+8R
         kOFo4JYnByClHAYoyL+COGXEuOxpMsp2/cQQF7F5LUlX7O890yioIMvLzPnpwHxpyU6O
         Cj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794610967; x=1795215767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=75A5kNao/8hiq8uHxtP1L7BaRjFLXZ5Ia6WGhmfWzYs=;
        b=q+N4Y2/5BsecaMrfr/uUNVrSIlcs6/VTPRbWHn9dIsVCOngkI+/ZGrwbO4zub78JZD
         iUBFWRNQJQSucECoSt8JIwxoIee8FI7mfTu0LrtrqMqGi+UnVtS+a12YtgCT1YHqpiW+
         YCT9Kss2Tp47ZJCE3IreGljQyK7suVNIrK4Wpq+VUjI5mTp0L2Sdf+4Wv/dbaOITNYVN
         1X7Ha/BzeSqGYtD4Ce/sZ++p+LHXenh155lXeZOTldxw1YwO/FZ2DN7XxsqoAsHdIsq7
         ve2AlozGFwqs6hwxGsY5HbA6Uy8AIQssQZuAKghN/oT5lwTblu5AD0j7X0sVbM1WBNBN
         Y+Og==
X-Forwarded-Encrypted: i=1; AL+hErGhVvcrxRyOofNjJLA2fldQh2vtpjWshE7TN/JvAlFs79F9+H6oMHT6LIRY868AhRQV9q8Wy5TSS2E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cqaSOfZHBVuVK2KVEsQI7Be7fkx9X6bGSuI6kqhGQo0Cayi2D
	rFoWfvckuvAXw4jHVVqRM8nOAS1bSvSYZ9nCBXqI6JfW0kmz/cypl/o9
X-Gm-Gg: AYBFou3rsMBLKNpZmZRWDWgkoewSNkrc24zkGosDhJzV2BqWIsvqj7qovWfvT++wikD
	Tokd/syOJvHydvcjXUiRCKJJOGF1szuLQoli44IH5J36PYliM9xHL1J4sdAy/LwfG+pqDvHrDGd
	Y+opoEG0Q4ZACgoxeDoLQ9Ph9+BPXf0g78jFAHAo8lG/DHa2ORSI+ucT9Kw4ZOTv5B8jOseOWIy
	ApAbLwvJ/84nAU/j349ypXssAjuJvfTKXufrRrZkA8t3DxYRX3mt2NIKwXBUZzO79D6y8wnprsa
	ezjAwSLz13domSap0si89QERxZRvvfD31sFbEAHwUbmmsNsD/YmIFpc6CF34kz8CqwCT7YU4xAU
	Rmz0HBfYUBDkORK+RRsxOlxfKzUKtfWPJiftP/wVZTnFd0jFm+R7bQMQ7Qmvya2j4+gMRWIhTOf
	qhOGqQdM39V23Vambokbpc7APsUp+hnqhH8O86nPgTefPFlQKIVOv27DVtmynuX1EX+yZckbCFl
	4e5KyzZuNt7pPCDcbBSaEp9oPr99I4gzKuYI9ElNrdPtiE9BVtsojG388oNmsc8xEkl5NI2/mtL
	hVEojPxWAQTcJbQLlRl1D8dkEr98fMlggFire6ZIPLVTaJ1hapAHEV9CIyht21/10ewtW/+tHrA
	CocyZt6N2AIQ92Q/kD/gUMfGgNKDDEcOg1Fvvaw==
X-Received: by 2002:a2e:a105:0:b0:3a9:a1ed:634a with SMTP id 38308e7fff4ca-3ae2b5223dbmr12343971fa.21.1794610967171;
        Fri, 13 Nov 2026 15:02:47 -0800 (PST)
Received: from yantra.. (nekmmqsrubyk7w1qlch-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:2fd0:3310:f4e5:7f91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae2b7e62e6sm11752691fa.38.2026.11.13.15.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:02:45 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2] iio: pressure: dps310: don't wait for new temperature in trigger handler
Date: Sat, 14 Nov 2026 01:02:41 +0200
Message-ID: <20261113230241.82046-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Each scan waits for a new temperature result before reading pressure.
With pressure sampled faster than temperature, scans then come at the
temperature rate: an 8 Hz trigger with temperature at its default 1 Hz
gives one scan a second.

Read pressure first and take the latest temperature, as a direct
pressure read already does. Wait for temperature only when pressure is
not in the scan. Read a temperature in probe, so there is a latest one
from the first scan on.

Fixes: 9b7cad9ce2ed ("iio: pressure: dps310: add triggered buffer support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261110154254.39092-1-zoone.rupert%40gmail.com
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
v2: read a temperature in probe, so the first scans have one (Arnav Kapoor)
v1: https://lore.kernel.org/linux-iio/20261111195118.36853-1-zoone.rupert@gmail.com/

Cc: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

 drivers/iio/pressure/dps310.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 85df58ac1809..3d05540f95dd 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -910,10 +910,18 @@ static int dps310_fill_channels(struct dps310_data *data,
 	unsigned int i;
 	int rc;
 
-	/* Compensation needs a temperature, so it is sampled either way */
-	rc = dps310_read_temp_raw_locked(data);
-	if (rc)
-		return rc;
+	if (test_bit(DPS310_SCAN_PRESSURE, scan_mask)) {
+		rc = dps310_read_pres_raw_locked(data);
+		if (rc)
+			return rc;
+
+		/* Waiting here would hold scans to the temperature rate */
+		dps310_refresh_temp_locked(data);
+	} else {
+		rc = dps310_read_temp_raw_locked(data);
+		if (rc)
+			return rc;
+	}
 
 	i = 0;
 	if (test_bit(DPS310_SCAN_TEMP, scan_mask)) {
@@ -924,10 +932,6 @@ static int dps310_fill_channels(struct dps310_data *data,
 	}
 
 	if (test_bit(DPS310_SCAN_PRESSURE, scan_mask)) {
-		rc = dps310_read_pres_raw_locked(data);
-		if (rc)
-			return rc;
-
 		/* Pascals, see the channel definition */
 		rc = dps310_calculate_pressure(data, &channels[i++]);
 		if (rc)
@@ -1017,6 +1021,12 @@ static int dps310_probe(struct i2c_client *client)
 	if (rc)
 		return rc;
 
+	/* Pressure compensation needs a temperature from the start */
+	scoped_guard(mutex, &data->lock)
+		rc = dps310_read_temp_raw_locked(data);
+	if (rc)
+		return rc;
+
 	/*
 	 * The device measures continuously in background mode, so a capture is
 	 * just a read of the latest results. The trigger is not aligned with

base-commit: 9752760146e642f3e4a2ec860f8767fa72030d2c
-- 
2.43.0

