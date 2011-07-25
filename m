Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:59443 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673Ab1GYLah (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2011 07:30:37 -0400
Message-ID: <4E2D53E1.90305@cam.ac.uk>
Date: Mon, 25 Jul 2011 12:30:41 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
CC: linux-iio@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] staging: (iio) restore macro IIO_ATTR_2
References: <1311373619-19188-1-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1311373619-19188-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/22/11 23:26, Vivien Didelot wrote:
> For some reason, IIO_ATTR_2 has been deleted by commit
> 99e5dc45b854b4b661044e807905152911ed3fdb but it is still used by the macro
> IIO_DEVICE_ATTR_2. This patch restores it.
> Please ignore it if it shouldn't exist anymore. If so, this would need to
> remove IIO_DEVICE_ATTR_2 as well. Obviously it seems to be useful as the struct
> iio_dev_attr has a val2 member.
Good spot.  Do you have a user for the two parameter version?  If not
I'd prefer to just scrap the IIO_DEVICE_ATTR_2 until we actually need it.
That also means we can scrap val2 from struct iio_dev_attr which is a nice
little clean up.  How about the following?

Looking at it this structure could put address and the chan_spec
pointer in the same memory as they are never used together.
Different issue though so that can be in a later patch.

Thanks,

Jonathan


Subject: [PATCH] staging:iio: sysfs.h remove unused val2 and dead macro.

Vivien pointed out that 99e5dc45b854b4b661044e807905152911ed3fdb
removed the IIO_DEVICE_ATTR_2 macro but didn't clean up the other
macros that used it.

As it turns out, no one is using val2 in tree, so lets scrap that
until it is needed.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Reported-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/staging/iio/sysfs.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index cecc7ec..9e0b67c 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -18,13 +18,11 @@
  * struct iio_dev_attr - iio specific device attribute
  * @dev_attr:	underlying device attribute
  * @address:	associated register address
- * @val2:	secondary attribute value
  * @l:		list head for maintaining list of dynamically created attrs.
  */
 struct iio_dev_attr {
 	struct device_attribute dev_attr;
 	int address;
-	int val2;
 	struct list_head l;
 	struct iio_chan_spec const *c;
 };
@@ -64,10 +62,6 @@ struct iio_const_attr {
 	struct iio_dev_attr iio_dev_attr_##_vname			\
 	= IIO_ATTR(_name, _mode, _show, _store, _addr)
 
-#define IIO_DEVICE_ATTR_2(_name, _mode, _show, _store, _addr, _val2)	\
-	struct iio_dev_attr iio_dev_attr_##_name			\
-	= IIO_ATTR_2(_name, _mode, _show, _store, _addr, _val2)
-
 #define IIO_CONST_ATTR(_name, _string)					\
 	struct iio_const_attr iio_const_attr_##_name			\
 	= { .string = _string,						\
-- 
1.7.3.4

