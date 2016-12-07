Return-Path: <SRS0=5DSi=XW=gmail.com=geert.uytterhoeven@kernel.org>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <alpine.DEB.2.02.1612062143480.10644@pmeerw.net>
References: <1481041823-18382-1-git-send-email-jacopo@jmondi.org> <alpine.DEB.2.02.1612062143480.10644@pmeerw.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 7 Dec 2016 09:15:31 +0100
Message-ID: <CAMuHMdXfUiN5m7F7oJzZOwPXQgEe0oE22wO_jsNgj7h_hg09UA@mail.gmail.com>
Subject: Re: [PATCH] iio: Add Maxim MAX11100 driver
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jacopo Mondi <jacopo@jmondi.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Magnus Damm <magnus.damm@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Dec 6, 2016 at 10:00 PM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig

>> +static int max11100_read_raw(struct iio_dev *indio_dev,
>> +                          struct iio_chan_spec const *chan,
>> +                          int *val, int *val2, long mask)
>> +{
>> +     int ret;
>> +     struct max11100_state *state = iio_priv(indio_dev);
>> +     uint8_t buffer[3] = { 0, 0, 0 };

>> +     ret = spi_read(state->spi, (void *) buffer, 3);

Cast not needed.

>> +static int max11100_probe(struct spi_device *spi)
>> +{
>> +     int ret;
>> +     struct iio_dev *indio_dev;
>> +     struct max11100_state *state;
>> +
>> +     indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
>> +     if (!indio_dev) {
>> +             pr_err("Can't allocate iio device\n");
>
> error message really needed?

No, OOM will scream anyway.

>
>> +             return -ENOMEM;
>> +     }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
