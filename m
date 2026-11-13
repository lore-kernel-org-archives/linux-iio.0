Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558352;
	b=Odi3bp+O8IZ35/PI6Ih+raEXq7YDArjYaS4BUwWHxfEedpuIckbT9A4EeXAbSRfySOa4
	 CUMkDArlgDaCMzuCjJDx0QpOPocaA6jLlcKEaNNmgsH8dQRG2R7/sc2m70I4wO1Bq4f66
	 p+kBKdMGSfxYSg6CxYjuJEJEYM5DTnpJ3kY+WqZJgrrZl/GPKiERPCLLbX5aJjkIQFGb1
	 hssfh5dLzf2W90c6G9XStqwBUx+W2oOKDq7Mkyh4rGzrNq9Mr5Xozr7FttWoZ61reKbUe
	 8yIml042z3ge4fFkffiofSXhKyIV3XcAXsZMbhNX2jM7UC3ENZxAGiR+V1lPVGnZwJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558352;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fOyA+/mIxQw8aulmJJ6drlntxz+JUhzM5Zq2n9iEbYU=;
	b=LGnTr2M3VLOOibdOKRt/JoyDh6uoA4NtsyYGENsCeRWr+elG9BPfrGZQQLcvGL+07U+7
	 ciVezRBJsRIpMsYVuTabmybI9r8mjAdrBF6WZmfQLgT0+HPugUvD98NqSHXxmkaEQCiUf
	 l94UZ8SwH9SNAyKFmnv7otYXf36EiXCH+IBblkaTqENA32C2k7QR5VT+USsqnhMqapHmO
	 KmUDRgJk/ipkmxR7YUelTRuERJD45CG5cK7fpTLjF7RF3F1xR1E/aoCdBDEOs9JK+K6ZH
	 fzusxqZocpw/FMLN6h/hTLwi/MXYexbl7dIovsREImd6H11P+Pw8o7glc+M37ZHTajg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=b8os27o2;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259DD606A31C;
	Fri, 13 Nov 2026 08:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 259DD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=b8os27o2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=b8os27o2WF93BP5j5fLBwLzoEpXglGJ2tTkraxcy0bwjYBjbqf2vJTcaIdlZqp8HPlL9l5rrEjkU1
	 TDoOLxsn0ieiAEzRGtI9/aDJEbOMpX4/UUVkRZKirKjgyerUEGGMzfQSqz0DvoKBnrayj7gFDZ0yHQ
	 BCbOByYrQHpRnFn4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86af6c98beda-8a1a3;
	Fri, 13 Nov 2026 16:25:48 +0800 (CST)
X-RM-TRANSID:2ee86af6c98beda-8a1a3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66af6c988111-1e8d6;
	Fri, 13 Nov 2026 16:25:48 +0800 (CST)
X-RM-TRANSID:2ee66af6c988111-1e8d6
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH v3] iio: potentiostat: lmp91000: Handle configuration write errors
Date: Fri, 13 Nov 2026 16:25:46 +0800
Message-ID: <20261113082546.176582-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
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

lmp91000_read_config() ignores errors when unlocking and programming
the TIA and reference registers. Probe can then succeed even though
the hardware configuration does not match the parameters used to
interpret measurements.

Check the configuration writes and return the first error. After a
successful unlock, attempt to restore write protection even if a
configuration write fails. Return a relock error when both configuration
writes succeeded.

lmp91000_probe() returns either error before registering the IIO device,
so the caller does not need to distinguish their source. Preserve the
configuration error if restoring write protection also fails.

Fixes: 67e17300dc1d ("iio: potentiostat: add LMP91000 support")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
Changes in v3:
- Declare the loop counter separately from the return code (Andy Shevchenko).
- Explain how probe handles configuration and relock failures.

Changes in v2:
- Use an explicit error path to restore write protection and return the
  original configuration error, as suggested by Jonathan Cameron.
- Return the final lock write result directly on the successful path.

 drivers/iio/potentiostat/lmp91000.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index 00cb3fea97ca..1e07917ff76a 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -205,7 +205,8 @@ static int lmp91000_read_config(struct lmp91000_data *data)
 {
 	struct device *dev = data->dev;
 	unsigned int reg, val;
-	int i, ret;
+	int ret;
+	int i;
 
 	ret = device_property_read_u32(dev, "ti,tia-gain-ohm", &val);
 	if (ret) {
@@ -250,13 +251,25 @@ static int lmp91000_read_config(struct lmp91000_data *data)
 		return ret;
 	}
 
-	regmap_write(data->regmap, LMP91000_REG_LOCK, 0);
-	regmap_write(data->regmap, LMP91000_REG_TIACN, reg);
-	regmap_write(data->regmap, LMP91000_REG_REFCN,
-		     LMP91000_REG_REFCN_EXT_REF | LMP91000_REG_REFCN_50_ZERO);
+	ret = regmap_write(data->regmap, LMP91000_REG_LOCK, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, LMP91000_REG_TIACN, reg);
+	if (ret)
+		goto relock;
+
+	ret = regmap_write(data->regmap, LMP91000_REG_REFCN,
+			   LMP91000_REG_REFCN_EXT_REF | LMP91000_REG_REFCN_50_ZERO);
+	if (ret)
+		goto relock;
+
+	return regmap_write(data->regmap, LMP91000_REG_LOCK, 1);
+
+relock:
 	regmap_write(data->regmap, LMP91000_REG_LOCK, 1);
 
-	return 0;
+	return ret;
 }
 
 static int lmp91000_buffer_cb(const void *val, void *private)
-- 
2.51.0



