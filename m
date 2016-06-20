Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34623 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbcFTLVT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2016 07:21:19 -0400
Received: by mail-qk0-f194.google.com with SMTP id j2so22926421qkf.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2016 04:21:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1466361242-2994-8-git-send-email-linus.walleij@linaro.org>
References: <1466361242-2994-1-git-send-email-linus.walleij@linaro.org> <1466361242-2994-8-git-send-email-linus.walleij@linaro.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Mon, 20 Jun 2016 20:06:23 +0900
Message-ID: <CAC5umyijkFtggSdSLyNzs8YZtk7g4qyFXfcu2W2uVAJ8u-x10g@mail.gmail.com>
Subject: Re: [PATCH 7/9] iio: pressure: bmp280: add SPI interface driver
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2016-06-20 3:34 GMT+09:00 Linus Walleij <linus.walleij@linaro.org>:
> This patch mimics the SPI functionality found in the misc driver in
> drivers/misc/bh085-spi.c to make it possible to reuse the existing
> BMP280/BMP180/BMP085 driver with all clients of the other driver.
> The adoption is straight-forward since like the other driver, it is
> a simple matter of using regmap.
>
> This driver is also so obviously inspired/copied from the old misc
> driver in drivers/misc/bmp085.c that I just took the liberty to
> add in the authors of the other drivers + self in the core driver
> file.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

...

> +static int bmp280_spi_probe(struct spi_device *spi)
> +{
> +       const struct spi_device_id *id = spi_get_device_id(spi);
> +       struct regmap *regmap;
> +       const struct regmap_config *regmap_config;
> +       int ret;
> +
> +       spi->bits_per_word = 8;
> +       ret = spi_setup(spi);
> +       if (ret < 0) {
> +               dev_err(&spi->dev, "spi_setup failed!\n");
> +               return ret;
> +       }
> +
> +       switch (id->driver_data) {
> +       case BMP180_CHIP_ID:
> +               regmap_config = &bmp180_regmap_config;
> +               break;
> +       case BMP280_CHIP_ID:
> +               regmap_config = &bmp280_regmap_config;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       regmap = devm_regmap_init_spi(spi, regmap_config);

I was also trying to support SPI interface for this driver and found
that we can't simply use regmap_init_spi().

Quote from 5.3 SPI interface in BMP280 datasheet:

        In SPI mode, only 7 bits of the register addresses are used; the MSB of
        register address is not used and replaced by a read/write bit (RW = ‘0’
        for write and RW = ‘1’ for read).  Example: address 0xF7 is accessed by
        using SPI register address 0x77. For write access, the byte 0x77 is
        transferred, for read access, the byte 0xF7 is transferred.

The write operation used by regmap_init_spi() doesn't replace the RW bit.
So we need custom regmap_bus like below.

static int bmp280_regmap_spi_write(void *context, const void *data,
                                   size_t count)
{
        struct device *dev = context;
        struct spi_device *spi = to_spi_device(dev);
        u8 buf[2];

        memcpy(buf, data, 2);

        /*
         * The SPI register address (= full register address without bit 7) and
         * the write command (bit7 = RW = '0')
         */
        buf[0] &= ~0x80;

        return spi_write_then_read(spi, buf, 2, NULL, 0);
}

static int bmp280_regmap_spi_read(void *context, const void *reg,
                                  size_t reg_size, void *val, size_t val_size)
{
        struct device *dev = context;
        struct spi_device *spi = to_spi_device(dev);

        return spi_write_then_read(spi, reg, reg_size, val, val_size);
}

static struct regmap_bus bmp280_regmap_spi = {
        .write = bmp280_regmap_spi_write,
        .read = bmp280_regmap_spi_read,
};
