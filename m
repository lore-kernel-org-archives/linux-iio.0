Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870013;
	b=SDDaTjnJ55oC4Lj5QjO5zouRA0gICdI/UUnk9tObIyuafA1FT35ZWmbys8BgxYw5By7V
	 NE9ggIkT+Am3OZsq2Vd22qRkPYzY2s7FASbJ80/937/cCRIniJGe5kYemwH1VhzynUxpj
	 mXE2YvTjdqHMoTtwaPnkryVtdFeHCdNLplpU3y2SVIP5eG1UzYs6s3vwOSHKkI4BaSa67
	 yhVZdxlfzvt32/q0/17xvQBN/3Zrp0mj7oO15Yum3JzdUZbyu74Grpv/KVEveV1JViR81
	 /EKQoKcepbuAiQ5pQLGjVz7MVRLcfVOBaTuLYiaq2DSGxybodjz2yYmJSJAiFPDYw2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870013;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=mqKCpqc3ESi02u0qt7HzlcluWKxVbZ+aolou34tE824=;
	b=0QgcyLz/VJ909ehpjZZDYnaBNV2NmBRbnkNemvtGyl3CvHGJDC27wioybfz77K521Ouc
	 KMphYQEDdoD796ljteiFuXe+tJKWJj64rTv01+Ou+Nl+ZFLa7xheGs08cLAzrxAY4pZf9
	 FzgaslivBFl4GvfHDm2XqhRpjBESu9o2RwMzZy56XPMBcq+Ehv13HRBW0obk2Pgham9JH
	 aN8In3+kbp52cICesYwf4GIGmYXshCtBLfnhG/zBchyt4bvJww0LW+EcHTVYqtprhkrog
	 hfXYdny6xpwuOohIIV9OJyzjB494wQmtJEa/+UAb+5GrHhswiUD4pwkjW/5T9U3f64g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890BA606A33A
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 23:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 890BA606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b4e04eda5aso12125537b3.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 15:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870012; x=1795474812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mqKCpqc3ESi02u0qt7HzlcluWKxVbZ+aolou34tE824=;
        b=TEO0usWnzJOcRuz92+9oaG66ZbuMwH73ZDhyJzXOsDeY38IVD+1JCS/8O4wxExc29u
         EY2EX6M37fYWNkHhIajcnZ40QpVrKrdML/zjMn71ucicekMDCQ59iHCLhIf9O7hmI5Mo
         4oBKBfYbO43Y2yeiLWevpb4gFF0GUQk7vvcjod8Ki7o1IrBCuqOWdlYUCauRei2qGty1
         P5Qama9sBRge5YxznYkI4N1l6WXCPBFgqP7Gh/6KSm+RAV7fCCNoM52KVBiTkdG5xR/M
         6ohUm2y05GSrptW2gDhQKdxs42jRQhsfs/sKMXfORCyec2xbOjWu0A3ybjLZfCoW3hAu
         xS/g==
X-Gm-Message-State: APuU4Z9Iof92G6OX0xoAp2/2hmdqtqDHosMECoZ2ya1RVwN6Ctyj2wMw
	KrK1+cZRiWE8sdscX2lxcTjBza5IWi3F0081tT2Qu160OJ7mJCeptI6w
X-Gm-Gg: AZFdTZdAqfziPMInPslJfZ20kuGzP3pGItitdXZSNfzh7vs1qu50fpinkVZ3tjHFvL0
	z6g5/+tWFRBjuARNyVcS2fVU+7rQFFgQdoWnDPBuldrqfI8BBDHdx3pNWRCp/aPk3dEOJXMVTHk
	mTbGWQg2PpwcvTc4ftRBvbl1UqlGYZHiA+XUCqvbVJLQ+kA06x55ylcrP4nF0ZBs/nbdspcrxpI
	V/JTO0wP1lXmwLlEoSwCY3PycZ50eOp/X9ATTZH6dxn8mGDHwWyerp4bPd4vPgfpJAaOP7ijWBE
	56dylO69QVVGg98PIJCp94H0xopyGxjr9dqVODcDGZiWxZC7JgXhPUAtBTNFFSov6YMfijrLWAt
	UXlhKaPkEc3ETuJGkwAfNg6Y9GkCr0eUr9zkktmQ9RB09Xv3YpDz9lvEcyvNiuYgXy04OpSNm/U
	y3E9HNCBOJX7gwd9NqeuBs+FAx+izzgmzvIavP4xS/IRzD9k7n5lcKrEPRwlPRj3q7tbe30xkeI
	/nzWCj6jjomTyDWStMWCYS+3HjjCJMkRErEratB9M1wyl0aXeHBh0HjZwPqIsyeSxQF80xcsV0U
	TTFDpci2y4sGryDAluCU0nRsWDFEr84eiSrxrVpvTLHntNfr9cYHnUMSPFvqfpD9KGAoPSlm8ob
	X1t2Kr1ZEXfKWzFTEWrlooiIUJgXzcMoG
X-Received: by 2002:a05:690c:e3ec:b0:8b4:b5e4:e7a4 with SMTP id 00721157ae682-8b4b5e4f2c0mr64991407b3.21.1794870012557;
        Mon, 16 Nov 2026 15:00:12 -0800 (PST)
Received: from 1.0.0.127.in-addr.arpa ([71.68.170.161])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4ebc50e40sm10721347b3.17.2026.11.16.15.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:00:12 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Mon, 16 Nov 2026 17:59:53 -0500
Subject: [PATCH 4/5] iio: potentiometer: mcp4018: Turn on the vdd supply
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-iio-ad5246-v1-4-ef6b7c06d4b0@telaak.dev>
References: <20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev>
In-Reply-To: <20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joseph Telaak <joseph@telaak.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org
X-Mailer: b4 0.16.0

Get and enable the vdd supply at probe, so a board that switches the
potentiometer's supply gets it powered before the wiper is used. On
boards that describe no supply, this gets the dummy regulator.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/iio/potentiometer/mcp4018.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
index 53471bd24640..0d80bdfdf243 100644
--- a/drivers/iio/potentiometer/mcp4018.c
+++ b/drivers/iio/potentiometer/mcp4018.c
@@ -17,6 +17,7 @@
 #include <linux/iio/iio.h>
 #include <linux/module.h>
 #include <linux/property.h>
+#include <linux/regulator/consumer.h>
 
 #define MCP4018_WIPER_MAX 127
 
@@ -167,6 +168,7 @@ static int mcp4018_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct mcp4018_data *data;
 	struct iio_dev *indio_dev;
+	int ret;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_BYTE)) {
@@ -174,6 +176,10 @@ static int mcp4018_probe(struct i2c_client *client)
 		return -EOPNOTSUPP;
 	}
 
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable vdd supply\n");
+
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;

-- 
Git-155)

