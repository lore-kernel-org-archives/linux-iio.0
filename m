Return-Path: <SRS0=8l0C=YF=perches.com=joe@kernel.org>
Message-ID: <1482369030.1945.3.camel@perches.com>
Subject: Re: [PATCH] indention and space fixes to align with linux style
From: Joe Perches <joe@perches.com>
To: Scott Matheina <scott@matheina.com>, gregkh@linuxfoundation.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date: Wed, 21 Dec 2016 17:10:30 -0800
In-Reply-To: <518f5c19-26f3-9896-64c8-ec2a2b592c5c@matheina.com>
References: <1482289187-7276-1-git-send-email-scott@matheina.com>
	 <1482290625.1984.33.camel@perches.com>
	 <518f5c19-26f3-9896-64c8-ec2a2b592c5c@matheina.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Wed, 2016-12-21 at 19:02 -0600, Scott Matheina wrote:
> On 12/20/2016 09:23 PM, Joe Perches wrote:
> > On Tue, 2016-12-20 at 20:58 -0600, Scott Matheina wrote:
> > > Fixed indention and space issues to align the code with the linux style guide.
> > []
> > > diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> > []
> > > @@ -176,16 +176,16 @@
> > >    */
> > > 
> > >   struct adt7316_chip_info {
> > > -	struct adt7316_bus	bus;
> > > -	u16			ldac_pin;
> > > -	u16			int_mask;	/* 0x2f */
> > > -	u8			config1;
> > > -	u8			config2;
> > > -	u8			config3;
> > > -	u8			dac_config;	/* DAC config */
> > > -	u8			ldac_config;	/* LDAC config */
> > > -	u8			dac_bits;	/* 8, 10, 12 */
> > > -	u8			id;		/* chip id */
> > > +	struct adt7316_bus bus;
> > > +	u16 ldac_pin;
> > > +	u16 int_mask;		/* 0x2f */
> > > +	u8 config1;
> > > +	u8 config2;
> > > +	u8 config3;
> > > +	u8 dac_config;		/* DAC config */
> > > +	u8 ldac_config;		/* LDAC config */
> > > +	u8 dac_bits;		/* 8, 10, 12 */
> > > +	u8 id;			/* chip id */
> > >   };
[]
> > The style above is fine and doesn't need
> > to be changed.  It is not in CodingStyle
> > as preferred one way or the other.
[]
> The problem I'm running into is when I use Lindent, it automatically 
> makes the
> change above, so I can't use that tool for the file. Even when I correct 
> the changes
> in the file git diff still shows the non-change, so I'm just trying to 
> figure out how
> to use the given tools without having these issues. I'm going to just go 
> manual with
> my future changes is suppose.

Lindent isn't actually a very good source code reformatter
for Linux kernel code.

checkpatch can perform some of these transformations with
the --fix or --fix-inplace option.

Making changes for human readability of the source code
is generally good.

It's OK to start to read and familiarize yourself the the
kernel styles by using these tools, but better is to find
and fix actual defects in code instead of producing
whitespace changes that don't actually create any compiler
output differences.

Welcome in any case.
