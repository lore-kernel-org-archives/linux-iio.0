Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:59145 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752552AbbETPXd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 20 May 2015 11:23:33 -0400
From: Xander Huff <xander.huff@ni.com>
To: lars@metafoo.de, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org
Cc: michal.simek@xilinx.com, soren.brinkmann@xilinx.com,
	jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, ben.shelton@ni.com, joshc@ni.com,
	joe.hershberger@ni.com, Xander Huff <xander.huff@ni.com>
Subject: [PATCH v2 2/2] iio: adc: xilinx-xadc: Add label as an optional argument for aux channels
Date: Wed, 20 May 2015 10:22:32 -0500
Message-Id: <1432135352-29848-2-git-send-email-xander.huff@ni.com>
In-Reply-To: <1432135352-29848-1-git-send-email-xander.huff@ni.com>
References: <555B78A3.2030202@metafoo.de>
 <1432135352-29848-1-git-send-email-xander.huff@ni.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

To better facilitate user-mode access to optional aux channels, allow
device trees to specify a custom label for defined channels.

Signed-off-by: Xander Huff <xander.huff@ni.com>
Reviewed-by: Joe Hershberger <joe.hershberger@ni.com>
Reviewed-by: Josh Cartwright <joshc@ni.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index ce93bd8..bda4241 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1119,6 +1119,9 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 			if (ret || reg > 16)
 				continue;
 
+			of_property_read_string(child, "label",
+						&chan->extend_name);
+
 			if (of_property_read_bool(child, "xlnx,bipolar"))
 				chan->scan_type.sign = 's';
 
-- 
1.9.1

