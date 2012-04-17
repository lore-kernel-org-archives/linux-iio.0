Return-Path: <omaplinuxkernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1333971244-10684-1-git-send-email-srinidhi.kasagar@stericsson.com>
References: <1333971244-10684-1-git-send-email-srinidhi.kasagar@stericsson.com>
Date: Tue, 17 Apr 2012 11:59:36 +0530
Message-ID: <CAM=Q2csOWte=C3iDrqBsKxrb-Yg4Ne-1kS+79iCaMVua1iDUBQ@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: add lsm303dlh magnetometer driver
From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
To: Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>
Cc: jic23@cam.ac.uk, linux-iio@vger.kernel.org, linus.walleij@linaro.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi Srinidhi,

On Mon, Apr 9, 2012 at 5:04 PM, Srinidhi KASAGAR
<srinidhi.kasagar@stericsson.com> wrote:
> Add support for lsm303dlh magnetometer device.
>
> Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> =A0drivers/staging/iio/magnetometer/Kconfig =A0 =A0 | =A0 10 +
> =A0drivers/staging/iio/magnetometer/Makefile =A0 =A0| =A0 =A01 +
> =A0drivers/staging/iio/magnetometer/lsm303dlh.c | =A0803 ++++++++++++++++=
++++++++++
> =A03 files changed, 814 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/staging/iio/magnetometer/lsm303dlh.c
>
> diff --git a/drivers/staging/iio/magnetometer/Kconfig b/drivers/staging/i=
io/magnetometer/Kconfig
> index 722c4e1..840eaba 100644
> --- a/drivers/staging/iio/magnetometer/Kconfig
> +++ b/drivers/staging/iio/magnetometer/Kconfig
> @@ -24,4 +24,14 @@ config SENSORS_HMC5843
> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here: the=
 module
> =A0 =A0 =A0 =A0 =A0will be called hmc5843
>
> +config SENSORS_LSM303DLH
> + =A0 =A0 =A0 tristate "STMicroelectronics LSM303DLH 3-Axis Magnetometer"
> + =A0 =A0 =A0 depends on I2C
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Say Y here to add support for the STMicroelectronics
> + =A0 =A0 =A0 =A0 LSM303DLH 3-Axis Magnetometer.
> +
> + =A0 =A0 =A0 =A0 To compile this driver as a module, choose M here: the =
module
> + =A0 =A0 =A0 =A0 will be called lsm303dlh.
> +
> =A0endmenu
> diff --git a/drivers/staging/iio/magnetometer/Makefile b/drivers/staging/=
iio/magnetometer/Makefile
> index f2a753f..e09007b 100644
> --- a/drivers/staging/iio/magnetometer/Makefile
> +++ b/drivers/staging/iio/magnetometer/Makefile
> @@ -4,3 +4,4 @@
>
> =A0obj-$(CONFIG_SENSORS_AK8975) =A0 +=3D ak8975.o
> =A0obj-$(CONFIG_SENSORS_HMC5843) =A0+=3D hmc5843.o
> +obj-$(CONFIG_SENSORS_LSM303DLH) =A0 =A0 =A0 =A0+=3D lsm303dlh.o
> diff --git a/drivers/staging/iio/magnetometer/lsm303dlh.c b/drivers/stagi=
ng/iio/magnetometer/lsm303dlh.c
> new file mode 100644
> index 0000000..4b23083
> --- /dev/null
> +++ b/drivers/staging/iio/magnetometer/lsm303dlh.c
> @@ -0,0 +1,803 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2012
> + * License Terms: GNU General Public License, version 2
> + *
> + * This code is mostly based on hmc5843 driver
> + *

How different is it from the hmc5843 driver Can we add support in the
hmc driver itself?
