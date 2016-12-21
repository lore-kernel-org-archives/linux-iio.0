Return-Path: <SRS0=fx6V=YE=perches.com=joe@kernel.org>
Message-ID: <1482290625.1984.33.camel@perches.com>
Subject: Re: [PATCH] indention and space fixes to align with linux style
From: Joe Perches <joe@perches.com>
To: Scott Matheina <scott@matheina.com>, gregkh@linuxfoundation.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Dec 2016 19:23:45 -0800
In-Reply-To: <1482289187-7276-1-git-send-email-scott@matheina.com>
References: <1482289187-7276-1-git-send-email-scott@matheina.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Tue, 2016-12-20 at 20:58 -0600, Scott Matheina wrote:
> Fixed indention and space issues to align the code with the linux style guide.
[]
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
[]
> @@ -176,16 +176,16 @@
>   */
> 
>  struct adt7316_chip_info {
> -	struct adt7316_bus	bus;
> -	u16			ldac_pin;
> -	u16			int_mask;	/* 0x2f */
> -	u8			config1;
> -	u8			config2;
> -	u8			config3;
> -	u8			dac_config;	/* DAC config */
> -	u8			ldac_config;	/* LDAC config */
> -	u8			dac_bits;	/* 8, 10, 12 */
> -	u8			id;		/* chip id */
> +	struct adt7316_bus bus;
> +	u16 ldac_pin;
> +	u16 int_mask;		/* 0x2f */
> +	u8 config1;
> +	u8 config2;
> +	u8 config3;
> +	u8 dac_config;		/* DAC config */
> +	u8 ldac_config;		/* LDAC config */
> +	u8 dac_bits;		/* 8, 10, 12 */
> +	u8 id;			/* chip id */
>  };

Hello Scott.

I believe you're relatively new at this
patch submission stuff.

The style above is fine and doesn't need
to be changed.  It is not in CodingStyle
as preferred one way or the other.

>  /*
> @@ -212,13 +212,12 @@ struct adt7316_chip_info {
>   */
> 
>  struct adt7316_limit_regs {
> -	u16	data_high;
> -	u16	data_low;
> +	u16 data_high;
> +	u16 data_low;
>  };
> 
>  static ssize_t adt7316_show_enabled(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +				    struct device_attribute *attr, char *buf)

This one isn't either but it is a very common
style in net/, drivers/net, and drivers/staging
though.
