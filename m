Return-Path: <renatogeh@gmail.com>
From: Renato Lui Geh <renatogeh@gmail.com>
Date: Thu, 8 Nov 2018 12:04:52 -0200
To: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc: "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
	"jic23@jic23.retrosnub.co.uk" <jic23@jic23.retrosnub.co.uk>,
	"giuliano.belinassi@gmail.com" <giuliano.belinassi@gmail.com>,
	"renatogeh@gmail.com" <renatogeh@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: Questions related to some drivers
Message-ID: <20181108140451.uwiwbjxoyxlmjqic@renatolg>
References: <20181017190028.wu2kgsooj64beh7o@smtp.gmail.com>
 <d0fc5a236a82d03fdbe4d05eb27ff3bd3ac36958.camel@analog.com>
 <20181018114145.amqff57holmecxpo@smtp.gmail.com>
 <CAEFO=4BjSiYeNW_n0PjoC3EqaN1Z8E1XB_CO+FJJdTwZo4enzg@mail.gmail.com>
 <20181023105126.408ef7ab@archlinux>
 <CAEFO=4Dc_v90MHFnniTpAcMvajpt3O55rtc730Pr0F6+Aau49A@mail.gmail.com>
 <6f9ad9ace7828741f25ea6e7c555c9f4e91a203b.camel@analog.com>
 <20181107185735.wryk5o4wndy6bkzn@renatolg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
In-Reply-To: <20181107185735.wryk5o4wndy6bkzn@renatolg>
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 11/06, Ardelean, Alexandru wrote:
>For AD778x you could also add support for the GAIN & FILTER pins via GPIOs,
>to control these settings. And then in the ad7780_postprocess_sample()
>function check if the GPIO settings (stored on a gpio_desc on ad7780_state)
>match the expected GAIN & FILTER bit settings ; if not return -EIO.

We're having some trouble with the GPIOs, and would like some insight on
how to proceed. Any help would be very much appreciated!

We're wondering if we should do something like this in ad7780.c's probe:

st->powerdown_gpio = devm_gpiod_get_optional(&spi->dev,
					     "powerdown",
					     GPIOD_OUT_LOW);

for both gain and filter. Taking a look at driver drivers/iio/adc/hx711.c
(another adc driver out of staging), we have:

hx711_data->gpiod_pd_sck = devm_gpiod_get(dev, "sck", GPIOD_OUT_LOW);

So we're assuming "sck" and "powerdown" are the pins we're looking for. Are we
correct to assume that these strings are compared with a table that map the
actual GPIO pins? So we'd have something like:

st->gain_gpio = devm_gpiod_get_optional(&spi->dev,
					"gain",
					GPIO_DOUT_LOW);

Where "gain" is the pin 4 or 5 on the AD778x
(https://www.analog.com/media/en/technical-documentation/data-sheets/ad7780.pdf)
chip.

Where can we find this table that maps these pin names to the actual pin
numbers? We found this link
https://www.kernel.org/doc/html/v4.17/driver-api/gpio/board.html that shows how
to declare table attributes, but we couldn't find this lookup table there.

Are we missing something? Out of curiosity, why do we have to pass a string
(e.g. powerdown, gain, sck, dout) instead of the pin number? We found somewhere
that they are names to functions. Are these functions implemented on the chip?

Thanks,
Renato
