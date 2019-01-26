Return-Path: <SRS0=WfKE=QC=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C9EC282C7
	for <linux-iio@archiver.kernel.org>; Sat, 26 Jan 2019 17:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10725218A2
	for <linux-iio@archiver.kernel.org>; Sat, 26 Jan 2019 17:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWojG2xt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfAZRiD (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 26 Jan 2019 12:38:03 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34394 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfAZRiD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Jan 2019 12:38:03 -0500
Received: by mail-qk1-f196.google.com with SMTP id q8so7263674qke.1
        for <linux-iio@vger.kernel.org>; Sat, 26 Jan 2019 09:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PqhEu0aa8F7y+O/p5b1EdMF3rLzE2XilArnGOx2kaR8=;
        b=JWojG2xtcyAMFIvc5VEWD1XSUrW5UmtzRtCQjLfiUEqcrEC91MLTmNgrmeTbWeBlyw
         /8CvEmXu8A3Jl0IgAvm2p3PxF9yIE3bmhF2Tv5zMjbNryqhsVon7g/ZIDHfmd6bWM3TO
         Aq1qE22HkUzW4a3LWh5UOyr+2o4fUn0y2u8EKpbcPTyivv3PRutAjcEkr5MXaR1Anj0N
         I0qWQmnDPng0bzZTubgWkxOTn3zMC64ppQdFfPF3w2nP6X/jFUp1N7aRaHLMtvslElNf
         r1vbP9Bb1DJtGIuu0l9QSHwmUIZLMf/ZT/ReHZk7TGr75GBCIqBoFapt9KRdeZNUDXuJ
         slzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PqhEu0aa8F7y+O/p5b1EdMF3rLzE2XilArnGOx2kaR8=;
        b=JS7fHQhKYSoo8VHxbMONKYaay7vKqTy5+TMAInuRgPU29TV0h+PvVrFBgktnaWNIS5
         /O2aEZD/btJIm/g5nvVH7RzqHGAKlFFF4UdunJujwoCQMB/PFJq0BCWEeTXoDglL+zRI
         33Qw1X347gfXC19571ehfHeNzXNplFVgr3EzzizsddHwnguKtBHuJlLYJYKZ9QrGuVY4
         XFcDfQrDaWd4fPadDDEEecRmehQlP9V1MYP6MhJnpf+EzEs1L3n0Y3nNSpjQZrQq30ca
         RbDvkTac5rN5906nq2y5d/8cgNWuhxJs2OvwotLJ/JA7IjLbkBlZEB3uS2XRcDplE5Qd
         Uo7w==
X-Gm-Message-State: AJcUukdVDhaDSAy9A7Avz8QjUbpuqKE/kbxRzrjFduhH/91DITgmZJQN
        oh+bHrmr6/uVnLr3j6Irqk9XpqGrJp4=
X-Google-Smtp-Source: ALg8bN6c0R035D0EmAOdne9IgBR/j+ZKbXDg7BIeG2PwOLoGuZ/AovmjoBw+JVx14HSTaFbO8P59cA==
X-Received: by 2002:a37:6982:: with SMTP id e124mr14240645qkc.50.1548524281958;
        Sat, 26 Jan 2019 09:38:01 -0800 (PST)
Received: from archfcr.localdomain ([177.139.38.48])
        by smtp.gmail.com with ESMTPSA id y2sm83317923qtb.88.2019.01.26.09.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 09:38:01 -0800 (PST)
Date:   Sat, 26 Jan 2019 15:37:53 -0200
From:   Felipe Cardoso Resende <felipecardoso.fcr@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH] drivers: staging: iio: adc: Include SPDX Identifier
Message-ID: <20190126173746.GA7100@archfcr.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Remove warning found by checkpatch.pl by including SPDX Identifier

Signed-off-by: Felipe Cardoso Resende <felipecardoso.fcr@gmail.com>
---
 drivers/staging/iio/adc/ad7192.c     | 3 +--
 drivers/staging/iio/adc/ad7192.h     | 5 ++---
 drivers/staging/iio/adc/ad7280a.c    | 3 +--
 drivers/staging/iio/adc/ad7280a.h    | 5 ++---
 drivers/staging/iio/adc/ad7606.c     | 3 +--
 drivers/staging/iio/adc/ad7606.h     | 5 ++---
 drivers/staging/iio/adc/ad7606_par.c | 3 +--
 drivers/staging/iio/adc/ad7606_spi.c | 3 +--
 drivers/staging/iio/adc/ad7780.c     | 3 +--
 drivers/staging/iio/adc/ad7816.c     | 3 +--
 10 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index acdbc07fd259..b01d4cd6bb82 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * AD7190 AD7192 AD7193 AD7195 SPI ADC driver
  *
  * Copyright 2011-2015 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include <linux/interrupt.h>
diff --git a/drivers/staging/iio/adc/ad7192.h b/drivers/staging/iio/adc/ad7192.h
index 7433a43c2611..2a5a55fdd825 100644
--- a/drivers/staging/iio/adc/ad7192.h
+++ b/drivers/staging/iio/adc/ad7192.h
@@ -1,9 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
  * AD7190 AD7192 AD7195 SPI ADC driver
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 #ifndef IIO_ADC_AD7192_H_
 #define IIO_ADC_AD7192_H_
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 14f6a3ced060..c10fdce511a6 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * AD7280A Lithium Ion Battery Monitoring System
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include <linux/crc8.h>
diff --git a/drivers/staging/iio/adc/ad7280a.h b/drivers/staging/iio/adc/ad7280a.h
index ccfb90d20e71..400d47ab3744 100644
--- a/drivers/staging/iio/adc/ad7280a.h
+++ b/drivers/staging/iio/adc/ad7280a.h
@@ -1,9 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
  * AD7280A Lithium Ion Battery Monitoring System
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #ifndef IIO_ADC_AD7280_H_
diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 7308fa8fbb4c..b4a28cddfc91 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * AD7606 SPI ADC driver
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include <linux/interrupt.h>
diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index 86188054b60b..3a57bc5539b6 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -1,9 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
  * AD7606 ADC driver
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #ifndef IIO_ADC_AD7606_H_
diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
index 8bd86e727b02..ec2280f07b78 100644
--- a/drivers/staging/iio/adc/ad7606_par.c
+++ b/drivers/staging/iio/adc/ad7606_par.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * AD7606 Parallel Interface ADC driver
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include <linux/module.h>
diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
index b76ca5a8c059..0b848da3ac08 100644
--- a/drivers/staging/iio/adc/ad7606_spi.c
+++ b/drivers/staging/iio/adc/ad7606_spi.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * AD7606 SPI ADC driver
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include <linux/module.h>
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index c4a85789c2db..88caa6617c74 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * AD7170/AD7171 and AD7780/AD7781 SPI ADC driver
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include <linux/interrupt.h>
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 5209651a1b25..0ac6b3f32d13 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * AD7816 digital temperature sensor driver supporting AD7816/7/8
  *
  * Copyright 2010 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
  */
 
 #include <linux/interrupt.h>
-- 
2.20.1

