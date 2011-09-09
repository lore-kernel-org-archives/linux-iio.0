Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:45158 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758973Ab1IIOcP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 9 Sep 2011 10:32:15 -0400
Message-ID: <4E6A2560.1050204@cam.ac.uk>
Date: Fri, 09 Sep 2011 15:40:32 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [IIO] Mistake in assumption about trigger names
References: <201109091601.39902.manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <201109091601.39902.manuel.stahl@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/09/11 15:01, Manuel Stahl wrote:
> Hi Jonathan,
> 
> I'm currently updating the iioutils SF project. By doing so I encountered a 
> problem in your generic_buffer.c example.
> 
> You generate the trigger name from the device name:
>> 	if (trigger_name == NULL) {
>> 		/*
>> 		 * Build the trigger name. If it is device associated it's
>> 		 * name is <device_name>_dev[n] where n matches the device
>> 		 * number found above
>> 		 */
>> 		ret = asprintf(&trigger_name,
>> 			       "%s-dev%d", device_name, dev_num);
>> 		if (ret < 0) {
>> 			ret = -ENOMEM;
>> 			goto error_ret;
>> 		}
>> 	}
> 
> That will not work if a device has no trigger and is enumerated before the 
> device you are looking at.
Dratt, that is actually a result of a bug rather than a missassumption.
The number should be independent of the enumeration order.  That is it
should be consistent what ever the ordering.  The reorganisation of when
the device_register happens has broken this however (which is where the
id is allocated).  My tests didn't pick it up because I was testing only
one device. Yours presumably just have one trigger provider so it looked
like it was getting the trigger number whereas it was actually getting 0
on all occasions.

The fix is to move the id allocation and deallocation from iio_device_register
/ unregister to the allocate and free paths.  That should put things back
the way they were...  I'll hammer that out quickly now.
> 
> I think we need a symlink in the device directory to it's own trigger.
I'm anti that purely because we then have two different ways of finding
a trigger.  Currently there is one consistent method.  They are both
children of the underlying device so one can get to it that way if
it's really necessary.

> Also the current_trigger attribute should go into the buffer directory, as 
> this is the place, where it is actually used.
This one has come up before.  It is a pain to do so as the files in the
buffer directory come from the buffer implementation and those in the
trigger directory from the device driver calling into the core.  Same
is true of scan_elements and so I'm afraid the slight improvement in
logic of where things are located is not worth the complexity increase
in the driver.

Jonathan

