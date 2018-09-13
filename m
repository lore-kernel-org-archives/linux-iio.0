Return-Path: <SRS0=uEUa=L3=lechnology.com=david@kernel.org>
Subject: Re: [PATCH v2 4/4] spi: spi-davinci: Add support for SPI_CS_WORD
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-spi <linux-spi@vger.kernel.org>, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 Mark Brown <broonie@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180913003920.30600-1-david@lechnology.com>
 <20180913003920.30600-5-david@lechnology.com>
 <CAMuHMdUb=sXBBRLhKNxsWT_Z4PCoLcM16NajvmPVHWsvgoL7_w@mail.gmail.com>
From: David Lechner <david@lechnology.com>
Message-ID: <fb43f4d7-5b19-72be-9216-efdca9b59eba@lechnology.com>
Date: Thu, 13 Sep 2018 09:26:48 -0500
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUb=sXBBRLhKNxsWT_Z4PCoLcM16NajvmPVHWsvgoL7_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 09/13/2018 08:44 AM, Geert Uytterhoeven wrote:
> Hi David,
> 
> On Thu, Sep 13, 2018 at 2:40 AM David Lechner <david@lechnology.com> wrote:
>> This adds support for the SPI_CS_WORD flag to the TI DaVinci SPI
>> driver. This mode can be used as long as we are using the hardware
>> chip select and not a GPIO chip select.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>   drivers/spi/spi-davinci.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
>> index d502cf504deb..8f7dcbc53c57 100644
>> --- a/drivers/spi/spi-davinci.c
>> +++ b/drivers/spi/spi-davinci.c
>> @@ -230,7 +230,8 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
>>                                  !(spi->mode & SPI_CS_HIGH));
>>          } else {
>>                  if (value == BITBANG_CS_ACTIVE) {
>> -                       spidat1 |= SPIDAT1_CSHOLD_MASK;
>> +                       if (!(spi->mode & SPI_CS_WORD))
>> +                               spidat1 |= SPIDAT1_CSHOLD_MASK;
>>                          spidat1 &= ~(0x1 << chip_sel);
>>                  }
>>          }
>> @@ -440,8 +441,12 @@ static int davinci_spi_setup(struct spi_device *spi)
>>                          return retval;
>>                  }
>>
>> -               if (internal_cs)
>> +               if (internal_cs) {
>>                          set_io_bits(dspi->base + SPIPC0, 1 << spi->chip_select);
>> +               } else if (spi->mode & SPI_CS_WORD) {
>> +                       dev_err(&spi->dev, "SPI_CS_WORD can't be use with GPIO CS\n");
>> +                       return -EINVAL;
> 
> Does the SPI core fall back to splitting the transfer in this case?

Hmm... it doesn't look like it.

I suppose it might be best to modify the SPI core to say:

	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD) ||
					  gpio_is_valid(spi->cs_gpio)) {

instead of:

	if ((spi->mode & SPI_CS_WORD) && !(ctlr->mode_bits & SPI_CS_WORD)) {

Then we could drop the error above.

> 
>> +               }
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
> 
