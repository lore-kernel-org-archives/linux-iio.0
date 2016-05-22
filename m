Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:60495 "EHLO
	baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbcEVJGr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 May 2016 05:06:47 -0400
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH 45/54] MAINTAINERS: Add file patterns for staging iio device tree bindings
Date: Sun, 22 May 2016 11:06:22 +0200
Message-Id: <1463907991-7916-46-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
---
Please apply this patch directly if you want to be involved in device
tree binding documentation for your subsystem.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f11355314880838b..5c96827ea93d5d7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10867,6 +10867,7 @@ STAGING - INDUSTRIAL IO
 M:	Jonathan Cameron <jic23@kernel.org>
 L:	linux-iio@vger.kernel.org
 S:	Odd Fixes
+F:	Documentation/devicetree/bindings/staging/iio/
 F:	drivers/staging/iio/
 
 STAGING - LIRC (LINUX INFRARED REMOTE CONTROL) DRIVERS
-- 
1.9.1

