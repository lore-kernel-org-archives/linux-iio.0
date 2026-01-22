Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7143D7D8F
	for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096080; cv=none; b=XGvSreIk/SXhdAqBawf/SQm6bkna+tONxqn2fqIA7Dnpdb8YFwiwKjQe+ShRjI1DGwLi3dlezcr0g4laXcqd8vieU68yp56qCPqUGurSdjOYFbyc+k3BQtQnHtYsxCWbDYnAbvDh7L3FqByfUS49uBIkaJ9nbDHrWS3Vv5WreFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096080; c=relaxed/simple;
	bh=EyDARny+YwThyKQOrkf5m260pLOE6KAGgRiLiOGNkEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=seVLUIPiumwCbbi5fAdrv9ofgfPuZgfrYFbA5bpdn3UGPXpJ4UUpxnsIQ4S7rAHhdtWKVR3upPXJJ5xJhh9lxIKtr9KiOZ37gFkqjGnmGzV/soR3vUc/NHAhmm8mwPtG7fXZsi5Ja6pcxJwg03T5doEl+vHQ5uiRkYzR/Kjo9y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYjuCl9l; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYjuCl9l"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47d63594f7eso10412255e9.0
        for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 07:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769096077; x=1769700877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mx/uPaqOU1cLTitX0CrQOK3JjwkChXmdOPeXdYeNQlM=;
        b=IYjuCl9liSAtEUpArgMHVU0WMfr4yxZY22Z8S+cUgoWhN9nxluOlQBrq1vfkFhuqA/
         3QUIvERF4lTR/dUK5bAUJ+BomMWgqIbPcjJf7yMc6lEolGMrZnRXc9jFIVLPKQnlsOgY
         aCSRk9if1TvzatqsU0i4dOE/8HzPec4/DjHwPStt7ABW6loUiEqHO+crCb12RpvyU/kq
         j0kSqpAa1Do7KDfHHvFw29bFBu9FnqKkpCcDeFlMcdOHhiUuHkmtCCRsVpp3iPu1Hh8p
         I8AkPSGNR/qusntOgcEHlkhJZFI8hbtG1mbyO9SGVL7f/L/Fh1wvT8yzbQE0uEJH0MdG
         lLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769096077; x=1769700877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mx/uPaqOU1cLTitX0CrQOK3JjwkChXmdOPeXdYeNQlM=;
        b=o6xdouvELKU7sFtlhkZVosSCKw87ZbEQT0PL2ZE4ah0ot/meN5f+LTZUqU0mLp6x3D
         Ks1HItSPmQuXguUTCC4WAGevgZsczmBWwgUR7CgTvbjCttU0YYPRL1TcFUJTvhb1ZsCE
         D9FklKQddkExxcB+Fks6wrEHhzEwjyfnrPL2AQG4SLvaxmCiTqay9V77olRBczSE99PF
         ht0xf2YxjxBtkbNsV8ZQKoVvs43XxwDd3ATFJFZblToyALxrrCqyJuYuKgRWr36mY5N7
         vQ8Jqv96NEeICYg0TXW05e5r2Mg7SNOu5fNKgVZPrVTkgkRvl6wBAbSMgmV0fHMH+71X
         Jmhw==
X-Gm-Message-State: AOJu0YwJnMLTVgB6snWcDecfVfhCUnmcWQpShSWUPTGvXiqNfEv54MQl
	nHApJmoOgpwEVaVFslttZagBJHHNLoWHvdg/xraTr6Sf+G4KoSHPEY9CO369/A==
X-Gm-Gg: AZuq6aI4lMAyBvLwZcdLVZ9ud6NJQVxOVxLT/okN/mVzWF7mB/KhV67zccH1yGPfGWp
	6F/EBZ33TRfBu9f3U8BEUwkcF/XWDJC1NftpKy+gFQD/CG+/Mmvun7VXndaesKK8npN4g9CoxhV
	esrjNCCk+c4Yb+555QR3mralW49ij7023TB9ojQmV5gW2UWAM7RAd8n+bZEtLthCTQodsQaTvd3
	pY7D0k9PV96CLiKfHLPSl4nkACIkZ1igvuaPv+1xfN9M5KHVWpWZqyziv4lJezAsAmTCARu7HkM
	dbVB+n81FcB9MURQX5JlBlTVPrLZIAtlzY5JX2KSMueDZ2bOkVlN6klzg4KcLebr0M7AmPo+KH0
	oZKrSRlEQWoDDS4GtS359DdLQFeyQyLBNSL5GuVLGHPIusXl9FXRfcocbTGPLqGqwIyRyqYeht6
	z7
X-Received: by 2002:a05:600c:8189:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-4804c9b9b54mr158695e9.30.1769096076946;
        Thu, 22 Jan 2026 07:34:36 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e6dasm47355229f8f.32.2026.01.22.07.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:34:36 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] drivers: iio: mpu3050: use dev_err_probe for regulator request
Date: Thu, 22 Jan 2026 17:34:24 +0200
Message-ID: <20260122153425.8751-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regulator requesting may result in deferred probing error which will
abort driver probing. To avoid this just use dev_err_probe which handles
deferred probing.

Addresses this situation:
[    2.250875] mpu3050-i2c 2-0068: Cannot get regulators

Svyatoslav Ryhel (1):
  drivers: iio: mpu3050: use dev_err_probe for regulator request

 drivers/iio/gyro/mpu3050-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.51.0

