Return-Path: <SRS0=55s9=X3=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH] iio: adc: max1027: allocate DMA-safe buffer
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
References: <20161209102435.30638-1-marcus.folkesson@gmail.com>
 <915bf030-49c3-5d56-73c2-9c3da3f1a02e@kernel.org>
 <20161210205333.24gjh6vccyqdo5ll@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Matt Ranostay <mranostay@gmail.com>,
 Sandhya Bankar <bankarsandhya512@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <aea77156-d264-9066-4fca-914721bba400@metafoo.de>
Date: Mon, 12 Dec 2016 18:31:57 +0100
MIME-Version: 1.0
In-Reply-To: <20161210205333.24gjh6vccyqdo5ll@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 12/10/2016 09:53 PM, Marcus Folkesson wrote:
> On Sat, Dec 10, 2016 at 05:36:34PM +0000, Jonathan Cameron wrote:
>> On 09/12/16 10:24, Marcus Folkesson wrote:
>>> The buffer needs to be DMA-safe when used with spi_read()
>>>
>>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>> Please read the documentation in include/linux/gfp.h about GFP_DMA.
>>
>> Specifically:
>> 220  * GFP_DMA exists for historical reasons and should be avoided where possible.
>> 221  *   The flags indicates that the caller requires that the lowest zone be
>> 222  *   used (ZONE_DMA or 16M on x86-64). Ideally, this would be removed but
>> 223  *   it would require careful auditing as some users really require it and
>> 224  *   others use the flag to avoid lowmem reserves in ZONE_DMA and treat the
>> 225  *   lowest zone as a type of emergency reserve.
>>
>> Seems unlikely this applies!  This caught me by surprise as I didn't even know
>> that flag existed - hence I went digging.
>>
>> Jonathan
> 
> Always learn something!
> I did not know it was depricated, seems like the comment about GFP_DMA was
> commited just a year ago.

GFP_DMA is the lowest common denominator when it comes to allocating
buffers. Using GFP_DMA will allocate the buffer at an address that is
accessible by all DMA hardware. But for most (and pretty much all modern)
hardware this is simply not necessary since the addressable range is much
larger. On the other hand the downside of using GFP_DMA is that there is
only a very limited amount (16M at most) of memory available for GFP_DMA
allocations. This is why it is not recommend to be used for new drivers.

The problem is that when the buffer is allocated in the IIO driver we do not
know the buffer address restrictions of the SPI device. And often the DMA is
not even done by the SPI controller but a dedicated separate DMA controller.

Ideally there would be some kind of helper function that allows to allocate
a DMA-able transfer buffer for a specific SPI device.

> 
> I had a problem with a driver on my own that by using a non
> DMA-safe buffer, so I was digging around looking for similiar cases in
> the kernel.

What kind of issue was this?

> 
> I thought other drivers (iio/common/ssp_sensors/sspi_spi.c,
> input/rmi4/rmi_spi.c) was using GFP_DMA for this purpose.
> 
> Anyway, thanks.
> 
> Cheers,
> Marcus Folkesson 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
