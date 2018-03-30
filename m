Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbeC3JRE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 30 Mar 2018 05:17:04 -0400
Date: Fri, 30 Mar 2018 10:16:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: John Syne <john3909@gmail.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>, daniel.baluta@nxp.com,
        Mark Brown <broonie@kernel.org>
Subject: Re: meter ABI: (was Re: [PATCH v2 1/3] staging:iio:meter: Replaces
 IIO_DEV_ATTR_CH_OFF by IIO_DEVICE_ATTR)
Message-ID: <20180330101658.0c891804@archlinux>
In-Reply-To: <DEF2F80D-110C-4A63-8A4D-2354F95BA6D6@gmail.com>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
        <3af0e5a795059a8418cf08ff29f05f8d5e00da9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
        <20180307200730.08ed3c2f@archlinux>
        <20180309003733.aichruo53vqryafg@smtp.gmail.com>
        <20180310151045.4570e85d@archlinux>
        <79D3051B-FF2F-4DD3-AF75-F6A4BAD81838@gmail.com>
        <20180317203037.1093cc11@archlinux>
        <A8E3184B-765B-4730-A076-C3FCF487EAE3@gmail.com>
        <20180318122312.0d395367@archlinux>
        <F6FE75D3-5289-4675-9345-F46CABEFA99E@gmail.com>
        <20180324151829.7d03ad15@archlinux>
        <6490BA61-EF6F-4407-A5A2-26B7E86B0629@gmail.com>
        <20180325175430.3f60741f@archlinux>
        <DEF2F80D-110C-4A63-8A4D-2354F95BA6D6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 25 Mar 2018 13:53:02 -0700
John Syne <john3909@gmail.com> wrote:

> > On Mar 25, 2018, at 9:54 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> > 
> > On Sun, 25 Mar 2018 01:29:41 -0700
> > John Syne <john3909@gmail.com> wrote:
> >   
> >> Hi Jonathan,  
> > Hi John,
> > 
> > Please wrap your normal emails (excepting tables) to 80 chars.  
> Yeah, I’m trying to do that, but I use a Mac and Apple Mail doesn’t
> have a feature to wrap at 80 automatically so I have to do
> this manually.
> >   
> >> 
> >> I was speaking with Rodrigo and here is what I think must be done to move
> >> ADE7878 out of staging
> >> 
> >> Here are the steps as I see them:
> >> 
> >> 1) Define the IIO Attributes so they are consistent with the IIO ABI. This
> >>   should be pretty simple given agreement on the naming convention.  
> > Please don't go just changing attribute names - the driver needs to
> > use the standard approach of iio_chan_spec and create the vast
> > majority of attributes automatically via that.  There 'may' be
> > a few corner cases wee don't want to make generic and they 'might'
> > be exposed as attributes.
> > 
> > I suspect this change is the 'big' job.  The core support necessary
> > for RMS and MAV (computedtype or whatever we call it) will need adding
> > as well.  That is a separate patch set with support for some examples
> > in the dummy driver.  
> Great that you mentioned this, because I though we only needed to
> modify the IIO_ATTR naming. I’ll take a look at iio_chan_spec and
> the examples in the dummy driver.

That is how it was originally done and this is an 'old' driver,
but the chan spec stuff does three things :
1) Saves on lots of boiler plate code.
2) Makes it sane to access the device from other driver (hwmon now does something
similar btw).
3) Avoids a lot of ABI typos and careful review.

> >   
> >> 2) Map the ADE7854 interrupt status to IIO events. This requires an
> >>   interrupt processing section.
> >> 3) Add DeviceTree support.
> >> 4) Create DeviceTree overlay for the ADE7854.  
> > More a case of bindings for now.  If those are used via an overlay
> > fine but given we don't have any boards with one one in mainline,
> > this is an implementation detail for the user rather than part
> > of moving this driver out of staging.  
> I was thinking more along the lines of documentation to show a
> developer what was needed to get the driver working.
Do it as an example in the device tree bindings doc.

> >   
> >> 5) Update ADE7854 probe to read in the DeviceTree register settings.
> >> 6) Add support for power modes (PM1, PM2).  
> > This isn't necessary for a move out of staging (nice to have though).
> >   
> >> 7) Not sure if we will support measurement streaming on the ADE7854.
> >>   The problem is ADE7854 is designed as an SPI master, which means
> >>   it controls the SPI clock, so the driver must support SPI slave
> >>   mode. However, the Linux Kernel does not currently support SPI
> >>   slave mode. We have three choices to make this work and they
> >>   are all a lot of work: 1) Add support for SPI Slave mode to the
> >>   kernel,  2) Use hardware to convert SPI signals to I2S signals
> >>   and with the use of a custom codec, use the ALSA framework to
> >>   stream the samples (this is an approach I used, but I don’t like
> >>   it), 3) Move the I2S driver out of the sound subsystem and use it
> >>   together with DMA to stream samples directly into the ADE7854 driver
> >>   (my preferred solutions). Perhaps Mark Brown has some ideas on how
> >>    to make this work.   
> > I'll be honest, this is an end of line part and frankly more than
> > a little crazy. I would go with simply not supporting the measurement
> > streaming at all for this part.  If you really need it we can then
> > move onto the how part, but from what you have said I'm guessing you
> > don't care except in an abstract 'it would be nice' sort of a way?  
> Yeah, I’m moving to the ADE9000 so I’ll drop this.
Agreed.  We let someone else pick it up if they care.

> >   
> >> 
> >> The ADE9000 will be much easier because it uses an SPI Slave interface. 
> >> 
> >> I hope I have captured everything, but let me know if I have missed anything.
> >>   
> > 
> > That will do for now ;)  I'm sure there will be details that need
> > tidying up once we have the above done, but that's true for any new
> > driver (and this will be nearly a new driver before things are done).  
> Thank you again for all the detailed feedback.
> > 
> > Jonathan  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

