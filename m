Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1321434819-23678-4-git-send-email-lars@metafoo.de>
References: <1321434819-23678-1-git-send-email-lars@metafoo.de> <1321434819-23678-4-git-send-email-lars@metafoo.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 16 Nov 2011 10:12:54 -0700
Message-ID: <CACxGe6tz0ppZj=a_e4rkgNxzhQ4MSCtXKXGk_dPov80QDU4MCg@mail.gmail.com>
Subject: Re: [PATCH 3/5] SPI: Add helper macro for spi_driver boilerplate
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jean Delvare <khali@linux-fr.org>,
	Jonathan Cameron <jic23@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, spi-devel-general@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Wed, Nov 16, 2011 at 2:13 AM, Lars-Peter Clausen <lars@metafoo.de> wrote=
:
> This patch introduces the module_spi_driver macro which is a convenience =
macro
> for SPI driver modules similar to module_platform_driver. It is intended =
to be
> used by drivers which init/exit section does nothing but register/unregis=
ter
> the SPI driver. By using this macro it is possible to eliminate a few lin=
es of
> boilerplate code per SPI driver.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0include/linux/spi/spi.h | =A0 11 +++++++++++
> =A01 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index bb4f5fb..176fce9 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -200,6 +200,17 @@ static inline void spi_unregister_driver(struct spi_=
driver *sdrv)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0driver_unregister(&sdrv->driver);
> =A0}
>
> +/**
> + * module_spi_driver() - Helper macro for registering a SPI driver
> + * @__spi_driver: spi_driver struct
> + *
> + * Helper macro for SPI drivers which do not do anything special in modu=
le
> + * init/exit. This eliminates a lot of boilerplate. Each module may only
> + * use this macro once, and calling it replaces module_init() and module=
_exit()
> + */
> +#define module_spi_driver(__spi_driver) \
> + =A0 =A0 =A0 module_driver(__spi_driver, spi_register_driver, \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_unregister_driver)
>
> =A0/**
> =A0* struct spi_master - interface to SPI master controller
> --
> 1.7.7.1
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
