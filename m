Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3012A4F85DE;
	Fri, 18 Sep 2026 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738888; cv=none; b=OlAsEztJIkhqI/joJAzM3Pvgk+VjWYeLMHXLMqgrB0tUoZT1Z9XmU7aMmZDY8er2JgeBEgr4Vude6MmtHmYIBpGYdgHpQmci0makSOroQx6L/fAPOV2lMjyS0GBRqHcxh4LBKwXB6GAA7YWyYDf5Rf8Wq/i5McJQ9zwaEOrO4ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738888; c=relaxed/simple;
	bh=kkdoe7sTV6FZQcGXL7P3EQs908f175NF3RWzIpamD4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GtBE4nGpnv11fy8wq1Cm0siLOYBWxb046HbKk60GhajOjJ66jE9AfOy1PMNySCCHs0H7y/C1zfc8FpJ3vJlGXloq4moftHHPUg4Euh0hOVRJR9o+/HJiteBJkrBAU6Awy4YzPt22izJwAuOerBpNFBqsDTQbIr/cMd9KQ+3QeQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=dMuW77DN; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="dMuW77DN"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 68IDf4ek029517-68IDf4em029517
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 18 Sep 2026 16:41:04 +0300
Received: from ex19-16.utu.fi ([130.232.247.56])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <jaakko.ma.koivisto@utu.fi>)
	id 1x7Ypr-007PQp-Tt;
	Fri, 18 Sep 2026 16:41:03 +0300
Received: from lorpotin (91.145.105.139) by ex19-16.utu.fi (130.232.247.56)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 16:41:03 +0300
From: Jaakko Koivisto <jmatko@utu.fi>
To: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jaakko
 Koivisto <jmatko@utu.fi>
Subject: [PATCH 1/3] iio: chemical: sgp40: Implement get_serial_number-command
Date: Fri, 18 Sep 2026 16:40:17 +0300
Message-ID: <20260918134019.1101308-2-jmatko@utu.fi>
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
 HEUDBAEGDw0aRgwNSFhIWkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEhdSFhIWEhYSFleSAkDKAEcRQMEAQYPDRpGDA1IWEhZXUgJBgwRKAMNGgYNBEYHGg9IWEhaWUgM
 BA0LAAYNGigKCREEAQoaDUYLBwVIWEhaXUgEAQYdEEUBAQcoHg8NGkYDDRoGDQRGBxoPSFhIWVBIBh0GB0YbCSgJBgkEBw9GCwcFSFg=
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=FWHLj1ESnVWitIfn9IvPlEG74Udso9jFOrjE+1hMxZE=;
 b=dMuW77DNxODWfgNtCkmdd9aVa1LiJ7S6wxkYsqWptkgOHcZTKtZH6NCfB5eiFIfMHwYokIrjQyPv
	k7MrWPQh9cKqGlaj+PuH3JUVaOE4isFy4thIXr5Me1zKClSJlIvqL4QR2OJw9UOA5GXtzv5LbX76
	NKA2nm9TKHXa45zdIqCpWmDoNeYZv3Fk0DXjbSiloKkcPo0XfqYNkybwYiCSKDp07a0GWY5AJ8R+
	p8rcmBg/ae/sqKgYgZsfV8hAQxX65ut12UKXAB6IgqriwSz7mm6kzuHPoAKc7Ds88v13oUdFitCr
	K2OwSzlDqNcXTx4PqtO7fQ/pz47y8SKGSjlwxA==

-Retrieve the chip serial number.
-Present the serial number to userspace as device attribute.
-Rename the tg_measure -struct now that is is used for multiple
commands.

Signed-off-by: Jaakko Koivisto <jmatko@utu.fi>
---
 drivers/iio/chemical/sgp40.c | 78 +++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
index b2b5e32a9eb2..c1e2a992ec2a 100644
--- a/drivers/iio/chemical/sgp40.c
+++ b/drivers/iio/chemical/sgp40.c
@@ -35,6 +35,7 @@
 #include <linux/mutex.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 /*
  * floating point calculation of voc is done as integer
@@ -53,11 +54,12 @@ struct sgp40_data {
 	int			rht;
 	int			temp;
 	int			res_calibbias;
+	u64			serial_number;
 	/* Prevent concurrent access to rht, tmp, calibbias */
 	struct mutex		lock;
 };
 
-struct sgp40_tg_measure {
+struct sgp40_command {
 	u8	command[2];
 	__be16	rht_ticks;
 	u8	rht_crc;
@@ -70,6 +72,18 @@ struct sgp40_tg_result {
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
@@ -162,6 +176,40 @@ static int sgp40_calc_voc(struct sgp40_data *data, u16 resistance_raw, int *voc)
 	return 0;
 }
 
+static int sgp40_get_serial_number(struct sgp40_data *data)
+{
+	int ret;
+	struct i2c_client *client = data->client;
+	struct sgp40_command get_sn = {.command = {0x36, 0x82}};
+	struct sgp40_serial_number_result res;
+
+	ret = i2c_master_send(client, (char*)&get_sn, sizeof(get_sn.command));
+	if (ret != sizeof(get_sn.command)) {
+		dev_err(data->dev, "i2c_master_send ret: %d, expected %zu", ret, sizeof(get_sn.command));
+		return -EIO;
+	}
+	msleep(1);
+	ret = i2c_master_recv(client, (char*)&res, sizeof(res));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(res)) {
+		dev_err(data->dev, "i2c_master_recv ret: %d, expected: %zu", ret, sizeof(res));
+		return -EIO;
+	}
+
+	if (crc8(sgp40_crc8_table, (u8*)&res.A, 2, SGP40_CRC8_INIT) != res.A_crc ||
+	    crc8(sgp40_crc8_table, (u8*)&res.B, 2, SGP40_CRC8_INIT) != res.B_crc ||
+	    crc8(sgp40_crc8_table, (u8*)&res.C, 2, SGP40_CRC8_INIT) != res.C_crc)
+	{
+		dev_warn(data->dev, "CRC error in get_serial_number");
+	}
+
+	data->serial_number = 0LL | ((u64)be16_to_cpu(res.A) << 32) | ((u64)be16_to_cpu(res.B) << 16) | (u64)be16_to_cpu(res.C);
+	dev_dbg(data->dev, "serial number: %llu", data->serial_number);
+
+	return 0;
+}
+
 static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *resistance_raw)
 {
 	int ret;
@@ -169,7 +217,7 @@ static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *resistance
 	u32 ticks;
 	u16 ticks16;
 	u8 crc;
-	struct sgp40_tg_measure tg = {.command = {0x26, 0x0F}};
+	struct sgp40_command tg = {.command = {0x26, 0x0F}};
 	struct sgp40_tg_result tgres;
 
 	mutex_lock(&data->lock);
@@ -311,9 +359,31 @@ static int sgp40_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static ssize_t serial_number_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct sgp40_data *data = iio_priv(dev_to_iio_dev(dev));
+
+	return sysfs_emit_at(buf, 0, "%llu\n", data->serial_number);
+}
+
+static IIO_DEVICE_ATTR_RO(serial_number, 0);
+
+static struct attribute *sgp40_attributes[] = {
+	&iio_dev_attr_serial_number.dev_attr.attr,
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
@@ -347,6 +417,10 @@ static int sgp40_probe(struct i2c_client *client)
 	indio_dev->channels = sgp40_channels;
 	indio_dev->num_channels = ARRAY_SIZE(sgp40_channels);
 
+	ret = sgp40_get_serial_number(data);
+	if (ret)
+		dev_warn(dev, "failed to retrieve device serial number\n");
+
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
 		dev_err(dev, "failed to register iio device\n");
-- 
2.55.0

