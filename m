Return-Path: <prvs=03571e9363=mike.looijmans@topicproducts.com>
Subject: Re: "Generic" MMIO ADC
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	<devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>
References: <b60def9a-45dc-bf97-e059-abbe105648b2@topic.nl>
 <20170630145319.20ec3696@jic23.retrosnub.co.uk>
From: Mike Looijmans <mike.looijmans@topic.nl>
Message-ID: <b9dc2313-53da-1566-c0e8-ac18599f59da@topic.nl>
Date: Mon, 3 Jul 2017 14:37:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170630145319.20ec3696@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

=EF=BB=BFOn 30-06-17 15:53, Jonathan Cameron wrote:
> On Fri, 30 Jun 2017 10:44:42 +0200
> Mike Looijmans <mike.looijmans@topic.nl> wrote:
>=20
>> =EF=BB=BFI'm writing an IIO driver for a custom IP, which is pretty simp=
le:
>>
>> - Map the registers to memory and register IRQ routine
>> - To start acquisition, write a value to the config register
>> - On interrupt, read data register, push it into queue
>> - To stop, write another value to config.
>>
>> Would it be useful to provide this as a generic driver in Linux, so that=
 you
>> can provide the config register and data register offsets and values in =
the
>> devicetree? That would make it work on a lot of similar project without
>> everyone coding the same thing.
>=20
> Hi Mike,
>=20
> I've brought in the devicetree bindings maintainers and list as well on t=
his
> discussion because in many ways it's more about the strategy on bindings
> than the actual driver...  Also Linus Walleij for any experience handing
> the gpio-mmio driver which strikes me as fairly similar in aim.
>=20
> To the driver question, yes absolutely this would be a good thing to have=
.
> The majority of ADCs out there are irritatingly more complex than what
> you have.  Everyone seems to feel obliged to put in their own 'special
> sauce'.
>=20
> As for bindings, there are two options, either we
>=20
> 1) As you suggest push all differences between different parts into the
> bindings.  Note we'll still need a compatible list in the driver.
> So this is something like gpio-mmio.c
>=20
> 2) Do something similar to the irq generic_chip (CONFIG_GENERIC_IRQ)
> infrastructure and actually have very slim wrapper drivers around a
> library.   That allows those elements that are constrained by the
> hardware to not need specifying in device tree bindings.
>=20
>>
>> And a related question: Is there a driver that's close to this?
> I can't immediately think of one, but it's possible that one
> of the SoC ADC drivers is simple enough to describe this way.
>=20
> So Mark / Rob.  You guys have experience with how the bindings
> worked out for each approach.  Which do you prefer?
> Either approach is fine with me.
>=20
> Mike, perhaps you have an initial cut of some bindings that might
> help the discussion to move along?

I was thinking along these lines:

... {
    compatible =3D "iio-adc-generic-mmio";
    reg =3D <0x43210000 4096>;
    interrupt =3D <&gic 42 0>;
    iio,start-sequence =3D <0x0 0x3> <0x4 0xff>;
    iio,stop-sequence =3D <0x0 0x0>;
    iio,data-register =3D <0x10>;
};

Required:
   compatible: must be "iio-adc-generic-mmio";
   reg: Memory address and range of IP platform device
   interrupt: Data-ready interrupt binding

Optional:
   iio,data-register: Offset where to read data. Defaults to <0>.
   iio,start-sequence: Array of <offset value> pairs. On start of acquisiti=
on
                       the driver writes each value to each offset in order=
.
   iio,stop-sequence: Array of <offset value> pairs to stop acquisition.


And we could make up more properties as we go, like the number of valid dat=
a=20
bits and shift, interrupt rate and fifo buffer properties...

We could add normal clock and power supply bindings as well, so it would=20
enable them on starting data acquisition.


For now the bad news is that the project was put on hold, so I'm not allowe=
d=20
to spend serious development time now.


Kind regards,

Mike Looijmans
System Expert

TOPIC Products
Materiaalweg 4, NL-5681 RJ Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
E-mail: mike.looijmans@topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
