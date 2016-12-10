Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36094 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752094AbcLJU7l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Dec 2016 15:59:41 -0500
Date: Sat, 10 Dec 2016 21:53:33 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <mranostay@gmail.com>,
        Sandhya Bankar <bankarsandhya512@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max1027: allocate DMA-safe buffer
Message-ID: <20161210205333.24gjh6vccyqdo5ll@gmail.com>
References: <20161209102435.30638-1-marcus.folkesson@gmail.com>
 <915bf030-49c3-5d56-73c2-9c3da3f1a02e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <915bf030-49c3-5d56-73c2-9c3da3f1a02e@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Dec 10, 2016 at 05:36:34PM +0000, Jonathan Cameron wrote:
> On 09/12/16 10:24, Marcus Folkesson wrote:
> > The buffer needs to be DMA-safe when used with spi_read()
> > 
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Please read the documentation in include/linux/gfp.h about GFP_DMA.
> 
> Specifically:
> 220  * GFP_DMA exists for historical reasons and should be avoided where possible.
> 221  *   The flags indicates that the caller requires that the lowest zone be
> 222  *   used (ZONE_DMA or 16M on x86-64). Ideally, this would be removed but
> 223  *   it would require careful auditing as some users really require it and
> 224  *   others use the flag to avoid lowmem reserves in ZONE_DMA and treat the
> 225  *   lowest zone as a type of emergency reserve.
> 
> Seems unlikely this applies!  This caught me by surprise as I didn't even know
> that flag existed - hence I went digging.
> 
> Jonathan

Always learn something!
I did not know it was depricated, seems like the comment about GFP_DMA was
commited just a year ago.

I had a problem with a driver on my own that by using a non
DMA-safe buffer, so I was digging around looking for similiar cases in
the kernel.

I thought other drivers (iio/common/ssp_sensors/sspi_spi.c,
input/rmi4/rmi_spi.c) was using GFP_DMA for this purpose.

Anyway, thanks.

Cheers,
Marcus Folkesson 
