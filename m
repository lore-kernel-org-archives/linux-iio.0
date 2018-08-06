Return-Path: <SRS0=4IjE=KV=opensource.cirrus.com=ckeepax@kernel.org>
Date: Mon, 6 Aug 2018 11:25:08 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Stefan Popa <stefan.popa@analog.com>
CC: <jic23@kernel.org>, <broonie@kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Crestez Dan
 Leonard" <leonard.crestez@intel.com>
Subject: Re: [PATCH v3 3/6] regmap: Add regmap_noinc_read API
Message-ID: <20180806102508.GA32322@imbe.wolfsonmicro.main>
References: <1533301341-26560-1-git-send-email-stefan.popa@analog.com>
 <1533301341-26560-4-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1533301341-26560-4-git-send-email-stefan.popa@analog.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Aug 03, 2018 at 04:02:18PM +0300, Stefan Popa wrote:
> From: Crestez Dan Leonard <leonard.crestez@intel.com>
> 
> The regmap API usually assumes that bulk read operations will read a
> range of registers but some I2C/SPI devices have certain registers for
> which a such a read operation will return data from an internal FIFO
> instead. Add an explicit API to support bulk read without range semantics.
> 
> Some linux drivers use regmap_bulk_read or regmap_raw_read for such
> registers, for example mpu6050 or bmi150 from IIO. This only happens to
> work because when caching is disabled a single regmap read op will map
> to a single bus read op (as desired). This breaks if caching is enabled and
> reg+1 happens to be a cacheable register.
> 
> Without regmap support refactoring a driver to enable regmap caching
> requires separate I2C and SPI paths. This is exactly what regmap is
> supposed to help avoid.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index 4f38068..b6e6040 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -946,6 +946,8 @@ int regmap_raw_write_async(struct regmap *map, unsigned int reg,
>  int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
>  int regmap_raw_read(struct regmap *map, unsigned int reg,
>  		    void *val, size_t val_len);
> +int regmap_noinc_read(struct regmap *map, unsigned int reg,
> +		      void *val, size_t val_len);
>  int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
>  		     size_t val_count);
>  int regmap_update_bits_base(struct regmap *map, unsigned int reg,
> @@ -1196,6 +1198,13 @@ static inline int regmap_raw_read(struct regmap *map, unsigned int reg,
>  	return -EINVAL;
>  }
>  
> +static inline int regmap_pipe_read(struct regmap *map, unsigned int reg,
> +				   void *val, size_t val_len)
> +{
> +	WARN_ONCE(1, "regmap API is disabled");
> +	return -EINVAL;
> +}
> +

This is presumably supposed to be regmap_noinc_read.

Thanks,
Charles
