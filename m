Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610904;
	b=XjpRBY675hm9Vwv+1g8UouT3VGJe3Al2Zk9coXuIGzw1KQtCu3zdNnH0TUm5h9y9Lb1a
	 Lyhxw9d6vm7l9VdJChWLSjEp5QcsecCYxvq/QFH2kOINJ2NKoQocOefp08+cfEaHSONZI
	 92TfF0MmUjUPnQsTrwoNCZUy+n1JvlbYF3lIxZteLHrhPPuEeWgtZio2h6oXPZTdbnPZu
	 pvkiGczvX2Mh/WauI3j1oCnc3OfzaIj2Rp08z+k49NuNDiYRLLUQJx1ooUhd8mV+eo7z3
	 aUwFxW77qEhFb7VvC4CiQJIn8gxl5wk1VULZlAjYp1jBLCJH2JcnoI2X+WcnT/ZfIQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610904;
	h=DMARC-Filter:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-FEAS-BEC-Info:X-FEAS-Client-IP:
	 X-FE-Last-Public-Client-IP:X-FE-Policy-ID:X-FE-Hostname:
	 DKIM-Signature;
	bh=kX1eaipy9cUjWOh6p9xTidj8SOjSyvezRzVEkIQAl5g=;
	b=aVqto79xjmsuxmnULWePKO/hAu7v2lSdrw4LUqZwlHm5adblzfi283txDBJCMJ5fPNx7
	 Gkfr4A2lt9gLsEk05lg0bhyTeOVaXk6m8trZSF2txySBZ5NF5EEje52FELJkVScyySODe
	 Sai9Dqv8Ba15Rc4S+uXiQ22IExDEhdN0buzACvnxyWR+qI5W/4TQmrXvWuBoj8wL/w3Hi
	 w0WKjkejwQa8Jrp3VknzUTGCag4NsjNm17eFl4uPDzlvYUhTzwd8IzlnZWc/dG7gTqnzL
	 zqnpSc8imkEvxUGtQR7pFOfPs1jvtCkopLStkgkAOetpGGpV/JdMSPcit1oqE3H2X6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=Y8rItcIu;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673CA606A336;
	Mon,  2 Nov 2026 09:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 673CA606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=Y8rItcIu
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6A29EgWg024523-6A29EgWi024523
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 2 Nov 2026 11:14:42 +0200
Received: from ex19-16.utu.fi ([130.232.247.56])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <jaakko.ma.koivisto@utu.fi>)
	id 1xNo7m-00Gk5y-8A;
	Mon, 02 Nov 2026 11:14:42 +0200
Received: from lorpotin (91.145.105.139) by ex19-16.utu.fi (130.232.247.56)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 11:14:41 +0200
From: Jaakko Koivisto <jmatko@utu.fi>
To: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jaakko
 Koivisto <jmatko@utu.fi>
Subject: [PATCH v2 4/5] iio: chemical: sgp40: Implement execute_self_test-command
Date: Mon, 2 Nov 2026 11:12:57 +0200
Message-ID: <20261102091258.247402-5-jmatko@utu.fi>
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
 bh=kX1eaipy9cUjWOh6p9xTidj8SOjSyvezRzVEkIQAl5g=;
 b=Y8rItcIuMA4J8LbO7lLZI4j9HlsQ08TRhWXznfDBBXGJZZVFW+t2cqgvVJUpoq99jguB+9zYUKB+
	dJnA/fpfHTbAPGeC+JQ1VLGQhmjcPa5baeHZxPFcwrCFV7I9Cj+VupXRvun5nHwPxzzchF0VIsEF
	697nLErADnAuxJI7qdNZ7oKbRY83qZRj4YeflzaJCkHaAj3w2+LV+vP6elKul+y6gf4fTNJTEl4l
	vzOzghzQP8Gc61ZKwQICz1e2m87wXAnQh61i/iBPDPWle7JxBMaA/+U9RikqlMXkuxtZdL9Cg27C
	cA5fLJkvz48nlNiB0PP5rnlqoscveeu7lXbf5w==

Add functionality for running the SGP40 sensor self-test, testing
the heater and MOX-material.

Datasheet does not clearly state if the chip is completely unusable if
the test fails. Because of this the driver will try to use the chip
normally even if the self-test has failed.

If the test fails to run, the driver probe is aborted.

Signed-off-by: Jaakko Koivisto <jmatko@utu.fi>
---
Is it ok to fail the probe if the self-test fails? Currently the driver
will probe succesfully even if the device is powered down, or does
not exist at all, so failing the probe is rather significant change
from current behaviour.

Case where self-test reports FAIL was tested using a MCU
mimicking SGP40 instead of real device, due to problems finding any
failed SPG40s.

 drivers/iio/chemical/sgp40.c | 58 ++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
index e0a300720fce..278390bc6b04 100644
--- a/drivers/iio/chemical/sgp40.c
+++ b/drivers/iio/chemical/sgp40.c
@@ -83,6 +83,19 @@ struct sgp40_serial_number_result {
 	u8	C_crc;
 } __packed;
 
+/*
+ * Datasheet table 13.
+ */
+#define SGP40_SELF_TEST_PASS 0xD4
+#define SGP40_SELF_TEST_FAIL 0x4B
+
+struct sgp40_self_test_result {
+	u8	data;
+	u8	_ignore;
+	u8	crc;
+} __packed;
+
+
 static const struct iio_chan_spec sgp40_channels[] = {
 	{
 		.type = IIO_CONCENTRATION,
@@ -209,6 +222,47 @@ static int sgp40_get_serial_number(struct sgp40_data *data, u64 *serial_number)
 	return 0;
 }
 
+static int sgp40_execute_self_test(struct sgp40_data *data)
+{
+	int ret;
+	struct i2c_client *client = data->client;
+	struct sgp40_tg_measure run_test = { .command = {0x28, 0x0E} };
+	struct sgp40_self_test_result res;
+
+	guard(mutex)(&data->lock);
+
+	ret = i2c_master_send(client, (char *)&run_test, sizeof(run_test.command));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(run_test.command))
+		return dev_err_probe(data->dev, -EIO,
+		       "i2c_master_send ret: %d, expected %zu\n", ret, sizeof(run_test.command));
+
+	msleep(320); /* Max duration for self-test command. Datasheet table 8. */
+
+	ret = i2c_master_recv(client, (char *)&res, sizeof(res));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(res))
+		return dev_err_probe(data->dev, -EIO,
+		       "i2c_master_recv ret: %d, expected: %zu\n", ret, sizeof(res));
+
+	if (crc8(sgp40_crc8_table, (u8 *)&res, 2, SGP40_CRC8_INIT) != res.crc)
+		return dev_err_probe(data->dev, -EIO, "CRC error in execute_self_test\n");
+
+	dev_dbg(data->dev, "self test result: 0x%x\n", res.data);
+	switch (res.data) {
+	case SGP40_SELF_TEST_PASS:
+		return 0;
+	case SGP40_SELF_TEST_FAIL:
+		dev_warn(data->dev, "Device self-test failed, check data validity\n");
+		return 0;
+	default:
+		dev_err(data->dev, "Invalid self-test response from device\n");
+		return -EIO;
+	}
+}
+
 static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *resistance_raw)
 {
 	int ret;
@@ -418,6 +472,10 @@ static int sgp40_probe(struct i2c_client *client)
 	indio_dev->channels = sgp40_channels;
 	indio_dev->num_channels = ARRAY_SIZE(sgp40_channels);
 
+	ret = sgp40_execute_self_test(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to run device self-test\n");
+
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
 		dev_err(dev, "failed to register iio device\n");
-- 
2.56.0

