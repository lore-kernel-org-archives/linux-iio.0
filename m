Return-Path: <SRS0=qS1a=FK=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Fri, 16 Feb 2018 11:16:58 -0200
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "lars@metafoo.de" <lars@metafoo.de>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
Subject: Re: [PATCH] staging: iio/meter: add name to function definition
 arguments
Message-ID: <20180216131658.h7b2y2ckkucetnzj@smtp.gmail.com>
References: <20180216125041.qfvg7xtpulc54tk6@smtp.gmail.com>
 <1518785796.9517.25.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1518785796.9517.25.camel@nxp.com>
List-ID: <linux-iio@vger.kernel.org>

Hi Daniel

> Hi Rodrigo,
> 
> I think this is a nice finding. One comment inline:
> 
> On Vi, 2018-02-16 at 10:50 -0200, rodrigosiqueira wrote:
> > This patch fixes the checkpatch.pl warning:
> > 
> > drivers/staging/iio/meter/ade7854.h:157: WARNING: function definition
> > argument 'struct device *' should also have an identifier name...
> > 
> > +	int (*read_reg_32)(struct device *dev, u16 reg_address, u32 *val);
> > +	int (*write_reg_8)(struct device *dev, u16 reg_address, u8 value);
> 
> 
> Any particular reason for using val vs value? I get that one is a pointer
> and another a plain type, but I think the name should be the same.

Before I selected the name, I figure out that read_reg_* and write_reg_*
was assigned inside the iio/meter/ade7754-(i2c|spi).c files by function
like ade7754_*_read_reg_* and ade7754_*_write_reg_* .

I considered to use 'value' name for both functions parameters, however,
I noticed that function ade7754_*_write_reg_* adopted the name 'value'
for the last argument and ade7754_*_read_reg_* named the last argument
as 'val'. So, for consistency sake between the header file and the c
code, I decided to use the same parameter name patterns.


> thanks,
> Daniel.
>

Thanks 
