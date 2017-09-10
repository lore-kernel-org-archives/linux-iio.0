Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751578AbdIJNsK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Sep 2017 09:48:10 -0400
Date: Sun, 10 Sep 2017 14:48:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: Colin Parker <colin.foeparker@aclima.io>,
        linux-iio@vger.kernel.org, foeparker.colin@gmail.com,
        Colin Parker <colin.parker@aclima.io>
Subject: Re: [PATCH] IIO: BME280: Updates to Humidity readings need ctrl_reg
 write!
Message-ID: <20170910144812.64fdd20e@archlinux>
In-Reply-To: <20170904172051.GA20312@arbeit>
References: <1503962499-11417-1-git-send-email-colin.parker@aclimalabs.com>
        <20170903173415.6a86f166@archlinux>
        <20170904172051.GA20312@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 4 Sep 2017 19:20:51 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Jonathan Cameron <jic23@kernel.org> schrieb am Sun, 03. Sep 17:34:
> > On Mon, 28 Aug 2017 16:21:39 -0700
> > Colin Parker <colin.foeparker@aclima.io> wrote:
> >   
> > > From: Colin Parker <colin.parker@aclima.io>
> > > 
> > > The ctrl_reg register needs to be written after any write to
> > > the humidity registers. The value written to the ctrl_reg register
> > > does not necessarily need to change, but a write operation must
> > > occur.  
> > 
> > That's nasty.
> >   
> > > 
> > > The regmap_update_bits functions will not write to a register
> > > if the register value matches the value to be written. This saves
> > > unnecessary bus operations.  The change in this patch forces a bus
> > > write during the chip_config operation by switching to
> > > regmap_write_bits.
> > > 
> > > This will fix issues where the Humidity Sensor Oversampling bits
> > > are not updated after initialization.
> > > 
> > > Signed-off-by: Colin Parker <colin.parker@aclima.io>  
> 
> Acked-by: Andreas Klinger <ak@it-klinger.de>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> 
> > 
> > I'd just like to leave a little more time for Andreas to respond to
> > this before I apply it.
> > 
> > Give me a bump if it looks like I have forgotten about it after next
> > weekend.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/iio/pressure/bmp280-core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > > index 0d2ea3e..8f26428 100644
> > > --- a/drivers/iio/pressure/bmp280-core.c
> > > +++ b/drivers/iio/pressure/bmp280-core.c
> > > @@ -573,7 +573,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
> > >  	u8 osrs = BMP280_OSRS_TEMP_X(data->oversampling_temp + 1) |
> > >  		  BMP280_OSRS_PRESS_X(data->oversampling_press + 1);
> > >  
> > > -	ret = regmap_update_bits(data->regmap, BMP280_REG_CTRL_MEAS,
> > > +	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
> > >  				 BMP280_OSRS_TEMP_MASK |
> > >  				 BMP280_OSRS_PRESS_MASK |
> > >  				 BMP280_MODE_MASK,  
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html  
> 

