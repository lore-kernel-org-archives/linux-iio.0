Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 2/9] iio: core: Add misssing braces
Date: Thu, 24 Oct 2013 17:23:28 +0530
Message-Id: <1382615615-20153-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382615615-20153-1-git-send-email-sachin.kamat@linaro.org>
References: <1382615615-20153-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Silences the following checkpatch warning:
WARNING: sizeof *iio_attr should be sizeof(*iio_attr)

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/industrialio-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e4780b4..18f72e3 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -685,7 +685,7 @@ int __iio_add_chan_devattr(const char *postfix,
 	int ret;
 	struct iio_dev_attr *iio_attr, *t;
 
-	iio_attr = kzalloc(sizeof *iio_attr, GFP_KERNEL);
+	iio_attr = kzalloc(sizeof(*iio_attr), GFP_KERNEL);
 	if (iio_attr == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
-- 
1.7.9.5
