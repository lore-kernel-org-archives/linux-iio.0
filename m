Return-Path: <SRS0=7Css=7D=linux-mips.org=ladis@kernel.org>
Date: Tue, 1 Aug 2017 10:26:05 +0200
Sender: Ladislav Michl <ladis@linux-mips.org>
From: Ladislav Michl <ladis@linux-mips.org>
To: linux-iio@vger.kernel.org
Cc: Daniel Baluta <daniel.baluta@intel.com>,
        Matt Ranostay <matt.ranostay@intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/2] iio: adc: ti-ads1015: fix conversion time
Message-ID: <20170801082605.kxzqtnrbt6glplmu@lenoch>
References: <20170801082521.namcrs4wyufwqyuh@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170801082521.namcrs4wyufwqyuh@lenoch>
List-ID: <linux-iio@vger.kernel.org>

When reading diffrent channel value than device is currently processing
wait time of conversion period is applied, which is not enough as device
might be already in the middle of conversion and therefore previously
converted value is returned - the one belonging to another channel.
Fix it by waiting for two sampling periods.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/iio/adc/ti-ads1015.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 884b8e461b17..86fd2753869d 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -260,7 +260,7 @@ int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
 		return ret;
 
 	if (change) {
-		conv_time = DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr]);
+		conv_time = 2 * DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr]);
 		usleep_range(conv_time, conv_time + 1);
 	}
 
-- 
2.11.0
