Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org,
	greg@kroah.com
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 11/14] staging:iio:magnetometer:ak8975 use platform_data to pass the gpio number.
Date: Wed, 21 Sep 2011 11:15:59 +0100
Message-Id: <1316600162-15581-12-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316600162-15581-1-git-send-email-jic23@cam.ac.uk>
References: <1316600162-15581-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Tegra doesn't have irq_to_gpio() any more, and ak8975 is included in
tegra_defconfig. This causes a build failure. Instead, pass the GPIO name
through platform data.

[swarren: Rewrote commit description when I squashed this with my patch
to remove the irq_to_gpio() call]

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/staging/iio/magnetometer/ak8975.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index 0697ab3..0e66d3f 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -477,7 +477,10 @@ static int ak8975_probe(struct i2c_client *client,
 	int err;
 
 	/* Grab and set up the supplied GPIO. */
-	eoc_gpio = irq_to_gpio(client->irq);
+	if (client->dev.platform_data == NULL)
+		eoc_gpio = -1;
+	else
+		eoc_gpio = *(int *)(client->dev.platform_data);
 
 	/* We may not have a GPIO based IRQ to scan, that is fine, we will
 	   poll if so */
-- 
1.7.3.4
