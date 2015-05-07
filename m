Return-Path: <xander.huff@ni.com>
From: Xander Huff <xander.huff@ni.com>
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: michal.simek@xilinx.com, soren.brinkmann@xilinx.com, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, ben.shelton@ni.com, joshc@ni.com,
        joe.hershberger@ni.com, Xander Huff <xander.huff@ni.com>
Subject: [PATCH 2/2] iio: adc: xilinx-xadc: Add xlnx,extend-name as an optional argument for aux channels
Date: Thu, 7 May 2015 17:44:04 -0500
Message-Id: <1431038644-41600-2-git-send-email-xander.huff@ni.com>
In-Reply-To: <1431038644-41600-1-git-send-email-xander.huff@ni.com>
References: <1431038644-41600-1-git-send-email-xander.huff@ni.com>
List-ID: <linux-iio@vger.kernel.org>

To better facilitate user-mode access to optional aux channels, allow
device trees to specify a custom extended name for defined channels.

Signed-off-by: Xander Huff <xander.huff@ni.com>
Reviewed-by: Joe Hershberger <joe.hershberger@ni.com>
Reviewed-by: Josh Cartwright <joshc@ni.com>
--
Natinst-ReviewBoard-ID: 97119
---
 drivers/iio/adc/xilinx-xadc-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index a221f73..cf1d2f9 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1118,6 +1118,9 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 			if (ret || reg > 16)
 				continue;
 
+			of_property_read_string(child, "xlnx,extend-name",
+						&chan->extend_name);
+
 			if (of_property_read_bool(child, "xlnx,bipolar"))
 				chan->scan_type.sign = 's';
 
-- 
1.9.1
