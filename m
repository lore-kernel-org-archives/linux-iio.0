Return-Path: <manuel.stahl9cd33xy531iis.fraunhofer.de@bounce.antispameurope.com>
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [IIO] Mistake in assumption about trigger names
Date: Fri, 9 Sep 2011 16:01:39 +0200
Cc: linux-iio@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201109091601.39902.manuel.stahl@iis.fraunhofer.de>
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

I'm currently updating the iioutils SF project. By doing so I encountered a 
problem in your generic_buffer.c example.

You generate the trigger name from the device name:
> 	if (trigger_name == NULL) {
> 		/*
> 		 * Build the trigger name. If it is device associated it's
> 		 * name is <device_name>_dev[n] where n matches the device
> 		 * number found above
> 		 */
> 		ret = asprintf(&trigger_name,
> 			       "%s-dev%d", device_name, dev_num);
> 		if (ret < 0) {
> 			ret = -ENOMEM;
> 			goto error_ret;
> 		}
> 	}

That will not work if a device has no trigger and is enumerated before the 
device you are looking at.

I think we need a symlink in the device directory to it's own trigger.
Also the current_trigger attribute should go into the buffer directory, as 
this is the place, where it is actually used.

-- 
Regards,
Manuel Stahl
