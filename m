Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org,
	greg@kroah.com
Cc: Stephen Warren <swarren@nvidia.com>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 13/14] staging:iio:magnetometer:ak8975: Fix probe() error-handling
Date: Tue, 20 Sep 2011 17:11:12 +0100
Message-Id: <1316535073-21444-14-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316535073-21444-1-git-send-email-jic23@cam.ac.uk>
References: <1316535073-21444-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Stephen Warren <swarren@nvidia.com>

Fix ak8975_probe() to jump to the appropriate exit labels when an error
occurs. With the previous code, some cleanup actions were being skipped
for some error conditions.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Andrew Chew <achew@nvidia.com>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/magnetometer/ak8975.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index 9c53383..ab0e26c 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -513,7 +513,7 @@ static int ak8975_probe(struct i2c_client *client,
 	err = ak8975_setup(client);
 	if (err < 0) {
 		dev_err(&client->dev, "AK8975 initialization fails\n");
-		goto exit_gpio;
+		goto exit_free_iio;
 	}
 
 	i2c_set_clientdata(client, indio_dev);
-- 
1.7.3.4
