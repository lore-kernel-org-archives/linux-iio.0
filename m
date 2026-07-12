Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA9D3B3BE5
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 20:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783887906; cv=none; b=mzQ2zPWMKV4bZ+cFb+5j6zHw+7lyFJaQkjt+epnJlvvn+3zXmwg7k64oM4vV7NM2rEW7aBmMhpgYVy1UqL8DtywHrgLcg4flI1qXKrOf75Xe58RelqTx90PwoRB/4CkLCrIKxP4MT4UbQRwmbdvG9khhRiIHefMOTaHlcpIgdSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783887906; c=relaxed/simple;
	bh=9Uv79NmVh9eY/kXN536i2ek90M/WLPrQWFXW/X5gzzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WlTD8Pp8sx7LxvEdzey1I+QgfBb1Q9ZKse3PDuQXkThjX/V1aWlJzJJRMcUlDD99EpXUnGN9vH1n3lhDHp0txw3s2tghqwGUNgmqyZeRg91B52soJTsLxymawfdR6qTT3FXyXpb+k+wp2q+mZ+HwZp1WKjIsaYiIkcAKXFf+aUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2tCmRvG; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2tCmRvG"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dfe910e5eso175870a91.2
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 13:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783887904; x=1784492704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t1Yo/I8ZgIt91EkcMTcsXR68fdAvToPUpH4oydF0Wx8=;
        b=m2tCmRvGNv/Vf1Ib3GElLmwymIZdr3ZbWWkPpT//p6H/jfHtRykzqq241ZKIWURP5m
         aqQEVe8nHVz0/GxwTYE9hMemgtvbzo4/YUCRNne9QG3kPihSu1WrZZJSC0rtfCarhliD
         +/b+hwu0Y5+DMG8bgWs/54obXYNQahmVD+/C9zJafH5Xw43ZM4Vit1784gdgtJjemdY3
         jCM0jKwiODZr2W8jRWRegcjntnOSXVMa0FCiV4gDn+0f4/SCavqkOs03rgnHb0M1Jzod
         GKGZJb6/M9mC51BlqwRsJLzO+7FpTRq23D7jJhvmptmwxSFwlYEfIV6OQGzaA0Xcy+Sb
         mqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783887904; x=1784492704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t1Yo/I8ZgIt91EkcMTcsXR68fdAvToPUpH4oydF0Wx8=;
        b=N+Q1V72wrN6JF5d5OjFU/epUHcUgCQmdbpbgtdNVIPrBMzTDh/4o7C5qKzcLWfiuR7
         nZDwRlGmgQ7NcqDoTT079zkWCBVhILaBEDtY1BD3WojkYrKDCo1w1T09uXwdTvbOFe/l
         NPxyP141r4buz+DeNZsh7870kotZP3q82yGaEEyAp8EEextc9mF7nEJtk4rM3aMPqD+c
         DSITmdo8Eguyi1i3OHq3OHThWboS34L++0zhznEdAaJfwRSgIcOCEU1yYpWYSk1MzR6m
         I+fkMt2mfabDem9ajrLqE9LknvXGxr+67Blbjl9ux2GgAzcOPYCV2QVvk/IZHYLGwt+7
         P6jw==
X-Forwarded-Encrypted: i=1; AHgh+RoMQ6n/XBy5052v8IAtrvw7uGM6VfE+ysgZ9pLO+LuKMS62r0XvVnSjaeYypyU/EDWlWwu2+B4CiY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFXqzbU/QpbWNP0jn1G5ahVUitiBRnmDd31QnETVcbSV0jS76p
	E8mM2HBSG6sWmRZ2fjGogxaUGx9P2FobH+iqk1Pof6J34BDVOTPt57g=
X-Gm-Gg: AfdE7cm7BX0MspZjkUL6X0fge6J43rCrz1ZSN7aoqj9vSEVSHk+qo1WQVO214tCRzKp
	xgtwbWC4bp3FmkrO7IwMHvyFMI+MreyEo6Gc0Dmb/Q5PhFYBBkZTjXvpMJ1zk9gny+Xqi5QAzaj
	RFJt+JbH1FKYVcaTVNglslj1+M0vfV8+l2JTegedYIF8JAdA4DWGUBGpP6H4WNfLrme23AuDKL/
	BqAF9HJE6Ms28PEpKO6vC5iUm2OVT8XDZvq+Unh7qc4vI2E3ulxCHeQ+RPrVVYDa6l4dgJ286rD
	QXteMK0BrG5lcjIdenm8ZwNpkLWgaUoTxTRRmIDbHnZazzrDNpAtil4wAB39Xoyp/nLPy4+ToYK
	qQYlO8ImqmJAHTOnseYDBDAjzdozu/rWKKhIqcq4ZGN7mQoBeCxrGKKSPz1Npa9D8Bazsqi5G0y
	8xtHLmrAgSDpmuFpDzf2tr+AK4EB6NrUoCBIzj0LbwhFr/C7Z7aYYT
X-Received: by 2002:a17:90b:5687:b0:36a:8240:2477 with SMTP id 98e67ed59e1d1-38dc7608a0fmr6218318a91.19.1783887904009;
        Sun, 12 Jul 2026 13:25:04 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm58833648eec.4.2026.07.12.13.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 13:25:03 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v1 1/4] iio: light: opt4001: Fix read-modify-write of wrong register in power down
Date: Mon, 13 Jul 2026 01:54:48 +0530
Message-Id: <20260712202451.20822-2-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260712202451.20822-1-nikhilgtr@gmail.com>
References: <20260712202451.20822-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

opt4001_power_down() intends to clear the operating mode bits in the
CTRL register but reads OPT4001_DEVICE_ID instead of OPT4001_CTRL.
The device ID value with the mode bits masked out is then written to
CTRL, corrupting the conversion time and fault count configuration.

Read the CTRL register instead so only the operating mode bits are
cleared and the rest of the configuration is preserved.

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/light/opt4001.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index ba4eb82d9bc2..f2cf496cc243 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -228,7 +228,7 @@ static int opt4001_power_down(struct opt4001_chip *chip)
 	int ret;
 	unsigned int reg;
 
-	ret = regmap_read(chip->regmap, OPT4001_DEVICE_ID, &reg);
+	ret = regmap_read(chip->regmap, OPT4001_CTRL, &reg);
 	if (ret) {
 		dev_err(dev, "Failed to read configuration\n");
 		return ret;
-- 
2.39.5

