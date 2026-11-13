Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794557665;
	b=K03c+YargJ9LklfBfFJ+989r4fIfy5X2ufERVy4w7CxDOhJ/BiWbQHyHX5PRywiU5Q0J
	 vsTRNww9nWASrX68hTbLklqFc2/srFPS6K1HxcDjoAMVjzVsMswH8CdaVe/F1/DX5Q9cq
	 eWIZGnamnTqIND6ePBJc3mOU4T50bL3gLH3uqtycqcgVd3E9ZVDwUSWkVBd220GIVLrK7
	 wLolYgFeocQySyDO4zs+ZA1KdkWcN81XXyeIUb0JaS3dur0be2ab/dKyz0haStlhg2u5q
	 wNmjWZotusEM14WvIhTkqbz/EU/449TG7VWvWnlSzIS2AxjLglIklg2bOUZOQm/FfFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794557665;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CxtPvmxPe3FOrfH9AJ+tglCFjPaN+UcOU2rslDDRLy0=;
	b=gl25poWZY2azw4qS3DeHWNXVgVTWxJbQQLG4/4HzEdJdRw2PyzRTG8Rgp8CUGtZTcj14
	 8dUkjupvizIhh8ufYhxzYkGTbsTyZaUgFbwhgPzvkDwfILv6xVnfAKrxDr1ee1T4cLGic
	 hmqpOkkhz0v/pNY6i7cLHCkb2HymHlj5bjIx8UuYFzS47Q+CG5CYBy7d9JPLCBEVk8KFX
	 DJFLRnANpRla8Anjhpuzy1+mawhmZWaRfMNreRcNYkVe7Aruk5M7PiqkBad3MMTTeMFYL
	 YS0DSs2jCaypey0shtNBSfTVJMdxdVhqolKHv/bTNy4oJ8nauF3CcuPJgyPAhX+LU3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=d2Wv9N8m;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEE0606A321;
	Fri, 13 Nov 2026 08:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AEE0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=d2Wv9N8m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=d2Wv9N8m0cPE9uXvEQMPTLzuucX750PtCquBM+jtFOnLI233RwRIsof4LzU8PAjI3Rkp9TBPAGTxP
	 HcG7cYCEVo/v1Z5tRYF2f2z49jxtDBDwlC4CqPpsyfGRBF2FWu7iyulLjAuw4FiBiwRcIo3QcIotDC
	 qa0XB2S1vsc+evIk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af6c6dcd1f-89d5b;
	Fri, 13 Nov 2026 16:14:20 +0800 (CST)
X-RM-TRANSID:2ee46af6c6dcd1f-89d5b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46af6c6db7b2-1dfe1;
	Fri, 13 Nov 2026 16:14:20 +0800 (CST)
X-RM-TRANSID:2ee46af6c6db7b2-1dfe1
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH v2] iio: potentiostat: lmp91000: Handle configuration write errors
Date: Fri, 13 Nov 2026 16:14:18 +0800
Message-ID: <20261113081419.175192-1-zhujun2@cmss.chinamobile.com>
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

Fixes: 67e17300dc1d ("iio: potentiostat: add LMP91000 support")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
Changes in v2:
- Use an explicit error path to restore write protection and return the
  original configuration error, as suggested by Jonathan Cameron.
- Return the final lock write result directly on the successful path.

 drivers/iio/potentiostat/lmp91000.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index 00cb3fea97ca..b9a852646cbc 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -250,13 +250,25 @@ static int lmp91000_read_config(struct lmp91000_data *data)
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



