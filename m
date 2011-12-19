Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]:23966
	"EHLO AM1EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752322Ab1LSLxc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 19 Dec 2011 06:53:32 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@kernel.org>, <devel@driverdev.osuosl.org>,
	<linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio: Remove unused variable
Date: Mon, 19 Dec 2011 12:54:07 +0100
Message-ID: <1324295647-25993-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

=46ixes the following warning:
	drivers/staging/iio/industrialio-buffer.c: In function =E2=80=98iio_sc=
an_mask_query=E2=80=99:
	drivers/staging/iio/industrialio-buffer.c:620: warning: unused variabl=
e =E2=80=98mask=E2=80=99

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/industrialio-buffer.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/stagin=
g/iio/industrialio-buffer.c
index a03a574..68db2d2 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -617,8 +617,6 @@ EXPORT_SYMBOL_GPL(iio_scan_mask_set);
 int iio_scan_mask_query(struct iio_dev *indio_dev,
 			struct iio_buffer *buffer, int bit)
 {
-	long *mask;
-
 	if (bit > indio_dev->masklength)
 		return -EINVAL;
=20
--=20
1.7.7.3


