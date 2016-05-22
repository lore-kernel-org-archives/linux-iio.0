Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:34499 "EHLO
	xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbcEVJGt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 May 2016 05:06:49 -0400
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
Subject: [PATCH 20/54] MAINTAINERS: Add file patterns for iio device tree bindings
Date: Sun, 22 May 2016 11:05:57 +0200
Message-Id: <1463907991-7916-21-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
---
Please apply this patch directly if you want to be involved in device
tree binding documentation for your subsystem.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd7793520e2cccfc..5cf50bf461c4255e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5786,6 +5786,7 @@ R:	Lars-Peter Clausen <lars@metafoo.de>
 R:	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/
 F:	drivers/iio/
 F:	drivers/staging/iio/
 F:	include/linux/iio/
-- 
1.9.1

