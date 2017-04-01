Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33152 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdDAOSm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2017 10:18:42 -0400
Date: Sat, 1 Apr 2017 19:48:39 +0530
From: simran singhal <singhalsimran0@gmail.com>
To: jic23@kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: pressure: zpa2326: Remove unnecessary cast on void
 pointer
Message-ID: <20170401141838.GA748@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following Coccinelle script was used to detect this:
@r@
expression x;
void* e;
type T;
identifier f;
@@
(
  *((T *)e)
|
  ((T *)x)[...]
|
  ((T*)x)->f
|
- (T*)
  e
)

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/iio/pressure/zpa2326.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index c720c3a..e58a0ad 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -751,7 +751,7 @@ static void zpa2326_suspend(struct iio_dev *indio_dev)
  */
 static irqreturn_t zpa2326_handle_irq(int irq, void *data)
 {
-	struct iio_dev *indio_dev = (struct iio_dev *)data;
+	struct iio_dev *indio_dev = data;
 
 	if (iio_buffer_enabled(indio_dev)) {
 		/* Timestamping needed for buffered sampling only. */
@@ -790,7 +790,7 @@ static irqreturn_t zpa2326_handle_irq(int irq, void *data)
  */
 static irqreturn_t zpa2326_handle_threaded_irq(int irq, void *data)
 {
-	struct iio_dev         *indio_dev = (struct iio_dev *)data;
+	struct iio_dev         *indio_dev = data;
 	struct zpa2326_private *priv = iio_priv(indio_dev);
 	unsigned int            val;
 	bool                    cont;
-- 
2.7.4

