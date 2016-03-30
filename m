Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34277 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbcC3GIl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 30 Mar 2016 02:08:41 -0400
Received: by mail-pa0-f49.google.com with SMTP id fe3so32191096pab.1
        for <linux-iio@vger.kernel.org>; Tue, 29 Mar 2016 23:08:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: iio_simple_dummy_buffer_dma
From: John Syne <john3909@gmail.com>
In-Reply-To: <56CC89E7.4030700@metafoo.de>
Date: Tue, 29 Mar 2016 23:08:25 -0700
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-Id: <9310CAE0-D5C3-4571-A979-779C7483BBE5@gmail.com>
References: <C78F84F2-A2D5-40B2-9291-F27FA95C8F52@gmail.com> <8CFE0549-CA65-4163-917D-5BF55DCC0E4A@gmail.com> <56CAF486.4060505@metafoo.de> <5343A235-F2C0-46B0-A0E1-853F3BC5F27D@gmail.com> <56CB4602.6060809@metafoo.de> <4A74D836-0747-43D6-886B-7D1C5CB2D070@gmail.com> <56CC89E7.4030700@metafoo.de>
To: Lars-Peter Clausen <lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lars,

I did manage to get the dummy example with iio_simple_dummy_buffer_dma working. It turns out I had an issue in my dummy Kconfig when I added back the iio_simple_dummy_buffer_dma support. Now I can run iiod and connect iioScope and see sine, square, etc waveforms. I can also use generic_buffer and that works also. 

Now I’m trying to figure out how to add my own hardware using part 2 of iio_simple_dummy_buffer_dma as a template. I was wondering when you expect to release the “overhauled version”.

Has anyone used the IIO-DMA framework in a real driver? In your IIO-DMA patch notes, you said "Andrey Yurovsky has also successfully added DMA buffer support to the existing AT91 ADC”, but I have looked at this driver and I don’t see any IIO-DMA framework added. 

Also, have you made any progress on adding the high speed interface via mmap or vmsplice. 

Thank you and Jonathan for all the work you guys do on IIO. The IIO framework is a really helpful for what I need, especially with the DMA support. 


Regards,
John


> On Feb 22, 2016, at 3:44 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
> On 02/22/2016 05:51 AM, John Syne wrote:
>> BTW, I seem to remember that Lars removed iio_simple_dummy_buffer_dma.c in his V3 patch so this won’t be in the IIO repo, but I don’t know how to test the IIO DMA framework without this file.
>> 
> 
> Hi,
> 
> The patch was dropped for now to avoid conflicts with other ongoing work on
> the dummy driver. The patch will come back in a slightly overhauled version
> soonish.
