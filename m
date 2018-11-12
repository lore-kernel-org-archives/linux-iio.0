Return-Path: <SRS0=EkPT=NX=gmail.com=robherring2@kernel.org>
From: Rob Herring <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	mark.rutland@arm.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@bq.com>
Subject: Re: [PATCH] iio: st-accel: add support for lis3de
Message-ID: <20181112185927.GA17634@bogus>
References: <20181107154521.32761-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181107154521.32761-1-heiko@sntech.de>
Date: Mon, 12 Nov 2018 12:59:29 -0600
List-ID: <linux-iio@vger.kernel.org>

On Wed, Nov 07, 2018 at 04:45:21PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@bq.com>
> 
> This commit add support for STMicroelectronics lis3de accelerometer.
> Datasheet for this device can be found here:
> 
> https://www.st.com/resource/en/datasheet/lis3de.pdf
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
> ---
>  Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/accel/Kconfig                            | 2 +-
>  drivers/iio/accel/st_accel.h                         | 1 +
>  drivers/iio/accel/st_accel_core.c                    | 1 +
>  drivers/iio/accel/st_accel_i2c.c                     | 5 +++++
>  drivers/iio/accel/st_accel_spi.c                     | 5 +++++
>  include/linux/iio/common/st_sensors.h                | 2 +-
>  7 files changed, 15 insertions(+), 2 deletions(-)
