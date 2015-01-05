Return-Path: <joe@perches.com>
Message-ID: <1420476166.2652.14.camel@perches.com>
Subject: Re: [PATCH V1 1/1] iio: Added Capella cm3232 ambient light sensor
 driver.
From: Joe Perches <joe@perches.com>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: Kevin Tsai <ktsai@capellamicro.com>, Wolfram Sang <wsa@the-dreams.de>,
 Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark
 Rutland <mark.rutland@arm.com>,  Ian Campbell
 <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 Grant Likely <grant.likely@linaro.org>, Andrew Morton
 <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab
 <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Archana Patni
 <archana.patni@linux.intel.com>, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Date: Mon, 05 Jan 2015 08:42:46 -0800
In-Reply-To: <CAEnQRZBmwurFCJU4E4ArO8waU+YcGWrRYr3DRVxq9haduX2t=w@mail.gmail.com>
References: <1420071030-888-1-git-send-email-ktsai@capellamicro.com>
	 <CAEnQRZBD2NMYRp1cW0J2ssT4CT=0jSM=X6ByHQiUrA0ueV8fRA@mail.gmail.com>
	 <1420463396.2652.8.camel@perches.com>
	 <CAEnQRZBmwurFCJU4E4ArO8waU+YcGWrRYr3DRVxq9haduX2t=w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Mon, 2015-01-05 at 16:20 +0200, Daniel Baluta wrote:
> On Mon, Jan 5, 2015 at 3:09 PM, Joe Perches <joe@perches.com> wrote:
> > On Mon, 2015-01-05 at 12:51 +0200, Daniel Baluta wrote:
> >> On Thu, Jan 1, 2015 at 2:10 AM, Kevin Tsai <ktsai@capellamicro.com> wrote:
> >> > CM3232 is an advanced ambient light sensor with I2C protocol interface.
> >> > The I2C slave address is internally hardwired as 0x10 (7-bit).  Writing
> >> > to configure register is byte mode, but reading ALS register requests to
> >> > use word mode for 16-bit resolution.
[]
> >> You could directly return i2c_smbus_write_byte_data(..).
> >
> > Sometimes it's better to return a specific value
> > for the error instead of depending on correctness
> > of all the indirect functions in the call chain.
> >
> > In this case, all the smbus_xfer functions must
> > return 0 on success.  Do they?
> 
> Yes.
> 
> http://lxr.free-electrons.com/source/drivers/i2c/i2c-core.c#L2845

This doesn't show that adapter->algo->smbus_xfer()
returns 0, you have to look at the code for that
indirectly called function. 

> Also, I guess kbuild test robot will complain about it, like here:
> 
> http://marc.info/?l=linux-kernel&m=141963536230419&w=2

Is the kbuild test robot now submitting patches for all
possible coccinelle simplifications?  I don't think so.
