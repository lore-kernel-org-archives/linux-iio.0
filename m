Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610901;
	b=Gl08a8zxqiubbARptX2eHZkzP7dnEp9RAbBT+QQlvqldsK0tuZ/Y8fjADCaKSNHWPnie
	 8YuxnGDCmckmrlyVMetA55vgew8EIHxORULnL+qe0bq3mVF52rqAEKWYhiWN/5zq+aQ0d
	 WAe7JBq7FtuZ71LvDjEGXi1CKHfnycce6DC2pXosKxOTeCmgCByIyh37LaIBBOI2yanIl
	 vzeIkVmgjgxKSvNGyIkY4Xjov1zFl5QnlQWqZU612PzoqQGOzTxLqyy3knDgYO1g3TQX2
	 JHKtAX8WOFYbZ0vEEbMU5jjCz1bvvC25vW46LzK2nn+1hfIZhYbK2hlD+GsdL6WtEhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610901;
	h=DMARC-Filter:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-FEAS-BEC-Info:X-FEAS-Client-IP:
	 X-FE-Last-Public-Client-IP:X-FE-Policy-ID:X-FE-Hostname:
	 DKIM-Signature;
	bh=MrOe3UikfYsK/XTrWoF+9EdhW5CH5E2Gx0DmcIHb1eM=;
	b=5jwiWj2Ux9zbwiaIws9wZ4l063Ja2jAum6posiZYAcIAICAOcIrGfnhluyQeZ3bkmVmy
	 H4nHA2DQawt8f3QK3X4eVSo2pF5lwI2xyapr9MossR8UDMOKwaNXcYOkqsKulTHkffZ+G
	 FJ1gU20UEBjNNP97g7sDkmK2Lph2bgROnFkIpk2FNKCMythAORbezGWbW8Wrz/ubnbLsj
	 yiDMTbwiZcnsq6YmVKpP7i5sjuvlVnCOEfLbs8FGt2YM9Hxq4Eo4kKoZjnmsFBzQMk66Y
	 wsxS9mZvrZD5pL+iwyf1WBA7lnw54r5/Ld/GERgY7yHqT3LoBspvmMkQHgjJTGdwDuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b="m2Sb/66B";
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B078B606A32E;
	Mon,  2 Nov 2026 09:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B078B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=m2Sb/66B
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6A29EdV6024493-6A29EdV8024493
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 2 Nov 2026 11:14:39 +0200
Received: from ex19-16.utu.fi ([130.232.247.56])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <jaakko.ma.koivisto@utu.fi>)
	id 1xNo7j-00Gk5m-Fk;
	Mon, 02 Nov 2026 11:14:39 +0200
Received: from lorpotin (91.145.105.139) by ex19-16.utu.fi (130.232.247.56)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 11:14:39 +0200
From: Jaakko Koivisto <jmatko@utu.fi>
To: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jaakko
 Koivisto <jmatko@utu.fi>
Subject: [PATCH v2 2/5] iio: chemical: sgp40: Replace manual locking with guard()
Date: Mon, 2 Nov 2026 11:12:55 +0200
Message-ID: <20261102091258.247402-3-jmatko@utu.fi>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102091258.247402-1-jmatko@utu.fi>
References: <20261102091258.247402-1-jmatko@utu.fi>
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
Content-Type: text/plain
X-ClientProxiedBy: ex19-10.utu.fi (130.232.247.50) To ex19-16.utu.fi
 (130.232.247.56)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFpdSAIJCQMDB0YFCUYDBwEeARscBygdHB1GDgFIWUhZXkgJAygB
 HEUDBAEGDw0aRgwNSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhdSFhIWEhYSFleSAkDKAEcRQMEAQYPDRpGDA1IWEhZXUgJBgwRKAMNGgYNBEYHGg9IWEhaWUgM
 BA0LAAYNGigKCREEAQoaDUYLBwVIWEhaXUgEAQYdEEUBAQcoHg8NGkYDDRoGDQRGBxoPSFhIWVBIBh0GB0YbCSgJBgkEBw9GCwcFSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=MrOe3UikfYsK/XTrWoF+9EdhW5CH5E2Gx0DmcIHb1eM=;
 b=m2Sb/66Bin4Zru6walYtm982eCFNWOXrh6HAQvdi4BtauFuw2SMB8iYwz0/XaLbmY+tS0mjDqvOO
	312leqsTuYtNz/QpHMpCtEGlZkPiJETCy0k4yZCD8ypkaGWmaci0Ok6s/qJ8N76DvbaswV+89THm
	9ZXZFPTINaHqg5bI44lVjrES+YX8vXcaKfxQQXIyeq/V9zrexN4xuCbALs+ne4pMsAw07tgp55vU
	RlV4H4lz1wQvDOgHUp4dRX7HJc4oPa1BUvjbjw0gqHjsv8ny7dhQu27A12cnED+IdtXwU9opGswa
	pH8xevQsfbd7wcyDsp11aZ4dJOZr2OG6o/KVwQ==

Replace manual mutex_lock() and mutex_unlock() with RAII-style
guard(mutex)().

Extend the lock in sgp40_measure_resistance_raw() to cover the
I2C send and receive cycle, preventing I/O-errors if the device
is currently running a command, or clobbering the output of a previous
command if a new command is issued during the sleep-period between
i2c_master_send() and i2c_master_recv().

Signed-off-by: Jaakko Koivisto <jmatko@utu.fi>
---
 drivers/iio/chemical/sgp40.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
index 3a239fb6847f..080d51f9f53c 100644
--- a/drivers/iio/chemical/sgp40.c
+++ b/drivers/iio/chemical/sgp40.c
@@ -148,9 +148,8 @@ static int sgp40_calc_voc(struct sgp40_data *data, u16 resistance_raw, int *voc)
 	u32 exp = 0;
 
 	/* we calculate as a multiple of 16384 (2^14) */
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	x = ((int)resistance_raw - data->res_calibbias) * 106;
-	mutex_unlock(&data->lock);
 
 	/* voc = 500 / (1 + e^x) */
 	exp = sgp40_exp(x, SGP40_CALC_POWER, 18);
@@ -172,7 +171,7 @@ static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *resistance
 	struct sgp40_tg_measure tg = {.command = {0x26, 0x0F}};
 	struct sgp40_tg_result tgres;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	ticks = (data->rht / 10) * 65535 / 10000;
 	ticks16 = (u16)clamp(ticks, 0u, 65535u); /* clamp between 0 .. 100 %rH */
@@ -184,8 +183,6 @@ static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *resistance
 	tg.temp_ticks = cpu_to_be16(ticks16);
 	tg.temp_crc = crc8(sgp40_crc8_table, (u8 *)&tg.temp_ticks, 2, SGP40_CRC8_INIT);
 
-	mutex_unlock(&data->lock);
-
 	ret = i2c_master_send(client, (const char *)&tg, sizeof(tg));
 	if (ret < 0)
 		return ret;
@@ -232,16 +229,16 @@ static int sgp40_read_raw(struct iio_dev *indio_dev,
 
 			*val = resistance_raw;
 			return IIO_VAL_INT;
-		case IIO_TEMP:
-			mutex_lock(&data->lock);
+		case IIO_TEMP: {
+			guard(mutex)(&data->lock);
 			*val = data->temp;
-			mutex_unlock(&data->lock);
 			return IIO_VAL_INT;
-		case IIO_HUMIDITYRELATIVE:
-			mutex_lock(&data->lock);
+		}
+		case IIO_HUMIDITYRELATIVE: {
+			guard(mutex)(&data->lock);
 			*val = data->rht;
-			mutex_unlock(&data->lock);
 			return IIO_VAL_INT;
+		}
 		default:
 			return -EINVAL;
 		}
@@ -263,11 +260,11 @@ static int sgp40_read_raw(struct iio_dev *indio_dev,
 		*val2 = ((voc % (1 << SGP40_CALC_POWER)) * 244) / (1 << (SGP40_CALC_POWER - 12));
 		dev_dbg(data->dev, "voc: %d val: %d.%06d\n", voc, *val, *val2);
 		return IIO_VAL_INT_PLUS_MICRO;
-	case IIO_CHAN_INFO_CALIBBIAS:
-		mutex_lock(&data->lock);
+	case IIO_CHAN_INFO_CALIBBIAS: {
+		guard(mutex)(&data->lock);
 		*val = data->res_calibbias;
-		mutex_unlock(&data->lock);
 		return IIO_VAL_INT;
+	}
 	default:
 		return -EINVAL;
 	}
@@ -279,6 +276,8 @@ static int sgp40_write_raw(struct iio_dev *indio_dev,
 {
 	struct sgp40_data *data = iio_priv(indio_dev);
 
+	guard(mutex)(&data->lock);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		switch (chan->type) {
@@ -286,17 +285,13 @@ static int sgp40_write_raw(struct iio_dev *indio_dev,
 			if ((val < -45000) || (val > 130000))
 				return -EINVAL;
 
-			mutex_lock(&data->lock);
 			data->temp = val;
-			mutex_unlock(&data->lock);
 			return 0;
 		case IIO_HUMIDITYRELATIVE:
 			if ((val < 0) || (val > 100000))
 				return -EINVAL;
 
-			mutex_lock(&data->lock);
 			data->rht = val;
-			mutex_unlock(&data->lock);
 			return 0;
 		default:
 			return -EINVAL;
@@ -305,9 +300,7 @@ static int sgp40_write_raw(struct iio_dev *indio_dev,
 		if ((val < 20000) || (val > 52768))
 			return -EINVAL;
 
-		mutex_lock(&data->lock);
 		data->res_calibbias = val;
-		mutex_unlock(&data->lock);
 		return 0;
 	}
 	return -EINVAL;
-- 
2.56.0

