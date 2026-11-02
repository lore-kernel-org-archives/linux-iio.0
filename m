Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610905;
	b=EFzSkJxdUTg2wx1gK96chY/W0Gl+ilbnvZ6BLk4U9QTtNRIK/vR16z8qDYMqujs2wthP
	 13QMfLKVO80/1iLNJ20MnDWgWaBaVqLlyWXZq+nhwrPXeVg7nuwafnzn/8dj9laRGKs2N
	 xTkVEsCkFUpOfJdRqYV+kx8ybcOVdPTIDr1ikjq/dBbeSMOXItIyFwjtfn44PQWNF4rRR
	 iZrhI2pcnwnCD1JcbWDVcTGq1GveE4tLbl0aXzu8Ai9Z4AI4LBjo8jedLk40+AwFbJ/dR
	 8klvh3mYHXeqDY0oeRRHeb3wOPzAFv4oJMeDqP76PjiaepaOIqN2eoF7ugsUEJuhJcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610905;
	h=DMARC-Filter:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-FEAS-BEC-Info:X-FEAS-Client-IP:
	 X-FE-Last-Public-Client-IP:X-FE-Policy-ID:X-FE-Hostname:
	 DKIM-Signature;
	bh=A69/kg5LLhw/n57+9+c2EFtAoRS1SzBUAOSLPwxbfQ4=;
	b=2fPb+leITgNM0/vLLQEI+/fjJA3ajgwvOptcxd0l+SabaCCkcsx6nrEZII2cuHEzC/p7
	 loVoYlUZslN1cVhUsPS9iSdowRLKYCJ5d0XhA6zYUL3LmMNdRwDg2fFkkLjsf07A1Z3iY
	 isWkQ6QelMqcMb94bHuJeBiKImOF355RtDiJVcOpHxzdqEpVj5zkEyQk8dinwST+oQ5xl
	 oZZhQtWzSznBBc7e4kzZ0ocgRZqnM90szFlxY0pXqSwzyFz/UXfVz7Np5CkY9Chsd+EUm
	 R0nhmw9wl4wNUlkEik44ObdXYkwJVsqZaY2yjGbZv1TUWBEEOCzZ+IRwNWdPSPs1ubA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=VP78Ksrf;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55540606A33C;
	Mon,  2 Nov 2026 09:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55540606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=VP78Ksrf
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6A29Efis024507-6A29Efiu024507
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 2 Nov 2026 11:14:41 +0200
Received: from ex19-16.utu.fi ([130.232.247.56])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <jaakko.ma.koivisto@utu.fi>)
	id 1xNo7k-00Gk5v-Sv;
	Mon, 02 Nov 2026 11:14:40 +0200
Received: from lorpotin (91.145.105.139) by ex19-16.utu.fi (130.232.247.56)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 11:14:40 +0200
From: Jaakko Koivisto <jmatko@utu.fi>
To: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jaakko
 Koivisto <jmatko@utu.fi>
Subject: [PATCH v2 3/5] iio: chemical: sgp40: Implement get_serial_number-command
Date: Mon, 2 Nov 2026 11:12:56 +0200
Message-ID: <20261102091258.247402-4-jmatko@utu.fi>
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
 bh=A69/kg5LLhw/n57+9+c2EFtAoRS1SzBUAOSLPwxbfQ4=;
 b=VP78KsrfDsIrvU+ivYMD+mn838Ty7KYb3HVpOeG0RavkNj6szOrQTV8qbmGkq/Nrzyk/3c5vfhkd
	7dJhVM8kULpgOTk2mKE/d+0bJbZtoBEK4LtxjQK/wvo1s71IkTqnfFfZAvK5VWnMjvZZVK/QJyW/
	hVQVT7TRjLNJke6IcQrNKlyv/292XRIu4GecggwjQwY87u0zOMEHYQDQxVW3qU1Pcv0UvFSq2YKU
	ayNMoam4162iZTbsEmgYofCoT5Kh/TXBYf0GYIPjc7bC4uLgp1oud2tyFiNNbpJH2KluKv82DbSS
	NK+PXW0N8Lf3h92WHi0UTO6xkFBm1PmE2mnsWA==

Add functionality for retrieving SGP40 sensor serial number
and present it to the userspace using serialnumber ABI.

Signed-off-by: Jaakko Koivisto <jmatko@utu.fi>
---
Currently only the bno055 driver uses the serialnumber ABI, and presents
the SN in hex. Documentation gives hex output as example format, not hard
requirement, but should we use the same format here anyway?

 drivers/iio/chemical/sgp40.c | 76 ++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
index 080d51f9f53c..e0a300720fce 100644
--- a/drivers/iio/chemical/sgp40.c
+++ b/drivers/iio/chemical/sgp40.c
@@ -35,6 +35,7 @@
 #include <linux/mutex.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 /*
  * floating point calculation of voc is done as integer
@@ -70,6 +71,18 @@ struct sgp40_tg_result {
 	u8	res_crc;
 } __packed;
 
+/*
+ * Datasheet table 16. Serial number is given as 48-bit value 0xAAAABBBBCCCC.
+ */
+struct sgp40_serial_number_result {
+	__be16	A;
+	u8	A_crc;
+	__be16	B;
+	u8	B_crc;
+	__be16	C;
+	u8	C_crc;
+} __packed;
+
 static const struct iio_chan_spec sgp40_channels[] = {
 	{
 		.type = IIO_CONCENTRATION,
@@ -161,6 +174,41 @@ static int sgp40_calc_voc(struct sgp40_data *data, u16 resistance_raw, int *voc)
 	return 0;
 }
 
+static int sgp40_get_serial_number(struct sgp40_data *data, u64 *serial_number)
+{
+	int ret;
+	struct i2c_client *client = data->client;
+	struct sgp40_tg_measure get_sn = { .command = {0x36, 0x82} };
+	struct sgp40_serial_number_result res;
+
+	guard(mutex)(&data->lock);
+
+	ret = i2c_master_send(client, (char *)&get_sn, sizeof(get_sn.command));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(get_sn.command))
+		return dev_err_probe(data->dev, -EIO,
+		       "i2c_master_send ret: %d, expected %zu\n", ret, sizeof(get_sn.command));
+
+	fsleep(1000); /* Max duration for get_serial_number command. Datasheet table 8. */
+
+	ret = i2c_master_recv(client, (char *)&res, sizeof(res));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(res))
+		return dev_err_probe(data->dev, -EIO,
+		       "i2c_master_recv ret: %d, expected: %zu\n", ret, sizeof(res));
+
+	if (crc8(sgp40_crc8_table, (u8 *)&res.A, 2, SGP40_CRC8_INIT) != res.A_crc ||
+	    crc8(sgp40_crc8_table, (u8 *)&res.B, 2, SGP40_CRC8_INIT) != res.B_crc ||
+	    crc8(sgp40_crc8_table, (u8 *)&res.C, 2, SGP40_CRC8_INIT) != res.C_crc)
+		return dev_err_probe(data->dev, -EIO, "CRC error in get_serial_number\n");
+
+	*serial_number = ((u64)be16_to_cpu(res.A) << 32) | ((u64)be16_to_cpu(res.B) << 16) | (u64)be16_to_cpu(res.C);
+
+	return 0;
+}
+
 static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *resistance_raw)
 {
 	int ret;
@@ -306,9 +354,37 @@ static int sgp40_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static ssize_t serialnumber_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	int ret;
+	u64 serial_number;
+	struct sgp40_data *data = iio_priv(dev_to_iio_dev(dev));
+
+	ret = sgp40_get_serial_number(data, &serial_number);
+	if (ret < 0)
+		return ret;
+
+	return sysfs_emit_at(buf, 0, "%llu\n", serial_number);
+}
+
+static IIO_DEVICE_ATTR_RO(serialnumber, 0);
+
+static struct attribute *sgp40_attributes[] = {
+	&iio_dev_attr_serialnumber.dev_attr.attr,
+	NULL
+};
+
+static struct attribute_group sgp40_attribute_group = {
+	.attrs = sgp40_attributes,
+};
+
+
 static const struct iio_info sgp40_info = {
 	.read_raw	= sgp40_read_raw,
 	.write_raw	= sgp40_write_raw,
+	.attrs		= &sgp40_attribute_group,
 };
 
 static int sgp40_probe(struct i2c_client *client)
-- 
2.56.0

