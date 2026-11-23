Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795463390;
	b=zE8TdQ7Kc4WQQLdFg4XqXC1XPWrXz/RfPFUsZ6Dhqve79Pt0/nB+3aUzKR6ut1geqWCm
	 VarEEKV/pMKeWHX2rX02C/OIwS+FCbDGuviTbPOPUZ+zBq3NRiObwjSQZMuj+U0kZF5s8
	 UKiIi6xthWbG7GvSMzfIEd3TgrUmjdMeJzy8P9qOoqm1DdsNVxzCrlFUsHqrzQ7ZM10lg
	 dU1mHxId6P3q1bd09fyObQ39jjdhN0v6Bk1bYaPtIIX+8tu7E0JV9kz/yk8cVI4NMceET
	 QzBl15jnqeMkSd7gMZyNqCJQt49QJOWtZ1KHN3m9znIvpMv8kbCHdxuMrHycPbP7lxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=u/af0oFedONOG78b7v4aO2KzMNrUwvebFerX1xuYNME=;
	b=JYdVY5qT7/JZqBZ6TqAQIw3/GydsNUPASBCMAjaOLsYrFioDUQojFgi0s8EjT8oiPa60
	 k2W2Mp8b8HK4twIRgtiBhq9qhc+41q3Vi9z+LL3pgseOsKIdSYOLeiHrUwjfvq7XONZ+s
	 aevthwoiqTJxgpOndTEk5xP1M19w+cuk4W0ti0AtKQypeDnxZdG4TSKNglGwhHl2am1cn
	 MKE+BE9y54xaccvxvEWmn7TMriZ6Tm0NVttbIehBoHOzRTAB6GGSiUo+gLCrr9+TN9YZJ
	 HYIG87bDx+gF9oSER4vuI48CCu6pwAmOS74LbD4ptyR2vLqjQivsXauG+56pwbKiKZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OtIFV7gX;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3604606A69F
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 19:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3604606A69F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OtIFV7gX
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so35306855e9.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 11:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795463388; x=1796068188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u/af0oFedONOG78b7v4aO2KzMNrUwvebFerX1xuYNME=;
        b=OtIFV7gXGyoWOxdYBtL8dlue9CMS63zjNUtm4UI7vahvboE0MZf6hfP5k0NLDI5a+d
         667pFkQ+4Xu+I7vPpzOJz7VjPErLTrpqUovSbnudpgyWe0ZMiTy7JbyNziszkIWUrs2f
         SBwyST9yiHOzGlYOZ16kzwdcG9Ayb0jAsQbuFJL4FGleCP/+H36fe6HSVF+/LFwLnc85
         3qyCZBxMP9nmWPpBuxtkSYs0zPF86WVBYf2Na/mJeTL87lhlLXAuYnXBDL64rc4qoFrW
         mKoh87MhlW4L/sBBSbLMjDf9eshvAk7ocp5MKBEoISfbAFX1zIYBpmF7hIGgl+WVXZh1
         JPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795463388; x=1796068188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u/af0oFedONOG78b7v4aO2KzMNrUwvebFerX1xuYNME=;
        b=OMXQz1lUuo69IXc9PfuH/J1YDC6HxteGjhvtqwV/f2LyAsngSAamJTcHNbUu+zMnC9
         vn2N8MIgEvUz9VnJUOCahi16aWozARLD+odqWIlKP9y+BSwAVRKPrVe0iHu5EvFhH8jI
         U8Wj4Ug0/1LGmR8Vq1kvdDVSlM/wn4T1PQAUaQJ8ErzkoOOBSsuB6Q4y3sCaJA+KYRaK
         35JYr6qAzw4zjm1OpdkzuyKMRRcI5kAOFhICN61zJDBFdftIgTa63AW1gEXLncejB35D
         etQqPBRSuHneATb2Hu+T2UlkWVu0DPAxnAudeDwb0db7S5ngkMbtLtMX+4Pg5w8VYB19
         A1Tw==
X-Forwarded-Encrypted: i=1; AL+hErFhSfi9JT0YlJnboFyejootUyWlmkZKz9zc62wbI3a/6iAkRTD9YsNm76RWOX4fjcPuwQbz1nmm5rw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hwTRiDUSwLjQMg3jWAfhxcHJSuQGtg2yHrGI5NuZc0U5I+VTD
	I9/zPZC/9Wisa1V1Jqye/8R2nzXG16ODr5YqIA1h70P3REgYtyXiO15vGEtRwycHdyg=
X-Gm-Gg: AZFdTZdCp2NHaJOpfj8t+2RBs/Q/Tx4H6GnHBIVhyv2z2G+GnwVtxOrTRc+Rq21LOW5
	KNs96KQiD09fKmDhyTVn9PMziwGN88BsvJl+zaJePQgukknVZC+B290dpjnvNw1inIEbu4pogUS
	6g75AB33mOJFeTtuDoJ//5QQ0kOgXoOIzyQP1sHYvQrhnoytYg84AiXoBguUnCLyNM9057o9WwZ
	LbEy5q3+irIGwB1A8CDA7RbarEb3mPtP8m30YGcA1y4T2Nz1PYkSiCT+ZfWaQTdIv4MI7JVh6sR
	gv2NwMnWg2+LapjP6nCOIN0zyzpHrq/+DjulTsCVUSmdex4VOjap6YXQ3NEkmi/pdMMa0GMp4h3
	mx64af2L9sPY0G8Ls9hPg35gR/t/D1Sc8BqxI3JeWSMz1zBWak+7f94b6zlyJubBWLJJqI6ugtn
	2+2KhBPXxQ2A18eYWaQoze1iKnudr57smEugA371t4uVwq0dxRuXtyt4JFFVci53uY17Qdrnzpa
	eToXNfV7DV/MkW/JKodwZbobRDq5AeKutQiDhM3nROD9yt31pvVD68tvldo2ldijVlryw1F2FR3
	gLDdApftLpg3Gzy7Q7aSqgDg5J53pXiWYBlqzI8m0E/Lw92HMG/ryf20ADg5raRUOqmKRhExFJP
	/BCI7FanaRkY=
X-Received: by 2002:a05:600c:4e4c:b0:4b6:5dac:b61e with SMTP id 5b1f17b1804b1-4bb88938d2dmr237088285e9.32.1795463388317;
        Mon, 23 Nov 2026 11:49:48 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm300924125e9.2.2026.11.23.11.49.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 11:49:48 -0800 (PST)
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
Subject: [PATCH v3 3/4] iio: magnetometer: mmc5633: Enable the VDD supply
Date: Mon, 23 Nov 2026 20:49:42 +0100
Message-ID: <20261123194943.57601-4-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261123194943.57601-1-gerard@teslabs.com>
References: <20261123194943.57601-1-gerard@teslabs.com>
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
 drivers/iio/magnetometer/mmc5633.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
index 5871007eeba6..584ed957e0ac 100644
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
@@ -65,6 +66,8 @@
 
 /* tSR: minimum time between SET or RESET and other operations */
 #define MMC5633_WAIT_SET_RESET_US	(1 * USEC_PER_MSEC)
+/* tOp: time to operate device after VDD valid */
+#define MMC5633_POWER_ON_US		(5 * USEC_PER_MSEC)
 
 #define MMC5633_HDR_CTRL0_MEAS_M	0x01
 #define MMC5633_HDR_CTRL0_MEAS_T	0x03
@@ -473,6 +476,12 @@ static int mmc5633_common_probe(struct regmap *regmap, char *name,
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

