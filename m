Return-Path: <SRS0=Kdk2=ET=intel.com=fengguang.wu@kernel.org>
Date: Thu, 25 Jan 2018 02:53:42 +0800
From: kbuild test robot <lkp@intel.com>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: kbuild-all@01.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: Re: [PATCH] Staging: iio: ade7758: Expand buf_lock to cover both
 buffer
Message-ID: <201801250253.o4jdYyJW%fengguang.wu@intel.com>
References: <1516654973-6434-1-git-send-email-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1516654973-6434-1-git-send-email-shreeya.patel23498@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Hi Shreeya,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on iio/togreg]
[also build test WARNING on v4.15-rc9 next-20180119]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Shreeya-Patel/Staging-iio-ade7758-Expand-buf_lock-to-cover-both-buffer/20180124-234049
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/staging/iio/meter/ade7758_core.c:28:5: sparse: symbol '__ade7758_spi_write_reg_8' was not declared. Should it be
>> drivers/staging/iio/meter/ade7758_core.c:104:5: sparse: symbol '__ade7758_spi_read_reg_8' was not declared. Should it be

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
