Return-Path: <SRS0=Xsfc=KE=gmail.com=robherring2@kernel.org>
Date: Fri, 20 Jul 2018 11:02:42 -0600
From: Rob Herring <robh@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: jic23@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
	david.brown@linaro.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
	jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
	fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com,
	drew.paterson@ams.com
Subject: Re: [PATCH v2 1/7] iio: imu: mpu6050: add support for regulator
 framework
Message-ID: <20180720170242.GA18120@rob-hp-laptop>
References: <20180717084158.23532-1-masneyb@onstation.org>
 <20180717084158.23532-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180717084158.23532-2-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jul 17, 2018 at 04:41:52AM -0400, Brian Masney wrote:
> This patch adds support for the regulator framework to the mpu6050
> driver.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
> Changes since v1:
> - Use devm_regulator_get() instead of devm_regulator_get_optional()
> - Use devm_add_action() for cleaning up the regulator.
> - Correct ordering of resume code.
> - Add regulator_enabled flag to ensure regulator is not disabled twice,
>   specifically the case where the device is suspended and then the
>   driver is removed.
> 
> Original extra changelog from v1:
> 
> This is a variation of Jonathan Marek's patch from postmarketOS
> https://gitlab.com/postmarketOS/linux-postmarketos/commit/b8ad1ec1859c8bbcbce94944b3f4dd68f8f9fc37
> with the following changes:
> 
> - Stripped out 6515 variant code.
> - Add the regulator to the mpu core instead of only the i2c variant.
> - Add error handling.
> - Release the regulator on suspend, device remove, etc.
> - Device tree documentation.
> 
>  .../bindings/iio/imu/inv_mpu6050.txt          |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 73 +++++++++++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  3 +
>  3 files changed, 77 insertions(+)
