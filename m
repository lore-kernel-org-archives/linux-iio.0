Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 4/8] iio:magnetometer:bmc150_magn: replace magic value
Date: Fri, 17 Jul 2015 10:52:27 +0200
Message-Id: <10d009333e7ce8c43f17c50c03a1f3d0a1dda11f.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437090791.git.knaack.h@gmx.de>
References: <cover.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437090791.git.knaack.h@gmx.de>
References: <cover.1437090791.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Construct the scanmask using its descriptive axis names (as used in
iio_chan_spec) instead of a 'magic' value.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
Does this look better?

 drivers/iio/magnetometer/bmc150_magn.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 7da4ce9409e8..f1b6a4dc40ea 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -651,7 +651,9 @@ static const struct iio_info bmc150_magn_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static const unsigned long bmc150_magn_scan_masks[] = {0x07, 0};
+static const unsigned long bmc150_magn_scan_masks[] = {
+					BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
+					0};
 
 static irqreturn_t bmc150_magn_trigger_handler(int irq, void *p)
 {
-- 
2.4.3
