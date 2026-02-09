Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9272236A73
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 03:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770608409; cv=none; b=uTH2KSZ6UCIalEGFIpkh//oE9nOsIBofQinm/BhGVXUiDsNF25ehGiwWL47YZu6Wkl8GHVdJt6Hsg8+2LfKoKGSAGb5GAM+EQrCS0JVAc5ZjtH1mShSAkUVu97H/Wao7svXPle/nfc5ZcivjJFmj5m3RNZwlo9ibSLaYZxXBVII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770608409; c=relaxed/simple;
	bh=FRQMDMtmr6RuDCT3QnoTS6pq66M/4574XQAa6lYWU3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nQ3yjcP3dOWrvmol54yQx/66pxiuak+c254Rr5qPBNi6NRi+jC4Y2rSX4fhwxH4RIc0uIeTXqjZbdbc2dcsfp6yjoGqej/ZUGYeI90P0M06+nnqPi6EgQwTsjvXdUe1YtD/AyW6634/CaLA6k1ZvHtPNUouG6ClmQfdmQdX76sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmW02srT; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmW02srT"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ba716126f5so29997eec.3
        for <linux-iio@vger.kernel.org>; Sun, 08 Feb 2026 19:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770608409; x=1771213209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXcQdRWHKbSzK5H4HbSkBU6Vxa0xKwilMdxaH54zctE=;
        b=EmW02srTNKFQJucAEdWl49q1JdPXFhhu6cc9UTEEgo9ORrdA693kqDbX0+MjF96+GT
         vuAXNghzLPtMP3r7cO+vdiFk9xZi20b2RKDpOzeBcqieDHnPWbZGHW100ZxxFFBQTt81
         cL5lGfJCsOcJX+fM56bdu6uWLNEWs6BkCPw/9ItlWEpPe67d3dWYRTCqD0Mf+KnWLrYL
         Onsvmfz0pU5dZ+Af3ehsC2TeK7nULwv6HrxgLSLHTuHrjSGDkTYMvQgzqVtriGWQb5Sj
         6oqv4PuYQ8CAC1ZXaTWAR8IXzEUA4b+KZXKoxn06C3bYsNYCEQ11sO7dnLlv8r9mR/Mi
         uvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770608409; x=1771213209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MXcQdRWHKbSzK5H4HbSkBU6Vxa0xKwilMdxaH54zctE=;
        b=eZBfuFZ6Wl+vcThep9jO87K1DgAfxwiyxt803cb8T/lSqXElYufHdywlH/5+7sWZMn
         Y/jhkspHQiEMOGjJbmzGvcwhAkzfNMh0jCI9ywdLPZp6hinqM6Xt4CduCnb7eev59Xog
         nI/zU2iLeos8XjTruFU0Hz79PYqV8kCKeSgWmAuDiUMHWu91KnyOuZx+tjHvOstlnw/i
         VvS2AR//vwaHOONd804XKee/dR/9ffS50/fp8d7XZoF2kQ92wnGpU+Zhj9JCKXM+uTq6
         JJWOp/tKbDHBVsL7zFfKGx48Qp4jHJEfMH6B5Uigx+QmHVQoXJcVZBzyVTSt9V1E9pY8
         5sbA==
X-Gm-Message-State: AOJu0YwXBhnFRDHOVWe3V1De6ZqPE7oCvVDyMEhWrw4cj+MUWn14UFCv
	lTA8cr2Qi1ifB/KebBMocyRotNFPvE+0gQMuqxV+8D1JrVMYtjjPCpxLRKEcJA==
X-Gm-Gg: AZuq6aLm31QIjGDemuUVH6zw1W+N74AuqkI8AlfqzJiBivNBeHkD3ajiekZMg+g4Jbu
	ZZ+iRUBjXSOgHduNuQBrpRWtxud40Scck+MPcKJmyHp+w7kdLV3VybSGPDdYNpMAZ/QGSzCzoB5
	ltKkp8TRZHqMhUZkkAyWjQsZkuCZmCBG0ShiciBS5McJ/qi+Vfl4VwRkgzLEvF3yrL56Xzb810G
	LUto7xvBQWtFFJCYIQJ5VaMqNJg+qX+irPSUZsgbOmqmD3Pnyuebpwpb2q1CtoOJYtZ5utwp1xr
	P78A7a593UJpqgHsRdGfsd7DDGZMzReX6PPKCGcHSspfnVl+UJFLVV+QeiZX1eOyX5t2lWpQnH1
	yQHZsYqBDLD/+UZWk2zPc1KBGZd0tfERFupDQwi9uBjgKgZlTlwgNbIKx74ueD1eN89nhW+Jsud
	91in6kBfGhcHXeDw8KDrPgCg==
X-Received: by 2002:a05:7300:6425:b0:2ba:7321:cf91 with SMTP id 5a478bee46e88-2ba7321d1fcmr339913eec.3.1770608408975;
        Sun, 08 Feb 2026 19:40:08 -0800 (PST)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855af5ca2sm7682073eec.8.2026.02.08.19.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 19:40:08 -0800 (PST)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Mon, 09 Feb 2026 11:37:04 +0800
Subject: [PATCH 3/5] iio: proximity: hx9023s: support firmware-name
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-upstream-20260219-v1-3-2b4d74e309d1@gmail.com>
References: <20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com>
In-Reply-To: <20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1640; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=FRQMDMtmr6RuDCT3QnoTS6pq66M/4574XQAa6lYWU3w=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDJmdYT9XLZPkMXd4Fc5muEj5n9jMcJv8RdauEZ88sjm2P
 OIKsCrqKGFhEORgkBVTZDnz+g1rvurDPcG/XTNg5rAygQxh4OIUgIn8nszwVdphqxlbD7+US1DF
 houvVJ4c/BywSiS/59nSG1uVmpyWMjJcLt3tMzfmz/8XlvOWLfu3vdrM7PYMa5a5/qVvHx/iWid
 UDwA=
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

Add an optional firmware-name property to specify the firmware file.
If not provided, the driver falls back to the default firmware name.

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index eb4902d18d74..b680b89956bd 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -1089,6 +1089,7 @@ static int hx9023s_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	struct hx9023s_data *data;
+	const char *fw_name = "hx9023s.bin";
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
@@ -1111,6 +1112,10 @@ static int hx9023s_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "regulator get failed\n");
 
+	ret = device_property_read_string(dev, "firmware-name", &fw_name);
+	if (ret && ret != -EINVAL)
+		return dev_err_probe(dev, ret, "failed to read firmware-name\n");
+
 	ret = hx9023s_id_check(indio_dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "id check failed\n");
@@ -1126,7 +1131,7 @@ static int hx9023s_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "channel config failed\n");
 
-	ret = request_firmware_nowait(THIS_MODULE, true, "hx9023s.bin", dev,
+	ret = request_firmware_nowait(THIS_MODULE, true, fw_name, dev,
 				      GFP_KERNEL, data, hx9023s_cfg_update);
 	if (ret)
 		return dev_err_probe(dev, ret, "reg config failed\n");

-- 
2.43.0

