Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qe0-f52.google.com ([209.85.128.52]:64967 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196Ab3B0Tu4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 14:50:56 -0500
Received: by mail-qe0-f52.google.com with SMTP id s14so411020qeb.39
        for <linux-iio@vger.kernel.org>; Wed, 27 Feb 2013 11:50:55 -0800 (PST)
Date: Wed, 27 Feb 2013 14:50:51 -0500
From: Chris Micali <chrismicali@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"=?utf-8?Q?linux-iio=40vger.kernel.org?=" <linux-iio@vger.kernel.org>
Message-ID: <69F22814D4E34BA292A240F114EAA970@gmail.com>
In-Reply-To: <5CCB32D4B146494F902390C27F8216A8@gmail.com>
References: <26387F1A648A4D3D9BB4142C4F0AAE98@gmail.com>
 <512E2F31.8000604@metafoo.de>
 <B42F83EDFE8B4D2D8D46B6241B49B4E8@gmail.com>
 <512E3592.4020702@metafoo.de>
 <4AEA8015FE824807B3CF62B7B35FC5D3@gmail.com>
 <512E43A9.4090301@metafoo.de>
 <5277B88AB1FF4E6A83920766C0BE13F7@gmail.com>
 <512E5054.8030905@kernel.org> <512E55AA.6050203@metafoo.de>
 <5CCB32D4B146494F902390C27F8216A8@gmail.com>
Subject: Re: IIO Drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Last question :)  I'd like to sample from this device as quickly as possible - so I'm assuming I need to trigger quickly?  Should I use iio-trig-periodic-rtc?  Any hints/instructions on how to use that?  Should the driver supply it's own trigger that uses an hrtimer instead?

Thanks!
Chris


On Wednesday, February 27, 2013 at 2:32 PM, Chris Micali wrote:  
> Guys,  
>  
> Thanks a lot for the help! I finally tracked down issues, it was a combination of a few things:
>  
> 1. The .channel had to be 0, not 1 in the driver (scan_index didn't matter)
> 2. 1 or more scan_elements have to be enabled as you mentioned
> 2. When echoing into the sysfs files it has to have a space after the number (cat 1 > in_voltage0_en and not cat 1>in_vo…) (duh!)
> 3. The generic_buffer.c program had a few bugs in it causing crashes. I updated the iio_utils.h to a newer version I found here: https://github.com/analogdevicesinc/iio-oscilloscope and then made a few modifications (the newer iio_utils did not parse a few things right in the channel details like bigendian/littleendian)
>  
> So generic_buffer is now correctly sampling (although it crashes after a couple, it's probably another iio_utils issue)
>  
> Thanks!!
>  
> -chris
>  
>  
> On Wednesday, February 27, 2013 at 1:51 PM, Lars-Peter Clausen wrote:
>  
> > On 02/27/2013 07:28 PM, Jonathan Cameron wrote:
> > > On 02/27/2013 05:36 PM, Chris Micali wrote:
> > > > lars,  
> > > >  
> > > > I was under the impression that flag gets added automatically by iio_triggered_buffer_setup (industrialiio-triggers.c:77) - I actually am now able to enable the scan_element after changing my channel .channel and .scan_index to 0 (trying to match exactly the other drivers.)
> >  
> >  
> > Yea, you are right I missed the iio_triggered_buffer_setup part.
> >  
> > > Strange, scan_index should have defaulted to zero and the .channel value shouldn't have mattered
> > > for buffered reads (just effects naming). Might have caused issues with userspace expecting a channel 0
> > > though...
> >  
> >  
> >  
> >  
> >  
> > I guess the scan_index had nothing to do with this, but I suggested to set
> > scan_elements/in_voltage0_en to 1, so this clearly wouldn't have worked with
> > .channel being 1.
> >  
> > >  
> > > > When i run general_buffer (from the docs dir) with that scan element enabled it can no longer read the trigger (Could not open /trigger/current_trigger Failed to write current_trigger file) - this succeeds if that scan_element is not enabled.  
> >  
> >  
> > You can't change the trigger if the buffer is currently enabled. Make sure that
> > he buffer is disabled (check the buffer/enable attribute).
> >  
> > - Lars
> > u
>  



