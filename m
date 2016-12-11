Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54044 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753199AbcLKPHt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Dec 2016 10:07:49 -0500
Subject: Re: [PATCH] iio: adc: max1027: allocate DMA-safe buffer
To: Marcus Folkesson <marcus.folkesson@gmail.com>
References: <20161209102435.30638-1-marcus.folkesson@gmail.com>
 <915bf030-49c3-5d56-73c2-9c3da3f1a02e@kernel.org>
 <20161210205333.24gjh6vccyqdo5ll@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <mranostay@gmail.com>,
        Sandhya Bankar <bankarsandhya512@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karol Wrona <k.wrona@samsung.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <469e75f7-c3a2-48a3-9dac-6ffea0a8efd9@kernel.org>
Date: Sun, 11 Dec 2016 15:07:46 +0000
MIME-Version: 1.0
In-Reply-To: <20161210205333.24gjh6vccyqdo5ll@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/12/16 20:53, Marcus Folkesson wrote:
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
> 
> I had a problem with a driver on my own that by using a non
> DMA-safe buffer, so I was digging around looking for similiar cases in
> the kernel.
> 
> I thought other drivers (iio/common/ssp_sensors/sspi_spi.c,
> input/rmi4/rmi_spi.c) was using GFP_DMA for this purpose.
oops. I guess that iio one snuck past us.  Karol, I doubt having this flag there
is having any effect at all on your platform.  Shall we drop it?

Marcus, it might be worth following up on the input driver as well if you would like to
do so.  I'm not so certain about what is going on in that driver as I don't know what
rmi is!

Thanks,

Jonathan
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

