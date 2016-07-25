Return-Path: <cmo@melexis.com>
MIME-Version: 1.0
In-Reply-To: <c64a366156bd450cae2419890e2ec06b0b09e93b.1469026858.git.leonard.crestez@intel.com>
References: <c64a366156bd450cae2419890e2ec06b0b09e93b.1469026858.git.leonard.crestez@intel.com>
From: Crt Mori <cmo@melexis.com>
Date: Mon, 25 Jul 2016 09:28:42 +0200
Message-ID: <CAKv63uufrAKU5M7bwzYT5Pfi+KOC=VhFE8Z1Br9kUVeagi3h=Q@mail.gmail.com>
Subject: Re: [RFC v2] regmap: Add regmap_pipe_read API
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
	Laurentiu Palcu <laurentiu.palcu@intel.com>, Linux Iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Adding linux-iio list to this - especially since there are IIO
drivers which work because of some special case...

Otherwise nice series.
Crt
On 20 July 2016 at 17:08, Crestez Dan Leonard <leonard.crestez@intel.com> wrote:
> The regmap API usually assumes that bulk read operations will read a
> range of registers but some I2C/SPI devices have certain registers for
> which a such a read operation will return data from an internal FIFO or
> some other kind of buffer. Add an explicit API to support bulk read with
> "output pipe" rather than range semantics.
>
> Some linux drivers use regmap_bulk_read or regmap_raw_read for such
> registers, for example mpu6050 or bmi150 from IIO. This only happens to
> work because when caching is disabled a single short regmap read op will
> map to a single bus read op and behave as intended. This breaks if
> caching is enabled and reg+1 happens to be a cacheable register.
>
> Without regmap support refactoring a driver to enable regmap caching
> requires separate i2c and spi paths. This is exactly what regmap is
> supposed to help avoid.
>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
>
> ---
> Changes since V1:
> * Improve comments. I think "pipe" is the correct word here.
> * Rely on void* pointer arithmetic instead of casting to u8*
>
> The SPMI implementations of regmap_bus have read functions which
> auto-increment internally and this will not work correctly with
> regmap_pipe_read. I think the correct fix would be for regmap-spmi to
> only implement reg_read. This can be considered an acceptable limitation
> because in order to run into this somebody would have to write new code
> to call this new API with an SPMI device.
>
> I attempted to also support this when the underlying bus only supports
> reg_read (for example an adapter with only I2C_FUNC_SMBUS_BYTE_DATA) but
> it's not clear how to do this on top of _regmap_read. Apparently this
> returns the value as an "unsigned int" which needs to be formatted
> according to val_bytes. Unfortunately map->format.format_val is not
> always available. Presumably the code dealing with this from regmap_bulk_read
> should be refactored into a separate function?
>
> It's not clear why regmap doesn't just always initialize format_val.
>
>  drivers/base/regmap/regmap.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/regmap.h       |  9 +++++++
>  2 files changed, 73 insertions(+)
>
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index df2d2ef..55c3090 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -2408,6 +2408,70 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
>  EXPORT_SYMBOL_GPL(regmap_raw_read);
>
>  /**
> + * regmap_pipe_read(): Read data from a register with pipe semantics
> + *
> + * @map: Register map to read from
> + * @reg: Register to read from
> + * @val: Pointer to data buffer
> + * @val_len: Length of output buffer in bytes.
> + *
> + * The regmap API usually assumes that bulk bus read operations will read a
> + * range of registers. Some devices have certain registers for which a read
> + * operation will read a block of data from an internal buffer.
> + *
> + * The target register must be volatile but registers after it can be
> + * completely unrelated cacheable registers.
> + *
> + * This will attempt multiple reads as required to read val_len bytes.
> + *
> + * This function is not supported over SPMI.
> + *
> + * A value of zero will be returned on success, a negative errno will be
> + * returned in error cases.
> + */
> +int regmap_pipe_read(struct regmap *map, unsigned int reg,
> +                    void *val, size_t val_len)
> +{
> +       size_t read_len;
> +       int ret;
> +
> +       if (!map->bus)
> +               return -EINVAL;
> +       if (!map->bus->read)
> +               return -ENOTSUPP;
> +       if (val_len % map->format.val_bytes)
> +               return -EINVAL;
> +       if (!IS_ALIGNED(reg, map->reg_stride))
> +               return -EINVAL;
> +       if (val_len == 0)
> +               return -EINVAL;
> +
> +       map->lock(map->lock_arg);
> +
> +       if (!regmap_volatile(map, reg)) {
> +               ret = -EINVAL;
> +               goto out_unlock;
> +       }
> +
> +       while (val_len) {
> +               if (map->max_raw_read && map->max_raw_read < val_len)
> +                       read_len = map->max_raw_read;
> +               else
> +                       read_len = val_len;
> +               ret = _regmap_raw_read(map, reg, val, read_len);
> +               if (ret)
> +                       goto out_unlock;
> +               val += read_len;
> +               val_len -= read_len;
> +       }
> +
> +out_unlock:
> +       map->unlock(map->lock_arg);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(regmap_pipe_read);
> +
> +/**
>   * regmap_field_read(): Read a value to a single register field
>   *
>   * @field: Register field to read from
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index 3dc08ce..18ee90e 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -719,6 +719,8 @@ int regmap_raw_write_async(struct regmap *map, unsigned int reg,
>  int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
>  int regmap_raw_read(struct regmap *map, unsigned int reg,
>                     void *val, size_t val_len);
> +int regmap_pipe_read(struct regmap *map, unsigned int reg,
> +                    void *val, size_t val_len);
>  int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
>                      size_t val_count);
>  int regmap_update_bits_base(struct regmap *map, unsigned int reg,
> @@ -955,6 +957,13 @@ static inline int regmap_raw_read(struct regmap *map, unsigned int reg,
>         return -EINVAL;
>  }
>
> +static inline int regmap_pipe_read(struct regmap *map, unsigned int reg,
> +                                  void *val, size_t val_len)
> +{
> +       WARN_ONCE(1, "regmap API is disabled");
> +       return -EINVAL;
> +}
> +
>  static inline int regmap_bulk_read(struct regmap *map, unsigned int reg,
>                                    void *val, size_t val_count)
>  {
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
