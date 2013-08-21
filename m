Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:58245 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261Ab3HUVTS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Aug 2013 17:19:18 -0400
In-Reply-To: <0423FED8EB79934F939F077EAF96DBD717D8025F@HASMSX105.ger.corp.intel.com>
References: <0423FED8EB79934F939F077EAF96DBD717D8025F@HASMSX105.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: working with IIO
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Wed, 21 Aug 2013 22:00:15 +0100
To: "Yuniverg, Michael" <michael.yuniverg@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "Drubin, Daniel" <daniel.drubin@intel.com>,
	"Haimovich, Yoav" <yoav.haimovich@intel.com>
Message-ID: <a761c167-aef3-42a3-a4bd-fa5078861dd1@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



"Yuniverg, Michael" <michael.yuniverg@intel.com> wrote:
>Hi Jonathan, guys,
>
>My name is Michael Yuniverg and I'm working for Intel.
>You surely noted that starting Kernel 3.7 some of Intel-supported
>sensors were exposed to user space via iio subsystem.
>
>Me and my colleagues (in CC) are working to expose a new generation of
>Intel-supported sensors and naturally we'd like to  keep using iio.
>However we've seen the limitation of just single user-mode client
>allowed to work with a particular iio device:
>/**
>* iio_chrdev_open() - chrdev file open for buffer access and ioctls
>**/
>static int iio_chrdev_open(struct inode *inode, struct file *filp)
>{
>        struct iio_dev *indio_dev = container_of(inode->i_cdev,
>                                               struct iio_dev, chrdev);
>
>        if (test_and_set_bit(IIO_BUSY_BIT_POS, &indio_dev->flags))
>                return -EBUSY;
>
>        filp->private_data = indio_dev;
>
>        return 0;
>}
>
>This limitation is really painful for our design that is striving to
>achieve better performance moving some of sensors logic to Kernel mode.
>Now please Jonathan, could you explain the ratio behind this
>limitation?

Simplicity and hence speed plus where all this evolved from which was data logging. Technically there is nothing stopping us having a separate buffer per user as we already allow multiple buffers to be fed from the same device for different purposes. This is how the bridge to input functions (not yet in mainline)

What is your application which needs multiple simultaneous buffered users? 

As a quick thought I would not necessarily be against having the ability to request additional chrdevs each with their own buffers. A bit fiddly to retrofit though as not breaking abi would mean we need to keep the existing interfaces as they are.


>And in general - could you share with us your plans of future
>modifications to  iio

Lots though honestly most of the interesting bits are not my ideas or plans but rather those of others.

Personally I am still working through a load of core changes that are not going to change anything fundamental.

Of course feel free to propose any changes you would like!
>
>Thanks in advance,
>Michael
>
>
>---------------------------------------------------------------------
>Intel Israel (74) Limited
>
>This e-mail and any attachments may contain confidential material for
>the sole use of the intended recipient(s). Any review or distribution
>by others is strictly prohibited. If you are not the intended
>recipient, please contact the sender and delete all copies.

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
