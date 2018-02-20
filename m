Return-Path: <SRS0=J+uo=FO=intel.com=fengguang.wu@kernel.org>
Date: Tue, 20 Feb 2018 17:12:25 +0800
From: kbuild test robot <lkp@intel.com>
To: Quentin Schulz <quentin.schulz@bootlin.com>
Cc: kbuild-all@01.org, sre@kernel.org, robh+dt@kernel.org,
	mark.rutland@arm.com, wens@csie.org, linux@armlinux.org.uk,
	maxime.ripard@bootlin.com, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, thomas.petazzoni@bootlin.com,
	linux-sunxi@googlegroups.com,
	Quentin Schulz <quentin.schulz@bootlin.com>
Subject: Re: [PATCH v4 06/13] power: supply: axp20x_battery: use data struct
 for variant specific code
Message-ID: <201802201606.lLg38XZv%fengguang.wu@intel.com>
References: <52f68b8ed9452d643d9156a849014c9d0eb4404b.1519044068.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52f68b8ed9452d643d9156a849014c9d0eb4404b.1519044068.git-series.quentin.schulz@bootlin.com>
List-ID: <linux-iio@vger.kernel.org>

Hi Quentin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on ]

url:    https://github.com/0day-ci/linux/commits/Quentin-Schulz/add-support-for-AXP813-ADC-and-battery-power-supply/20180220-051138
base:    
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/power/supply/axp20x_battery.c:479:23: sparse: symbol 'axp209_data' was not declared. Should it be
>> drivers/power/supply/axp20x_battery.c:486:23: sparse: symbol 'axp221_data' was not declared. Should it be

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
