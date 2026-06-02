Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A303672B1
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 16:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418752; cv=none; b=p4qV4u9VmGm/KwLBEybDsdpVnQxcx0QRJO4TV017+QwTKDrH+D28D6EQu4yJrl8KqarQ243hdxV17ikgQIc2h310TyXYe3vSSsVJT90QAdFLvmkuUoRDJdWeLvFxjRq/Zqh0Lg2EUTXRYntZVRgnKsEyDfWFdpP8IJJPDtiEwHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418752; c=relaxed/simple;
	bh=SY2cx2/aZPxKOolUSutlY/r7Wb1PfaSweT67ksOyc8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L8eb6pmm/LHbDyjzuXyxCa6eHoqHAzXt1hI3ardv4ylU4XW6NP9X3nHb8jrdqDCvu9juRg4GrwAm2FZNz0tfllZZkGhiqqajVGF5f+2peAQAoCnYuUHMELPMsWLaIbRvH8bJjm5CD38+IZClEyh9iDF+TEbb8wRnE138pZl99o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=HCeFDr61; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="HCeFDr61"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9153e2708aeso392059485a.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 09:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780418750; x=1781023550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P3ZhQnegYV5oQrSJ6/SLEy4PO6gApt+HL2skufhmVkc=;
        b=HCeFDr619jpCv1y5jx+OOZ/FNmdJqO2jtCJMKjJRqNIcCHb2zrStPqUE89LPNwWQHw
         d4wJG7i+5N30hB/TB/2uhV+mSOmahbJV+jx6UNgzWt5pyYjEOYWN4yXIwENbFet/ntRJ
         jr075aml1u4PKYf1tcD22ZGn2weSYsrOGm7JRT6W3x2DS9ZDhq2vbjpIBm+gj6drqltw
         hD0nd/YM96JQLJPd+mxOyQtTRvKWs5Xb4AQ13h+EB+cGppf0zMMWVbWlqGX5aO0czr3t
         y3pT72tDr2zOQxYNRgj2zOf9WabVUoR8MzSvDHs4s/Ep1pdMqhMM6WpJPFqPzAZ+5zko
         Y6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780418750; x=1781023550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3ZhQnegYV5oQrSJ6/SLEy4PO6gApt+HL2skufhmVkc=;
        b=aCyT7exU/l5oU/9UcMGaB2d7+bg/Jt502Yh3kW3KTwsWldfO11ZG6nv8NdzSQYyNOe
         s+5CGIUy538wqiy10HLP2xmQN3KdxEdZk/tJUF1lKjExpcrqpBEYt+zJvYuCluwMVQE6
         kabHmyZtDHvi58OzEukCPbq4MCE7j06o5N7+AESwkCWIU/iF9Sdw8pu7hflt8zpw+z52
         UlfTCzP+Y77m6Zh3psmmFxUmOHCiSh9aLyGCeua+wyNJbZUd22jkcIm1H91611xOhjJJ
         LavO9dud4OsK4yf9gOiKUuKjhn1oLJRswmXmC5GFxHwomk/iz3x9PwsLBUBdrSt8VIyB
         x2DA==
X-Forwarded-Encrypted: i=1; AFNElJ9Mflk7zC8009wCcmH1rv0PJlnfsBgCdQX782oHuwDE/j2HO6ZYnjuWq84/W0ACRI8XGLUngzwqpLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysy6MOnhfu6dL0wPDilszVFvLsXGiNSYqqnfZAb4Exb26tlejb
	RC5kxs48f+ca0x3K9+noPyHT8OdpLouckyZUZrwIe5U3RXj/mq3uRdkyRhdbDhEAMIw=
X-Gm-Gg: Acq92OEC1e9ztjgaS4vfnUL7ODKVhDfrR9K4zK4PvWU5HxBb3DFtL/YbV5xFztoy2yU
	7AI8QeZnikY3z4vSWteEwYFU8ZQ7iUtdTI+goDxq0JIYt1prbdZFdU4ezq9GQi5lo8KIJPb1/EC
	q2X6q4NxtR6ewnAZGKeoHiBxmhWslttJ7q+b2sZjFD+Yq02+N68+48/2MsO/gAjyKdU08SgtJ8k
	WscMVP+0yK3J5mP+QYq2NZPK/q4k2CKy5OTBJLi19WbmGaQc7jJ/7QaKtQ4W2MXMQBpXhx1fCEE
	aks1jdpie7fYSqgWqZqY3mL3Nx2lbht/6P45yfm1Oky+MjVKl5+c8oeWSbfmSy23OBwe5vR+Gwf
	X9eqWsg/j5EiL08UfP8Y3P0bXx42ve96jwA77F4hWJj9GNa3QIKeoxeOr8VuvTfDyOa4ktkWNsf
	D050h0LEDqHmmkPuNHs17UFFdMfBi1LkWn21xong==
X-Received: by 2002:a05:620a:4510:b0:8cf:f215:24c6 with SMTP id af79cd13be357-9153d9a2797mr2536908585a.21.1780418750036;
        Tue, 02 Jun 2026 09:45:50 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-915891724f9sm25899785a.1.2026.06.02.09.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 09:45:49 -0700 (PDT)
From: Sam Moelius <sam.moelius@trailofbits.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Jorge Marques <jorge.marques@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	=?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	Stefan Popa <stefan.popa@analog.com>,
	Julien Stephan <jstephan@baylibre.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS)
Cc: Samuel Moelius <samuel.moelius@trailofbits.com>
Subject: [PATCH v2] iio: adc: ad7380: select REGMAP
Date: Tue,  2 Jun 2026 16:45:39 +0000
Message-ID: <20260602164539.1541685-1-sam.moelius@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Samuel Moelius <samuel.moelius@trailofbits.com>

The AD7380 driver uses generic regmap types and APIs. However, its
Kconfig entry does not select REGMAP.

As a result, AD7380 can be enabled from an allnoconfig-derived config
with SPI_MASTER=y while REGMAP remains unset, causing ad7380.o to fail
to build.

Fixes: b095217c104b ("iio: adc: ad7380: new driver for AD7380 ADCs")
Signed-off-by: Samuel Moelius <samuel.moelius@trailofbits.com>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a9dedbb8eb46..c79341848698 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -311,6 +311,7 @@ config AD7298
 config AD7380
 	tristate "Analog Devices AD7380 ADC driver"
 	depends on SPI_MASTER
+	select REGMAP
 	select SPI_OFFLOAD
 	select IIO_BUFFER
 	select IIO_BUFFER_DMAENGINE
-- 
2.43.0

