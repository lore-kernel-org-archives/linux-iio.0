Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDE744A718
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519819; cv=none; b=qheqI68/icULRY4iE9oWlVlmhTm0MJDvB0KTTHCDJgbmZrMWKT8W1vW9fR78LY4ybzbUEPWB2wCYXQSRDsMD8M2xdC80IGdwnPZCHPpXukzUPJmjCx/u9KnR7222pTe3eEUP5CiEA512n8kg4KBv4R3tmIkBipx5HASPiKYbfaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519819; c=relaxed/simple;
	bh=7i2Yo/t1q7XHGK77pjVZTy0lQTNcJulrmaJ5KfJ/L+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=chc3jdHUdWoRBMIkTBlUooWBO3QulsKdZdkIU225k1W5wIioZXIXQwq1g8ry0Do5/kfVU1cAX1Smq+seZ3APkd5KDZ9TirjvFfYJUQ1WCek9ztVEmTed9RW209/f2SjAYcM5FXxEeNj4BLv7GebNxiqRiTGrs0f/4OPEGT/U5HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVFFNAhZ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVFFNAhZ"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3660ab73adbso2836834a91.1
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778519817; x=1779124617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6QUHdwsKPMuhzZ5dbxDVHemNDTFeD/H74o09NHkn/Q=;
        b=ZVFFNAhZOOvm6mTYduHhKRx63hG+XQLHn97OcP58AIXroEEvev9OADwW+siArzhnKs
         1n7EmqySlI33uNsUUQKOhlRpk1GYfW/f9lEedRgMEaJzN7Y5QcjWfp+BEGny/FTm6AUW
         LRaM4ZGb/fCHcRWSSAtWavz5ZfSFJDmycUOMDL8T/HFm/JReblBd3ao/bfTUz+gAiufC
         xWBwJt3eRd2h7hLIr5Vk7KyYkHQX6LwvJ+nQQxjEEJsAqjvOWuQUlPrex3Cj+72WfxaF
         29+s3hJkGOt9X8VEYxrXmWSU6t5BxDPTQ9T34Nt8Z8jFrjkGlZAiVT6wdCTKdeSv6gz6
         puZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519817; x=1779124617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N6QUHdwsKPMuhzZ5dbxDVHemNDTFeD/H74o09NHkn/Q=;
        b=UPQZldsJvaSCwt1e8gFoD27XLtBZf3c+/Uj63o135YQHKwnN9b3FekcjjbMFf7kyDc
         QN3O5mmswFM9h2+nDCIY+1Pv94ilrhtuu7My8vY8iYurbwCzKK0PPwOwng/B8FD5y5aZ
         gNoJt6hxzHe8oUuCsQxLUr9B0RrFHkBHWyUF+B+hpH+TKlwftePNaDPHQW3dJuncJzD0
         cLuEAojkCA/xIpR9LQe4OZh+JKKvZ7BjGfpUfwXXpDMUIHY/NQCAs0RXXe1n0D70qh1E
         xZbuaXWkEGcPYmIjutqDhxlJ243Lpt0M0+JUgbLYpldw06+obKu20U+f7+FSWOR2HGPh
         9/5g==
X-Forwarded-Encrypted: i=1; AFNElJ+s61L8PcaSSBUpCUoKZtRelMwKSaTEqLW/sk3LFjksFN/LrB8vEukbmqPqHD63mqWjTZkjWf1LPXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBeIsyhXPiI/o2dVfdw0lOtdWQcM2Y9JTy3zv8v6fJDmgbyqDD
	XROdHTIps6Ppgtzo6O5d4ySW6jcNW0dxdnbLrbp8/hIU1oc+H/0G3q8w
X-Gm-Gg: Acq92OGa/8WymwEQKYZqsgOcyC6OE1CNS0mI5A/ckAidiBmQwtRs1PQ4kubt7f4tJPE
	lZIHvCtqzHxg8H8z7qgF/j2r8wwYflmv8o/4dVOGuCsFytRa5CfsbmvQf04lnVsPcEGihChHJJZ
	cO/23SXfv8NoLFdyn/iQtPNmL2E87ogodb/i9YgHK7O61qjWCyGOV5Mi2VWZYa04EE2op1IxQEZ
	f9+xV8nON/gzvFvnztmGJcab7Z6QroS7vx8hdYrzdcFxwrEJMSU/W97akuZDkjGpZDTCA24XT96
	144plxWfTHyZGFJhJlJ9XDN5LG6ABOGGD2AzenRwWHaWil9Io7OG3pBx+YuTmeEqT8Z871PgjFa
	rC5E9KXSuOYqIgnVOCB5yNnlymuoWZtAvA6qh075cFFjCZwPk81VXAlQZZq6FCU68RmEhi3KYsd
	Vr8LYipGuMQlN0p9FlS7/AEETYK/S5SWJTteIAYSRU/oJktSJ6AoiPhqAIlLY=
X-Received: by 2002:a17:90b:3882:b0:35f:bb17:39f with SMTP id 98e67ed59e1d1-368ab63226dmr375758a91.1.1778519815828;
        Mon, 11 May 2026 10:16:55 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d660b9d7sm8315004a91.17.2026.05.11.10.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:16:55 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org,
	marcelo.schmitt@analog.com,
	nuno.sa@analog.com
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	linux-iio@vger.kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] MAINTAINERS: Update maintainer for IIO drivers
Date: Mon, 11 May 2026 22:46:43 +0530
Message-Id: <20260511171643.3173872-3-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511171643.3173872-1-sanjayembedded@gmail.com>
References: <20260511171643.3173872-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

The listed Analog Devices domain email for Cosmin Tanislav is no
longer valid, and he is no longer maintaining these IIO drivers.

Add Marcelo Schmitt as the maintainer from Analog Devices to continue
support and maintenance of the affected drivers.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 887019830334..3115538ce829 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -633,7 +633,7 @@ F:	drivers/iio/accel/adxl355_i2c.c
 F:	drivers/iio/accel/adxl355_spi.c
 
 ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
-M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
+M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
@@ -1452,7 +1452,7 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
 F:	drivers/iio/adc/ad4080.c
 
 ANALOG DEVICES INC AD4130 DRIVER
-M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
+M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
@@ -1557,7 +1557,7 @@ F:	Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
 F:	drivers/iio/dac/ad7293.c
 
 ANALOG DEVICES INC AD74115 DRIVER
-M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
+M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
@@ -1565,7 +1565,7 @@ F:	Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
 F:	drivers/iio/addac/ad74115.c
 
 ANALOG DEVICES INC AD74413R DRIVER
-M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
+M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
-- 
2.34.1

