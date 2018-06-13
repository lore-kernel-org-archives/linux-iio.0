Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:54139 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935245AbeFMTY7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 13 Jun 2018 15:24:59 -0400
Date: Thu, 14 Jun 2018 03:23:53 +0800
From: kbuild test robot <lkp@intel.com>
To: Borys Movchan <borys.movchan@axis.com>
Cc: kbuild-all@01.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Borys Movchan <borysmn@axis.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeff LaBundy <jeff@labundy.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: add ISL29033 Ultra-Low Lux
 ambient-light-sensor
Message-ID: <201806140109.tvP88cyu%fengguang.wu@intel.com>
References: <20180613140043.5802-2-borys.movchan@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180613140043.5802-2-borys.movchan@axis.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Borys,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on iio/togreg]
[also build test WARNING on v4.17 next-20180613]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Borys-Movchan/dt-bindings-iio-light-add-ISL29033-device-bindings/20180613-220725
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/iio/light/isl29033.c:235:15: sparse: cast to restricted __be16
>> drivers/iio/light/isl29033.c:235:15: sparse: cast to restricted __be16
>> drivers/iio/light/isl29033.c:235:15: sparse: cast to restricted __be16
>> drivers/iio/light/isl29033.c:235:15: sparse: cast to restricted __be16

vim +235 drivers/iio/light/isl29033.c

   220	
   221	static int isl29033_read_sensor_input(struct isl29033_chip *chip)
   222	{
   223		int ret;
   224		u16 val;
   225		struct device *dev = regmap_get_device(chip->regmap);
   226	
   227		ret = regmap_bulk_read(chip->regmap, ISL29033_REG_ADD_DATA_LSB,
   228					(u8 *)&val, 2);
   229		if (ret < 0) {
   230			dev_err(dev,
   231				"Data bulk read error %d\n", ret);
   232			return ret;
   233		}
   234	
 > 235		val = be16_to_cpu(val);
   236		dev_vdbg(dev, "Data read: %x\n", val);
   237	
   238		return val;
   239	}
   240	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
