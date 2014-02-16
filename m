Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:56362 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697AbaBPL5T (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 16 Feb 2014 06:57:19 -0500
Received: from [192.168.0.80] ([178.12.50.63]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MIPhr-1WJ88x23TD-0049mz for
 <linux-iio@vger.kernel.org>; Sun, 16 Feb 2014 12:57:17 +0100
Message-ID: <5300A79B.6060209@gmx.de>
Date: Sun, 16 Feb 2014 12:57:15 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: [PATCH]staging:iio:ad799x fix typo in copyright message
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix a typo in the copyright message.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 13a944f..570c594 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -1,6 +1,6 @@
 /*
  * iio/adc/ad799x.c
- * Copyright (C) 2010-1011 Michael Hennerich, Analog Devices Inc.
+ * Copyright (C) 2010-2011 Michael Hennerich, Analog Devices Inc.
  *
  * based on iio/adc/max1363
  * Copyright (C) 2008-2010 Jonathan Cameron
