Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56997 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbcGCJSL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2016 05:18:11 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: nicolas.iooss_linux@m4x.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio: Add iio.git tree to MAINTAINERS
Date: Sun,  3 Jul 2016 10:18:03 +0100
Message-Id: <20160703091803.20451-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The tree has been in the same location for a long time.  Putting it in
MAINTAINERS makes it easy for those new to, or less familiar with IIO
to find the correct tree to base patches on.

Mostly basing on staging-next is fine as well unless working on a very
active driver.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c1e4bf3ea8ec..345e75744439 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5785,6 +5785,7 @@ R:	Hartmut Knaack <knaack.h@gmx.de>
 R:	Lars-Peter Clausen <lars@metafoo.de>
 R:	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
 L:	linux-iio@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/
 F:	drivers/iio/
-- 
2.9.0

