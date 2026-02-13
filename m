Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FCA362139
	for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770996144; cv=none; b=YZ2DUeSky44k25tvhjrN/BAaDcsLPPNBqNqqwLFu406r63AExwPU1nnXlOcnDiwX/jXdQ5HRuu8i6nBKK2rpFS7BoEI2Ksx/5WCezkwo36bxm1U4rXbnVZc2i0xjMJOo1KVWKaL6hvkEgmKGnOBO7LVGyvCqQKzFi5bdbPzPejA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770996144; c=relaxed/simple;
	bh=MdHGnwhc+Xr6C7Tf/QQO37NwJ0ltI3EiKeCTUpJF870=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cCiFDIP2kTzhzwG78xUhwupTE6XwBEKxMmS6cRr3hD8k0LKhi+JcuT5x1DWYXC4dvrJbJ5/11+zGGs2B3DIq5SlaCD0Km/qvkhgfbmlzrgeaYRagXwGuzwlwQOes4dUV9DYveEy3mKwjZA3sd9VXkcEWL1ZRe0YpAS0BxMgYvaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biewx2oz; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biewx2oz"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-127337e3870so35754c88.2
        for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 07:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770996142; x=1771600942; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0TSgWdTylqNWuh2HONEDIwf377TKen+WMQB+yoZN91Y=;
        b=biewx2oz1YKY7ZCDLO8em1P9ygNKur4C9GixylP6TN7uwPW9osMKYS1CXiJwZzMDDf
         vU6E6vFlNIO5s3ABqKF1ZmFw66ZzZuXbfta5NZefDYfQrePI/1AeDYbw5T2TIfkFyXYi
         8vnJ0gvsgelc8CANa/a0qetGbse5bufsV3hgkHoIPsUHyRZ4GahVjslKv4IKOw/FEaAf
         he588hTnqOwT28nfUcG6WbkF8Ta3gzShM1Cbc1DOB12eqRASW//b9ZeoU65PzGjmilsw
         B0hIhCTqZjnet+O4ODhRPUcLMS6iT2WZGIX9HHLAvL3GRNpELf62JFMcQwaBRzns3W5D
         fvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770996142; x=1771600942;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0TSgWdTylqNWuh2HONEDIwf377TKen+WMQB+yoZN91Y=;
        b=iuOGwAzRYf11eOlzyoenNASK9MRrDgonHtYL70m3geBcJR6OpdISSi93ZtTqOA2d1e
         AmReEmPnE3wQ3d1sG7otzizkD3oelzU/FhvZ7BLnOkD8jS6r5xGqxlX4NLCGRwDEoHn8
         Swr5Pj28QViN5ViDe1aYCzpg66JZy20NSod44ZvAVhmEKfk7XB61QGDkpfGwPgOjKj4E
         YLD/8ug9vDI7KXIsVOWgshJqFtC2wvpke58n5891sLgCi7+P1b01ry5/KWEWBl9HtEvQ
         4u7C4w9BSSfqiCvXEx0BNoc8ccgYDloz536ei5zXXSZDpJgWxiwQ1gMz+1Zayxwwnybo
         qQww==
X-Gm-Message-State: AOJu0YzGZypZvDR0gdBk++3QE2o+vS7BiL36aV+qwDv6KxqCNkjgiH68
	TAA1Dl0+kqif0AJzNHDsSC6ZiR5LYAEIA5Uv0cq8r/MmlwaibaCiLMec
X-Gm-Gg: AZuq6aKhEgjOLergrGxdMyRFAajVFRpTz/6kv9PYimHc+qIoKhggvjJF6VMnfxukJVv
	ROlsPrhojJK1iUjXVrhJjaqtAPmAthH5vQPq3ht9oe0yGiudDu7Ko4dSM0jZzUyiMnO3oG439CG
	Z6yGcK7C+Af5PjvpHoc66HfIapPG0tjf+vEZH448UmnvV3cF6x59an1Ekxf6HNA7A1GDyEGAXMm
	jPtTVOWKaYSKtTcxJim1zH3Zwpo73O2hMxgzpzpih2C4WfzASP+yjDaAND1EOF6Ax/9C25yBAOt
	f5Z0/d+eeA3PSs2u5YagQd3L0K3Y029Ybeja80uvQ0Uq4Gr2n9vLF2GZ2JSbjt20qEPLFQC5tHO
	UtAnn6K7e1QZmj2N3cyaGJcCsfvyhL5IqJi1HBAmfxF6hPWKLCKIyCPHALQJ/w0nz60qKeCPV5f
	WzS6MF4M/AXr+QdbF3/A9LVNubSNmcs9xWgf+vPDl87StqEl3j7clct+Q=
X-Received: by 2002:a05:693c:2c05:b0:2ba:7d5a:a816 with SMTP id 5a478bee46e88-2baba09cea6mr604050eec.4.1770996141658;
        Fri, 13 Feb 2026 07:22:21 -0800 (PST)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcd01d1sm6755006eec.17.2026.02.13.07.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 07:22:21 -0800 (PST)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Fri, 13 Feb 2026 23:14:46 +0800
Subject: [PATCH v3 4/4] iio: proximity: hx9023s: support firmware-name
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-upstream-20260219-v3-4-df9371d29f5c@gmail.com>
References: <20260213-upstream-20260219-v3-0-df9371d29f5c@gmail.com>
In-Reply-To: <20260213-upstream-20260219-v3-0-df9371d29f5c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=MdHGnwhc+Xr6C7Tf/QQO37NwJ0ltI3EiKeCTUpJF870=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDJn9jn0cOxd8/a5mdiay+V3Eziy9cJNJySuXnL5Y83/Rn
 phbZ1fbdJSyMAhyMMiKKbKcef2GNV/14Z7g364ZMHNYmUCGMHBxCsBEXJ8y/M/XzruW/HvxZanV
 lpE3JDMvub7dsyvj/J/1j55FF7NE7K1h+GfVdiN1/o/yVUWd+3c/uGWxdqpH8p1HFX86SoWcWOb
 lF9sCAA==
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

Add an optional firmware-name property to specify the firmware file.
If not provided, the driver falls back to the default firmware name.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 17e00ee2b6f8..9efaa5b6b5bd 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -1088,6 +1088,7 @@ static int hx9023s_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	struct hx9023s_data *data;
+	const char *fw_name;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
@@ -1125,7 +1126,9 @@ static int hx9023s_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "channel config failed\n");
 
-	ret = request_firmware_nowait(THIS_MODULE, true, "hx9023s.bin", dev,
+	fw_name = "hx9023s.bin";
+	device_property_read_string(dev, "firmware-name", &fw_name);
+	ret = request_firmware_nowait(THIS_MODULE, true, fw_name, dev,
 				      GFP_KERNEL, data, hx9023s_cfg_update);
 	if (ret)
 		return dev_err_probe(dev, ret, "reg config failed\n");

-- 
2.43.0

