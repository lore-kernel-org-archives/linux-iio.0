Return-Path: <joe@perches.com>
Subject: Re: [PATCH v3] iio: light: Adding driver for ISL29018 ALS
From: Joe Perches <joe@perches.com>
To: rklein@nvidia.com
Cc: jic23@cam.ac.uk, achew@nvidia.com, olof@lixom.net,
 linux-i2c@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, ldewangan@nvidia.com
In-Reply-To: <1286318566-9782-1-git-send-email-rklein@nvidia.com>
References: <1286318566-9782-1-git-send-email-rklein@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Oct 2010 18:36:48 -0700
Message-ID: <1286329008.2156.78.camel@Joe-Laptop>
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Tue, 2010-10-05 at 15:42 -0700, rklein@nvidia.com wrote:
> From: Rhyland Klein <rklein@nvidia.com>

Hi again.

> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
[]
> +#define ISL29018_REG_ADD_DATA_LSB	0x02
> +#define ISL29018_REG_ADD_DATA_MSB	0x03
> +#define ISL29018_MAX_REGS		ISL29018_REG_ADD_DATA_MSB
> +
> +struct isl29018_chip {
> +	struct iio_dev		*indio_dev;
> +	struct i2c_client	*client;
> +	struct mutex		lock;
> +	unsigned int		range;
> +	unsigned int		adc_bit;
> +	int			prox_scheme;
> +	u8			reg_cache[ISL29018_MAX_REGS];
> +};
[]
> +static int isl29018_chip_init(struct i2c_client *client)
> +{
> +	struct isl29018_chip *chip = i2c_get_clientdata(client);
[]
> +	memset((void *)chip->reg_cache, 0, ARRAY_SIZE(chip->reg_cache));

Turns out there's only 3 of these registers.
Earlier, I believe you said 32 bytes. 

I think the normal kernel style is:

	memset(chip->reg_cache, 0, sizeof(chip->reg_cache));

ARRAY_SIZE works, but only because reg_cache is u8.

cheers, Joe
