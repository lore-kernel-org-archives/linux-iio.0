Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795140655;
	b=t6cT8hvpiggczTv7zQxuOy3ZSz8J6Gum9Wz6rXrNU4bGq9sSBucPpGcLPVQa39XDIX5Z
	 1TUW/AfO1IB0dTsbazipqQ5RXR62VlrMdOEtQEWzLpA88SWCXHHlLklDD0q96aVJItoLM
	 C3MxIpYoslZgjFIdksLfegIfAB+7J0o6V4+2XO9TiSjZ8SfIFrYRJMuDurko37IY27y/B
	 Ft8Y/KqOqyfdGp4UBke0dMhADVwc/iAqaWRkSBqGB9G5uZCrm9A9UJ/+XBwSv4AyOmaBF
	 6jWcQpHlhIB8F94iD4dml8RlpjPvkFFfQFsnMYLdDHZz4nzgwUvMlyc3S1pHMaYc8Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795140655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RJn+hkZf3RqN/RrP1c9RUAnn/ZcmBsgELIXfGkI4e7M=;
	b=kS11+6inEfOGf1ESL/6GCw6K3Ie9s0j5Jo8i3s5PNn6XKrgFkonEYdwBXxFxIHDmdt12
	 KsmVPa0mYBIoqGR49VflB4GGKH6bFhdNNN3v9zj/SUhG+Bru9+TDRMmHq/Evu1pVlPKht
	 hwP3aBaqKqlYDBlLZEiNO0aLoEexpDmBplYpP+oSN7y78TJ12o4qEtLhlIXUcSGFTIFSU
	 sN5Tny1ACvnhVic84Wkno9z12ZD6Px3gNp/S7BW3wHx3FyoXa3whmr3TkQu5Xsy6hx0x/
	 9E6nUx2lx08sDHz7msiZymFkIsyo7orHXJ6ShBfgDEE//N+hO66XjJ8D4Y7OCyYCPwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=reflexrobotics.com;
	spf=pass smtp.mailfrom=reflexrobotics.com;
	dkim=pass header.d=reflexrobotics-com.20260707.gappssmtp.com header.i=@reflexrobotics-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bJXYVYyq;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15754606A320
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 02:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15754606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reflexrobotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reflexrobotics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reflexrobotics-com.20260707.gappssmtp.com header.i=@reflexrobotics-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bJXYVYyq
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3282db206d3so997328eec.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 18:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reflexrobotics-com.20260707.gappssmtp.com; s=20260707; t=1795140654; x=1795745454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RJn+hkZf3RqN/RrP1c9RUAnn/ZcmBsgELIXfGkI4e7M=;
        b=bJXYVYyqM/nXgsKJZbji+NrgPfrpbV7fGjidiuCfWSU5x+2E8lyBQKNuI9gdFisAOV
         IgaosAThctvV+eLzR9GJwyjeZ/0/nglqbGgVhP2BlUxMXMDl0gzEzn4a0LS9oBSz503M
         bCNwWOT+6Jr3twx9YJrROzGEqAwZzXkPzQJ2PSndWyljE+2vi0rUbeUexzCmST2CZ/T8
         n+NISlTN0UyBRfZWJHBe/8eF0j+IrU43wrywZjik3Ccsd5lOfmirf6w1GQhYLgFwQLJx
         ENHlx10m1wvihgGOsqbhmVZcAcCiq5aCCIvF75BPEDfIpA8vBd3QU6TwyxN3AWYLf/7K
         2qzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795140654; x=1795745454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RJn+hkZf3RqN/RrP1c9RUAnn/ZcmBsgELIXfGkI4e7M=;
        b=iM2f0BedEhvtE7sd2NknGJyZOgrpm2yo+G3tEJg2Ab7EgakbPCYLOS9SHAf0DqLdqK
         tjSfEly1Ji/Frbku6JYAtsC7SORoeoHVMmTT2awjkeDd40+sl4JUJx4P5ysX1iztZ/2K
         9GWU4GyP/Dn5dQ/8jjuJME3i+rJg4z/BjlcydazEgqRSkcwonFm9vLH6Fe0Wt7ofYWdm
         gfYv+B50Hfoi8pDhYCUfx8UDOXQuP8KqdnIoBA9LRVeRlt3RediFwSvhIwgSkDOLmulF
         tK0FaYLTkayTSvlSpA9362uUQ5m0Ff7K+iqhCQdtsO+0OEgaUY0KAmP7iQyGYWGVHTgi
         dmlw==
X-Forwarded-Encrypted: i=1; AL+hErGc5UJ8Dc6bxZQ5pTz9qRS8Hs611K2hS/UJE39rr5hA1OXpqugkgk44Ceo/N30efFFC/clclj7qMvs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CTECgvyOtBRN3wHOOkSLkjd2Fd/+ZKGqHMj3LEqXtkDrDgJel
	szBpISj0E7FLcmacChx2kCnJyHDP+O4b7DGtHszCzrZdptWNPNR0hco3HKrqh1Z7hoc=
X-Gm-Gg: AYBFou24XkPdVDpy6WiFwRtV29kGsPQqa3bkdZzIfiSvwSJYQlmxRMfiRuMO6FOiq5l
	zyRvknpbgwWhdoF5PzuzbsG5a0Yqy8qu/bQpWi0KdjoYeKsjssCYZSCQmLtHn8GEia9U3BolzL2
	QJrxMSMl1qSWvu9I7to2tNRZBxbu4dZyyRh6FsfsMwNboEkOS4HhMIbcpOTWvywPSYa7PB6rTM3
	++ySLXRWMDu5DrTfSwvtlF4lrc9U5d4/LOMG+I1p905EBaMPMrgxhAyrhPYjInsXjienl7prUOg
	qlyk7AtRYPBhmCTIndxHU5dXbjO9ZDlgMq09NDHfucUN86tlm8MDBD3+7DhrLdoQwNHYw1/fH4a
	k3qRI+FNvvt+4zG1ipRcVqx8M9YAVn4XyMk9yYar+891+HeTRpL51YRZCt4z5tM0UUhQNg0oTjo
	QMhFMAEUeTAR+gspun8aG4EF80jHTNO/S1q3G7rzIvPee3wIQ2G+JpnMa3M8XrIrWAhs0Io1sEj
	bFeof3j8ieWg7hOL7KXNYkzkgVPt2/+7ZN6JdaEdrioAMXaxrx3vKblYDuAQMY17IvZ1Wga3NJs
	hB5Vh6W/qFzeVQ5UmcWZj03ivH0OjZaSAGf7vI26FKvbaP2cCli41woNoxHz7G8ehaKX/GwitHE
	KzXjNDScCOu0xbBGCEfYlggw=
X-Received: by 2002:a05:693c:41cd:20b0:378:3227:b4dd with SMTP id 5a478bee46e88-3856f03cacfmr1229064eec.18.1795140654085;
        Thu, 19 Nov 2026 18:10:54 -0800 (PST)
Received: from localhost ([76.51.7.19])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-38567da4f85sm2806190eec.27.2026.11.19.18.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 18:10:53 -0800 (PST)
From: Joe LeVeque <joe.l@reflexrobotics.com>
To: jean-baptiste.maneyrol@tdk.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joe LeVeque <joe.l@reflexrobotics.com>
Subject: [PATCH 1/2] iio: imu: inv_icm42600: return -EBUSY for temperature reads when idle
Date: Thu, 19 Nov 2026 18:08:49 -0800
Message-Id: <20261120020850.24318-2-joe.l@reflexrobotics.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120020850.24318-1-joe.l@reflexrobotics.com>
References: <20261120020850.24318-1-joe.l@reflexrobotics.com>
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

The temperature sensor only measures while the accel or gyro is on.
With both off, its data register keeps the last measurement, so a
temperature read returns stale data. On an ICM-42688-P, a value held at
about 52 C was returned while the chip was at about 62 C. The data only
reads as invalid before the first measurement after power-up.

The temperature is the die temperature, used for accel and gyro
compensation, so return -EBUSY when both are off instead of stale data.

Suggested-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Signed-off-by: Joe LeVeque <joe.l@reflexrobotics.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
index 7f80bda471c3..b35706bb1c8f 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
@@ -23,6 +23,16 @@ static int inv_icm42600_temp_read(struct inv_icm42600_state *st, s16 *temp)
 	pm_runtime_get_sync(dev);
 	mutex_lock(&st->lock);
 
+	/*
+	 * The temperature sensor only measures while the accel or gyro is
+	 * on; with both off, its data register holds a stale value.
+	 */
+	if (st->conf.gyro.mode == INV_ICM42600_SENSOR_MODE_OFF &&
+	    st->conf.accel.mode == INV_ICM42600_SENSOR_MODE_OFF) {
+		ret = -EBUSY;
+		goto exit;
+	}
+
 	ret = inv_icm42600_set_temp_conf(st, true, NULL);
 	if (ret)
 		goto exit;
-- 
2.34.1

