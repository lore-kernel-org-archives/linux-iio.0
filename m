Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:40202 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754306AbcKEO3C (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Nov 2016 10:29:02 -0400
Date: Sat, 5 Nov 2016 10:29:00 -0400
From: Brian Masney <masneyb@onstation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: regmap and i2c_smbus_write_byte question
Message-ID: <20161105142900.GA6844@basecamp.onstation.org>
References: <20161105113831.GA6053@basecamp.onstation.org>
 <6a764449-63a3-e7a3-8bd4-d20c436bed3f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6a764449-63a3-e7a3-8bd4-d20c436bed3f@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Nov 05, 2016 at 12:53:02PM +0000, Jonathan Cameron wrote:
> On 05/11/16 11:38, Brian Masney wrote:
> > I am investigating converting the tsl2583 staging driver over to use
> > the regmap API. I ran into an issue converting the following call to
> > i2c_smbus_write_byte() over to the regmap API:
> > 
> > struct tsl2583_chip {
> >         struct i2c_client *client;
> >         ...
> > }
> > 
> > /*
> >  * clear status, really interrupt status (interrupts are off), but
> >  * we use the bit anyway - don't forget 0x80 - this is a command
> >  */      
> > ret = i2c_smbus_write_byte(chip->client,
> >                            (TSL258X_CMD_REG | TSL258X_CMD_SPL_FN |
> >                             TSL258X_CMD_ALS_INT_CLR));
> > 
> > I don't see a way to do this in the regmap API.  
> > drivers/input/touchscreen/tsc2004.c has this same issue and that code
> > directly calls i2c_smbus_write_byte() along with the regmap API. Am I
> > missing something? This doesn't feel right to me to bypass the regmap
> > API and directly access the i2c client.
> > 
> > The data sheet for the tsl2583 sensor is available here:
> > http://media.digikey.com/PDF/Data%20Sheets/Austriamicrosystems%20PDFs/TSL2581,83.pdf
> > Page 10 has the table that describes clearing the interrupt bit. The
> > sensor will not take additional readings until that bit is cleared
> > (even though interrupts are off).
> Bit of a tangential question but why do a regmap conversion for this device?
> It's i2c only so we don't gain from easy support for multiple bus types.
> There aren't all that many registers and we don't have reason to
> often read/write the ones that aren't volatile.
> 
> Hence I'd argue there is little point in doing a regmap conversion in
> the first place.
> 
> If there is a good reason to do it then there isn't an easy way around
> these 'odd' diversions from what is otherwise a nice register
> based interface.
> 
> Hence another reason to not do a regmap conversion.

I totally agree that it does not make sense to do the regmap conversion
for this driver. The only reason that I initially looked into doing it
was that there are other light drivers in mainline (with few registers)
that use the regmap API.

My tsl2583 patch set that I sent out a few days ago is still valid even
though the cover sheet says it lays the ground work for the regmap
conversion.

Thanks,

Brian

