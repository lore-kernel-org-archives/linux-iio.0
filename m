Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610956;
	b=RPSP/arhTiHz92yHxoomewIyP/kGu2OAwaDkuTA0kwGIBR4sumomyUc09my2TUcCPUfd
	 sp+0BlmNUS4YX9UpUafjzOgVw1SWbf1pMAlTdtUuk8Bcye6wjeiyAfX12y9Sa9+FbbGo/
	 IOPGoyRUdHR6yePt7VjWvklk+1DegBKP1/tBb2a0QVa82/ibQeFDONWMlchf3wWF005/h
	 SzGmKbI8esLZV9Wx/bjR1AUI9cWISET80MWqmqRLqJmH8TUc1JpLXkwuSw01ZwEgSDwJp
	 UTeFsZuK3B2xuoqYu9HvCRxhueinZwQ7Dk69hpILn6dw8nRLqL7jl5CWhA6/PK0HigA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610956;
	h=DMARC-Filter:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=O3jVSvvryYZl7OF3FZBbst06ttsT1TkPtiH56l6h7gM=;
	b=mDtC9Us3ZbxbZhBslIfNdpdd2X5FkVYSJ3o7dW2sS8roUb5XeMSmLeCJ7WL5S9YauQGs
	 cqf1N4qBNPZC/5QizSGxiXZqu76kh0MtWY1V0I/+auosS+RRXa5CFl/ggtNd3fYFMHpCA
	 k+4bcBwz52VfKMMUAIqUzcCgHpJjXXjbE9jQD9VgVSBp82rEMsqA7j0Xei2rVaSSlUEy1
	 lSyH+7BgUOEZxHK7IRZyZ2WoLS6z+BKYCSN8euJ9eiKoY5+zqkZf7J165jESZzxjbHG/B
	 9IW9KdZ3vQy5HcUrRthkz/ZN5CgI/KlcqLru0+uSMGrvBQsbQLrJj1hzlr7DUhLOVTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=hwjlcLJG;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E19B606A326;
	Mon,  2 Nov 2026 09:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E19B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=hwjlcLJG
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6A29FXwl025270-6A29FXwn025270
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 2 Nov 2026 11:15:33 +0200
Received: from ex19-16.utu.fi ([130.232.247.56])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <jaakko.ma.koivisto@utu.fi>)
	id 1xNo8b-00GkDl-JU;
	Mon, 02 Nov 2026 11:15:33 +0200
Received: from lorpotin (91.145.105.139) by ex19-16.utu.fi (130.232.247.56)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 11:15:33 +0200
From: Jaakko Koivisto <jmatko@utu.fi>
To: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jaakko
 Koivisto <jmatko@utu.fi>
Subject: [PATCH v2 5/5] iio: chemical: sgp40: Implement turn_heater_off-command
Date: Mon, 2 Nov 2026 11:15:09 +0200
Message-ID: <20261102091509.252337-1-jmatko@utu.fi>
X-Mailer: git-send-email 2.56.0
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
X-ClientProxiedBy: ex19-05.utu.fi (130.232.247.45) To ex19-16.utu.fi
 (130.232.247.56)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFpdSAIJCQMDB0YFCUYDBwEeARscBygdHB1GDgFIWUhZXkgJAygB
 HEUDBAEGDw0aRgwNSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhdSFhIWEhYSFleSAkDKAEcRQMEAQYPDRpGDA1IWEhZXUgJBgwRKAMNGgYNBEYHGg9IWEhaWUgM
 BA0LAAYNGigKCREEAQoaDUYLBwVIWEhaXUgEAQYdEEUBAQcoHg8NGkYDDRoGDQRGBxoPSFhIWVBIBh0GB0YbCSgJBgkEBw9GCwcFSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:mime-version:content-type;
 bh=O3jVSvvryYZl7OF3FZBbst06ttsT1TkPtiH56l6h7gM=;
 b=hwjlcLJGmmimqwJdujiWcM+UFFFGSU6RZ4D9R978MbMgpuR/IFnJFhV9aDzkaSvvTZsAfXZOr3V4
	pNQhvrCvN9F4Pr/teq1eSdEKLHTf7enSNbrEl8/eaTau4S0a8P57953ZC1QCPEoZcmCxwvszJqnf
	BXvsqbh+mjT+iE2wFm/g3d1fse56Sq7s+1VdsFSXX4OwUP0vzg6tqGBxX3e98s19sSvtgfx+FGyX
	lswR3k4qDzvoFo/nRHyftNptCwZj38baZgYOP48tLBiFaEB/4cxRC9DmnTPpV2hcen6ffw6HnoWD
	exehqyfIlKghSsPungFIl6u7z34rmn7axw0efw==

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

