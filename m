Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795285535;
	b=jIYw0NRCTCjx1EiotC0XeFcY6vsvPwmUt3ogxyuDokBEgmH5Mn1L3Ldebbz7vW+bhhwp
	 to6VwhtxWodGxHRAuoyZ+48ZwNT8ti8lL9IVyH1y96Y1EfmrnZtR4wGKMr8XXrv1Svfgp
	 NDKzaE8Ba0qKDFcaV5GVcisnkGKL/5Q5ruzkew2hv6yZcI+LWEGo05IvbhEf5VIJEMD2z
	 4ltYL7FgfHw9q+0Fq0mWDD4U3THzB/GOx2L+naCuw6y8xKXt60tl45FjQJZBZOg5yLWff
	 w58OIku9H8kP9l6VUl1R/bBpKbbuwHh3fK/mdR1bBuKHpcWMhbOHk6D76rqX/Taxb4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795285535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XIR6Wx/jogMouYNfoTVVWotCZnwikfuag8XOShgmdeo=;
	b=B2kU6TN/uvJJOWZKn4Qi3n9N5O9TdehHnIR66lNZopmp8cUPVeVeBMmlXPRMrJdyI3qq
	 xuQkwesQ5GRP1vKaxLAR8qfrslMVBe1qYKAvDB/S06HOJ0YSah71ZlZbtnckp2GNjZbEM
	 D1PITBBmC/lT2yPdAqYPqo2KCGcpZKwPWAu9yLEWseKdmBzG9qfQ0EA8lg1ZQdnWwNbaV
	 EeAjvt7MKKct4ozwaINoPV2q/3jQGr3XnTEhFVJpBzX4Q1nC8UlpZEiF58qCtokKAz8Pb
	 KKk0+ynKAMsilg2DuTaR0JSFcrnbqojL1aXA+8AUiIoKPQEFvX2Y+5xI+SmOQhEJa3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ivJVa0li;
	arc=none smtp.remote-ip=209.85.208.174
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3770606A330
	for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 18:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3770606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ivJVa0li
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3adfc004920so18065631fa.3
        for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 10:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795285533; x=1795890333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XIR6Wx/jogMouYNfoTVVWotCZnwikfuag8XOShgmdeo=;
        b=ivJVa0liH8Wp0nV1SixjK4toqh6XCBigxUkZb9iYN+7ehEtuY/JMNjSVlQp0aVLKZr
         5B3FJtA3rBiV+l/dp/9i92pOQ0IOgapx+KT+QFeYsNtrTZKU9/6zvEw1fBg1RAy1pHP4
         3ytxvcj/yHihfsdB3pEO/wo3oTWCqmCVEKA5txENfPUI272ClFlQz5X5iWxLMssqa7hX
         55y0UC5H3XyDVix5peRGc979ylryOxNAKBtrXH/IDVq7dy4gWssaVeN7DpgKgEvLMa18
         iMDXWCF4BApFi2UDC0HRKvtt7l46OtnYGGT/Y2U9NU0/SBhnd7eXFPVQk8izq0BUGtPk
         Aq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795285533; x=1795890333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XIR6Wx/jogMouYNfoTVVWotCZnwikfuag8XOShgmdeo=;
        b=jxDv5HmIdu40A1HvcMiNIiujA8bSo8oIElMa6QsVN38YhnnvYAtA03Xtm0kbK6s/SX
         PPNwDJ1C+nMm0aVV1IgWOcRyL4a/YtdS3N/x71JZ6iouvgRgdsqZioCEGwW8TEFVCdZI
         3L35dg4pERszRZy9qUZT39DsQt1JN9g9vqHlmUa/H1WtmPF9gT7RBdAxzFqN1ATYJHUW
         jJAISP4k4fk7Xwki+1IxH5XsTa7IcVT3llBVmOq/Ynpo1JQx/wZDVAKl9c+ou6XY6DyJ
         VbTDGPnR+hfAMPXiMZ0P8LApgSqsleBfoZucoXqJ7bXPTDnrb0QknG4VR/bBrzvEIcJu
         J5dw==
X-Forwarded-Encrypted: i=1; AL+hErHaid4RhPXXUx0aGe5pbTnWmgD19lIwtEpoMT+88xToCQSajvz0ETMTpeLtS9O64wWnJMdnpd2LlOY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BVMvijpeiwB5QGTzSOBmHEokh3R1DLcpdnYfiVt5kPe7bcW9x
	0GD39h8+lcYCBkOcDTIiBi9gjp+M/824/iZm26clzy6kAMvgc8yzJtCWV1Qi7UJn
X-Gm-Gg: AZFdTZf+BtpKRH3+yKz4L1G+VNQWZ8iCfqbJNZH5wDO8WF69TyHHibDZJX734HyXr8U
	ClpYH/PpsXnazsn+6lcD3m7vcxSwbN3jTIKQy8rt69cReLJeTkjaXukNXzjdmrwSrfeOq2yICh8
	kuZnIxJ29Wz3CtTJa66vDA6N/4ZqkrvffVtNIezHYJqwNE3LMJJ4AlztFusCClULBKny5SKcB2F
	3dZxI9JAbaXWYyGXeHMuijyB82Vh+Oyf4tYEtzOvq1xDGD5iJ5mD1nexj66cPfvsXB80iCroRbg
	OHb2KePinhkSSvKqUiRGR78XIsZkBtgPA/WEjyS88IGjEll0pLpJjzMp76gFNyY+fdve8PcouTK
	W5Qwk8Tt/Wsz5CVXxBaN4iiPrfYYF444loHTEhUrxo0bVphvL2etWiXFJRdyu/ltulU73VHVj1S
	Koso7nWWUjVILTpu2JKGO4iUnn75ke5MDPRHcRVaTesqdsclKf8Fqonwdia5SNp6WlxzESXCL1C
	pbMgggbV6IRebRAPXQifXJ8kDazcd4Qy6FnSOVnsw39ac5awLj+uZSjGOJ2qaQjpAuFYKq0Rdvq
	2ZIV4UupQoEfPMYSWuATiSlA6gHB2f3NHPkg+UtveburNTMMkfJP9o5y1hJ81fdSFaJS92KOFpm
	BSI5DIP1xThIOnXvj/jFMFAiRboSwIhZDaLTXLw==
X-Received: by 2002:a05:651c:19a9:b0:3ae:6273:a010 with SMTP id 38308e7fff4ca-3ae7f9a6933mr23888191fa.9.1795285532768;
        Sat, 21 Nov 2026 10:25:32 -0800 (PST)
Received: from yantra.. (nekmmqulvmgxaw4nwuk-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:a86f:851c:d740:ea0c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae80538a4esm17472771fa.29.2026.11.21.10.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 10:25:32 -0800 (PST)
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
Subject: [PATCH v2] iio: pressure: dps310: read the first temperature in probe
Date: Sat, 21 Nov 2026 20:25:27 +0200
Message-ID: <20261121182527.34489-1-zoone.rupert@gmail.com>
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
v2: return inside the guard scope (Andy)
v1: https://lore.kernel.org/linux-iio/20261119190827.36947-1-zoone.rupert@gmail.com/

Based on iio togreg, fine to squash into 903941a9b06a instead.

Tested on a DPS310 on a BeagleBone Black: enabling the buffer without
a trigger works.

Cc: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

 drivers/iio/pressure/dps310.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 9b52cbc2372a..fc727e5fcd59 100644
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
@@ -1478,6 +1471,13 @@ static int dps310_probe(struct i2c_client *client)
 	if (rc)
 		return rc;
 
+	/* Pressure compensation needs a temperature from the start */
+	scoped_guard(mutex, &data->lock) {
+		rc = dps310_read_temp_raw_locked(data);
+		if (rc)
+			return rc;
+	}
+
 	/*
 	 * The device measures continuously in background mode, so a triggered
 	 * capture is just a read of the latest results. The setup ops run the

base-commit: 903941a9b06ae445c70646ab061b604c2dea17d3
-- 
2.43.0

