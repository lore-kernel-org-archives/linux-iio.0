Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1321434819-23678-3-git-send-email-lars@metafoo.de>
References: <1321434819-23678-1-git-send-email-lars@metafoo.de> <1321434819-23678-3-git-send-email-lars@metafoo.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 16 Nov 2011 10:12:20 -0700
Message-ID: <CACxGe6toOFjOdP7-oZ4O2J=g2U+Y+aWOUzHDoCaX6goAs6zKsQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] I2C: Add helper macro for i2c_driver boilerplate
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jean Delvare <khali@linux-fr.org>,
	Jonathan Cameron <jic23@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, spi-devel-general@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Wed, Nov 16, 2011 at 2:13 AM, Lars-Peter Clausen <lars@metafoo.de> wrote=
:
> This patch introduces the module_i2c_driver macro which is a convenience =
macro
> for I2C driver modules similar to module_platform_driver. It is intended =
to be
> used by drivers which init/exit section does nothing but register/unregis=
ter
> the I2C driver. By using this macro it is possible to eliminate a few lin=
es of
> boilerplate code per I2C driver.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0include/linux/i2c.h | =A0 13 +++++++++++++
> =A01 files changed, 13 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index a81bf6d..7e92854 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -485,6 +485,19 @@ static inline int i2c_adapter_id(struct i2c_adapter =
*adap)
> =A0{
> =A0 =A0 =A0 =A0return adap->nr;
> =A0}
> +
> +/**
> + * module_i2c_driver() - Helper macro for registering a I2C driver
> + * @__i2c_driver: i2c_driver struct
> + *
> + * Helper macro for I2C drivers which do not do anything special in modu=
le
> + * init/exit. This eliminates a lot of boilerplate. Each module may only
> + * use this macro once, and calling it replaces module_init() and module=
_exit()
> + */
> +#define module_i2c_driver(__i2c_driver) \
> + =A0 =A0 =A0 module_driver(__i2c_driver, i2c_add_driver, \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_del_driver)
> +
> =A0#endif /* I2C */
> =A0#endif /* __KERNEL__ */
>
> --
> 1.7.7.1
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
