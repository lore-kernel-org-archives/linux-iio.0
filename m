Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513599;
	b=1MrV63Ppc3mFXQCiDMRgtKi/5foraD4PVaLA939iDbfvg5ZuM5DC4Bl0CJcNPIbJ37Bh
	 Yhc+vfy6zvpwYROgc1zbBH++74oGkwYBbaqyfUFvoesIfcNPVubAhR6NOw9K5AK0tE1Eh
	 1sPBRQxT0diNJzeQXN87T7Q3QXPjciPlmhiOIaJn49ijY3BnIPvvgyrBYntD1W6L5nyMC
	 RbAPMBMgC/Z/U/sZgRvl+kTl+7qCZCzPp2KH5WeF3Rp4kIBpCdYfhjXLJwp0CSHg6302c
	 TQZePYNTQ4szBqz/hnBoq72arjJI6FsHZgaFo+yYT8SC0MJS4SjNOYYjD7WTxtY69IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GnZSqwlaadL4PUZcokgyQtKhCiqmTb5kZKgMwBNaw/w=;
	b=wKZ880YWRFKxDx6oAZAwXUcBcBBm7eUVwFTmsd/dbRxYq3eDT1dIEpQZ41zUYkaenS2u
	 ITws7KOnPfXwnmFy+35/Dt9qFPZTD9RmH6bIBHo+4tcAL1PTXZg2egQcryfgvCwjh9qRx
	 vF3voZDZSVQzd7jGOvxDp67m997gSzMVoVDmofIpHb/FWZ8tx997UJ4S4MY2Zc9R+3VVr
	 WiaMaoCmgwiSJNTXTueFbDFzZQ1VoGHKIL15esuJFuU6hgPwioTIyUYpBYHbeExMIZ9Qt
	 n+i0Ko17SQmUSNGUbxqtPiD3su9tOHe/Jg+JWOApTf9GkGNg4iFGVmMc+RstKhekw+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=SWOat0uM;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDEF60777C9
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 09:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABDEF60777C9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=SWOat0uM
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4b467581b98so40794825e9.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 01:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795513597; x=1796118397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GnZSqwlaadL4PUZcokgyQtKhCiqmTb5kZKgMwBNaw/w=;
        b=SWOat0uMtykoLrOOWFDDMs7TMV4cfqWsKi6cZpyxQ6x1B8U3bBeY+BrBehM1SdbsfS
         D9YA2Rztbp/ssELZIBseqhnvrukpJKgPTsd0HcV4HRH4d09PQrqo2sWs+4Ye7MOp7AW6
         aqhlVvcU4Ez3Y1U/3LpV2RfSLxOaliJc2F3j8hbjsRh4Aduo8iQN+gaTnzuIUFUj5LRQ
         q8EahHyO3QnDP9m/B8MINzZEmHfjVt0suVbJk2aDaZTgnJGvfafiy81Nb6XW1ImpTEZH
         mkzr500eodJoDpvBVMbm29YB9ImpG3eYdQxda8zcb3ZOtjCbojoIt5TZ0x7vCf8cC7lp
         Gv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795513597; x=1796118397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GnZSqwlaadL4PUZcokgyQtKhCiqmTb5kZKgMwBNaw/w=;
        b=qiEJbwEPJmIFHEi9Ni96iCqO8l7ZlLWR5v2LqifGRJTR2cPAWbiD9QPDI/1dZyHtIJ
         9j//AXxsI3ygGTrmR15iU2mlqRD/Lgy+XtD52enONx7s+8M4O2+Kq4ksBLHjW5RmmXMm
         /htcVRcZh01idAI0lUkrCtGdPu23ZHiwZ4CYfZ60rM7EK31SRw8YUk/HB1juk/8/Ds7j
         RiRdzJ2L7hzR8g/IE0kjbVaig8NoQ+1LU1ReI51LH1vcaDRPHztU1M8Lypzdb0BXK0Ml
         ucVAZwV4xHFGNh1r0HfPGQMVSGJNJ0kgKHAN4yXFwdkwSkz8WP2vJJU/JcvS5uMj3bqx
         QZ5w==
X-Forwarded-Encrypted: i=1; AL+hErHJFQ+UjMO4mtlju/Wt8b8inbtAKnaCMT6GSfUUTkWxFKZFDpq3RHivb4APSJw2nANZ4aVZ0nC4Jio=@vger.kernel.org
X-Gm-Message-State: APuU4Z/OoleLgh4qBiSvR0gJoRjsKObzuVEXkKD8CeGIJ6WflNynrmn5
	Hy8AKo39w7wsU5jhEm/Rz66sw4Mcqoj6FskcuojPShYyE853C8SbXbUwKLlZ3SC9Vck=
X-Gm-Gg: AZFdTZeY/D1dMxBNiA2PM/teGiMCPA2IC38bCRTimxsGqLOhYx6Gxy9nLLbEThtjTj6
	kW3Dj/Rc2tCDW5VCezA8TEp87Gf95hSu0UFgO51+jhG9XoLbtVZL/ADB0meD++F3zW8PKFAVuHo
	iYjNWCrwyFtkBznb8ZLbHp1rpDT7bHX+tAtGstFr+a2ZDedmdSDT2eBT5jnW3X7n55+7eBnnN+f
	A0rAO8VVSv7Bn5174GR4evOzE9KebeHle44hxJt9eoik3QmjCtoAMoJ4NtuOxUjUMfoAS2I1ZhH
	a1iMFLTCq6yVkCAUPyWgyt1sXVGkAdTBCIODD5+S2Cr6qL/hCUEgiiiZaYVx8LoebTAfZCnFWkM
	PmKCaTXdCA4OPKdWF6A6zgj7MUcthL3vLiRVOcK0FIrE9bTmEBhf8a1GlaikjnvIyHABBREGEh4
	FYoKBhmPWhSie6Qetuck10JHfkSmd2x5H0GvyrJGNG1EcdnIurrFP4eFiDaev60ZaE32wuLBBb5
	cC9pSGlVzGqa0hsleWwy/bHfi3WC/uMDEQRhNHxwuHXIuoVjLl4FtKzur9fOw8PURsuWyvuhB1I
	pfSMoSrazBHqTQSJ0yVMxkl0FdNngkWyPvBQOnAoQX9xbLs71n/cb7cXV4B/1Y4Qa8SzYwgGa53
	TboeFEYaGgjg=
X-Received: by 2002:a05:600c:530f:b0:4bb:781f:6067 with SMTP id 5b1f17b1804b1-4bb887e21e4mr276037095e9.1.1795513597154;
        Tue, 24 Nov 2026 01:46:37 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884c3063sm431782555e9.15.2026.11.24.01.46.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 01:46:36 -0800 (PST)
From: Gerard Marull-Paretas <gerard@teslabs.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Frank Li <Frank.li@nxp.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] iio: magnetometer: mmc5633: Enable the VDD supply
Date: Tue, 24 Nov 2026 10:46:31 +0100
Message-ID: <20261124094632.8879-4-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261124094632.8879-1-gerard@teslabs.com>
References: <20261124094632.8879-1-gerard@teslabs.com>
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

Boards may switch the supply of the sensor, so get and enable it before
initialising the chip, and wait the 5 ms both parts need after VDD is
valid before they can be operated.

Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
---
 drivers/iio/magnetometer/mmc5633.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
index 8142ba741ddc..08bebc8eb5f6 100644
--- a/drivers/iio/magnetometer/mmc5633.c
+++ b/drivers/iio/magnetometer/mmc5633.c
@@ -27,6 +27,7 @@
 #include <linux/mutex.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/time.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
@@ -70,6 +71,13 @@
  * - MMC5633NJL datasheet (Rev. A, page 23)
  */
 #define MMC5633_WAIT_SET_RESET_US	(1 * USEC_PER_MSEC)
+/*
+ * tOp, time to operate the device after VDD is valid, per
+ * Operating Timing Diagram section in
+ * - MMC5603NJ datasheet (Rev. B, page 15)
+ * - MMC5633NJL datasheet (Rev. A, page 23)
+ */
+#define MMC5633_POWER_ON_US		(5 * USEC_PER_MSEC)
 
 #define MMC5633_HDR_CTRL0_MEAS_M	0x01
 #define MMC5633_HDR_CTRL0_MEAS_T	0x03
@@ -474,6 +482,12 @@ static int mmc5633_common_probe(struct regmap *regmap, char *name,
 	if (ret)
 		return ret;
 
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable VDD regulator\n");
+
+	fsleep(MMC5633_POWER_ON_US);
+
 	indio_dev->info = &mmc5633_info;
 	indio_dev->name = name;
 	indio_dev->channels = mmc5633_channels;
-- 
2.45.2

