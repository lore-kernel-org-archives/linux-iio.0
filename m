Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34799 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbbEGXsS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2015 19:48:18 -0400
Date: Thu, 7 May 2015 18:48:17 -0500
From: Michael Welling <mwelling@ieee.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	san@rosetechnology.dk, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: mcp320x: Fix occasional incorrect readings
Message-ID: <20150507234817.GA24969@deathray>
References: <1430930957-14588-1-git-send-email-mwelling@ieee.org>
 <554B3ABB.7050306@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <554B3ABB.7050306@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, May 07, 2015 at 11:13:15AM +0100, Jonathan Cameron wrote:
> On 06/05/15 17:49, Michael Welling wrote:
> > Without the cacheline alignment, the readings will occasionally incorrectly
> > return 0.
> > 
> > Signed-off-by: Michael Welling <mwelling@ieee.org>
> Applied to the fixes-togreg branch of iio.git.  Not sure
> when I'll be able to push this out publicly as travelling
> / working nights and generally having a silly week.
> 
> J

Thanks.

Appearently code can be silly too:
https://lkml.org/lkml/2015/5/7/879

> > ---
> > 
> > v2: Moved buffers to the end of the mcp320x struct per suggestion to keep
> > them on their own cacheline.
> > 
> >  drivers/iio/adc/mcp320x.c |    6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> > index efbfd12..8d9c9b9 100644
> > --- a/drivers/iio/adc/mcp320x.c
> > +++ b/drivers/iio/adc/mcp320x.c
> > @@ -60,12 +60,12 @@ struct mcp320x {
> >  	struct spi_message msg;
> >  	struct spi_transfer transfer[2];
> >  
> > -	u8 tx_buf;
> > -	u8 rx_buf[2];
> > -
> >  	struct regulator *reg;
> >  	struct mutex lock;
> >  	const struct mcp320x_chip_info *chip_info;
> > +
> > +	u8 tx_buf ____cacheline_aligned;
> > +	u8 rx_buf[2];
> >  };
> >  
> >  static int mcp320x_channel_to_tx_data(int device_index,
> > 
> 
