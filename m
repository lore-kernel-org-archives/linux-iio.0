Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [PATCH] iio: acpi: Add ACPI0008 Ambient Light Sensor
Date: Thu, 30 Apr 2015 13:30:28 +0200
Cc: jic23@kernel.org,
 knaack.h@gmx.de,
 lars@metafoo.de,
 pmeerw@pmeerw.net,
 marxin.liska@gmail.com,
 rui.zhang@intel.com,
 linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <1430306845-7117-1-git-send-email-gabriele.mzt@gmail.com> <201504301144.36641.marex@denx.de> <2165669.Hd5jxiYFUm@xps13>
In-Reply-To: <2165669.Hd5jxiYFUm@xps13>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201504301330.29091.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

On Thursday, April 30, 2015 at 01:27:43 PM, Gabriele Mazzotta wrote:
> On Thursday 30 April 2015 11:44:36 Marek Vasut wrote:
> > On Wednesday, April 29, 2015 at 05:36:32 PM, Gabriele Mazzotta wrote:
> > [...]
> > 
> > > > > I'm sorry, I've just noticed that I haven't changed the value of
> > > > > realbits in acpi_als_channels. This makes me wonder what would be
> > > > > the proper value, given that this is a generic driver and all the
> > > > > information I have are those in the ACPI specification (which
> > > > > states what I reported here above).
> > > > > 
> > > > > Should I just set realbits to 32?
> > > > 
> > > > I believe the ALS reports only 16bit signel value, no ?
> > > > My observation with a strong coherent light source is that
> > > > the saturated sensor reported 0xffff .
> > > 
> > > Probably it's the same for me. I couldn't get to the point where
> > > ALI reports 0xffff, just really close, I will have to try with some
> > > stronger lights. However, looking at my ACPI table, I can see that
> > > the value returned by _ALI is just the composition of two 8 bits
> > > variables put side by side, so yes, I can say that even on my system
> > > it's a 16bit value.
> > 
> > What kind of hardware are you testing this on ?

Hi!

> Dell XPS13 9333.

Cool, even better :)

I tested it on the following hardware:
Acer W500
Retina MacBook Pro 10,1 
MacBook Air (I don't know the revision, sorry)

> > > The problem here is that I'm not sure we can assume this as true in
> > > general since the ACPI specification doesn't say anything.
> > 
> > Maybe someone more knowledgable can speak up.
> 
> I'm looking at some documentation from Microsoft [1] on how to use these
> sensors in Windows and values as high as 100,000 lux are mentioned.

I see, thank you for investigating !

> [1]
> https://msdn.microsoft.com/en-us/library/windows/hardware/dn613948%28v=vs.
> 85%29.aspx

Best regards,
Marek Vasut
