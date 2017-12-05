Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH] iio: buffer-dma: Expose data available
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, mfornero@gmail.com
Cc: linux-iio@vger.kernel.org, Matt Fornero <matt.fornero@mathworks.com>
References: <1512161180-30116-1-git-send-email-mfornero@gmail.com>
 <20171202115257.5e561988@archlinux>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <d260e712-ec2f-33d5-e368-86c2e7ffa19e@metafoo.de>
Date: Tue, 5 Dec 2017 10:32:08 +0100
MIME-Version: 1.0
In-Reply-To: <20171202115257.5e561988@archlinux>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 12/02/2017 12:52 PM, Jonathan Cameron wrote:
> On Fri,  1 Dec 2017 15:46:20 -0500
> mfornero@gmail.com wrote:
> 
>> From: Matt Fornero <matt.fornero@mathworks.com>
>>
>> Add a sysfs attribute that exposes the buffer data available to
>> userspace. This attribute can be checked at runtime to determine the
>> overall buffer fill level (across all allocated DMA buffers).
>>
>> Signed-off-by: Matt Fornero <matt.fornero@mathworks.com>
> 
> Seems sensible to me.
> 
> Lars?

I guess one question is whether this should be generic.
iio_dma_buffer_data_available() is a generic function and not specific to
the DMA buffers, so it would work just fine for FIFO based buffers as well.
