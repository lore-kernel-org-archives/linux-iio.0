Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:40216 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeHBVoi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Aug 2018 17:44:38 -0400
MIME-Version: 1.0
In-Reply-To: <20180802191554.20176-1-marcus.folkesson@gmail.com>
References: <20180802191554.20176-1-marcus.folkesson@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 2 Aug 2018 22:52:00 +0300
Message-ID: <CAHp75Vf8kMLsoFN_EK150yW_FvH8XfgjiETYAtvW63et5NNurw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: adc: add support for mcp3911
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Aug 2, 2018 at 10:15 PM, Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
> MCP3911 is a dual channel Analog Front End (AFE) containing two
> synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

> Signed-off-by: Kent Gustavsson <kent@minoris.se>

What is this? Why it's here (presense and location in the message)?

> + * Copyright (C) 2018 Kent Gustavsson <kent@minoris.se>

> + *

Redundant.

> +static int mcp3911_read(struct mcp3911 *adc, u8 reg, u32 *val, u8 len)
> +{
> +       int ret;
> +
> +       reg = MCP3911_REG_READ(reg, adc->dev_addr);
> +       ret = spi_write_then_read(adc->spi, &reg, 1, val, len);
> +       if (ret < 0)
> +               return ret;
> +
> +       be32_to_cpus(val);
> +       *val >>= ((4 - len) * 8);
> +       dev_dbg(&adc->spi->dev, "reading 0x%x from register 0x%x\n", *val,
> +                       reg>>1);
> +       return ret;
> +}
> +
> +static int mcp3911_write(struct mcp3911 *adc, u8 reg, u32 val, u8 len)
> +{
> +       dev_dbg(&adc->spi->dev, "writing 0x%x to register 0x%x\n", val, reg);
> +
> +       val <<= (3 - len) * 8;
> +       cpu_to_be32s(&val);
> +       val |= MCP3911_REG_WRITE(reg, adc->dev_addr);
> +
> +       return spi_write(adc->spi, &val, len + 1);
> +}

Can't you use REGMAP_SPI ?

> +       of_property_read_u32(of_node, "device-addr", &adc->dev_addr);
> +       if (adc->dev_addr > 3) {
> +               dev_err(&adc->spi->dev,
> +                               "invalid device address (%i). Must be in range 0-3.\n",
> +                               adc->dev_addr);
> +               return -EINVAL;
> +       }
> +       dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_addr);

Isn't what we called CS (chip select)?

> +       if (IS_ERR(adc->vref)) {

> +

Redundant.

> +       if (adc->clki)

Seems to be redundant if clock is optional (it should be NULL and API
is NULL-aware).

> +               clk_disable_unprepare(adc->clki);

> +       if (adc->clki)
> +               clk_disable_unprepare(adc->clki);

Ditto.

> +#if defined(CONFIG_OF)

This prevents playing with the device on ACPI enabled platforms.

> +               .of_match_table = of_match_ptr(mcp3911_dt_ids),

Ditto for macro.

-- 
With Best Regards,
Andy Shevchenko
