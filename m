Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:45997 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991AbcCYWqT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2016 18:46:19 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Alan Tull <atull@opensource.altera.com>,
	Moritz Fischer <moritz.fischer@ettus.com>
Subject: [PATCH 7/8] fpga: Fix zynq-fpga dependencies
Date: Fri, 25 Mar 2016 23:40:54 +0100
Message-Id: <1458945655-5027-7-git-send-email-richard@nod.at>
In-Reply-To: <1458945655-5027-1-git-send-email-richard@nod.at>
References: <1458945655-5027-1-git-send-email-richard@nod.at>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Not all archs have DMA.

Fixes the following build error:
ERROR: "devm_ioremap_resource" [drivers/fpga/zynq-fpga.ko] undefined!

Cc: Alan Tull <atull@opensource.altera.com>
Cc: Moritz Fischer <moritz.fischer@ettus.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/fpga/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index c9b9fdf..490ecf0 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -20,6 +20,7 @@ config FPGA_MGR_SOCFPGA
 	  FPGA manager driver support for Altera SOCFPGA.
 
 config FPGA_MGR_ZYNQ_FPGA
+	depends on HAS_DMA
 	tristate "Xilinx Zynq FPGA"
 	help
 	  FPGA manager driver support for Xilinx Zynq FPGAs.
-- 
1.8.4.5

