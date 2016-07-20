Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:41189 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753064AbcGTI3y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jul 2016 04:29:54 -0400
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, maxime.ripard@free-electrons.com, wens@csie.org,
	dmitry.torokhov@gmail.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
	antoine.tenart@free-electrons.com,
	thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org
Subject: [PATCH 2/5] mfd: sunxi-gpadc-mfd: add buffer structure
Date: Wed, 20 Jul 2016 10:29:08 +0200
Message-Id: <1469003351-15263-3-git-send-email-quentin.schulz@free-electrons.com>
In-Reply-To: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds a buffer structure for files including the sunxi-gpadc-mfd
header. This structure has a buffer of 32 u32 values to store data from the
FIFO of the GPADC of Allwinner SoCs. A buff_size is provided in case the
buffer is not full.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 include/linux/mfd/sunxi-gpadc-mfd.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mfd/sunxi-gpadc-mfd.h b/include/linux/mfd/sunxi-gpadc-mfd.h
index 7155845..f658299 100644
--- a/include/linux/mfd/sunxi-gpadc-mfd.h
+++ b/include/linux/mfd/sunxi-gpadc-mfd.h
@@ -20,4 +20,9 @@ struct sunxi_gpadc_mfd_dev {
 	void __iomem			*regs;
 };
 
+struct sunxi_gpadc_buffer {
+	u32				buffer[32];
+	unsigned int			buff_size;
+};
+
 #endif
-- 
2.5.0

