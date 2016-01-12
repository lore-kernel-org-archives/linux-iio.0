Return-Path: <linux@rainbow-software.org>
From: Ondrej Zary <linux@rainbow-software.org>
To: Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH] iio: Add TH06 Humidity and Temperature sensor driver
Date: Tue, 12 Jan 2016 13:50:10 +0100
Cc: "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
 Cristina Moraru <cristina.moraru09@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>,
 "Lars-Peter Clausen" <lars@metafoo.de>,
 Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
 Matt Ranostaj <mranostay@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "octavian.purdila@intel.com" <octavian.purdila@intel.com>
References: <1452553042-4495-1-git-send-email-cristina.moraru09@gmail.com> <alpine.DEB.2.02.1601121158480.30757@pmeerw.net> <CAEnQRZBUkaFKLUZRQD3zDU4JyHbrBd+dv+vuZwMf5zjqogBijQ@mail.gmail.com>
In-Reply-To: <CAEnQRZBUkaFKLUZRQD3zDU4JyHbrBd+dv+vuZwMf5zjqogBijQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201601121350.11076.linux@rainbow-software.org>
List-ID: <linux-iio@vger.kernel.org>

On Tuesday 12 January 2016, Daniel Baluta wrote:
> On Tue, Jan 12, 2016 at 1:07 PM, Peter Meerwald-Stadler
>
> <pmeerw@pmeerw.net> wrote:
> >> Add implementation for Hoperf TH06 Humidity and Temperature
> >> sensor driver.
> >>
> >> Datasheet: http://www.hoperf.com/upload/sensor/TH06_Module_v01.pdf
> >
> > I think it would be good to make to manufacturer's company name (Hoperf)
> > more visible in the driver; it is currently just mentioned in the commit
> > message; just 'TH06' is hard to google :)
> >
> > maybe you could list the TODOs / unsupported features here...
> >
> > the I2C register layout looks close to the si7020, maybe the chip can be
> > supported there without duplicating code?
>
> Yes, they look pretty similar. We can give it a try to add the support
> for TH06 into
> already existing code for si7020.
>
> There will be some fun with Kconfig part :). Any idea if Hoperf and
> Silabs are related
> companies :D.

Looks like TH06 is just a module with Si7020 chip. Try the "Read Electronic 
ID" and "Read Firmware Revision" commands from Si7020 datasheet.

-- 
Ondrej Zary
