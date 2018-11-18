Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f170.google.com ([209.85.222.170]:40535 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeKROpd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Nov 2018 09:45:33 -0500
Received: by mail-qk1-f170.google.com with SMTP id y16so43866346qki.7
        for <linux-iio@vger.kernel.org>; Sat, 17 Nov 2018 20:26:32 -0800 (PST)
From: Matheus Tavares <matheus.bernardino@usp.br>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: [PATCH v2 5/7] staging:iio:ad2s90: Replace license text w/ SPDX identifier
Date: Sun, 18 Nov 2018 02:25:38 -0200
Message-Id: <20181118042540.12697-6-matheus.bernardino@usp.br>
In-Reply-To: <20181118042540.12697-1-matheus.bernardino@usp.br>
References: <20181118042540.12697-1-matheus.bernardino@usp.br>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch removes the license boilerplate text at the top of ad2s90.c
and, instead, adds the SPDX GPL-2.0 license identifier, which solves the
checkpatch.pl warning:
"WARNING: Missing or malformed SPDX-License-Identifier tag in line 1".

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
Changes in v2:
 - Changed GPL-2.0-only identifier to GPL-2.0
 - Removed license boilerplate text
 - Rewritten patch message to reflect these modifications

 drivers/staging/iio/resolver/ad2s90.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index fe90f2056bff..9aa229ba47e7 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ad2s90.c simple support for the ADI Resolver to Digital Converters: AD2S90
  *
  * Copyright (c) 2010-2010 Analog Devices Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 #include <linux/types.h>
 #include <linux/mutex.h>
-- 
2.18.0
