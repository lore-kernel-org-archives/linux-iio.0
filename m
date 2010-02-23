Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:54352 "EHLO
	ppsw-5.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381Ab0BWWyX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 23 Feb 2010 17:54:23 -0500
Date: 23 Feb 2010 22:54:20 +0000
From: "J.I. Cameron" <jic23@cam.ac.uk>
To: Sven-Thorsten Dietrich <sdietrich@novell.com>
Cc: Greg KH <gregkh@suse.de>, lindner_marek@yahoo.de,
	siwu@hrz.tu-chemnitz.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging drivers use spin_lock_init()
Message-ID: <Prayer.1.3.2.1002232254200.5956@hermes-2.csi.cam.ac.uk>
In-Reply-To: <1266962359.3234.40.camel@sven.thebigcorporation.com>
References: <1266962359.3234.40.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Feb 23 2010, Sven-Thorsten Dietrich wrote:

>Subject: Convert driver-staging to use spin_lock_init()
>
>This fixes some RT-triggered compile errors and typos.
>
>Against 2.6.33-rc8. Push upstream as you see appropriate.
>
>Thanks.
>
>Signed-off-by: Sven-Thorsten Dietrich <sdietrich@novell.com>
For the two IIO patches, 
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Thanks for the fix!

Jonathan

>Index: linux-2.6.32-slert-devel/drivers/staging/batman-adv/device.c
>===================================================================
>--- linux-2.6.32-slert-devel.orig/drivers/staging/batman-adv/device.c
>+++ linux-2.6.32-slert-devel/drivers/staging/batman-adv/device.c
>@@ -118,9 +118,9 @@ int bat_device_open(struct inode *inode,
> 
> 	INIT_LIST_HEAD(&device_client->queue_list);
> 	device_client->queue_len = 0;
> 	device_client->index = i;
>-	device_client->lock = __SPIN_LOCK_UNLOCKED(device_client->lock);
>+	spin_lock_init(&device_client->lock);
> 	init_waitqueue_head(&device_client->queue_wait);
> 
> 	file->private_data = device_client;
> 
>Index: linux-2.6.32-slert-devel/drivers/staging/iio/ring_generic.h
>===================================================================
>--- linux-2.6.32-slert-devel.orig/drivers/staging/iio/ring_generic.h
>+++ linux-2.6.32-slert-devel/drivers/staging/iio/ring_generic.h
>@@ -145,10 +145,9 @@ static inline void __iio_init_ring_buffe
> 	ring->bpd = bytes_per_datum;
> 	ring->length = length;
> 	ring->loopcount = 0;
> 	ring->shared_ev_pointer.ev_p = 0;
>-	ring->shared_ev_pointer.lock =
>-		__SPIN_LOCK_UNLOCKED(ring->shared_ev_pointer->loc);
>+	spin_lock_init(&ring->shared_ev_pointer.lock);
> }
> 
> /**
>  * struct iio_scan_el - an individual element of a scan diff -u -r 
> linux-2.6.32.orig/drivers/staging/iio/ring_sw.c 
> linux-2.6.32.orig-bak/drivers/staging/iio/ring_sw.c --- 
> linux-2.6.32.orig/drivers/staging/iio/ring_sw.c 2009-12-02 
> 19:51:21.000000000 -0800 +++ 
> linux-2.6.32.orig-bak/drivers/staging/iio/ring_sw.c 2010-02-22 
> 19:04:42.171671961 -0800 @@ -21,7 +21,7 @@
> 		return -EINVAL;
> 
> 	__iio_init_ring_buffer(&ring->buf, bytes_per_datum, length);
>-	ring->use_lock = __SPIN_LOCK_UNLOCKED((ring)->use_lock);
>+	spin_lock_init(&ring->use_lock);
> 	ring->data = kmalloc(length*ring->buf.bpd, GFP_KERNEL);
> 	ring->read_p = 0;
> 	ring->write_p = 0;
>
>
>

