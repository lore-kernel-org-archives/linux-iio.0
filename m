Return-Path: <weiyj.lk@gmail.com>
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Giorgio Dal Molin <giorgio.nicole@arcor.de>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Crt Mori <cmo@melexis.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH -next] iio: adc: ti-ads1015: add missing of_node_put() in ads1015_get_channels_config_of()
Date: Fri, 26 Aug 2016 14:31:50 +0000
Message-Id: <1472221910-661-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

When terminating for_each_child_of_node() iteration with
break or return, of_node_put() should be used to prevent
stale device node references from being left behind.

This is detected by Coccinelle semantic patch.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iio/adc/ti-ads1015.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 066abaf..cde6f13 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -522,6 +522,7 @@ static int ads1015_get_channels_config_of(struct i2c_client *client)
 			if (pga > 6) {
 				dev_err(&client->dev, "invalid gain on %s\n",
 					node->full_name);
+				of_node_put(node);
 				return -EINVAL;
 			}
 		}
@@ -532,6 +533,7 @@ static int ads1015_get_channels_config_of(struct i2c_client *client)
 				dev_err(&client->dev,
 					"invalid data_rate on %s\n",
 					node->full_name);
+				of_node_put(node);
 				return -EINVAL;
 			}
 		}
