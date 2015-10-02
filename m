Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22885 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932AbbJBNwx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 2 Oct 2015 09:52:53 -0400
Date: Fri, 2 Oct 2015 21:53:06 +0800
From: kbuild test robot <lkp@intel.com>
To: Paul Cercueil <paul.cercueil@analog.com>
Cc: kbuild-all@01.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antonio Fiol <antonio@fiol.es>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Paul Cercueil <paul.cercueil@analog.com>
Subject: Re: [PATCH 2/2] iio: dac: Add support for the AD5592R/AD5593R
 ADCs/DACs
Message-ID: <201510022121.1QklnZU3%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443789956-25340-2-git-send-email-paul.cercueil@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Paul,

[auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]

reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/iio/dac/ad5592r.c:20:19: sparse: incorrect type in initializer (different base types)
   drivers/iio/dac/ad5592r.c:20:19:    expected unsigned short [unsigned] [usertype] msg
   drivers/iio/dac/ad5592r.c:20:19:    got restricted __be16 [usertype] <noident>
   drivers/iio/dac/ad5592r.c:28:19: sparse: incorrect type in initializer (different base types)
   drivers/iio/dac/ad5592r.c:28:19:    expected unsigned short [unsigned] [usertype] msg
   drivers/iio/dac/ad5592r.c:28:19:    got restricted __be16 [usertype] <noident>
>> drivers/iio/dac/ad5592r.c:41:18: sparse: cast to restricted __be16
>> drivers/iio/dac/ad5592r.c:41:18: sparse: cast to restricted __be16
>> drivers/iio/dac/ad5592r.c:41:18: sparse: cast to restricted __be16
>> drivers/iio/dac/ad5592r.c:41:18: sparse: cast to restricted __be16
   drivers/iio/dac/ad5592r.c:48:19: sparse: incorrect type in initializer (different base types)
   drivers/iio/dac/ad5592r.c:48:19:    expected unsigned short [unsigned] [usertype] msg
   drivers/iio/dac/ad5592r.c:48:19:    got restricted __be16 [usertype] <noident>
   drivers/iio/dac/ad5592r.c:56:19: sparse: incorrect type in initializer (different base types)
   drivers/iio/dac/ad5592r.c:56:19:    expected unsigned short [unsigned] [usertype] msg
   drivers/iio/dac/ad5592r.c:56:19:    got restricted __be16 [usertype] <noident>
   drivers/iio/dac/ad5592r.c:68:26: sparse: cast to restricted __be16
   drivers/iio/dac/ad5592r.c:68:26: sparse: cast to restricted __be16
   drivers/iio/dac/ad5592r.c:68:26: sparse: cast to restricted __be16
   drivers/iio/dac/ad5592r.c:68:26: sparse: cast to restricted __be16
--
>> drivers/iio/dac/ad5593r.c:28:15: sparse: incorrect type in assignment (different base types)
   drivers/iio/dac/ad5593r.c:28:15:    expected unsigned short [unsigned] [usertype] value
   drivers/iio/dac/ad5593r.c:28:15:    got restricted __be16 [usertype] <noident>
>> drivers/iio/dac/ad5593r.c:38:25: sparse: incorrect type in argument 3 (different base types)
   drivers/iio/dac/ad5593r.c:38:25:    expected unsigned short [unsigned] [usertype] value
   drivers/iio/dac/ad5593r.c:38:25:    got restricted __be16 [usertype] <noident>
>> drivers/iio/dac/ad5593r.c:48:18: sparse: cast to restricted __be16
>> drivers/iio/dac/ad5593r.c:48:18: sparse: cast to restricted __be16
>> drivers/iio/dac/ad5593r.c:48:18: sparse: cast to restricted __be16
>> drivers/iio/dac/ad5593r.c:48:18: sparse: cast to restricted __be16
   drivers/iio/dac/ad5593r.c:56:15: sparse: incorrect type in assignment (different base types)
   drivers/iio/dac/ad5593r.c:56:15:    expected unsigned short [unsigned] [usertype] value
   drivers/iio/dac/ad5593r.c:56:15:    got restricted __be16 [usertype] <noident>
   drivers/iio/dac/ad5593r.c:69:18: sparse: cast to restricted __be16
   drivers/iio/dac/ad5593r.c:69:18: sparse: cast to restricted __be16
   drivers/iio/dac/ad5593r.c:69:18: sparse: cast to restricted __be16
   drivers/iio/dac/ad5593r.c:69:18: sparse: cast to restricted __be16

vim +20 drivers/iio/dac/ad5592r.c

    14	#include <linux/of.h>
    15	#include <linux/spi/spi.h>
    16	
    17	static int ad5592r_dac_write(struct ad5592r_state *st, unsigned chan, u16 value)
    18	{
    19		struct spi_device *spi = container_of(st->dev, struct spi_device, dev);
  > 20		u16 msg = cpu_to_be16(BIT(15) | (chan << 12) | value);
    21	
    22		return spi_write(spi, &msg, sizeof(msg));
    23	}
    24	
    25	static int ad5592r_adc_read(struct ad5592r_state *st, unsigned chan, u16 *value)
    26	{
    27		struct spi_device *spi = container_of(st->dev, struct spi_device, dev);
    28		u16 msg = cpu_to_be16((AD5592R_REG_ADC_SEQ << 11) | BIT(chan));
    29		int ret;
    30	
    31		ret = spi_write(spi, &msg, sizeof(msg));
    32		if (ret)
    33			return ret;
    34	
    35		spi_read(spi, &msg, sizeof(msg)); /* Invalid data */
    36	
    37		ret = spi_read(spi, &msg, sizeof(msg));
    38		if (ret)
    39			return ret;
    40	
  > 41		*value = be16_to_cpu(msg);
    42		return 0;
    43	}
    44	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
