Return-Path: <rodriguez.twister@gmail.com>
From: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	driverdev-devel@linuxdriverproject.org,
	linux-iio@vger.kernel.org
Cc: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
Subject: [PATCH 2/2] staging: iio_simple_dummy: zero check param 
Date: Wed, 27 May 2015 01:19:58 +0300
Message-Id: <1432678798-22903-2-git-send-email-rodriguez.twister@gmail.com>
In-Reply-To: <1432678798-22903-1-git-send-email-rodriguez.twister@gmail.com>
References: <1432678798-22903-1-git-send-email-rodriguez.twister@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Check for zero was added to the module parameter "instances" to
avoid the allocation of array of zero values. Although it is a valid call,
we don't want to allocate ZERO_SIZE_PTR, so need to disallow this case.
The type of variables which are compared to "instances" were also changed
to unsigned int so that no compiler complaints occur.

Signed-off-by: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
---
 drivers/staging/iio/iio_simple_dummy.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index 88fbb4f..2744a1b 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -30,7 +30,7 @@
  * dummy devices are registered.
  */
 static unsigned instances = 1;
-module_param(instances, int, 0);
+module_param(instances, uint, 0);
 
 /* Pointer array used to fake bus elements */
 static struct iio_dev **iio_dummy_devs;
@@ -706,9 +706,10 @@ static void iio_dummy_remove(int index)
  */
 static __init int iio_dummy_init(void)
 {
-	int i, ret;
+	unsigned int i;
+	int ret;
 
-	if (instances > 10) {
+	if (instances == 0 || instances > 10) {
 		instances = 1;
 		return -EINVAL;
 	}
@@ -742,7 +743,7 @@ module_init(iio_dummy_init);
  */
 static __exit void iio_dummy_exit(void)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < instances; i++)
 		iio_dummy_remove(i);
-- 
2.4.1
