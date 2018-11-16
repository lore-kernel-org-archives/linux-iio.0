Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbeKPVuy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 16 Nov 2018 16:50:54 -0500
Date: Fri, 16 Nov 2018 11:38:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc: "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "giuliano.belinassi@gmail.com" <giuliano.belinassi@gmail.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: Questions related to some drivers
Message-ID: <20181116113848.08d15c0b@archlinux>
In-Reply-To: <0419f814587c3d676c18178bc789a4c52202c349.camel@analog.com>
References: <20181017190028.wu2kgsooj64beh7o@smtp.gmail.com>
        <d0fc5a236a82d03fdbe4d05eb27ff3bd3ac36958.camel@analog.com>
        <20181018114145.amqff57holmecxpo@smtp.gmail.com>
        <CAEFO=4BjSiYeNW_n0PjoC3EqaN1Z8E1XB_CO+FJJdTwZo4enzg@mail.gmail.com>
        <20181023105126.408ef7ab@archlinux>
        <CAEFO=4Dc_v90MHFnniTpAcMvajpt3O55rtc730Pr0F6+Aau49A@mail.gmail.com>
        <6f9ad9ace7828741f25ea6e7c555c9f4e91a203b.camel@analog.com>
        <20181107185735.wryk5o4wndy6bkzn@renatolg>
        <20181108140451.uwiwbjxoyxlmjqic@renatolg>
        <cddb41ac39b2210359adc0421b2c3d46e884453f.camel@analog.com>
        <CAEFO=4Aoda5rcuXOHivk8cy2XtV1D0bwkKKuwzUi-z+8z26CLQ@mail.gmail.com>
        <0419f814587c3d676c18178bc789a4c52202c349.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 14 Nov 2018 09:55:08 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Tue, 2018-11-13 at 11:56 -0200, Giuliano Augusto Faulin Belinassi wrote:
> > Hello,
> >      We have some doubts regarding the FILTER and GAIN pins. Should
> > these pins be set in userspace, and therefore there must be a
> > 'ad7780_write_raw' function? Or should we use the device tree with a
> > value set on initialization?
> >   
> 
> So, definitely add the code that initializes the pins via device-tree.
> Quite a few users of the driver may only want a single gain value for the
> entire life-cycle of the chip running ; and this can be neatly initialized
> from DT.

Actually I'll come down on the other side in that argument.  They are both
better set from just userspace, not in DT.  DT bindings for gain in particular
have always been controversial as it's is sometimes more of a policy decision
(and hence generally shouldn't be in DT) rather than one dictated by hardware.

However any defaults should then be conservative (minimum gain, widest filter)
so peoples till get a reasonable answer when not controlling these explicitly.

Now, if there is a 'strong' hardware reason for having a particular set of
value (typical one is the hardware is actually damaged if we go too far
out of range) then they can go in DT. Otherwise I would definitely prefer
userspace control only.

> 
> Adding a 'ad7780_write_raw' function for updating these pins, also sounds
> like a neat idea.
> Then you could update the GAIN and FILTER pins via user-space calls.
> I guess it's up to you if you want to do this. But I don't know how many
> users of the driver would require/want this flexibility with this
> particular chip [we haven't received any requests for this (yet) AFAIK].
> 
> Doing this is a bit more work, because you'll have to create a new macro
> like AD_SD_CHANNEL() which allows to set custom bit/mask fields [1], or
> just create a AD_SD_CHANNEL_GAIN() or AD_SD_CHANNEL_GAIN_FILTER() macro.
> [ see include/linux/iio/adc/ad_sigma_delta.h for AD_SD_CHANNEL() ].
> 
> I guess the [1] variant would be more flexible/interesting.
> The AD7780 uses quite a bit of logic from the generic ad_sigma_delta
> driver.
> 
> > Thank you
> > On Thu, Nov 8, 2018 at 12:46 PM Ardelean, Alexandru
> > <alexandru.Ardelean@analog.com> wrote:  
> > > 
> > > On Thu, 2018-11-08 at 12:04 -0200, Renato Lui Geh wrote:  
> > > > Hi,
> > > >   
> > > 
> > > Hey,
> > >   
> > > > On 11/06, Ardelean, Alexandru wrote:  
> > > > > For AD778x you could also add support for the GAIN & FILTER pins
> > > > > via
> > > > > GPIOs,
> > > > > to control these settings. And then in the
> > > > > ad7780_postprocess_sample()
> > > > > function check if the GPIO settings (stored on a gpio_desc on
> > > > > ad7780_state)
> > > > > match the expected GAIN & FILTER bit settings ; if not return -EIO.  
> 
> By the way: looking at this suggestion now, I'm not sure [now] if it's a
> good idea to read GPIOs in the ad7780_postprocess_sample() function as that
> could slow down the data-rate when reading from the ADC.
> So, I would drop this idea.

Should definitely avoid any actual hardware reads / writes as these may
well be on some gpio chip out on a slow bus.

> 
> > > > 
> > > > We're having some trouble with the GPIOs, and would like some insight
> > > > on
> > > > how to proceed. Any help would be very much appreciated!
> > > > 
> > > > We're wondering if we should do something like this in ad7780.c's
> > > > probe:
> > > > 
> > > > st->powerdown_gpio = devm_gpiod_get_optional(&spi->dev,
> > > >                                            "powerdown",
> > > >                                            GPIOD_OUT_LOW);
> > > >   
> > > 
> > > Yes, something like this.
> > >   
> > > > for both gain and filter. Taking a look at driver
> > > > drivers/iio/adc/hx711.c
> > > > (another adc driver out of staging), we have:
> > > > 
> > > > hx711_data->gpiod_pd_sck = devm_gpiod_get(dev, "sck", GPIOD_OUT_LOW);
> > > > 
> > > > So we're assuming "sck" and "powerdown" are the pins we're looking
> > > > for.
> > > > Are we
> > > > correct to assume that these strings are compared with a table that
> > > > map
> > > > the
> > > > actual GPIO pins? So we'd have something like:
> > > > 
> > > > st->gain_gpio = devm_gpiod_get_optional(&spi->dev,
> > > >                                       "gain",
> > > >                                       GPIO_DOUT_LOW);  
> > > 
> > > This is exactly a good idea to do for `gain`.
> > > And similar for `filter`
> > >   
> > > > 
> > > > Where "gain" is the pin 4 or 5 on the AD778x  
> > > 
> > > The pin 4 or 5 on the AD778x are not what you define here.
> > > The GPIOs you define/use here are on the host-board.
> > > 
> > > So,
> > > 
> > > Host-board [dt-entry] <----> AD778x [HW-pin]
> > > 
> > > Where:
> > > * `dt-entry` is definted in the device-tree something like:
> > >    gain-gpio = <&gpio GPIO_NUMBER_ON_HOST_BOARD GPIO_FLAGS>
> > > * GPIO_NUMBER_ON_HOST_BOARD is a number, which varies ; for example for
> > > Raspberry Pi it could be pin 25 [in the device tree];
> > > * GPIO_FLAGS is usually 0 ; but can be any other numeric value defined
> > > here:
> > > 
> > >   
> https://github.com/torvalds/linux/blob/master/include/dt-bindings/gpio/gpio.h
> > > * `HW-pin` doesn't matter, because it's a physical pin that can be
> > > defined
> > > as anything in SW
> > >   
> > > > (
> > > >   
> https://www.analog.com/media/en/technical-documentation/data-sheets/ad7780.pdf
> > > > )
> > > > chip.
> > > > 
> > > > Where can we find this table that maps these pin names to the actual
> > > > pin
> > > > numbers? We found this link  
> > > 
> > > The actual pin number doesn't matter in the driver you write.
> > > It matters in the device-tree for the board you use the driver [and
> > > chip]
> > > on.
> > > 
> > > If you were to test your driver change on a RPi board and you
> > > physically
> > > connect this on Pin 25 (physical) and in your device-tree
> > > GPIO_NUMBER_ON_HOST_BOARD is the value (in SW) for Pin 25, then that's
> > > what
> > > matters when you test/run the code.
> > > 
> > > In the kernel, a pin numbers table for the RPi can be found here:
> > > 
> > >   
> https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/bcm283x.dtsi#L185
> > > 
> > > I keep referring to RPi because we've used it a bit more than other
> > > boards,
> > > and also because for RPi usually Pin 25 in HW is also Pin 25 in SW.
> > > 
> > >   
> > > > https://www.kernel.org/doc/html/v4.17/driver-api/gpio/board.html that
> > > > shows how
> > > > to declare table attributes, but we couldn't find this lookup table
> > > > there.
> > > > 
> > > > Are we missing something? Out of curiosity, why do we have to pass a
> > > > string
> > > > (e.g. powerdown, gain, sck, dout) instead of the pin number? We found
> > > > somewhere
> > > > that they are names to functions. Are these functions implemented on
> > > > the
> > > > chip?
> > > >   
> > > 
> > > So, the string in the driver, will be used to lookup the physical pin
> > > in
> > > the device-tree.
> > > The pin number differs from one host-board to another [as I've said],
> > > so
> > > the string is a unique identifier for the driver, which resolves to the
> > > physical pin on the board.
> > > 
> > > By the way: one work item (maybe after the driver is moved out of
> > > staging)
> > > would be to also write a device-tree binding doc.
> > > An example:
> > > 
> > >   
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/sound/adi,adau17x1.txt
> > > It's not the best one, and feel free to look for others as well, that
> > > define GPIOs. But in that file, is an example of how to link a reset-
> > > gpio
> > > that would be called by that driver to physically reset the device when
> > > probed & initialized.
> > > 
> > > Usually the arch/arm[64]/boot/dts have a lot of device-trees that may
> > > help
> > > shape some thinking about device-trees.
> > > 
> > > I'm hoping I got to explain things somewhat.
> > > It is a bit late in the afternoon [for me], but I thought I'd give it a
> > > try
> > > :)
> > > 
> > > If there are still questions, feel free to ask.
> > > I think I can get to them tomorrow.
> > > 
> > > Thanks
> > > Alex
> > >   
> > > > Thanks,
> > > > Renato
> > > >   
> > 
> >   
