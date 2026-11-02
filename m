Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613475;
	b=ewM8wosmn716/Uw+DqYU+J62W2VVhB9zT8yUaxClkAp4Mr64D1aZsmfbLwW71/1hPcJQ
	 kqGQrKe7IOkDHeGh0l7kqTs+Bk8giZPIZkTn8jjvwJG/Seg7rdlWQM7ICxx5hl/wl3Lo+
	 D4gnSrfWbuG7l2lFmWYZJixPxWt1JnXVHwsWy/XIu08+avYBlTP3x9MFK3WTZgz2fnKe7
	 f4y+uB9V4cSQ+3UhLEKFaFF9usEnjpb5L0uG34DqniJECfezrn6OyDAx7QJlzTeQfxNy9
	 Ih6NauboFN9HbONlEAYSmZfLSa3FRAAlgzxypPS19x3pAAPia47IZOzwRfsyf1AIk3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613475;
	h=DMARC-Filter:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-FEAS-BEC-Info:X-FEAS-Client-IP:
	 X-FE-Last-Public-Client-IP:X-FE-Policy-ID:X-FE-Hostname:
	 DKIM-Signature;
	bh=O3jVSvvryYZl7OF3FZBbst06ttsT1TkPtiH56l6h7gM=;
	b=CUWn0vnYLOuYST6CUjhQJqBRDQInsbi5WiD10SEL+san/FdPSV8Y/l5gxrJ5pzhgmrPg
	 puM5pKDx/Hyoiwgm+Ewi9xpxzM7W7fnflOY+CKuWQRFW4Yb3tbkvp7mt1VeGSA7PJ+z0t
	 G7ErsDNX6fMSVdB8Zpbgxa4ZYFZ3/yomuiOf6xmRDn/BKNH86QEIIL3drUQuyW37GBCIB
	 MI7h/1L3bWMxSHZfsGQB5Rh+iEUFRIm6VK0vFBffYHFrge7vIpcqDbeM7/KWHdNJhRBkk
	 3njxaaI2+2Se2OdumnR8vCm0x8PTTdkKVECBiy44f+uimUS1l/KcSmkOQQnxi5+ngNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=BYOdEAWJ;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB44606A324;
	Mon,  2 Nov 2026 09:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AB44606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=BYOdEAWJ
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 6A29vSRr023761-6A29vSRt023761
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 2 Nov 2026 11:57:28 +0200
Received: from ex19-16.utu.fi ([130.232.247.56])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <jaakko.ma.koivisto@utu.fi>)
	id 1xNonA-00HHFg-3x;
	Mon, 02 Nov 2026 11:57:28 +0200
Received: from lorpotin (91.145.105.139) by ex19-16.utu.fi (130.232.247.56)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 11:57:27 +0200
From: Jaakko Koivisto <jmatko@utu.fi>
To: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jaakko
 Koivisto <jmatko@utu.fi>
Subject: [PATCH v2 5/5] iio: chemical: sgp40: Implement turn_heater_off-command
Date: Mon, 2 Nov 2026 11:56:02 +0200
Message-ID: <20261102095602.333752-1-jmatko@utu.fi>
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
 HEUDBAEGDw0aRgwNSFhIWkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEhdSFhIWEhYSFleSAkDKAEcRQMEAQYPDRpGDA1IWEhZXUgJBgwRKAMNGgYNBEYHGg9IWEhaWUgM
 BA0LAAYNGigKCREEAQoaDUYLBwVIWEhaXUgEAQYdEEUBAQcoHg8NGkYDDRoGDQRGBxoPSFhIWVBIBh0GB0YbCSgJBgkEBw9GCwcFSFg=
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=O3jVSvvryYZl7OF3FZBbst06ttsT1TkPtiH56l6h7gM=;
 b=BYOdEAWJzH2vOSXkviwG/cx4EGPYm5HH3Q4+EdjW7Y+9+TZ+w8Kb4NYVH+uO0zmNku9G9we0+Plp
	qpIPbmHrwOCHHAkvia2f0joAgSbIO9HvDTkzQY3lPEBPJvPCDmy8iy50saCg7gWxdNm37UTL886+
	d1eWtaqW/uHy44rmzt6g83Q+in0Wl8lg0C5BZtOEo/GQMy18NPLDfJ1M7/ICha3KkdButRBOF5tg
	beKoK3BPDXEpv2lPUrXeaqQpEkeWKTNFcOGD4QlZ+iR/FDOxpibYd71GJCrCbnTpHXIVDuCOazGK
	GOrXsm+Zcrg4B0o7HHDblviIbOQWPriUeTUNXg==

Add functionality for turning the SGP40 sensor heating element
on or off manually. After turning the heater off, the sensor enters
idle mode. Track the state of the heater in the driver, as the device
does not expose current heater state via any register.

Turning the heater off saves approx. 2.5 mA compared to regular
operation. The heating element is automatically turned back on
when measurement is performed.

Signed-off-by: Jaakko Koivisto <jmatko@utu.fi>
---
 drivers/iio/chemical/sgp40.c | 62 +++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
index 278390bc6b04..87df8d79fe6e 100644
--- a/drivers/iio/chemical/sgp40.c
+++ b/drivers/iio/chemical/sgp40.c
@@ -54,7 +54,8 @@ struct sgp40_data {
 	int			rht;
 	int			temp;
 	int			res_calibbias;
-	/* Prevent concurrent access to rht, tmp, calibbias */
+	bool			heater_enabled;
+	/* Prevent concurrent access to rht, tmp, calibbias, heater_enabled */
 	struct mutex		lock;
 };
 
@@ -263,6 +264,27 @@ static int sgp40_execute_self_test(struct sgp40_data *data)
 	}
 }
 
+static int sgp40_turn_heater_off(struct sgp40_data *data)
+{
+	int ret;
+	struct i2c_client *client = data->client;
+	struct sgp40_tg_measure turn_off = { .command = {0x36, 0x15} };
+
+	guard(mutex)(&data->lock);
+
+	ret = i2c_master_send(client, (char *)&turn_off, sizeof(turn_off.command));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(turn_off.command))
+		return dev_err_probe(data->dev, -EIO,
+		       "i2c_master_send ret: %d, expected %zu", ret, sizeof(turn_off.command));
+
+	fsleep(1000); /* Max duration for command turn_heater_off. Datasheet table 8. */
+	data->heater_enabled = false;
+
+	return 0;
+}
+
 static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *resistance_raw)
 {
 	int ret;
@@ -293,6 +315,7 @@ static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *resistance
 		return -EIO;
 	}
 	msleep(30);
+	data->heater_enabled = true;
 
 	ret = i2c_master_recv(client, (u8 *)&tgres, sizeof(tgres));
 	if (ret < 0)
@@ -423,10 +446,47 @@ static ssize_t serialnumber_show(struct device *dev,
 	return sysfs_emit_at(buf, 0, "%llu\n", serial_number);
 }
 
+static ssize_t heater_enable_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
+{
+	int ret;
+	u16 __ignore;
+	bool val;
+	struct sgp40_data *data = iio_priv(dev_to_iio_dev(dev));
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	if (val)
+		ret = sgp40_measure_resistance_raw(data, &__ignore);
+	else
+		ret = sgp40_turn_heater_off(data);
+
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t heater_enable_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct sgp40_data *data = iio_priv(dev_to_iio_dev(dev));
+
+	guard(mutex)(&data->lock);
+
+	return sysfs_emit(buf, "%d\n", data->heater_enabled);
+}
+
 static IIO_DEVICE_ATTR_RO(serialnumber, 0);
+static IIO_DEVICE_ATTR_RW(heater_enable, 0);
 
 static struct attribute *sgp40_attributes[] = {
 	&iio_dev_attr_serialnumber.dev_attr.attr,
+	&iio_dev_attr_heater_enable.dev_attr.attr,
 	NULL
 };
 
-- 
2.56.0

