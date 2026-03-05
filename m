Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B4730AD1C
	for <linux-iio@vger.kernel.org>; Thu,  5 Mar 2026 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772738519; cv=none; b=GdPmwAwFZ7aIjzrCxqUjj00OdfIXRinpj9X5V0cH+Bgq8ZgYIzS+Bgk6YPET61BbrvwV+0l5TzOCgaDHQarF3aC8KdjP0l8uj4vbgT1vEUlMhEJda+vRu6xrGHOv8tuTeFRs9QeJUY/jJOLgqfUjDbZSNg9kAl6Vhm+Bt2hfReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772738519; c=relaxed/simple;
	bh=1imMtC0/yYHco2vsVj5IgBrcAsYawBE93Z/RmAB2JM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pdG9zDiJgpEXOvT49Zt180+ae60cI4sedD1O8LdJ2WTC+VX/EPZV/GIcTAwvSzophqjiNHQ4J/3PNLW8rtnauaoz6q0Ipm1YkzfWkNEyZhtDtSttyJb4ysL3qiik8acArqRS+Gkvy8K2vF//wKzQXRI3/UuOHqM6F26cQsKnRmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRf0xQTf; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRf0xQTf"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2be1b5fe11cso4649797eec.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2026 11:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772738517; x=1773343317; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lil1/Z0c1c1jQe+1RB+TZc6c/UAakMjk1ihKBwtS5Vc=;
        b=FRf0xQTfLZj7RHV0qdDmA6ZSn7YluCr9jJ0AwtYwACrUadxh2BsqUzGR9YtrcnUto2
         CgozpJNsid1Aga6fVeHgO6c9U+Omf5+NA0PptHJlNYr6wf42TO2XkNiYbHms7RKy29A9
         vzmxWMDxD+abwwa8og1EnDm6+yMJ1fxanASIM04VnBp+RWCYj1Donh1gkRbVBuLefgtm
         +lqdx/lKjBMi3z+HCLkI8nhzUOf6ab5CQqk3fD523JOtcsTdlSOsGzy7R2TGqkjR6feH
         YYDPTv3UPABIRaLokIDxQcQtGYW/22t8Hqf8Ux4+AzzXzl913sEevp59xh0VgOZGwl1t
         0zmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772738517; x=1773343317;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lil1/Z0c1c1jQe+1RB+TZc6c/UAakMjk1ihKBwtS5Vc=;
        b=IfTZtmvOzlijOva+qSpxCEP3uIR/ZqI+m5yKX7NOaLNf4LqPSlWA+TwTmB1mCGVsAv
         Rh1+HiempUWKH0GnRmipKMpcyMjCJq/dqQ2HA5P1fIfn+0GBQqt8jdUmX29T5Ypd++9W
         bIay6otxdXd9NlzmdITe8MJ/c36ZLIWSLMJlefVlP6jQW3z61xM/LV7NsVybr0FDwK7F
         JdKWo0kEoH+djsjTTVCzde3pRXbv144K13XYdgnf2+bkfl8qo0gLZjWwzzrh5Dnd42Cp
         TFIEtOpUD4XDqlK71FpJTF4FWoOBpH59ANXqDLH33b0+9iPi2tZWblObIDw/niCjjlcb
         J8pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUd5yAGIrc7/KMees/Kq6ecdJN1xNINCeHnkfQ7n4zxAFj1npsb8arZWFtnSWTZOs4vTHj1ZvA6Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtP+bYIHixh+WmNjiPR3BdY2fEUKTJSDVpHNUBiIMr1Hdq8dFs
	a8sRgrJuO+hnqwAt+KVu8I6VHLM4fGtEt77nzpt7+0H5931CeHzN8Pe/
X-Gm-Gg: ATEYQzy8yqYcU+gD4CcDvshR/diGw3xJ6I/V0C27YxMjGDshiPk4ROE/V7FwpRlOAKD
	Zw33omIbJEq4zk2Xc23962MBjYUz58aCE1cjNxsWTs/NWBPWPazB9nE9n2KnMqP82/wh2seFdR5
	Xo5u7BW0pPHyv5iBsC4oifx88e1ic+SmAiSJFQXFWk7Obr7KarrE1HDBazF7//3mLeL9h+liDfJ
	U5r72DAzJp0X5m/3SuRLBPMWKXwqF/+2ghCf9qLQOGPKv1hBpJ150dtS4+DkhcYaTkuqaz9t7Ft
	yEoxxf+VPZAiHigXolbOJ51IYjuHkfu0TcpHzR74ntQTvYY6KJA1Zjnde4tFdk04YYH+OClOxB+
	S1p0I+4yCWkVdKq3vn2S7c6qbL0lAjfdHFQZOb4idQbMYUvha7c40TkTQ21k8kxXFUUcR607Wv/
	E6NrW/XmZye1Vz67+dEaxY+8SGeGszLsHYtiFXQHdZEGXZy72uX34E1FF2fw8Qw9WuTM21r4PVV
	+OrzHORRHHPZrI=
X-Received: by 2002:a05:7300:ad2d:b0:2be:ca4:e145 with SMTP id 5a478bee46e88-2be310ad068mr2688799eec.21.1772738517123;
        Thu, 05 Mar 2026 11:21:57 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7788:d145:a740:ca06])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be1281ff70sm10800980eec.14.2026.03.05.11.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 11:21:56 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 05 Mar 2026 11:21:52 -0800
Subject: [PATCH v3 1/6] iio: adc: ti-ads7950: normalize return value of
 gpio_get
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-ti-ads7950-facelift-v3-1-a23fdd1a079e@gmail.com>
References: <20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com>
In-Reply-To: <20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-94184

The GPIO get callback is expected to return 0 or 1 (or a negative error
code). Ensure that the value returned by ti_ads7950_get() for output
pins is normalized to the [0, 1] range.

Fixes: 86ef402d805d ("gpiolib: sanitize the return value of gpio_chip::get()")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/iio/adc/ti-ads7950.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index bbe1ce577789..b8cc39fc39fb 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -433,7 +433,7 @@ static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
 
 	/* If set as output, return the output */
 	if (st->gpio_cmd_settings_bitmask & BIT(offset)) {
-		ret = st->cmd_settings_bitmask & BIT(offset);
+		ret = (st->cmd_settings_bitmask & BIT(offset)) ? 1 : 0;
 		goto out;
 	}
 

-- 
2.53.0.473.g4a7958ca14-goog

