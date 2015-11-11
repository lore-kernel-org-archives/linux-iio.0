Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1447249974-27442-2-git-send-email-giuseppe.barba@st.com>
References: <1447249974-27442-1-git-send-email-giuseppe.barba@st.com>
	<1447249974-27442-2-git-send-email-giuseppe.barba@st.com>
Date: Wed, 11 Nov 2015 16:45:05 +0200
Message-ID: <CAEnQRZDaZTzVCfVmBgU_u5s+2MBVnXUrGKE8VCzA17JsJW9Jrw@mail.gmail.com>
Subject: Re: [V2] iio: st-accel: add support for lis2dh12
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Giuseppe Barba <giuseppe.barba@st.com>
Cc: Denis Ciocca <denis.ciocca@st.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Nov 11, 2015 at 3:52 PM, Giuseppe Barba <giuseppe.barba@st.com> wrote:
> This commit add support for STMicroelectronics lis2dh12 accelerometer.

Link to datasheet?

The subject should start with [PATCH v2] ...

>
> Signed-off-by: Giuseppe Barba <giuseppe.barba@st.com>
> ---

Here you should add a short changelog with what you changed since v1.

>  Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
>  drivers/iio/accel/st_accel.h                         | 1 +
>  drivers/iio/accel/st_accel_core.c                    | 1 +
>  drivers/iio/accel/st_accel_i2c.c                     | 5 +++++
>  drivers/iio/accel/st_accel_spi.c                     | 1 +
>  5 files changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
> index d3ccdb1..d4b87cc 100644
> --- a/Documentation/devicetree/bindings/iio/st-sensors.txt
> +++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
> @@ -36,6 +36,7 @@ Accelerometers:
>  - st,lsm303dlm-accel
>  - st,lsm330-accel
>  - st,lsm303agr-accel
> +- st,lis2dh12-accel
>
>  Gyroscopes:
>  - st,l3g4200d-gyro
> diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
> index 468f21f..5d4a189 100644
> --- a/drivers/iio/accel/st_accel.h
> +++ b/drivers/iio/accel/st_accel.h
> @@ -27,6 +27,7 @@
>  #define LSM303DLM_ACCEL_DEV_NAME       "lsm303dlm_accel"
>  #define LSM330_ACCEL_DEV_NAME          "lsm330_accel"
>  #define LSM303AGR_ACCEL_DEV_NAME       "lsm303agr_accel"
> +#define LIS2DH12_ACCEL_DEV_NAME                "lis2dh12_accel"
>
>  /**
>  * struct st_sensors_platform_data - default accel platform data
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index dab8b76..9d973f1 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -234,6 +234,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>                         [3] = LSM330DL_ACCEL_DEV_NAME,
>                         [4] = LSM330DLC_ACCEL_DEV_NAME,
>                         [5] = LSM303AGR_ACCEL_DEV_NAME,
> +                       [6] = LIS2DH12_ACCEL_DEV_NAME,
>                 },
>                 .ch = (struct iio_chan_spec *)st_accel_12bit_channels,
>                 .odr = {
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index 8b9cc84..294a32f 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -72,6 +72,10 @@ static const struct of_device_id st_accel_of_match[] = {
>                 .compatible = "st,lsm303agr-accel",
>                 .data = LSM303AGR_ACCEL_DEV_NAME,
>         },
> +       {
> +               .compatible = "st,lis2dh12-accel",
> +               .data = LIS2DH12_ACCEL_DEV_NAME,
> +       },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, st_accel_of_match);
> @@ -121,6 +125,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
>         { LSM303DLM_ACCEL_DEV_NAME },
>         { LSM330_ACCEL_DEV_NAME },
>         { LSM303AGR_ACCEL_DEV_NAME },
> +       { LIS2DH12_ACCEL_DEV_NAME },
>         {},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
> diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
> index 54b61a3..e82bedf 100644
> --- a/drivers/iio/accel/st_accel_spi.c
> +++ b/drivers/iio/accel/st_accel_spi.c
> @@ -58,6 +58,7 @@ static const struct spi_device_id st_accel_id_table[] = {
>         { LSM303DLM_ACCEL_DEV_NAME },
>         { LSM330_ACCEL_DEV_NAME },
>         { LSM303AGR_ACCEL_DEV_NAME },
> +       { LIS2DH12_ACCEL_DEV_NAME },
>         {},
>  };
>  MODULE_DEVICE_TABLE(spi, st_accel_id_table);
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
