Return-Path: <leonard.crestez@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [PATCH] iio: inv_mpu6050: Add support for auxiliary I2C master
To: linux-iio@vger.kernel.org
References: <201604210259.xtIWnZqM%fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Daniel Baluta <daniel.baluta@intel.com>, linux-i2c@vger.kernel.org,
 Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>,
 Jonathan Cameron <jic23@kernel.org>
Message-ID: <5718A53E.90101@intel.com>
Date: Thu, 21 Apr 2016 13:02:38 +0300
MIME-Version: 1.0
In-Reply-To: <201604210259.xtIWnZqM%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 04/20/2016 09:17 PM, kbuild test robot wrote:
> Hi,
> 
> [auto build test ERROR on iio/togreg]
> [also build test ERROR on v4.6-rc4 next-20160420]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Crestez-Dan-Leonard/iio-inv_mpu6050-Add-support-for-auxiliary-I2C-master/20160421-012042
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: i386-randconfig-i1-201616 (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/iio/imu/inv_mpu6050/inv_mpu_core.c: In function 'inv_mpu_core_probe':
>>> drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:966:11: error: implicit declaration of function 'i2c_add_adapter' [-Werror=implicit-function-declaration]
>      result = i2c_add_adapter(&st->aux_master_adapter);
>               ^
>>> drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:983:2: error: implicit declaration of function 'i2c_del_adapter' [-Werror=implicit-function-declaration]
>      i2c_del_adapter(&st->aux_master_adapter);
>      ^
>    cc1: some warnings being treated as errors

This error happens if you disable CONFIG_I2C and only compile with SPI
support. I will add a bunch of #ifdef CONFIG_I2C in the next version.
