Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E6445348D
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512593; cv=none; b=iC5n1U1BJmnjdRFQPRFaIzdjup3Nn11S4g9L4nLELlsqZNxi7PUWbylJQTpeDu3AJUp5pr3OG+8D2WBQ65nEDgmBIJ/NKvUGak6KeOmPlk4cTK1x02/U0v2J//PUoRNPaS+SOMHL6vD27h/3/uK12A0ICDc6WCIn7ukpeBo2OjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512593; c=relaxed/simple;
	bh=IyYb8UgF/AKA8+P9d730SEMTu3OzJGnh9mo/jac4tKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVRY+aUcNYJKgqSpDnmkrkyBxTGDn/ZaT8qMDOqtgXcPILk+Lrhe9T6TFmdGQgitbRguA9aYaV3MQ0tE9pZRUNFrqWHtu+xm1+QFg/4MJT0ZXrXvt4KYoUaODqfpr7ueid3yP7vnZZQpYyonmwe8zHRXh3xAq5FqVYrBdiLkPMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rS1o4ZGI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rS1o4ZGI"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf237e1433so61601975ad.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 11:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780512592; x=1781117392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1zPHIbDPv87v1NJ8/Wn8nmreCkN/BzTtCRIc6PgU/s=;
        b=rS1o4ZGIIa1cXEa/YK+hV+m4TLWhWt42DUfvU2pmVxDQ9L3gia4i+kh8z3VKDMLqsZ
         xX1TqL+aw+ybwc0rHhcMZSVge0aBzHXfaRRQXFgozRYSKp7IqNLZP2iSpWM4ceKoU4Yg
         9am5Xm5Xee0lPt2dB5DroebWr7+N0LrQAFOvSQt4emHup4vtKQXlG7IRoIKCB37I6LEH
         GVylcIUVVSiwld2nr2OdNxZ7q6J6R+9sUVKWFfgySJHk+83rE12RsIPxL+KkgdVo2J74
         pk89/z3GWBN7VtA0VZaF39iQ+FDp+xaqJHGVFdab+EOjSG95EE3834YQtS0IUpJtvnq7
         maZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780512592; x=1781117392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O1zPHIbDPv87v1NJ8/Wn8nmreCkN/BzTtCRIc6PgU/s=;
        b=mTvNOCzFev1yX+A/8/obvqRvVHAbU16rumYKpNMvDYpYdz83xKAxzlDtDZb+Vgk7B6
         VshhEYW82jMt4rNa8AO+/BHruuanzbkdXaVlTEygiW1xOZG+19OzU0nR0rSLgyJoQ7sV
         zYajMbYc2A67yR78Tm+SESfOByn7ZwcoDsxM1bqDj1/272d3/e86IY7ZUu3GT5hO5R5M
         1w7xCvrHWxLs1Akbi4bZ1Ro9ypOzPwrEDN1QybWDt6d2dVhTLSJWTd0kcoBSh65vMFEm
         l/E9pO+vDVRIc+rhdOhP7vL5+NSTWZVtcwcEep1Ddia7zIAYDCu0hnpsgVil+zMObEzV
         VCZA==
X-Gm-Message-State: AOJu0YyFtvwKE6YSNsRgVBr0vrsSNKKWUGmkIfy71SsKiXh153klGY/3
	ZbiALiR9bWYA9YJbtsWscdM59XL6Juj58A4YP8vfZzyqOKNFw2vX9UZXpRG9qw==
X-Gm-Gg: Acq92OGVJ2CphB5dUYPSyHvQilDARAgAoEZljlZAzzTCBPffxe2JImGmRzstL5mz1VM
	BqbQzmcPjhe8gziGhnMi1F9SOIjLg6WlZejg58SJZk7KyR11xxDad77CNyWswWa+YKT2k9ThtfB
	DMquPred/3G1/T4rzsC2k4dgkwOUYzdcPzfRb2AI+dBMGBpkvGZU6Cm2PrShdkZKBQFLDb0LEgk
	ck8IgnvHFaiU/SvUiXB+F6T4yA3KTsXD7lEHb4Qge0NiKIKmSYowyuXpFY4K1FA4Y2YvfzIB7pP
	Md61jGYkNsgWqeAtIz3BQhedg1VdjwstE2TWsRybtK75djmlcubYhKpcVu/8DvhVGtvWXo8+TrF
	YvNYsZVo2ZUjfswr+BpeApV0X9fwCpMCEueFF9bhyfR+lrZpfkmSpdxbqboajmKUWNKzY4aLLw/
	/2HNE1j60355nu1mnKVr5gqbC1Cm3xN0UFMPzcRjNvaGMz/NaPexdGxON7CfqFbpjB5wb+NXyBB
	DLv6Ztxpv3uEX1WQ5S6ZeYLMonsGL2SbCOGVS9U4Ci1qZD83/YPOQ==
X-Received: by 2002:a17:903:2443:b0:2bc:8f62:990b with SMTP id d9443c01a7336-2c1644dd3a8mr46147885ad.41.1780512592203;
        Wed, 03 Jun 2026 11:49:52 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2409:40c1:4015:6e6f:ee79:7998:9a6f:65e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d59csm32139675ad.4.2026.06.03.11.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:49:51 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	ak@it-klinger.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Subject: [PATCH v11 08/11] iio: adc: hx711: split variable assignments in hx711_read and hx711_reset
Date: Thu,  4 Jun 2026 00:18:56 +0530
Message-ID: <20260603184859.89693-9-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603184859.89693-1-piyushpatle228@gmail.com>
References: <20260603184859.89693-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate the initial value assignments from the declarations in
hx711_read() and hx711_reset().

This is a small preparatory cleanup before the later loop-iterator and
variant-specific changes adjust the local variable layout in these
functions.

No functional change.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/adc/hx711.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 30e1ce321747..4ccb0bf2d71f 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -159,9 +159,10 @@ static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 {
 	int i, ret;
 	int value = 0;
-	int val = gpiod_get_value(hx711_data->gpiod_dout);
+	int val;
 
 	/* we double check if it's really down */
+	val = gpiod_get_value(hx711_data->gpiod_dout);
 	if (val)
 		return -EIO;
 
@@ -204,8 +205,9 @@ static int hx711_wait_for_ready(struct hx711_data *hx711_data)
 
 static int hx711_reset(struct hx711_data *hx711_data)
 {
-	int val = hx711_wait_for_ready(hx711_data);
+	int val;
 
+	val = hx711_wait_for_ready(hx711_data);
 	if (val) {
 		/*
 		 * an examination with the oszilloscope indicated
-- 
2.43.0

