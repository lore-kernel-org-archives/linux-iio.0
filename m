Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB68812B93
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170256; cv=none; b=rkFIM0VhTbg05VwBzZ6p+dDak+aLl1YzqMTWdV2XPifeTuynyvDIoLGBfoOb5VXlq14EFHdhyWtb57uGkCYBqUQ7bnB/iVEQwjX4E+392YHVmc/Xydx5+RVfHD0i2QV/zVBGVJ+I5rW3EwuaMQjEK55pk+dya1DrEpO/JrcasBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170256; c=relaxed/simple;
	bh=uOmvo1mfNbD4bu9uWjKp7wZhL1nuHGEkZq/bWuGHg80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lI6s17dr3YSZWN4CZfScLbYErHNZ3Qv05vZC/q9QEq5uoec1Qc86XVZB4wv6N8v5LCIhtJwZOAP47qyc9r8dPJViVAnVYpb6I6BsdLA94KSwV/WlZP/En2jxoPzixngLx20OBCYH7XhTTDb9jEgUR+VtQ0OZTA/FdpJ6qpHH+ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/u7KLqI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/u7KLqI"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ba840146so54139105e9.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 05:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776170249; x=1776775049; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uenly7+CtNxUOjn6QoYde6SeyVk3RSuBlhTWmLeC+c0=;
        b=m/u7KLqI8ZTmu6DIMRpSBopLse3Mt2L0pLY5Wa3c6w3JHsk3pxD77P2DxkZup1DqGT
         zR2Goy6FLPUz0zg9HQTis42U8zBFkmXkJC8U5fErp7b4ts2VTkBYHzCujJHjGcmLZc9y
         +9BfbAgch+ZMO/w4n9N7C3cM1di9bo+Ncg7OAsd7zUD9Ih+MgCqY8ujmKCQ79VZrErJD
         0ovDcbWznEYRlAgO37eo8U36ayz5M9rxFZpY8RapqSJvyk8KHTzP0A9wu49zHys8qYqm
         H+RIwVHPJ+jCdzHq4Sn7RqhQGGyiXbgxXmnESgr2mmrqdgJCTdZ++dgw55AF8zMlqphs
         U3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776170249; x=1776775049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Uenly7+CtNxUOjn6QoYde6SeyVk3RSuBlhTWmLeC+c0=;
        b=ElCL4XbMMywzcZ51lHWWi84lcGSG5jWAvPEwePZIJf9kiM4xy3szL5Co7cWIVZ3lmH
         0hxYT47zPrjtHPpYadyc22mQNFawc50HiAIKdUL8CD++2DGMrlKCAuPPwEIsUILvht0F
         MoO98j3XXNnEurfOGGa84IF5kUaq+QgE+uD6OVREHqtWvpdCsGaLJ0Ar4Glm4Xs02Yt7
         +qOGZbakyzX23lttmkMSY1ri3OOSEfHEat+lUXolkziT33SG+85Xw35JwlPMElPj49S0
         fldsRu8FY3Sj8F6TH4+mfuVYPkzGIUkZ3L/uPB3Lh7lBs+ASFSFJe/q02tJaU/NNew+T
         Ty1A==
X-Gm-Message-State: AOJu0YzTIztiizd1IFtLegbpa9UZW/HNWdglpddS0u9U7wQv4xNV3hTe
	wYrbK8K5ekT1+GrgUF2kiWruMVf1RZyKskgCsKjk1LK8NwG40AMDn8OO
X-Gm-Gg: AeBDieu5hbSqt+EbrOrKQ79CS+WWT4ABdtyxTwjT70V1dqdXtpLhAseEGiUoHf0lKI7
	W2nYCYj+uiHXtiAHNYvzdEbKQEyeOCMG9puD9EmPKnAFezfgGA7afCyG3PTnhonsWqFslT+70/f
	dFiFl1DeM2v1NJyC2T8skR0dfylfbmsECVcbT1N5eqalRftpDzz2hHaalrrEHczaopGiujZqI+P
	6gAsepGTECu5xXkGRZY0NpITFyqdMOTpRhDRpmxmuuKcdVzyp5HEPGBFLZZegMJDRwk5ZsMdHjJ
	zQGJ+3gjkW0oQCxGHMBs9gkzmPYkIh65X2T4o3wxmoy7PJ/eaGntayVlKos+LF+ttx1FdL2Sp7S
	R2qcGr8e2NynpdGfXs2MG2e5PmyaOdFeTdlpJtBb+Amsy2cgxvTkxFf85PZd1m95ckZ9yJ+voga
	AEo1ns3A5BmyxL1bRI06lcZNHneiKydr6qtwyjAIPA
X-Received: by 2002:a5d:5d12:0:b0:43d:77e1:6a67 with SMTP id ffacd0b85a97d-43d77e16b06mr12244419f8f.5.1776170248128;
        Tue, 14 Apr 2026 05:37:28 -0700 (PDT)
Received: from [192.168.8.79] ([2a00:f502:260:5bd3:9217:8960:5f33:aaab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e46a85sm41552729f8f.24.2026.04.14.05.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:37:27 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Tue, 14 Apr 2026 15:37:22 +0300
Subject: [PATCH v4 6/6] iio: light: vcnl4000: register an IIO device with a
 device-managed function
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-vcnl4000-drop-enum-v4-6-59fde2932a0f@gmail.com>
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

Use a device-managed counterpart of iio_device_register() and remove the
redundant iio_device_unregister() call in driver remove function,
allowing us to remove vcnl4000_remove() function altogether.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 3d0287799ba5..c08927e34b4e 100644
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

