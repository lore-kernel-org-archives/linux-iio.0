Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E03E63B1
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170256; cv=none; b=nFZTPqDXdLVnIcWmpm8xkGkDtXn9o01aFP8gALXPPxBtiGh8Ycl77kDbDUkS19ai2kcLQTwlxn7NuWIR5PmlpnuBQCPCpQ368CLVEAPurkHmUrNeDXStMXePM9qIrGwz3IYslV02FXvEE01d9QxfMh1Jun/hK4B/wr9Yhro73AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170256; c=relaxed/simple;
	bh=7keH773eit1dlAVAToEvASwJEDw7H3TutIwfbRXeS+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uXDe87Ect0NEJHghWPYperfTH+/bbIcyDuvupa2N03ux/flDU5fo6uHEQSO3/gaFMGyJkNZSFi4HFfOpVFqgmDzpWWoX43Xt6PF0oob8+rXGm0DQ3YOl2U/LJEUanCv5QpFukHdOIHZiclVPcH0a7Zwy2TwfsbCaGZ34C/0wZ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1KxzFN9; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1KxzFN9"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so4341738f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 05:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776170247; x=1776775047; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGpv12SkwkaOJPmead5uDlbBQHRw6GdSGF20CiabWh0=;
        b=V1KxzFN9B1ZLSVj8FuHtSAsQx7B8ajVzH2c8fYkK7NwiD2gGb/fGLQr991Nyz3qwGx
         Pgbo6n+TaRYhfjR9SK8oV2OH/RBoOgs8UdBlfp1Qm1P+yrWTsJ1sT2laeAdTc+7rzEkF
         0SA8rIPpsdhNH2ubPsWFJ+zFNg/nWXCsa2NhnVp1tETJ14SEW3OvQ6qzlK+bt71aYES/
         uRtBri+6gy8QlkawP1dBB92pXiM4sW7Pz7OisiFkHgcLQ2f4kLrl0LdNbXVQO0in+LGA
         KLFk0AUN7grQYhnP4xOi/D93II2ahWK38gjGhs9IfWtAGYAVZOLKanJb6Wejx3KrYRN2
         wbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776170247; x=1776775047;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sGpv12SkwkaOJPmead5uDlbBQHRw6GdSGF20CiabWh0=;
        b=eIt4hnPcDRWMnKr57IKGCBt1OfIXzfZqdCRwxQ1Q5016zCatBw/2CPjAZ53sglyyTx
         HQmFP12+FZiADzqXe0CrzxzHfpZOMNPoc5Qq06d8+ffkXvUaQ1ZiziyK0BfvU3eboQwI
         7KZI5v7lXACKwWF4tWTnQRcj0P4YrVMUXvBKODewL+Kea+oR63tOI5Z5uM9eU32PVKs0
         HBwQCqxcUI/JtSEPAw3RwoaJOJBubCIYnXG245t1CUf2s4m9AIdcHGzbPoEOTQWN1w0M
         bboFayU8ZHLE92cMsRbQDuH3K4t+dSUETSCBc4dJMnKoBTZLfXfPbfcnTX/WNeIfJJh+
         oV2A==
X-Gm-Message-State: AOJu0YzDb3KkGwaSaKPJLczQGmMAukkb6cVeFt/27TS5aax+0zdwWMsR
	Fo0K/fwxblHZruzBI/DbwMoRRP+lh9PcBqdOOsK8SEXZRNnzuOLnoBPO
X-Gm-Gg: AeBDiesUOvxSefPhfF6GDdR+8zD/GywJg/xz1W5mNs1lqAayjm6anQUbxrPXi34Mmql
	dvQB6cJcXPJMD/J9eZloqhrO3E6XBqRMhpgj1CKjg0MSflpVc6MWhu4ziy2E8++e3/zQL4MzMnO
	7iCWv97Z6VKUE/ERM/TGWZmaV6657ExYIqI2txB09UmjBg+7qeTYDCtK5/2a4bb0e+YsAw5GFpW
	GgNSxhtvTXjYFOQczEdASovhuMcKeYlQmM+OUQI+FhNEd1xNmyS7+/NL8p9CixIe+hPMh4Db2Ba
	0zxjsNTOZHo4+yKns8kK09D+b6jm1ffVuD5gepuP2NfbiYmCtwP0tp9FxKmuBgpwlOHtDN/CNIH
	63NFLqfgT8qACMHST0xKJK+XsLsMEmJx3YNLVTYT0gHdlfzmk/OblxKztC6QCi5UaG06JnMoQlN
	ol8PWp/Y9FwvdAnupx6zc5bfJSEsog4g==
X-Received: by 2002:a5d:5d0b:0:b0:439:b55d:b0e5 with SMTP id ffacd0b85a97d-43d642a7a61mr26581874f8f.28.1776170246920;
        Tue, 14 Apr 2026 05:37:26 -0700 (PDT)
Received: from [192.168.8.79] ([2a00:f502:260:5bd3:9217:8960:5f33:aaab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e46a85sm41552729f8f.24.2026.04.14.05.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:37:26 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Tue, 14 Apr 2026 15:37:21 +0300
Subject: [PATCH v4 5/6] iio: light: vcnl4000: make pm_runtime_enable()
 device-managed
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-vcnl4000-drop-enum-v4-5-59fde2932a0f@gmail.com>
References: <20260414-vcnl4000-drop-enum-v4-0-59fde2932a0f@gmail.com>
In-Reply-To: <20260414-vcnl4000-drop-enum-v4-0-59fde2932a0f@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Erikas Bitovtas <xerikasxx@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2

Replace pm_runtime_set_active() and pm_runtime_enable() with their
device-managed counterpart to remove them from vcnl4000_remove().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 1e636e6f51da..3d0287799ba5 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -2055,23 +2055,18 @@ static int vcnl4000_probe(struct i2c_client *client)
 			return ret;
 	}
 
-	ret = pm_runtime_set_active(dev);
-	if (ret < 0)
+	ret = devm_pm_runtime_set_active_enabled(dev);
+	if (ret)
 		return ret;
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
-		goto fail_register;
+		return ret;
 
-	pm_runtime_enable(dev);
 	pm_runtime_set_autosuspend_delay(dev, VCNL4000_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
 
 	return 0;
-
-fail_register:
-	pm_runtime_set_suspended(dev);
-	return ret;
 }
 
 static const struct of_device_id vcnl_4000_of_match[] = {
@@ -2091,10 +2086,7 @@ static void vcnl4000_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
-	pm_runtime_dont_use_autosuspend(&client->dev);
-	pm_runtime_disable(&client->dev);
 	iio_device_unregister(indio_dev);
-	pm_runtime_set_suspended(&client->dev);
 }
 
 static int vcnl4000_runtime_suspend(struct device *dev)

-- 
2.53.0

