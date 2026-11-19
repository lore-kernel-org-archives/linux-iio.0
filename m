Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115315;
	b=0UJTVytUTj2er26v5biBVbYwuZRzLtVK7T0I7H7/O9E9nrCQlR1G9QlfjF79eEQYtmZR
	 WqFnVFbd+xVlqdQvRf/MQQHbQcIxegDcvWObxY4uE7LWnhYFcWzWpJ3jLNCkR1hrEepvE
	 QbCCR8YC9B5uZ5bnwtY9K2rU+NkjyrX73xvUZMZBn3LaARCRCxUueE4dUsN2ebilLy81n
	 K0cWXqEI49SgEhVuc2EIJwKRqbzK4/OcnYb4L7LT5w9l0fVl0ugyINAKMBMpZIl03/bng
	 tLnXtghwk50RHQiyt+sW8Ww+vf+/olqFmHxxBMtkVtfuS6CY1L2uoZDThUV5DfBO7ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UQGqXnVXE/6wF3pb82GfzovBiLKDNONE4MZwuQ7yLjQ=;
	b=bGWXZaHH5oLV5VHTwP7Ft8bhRSIusJ+H0f0lvD6bQeaVKvXQ6cSIiFFP1esug7t7xp1v
	 ZqFuFFuvNPxP2eRFdnlCPWjMeNvEISoLgIJArCKbgKRrrmZ8LrPXQiMU6K3JgfMYIe7ql
	 c9mXW2NEmPqmfWii0F4N4DrHPqPVzDey9XWRGlyF1MyHU9HK4m+2K83CQSsGIABmlPVii
	 LdBPDwkouoBDt+AbGlZ2acrKhi4zHJzzbXGhzhbpQwcYA42fsVHM5jKFKJwSsJxCe8MpV
	 CuHd9VpzD/dT4jk1BqFN28XskVsC4A3lhVW/+9/W2SC9vC6UfD5F077uvpjNhl+z45A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iyRmx8n4;
	arc=none smtp.remote-ip=209.85.208.177
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0BC606A32A
	for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 19:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B0BC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iyRmx8n4
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3adf9b1f5aeso12219581fa.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 11:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795115312; x=1795720112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UQGqXnVXE/6wF3pb82GfzovBiLKDNONE4MZwuQ7yLjQ=;
        b=iyRmx8n4vpQclEboNZ8lb459ncIbpraoDdR8PjKNSBooXOCREjqKiWqFeCp6Q7Ry/o
         jJa0lR+QwANG/aevovDPW8/mNJx/FqcqNuMq7sdLpyURiLBpNftBNmZpcxMNlKsKTqNe
         fKGz7670ccjwJUDfSFjrYojGpAMXDgzUtkfreZuGsICc7G3lIpt44Jf3TrN4Jd3Qbh7u
         IRTEnvuwMtpnR14jH9PqKvRy78m6vKeF6doIW9EccpSjzHfPvYav7zrL7WD7DEBwqAtA
         nKUQhz4laRB1F3UxJS0TZeEHyphSXLLqyyTCWZQQAE1BprGMK6aS7CZbCJeenNK3mqFi
         HAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795115312; x=1795720112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UQGqXnVXE/6wF3pb82GfzovBiLKDNONE4MZwuQ7yLjQ=;
        b=OSUJwP17wFKQSREAY5HP6ufaOELypS5f3qHAGdcDMy1Qfnx5Y4kVIrlskejX8J5IEm
         rmtM/ulvwHqcRSni9AMvrzrL4mZK6zhofCu+R/7AGeilBtddUO8mWM6JFpmjvrbkGuCI
         YBZoJxVSVTx179gCaT/oK4FXjK/c/LgZFPuFQISX/L6v35DfugaGV8ahFU+VO5sNIIVl
         pSlXPMt6xZLN6xdRKCmy8ubfs0anHyyQAl+IXM4xmoXuDR+0uup6cYjMWvJ10J5olYFW
         MkPuY6NLjeZ8y6AtWHqoH9gjQZZ30OyMAYXuWEX5pWjtwMATE9stVuXKDAxazRFa5Lpz
         fQEg==
X-Forwarded-Encrypted: i=1; AL+hErFUjyGR315VDzCl4MDDFZDuduoOr2R7imL8a366hPLywXymTtB71LLq+QNxVItFPuKavQmtTi4sKPM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OuCSeEoSdMahz7qm4GWZ8NzaL8iMrGIt/frkn+xYtI6eq9Noj
	agVJnEthrQ+mGqdq+c7NHRFoz7PQit8VLCXDAq+lpNAFW5rDl7SKyilW
X-Gm-Gg: AYBFou2ijMWAjYjzQfL9miiQCjJkEvNIcA32+llCTVUTIdcIhvnO2gDOnjHi3WmduYT
	QbKbAY3k8s/lLL5JGuvy88My8Y+VPL8XdNBlB3UaaXvMIO5h+goIqoS5BT6UJfBVdRRzS8NWdQR
	0HFQsrTGWLk7/El758QByO5tknOE40gymJwALJVyrJznOoBqNlG/GrGrCkSVNWz3NsOU04BWsdM
	7txDhbCt1WmaDI6Tn+Up+1F6JtqbSM8yCU4DcbjITwiKbep+P8SqUV2FNuKfN4VzXhmHRPLo2Ra
	+CbUoMxa6pctVP6reeYihhfg3K/oqTliMot57h6X3ccCDjymPGvSDZrE8NuB2XjtNEC+NNZS8XQ
	PePkeTw5ETPKtmj6lCdsV4cPUUMNSr81H1iUOiC5TwsBgsVzpdHXX5CPtF2DaOW2nB1HOJ6abnv
	znxo9juOoQ1dR8qz0TFgYao2xJlAEpMFBZT8ipjwsdwUyCdxTdLwmHGuiHpXLXDmHpxkrcItiXn
	cTJimqRwtDdN5rh5UYhwBymD/rl8cQZaimlwbVweNzy5M2DykbH5ph9TKtN5I8V5pQ5GKB2K3eO
	k5jf+VbLQOb+nujDIpLLNXvt5qjefxmLZl+VHz9xG8LUwNBlhydQ3SFajfoJtGX9gLZ5eRBnfoO
	QX340Kn3yqV5++kVlzGGew19k6ByWOn0KGEZFVyARH/q1t3XGkVtOiahm4a4=
X-Received: by 2002:a05:6512:39c8:b0:5c1:57ce:d4b2 with SMTP id 2adb3069b0e04-5c1b7c78c9bmr718744e87.33.1795115312011;
        Thu, 19 Nov 2026 11:08:32 -0800 (PST)
Received: from yantra.. (nekmmqt5p04tda8ausa-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:491d:95cd:6e94:3a5a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd018b45sm63965e87.41.2026.11.19.11.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 11:08:31 -0800 (PST)
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
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH] iio: pressure: dps310: read the first temperature in probe
Date: Thu, 19 Nov 2026 21:08:27 +0200
Message-ID: <20261119190827.36947-1-zoone.rupert@gmail.com>
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

The first temperature read is in dps310_fifo_interval() instead of
probe. That function is called with data->lock held and takes it
again, so enabling the buffer without a trigger deadlocks.

Move the read to probe.

Fixes: 903941a9b06a ("iio: pressure: dps310: don't wait for new temperature in trigger handler")
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
My v2 was on fixes-togreg and its probe hunk does not match testing,
sorry for the trouble.

Based on iio togreg. Same change as the diff in [1], fine to squash
into 903941a9b06a instead.

Tested on a DPS310 on a BeagleBone Black: enabling the buffer without
a trigger works.

[1] https://lore.kernel.org/linux-iio/20261117110735.46400-1-zoone.rupert@gmail.com/

Cc: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

 drivers/iio/pressure/dps310.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 9b52cbc2372a..ebfaa67a6b91 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -1058,16 +1058,9 @@ static unsigned int dps310_fifo_interval(struct dps310_data *data,
 {
 	unsigned int drain_interval_ms, fill_ms, want_ms;
 	int scan_rate;
-	int rc;
 
 	fill_ms = MSEC_PER_SEC * DPS310_FIFO_DEPTH / (prs_rate + tmp_rate);
 
-	/* Pressure compensation needs a temperature from the start */
-	scoped_guard(mutex, &data->lock)
-		rc = dps310_read_temp_raw_locked(data);
-	if (rc)
-		return rc;
-
 	/*
 	 * There is no hardware watermark, so take it as the number of scans
 	 * the user will wait for and drain at that rate. Scans come from
@@ -1478,6 +1471,12 @@ static int dps310_probe(struct i2c_client *client)
 	if (rc)
 		return rc;
 
+	/* Pressure compensation needs a temperature from the start */
+	scoped_guard(mutex, &data->lock)
+		rc = dps310_read_temp_raw_locked(data);
+	if (rc)
+		return rc;
+
 	/*
 	 * The device measures continuously in background mode, so a triggered
 	 * capture is just a read of the latest results. The setup ops run the

base-commit: 903941a9b06ae445c70646ab061b604c2dea17d3
-- 
2.43.0

