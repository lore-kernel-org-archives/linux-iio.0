Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:37099 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbdIEKLq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Sep 2017 06:11:46 -0400
Date: Tue, 5 Sep 2017 12:11:44 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Andrew F. Davis" <afd@ti.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Daniel Mack <daniel@zonque.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: misc: ti_dac7512: Remove duplicate driver
Message-ID: <20170905101144.GA23808@wunner.de>
References: <be82f31ef2f0f39c7893b42dfe46c7235ea6144a.1504604178.git.lukas@wunner.de>
 <d5a12cb12480235e05315e9c8fa6e8b5f5a3dfb6.1504604178.git.lukas@wunner.de>
 <CAK8P3a2L+wOER7LwXApD_YrVA7Zi9D96FZC5zAm_+aSy+qG0rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK8P3a2L+wOER7LwXApD_YrVA7Zi9D96FZC5zAm_+aSy+qG0rg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Sep 05, 2017 at 11:56:02AM +0200, Arnd Bergmann wrote:
> On Tue, Sep 5, 2017 at 11:44 AM, Lukas Wunner <lukas@wunner.de> wrote:
> > The Texas Instruments DAC7512 has the exact same pinout, programming
> > interface and power-down modes as the Texas Instruments DAC121S101 and
> > Analog Devices AD5320, which are already supported by the IIO driver
> > ad5446.c.  Remove the duplicate misc driver.
> >
> > This requires user space to migrate to the standardized IIO sysfs ABI.
> > (In other words, it needs to change a filename.)
> >
> > The IIO driver supports the chip's features more fully, e.g. the ability
> > to power down the output or choose one of the available powerdown modes.
> >
> > There is an oddity with the misc driver in that it initializes the SPI
> > slave to SPI_MODE_0, in contradiction to the datasheet which specifies
> > that data is latched in on the falling edge, implying that SPI_MODE_1
> > or SPI_MODE_2 must be used.  Another oddity is that Kconfig and the
> > MODULE_DESCRIPTION() claim the chip has 16-bit resolution although it
> > actually has 12-bit.
> >
> > Datasheets:
> > http://www.ti.com/lit/ds/symlink/dac7512.pdf
> > http://www.ti.com/lit/ds/symlink/dac121s101.pdf
> > http://www.analog.com/media/en/technical-documentation/data-sheets/AD5320.pdf
> >
> > Cc: Daniel Mack <daniel@zonque.org>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> 
> Good catch, removing duplicate code is usually a good idea.
> 
> However, for the incompatible user space ABI change, we need a better
> reasoning why this is safe to do and won't catch users by surprise.
> 
> If anyone relies on the old ABI and can't be expected to change,
> we need to stay compatible. Do we know who uses the old driver?

Daniel introduced it for use in Raumfeld speakers.

The IIO subsystem predates this driver by a few months.  I don't know
why it uses a nonstandard file in sysfs and wasn't based on IIO.

I'm wondering if the driver has ever worked because of the SPI_MODE_0
issue mentioned above.  If it did, it must have been by accident.
Or the datasheet is wrong, which seems unlikely.


> > -
> > -static const struct spi_device_id dac7512_id_table[] = {
> > -       { "dac7512", 0 },
> > -       { }
> > -};
> > -MODULE_DEVICE_TABLE(spi, dac7512_id_table);
> > -
> > -#ifdef CONFIG_OF
> > -static const struct of_device_id dac7512_of_match[] = {
> > -       { .compatible = "ti,dac7512", },
> > -       { }
> > -};
> 
> The other driver doesn't appear to have an of_match table, so
> I suspect it won't automatically get loaded.

I added one in this patch, check again.


> Can you update
> Documentation/devicetree/bindings/iio/dac/ti,dac7512.txt
> in an appropriate way to list all the IDs that are supported
> by the IIO driver, and make sure that the driver supports
> all the IDs that it needs?

There are no DT bindings documented for ad5446.c, so I left
this file as is, its contents continue to apply.

I guess I could amend the newly introduced OF match table with
all existing SPI IDs supported by ad5446.c and document those
in the DT bindings if desired?

Thanks,

Lukas
