Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 10/12] staging:iio: in case of buggy drivers avoid using undefined mask.
Date: Fri, 12 Aug 2011 16:55:36 +0100
Message-Id: <1313164538-1769-11-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313164538-1769-1-git-send-email-jic23@cam.ac.uk>
References: <1313164538-1769-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 8bee562..e8ad648 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -958,6 +958,7 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 			break;
 		default:
 			printk(KERN_INFO "currently unhandled type of event\n");
+			continue;
 		}
 		ret = __iio_add_chan_devattr(postfix,
 					     NULL,
-- 
1.7.3.4
