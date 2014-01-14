Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from b.ns.miles-group.at ([95.130.255.144]:1665 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751850AbaANPqO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 14 Jan 2014 10:46:14 -0500
From: Richard Weinberger <richard@nod.at>
To: kishon@ti.com, anton@enomsg.org, dwmw2@infradead.org,
	richardcochran@gmail.com, lidza.louina@gmail.com,
	gregkh@linuxfoundation.org, jic23@kernel.org, davem@davemloft.net
Cc: sebastian.hesselbarth@gmail.com, florian@openwrt.org,
	thomas.petazzoni@free-electrons.com, lars@metafoo.de,
	marex@denx.de, acourbot@nvidia.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	driverdev-devel@linuxdriverproject.org, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/7] staging,dgap: Add dependency on HAS_IOMEM
Date: Tue, 14 Jan 2014 16:45:40 +0100
Message-Id: <1389714345-20165-2-git-send-email-richard@nod.at>
In-Reply-To: <1389714345-20165-1-git-send-email-richard@nod.at>
References: <1389714345-20165-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On archs like S390 or um this driver cannot build nor work.
Make it depend on HAS_IOMEM to bypass build failures.

drivers/staging/dgap/dgap_driver.c: In function ‘dgap_cleanup_board’:
drivers/staging/dgap/dgap_driver.c:457:3: error: implicit declaration of function ‘iounmap’ [-Werror=implicit-function-declaration]
drivers/staging/dgap/dgap_driver.c: In function ‘dgap_do_remap’:
drivers/staging/dgap/dgap_driver.c:694:2: error: implicit declaration of function ‘ioremap’ [-Werror=implicit-function-declaration]

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/staging/dgap/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/dgap/Kconfig b/drivers/staging/dgap/Kconfig
index 31f1d75..3bbe9e1 100644
--- a/drivers/staging/dgap/Kconfig
+++ b/drivers/staging/dgap/Kconfig
@@ -1,6 +1,6 @@
 config DGAP
        tristate "Digi EPCA PCI products"
        default n
-       depends on TTY
+       depends on TTY && HAS_IOMEM
        ---help---
        Driver for the Digi International EPCA PCI based product line
-- 
1.8.1.4

