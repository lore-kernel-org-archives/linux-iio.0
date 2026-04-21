Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE45246BC0
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 01:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776735714; cv=none; b=bdgixD+mkaYOCsoi9GlIWtDepN/j9V1zeYd2PXuN00KmHh1ToAWNIbnJt1s/tE2CZ8XUaZTmrTme8oU45zme4M/oZu5OAVJIwGhKheGiulNPnHjwOzhFUDZmyIYUDFMZx/EVPvITH5mFVHyGs2cdu5lDuk4vfqiGWjDFPG/kHpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776735714; c=relaxed/simple;
	bh=c6q9oQkbovfdRANQ03O3aL99Sm5ehXOdqaDo9UPMz/U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=evVhBYJwFIep6A917LOG2wQvAbIJPd0VruMQr/2bY4tPzk+q+64vW+23k6+NFYa/zImcVwZtDCi30sDjQoBChxFCEgjYF8KJgHbCRiqXJ3xFvBru96WThIKmGrx1Rk1vSgObuOHkTV3F0zAVCR0z4AjWPeU7JVzlWKZKMa+6H8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=j6Elo5wC; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="j6Elo5wC"
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1776735700;
	bh=hgJYTfLM6ixBP8ZTg+ugrd/LAtv9wxJUHiWP3SanoKU=; l=1778;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=j6Elo5wCSIM8z5gvJTMXoe996oIs3z/w503GY8zefCWw/Zt5nbfRXTLYK9UaaIvSK
	 VS710a/FL4qchlmHvDmxOQEiXQs3RnesHF9Qz6kzUSopl/pA36coaz8hYIB4SG8xZ+
	 ZmeRNGG1b7Oco6THvytvKgvKHqYAXZVvNpvGTRyVeXHNGhcCIrj9zd8C4/ygOk/g0s
	 zr8ptz7a+xB+j4bhOUwLn2i9TAUaLAODywPOKkbIyPaojGazTYPBip+ZM4rwUcZP3T
	 6e0gZaZyv0d0Mbhdy2mYEyikg4b++C+BdlTr9rkuaKqsk+PM/CODaFhsMrQhPl2jVP
	 umBeI+OBiBI+A==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(1227023:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 21 Apr 2026 09:41:22 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Tue, 21 Apr
 2026 09:41:21 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1748.26 via Frontend
 Transport; Tue, 21 Apr 2026 09:41:21 +0800
From: <cy_huang@richtek.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Kevin Tung
	<kevin.tung.openbmc@gmail.com>, ChiYuan Huang <cy_huang@richtek.com>, "Lucas
 Tsai" <lucas_tsai@richtek.com>, <kevin.tung@quantatw.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH] iio: adc: rtq6056: Fix the manual device instantiation via sysfs
Date: Tue, 21 Apr 2026 09:41:17 +0800
Message-ID: <db4f5ded64ca7d2e56abfa30c6a174342c44fabb.1776735120.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Kevin Tung <kevin.tung.openbmc@gmail.com>

Add i2c_device_id to support sysfs manual device instantiation.

Fixes: 89a1034cd841 ("iio: adc: rtq6056: Add support for the whole RTQ6056 family")
Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Cc: <stable@vger.kernel.org>
---
Hi, Jonathan:

For some BSP limit, still some user instantiate rtq6056 deivce via sysfs.
Therefore, add old style i2c id to make it compatible for this kind of usage.

BR,
ChiYuan.
---
 drivers/iio/adc/rtq6056.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
index 2bf3a09ac6b0..e7036dc7d7b9 100644
--- a/drivers/iio/adc/rtq6056.c
+++ b/drivers/iio/adc/rtq6056.c
@@ -728,7 +728,7 @@ static int rtq6056_probe(struct i2c_client *i2c)
 	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_WORD_DATA))
 		return -EOPNOTSUPP;
 
-	devdata = device_get_match_data(dev);
+	devdata = i2c_get_match_data(i2c);
 	if (!devdata)
 		return dev_err_probe(dev, -EINVAL, "Invalid dev data\n");
 
@@ -878,6 +878,13 @@ static const struct of_device_id rtq6056_device_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rtq6056_device_match);
 
+static const struct i2c_device_id rtq6056_id[] = {
+	{ "rtq6056", (kernel_ulong_t)&rtq6056_devdata },
+	{ "rtq6059", (kernel_ulong_t)&rtq6059_devdata },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, rtq6056_id);
+
 static struct i2c_driver rtq6056_driver = {
 	.driver = {
 		.name = "rtq6056",
@@ -885,6 +892,7 @@ static struct i2c_driver rtq6056_driver = {
 		.pm = pm_ptr(&rtq6056_pm_ops),
 	},
 	.probe = rtq6056_probe,
+	.id_table = rtq6056_id,
 };
 module_i2c_driver(rtq6056_driver);
 
-- 
2.34.1

