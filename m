Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:46232 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbeJ1W5T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Oct 2018 18:57:19 -0400
Date: Sun, 28 Oct 2018 14:12:28 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Victor Colombo <victorcolombo@gmail.com>
Cc: Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        linux-iio@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: Work plan on ad2s90
Message-ID: <20181028141228.2d338b7f@archlinux>
In-Reply-To: <CADGsZakW=0BRnuYx47mQVxzjcTbP+80wjaFt_ZB1pY3G6_TfQw@mail.gmail.com>
References: <CAHd-oW7fA_1H3jnUTOhs7VXJ3Zciq6j2WthAytE39NedYpTibg@mail.gmail.com>
        <20181023104554.155dcdcf@archlinux>
        <CADGsZakW=0BRnuYx47mQVxzjcTbP+80wjaFt_ZB1pY3G6_TfQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 26 Oct 2018 03:35:34 -0300
Victor Colombo <victorcolombo@gmail.com> wrote:

> Hi Jonathan,
> 
> Thank you for the insights! We have sent a patch set addressing the points
> you brought up, except the device tree one.
> 
> We didn't quite get what needs to be done on the device tree. Do you have
> some pointers to help us with that?
Sure.

Take a look at driver that has a table of type
struct of_device_id.

These ID's are very similar to the spi_device_id table that is already there
in the driver, just used to describe in the devices presence in device tree
tables.  For examples of those look in arch/arm/boot/dts/

Now except for a somewhat nasty hack in the spi and i2c subsystems the
intent is that we actually have 3 common ways of describing the presence
and connectivity of a device on a bus that cannot be enumerated (buses
like USB where you can query what is there don't need this magic - mostly.. :)

1) struct spi_device_id - original method used to instantiate a device from a
   description provided by a 'board_file'.  Examples that are still in tree
   include arch/arm/mach-pxa/stargate2.c which includes:

static struct spi_board_info spi_board_info[] __initdata = {
	{
		.modalias = "lis3l02dq",
		.max_speed_hz = 8000000,/* 8MHz max spi frequency at 3V */
		.bus_num = 1,
		.chip_select = 0,
		.controller_data = &staccel_chip_info,
		.irq = PXA_GPIO_TO_IRQ(96),
	}, {
		.modalias = "cc2420",
		.max_speed_hz = 6500000,
		.bus_num = 3,
		.chip_select = 0,
		.controller_data = &cc2420_info,
	},
};
..
	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
..

The problem was that we had a very rapid growth in the number of board files
which was becoming totally unmanageable.  There were lots of subtle variations
in how things were done and it was a complete mess.
Linus (and others) threw up their hands in horror and said this needed sorting.
As a lot of embedded platforms had few discoverable busses, a description had
to come from somewhere.  Devicetree is about moving that description out of
the kernel source and standardising it.

2) Devicetree bindings.  These are documented in Documentation/devicetree/bindings/
and the uses can be found in arch/arm/boot/dts/
They actually do a very similar job to the above board files, but in a format that
is purely descriptive, not a random mixture of descriptive structures and code.
>From a practical point of view the other change was that they are always supposed
to be given in the form manufacturer,partnumber rather than simply the part number
you see above.  This is due to the fact we were starting to see naming clashes
across manufacturers. 

Now the 'hack' that I think is sometimes regretted now, but was very useful at
the time, is that for spi and i2c there is some glue logic that, having failed
to match against a specfic devicetree binding provided by of_device_id, it
falls back to stripping off the naming before the comma and trying to match
against the version in spi_device_id.    Whilst this works, it gets rid of
that naming clash prevention that we got from the devicetree ID.  As such
there are never ending plans to get rid of spi_device_id entirely.  Not sure
it'll ever actually happen, but we certainly want to prepare for it!

3) ACPI.  This is the approach used on nearly all x86 machines and arm servers.
It's kind of like devicetree in the sense that the description is separate
from the code (no board files), but with some nasty corners such as the DSDT
table which provides this information actually containing code and using a
complex parser to handle all the weird corners.
For ACPI ids, the formats are only 8 characters consisting of a manufacturer
ID and a hex number that identifies the part.   As got pointed out in a
different thread there are numerous ACPI IDs that don't obey the naming
laid out in the spec.  Generally we just support the ones seen in the wild
for a particular part.   There are various ways of providing a DSDT table
other than getting it from a bios (which most people can't change - sadly
only a few manufacturers use an open source (ish) BIOS like EDK2) but they
are all meant for testing only, not for production systems.

For this device, it's unlikely to turn up on an
ACPI platform in the near future, so we don't need the ACPI binding.
The devicetree binding however is the most likely way the OS will discover
the device is there so that one should definitely be on our list before
we move it out of staging.

Jonathan

> 
> Best,
> Victor
> 
> Em ter, 23 de out de 2018 às 06:45, Jonathan Cameron <
> jic23@jic23.retrosnub.co.uk> escreveu:  
> 
> > On Fri, 19 Oct 2018 23:49:06 -0300
> > Matheus Tavares Bernardino <matheus.bernardino@usp.br> wrote:
> >  
> > > Hello everyone.  
> > Hi Matheus.  
> > >
> > > I'm looking at the code and datasheet of ad2s90, trying to understand
> > > what is needed to move it to the main tree. I and my study group
> > > intend to work on it.  
> >
> > Great,
> >  
> > >
> > > I do not understand all the necessary steps yet, but I will present
> > > here some brief items for discussion. I'd like to ask if I'm on the
> > > right track. All feedback will be much appreciated.
> > >
> > > Some of the things that I think need to be done:
> > > - The IIO_CHAN_INFO_SCALE information mask is not set yet  
> > Good point, that should be possible to establish for a resolver.
> >  
> > > - The read_raw function does not return the error code returned by
> > > spi_read on failure  
> > Good spot (I missed that one at first glance ;)
> >  
> > > - There is no channel for velocity yet  
> >
> > I'm fairly sure that's because the device doesn't allow you to read that
> > via the serial bus.  There is an analog velocity outlook so you could
> > read it via an ADC and do the appropriate chaining of IIO devices
> > to provide that in this driver, but I wouldn't necessarily suggest doing
> > that without some hardware to test it.
> >  
> > > - There are two minor codestyle corrections to be made
> > > - Maybe it's possible to change the bit operations at the read_raw for
> > > a bitops.h function call  
> > Not really.  It is a weird form of shifted endian conversion, so you
> > 'could' do it that way and in theory make it a single shift in once case
> > and swap and shift in the other.  Probably not worth it though.
> >
> > a few additions.
> > * Devicetree support with standard devicetree id table.
> >
> > * The spi setup at the end of probe occurs 'after' the device is ready
> > for use.  A definite race condition that needs fixing.
> >
> > * Some pointless variable initial assignments that are always overwritten.
> >  
> > >
> > > Best regards,
> > > Matheus  
> >
> > Thanks,
> >
> > Jonathan
> >  
