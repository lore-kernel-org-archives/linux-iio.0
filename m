Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06C23A0B3D
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689557; cv=none; b=H8tG5oGdxiu/1/8840di8CwU2yqTk6hy0JDohkhkbEWnqXDkNjMkLpWBqheBJLyi6hCPoINbNgLkUIHbXzM9MwuWj2gt/BDgcQYVo6QCOdTdnOefAqRfBqBcxsp3n72ea3hkNab8h9gFZGBMgzyT+yriAAluWRRgfx7MnWk2pWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689557; c=relaxed/simple;
	bh=O3CiZsX8/sSIqW/MeI6zSh8drrZb8XA+eZGT6PBOfwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n13piVptiA+B1wh/UCLYpZjmNXcJwTPDn5dzvm82yINRCCAt6L/ywPkAGyp2qoUuwP/S/lQQw1eqtOr3a3iWz8Y64aiM+vpST7tTkEXeA3JKAwy21Akwscg4vzcy3dD8jk/OPWLQhLLX5enHA1zoYwQf4pOh135kbFUGqY6j5xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvJk0AKC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvJk0AKC"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ad21f437eeso19209505ad.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 05:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776689555; x=1777294355; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gjy0kKozpfQGMY901XsRQN4N8iGuBtZWuy8SEYO8Yww=;
        b=EvJk0AKCeuIqOu0CyPEPtJJUz+BNl9QvFK/NOE8h3Y1b2m15Zzb7Ekp5dXfkr/xtbR
         15VHDwu9T0wq1CgbscdcIYlva1pDKLDW/2dMg/ukd/wuvjoh8OejeWc1GAOdmOAq1vKZ
         oaEJrp6DDAiZsRfwwH/WfwNeutzGsozJF5izwdYNA7zc6a4Z/96gr35/n31wvCctv3Ng
         Enpy80NzOtXYU+/VwZzlKREsWOhidySbl6Tja1U314RHuV4WJU57YMOZClU89xLEChEp
         YMeuvV7BDp3l44JdvLOt3aIRjd18wqCIwCWgKw4mSooiwyigILTcjc7ZRXgej1fQV5Fd
         kpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776689555; x=1777294355;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjy0kKozpfQGMY901XsRQN4N8iGuBtZWuy8SEYO8Yww=;
        b=pBgfWuQuBRwYPmdMdnATZca6v5lNh0sE2jvGVwm1wEuOby8MFdsWVat2V85dpKUKuK
         82cfdigUveJr38WoqoMhRMijXqWfv+kHl/e6C/CP4jiQhX3bi8sjirsuH4fhuIfF3QCn
         oxftGxyqIsOqj1OjkOeD9pgEp9V6bH9iiwgwhoq+WcvluyhQ/IKG5RkgrNS8/BYk04F+
         U1mZDkztfh9FZJb/Qebk3iCiaJc/P/wFFNRy+zp0wmqLa+XSDfBGNcYZGlWun0DpeYKM
         7g4X8b8selNBMZohlR+BtwOfiTtKqvvsmaSM+lD2mW/D2DWygXlHbLC4nLpWvUUyYDR0
         iJoA==
X-Gm-Message-State: AOJu0YxtQaVpWLpVZNvTXqKhX6RmFHC0HCmMBVlU34tH/a+kC2SZIsjw
	CLXW6/QskqkmETmjtYOfO7fSUXsrsVKVCSALeJzH1cOg5vcJWOqzOfXyF6CLvA==
X-Gm-Gg: AeBDiettEU+mYTrHU4rbEZxCPccETcWvwSQr0ugjTkKkVfa59ZR2uSVdzpQL3FgzTUy
	G8goSmhrBPTS4GoalTGOgRg0Ru4RLCKtz/daXXFQ43kUScy4nA6o06LrvAVI6aMlYSKOmjfahMP
	cg1SArgAMRNseHbQaYyvXxo6OqW/VHcn57MQGvxYQJf7R8+SV0REnBX7N/VF88EBg/opTbW7VF5
	k1hWMOLFEFKTxGcLBfzHCP22m17hEPBOvBIU6SXubPPfDZpiSL/ow1AjUmEBxmE85feo+2rs4/J
	dZtILYasOL4VaSM7H9Qy8edGQ6LANWi9hTRjpG+dVLxV/Btzch/iZh/JVHWjllyngDWyfiB7QBb
	ekJf7FxrBoPSOMN9x6nmcQNstAAWT37R1SnIn1DjQTeT3ofyE3GnYlVLl4o27tMP9rJnEUiWkiL
	dAwzlhFqzKGPEWhWJMZCnfv+MgMuw4TLYkHqOuJ/bkIvC7nWtEp3SS588I23ByoCMwmN78s83SN
	QDbnCLBfLwkiGwXLDIX8o2ykpBFCVplte8CsVrZ327CQwHv+HW9KQlq6zJWKcRS7tci4sXZaOYH
	0kK1jLmFJSrFcqrXywNdpjLgPYMIAFdJZQ==
X-Received: by 2002:a17:903:32ce:b0:2b4:5bf8:a7e1 with SMTP id d9443c01a7336-2b5f9ddf47fmr119475925ad.6.1776689555234;
        Mon, 20 Apr 2026 05:52:35 -0700 (PDT)
Received: from 2001-b400-e3f5-0b64-70b5-78f3-865a-db5b.emome-ip6.hinet.net (2001-b400-e3f5-0b64-ae5d-5f4f-2a0e-5369.emome-ip6.hinet.net. [2001:b400:e3f5:b64:ae5d:5f4f:2a0e:5369])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cc9asm104923755ad.39.2026.04.20.05.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:52:34 -0700 (PDT)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Mon, 20 Apr 2026 20:52:52 +0800
Subject: [PATCH] iio: adc: rtq6056: add i2c_device_id support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-rtq6056_support_sysfs_instantiation-v1-1-483ccee27b63@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKMh5mkC/x2NQQqDMBAAvyJ7biANdgW/IiXEuNa9xHR3W1rEv
 zf0OIeZOUBJmBTG7gChNyvvpcH10kHeUnmQ46UxBB/Q98E7sSf6G0Z91bqLRf3qqpGLWirGyZr
 vMhIh0jJTHqCVqtDKn/9lup/nD7tZCLZ1AAAA
X-Change-ID: 20260420-rtq6056_support_sysfs_instantiation-c6ee66edbec7
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kevin Tung <Kevin.Tung@quantatw.com>, 
 Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776689584; l=1852;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=O3CiZsX8/sSIqW/MeI6zSh8drrZb8XA+eZGT6PBOfwU=;
 b=RMkkvuJPPRxEG64nlyNyv/ol2HIi6mMolgkFBNPxvtrdkhboWMh/T3vTeVfW4HEryCgGH6ldC
 9oUpsFBPYgBCiddrQVMjn4dVv1wGXpMldqopPS4Hh4Yxm48ehmVXqLz
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Add i2c_device_id table to support legacy I2C instantiation.
Update probe to use i2c_get_match_data() so device data can be
retrieved consistently for both OF and legacy I2C instantiation.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 drivers/iio/adc/rtq6056.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
index 2bf3a09ac6b0416d1afea85de3d343ed503ac3b9..e2b1da13c0d31fa90cf9a7bfe494f331bcce2675 100644
--- a/drivers/iio/adc/rtq6056.c
+++ b/drivers/iio/adc/rtq6056.c
@@ -728,7 +728,7 @@ static int rtq6056_probe(struct i2c_client *i2c)
 	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_WORD_DATA))
 		return -EOPNOTSUPP;
 
-	devdata = device_get_match_data(dev);
+	devdata = i2c_get_match_data(i2c);
 	if (!devdata)
 		return dev_err_probe(dev, -EINVAL, "Invalid dev data\n");
 
@@ -871,6 +871,13 @@ static const struct richtek_dev_data rtq6059_devdata = {
 	.set_average = rtq6059_adc_set_average,
 };
 
+static const struct i2c_device_id rtq6056_id[] = {
+	{ "rtq6056", (kernel_ulong_t)&rtq6056_devdata },
+	{ "rtq6059", (kernel_ulong_t)&rtq6059_devdata },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, rtq6056_id);
+
 static const struct of_device_id rtq6056_device_match[] = {
 	{ .compatible = "richtek,rtq6056", .data = &rtq6056_devdata },
 	{ .compatible = "richtek,rtq6059", .data = &rtq6059_devdata },
@@ -885,6 +892,7 @@ static struct i2c_driver rtq6056_driver = {
 		.pm = pm_ptr(&rtq6056_pm_ops),
 	},
 	.probe = rtq6056_probe,
+	.id_table = rtq6056_id,
 };
 module_i2c_driver(rtq6056_driver);
 

---
base-commit: c1f49dea2b8f335813d3b348fd39117fb8efb428
change-id: 20260420-rtq6056_support_sysfs_instantiation-c6ee66edbec7

Best regards,
-- 
Kevin Tung <kevin.tung.openbmc@gmail.com>

