Return-Path: <matheus.bernardino@usp.br>
MIME-Version: 1.0
References: <CAHd-oW7fA_1H3jnUTOhs7VXJ3Zciq6j2WthAytE39NedYpTibg@mail.gmail.com>
 <20181023104554.155dcdcf@archlinux> <CADGsZakW=0BRnuYx47mQVxzjcTbP+80wjaFt_ZB1pY3G6_TfQw@mail.gmail.com>
 <20181028141228.2d338b7f@archlinux>
In-Reply-To: <20181028141228.2d338b7f@archlinux>
From: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date: Sun, 4 Nov 2018 14:34:35 -0200
Message-ID: <CAHd-oW7R-iWKUnfjTBcswtayuidhC=qTiLyZKsuMxym7eceRPQ@mail.gmail.com>
Subject: Re: Work plan on ad2s90
To: jic23@jic23.retrosnub.co.uk
Cc: Victor Colombo <victorcolombo@gmail.com>, linux-iio@vger.kernel.org,
	kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

thanks a lot for the detailed explanation. As I was browsing the
Documentation/devicetree/bindings/iio dir, I realized that ad2s1200,
which is already in the main tree, doesn't have a binding
documentation (nor any of the resolver drivers at staging). Should I
write a documentation for ad2s90 or just add the of_device_id section
in the driver's code? Also, if it should be written, it has to go
under Documentation/devicetree/bindings/staging/iio/resolver, right?

Matheus.

On Sun, Oct 28, 2018 at 11:12 AM Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
> On Fri, 26 Oct 2018 03:35:34 -0300
> Victor Colombo <victorcolombo@gmail.com> wrote:
>
> > Hi Jonathan,
> >
> > Thank you for the insights! We have sent a patch set addressing the poi=
nts
> > you brought up, except the device tree one.
> >
> > We didn't quite get what needs to be done on the device tree. Do you ha=
ve
> > some pointers to help us with that?
> Sure.
>
> Take a look at driver that has a table of type
> struct of_device_id.
>
> These ID's are very similar to the spi_device_id table that is already th=
ere
> in the driver, just used to describe in the devices presence in device tr=
ee
> tables.  For examples of those look in arch/arm/boot/dts/
>
> Now except for a somewhat nasty hack in the spi and i2c subsystems the
> intent is that we actually have 3 common ways of describing the presence
> and connectivity of a device on a bus that cannot be enumerated (buses
> like USB where you can query what is there don't need this magic - mostly=
.. :)
>
> 1) struct spi_device_id - original method used to instantiate a device fr=
om a
>    description provided by a 'board_file'.  Examples that are still in tr=
ee
>    include arch/arm/mach-pxa/stargate2.c which includes:
>
> static struct spi_board_info spi_board_info[] __initdata =3D {
>         {
>                 .modalias =3D "lis3l02dq",
>                 .max_speed_hz =3D 8000000,/* 8MHz max spi frequency at 3V=
 */
>                 .bus_num =3D 1,
>                 .chip_select =3D 0,
>                 .controller_data =3D &staccel_chip_info,
>                 .irq =3D PXA_GPIO_TO_IRQ(96),
>         }, {
>                 .modalias =3D "cc2420",
>                 .max_speed_hz =3D 6500000,
>                 .bus_num =3D 3,
>                 .chip_select =3D 0,
>                 .controller_data =3D &cc2420_info,
>         },
> };
> ..
>         spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info=
));
> ..
>
> The problem was that we had a very rapid growth in the number of board fi=
les
> which was becoming totally unmanageable.  There were lots of subtle varia=
tions
> in how things were done and it was a complete mess.
> Linus (and others) threw up their hands in horror and said this needed so=
rting.
> As a lot of embedded platforms had few discoverable busses, a description=
 had
> to come from somewhere.  Devicetree is about moving that description out =
of
> the kernel source and standardising it.
>
> 2) Devicetree bindings.  These are documented in Documentation/devicetree=
/bindings/
> and the uses can be found in arch/arm/boot/dts/
> They actually do a very similar job to the above board files, but in a fo=
rmat that
> is purely descriptive, not a random mixture of descriptive structures and=
 code.
> From a practical point of view the other change was that they are always =
supposed
> to be given in the form manufacturer,partnumber rather than simply the pa=
rt number
> you see above.  This is due to the fact we were starting to see naming cl=
ashes
> across manufacturers.
>
> Now the 'hack' that I think is sometimes regretted now, but was very usef=
ul at
> the time, is that for spi and i2c there is some glue logic that, having f=
ailed
> to match against a specfic devicetree binding provided by of_device_id, i=
t
> falls back to stripping off the naming before the comma and trying to mat=
ch
> against the version in spi_device_id.    Whilst this works, it gets rid o=
f
> that naming clash prevention that we got from the devicetree ID.  As such
> there are never ending plans to get rid of spi_device_id entirely.  Not s=
ure
> it'll ever actually happen, but we certainly want to prepare for it!
>
> 3) ACPI.  This is the approach used on nearly all x86 machines and arm se=
rvers.
> It's kind of like devicetree in the sense that the description is separat=
e
> from the code (no board files), but with some nasty corners such as the D=
SDT
> table which provides this information actually containing code and using =
a
> complex parser to handle all the weird corners.
> For ACPI ids, the formats are only 8 characters consisting of a manufactu=
rer
> ID and a hex number that identifies the part.   As got pointed out in a
> different thread there are numerous ACPI IDs that don't obey the naming
> laid out in the spec.  Generally we just support the ones seen in the wil=
d
> for a particular part.   There are various ways of providing a DSDT table
> other than getting it from a bios (which most people can't change - sadly
> only a few manufacturers use an open source (ish) BIOS like EDK2) but the=
y
> are all meant for testing only, not for production systems.
>
> For this device, it's unlikely to turn up on an
> ACPI platform in the near future, so we don't need the ACPI binding.
> The devicetree binding however is the most likely way the OS will discove=
r
> the device is there so that one should definitely be on our list before
> we move it out of staging.
>
> Jonathan
>
> >
> > Best,
> > Victor
> >
> > Em ter, 23 de out de 2018 =C3=A0s 06:45, Jonathan Cameron <
> > jic23@jic23.retrosnub.co.uk> escreveu:
> >
> > > On Fri, 19 Oct 2018 23:49:06 -0300
> > > Matheus Tavares Bernardino <matheus.bernardino@usp.br> wrote:
> > >
> > > > Hello everyone.
> > > Hi Matheus.
> > > >
> > > > I'm looking at the code and datasheet of ad2s90, trying to understa=
nd
> > > > what is needed to move it to the main tree. I and my study group
> > > > intend to work on it.
> > >
> > > Great,
> > >
> > > >
> > > > I do not understand all the necessary steps yet, but I will present
> > > > here some brief items for discussion. I'd like to ask if I'm on the
> > > > right track. All feedback will be much appreciated.
> > > >
> > > > Some of the things that I think need to be done:
> > > > - The IIO_CHAN_INFO_SCALE information mask is not set yet
> > > Good point, that should be possible to establish for a resolver.
> > >
> > > > - The read_raw function does not return the error code returned by
> > > > spi_read on failure
> > > Good spot (I missed that one at first glance ;)
> > >
> > > > - There is no channel for velocity yet
> > >
> > > I'm fairly sure that's because the device doesn't allow you to read t=
hat
> > > via the serial bus.  There is an analog velocity outlook so you could
> > > read it via an ADC and do the appropriate chaining of IIO devices
> > > to provide that in this driver, but I wouldn't necessarily suggest do=
ing
> > > that without some hardware to test it.
> > >
> > > > - There are two minor codestyle corrections to be made
> > > > - Maybe it's possible to change the bit operations at the read_raw =
for
> > > > a bitops.h function call
> > > Not really.  It is a weird form of shifted endian conversion, so you
> > > 'could' do it that way and in theory make it a single shift in once c=
ase
> > > and swap and shift in the other.  Probably not worth it though.
> > >
> > > a few additions.
> > > * Devicetree support with standard devicetree id table.
> > >
> > > * The spi setup at the end of probe occurs 'after' the device is read=
y
> > > for use.  A definite race condition that needs fixing.
> > >
> > > * Some pointless variable initial assignments that are always overwri=
tten.
> > >
> > > >
> > > > Best regards,
> > > > Matheus
> > >
> > > Thanks,
> > >
> > > Jonathan
> > >
>
