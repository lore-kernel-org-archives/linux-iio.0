Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7303EB809
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780414785; cv=none; b=b1ujCSVz4aImHXwWsfhd3VbdI4gYbfiWjOaFhTuRrP5mpksNAeg4c81zHRKGBUbqqwdo2ObeAqtS1wCGLC/SNy7WsJQRrMiuz6yB6nqCOwDXrkVD4rh7k1JdriH+zRqqNFTwm87T7j501UifxFEKjbuaNzj8+lVEo9832x4HPwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780414785; c=relaxed/simple;
	bh=uzjZVtOVp9rHxaK2qDp5BRQbRRi0kT5DlVhtDRyB91M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eJ0bC5rEHMCf9Bpux95/acj/M/ga6SfqK13QZX/IgnIHMR1zQZx7X/4gU0uaX3sxEXdV3JU6p46MO07eXldbKQf/y0IFfLqvG/YneypTD6OYkfcQkscue8MMXBUfMDDpLVz8U6XmMmGJQ4P83vsTwmonulRU2pDz+KsvZTL9ksQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=eqAGXE/Y; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="eqAGXE/Y"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-6c449ac3588so1494129137.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 08:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780414783; x=1781019583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KFxuTfObIS5kNIa/g+jesmeajMd2HNasePUY4XZFIUQ=;
        b=eqAGXE/YoqGNjy78wrSHd+HnxbFGcMqhsBH+A0uuY2qghdP82PdwQsLA9S54VjS7D6
         GQkCnTaeZpfM8rIl0RlIq5tWsqKJqIicj/o7t5TQZPKrqJSW8vl/oDCBOkVp6tA1Oy/2
         tKyBivnA+3wcgm1K4sOtOxXhL2nUb1AqpTE+sVf+daNWnIJFu94eTj7fqm91uRtV80C3
         3RNuD82Tk9WZiNNGPNiNRU5F6FUZKyiUaYCrDo/lVIhE8mO1MofLSSfGq1oCxU1xna47
         bU7xOohdANLdra+nrZwSJ9I+r4ldFSW+gvAeHIFtbRD8AVrdLeo+OCowLpK/uQ5F7IAn
         /SWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780414783; x=1781019583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFxuTfObIS5kNIa/g+jesmeajMd2HNasePUY4XZFIUQ=;
        b=S74syvFgDr/VD+jiM9VjlGVI5gQisnM2Q4CxFMG2eHd6W8LxfojRXAVyFAvtDR40t6
         +2QzInOvyoFkg9DpHURJZb1cl7h/nJsOCboJ+JZ9G+vataOW2C/JQgl/wAYnYC+/rkDJ
         r2pzSvxfMjiXY9GzUxZz1wxsoJjbadNW+pdwJhaANZ0tEocVBtHnxD1bEahzZnQ80wgC
         oItudfl1yRlHXnZPIg9qWsEPCY18R1q4bbOthHxRpy7RMcIRZ4MHslLd9j1g1sUvSV7R
         0SiN+8hcU6IBmSFWrfVeI48NARqo+FhWNZBgGsJvRSw7KWN2atqAkuAyMkx9We+7oYen
         ka6A==
X-Forwarded-Encrypted: i=1; AFNElJ8nEhBRtCWK6y8H4jGG5Q4CrUltJ9jMlMXVCAN0ZdfMYtDvaSIMf/+qwCljW9N9sOKNca737qIVMt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLRWFY09Dsw3rwx3GPoc/2I2C8iWn5Fw6Qp4niPdgvR+SE7L8o
	tYN2PaTSGEobqM63xfMGb1LoO/cYJxFSxp6wUXmg5M7AxytFhbhE/R9CvBAkLoTeHJQ=
X-Gm-Gg: Acq92OH0beSFi3zn2xHSRJ+BxcKBTcOHWvaN/CxH9H5j+zUwcO8Z2nYMagao5ysBYP3
	bE/9CRXW6ax6sk2jRinmiEooIrhRGjryhTwsY+jzfjv41fLy+TRId7HdPI6lpFgrlcodAM8K30M
	B+Qg4qirBcgPkGviYfxuR82jLhol4OOKg4V6JzLcgQpVP0w2JCNsiwsr464cVA94fQlQuFO5X1x
	e53dbHr+4C9QPsmPDZJyWfBbS8BXlW7satUq/dds8dDvou9ymeVxfibTL8AK0p0VN6pTZ6dk0pm
	6CL7/ppTQgSzAG58nLpJVZEBDsMiOB2eNThSLwAmABO+2DxZeoZ2ncbcxy6HPrEeTDgrGTkKKWM
	NAEBOtapBRdw80UN8bWAg+xZQ6C2gTMTsVLYSm/DnK613n5RYy0fARM3WSaCWmsOlbpqqOmdUq+
	BkSYcsua3wPPNemI+n3fRGNhYmAZilRLWJGve5LA==
X-Received: by 2002:a05:6102:3754:b0:5ff:c5c8:2734 with SMTP id ada2fe7eead31-6ea2cd9b752mr361252137.25.1780414783445;
        Tue, 02 Jun 2026 08:39:43 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8ccea216beesm120744206d6.39.2026.06.02.08.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 08:39:42 -0700 (PDT)
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
Subject: [PATCH] iio: adc: ad7380: select REGMAP
Date: Tue,  2 Jun 2026 15:39:26 +0000
Message-ID: <20260602153926.1540911-1-sam.moelius@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Samuel Moelius <samuel.moelius@trailofbits.com>

The AD7380 driver uses generic regmap types and APIs. However, its Kconfig entry does not select REGMAP.

As a result, AD7380 can be enabled from an allnoconfig-derived config with SPI_MASTER=y while REGMAP remains unset, causing ad7380.o to fail to build.

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

