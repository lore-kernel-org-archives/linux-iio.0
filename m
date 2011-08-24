Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:55455 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755549Ab1HXIfu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 24 Aug 2011 04:35:50 -0400
Message-ID: <4E54B9D0.20903@cam.ac.uk>
Date: Wed, 24 Aug 2011 09:44:00 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: malas <malas@tcoe.iitm.ac.in>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: ad7793 adc rcv userspace test - details attached
References: <20110824081952.M29386@tcoe.iitm.ac.in>
In-Reply-To: <20110824081952.M29386@tcoe.iitm.ac.in>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/24/11 09:26, malas wrote:
> 
> Dear Michael Hennerich,
> 
> I have attached the details of my testing with the ad7793 driver both as when installed
> as module and otherwise.
> 
> I have not been to resolve the issue even after having created a device node under /dev
> as device0:buffer0.
> 
> Requesting your further assistance for the same.
> 
> Thanks
> Mala
> 
> 
> 
> --
> Open WebMail Project (http://openwebmail.org)
> 
> 
> 

> Testing results of ADC ad7793 driver with generic_buffer.c
> 
> 
> Results of installing ad7793 adc driver as module:
> 
> root:/> cd lib/modules/3.1.0-rc1-dirty/kernel/drivers/staging/iio/adc/ 
> root:/lib/modules/3.1.0-rc1-dirty/kernel/drivers/staging/iio/adc> ls ad7793.ko 
> root:/lib/modules/3.1.0-rc1-dirty/kernel/drivers/staging/iio/adc> insmod ad7793. ko 
> ad7793: module is from the staging directory, the quality is unknown, you have been warned. 
> root:/lib/modules/3.1.0-rc1-dirty/kernel/drivers/staging/iio/adc> lsmod 
> Module                  Size  Used by 
> ad7793                  7998  0 
> root:/lib/modules/3.1.0-rc1-dirty/kernel/drivers/staging/iio/adc> cd 
> root:/> ls -l /dev/device0\:buffer0 
> crw-r--r--    1 root     root        0,   0 Jan  1 00:00 /dev/device0:buffer0 
> root:/> ls /sys/bus/iio/devices/ 
> iio_sysfs_trigger 
> root:/> 
> 
> I observed driver probe() doesn't get called when inserted as module. Also the device0\buffer0 nodes dont get created on installation.

If probe isn't getting called then something has gone wrong in device matching.
What is the board file you are using? (guessing blackfin hasn't gone all device tree
yet?)

> Results of installing ad7793 adc driver built into kernel:
> 
> I added following line in .rc under dist/vendor/AnalogDevices/common/. 
> 
> mknod /dev/device0:buffer0 c 0 0
> 
> Please confirm this property of node is correct?

No it isn't. 
http://www.kernel.org/pub/linux/docs/device-list/devices-2.6+.txt
tells us that 0 0 is reserved for null devices.

What does the following contain?

/sys/bus/iio/devices/device0:/buffer0/dev


