Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:38584 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbeGKJK0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 11 Jul 2018 05:10:26 -0400
Date: Wed, 11 Jul 2018 05:07:06 -0400
From: Brian Masney <masneyb@onstation.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, jic23@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com
Subject: Re: [PATCH 2/3] iio: imu: mpu6050: add support for regulator
 framework
Message-ID: <20180711090706.fqflz4nzpypuwywj@d08157822050>
References: <20180711010932.20313-3-masneyb@onstation.org>
 <201807111656.iDIpGrc7%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201807111656.iDIpGrc7%fengguang.wu@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jul 11, 2018 at 04:50:22PM +0800, kbuild test robot wrote:
> Hi Brian,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on iio/togreg]
> [also build test ERROR on next-20180710]
> [cannot apply to v4.18-rc4]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Brian-Masney/iio-imu-mpu6050-add-support-for-6515-variant/20180711-092023
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: x86_64-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
> >> ERROR: "inv_mpu_core_remove" [drivers/iio/imu/inv_mpu6050/inv-mpu6050-spi.ko] undefined!
> >> ERROR: "inv_mpu_core_remove" [drivers/iio/imu/inv_mpu6050/inv-mpu6050-i2c.ko] undefined!

This patch applies cleanly against the iio/testing branch.

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=testing

Brian
