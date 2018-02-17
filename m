Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750977AbeBQOJ3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Feb 2018 09:09:29 -0500
Date: Sat, 17 Feb 2018 14:09:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
Subject: Re: [PATCH] staging: iio/meter: add name to function definition
 arguments
Message-ID: <20180217140834.2947e5e4@archlinux>
In-Reply-To: <20180216131658.h7b2y2ckkucetnzj@smtp.gmail.com>
References: <20180216125041.qfvg7xtpulc54tk6@smtp.gmail.com>
        <1518785796.9517.25.camel@nxp.com>
        <20180216131658.h7b2y2ckkucetnzj@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 16 Feb 2018 11:16:58 -0200
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> Hi Daniel
> 
> > Hi Rodrigo,
> > 
> > I think this is a nice finding. One comment inline:
> > 
> > On Vi, 2018-02-16 at 10:50 -0200, rodrigosiqueira wrote:  
> > > This patch fixes the checkpatch.pl warning:
> > > 
> > > drivers/staging/iio/meter/ade7854.h:157: WARNING: function definition
> > > argument 'struct device *' should also have an identifier name...
> > > 
> > > +	int (*read_reg_32)(struct device *dev, u16 reg_address, u32 *val);
> > > +	int (*write_reg_8)(struct device *dev, u16 reg_address, u8 value);  
> > 
> > 
> > Any particular reason for using val vs value? I get that one is a pointer
> > and another a plain type, but I think the name should be the same.  
> 
> Before I selected the name, I figure out that read_reg_* and write_reg_*
> was assigned inside the iio/meter/ade7754-(i2c|spi).c files by function
> like ade7754_*_read_reg_* and ade7754_*_write_reg_* .
> 
> I considered to use 'value' name for both functions parameters, however,
> I noticed that function ade7754_*_write_reg_* adopted the name 'value'
> for the last argument and ade7754_*_read_reg_* named the last argument
> as 'val'. So, for consistency sake between the header file and the c
> code, I decided to use the same parameter name patterns.
> 
Hohum. It isn't even that consistent ;)

ade7754_write_reg_8 uses val and ade7754_write_reg_16 uses value.

I would suggest another patch to make them all val.

Thanks,

Jonathan
> 
> > thanks,
> > Daniel.
> >  
> 
> Thanks 

