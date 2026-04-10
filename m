Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68DB3D47DB
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838006; cv=none; b=ewAZuv41DsVkiYplwLcUCtKNjzOrFUVo2jp2AI7WcwTwbJL5571EoqmkxyySljT/UEFq33NnBNvSdPtimRY0yibKIgBjIgkUFofwzG/FOxmCU5rF8CRVbDHnd2wtolTGJ83tFEchQPZygdHJGcLjxDDOWEvC+ePRTGgyXPuvrmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838006; c=relaxed/simple;
	bh=r/jXjAutn0sgIrFPdW80ckJd7XRi5ViYFyeURSC8krg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C4q3LGn2C8C/eiu3cXnTI8WUAarA/qX4c9wxLTUEnOyEXb7kDIiGGd2+mjIsL7nd9U63NhebYKtj7Pnjjo6qdePKrGF9f2OfTKDJK0dIIQElJdHPyq3gIJ8YpHjWJdHSgGj3r4nJ9B9xain919PhBOnNdIf7iQVnnS1C1jCMP78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKUAsJz8; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKUAsJz8"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7982c3b7da9so20400907b3.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 09:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775838004; x=1776442804; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnHBqJA8JZ40KTknuTFFFFvoEdkYaSYsNZRBUHIVWOQ=;
        b=CKUAsJz8o4OOD6t39PRfV2QZet5EVucFxQZkZPNIknyS4EYsnV7JgUORYjAKx1/w79
         PyN0UdgkOz1ph5/wsrBQ2GG7oEVqxnMUO+xw57WNhoE36XlSZBZltOlBwFLiQrRYZjgU
         styfi+6P7Njzgoa3Sg4K4nAFi5+O962vvTNvo0dF9ef0yYRZOoMQyraPDjDhwFMVKIwo
         waGfg0fjLNNKNhI10HINDbMuFs+g7s2VL/5Eww5Aw+JrLEhjynWzxvQMe45pDCiVuZoY
         vOhlBH2LKEelfI6or823xt0Khm7dsLLouFFk5xAk6RTMs07DH2dRI1tCWWVQllfQd/bU
         E32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775838004; x=1776442804;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nnHBqJA8JZ40KTknuTFFFFvoEdkYaSYsNZRBUHIVWOQ=;
        b=kgJMyfY3ppAX7KRcfz3aBtoYnll4oX9C54W6WEItzo3dJaBzDKzdhKcwCP4U49G4Qt
         8feF4YBkVymiJVuEQ88vIFePILKbbXOZgSizK5/krC7LOZFlh8AEB3VrIVh2XtCP3eTh
         Mfh3/TWJi0vTWx4Xj8DCwRIFxxIF/6qniGYaeJQPfCqO30Ety7po9KNBDpqPxlFQ7Z+u
         4mF7rYCyW+eo/xxdjbzZNt/sdOkDp+LWlkqp2CwPNhsSK0T6kl09W2fVgjmD/VfxHChx
         PpOHerVDI2i/vBtpdvamYxjvLYIYaC5I/3hbFswQv9vurri0DJxgEnfGAn4w4YELtQTf
         ouVA==
X-Gm-Message-State: AOJu0YxisDQwwK0MWvqeuy055TyGnIBkPFhRgOaR410wdALeZC5u+RpH
	3/i7dyTt4lfjYvGWiRf4i+9E7iXB81q+ntumSIx6y28kzkGToAg4olPG
X-Gm-Gg: AeBDieu7DdshDpiTk+niOumR3ga5G3l+k960ycAzVgmZjr3ppHeUsKSWyIGeSoQhFVt
	q5SwXYkFAr7YL9SuONSEeQjX0zTfR12J/CUszgVYEc3A/Q2Xh7EYq6LWNkf1ej+v34CgejM+iC5
	CohlObOo+cMuJYL0FbSUYXeqyNnyPQyDpiaHLESJzEFvSSeIJP23Igs+4YaauShl/XZVdNcfLJA
	KF2M9B60VK6os9nhUAKx5Z6/BlXz7Ag5+n8ANJpN1QK8uMhq2bThnILk7/LILw2wpdEnSs4sf1F
	QBjI/MY3dZfck8LSwSO1EmcntfMStIIIczWA/7Inho0nBwkPxWj1OIuiC0pv4Tw90KvZKGtNRuz
	ipb2HGAKcsxHk5aJj1yIX/XAxfdYycGBfGFf5c4ivBs5bJAV/XdPfAvB2NazbTz7gicnzL0UCyW
	fQ8ym6Rxwt2xTJLOVGx8L70HuGgg==
X-Received: by 2002:a05:690c:d94:b0:797:d386:44e4 with SMTP id 00721157ae682-7af6fa02e95mr44067907b3.16.1775838003818;
        Fri, 10 Apr 2026 09:20:03 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa05b48sm15408337b3.33.2026.04.10.09.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 09:20:03 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Fri, 10 Apr 2026 19:11:22 +0300
Subject: [PATCH v3 6/6] iio: light: vcnl4000: register an IIO device with a
 device-managed function
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-vcnl4000-drop-enum-v3-6-2ea2bc6f5dfb@gmail.com>
References: <20260410-vcnl4000-drop-enum-v3-0-2ea2bc6f5dfb@gmail.com>
In-Reply-To: <20260410-vcnl4000-drop-enum-v3-0-2ea2bc6f5dfb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.15.1

Use a device-managed counterpart of iio_device_register() and remove the
redundant iio_device_unregister() call in driver remove function,
allowing us to remove vcnl4000_remove() function altogether.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index b08cb6b33d33..c2d3121be687 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -2059,8 +2059,8 @@ static int vcnl4000_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0)
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
 		return ret;
 
 	pm_runtime_set_autosuspend_delay(dev, VCNL4000_SLEEP_DELAY_MS);
@@ -2082,13 +2082,6 @@ static const struct of_device_id vcnl_4000_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, vcnl_4000_of_match);
 
-static void vcnl4000_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-}
-
 static int vcnl4000_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -2128,7 +2121,6 @@ static struct i2c_driver vcnl4000_driver = {
 	},
 	.probe = vcnl4000_probe,
 	.id_table = vcnl4000_id,
-	.remove	= vcnl4000_remove,
 };
 
 module_i2c_driver(vcnl4000_driver);

-- 
2.53.0

