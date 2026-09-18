Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790FD4F93D3;
	Fri, 18 Sep 2026 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738890; cv=none; b=bpAqBSJww3hST+Emlba/oduFUrm99sbCKY86NEUKWO2N/VN/CR79DDUjKh84fnLTxsyGwiO3QoOsgqDodlSd5TB56JkZOdRxNr3keyhQmsKj77Tk3fD4UDvXM0GiJ9eHrhmDi5XiwIFCogyaaRcSDc24FKKq7+LiFnz8l/pnejs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738890; c=relaxed/simple;
	bh=dHZ/Tw7M9UbkFh0Sk8HaCIlpNFpoaRVGh4oDkARZANM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AvKMj5AA/u0kxiKSXczicXngCGYWY1inp499FH1i1Vpp81UuTGfH6UlrKRjPyOd3Ob5bqxxTS8rpKoEIKH9+RGNpEHkBSUOifkN6PUx+j1pCutrDiAha25RAcOcJ/StP5FMNXBpA25xI/arNpkmS9IjEbYZYQPjl+UVNM8liI50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=PS5hI52E; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="PS5hI52E"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 68IDf5ft029532-68IDf5fv029532
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 18 Sep 2026 16:41:05 +0300
Received: from ex19-16.utu.fi ([130.232.247.56])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <jaakko.ma.koivisto@utu.fi>)
	id 1x7Ypt-007NmQ-P0;
	Fri, 18 Sep 2026 16:41:05 +0300
Received: from lorpotin (91.145.105.139) by ex19-16.utu.fi (130.232.247.56)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 16:41:05 +0300
From: Jaakko Koivisto <jmatko@utu.fi>
To: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jaakko
 Koivisto <jmatko@utu.fi>
Subject: [PATCH 2/3] iio: chemical: sgp40: Implement execute_self_test-command
Date: Fri, 18 Sep 2026 16:40:18 +0300
Message-ID: <20260918134019.1101308-3-jmatko@utu.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918134019.1101308-1-jmatko@utu.fi>
References: <20260918134019.1101308-1-jmatko@utu.fi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-16.utu.fi (130.232.247.56) To ex19-16.utu.fi
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
 bh=lrcXUwjAaGobVd8SMjEjxNeeU1H6wOM4S4lV4AvdR1I=;
 b=PS5hI52EzM4x0yxEPFptBHTzaDjnqbelEOsEQM9zAkaGXiUhn9NPTOKDcFy46+r5uOfF3MUr12hn
	iqdd6aNPIPktfUyC57MFwqW6maz/brSND8MQsY0HQ2dxwv270nqy7F1IV645PT/m2tndZ7r4oOdH
	ONDNd9UJSdtuue4ca4R4xRHXmKD21+zyz0bGeKNKRv7Jy33MFZBgWn0+bllQjYE5hqif1H+3NFCS
	pNGGOG5FcaSxoRpwJ4MxYzujar3F2V7ukDIvgCvfejKpjileWQmnTtZPoSJ5pJG06vOuoJNMFeLW
	Rc/4n1cwssRoWqscd8GNPmenc6ha+CaXE71IOg==

-Run the chip self test routine testing heater and MOX -material.
-Log error if the test fails.

Datasheet does not clearly state if the chip is completely unusable if
the test fails. Because of this the driver will try to use the chip
normally even if the self-test has failed.

Signed-off-by: Jaakko Koivisto <jmatko@utu.fi>
---
 drivers/iio/chemical/sgp40.c | 53 ++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
index c1e2a992ec2a..28d5e737d1dc 100644
--- a/drivers/iio/chemical/sgp40.c
+++ b/drivers/iio/chemical/sgp40.c
@@ -84,6 +84,19 @@ struct sgp40_serial_number_result {
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
@@ -210,6 +223,42 @@ static int sgp40_get_serial_number(struct sgp40_data *data)
 	return 0;
 }
 
+static int sgp40_execute_self_test(struct sgp40_data *data)
+{
+	int ret;
+	struct i2c_client *client = data->client;
+	struct sgp40_command run_test = {.command = {0x28, 0x0E}};
+	struct sgp40_self_test_result res;
+
+	ret = i2c_master_send(client, (char*)&run_test, sizeof(run_test.command));
+	if (ret != sizeof(run_test.command)) {
+		dev_err(data->dev, "i2c_master_send ret: %d, expected %zu", ret, sizeof(run_test.command));
+		return -EIO;
+	}
+	msleep(320);
+
+	ret = i2c_master_recv(client, (char*)&res, sizeof(res));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(res)) {
+		dev_err(data->dev, "i2c_master_recv ret: %d, expected: %zu", ret, sizeof(res));
+		return -EIO;
+	}
+
+	if (crc8(sgp40_crc8_table, (u8*)&res, 2, SGP40_CRC8_INIT) != res.crc) {
+		dev_warn(data->dev, "CRC error in execute_self_test");
+	}
+
+	dev_dbg(data->dev, "self test result: 0x%x", res.data);
+	switch (res.data) {
+		case SGP40_SELF_TEST_PASS:
+			return 0;
+		case SGP40_SELF_TEST_FAIL:
+		default:
+			return res.data;
+	}
+}
+
 static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *resistance_raw)
 {
 	int ret;
@@ -421,6 +470,10 @@ static int sgp40_probe(struct i2c_client *client)
 	if (ret)
 		dev_warn(dev, "failed to retrieve device serial number\n");
 
+	ret = sgp40_execute_self_test(data);
+	if (ret)
+		dev_warn(dev, "device self test failed: ret 0x%x", ret);
+
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
 		dev_err(dev, "failed to register iio device\n");
-- 
2.55.0

