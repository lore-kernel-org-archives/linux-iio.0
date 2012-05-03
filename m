Return-Path: <axel.lin@gmail.com>
Message-ID: <1336057018.4205.2.camel@phoenix>
Subject: [PATCH] IIO: industrialio-core: Checking NULL instead of IS_ERR for
 debugfs_create_dir()
From: Axel Lin <axel.lin@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Michael Hennerich
 <michael.hennerich@analog.com>, linux-iio@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 03 May 2012 22:56:58 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

If defined CONFIG_DEBUG_FS, debugfs_create_dir returns NULL on failure.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/iio/industrialio-core.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 72e33b8..c74412b 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -235,15 +235,12 @@ static int iio_device_register_debugfs(struct iio_dev *indio_dev)
 	if (indio_dev->info->debugfs_reg_access == NULL)
 		return 0;
 
-	if (IS_ERR(iio_debugfs_dentry))
+	if (!iio_debugfs_dentry)
 		return 0;
 
 	indio_dev->debugfs_dentry =
 		debugfs_create_dir(dev_name(&indio_dev->dev),
 				   iio_debugfs_dentry);
-	if (IS_ERR(indio_dev->debugfs_dentry))
-		return PTR_ERR(indio_dev->debugfs_dentry);
-
 	if (indio_dev->debugfs_dentry == NULL) {
 		dev_warn(indio_dev->dev.parent,
 			 "Failed to create debugfs directory\n");
-- 
1.7.5.4
