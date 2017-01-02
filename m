Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-he1eur01on0120.outbound.protection.outlook.com ([104.47.0.120]:60544
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932227AbdABJOo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 2 Jan 2017 04:14:44 -0500
Subject: Re: [PATCH v6 2/9] misc: minimal mux subsystem and gpio-based mux
 controller
To: Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org
References: <1480493823-21462-1-git-send-email-peda@axentia.se>
 <1480493823-21462-3-git-send-email-peda@axentia.se>
 <8df0d60d-cc95-b0ce-f149-0e123af5046b@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
From: Peter Rosin <peda@axentia.se>
Message-ID: <7080f03c-0ee3-13b2-b242-21f80052e479@axentia.se>
Date: Mon, 2 Jan 2017 10:14:34 +0100
MIME-Version: 1.0
In-Reply-To: <8df0d60d-cc95-b0ce-f149-0e123af5046b@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2016-12-31 17:19, Jonathan Cameron wrote:
> On 30/11/16 08:16, Peter Rosin wrote:
>> Add a new minimalistic subsystem that handles multiplexer controllers.
>> When multiplexers are used in various places in the kernel, and the
>> same multiplexer controller can be used for several independent things,
>> there should be one place to implement support for said multiplexer
>> controller.
>>
>> A single multiplexer controller can also be used to control several
>> parallel multiplexers, that are in turn used by different subsystems
>> in the kernel, leading to a need to coordinate multiplexer accesses.
>> The multiplexer subsystem handles this coordination.
>>
>> This new mux controller subsystem initially comes with a single backend
>> driver that controls gpio based multiplexers. Even though not needed by
>> this initial driver, the mux controller subsystem is prepared to handle
>> chips with multiple (independent) mux controllers.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> Few trivial bits inline + question of whether misc is the right location..
> It's small, but not totally trivial as subsystems go, so perhaps it needs it's
> own directory.

In [9/9] you come to the conclusion that muxes should have their own
directory, but do you think it should be
	drivers/mux/*
or
	drivers/misc/mux/*
?

>> ---
>>  Documentation/driver-model/devres.txt |   6 +-
>>  MAINTAINERS                           |   2 +
>>  drivers/misc/Kconfig                  |  30 ++++
>>  drivers/misc/Makefile                 |   2 +
>>  drivers/misc/mux-core.c               | 311 ++++++++++++++++++++++++++++++++++
>>  drivers/misc/mux-gpio.c               | 138 +++++++++++++++
>>  include/linux/mux.h                   | 197 +++++++++++++++++++++
>>  7 files changed, 685 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/misc/mux-core.c
>>  create mode 100644 drivers/misc/mux-gpio.c
>>  create mode 100644 include/linux/mux.h
>>
>> diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
>> index ca9d1eb46bc0..d64ede85b61b 100644
>> --- a/Documentation/driver-model/devres.txt
>> +++ b/Documentation/driver-model/devres.txt
>> @@ -330,7 +330,11 @@ MEM
>>    devm_kzalloc()
>>  
>>  MFD
>> - devm_mfd_add_devices()
> Technically should be in a separate cleanup patch...
>> +  devm_mfd_add_devices()
>> +
>> +MUX
>> +  devm_mux_control_get()
>> +  devm_mux_control_put()
>>  
>>  PER-CPU MEM
>>    devm_alloc_percpu()
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3d4d0efc2b64..dc7498682752 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8407,6 +8407,8 @@ MULTIPLEXER SUBSYSTEM
>>  M:	Peter Rosin <peda@axentia.se>
>>  S:	Maintained
>>  F:	Documentation/devicetree/bindings/misc/mux-*
>> +F:	include/linux/mux.h
>> +F:	drivers/misc/mux-*
>>  
>>  MULTISOUND SOUND DRIVER
>>  M:	Andrew Veliath <andrewtv@usa.net>
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 64971baf11fa..2ce675e410c5 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -766,6 +766,36 @@ config PANEL_BOOT_MESSAGE
>>  	  An empty message will only clear the display at driver init time. Any other
>>  	  printf()-formatted message is valid with newline and escape codes.
>>  
>> +menuconfig MULTIPLEXER
>> +	bool "Multiplexer subsystem"
>> +	help
>> +	  Multiplexer controller subsystem. Multiplexers are used in a
>> +	  variety of settings, and this subsystem abstracts their use
>> +	  so that the rest of the kernel sees a common interface. When
>> +	  multiple parallel multiplexers are controlled by one single
>> +	  multiplexer controller, this subsystem also coordinates the
>> +	  multiplexer accesses.
>> +
>> +	  If unsure, say no.
>> +
> Fun question of the day. Is misc the place to put this or should it
> have it's own directory. I'd go for own directory...

I thought it too small for its own dir and that it could always be
moved later. But I don't really care...

> On the plus side, whilst it's in misc you get to pester Greg and Arnd
> for review.

I know :-]

>> +if MULTIPLEXER
>> +
>> +config MUX_GPIO
>> +	tristate "GPIO-controlled Multiplexer"
>> +	depends on OF && GPIOLIB
>> +	help
>> +	  GPIO-controlled Multiplexer controller.
>> +
>> +	  The driver builds a single multiplexer controller using a number
>> +	  of gpio pins. For N pins, there will be 2^N possible multiplexer
>> +	  states. The GPIO pins can be connected (by the hardware) to several

*snip*

>> +
>> +void mux_chip_free(struct mux_chip *mux_chip)
>> +{
>> +	if (!mux_chip)
>> +		return;
> I'd drop a blank line in here. Slightly nicer to read.

Right.

>> +	put_device(&mux_chip->dev);
>> +}
>> +EXPORT_SYMBOL_GPL(mux_chip_free);

*snip*

>> +
>> +static int mux_gpio_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = pdev->dev.of_node;
>> +	struct mux_chip *mux_chip;
>> +	struct mux_gpio *mux_gpio;
>> +	int pins;
>> +	u32 idle_state;
>> +	int ret;
>> +
>> +	if (!np)
>> +		return -ENODEV;
>> +
>> +	pins = gpiod_count(dev, "mux");
>> +	if (pins < 0)
>> +		return pins;
>> +
>> +	mux_chip = mux_chip_alloc(dev, 1, sizeof(*mux_gpio) +
>> +				  pins * sizeof(*mux_gpio->val));
>> +	if (!mux_chip)
>> +		return -ENOMEM;
> Rather feels like mux_chip_alloc is a good candidate for a managed
> allocator. Might be worth doing the register as well then the remove
> below would go away.  I guess perhaps not that worthwhile as not many
> mux types are likely to ever exist...

To me it seemed like too much extra support code for just two drivers.
And it can always be added later if/when more mux drivers show up...

>> +
>> +	mux_gpio = mux_chip_priv(mux_chip);
>> +	mux_gpio->val = (int *)(mux_gpio + 1);

*snip*

Cheers,
peda

