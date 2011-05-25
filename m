Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] iio: industrialio-trigger: set iio_poll_func private_data
Date: Wed, 25 May 2011 12:39:12 +0200
Message-ID: <1306319952-24722-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Failure to set iio_poll_func private_data, causes zero pointer access
violations in all consumer trigger handlers.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/industrialio-trigger.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 6159023..d504aa2 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -294,6 +294,7 @@ struct iio_poll_func
 	pf->h = h;
 	pf->thread = thread;
 	pf->type = type;
+	pf->private_data = private;
 
 	return pf;
 }
-- 
1.7.0.4
