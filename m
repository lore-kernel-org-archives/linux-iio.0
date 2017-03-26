Return-Path: <SRS0=81wB=3D=jic23.retrosnub.co.uk=jic23@kernel.org>
Date: Sun, 26 Mar 2017 10:18:04 +0100
In-Reply-To: <CAMuHMdWojCNtJBQxP6E+hdscCQ7U28RGWsPfhXidxJDu-aTQOw@mail.gmail.com>
References: <1490369323-13866-1-git-send-email-jacopo+renesas@jmondi.org> <CAMuHMdWojCNtJBQxP6E+hdscCQ7U28RGWsPfhXidxJDu-aTQOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH v3 0/4] iio: adc: Maxim max9611 driver
To: Geert Uytterhoeven <geert@linux-m68k.org>,Jacopo Mondi <jacopo+renesas@jmondi.org>,Jonathan Cameron <jic23@kernel.org>
CC: Wolfram Sang <wsa+renesas@sang-engineering.com>,Magnus Damm <magnus.damm@gmail.com>,Laurent Pinchart <laurent.pinchart@ideasonboard.com>,Hartmut Knaack <knaack.h@gmx.de>,Lars-Peter Clausen <lars@metafoo.de>,Peter Meerwald <pmeerw@pmeerw.net>,Rob Herring <robh+dt@kernel.org>,Mark Rutland <mark.rutland@arm.com>,linux-iio@vger.kernel.org,Linux-Renesas <linux-renesas-soc@vger.kernel.org>,"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <26ADB8F7-CC86-450B-9C78-EDEFF4880C11@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 26 March 2017 10:07:58 BST, Geert Uytterhoeven <geert@linux-m68k=2Eorg>=
 wrote:
>Hi Jacopo, Jonathan,
>
>On Fri, Mar 24, 2017 at 4:28 PM, Jacopo Mondi
><jacopo+renesas@jmondi=2Eorg> wrote:
>> Third round for Maxim max9611/max9612 high-side current sense
>amplifier driver=2E
>>
>> For reference, a simplified integration schematic drawing is here
>reported:
>>
>>  ----o----/\/\/-----o-------|LOAD|---
>>      |    shunt     |
>>  ____|______________|___
>>  |  RS+            RS-  |
>>  |   |-----gain-----|   |
>>  |          |           |
>>  |          |           |
>>  |max9611   |->| ADC |=3D=3D=3D=3D=3D I2c
>>  |______________________|
>>
>> public datasheet available at
>> https://datasheets=2Emaximintegrated=2Ecom/en/ds/MAX9611-MAX9612=2Epdf
>>
>> In v2 all channels whose values are calculated using parameters
>> depending on the applied gain have been transformed in "processed"
>channels=2E
>>
>> In v3 fixed DT bindings to use a more generic name for ADC nodes, and
>shunt
>> resistor description property=2E
>>
>> output reported from iio_info tool:
>> iio:device0: max9611_vdd
>>                 6 channels found:
>>                         voltage0:  (input)
>>                         1 channel-specific attributes found:
>>                                 attr 0: input value: 4=2E085000000
>>                         voltage1:  (input)
>>                         3 channel-specific attributes found:
>>                                 attr 0: scale value: 14
>>                                 attr 1: offset value: 1
>>                                 attr 2: raw value: 59
>>                         shunt:  (input)
>>                         2 channel-specific attributes found:
>>                                 attr 0: resistor_power value: 5000
>>                                 attr 1: resistor_current value: 5000
>>                         power:  (input)
>>                         1 channel-specific attributes found:
>>                                 attr 0: input value: 663=2E404000000
>>                         temp:  (input)
>>                         2 channel-specific attributes found:
>>                                 attr 0: scale value: 0=2E480076812
>>                                 attr 1: raw value: 59
>>                         current:  (input)
>>                         1 channel-specific attributes found:
>>                                 attr 0: input value: 817=2E000000000
>
>I'm a bit puzzled about Jonathan's request to have two separate
>attributes
>for the single shunt resistor value=2E  While they do apply to two
>calculated
>channels, they're the same physical property, and can never be
>different=2E

Yes but under abi any attribute with no channel as part of name applies to=
 all input channels=2E
On the inside part kind of sensible as sort of applies to all=2E

Here we would have a shunt on the temperature channel=2E=2E=2E




>
>Furthermore, in the above output they do not show up as attributes of
>the
>"power" and "current" channels, but as attributes of a separate "shunt"
>channel=2E Is that intentional?
>
Shouldn't be own channels, naming currently wrong=2E I raised that in revi=
ew=2E

>For comparison, with ina226 on BayLibre ACME, which uses a similar
>configuration, I get:
>
>    iio:device0: ina226
>        5 channels found:
>            voltage0:  (input)
>            6 channel-specific attributes found:
>                attr 0: scale value: 0=2E002500000
>                attr 1: raw value: 979
>                attr 2: integration_time value: 0=2E001100
>                attr 3: index value: 0
>                attr 4: en value: 0
>                attr 5: type value: le:u16/16>>0
>            voltage1:  (input)
>            6 channel-specific attributes found:
>                attr 0: integration_time value: 0=2E001100
>                attr 1: raw value: 4007
>                attr 2: scale value: 1=2E250000000
>                attr 3: en value: 0
>                attr 4: index value: 1
>                attr 5: type value: le:u16/16>>0
>            power2:  (input)
>            5 channel-specific attributes found:
>                attr 0: raw value: 49
>                attr 1: scale value: 25=2E000000000
>                attr 2: index value: 2
>                attr 3: type value: le:u16/16>>0
>                attr 4: en value: 0
>            current3:  (input)
>            5 channel-specific attributes found:
>                attr 0: scale value: 1
>                attr 1: raw value: 245
>                attr 2: type value: le:u16/16>>0
>                attr 3: index value: 3
>                attr 4: en value: 0
>            timestamp:  (input)
>            3 channel-specific attributes found:
>                attr 0: type value: le:s64/64>>0
>                attr 1: index value: 4
>                attr 2: en value: 0
>        6 device-specific attributes found:
>                attr 0: in_oversampling_ratio value: 4
>                attr 1: in_shunt_resistor value: 10000
>                attr 2: in_allow_async_readout value: 0
>                attr 3: integration_time_available value: 0=2E000140
>0=2E000204 0=2E000332 0=2E000588 0=2E001100 0=2E002116 0=2E004156 0=2E008=
244
>                attr 4: in_sampling_frequency value: 114
>                attr 5: in_active value: 1
>
>(note that the last "in_active" property does not exist in the mainline
> version of the driver)=2E
>
>Here the shunt resistor value is a (single) device-specific attribute,
>which
>makes more sense to me, as in-se the shunt resistor value is not a
>property
>of just the "current" and "power" channels, but a property of the
>(external)
>device configuration=2E
Sort of but userspace will be dumb about it and apply it to all channels=
=2E Only reason this isn't=20
happening here is userspace doesn't know about it=2E

So arguably we got it slightly wrong here=2E=2E=2E

J
>
>Thanks!
>
>Gr{oetje,eeting}s,
>
>                        Geert
>
>--
>Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
>geert@linux-m68k=2Eorg
>
>In personal conversations with technical people, I call myself a
>hacker=2E But
>when I'm talking to journalists I just say "programmer" or something
>like that=2E
>                                -- Linus Torvalds
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger=2Ekernel=2Eorg
>More majordomo info at  http://vger=2Ekernel=2Eorg/majordomo-info=2Ehtml

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
