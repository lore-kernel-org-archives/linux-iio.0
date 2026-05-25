Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBF93D0925
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693394; cv=none; b=jtA4FNy/iIsHbqS2xYtLfAHtUL8lRUj7plhVIZeqFIsPNHt3lwSERhszXyAycc4aRZEGn1MrAbjw+y6jzq48AAsDAkSxFG7J3VSm91wyciTzusMXCj8c9FIz3eQMPD66vb0qEXenwptOTL8g7rPxTWiLuzPLW5/uKn9dWNWGTTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693394; c=relaxed/simple;
	bh=tWgd/SEfc+JK++qJsXDUlul/VoKzD8XDZqfTfUFVDVY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ie7pO41H5YVwGajRIcqwtmAWCNNyP7UJ56decLzDhBlur8EFhGbc5C1F49rR2I59XWDF8Bza40jHweDNOdNJQYFhsm41+DJaQYheCULeqrnWFDGDSOnCiLlCLzuXQxh9Ug6/bvKj1YanYmMC4dDUHtUpFFkuCM6t/e13vtDKpdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qH0TmiON; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qH0TmiON"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891b0786beso62477335e9.1
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 00:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779693391; x=1780298191; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q9k9e6Xf+MNzWVgNPNHN8tTLfksKQSlXwsLl9xzbAfE=;
        b=qH0TmiONeUPAdDHEinCBFFaPCkzaZ99lDiDz7zjMVt46TdEKjsNI+B53JVBG75xq3w
         zN7rCuh5AzneT91VsknP3XdOmCb8eLlGO1N41eYTJDJlQiHxIrdSUiQWodv/5badUAD/
         jkWUmqHEw3lBDVcS8afRoIQhxsfl24yGEX6UELQYJpAZEUu7P/o76uxwxgWD5l7OKqdH
         8LY1ELSYjPVRV+rtn62ffcjXcLYOney2Kr+EbD1rK5R2TY34XivFCrNBSnozqEVdxViV
         x2wMLvTczxs/g9jbyTGBE5ImAVwIXXZwlahDSytGXdaGNO4KXpD27vf4oSvD1+eiBdQs
         VA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779693391; x=1780298191;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9k9e6Xf+MNzWVgNPNHN8tTLfksKQSlXwsLl9xzbAfE=;
        b=pgKPZe53v5lBciV4CHVWg5ATy4tC3NVwrwRdqFo3IlZgF2ww7IZ0O9J7RijRWmQPSd
         ASh2/pTffmH1vaKUjEVo1YF/+esmK8rEPl3h8qMVUFeoK/V1zD9UW4qEKOFP+penUVcu
         kEoilOw6M9gXt9xCQx7fX1ZDvnC1Xc7a0U9ZjtqoWhWm55JGah8t+Wpk8eA65zrd1k0w
         E+4YUH1uAGZpZc+xqvzLeW2F7/TnMTII1shO7kDOlqF/7ahBscLThMWPEWrpHekIu2Xh
         vRcnM8B3nepnen4j7W/O7YD3GFnpxYuqkcDC1prchFejSYofbOUU8N3PxsLFAZt8BkJQ
         rXLQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Ud24COMl3Eu1ByWWapBnPQzhtYIOJdbMIjaBXlUYAlAw2RYZ7lVn3oaekVo8gqnRrW/Ct/KSCkK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhaXXN2ldRtcTQIaAsHXhvUQosFm6U+6qSBxmbfImyf2TKKUy7
	vHudQyPFHbzRd/RKPL9c8sJ0RbzPe4we9+k4iNyLz3b0NtyO1ypcKx0H
X-Gm-Gg: Acq92OFCIDb5OEirUG7mJk/3NuxuheJlSsqKnTjtXcNgTDTYEG3hE57/WhqTtaVhXaQ
	Q/VkY/2UXvDU5dQYqh6QMgNJt4kA7+MlOJYfLg0k1lrwEB5mWZGn6kK4PKAeEZrOEKoedBI72aj
	D3YWO4p3tiVoHuxIVUWv/bC3lCqb/NLGj4UYT9lC11+JQpmfGVjMQZb8JSMTXZT8BOi2DaE8NK6
	qZtxiuYoPkDxIOyzUxlNA1VCnjiSngPTHkkrU8d1AqeKajVnvCvhgx5gK3L2XuvMLpQSwc0KD+G
	Vuu8oBjiETTcC87wM9Lkg1gzD0+qub4WXetdbFvKeHQ5B3I+4FhAfGp0H2vjoHrf5fLTq8po6Q3
	uyn9+ZvQXAhtrQFlL/Hsr96RllWmfe4UhF6JKX0tJFgj2e+7co9gnyz3b67H5RpXzJ+xDFKRaJ6
	lyj+/4Ejnh8rr3pAqHKdZu6hg=
X-Received: by 2002:a05:600c:a402:b0:48e:6db3:ff3a with SMTP id 5b1f17b1804b1-490426d079cmr152408125e9.16.1779693391151;
        Mon, 25 May 2026 00:16:31 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49042aec059sm93042295e9.28.2026.05.25.00.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 00:16:30 -0700 (PDT)
Date: Mon, 25 May 2026 10:16:27 +0300
From: Dan Carpenter <error27@gmail.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: core: fix uninitialized data in debugfs
Message-ID: <ahP3S9nOYN3pG-Fp@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If *ppos is non-zero then simple_write_to_buffer() will not initialize
the start of buf[].  Non zero values for *ppos aren't going to work
anyway.  Test for them at the start of the function and return -EINVAL.

Fixes: 6d5dd486c715 ("iio: core: make use of simple_write_to_buffer()")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
The original copy_from_user() code was better:
https://staticthinking.wordpress.com/2026/05/23/simple_write_to_buffer-is-complicated/
---
 drivers/iio/industrialio-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index bd6f4f9f4533..1308a534582b 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -419,7 +419,7 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
 	char buf[80];
 	int ret;
 
-	if (count >= sizeof(buf))
+	if (*ppos != 0 || count >= sizeof(buf))
 		return -EINVAL;
 
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
-- 
2.53.0

