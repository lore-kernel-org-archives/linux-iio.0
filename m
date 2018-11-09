Return-Path: <giuliano.belinassi@usp.br>
MIME-Version: 1.0
References: <20181017190028.wu2kgsooj64beh7o@smtp.gmail.com>
 <d0fc5a236a82d03fdbe4d05eb27ff3bd3ac36958.camel@analog.com>
 <20181018114145.amqff57holmecxpo@smtp.gmail.com> <CAEFO=4BjSiYeNW_n0PjoC3EqaN1Z8E1XB_CO+FJJdTwZo4enzg@mail.gmail.com>
 <20181023105126.408ef7ab@archlinux> <CAEFO=4Dc_v90MHFnniTpAcMvajpt3O55rtc730Pr0F6+Aau49A@mail.gmail.com>
 <6f9ad9ace7828741f25ea6e7c555c9f4e91a203b.camel@analog.com>
 <20181107185735.wryk5o4wndy6bkzn@renatolg> <20181108140451.uwiwbjxoyxlmjqic@renatolg>
 <cddb41ac39b2210359adc0421b2c3d46e884453f.camel@analog.com>
In-Reply-To: <cddb41ac39b2210359adc0421b2c3d46e884453f.camel@analog.com>
From: Giuliano Augusto Faulin Belinassi <giuliano.belinassi@usp.br>
Date: Fri, 9 Nov 2018 20:08:23 -0200
Message-ID: <CAEFO=4DVtccLOAhpGfMRL+1Bkd78-VfeOU=BuyRKs1vmqZrDiQ@mail.gmail.com>
Subject: Re: Questions related to some drivers
To: alexandru.Ardelean@analog.com
Cc: Renato Geh <renatogeh@gmail.com>, giuliano.belinassi@gmail.com,
	linux-iio@vger.kernel.org, Kernel USP <kernel-usp@googlegroups.com>,
	jic23@jic23.retrosnub.co.uk
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Hello. Sorry for the late reply

> On a more private note: do you guys have HW to test your code/changes on ?
No, we don't have it. I think it would be really nice if we could have
access to the
hardware to work on. :-)

> Jonathan did ask us about this in private, but I think the discussion has
> stalled a bit (time & priorities).
>
> We could send a few samples if there's anything you'd like to test this
> code on.

That would be really helpful :-)

> FWIW: we usually test quite a few of this simple ADC/DAC changes on
> Raspberry PI ; it's a pretty useful board for testing stuff.
On Thu, Nov 8, 2018 at 12:46 PM Ardelean, Alexandru
<alexandru.Ardelean@analog.com> wrote:
>
> On Thu, 2018-11-08 at 12:04 -0200, Renato Lui Geh wrote:
> > Hi,
> >
>
> Hey,
>
> > On 11/06, Ardelean, Alexandru wrote:
> > > For AD778x you could also add support for the GAIN & FILTER pins via
> > > GPIOs,
> > > to control these settings. And then in the ad7780_postprocess_sample()
> > > function check if the GPIO settings (stored on a gpio_desc on
> > > ad7780_state)
> > > match the expected GAIN & FILTER bit settings ; if not return -EIO.
> >
> > We're having some trouble with the GPIOs, and would like some insight on
> > how to proceed. Any help would be very much appreciated!
> >
> > We're wondering if we should do something like this in ad7780.c's probe:
> >
> > st->powerdown_gpio = devm_gpiod_get_optional(&spi->dev,
> >                                            "powerdown",
> >                                            GPIOD_OUT_LOW);
> >
>
> Yes, something like this.
>
> > for both gain and filter. Taking a look at driver drivers/iio/adc/hx711.c
> > (another adc driver out of staging), we have:
> >
> > hx711_data->gpiod_pd_sck = devm_gpiod_get(dev, "sck", GPIOD_OUT_LOW);
> >
> > So we're assuming "sck" and "powerdown" are the pins we're looking for.
> > Are we
> > correct to assume that these strings are compared with a table that map
> > the
> > actual GPIO pins? So we'd have something like:
> >
> > st->gain_gpio = devm_gpiod_get_optional(&spi->dev,
> >                                       "gain",
> >                                       GPIO_DOUT_LOW);
>
> This is exactly a good idea to do for `gain`.
> And similar for `filter`
>
> >
> > Where "gain" is the pin 4 or 5 on the AD778x
>
> The pin 4 or 5 on the AD778x are not what you define here.
> The GPIOs you define/use here are on the host-board.
>
> So,
>
> Host-board [dt-entry] <----> AD778x [HW-pin]
>
> Where:
> * `dt-entry` is definted in the device-tree something like:
>    gain-gpio = <&gpio GPIO_NUMBER_ON_HOST_BOARD GPIO_FLAGS>
> * GPIO_NUMBER_ON_HOST_BOARD is a number, which varies ; for example for
> Raspberry Pi it could be pin 25 [in the device tree];
> * GPIO_FLAGS is usually 0 ; but can be any other numeric value defined
> here:
>
> https://github.com/torvalds/linux/blob/master/include/dt-bindings/gpio/gpio.h
> * `HW-pin` doesn't matter, because it's a physical pin that can be defined
> as anything in SW
>
> > (
> > https://www.analog.com/media/en/technical-documentation/data-sheets/ad7780.pdf
> > )
> > chip.
> >
> > Where can we find this table that maps these pin names to the actual pin
> > numbers? We found this link
>
> The actual pin number doesn't matter in the driver you write.
> It matters in the device-tree for the board you use the driver [and chip]
> on.
>
> If you were to test your driver change on a RPi board and you physically
> connect this on Pin 25 (physical) and in your device-tree
> GPIO_NUMBER_ON_HOST_BOARD is the value (in SW) for Pin 25, then that's what
> matters when you test/run the code.
>
> In the kernel, a pin numbers table for the RPi can be found here:
>
> https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/bcm283x.dtsi#L185
>
> I keep referring to RPi because we've used it a bit more than other boards,
> and also because for RPi usually Pin 25 in HW is also Pin 25 in SW.
>
>
> > https://www.kernel.org/doc/html/v4.17/driver-api/gpio/board.html that
> > shows how
> > to declare table attributes, but we couldn't find this lookup table
> > there.
> >
> > Are we missing something? Out of curiosity, why do we have to pass a
> > string
> > (e.g. powerdown, gain, sck, dout) instead of the pin number? We found
> > somewhere
> > that they are names to functions. Are these functions implemented on the
> > chip?
> >
>
> So, the string in the driver, will be used to lookup the physical pin in
> the device-tree.
> The pin number differs from one host-board to another [as I've said], so
> the string is a unique identifier for the driver, which resolves to the
> physical pin on the board.
>
> By the way: one work item (maybe after the driver is moved out of staging)
> would be to also write a device-tree binding doc.
> An example:
>
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/sound/adi,adau17x1.txt
> It's not the best one, and feel free to look for others as well, that
> define GPIOs. But in that file, is an example of how to link a reset-gpio
> that would be called by that driver to physically reset the device when
> probed & initialized.
>
> Usually the arch/arm[64]/boot/dts have a lot of device-trees that may help
> shape some thinking about device-trees.
>
> I'm hoping I got to explain things somewhat.
> It is a bit late in the afternoon [for me], but I thought I'd give it a try
> :)
>
> If there are still questions, feel free to ask.
> I think I can get to them tomorrow.
>
> Thanks
> Alex
>
> > Thanks,
> > Renato
> >
