Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it1-f175.google.com ([209.85.166.175]:40031 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387444AbeKGAiD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Nov 2018 19:38:03 -0500
Received: by mail-it1-f175.google.com with SMTP id e11so14759328itl.5
        for <linux-iio@vger.kernel.org>; Tue, 06 Nov 2018 07:12:23 -0800 (PST)
MIME-Version: 1.0
References: <CAHd-oW68iJ=m2Woz63bVwnK_cCJi2uF2e0_EVur6DHJLRmKw+A@mail.gmail.com>
 <2ed30f2fa4ffc437c5a012831521d1eb6abe259f.camel@analog.com>
In-Reply-To: <2ed30f2fa4ffc437c5a012831521d1eb6abe259f.camel@analog.com>
From: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date: Tue, 6 Nov 2018 13:12:10 -0200
Message-ID: <CAHd-oW5iPLbEECw-SzyHGprSrEkrCSnH+xnhSB8uKqr-PqocPg@mail.gmail.com>
Subject: Re: Question about max frequency in ad2s90
To: alexandru.Ardelean@analog.com
Cc: jic23@jic23.retrosnub.co.uk, linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        graf.yang@analog.com, Victor Colombo <victorcolombo@gmail.com>,
        kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Nov 6, 2018 at 10:34 AM Ardelean, Alexandru
<alexandru.Ardelean@analog.com> wrote:
>
> On Mon, 2018-11-05 at 23:11 -0200, Matheus Tavares Bernardino wrote:
> > Hello everyone,
> >
>
> Hey,
>

Hi, Alex

> > While working on the ad2s90 driver, I had a question about the maximum
> > frequency set. Any feedback will be much appreciated.
> >
>
> Just a note/reminder for you: that driver looks pretty old and [since it's
> staging as well] you should also consider that it's likely that some [good]
> practices were not yet existing at the time [about how to do things].
>

Thanks for the reminder. Victor and I are trying to find what needs to
be updated/modified to move this driver out of staging. We've sent
some patches and now I'm working on the device tree support, which is
the last thing to be done in a list Jonathan helped us to enumerate.
So I take this opportunity to ask you to, please, let us know if
there's anything else you see that needs to be done before moving it
out of staging.

> > The ad2s90 driver sets its maximum speed to 830000hz (or 0.83Mhz), but
> > the datasheet [1] specifies a maximum of 2Mhz. Above the max_speed_hz
> > setup, there's a commentary saying  "need 600ns between CS and the
> > first falling edge of SCLK", which is also said in the datasheet.
> >
> > Is max_speed_hz set to 0.83Mhz, not 2Mhz, due to the required minimum
> > delay of 600ns, somehow? If not:
> >   1) is 0.83Mhz really correct? and
> >   2) is the minimum delay of 600ns being respected?
> >
>
> The 0.83 Mhz limitation looks very much like it was added to satisfy the
> 600 ns limitation. I quickly did the computation and it roughly ends up
> being 0.83 Mhz for 600 ns. (i.e. (1 / 0,000600) / 2 = half a period )
>

Thanks. Now I better understood the calculation made to use 0.83Mhz.

> That limitation (for the delay CS and the first data) is imposed by the
> datasheet ; while the chip could operate at a lower delay (and subsequently
> higher frequency up to 2 Mhz), it's safer to keep it somehow implemented.
>
> I took a look in the SPI code and it doesn't look like it implements some
> sort of delay between CS and first data being read. I may have missed stuff
> though.
>

Ok. So just to check if I got it right: The chip could work at 2Mhz
but needs a delay of 600ns between CS and the first data bit
retrieval. The driver could implement the delay and then clock at
2Mhz, but the SPI code doesn't have a way to implement this delay, so
we have to stay at a lower frequency (of maximum 0.83Mhz), to satisfy
the 600ns delay. Is that right?

So there's nothing to do about it, right?

> In any case, I do suggest removing all those 4 lines for the SPI setup
> code.
> i.e.
>
>         /* need 600ns between CS and the first falling edge of SCLK */
>         spi->max_speed_hz = 830000;
>         spi->mode = SPI_MODE_3;
>         spi_setup(spi);
>
> This should be handled via device-tree.
>

Right! Thanks for pointing it out. I'm going to address those changes
in the next patch set I'm working on, regarding device tree support.

> Instead, what could be done in the ad2s90_probe() function, is to add
> (early in the code) a check for the max frequency.
>
> Something like:
>
> #define AD2S90_MAX_SPI_FREQ_HZ  2000000
>
>        if (spi->max_speed_hz > AD2S90_MAX_SPI_FREQ_HZ) {
>                 dev_err(&spi->dev, "SPI CLK, %d Hz exceeds 2 MHz\n",
>                         spi->max_speed_hz);
>                 return -EINVAL;
>         }
>
> Or, you could make AD2S90_MAX_SPI_FREQ_HZ = 830000
>
> Or, you could just print a warning for > 830000.
> Something like:
>
> #define AD2S90_MAX_SPI_SAFE_FREQ_HZ  830000
>
>        if (spi->max_speed_hz > AD2S90_MAX_SPI_SAFE_FREQ_HZ)
>                 dev_warn(&spi->dev, "SPI CLK, %d Hz > 0.83 MHz, device may
> not operate correctly\n",
>                         spi->max_speed_hz);
>
>
> I'm not sure what would be recommended here. Maybe someone else has a
> stronger opinion about this.
>

Got it. Maybe we could join both, adding the error for freq > 2Mhz and
the warning for freq > 0.83 Mhz? Anyway, more opinions on this would
be nice, as you said.

Thanks for all the feedback.
Matheus

> Thanks
> Alex
>
> > Thanks,
> > Matheus.
> >
> > [1]
> > https://www.analog.com/media/en/technical-documentation/data-sheets/AD2S90.pdf
> >
