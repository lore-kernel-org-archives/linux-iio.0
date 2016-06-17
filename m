Return-Path: <fengguang.wu@intel.com>
Date: Sat, 18 Jun 2016 05:20:44 +0800
From: kbuild test robot <lkp@intel.com>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: kbuild-all@01.org, Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [PATCH v3] iio: Add driver for Silabs si1132, si1141/2/3 and
 si1145/6/7 ambient light, uv index and proximity sensors
Message-ID: <201606180552.Se53pkBn%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cfa05b01fcdcdc7ec5d3e5a7bb937122162d1176.1466161813.git.leonard.crestez@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Hi,

[auto build test WARNING on iio/togreg]
[also build test WARNING on v4.7-rc3 next-20160617]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Crestez-Dan-Leonard/iio-Add-driver-for-Silabs-si1132-si1141-2-3-and-si1145-6-7-ambient-light-uv-index-and-proximity-sensors/20160617-191427
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg


coccinelle warnings: (new ones prefixed by >>)

>> drivers/iio/light/si1145.c:1336:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
