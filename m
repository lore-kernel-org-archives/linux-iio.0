Return-Path: <greg@kroah.com>
Subject: patch staging-iio-function-iio_get_new_idr_val-return-negative-value-if-fails.patch added to gregkh-2.6 tree
To: sonic.adi@gmail.com,gregkh@suse.de,greg@kroah.com,jic23@cam.ac.uk,linux-iio@vger.kernel.org,linux-kernel@vger.kernel.org
From: <gregkh@suse.de>
Date: Thu, 22 Apr 2010 17:13:20 -0700
In-Reply-To: <4BA76219.4030606@cam.ac.uk>
Message-ID: <12719816003115@kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
List-ID: <linux-iio@vger.kernel.org>


This is a note to let you know that I've just added the patch titled

    Subject: staging: iio: Function iio_get_new_idr_val() return negative=
 value if fails.

to my gregkh-2.6 tree.  Its filename is

    staging-iio-function-iio_get_new_idr_val-return-negative-value-if-fai=
ls.patch

This tree can be found at=20
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patch=
es/


>>From jic23@cam.ac.uk  Thu Apr 22 16:40:17 2010
From: Sonic Zhang <sonic.adi@gmail.com>
Date: Mon, 22 Mar 2010 12:27:05 +0000
Subject: staging: iio: Function iio_get_new_idr_val() return negative val=
ue if fails.
To: sonic zhang <sonic.adi@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,  linux-iio <linux-iio@vg=
er.kernel.org>, Greg KH <greg@kroah.com>
Message-ID: <4BA76219.4030606@cam.ac.uk>


Function iio_get_new_idr_val() return negative value if fails.
So, only error when ret < 0 in iio_device_register_eventset().

Signed-off-by: Sonic Zhang <sonic.adi@gmail.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/staging/iio/industrialio-core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -537,6 +537,7 @@ static void iio_device_unregister_sysfs(
 	sysfs_remove_group(&dev_info->dev.kobj, dev_info->attrs);
 }
=20
+/* This function return negative value if fails. */
 int iio_get_new_idr_val(struct idr *this_idr)
 {
 	int ret;
@@ -660,7 +661,7 @@ static int iio_device_register_eventset(
 	for (i =3D 0; i < dev_info->num_interrupt_lines; i++) {
 		dev_info->event_interfaces[i].owner =3D dev_info->driver_module;
 		ret =3D iio_get_new_idr_val(&iio_event_idr);
-		if (ret)
+		if (ret < 0)
 			goto error_free_setup_ev_ints;
 		else
 			dev_info->event_interfaces[i].id =3D ret;
