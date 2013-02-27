Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qe0-f45.google.com ([209.85.128.45]:40054 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760283Ab3B0Rg5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 12:36:57 -0500
Received: by mail-qe0-f45.google.com with SMTP id b4so658539qen.18
        for <linux-iio@vger.kernel.org>; Wed, 27 Feb 2013 09:36:56 -0800 (PST)
Date: Wed, 27 Feb 2013 12:36:54 -0500
From: Chris Micali <chrismicali@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "=?utf-8?Q?linux-iio=40vger.kernel.org?=" <linux-iio@vger.kernel.org>
Message-ID: <5277B88AB1FF4E6A83920766C0BE13F7@gmail.com>
In-Reply-To: <512E43A9.4090301@metafoo.de>
References: <26387F1A648A4D3D9BB4142C4F0AAE98@gmail.com>
 <512E2F31.8000604@metafoo.de>
 <B42F83EDFE8B4D2D8D46B6241B49B4E8@gmail.com>
 <512E3592.4020702@metafoo.de>
 <4AEA8015FE824807B3CF62B7B35FC5D3@gmail.com>
 <512E43A9.4090301@metafoo.de>
Subject: Re: IIO Drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

lars, 

I was under the impression that flag gets added automatically by iio_triggered_buffer_setup (industrialiio-triggers.c:77) - I actually am now able to enable the scan_element after changing my channel .channel and .scan_index to 0 (trying to match exactly the other drivers.)  When i run general_buffer (from the docs dir) with that scan element enabled it can no longer read the trigger (Could not open /trigger/current_trigger  Failed to write current_trigger file) - this succeeds if that scan_element is not enabled.  

Is there a guide anywhere that captures the steps to setup and read from a driver that perhaps I missed?

-c


On Wednesday, February 27, 2013 at 12:34 PM, Lars-Peter Clausen wrote:

> On 02/27/2013 06:15 PM, Chris Micali wrote:
> > Lars, 
> > 
> > Thanks.. when I write 1 to scan_elements/in_voltage0_en via iio_cmdserv i get -2, from shell (echo 1>) i see write error: Invalid argument. No output in dmesg that indicates what the error is/could be though.
> > 
> > -c
> 
> In your driver you commented out the INDIO_BUFFER_TRIGGERED mode flag, did
> you add that back? Without it this won't work.
> 
> - Lars
> 
> > 
> > 
> > On Wednesday, February 27, 2013 at 11:34 AM, Lars-Peter Clausen wrote:
> > 
> > > On 02/27/2013 05:21 PM, Chris Micali wrote:
> > > > Hi Lars,
> > > > Thanks a lot for getting back to me. I've attached my code - it's pretty simple, I just copied an existing driver. As I mentioned individual reads are working fine (if i cat in_voltage0_raw) but buffered reads are failing. I've tracked the issue to industrialio-buffer.c in iio_compute_scan_bytes() which always returns zero because, i believe, the mask is 0. I haven't been able to find any docs on what 'scan masks' mean but I have seen a few drivers that supply available scan masks. Should I be specifying scan masks? 
> > > > Thanks!
> > > > -chris
> > > 
> > > 
> > > 
> > > 
> > > Hi Chris,
> > > 
> > > You need to enable the channels you want to sample in sysfs. If you are
> > > using the command server you can for example do this by doing a 'write
> > > ads... scan_elements/in_voltage0_en'
> > > 
> > > - Lars
> > > 
> > > 
> > > > 
> > > > 
> > > > On Wednesday, February 27, 2013 at 11:07 AM, Lars-Peter Clausen wrote:
> > > > 
> > > > > On 02/26/2013 08:56 PM, Chris Micali wrote:
> > > > > > Hello Lars,
> > > > > > 
> > > > > > I'm doing a bit of hacking on a IIO driver based on some of your drivers on a 3.8 kernel (specifically writing a driver for a TI SPI adc.) I've been able to get a driver up and working such that I can read directly from the in_voltage0_raw on sysfs and get the correct values but I can't seem to get buffered access working (via iio_cmdsrv.) I've had a hard time finding any docs on this stuff and I was wondering if you could give me any pointers on where to look or who else perhaps to ask about this stuff? Any pointers would be very much appreciated!
> > > > > > 
> > > > > > Thanks,
> > > > > > Chris
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > > Hi,
> > > > > 
> > > > > I'm afraid except for the the documentation in
> > > > > drivers/staging/iio/Documentation/, the kernel doc comments and the skeleton
> > > > > driver (drivers/staging/iio/iio_simple_dummy*) there is not much additional
> > > > > documentation available.
> > > > > 
> > > > > The general place to ask questions about IIO is the IIO mailinglist. I've
> > > > > put it on CC, hope you don't mind.
> > > > > 
> > > > > I think we can help you best if you post your code.
> > > > > 
> > > > > - Lars 


