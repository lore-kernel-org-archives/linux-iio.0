Return-Path: <SRS0=QyRP=M4=rockwellcollins.com=paresh.chaudhary@kernel.org>
MIME-Version: 1.0
References: <1539275890-38141-1-git-send-email-matthew.weber@rockwellcollins.com>
 <1539275890-38141-2-git-send-email-matthew.weber@rockwellcollins.com> <20181013145424.63fec888@archlinux>
In-Reply-To: <20181013145424.63fec888@archlinux>
From: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Date: Tue, 16 Oct 2018 17:16:15 -0500
Message-ID: <CAGSBOwYD1Y6LV4C+AuZiAY_6cE5Jr9Y0mU73+-DHm97RfARqxw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio:temperature:max31856:Add device tree bind info
To: jic23@kernel.org
Cc: Matthew Weber <matthew.weber@rockwellcollins.com>, linux-iio@vger.kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

Please find my comment inline.

Thanks,
Paresh

On Sat, Oct 13, 2018 at 8:54 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 11 Oct 2018 11:38:10 -0500
> Matt Weber <matthew.weber@rockwellcollins.com> wrote:
>
> > From: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> >
> > This patch added device tree binding info for MAX31856 driver.
> >
> > Signed-off-by: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> > Signed-off-by: Matt Weber <matthew.weber@rockwellcollins.com>
> Device tree bindings should be cc'd to the devicetree list and maintainers.
>
> Thanks,
>
> Jonathan
>
> > ---
> > Changes v1 -> v2
> > [Matt
> >  - Removed comment block and added possibilities of
> >    thermocouple type in device tree binding doc.
> >
> > ---
> >  .../bindings/iio/temperature/max31856.txt          | 32 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 33 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/temperature/max31856.txt
> >
> > diff --git a/Documentation/devicetree/bindings/iio/temperature/max31856.txt b/Documentation/devicetree/bindings/iio/temperature/max31856.txt
> > new file mode 100644
> > index 0000000..e1def9f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/temperature/max31856.txt
> > @@ -0,0 +1,32 @@
> > +Maxim MAX31856 thermocouple support
> > +
> > +https://datasheets.maximintegrated.com/en/ds/MAX31856.pdf
> > +
> > +Required properties:
> > +     - compatible: must be "max31856"
> > +     - reg: SPI chip select number for the device
> > +     - spi-max-frequency: As per datasheet max. supported freq is 5000000
> > +     - spi-cpha: must be defined for max31856 to enable SPI mode 1
> > +     - type: Type of thermocouple (By default is K-Type)
> > +             0x00 : TYPE_B
> > +             0x01 : TYPE_E
> > +             0x02 : TYPE_J
> > +             0x03 : TYPE_K (default)
> > +             0x04 : TYPE_N
> > +             0x05 : TYPE_R
> > +             0x06 : TYPE_S
> > +             0x07 : TYPE_T
> > +
> > +     Refer to spi/spi-bus.txt for generic SPI slave bindings.
> > +
> > +Optional properties:
> > +     - one-shot: Enable one-shot Conversion mode (By default mode is auto)
>
> Why is this something that should be in devicetree rather than controlled
> in the driver in response to some userspace interaction?
>
>
There is no specific reason. This is just providing info to the driver
so the driver can configure chip while probe for specified mode.
I understand your concern but as of now, the driver does not have
support to decide mode based on userspace interaction. We will work on
that when we reopen for enhancement (e.g threshold for temp. range)
> > +
> > + Example:
> > +     max31856@0 {
> > +             compatible = "max31856";
> > +             reg = <0>;
> > +             spi-max-frequency = <5000000>;
> > +             spi-cpha;
> > +             type = <0x03>;
> > +     };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index dd9a83d..6482ae8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7161,6 +7161,7 @@ MAX31856 IIO DRIVER
> >  M:   Matthew Weber <matthew.weber@rockwellcollins.com>
> >  S:   Maintained
> >  F:   drivers/iio/temperature/max31856.c
> > +F:   Documentation/devicetree/bindings/iio/temperature/max31856.txt
> >
> >  IIO UNIT CONVERTER
> >  M:   Peter Rosin <peda@axentia.se>
>
