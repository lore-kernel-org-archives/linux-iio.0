Return-Path: <SRS0=RlGP=YQ=jic23.retrosnub.co.uk=jic23@kernel.org>
Date: Mon, 02 Jan 2017 09:20:21 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Peter Rosin <peda@axentia.se>,Jonathan Cameron <jic23@kernel.org>,linux-kernel@vger.kernel.org
CC: Wolfram Sang <wsa@the-dreams.de>,Rob Herring <robh+dt@kernel.org>,Mark Rutland <mark.rutland@arm.com>,Hartmut Knaack <knaack.h@gmx.de>,Lars-Peter Clausen <lars@metafoo.de>,Peter Meerwald-Stadler <pmeerw@pmeerw.net>,Jonathan Corbet <corbet@lwn.net>,Arnd Bergmann <arnd@arndb.de>,Greg Kroah-Hartman <gregkh@linuxfoundation.org>,linux-i2c@vger.kernel.org,devicetree@vger.kernel.org,linux-iio@vger.kernel.org,linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 2/9] misc: minimal mux subsystem and gpio-based mux controller
In-Reply-To: <7080f03c-0ee3-13b2-b242-21f80052e479@axentia.se>
References: <1480493823-21462-1-git-send-email-peda@axentia.se> <1480493823-21462-3-git-send-email-peda@axentia.se> <8df0d60d-cc95-b0ce-f149-0e123af5046b@kernel.org> <7080f03c-0ee3-13b2-b242-21f80052e479@axentia.se>
Message-ID: <C3DCDDFF-3AEB-4A69-8D77-BD902DAFFD9E@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
List-ID: <linux-iio@vger.kernel.org>



On 2 January 2017 09:14:34 GMT+00:00, Peter Rosin <peda@axentia=2Ese> wrot=
e:
>On 2016-12-31 17:19, Jonathan Cameron wrote:
>> On 30/11/16 08:16, Peter Rosin wrote:
>>> Add a new minimalistic subsystem that handles multiplexer
>controllers=2E
>>> When multiplexers are used in various places in the kernel, and the
>>> same multiplexer controller can be used for several independent
>things,
>>> there should be one place to implement support for said multiplexer
>>> controller=2E
>>>
>>> A single multiplexer controller can also be used to control several
>>> parallel multiplexers, that are in turn used by different subsystems
>>> in the kernel, leading to a need to coordinate multiplexer accesses=2E
>>> The multiplexer subsystem handles this coordination=2E
>>>
>>> This new mux controller subsystem initially comes with a single
>backend
>>> driver that controls gpio based multiplexers=2E Even though not needed
>by
>>> this initial driver, the mux controller subsystem is prepared to
>handle
>>> chips with multiple (independent) mux controllers=2E
>>>
>>> Signed-off-by: Peter Rosin <peda@axentia=2Ese>
>> Few trivial bits inline + question of whether misc is the right
>location=2E=2E
>> It's small, but not totally trivial as subsystems go, so perhaps it
>needs it's
>> own directory=2E
>
>In [9/9] you come to the conclusion that muxes should have their own
>directory, but do you think it should be
>	drivers/mux/*
Probably this one=2E=2E=2E
>or
>	drivers/misc/mux/*
>?
>
>>> ---
>>>  Documentation/driver-model/devres=2Etxt |   6 +-
>>>  MAINTAINERS                           |   2 +
>>>  drivers/misc/Kconfig                  |  30 ++++
>>>  drivers/misc/Makefile                 |   2 +
>>>  drivers/misc/mux-core=2Ec               | 311
>++++++++++++++++++++++++++++++++++
>>>  drivers/misc/mux-gpio=2Ec               | 138 +++++++++++++++
>>>  include/linux/mux=2Eh                   | 197 +++++++++++++++++++++
>>>  7 files changed, 685 insertions(+), 1 deletion(-)
>>>  create mode 100644 drivers/misc/mux-core=2Ec
>>>  create mode 100644 drivers/misc/mux-gpio=2Ec
>>>  create mode 100644 include/linux/mux=2Eh
>>>
>>> diff --git a/Documentation/driver-model/devres=2Etxt
>b/Documentation/driver-model/devres=2Etxt
>>> index ca9d1eb46bc0=2E=2Ed64ede85b61b 100644
>>> --- a/Documentation/driver-model/devres=2Etxt
>>> +++ b/Documentation/driver-model/devres=2Etxt
>>> @@ -330,7 +330,11 @@ MEM
>>>    devm_kzalloc()
>>> =20
>>>  MFD
>>> - devm_mfd_add_devices()
>> Technically should be in a separate cleanup patch=2E=2E=2E
>>> +  devm_mfd_add_devices()
>>> +
>>> +MUX
>>> +  devm_mux_control_get()
>>> +  devm_mux_control_put()
>>> =20
>>>  PER-CPU MEM
>>>    devm_alloc_percpu()
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 3d4d0efc2b64=2E=2Edc7498682752 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -8407,6 +8407,8 @@ MULTIPLEXER SUBSYSTEM
>>>  M:	Peter Rosin <peda@axentia=2Ese>
>>>  S:	Maintained
>>>  F:	Documentation/devicetree/bindings/misc/mux-*
>>> +F:	include/linux/mux=2Eh
>>> +F:	drivers/misc/mux-*
>>> =20
>>>  MULTISOUND SOUND DRIVER
>>>  M:	Andrew Veliath <andrewtv@usa=2Enet>
>>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>>> index 64971baf11fa=2E=2E2ce675e410c5 100644
>>> --- a/drivers/misc/Kconfig
>>> +++ b/drivers/misc/Kconfig
>>> @@ -766,6 +766,36 @@ config PANEL_BOOT_MESSAGE
>>>  	  An empty message will only clear the display at driver init
>time=2E Any other
>>>  	  printf()-formatted message is valid with newline and escape
>codes=2E
>>> =20
>>> +menuconfig MULTIPLEXER
>>> +	bool "Multiplexer subsystem"
>>> +	help
>>> +	  Multiplexer controller subsystem=2E Multiplexers are used in a
>>> +	  variety of settings, and this subsystem abstracts their use
>>> +	  so that the rest of the kernel sees a common interface=2E When
>>> +	  multiple parallel multiplexers are controlled by one single
>>> +	  multiplexer controller, this subsystem also coordinates the
>>> +	  multiplexer accesses=2E
>>> +
>>> +	  If unsure, say no=2E
>>> +
>> Fun question of the day=2E Is misc the place to put this or should it
>> have it's own directory=2E I'd go for own directory=2E=2E=2E
>
>I thought it too small for its own dir and that it could always be
>moved later=2E But I don't really care=2E=2E=2E
>
>> On the plus side, whilst it's in misc you get to pester Greg and Arnd
>> for review=2E
>
>I know :-]
>
>>> +if MULTIPLEXER
>>> +
>>> +config MUX_GPIO
>>> +	tristate "GPIO-controlled Multiplexer"
>>> +	depends on OF && GPIOLIB
>>> +	help
>>> +	  GPIO-controlled Multiplexer controller=2E
>>> +
>>> +	  The driver builds a single multiplexer controller using a number
>>> +	  of gpio pins=2E For N pins, there will be 2^N possible multiplexer
>>> +	  states=2E The GPIO pins can be connected (by the hardware) to
>several
>
>*snip*
>
>>> +
>>> +void mux_chip_free(struct mux_chip *mux_chip)
>>> +{
>>> +	if (!mux_chip)
>>> +		return;
>> I'd drop a blank line in here=2E Slightly nicer to read=2E
>
>Right=2E
>
>>> +	put_device(&mux_chip->dev);
>>> +}
>>> +EXPORT_SYMBOL_GPL(mux_chip_free);
>
>*snip*
>
>>> +
>>> +static int mux_gpio_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device *dev =3D &pdev->dev;
>>> +	struct device_node *np =3D pdev->dev=2Eof_node;
>>> +	struct mux_chip *mux_chip;
>>> +	struct mux_gpio *mux_gpio;
>>> +	int pins;
>>> +	u32 idle_state;
>>> +	int ret;
>>> +
>>> +	if (!np)
>>> +		return -ENODEV;
>>> +
>>> +	pins =3D gpiod_count(dev, "mux");
>>> +	if (pins < 0)
>>> +		return pins;
>>> +
>>> +	mux_chip =3D mux_chip_alloc(dev, 1, sizeof(*mux_gpio) +
>>> +				  pins * sizeof(*mux_gpio->val));
>>> +	if (!mux_chip)
>>> +		return -ENOMEM;
>> Rather feels like mux_chip_alloc is a good candidate for a managed
>> allocator=2E Might be worth doing the register as well then the remove
>> below would go away=2E  I guess perhaps not that worthwhile as not many
>> mux types are likely to ever exist=2E=2E=2E
>
>To me it seemed like too much extra support code for just two drivers=2E
>And it can always be added later if/when more mux drivers show up=2E=2E=
=2E
There will be others :) sure do it later=2E
>
>>> +
>>> +	mux_gpio =3D mux_chip_priv(mux_chip);
>>> +	mux_gpio->val =3D (int *)(mux_gpio + 1);
>
>*snip*
>
>Cheers,
>peda
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger=2Ekernel=2Eorg
>More majordomo info at  http://vger=2Ekernel=2Eorg/majordomo-info=2Ehtml

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
