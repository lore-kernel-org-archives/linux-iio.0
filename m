Return-Path: <SRS0=invK=J3=gmail.com=himanshujha199640@kernel.org>
Date: Wed, 11 Jul 2018 15:34:43 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Brian Masney <masneyb@onstation.org>
Cc: jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
	andy.gross@linaro.org, david.brown@linaro.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org, jonathan@marek.ca,
	jmaneyrol@invensense.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, mkelly@xevo.com, fischerdouglasc@gmail.com,
	bshah@kde.org, ctatlor97@gmail.com
Subject: Re: [PATCH 2/3] iio: imu: mpu6050: add support for regulator
 framework
Message-ID: <20180711100442.GA30019@himanshu-Vostro-3559>
References: <20180711010932.20313-1-masneyb@onstation.org>
 <20180711010932.20313-3-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180711010932.20313-3-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

Hi Brain,

On Tue, Jul 10, 2018 at 09:09:31PM -0400, Brian Masney wrote:
> This patch adds support for the regulator framework to the mpu6050
> driver.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  }
>  EXPORT_SYMBOL_GPL(inv_mpu_core_probe);
>  
> +int inv_mpu_core_remove(struct inv_mpu6050_state *st)
> +{
> +	return regulator_disable(st->vddio_supply);
> +}
EXPORT_SYMBOL_GPL(inv_mpu_core_remove); ?

This is causing 0-day test build failure perhaps.

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
