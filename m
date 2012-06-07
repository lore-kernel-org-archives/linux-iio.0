Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:32891 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755957Ab2FGNL6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 7 Jun 2012 09:11:58 -0400
Received: from sirene.lan (83-215-0-241.stadt.dyn.salzburg-online.at [83.215.0.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pmeerw)
	by pmeerw.net (Postfix) with ESMTPSA id 16B0EC50173
	for <linux-iio@vger.kernel.org>; Thu,  7 Jun 2012 15:11:57 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Subject: [PATCH] iio: fix tsl2* file mode
Date: Thu,  7 Jun 2012 15:11:56 +0200
Message-Id: <1339074716-20970-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

just drop execute permission

---
 0 files changed
 mode change 100755 => 100644 drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583
 mode change 100755 => 100644 drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2x7x
 mode change 100755 => 100644 drivers/staging/iio/light/tsl2x7x.h
 mode change 100755 => 100644 drivers/staging/iio/light/tsl2x7x_core.c

diff --git a/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583 b/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583
old mode 100755
new mode 100644
diff --git a/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2x7x b/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2x7x
old mode 100755
new mode 100644
diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
old mode 100755
new mode 100644
diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
old mode 100755
new mode 100644
-- 
1.7.9.5

