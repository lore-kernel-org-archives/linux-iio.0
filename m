Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: daniel.baluta@intel.com,
	viorel.suman@intel.com,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iio: magnetometer: mmc35240: Fix crash in pm suspend
Date: Tue, 14 Jul 2015 17:56:52 +0300
Message-Id: <1436885814-29155-2-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1436885814-29155-1-git-send-email-daniel.baluta@intel.com>
References: <1436885814-29155-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

We must set i2c client private data at probe in order to
correctly retrieve it in pm suspend/resume, preventing
the following crash:

[ 321.790582] PM: Syncing filesystems ... done.
[ 322.364440] PM: Preparing system for mem sleep
[ 322.400047] PM: Entering mem sleep
[ 322.462178] BUG: unable to handle kernel NULL pointer dereference at 0000036c
[ 322.469119] IP: [<80e0b3d2>] mmc35240_suspend+0x12/0x30
[ 322.474291] *pdpt = 000000002fd6f001 *pde = 0000000000000000
[ 322.479967] Oops: 0000 1 PREEMPT SMP
[ 322.496516] task: a86d0df0 ti: a8766000 task.ti: a8766000
[ 322.570744] Call Trace:
[ 322.573217] [<80c0d2d1>] pm_generic_suspend+0x21/0x30
[ 322.578284] [<80d042ab>] i2c_device_pm_suspend+0x1b/0x30

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/magnetometer/mmc35240.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 7a2ea71..e89b059 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -496,6 +496,7 @@ static int mmc35240_probe(struct i2c_client *client,
 	}
 
 	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 	data->regmap = regmap;
 	data->res = MMC35240_16_BITS_SLOW;
-- 
1.9.1
