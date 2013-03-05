Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:46864 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756163Ab3CEVEO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Mar 2013 16:04:14 -0500
Message-ID: <51365E44.6000102@metafoo.de>
Date: Tue, 05 Mar 2013 22:06:12 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Chris Micali <chrismicali@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: IIO Drivers
References: <26387F1A648A4D3D9BB4142C4F0AAE98@gmail.com> <512E2F31.8000604@metafoo.de> <B42F83EDFE8B4D2D8D46B6241B49B4E8@gmail.com> <512E3592.4020702@metafoo.de> <4AEA8015FE824807B3CF62B7B35FC5D3@gmail.com> <512E43A9.4090301@metafoo.de> <5277B88AB1FF4E6A83920766C0BE13F7@gmail.com> <512E5054.8030905@kernel.org> <512E55AA.6050203@metafoo.de> <5CCB32D4B146494F902390C27F8216A8@gmail.com> <51322863.4070901@kernel.org> <EF0F19ECEFC64241BFFA64293C190541@gmail.com>
In-Reply-To: <EF0F19ECEFC64241BFFA64293C190541@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/04/2013 09:37 PM, Chris Micali wrote:
> Jonathan,  
> 
> Thanks - I'll share back my findings this week.
> 
> One thing i've run into is throughput - it seems like the linux spi subsystem has a non-deterministic 50-150us delay before an spi_sync or spi_async command is processed.  I can't seem to find any way around this - so if i use larger multi-byte transfers using spi_async and DMA I get great, stable throughput, but that is broken up by these 50-150us delays between transfers (i'm using the beagle bone, so AM3359 that has a dedicated SPI controller and DMA.)   
> 
> Have any of you guys had success getting reliable >1MSPS throughput via IIO over SPI?  It seems like this inherent delay in the SPI subsystem would make this pretty difficult.

No, not really, I think I never used more than 100kHz so far. Are you sure the
delay is really in the SPI subsystem and not just random interrupts kicking in?

I'm also curious did you implement your own IIO buffer, or are you just
starting a large SPI transfer which samples multiple samples at once?

- Lars

> 
> 
> On Saturday, March 2, 2013 at 11:27 AM, Jonathan Cameron wrote:
> 
>> On 02/27/2013 07:32 PM, Chris Micali wrote:
>>> Guys,  
>>>  
>>> Thanks a lot for the help! I finally tracked down issues, it was a combination of a few things:
>>>  
>>> 1. The .channel had to be 0, not 1 in the driver (scan_index didn't matter)
>>> 2. 1 or more scan_elements have to be enabled as you mentioned
>>> 2. When echoing into the sysfs files it has to have a space after the number (cat 1 > in_voltage0_en and not cat 1>in_vo…) (duh!)
>>> 3. The generic_buffer.c program had a few bugs in it causing crashes. I updated the iio_utils.h to a newer version I found here: https://github.com/analogdevicesinc/iio-oscilloscope and then made a few modifications (the newer iio_utils did not parse a few things right in the channel details like bigendian/littleendian)
>>>  
>>> So generic_buffer is now correctly sampling (although it crashes after a couple, it's probably another iio_utils issue)
>> If you do track down why this is happening, please do report back
>> so we can get it fixed. I wasn't previously aware of any particular
>> issues in the example code so any feedback is helpful!
>>  
>> Looking foward to seeing the driver code when you are happy with it.
>>  
>> Jonathan
>>> Thanks!!
>>>  
>>> -chris
>>>  
>>>  
>>> On Wednesday, February 27, 2013 at 1:51 PM, Lars-Peter Clausen wrote:
>>>  
>>>> On 02/27/2013 07:28 PM, Jonathan Cameron wrote:
>>>>> On 02/27/2013 05:36 PM, Chris Micali wrote:
>>>>>> lars,  
>>>>>>  
>>>>>> I was under the impression that flag gets added automatically by iio_triggered_buffer_setup (industrialiio-triggers.c:77) - I actually am now able to enable the scan_element after changing my channel .channel and .scan_index to 0 (trying to match exactly the other drivers.)
>>>>>>  
>>>>>  
>>>>>  
>>>>  
>>>>  
>>>> Yea, you are right I missed the iio_triggered_buffer_setup part.
>>>>  
>>>>> Strange, scan_index should have defaulted to zero and the .channel value shouldn't have mattered
>>>>> for buffered reads (just effects naming). Might have caused issues with userspace expecting a channel 0
>>>>> though...
>>>>>  
>>>>  
>>>>  
>>>>  
>>>>  
>>>> I guess the scan_index had nothing to do with this, but I suggested to set
>>>> scan_elements/in_voltage0_en to 1, so this clearly wouldn't have worked with
>>>> .channel being 1.
>>>>  
>>>>>  
>>>>>> When i run general_buffer (from the docs dir) with that scan element enabled it can no longer read the trigger (Could not open /trigger/current_trigger Failed to write current_trigger file) - this succeeds if that scan_element is not enabled.  
>>>>>  
>>>>>  
>>>>  
>>>>  
>>>> You can't change the trigger if the buffer is currently enabled. Make sure that
>>>> he buffer is disabled (check the buffer/enable attribute).
>>>>  
>>>> - Lars
>>>> u
>>>>  
>>>  
>>>  
>>  
>>  
>>  
> 
> 
> 

