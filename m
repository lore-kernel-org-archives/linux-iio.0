Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83344457A3;
	Wed, 23 Sep 2026 06:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790144098; cv=none; b=ry3j5MAKuLiBsE9RJolJQMKI4Ss1/IrcaZcgIBZGIqihNeIwG0z7DTI01JnWLxAks1OcBUhEP6QEqaYQNCCgCzN0WYhsgBHjUNlkvaYaZaUjIE8QQtt03YWyKntsehr2Guf5ixoipBRoWL5kXvETwchiK3CWtVYUl5xS94JRD0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790144098; c=relaxed/simple;
	bh=a/yAIKWkmXan8JFHfAMCcyrMGaiwv/YwnROXQ+PfgUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBuY/012DWN2Hc5cm5e4OIErGEKMNAiIqyUYK93iW82c/ZRK+CNdopasaPr+kqAR6GL9ux6cI8VpSxlbHr62z7qXkNfgLu5FYEDpxBnE/lwQfP8cLyLs7UzG3XxwHSyfLArazhqrjTLANMD/++FwCZamSPHafAPNKpxO9Czv5RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KWBoEc5o; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KWBoEc5o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790144094; x=1821680094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a/yAIKWkmXan8JFHfAMCcyrMGaiwv/YwnROXQ+PfgUg=;
  b=KWBoEc5omhpFCZxHCaKyX8YfOADWLN161VgdoDtN+dKlvppwvzbRG5GG
   DFYt78ieUzbirNtnA2yFBinMRiSsHzX0ezas61Sw+GKc4vARWl/hQkazl
   xvjGarWSsTH1+ZwRJ8ytbmUI4XQZUia6m+jU61uTl5G86rP8rtjd+sOf7
   YSm42LYVzjOYJgefZcRAij7AHwZsmxu0FvK+116cd765GFE97FCOmW+GQ
   zjI2sK6L/+PispnL4mRgKPZGvj/0V5LbSijhq7IRK7GKZ7wSgs1T9uOgy
   zFE0ohBFhW6xzetfBhJWbc8GMqmGz4i6j4B20KKw8usouoq9ekw8hJqtF
   g==;
X-CSE-ConnectionGUID: dXAqdkbVRfW7Fxzq129nqw==
X-CSE-MsgGUID: khu784KfQMCJEzzCQsHhBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="93308340"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="93308340"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 23:14:48 -0700
X-CSE-ConnectionGUID: hLya9EFtR/y1enJ0JUuIIA==
X-CSE-MsgGUID: M4RV5WF7RX6FyeBjg5MQhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="301381223"
Received: from igk-lkp-server01.igk.intel.com (HELO 1bbc298b9a73) ([10.211.93.152])
  by fmviesa001.fm.intel.com with ESMTP; 22 Sep 2026 23:14:44 -0700
Received: from kbuild by 1bbc298b9a73 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x9GFe-000000000Xz-0EVf;
	Wed, 23 Sep 2026 06:14:42 +0000
Date: Wed, 23 Sep 2026 08:13:49 +0200
From: kernel test robot <lkp@intel.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>, jic23@kernel.org,
	gregkh@linuxfoundation.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com
Cc: oe-kbuild-all@lists.linux.dev, dlechner@baylibre.com, andy@kernel.org,
	linux@analog.com, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com, error27@gmail.com,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: Re: [PATCH v2] staging: iio: adc: ad7816: Protect sysfs attributes
 with mutex
Message-ID: <202609230855.IEzAf41u-lkp@intel.com>
References: <20260920091522.15507-1-abdelnasserhussein11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920091522.15507-1-abdelnasserhussein11@gmail.com>

Hi Abdelnasser,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Abdelnasser-Hussein/staging-iio-adc-ad7816-Protect-sysfs-attributes-with-mutex/20260920-121522
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20260920091522.15507-1-abdelnasserhussein11%40gmail.com
patch subject: [PATCH v2] staging: iio: adc: ad7816: Protect sysfs attributes with mutex
config: sparc-randconfig-2001-20260923 (https://download.01.org/0day-ci/archive/20260923/202609230855.IEzAf41u-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260923/202609230855.IEzAf41u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609230855.IEzAf41u-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/irqflags.h:17,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/sparc/include/asm/cmpxchg_32.h:67,
                    from arch/sparc/include/asm/cmpxchg.h:7,
                    from arch/sparc/include/asm/atomic_32.h:17,
                    from arch/sparc/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/sparc/include/asm/bitops_32.h:102,
                    from arch/sparc/include/asm/bitops.h:7,
                    from include/linux/bitops.h:67,
                    from include/linux/kernel.h:23,
                    from include/linux/interrupt.h:6,
                    from drivers/staging/iio/adc/ad7816.c:8:
   drivers/staging/iio/adc/ad7816.c: In function 'ad7816_store_mode':
>> drivers/staging/iio/adc/ad7816.c:139:27: error: 'struct ad7816_chip_info' has no member named 'lock'
     139 |         guard(mutex)(&chip->lock);
         |                           ^~
   include/linux/cleanup.h:558:37: note: in definition of macro 'WITH_LOCK_GUARD_1_ATTRS'
     558 |         class_##_name##_constructor(_T),                                \
         |                                     ^~
   include/linux/cleanup.h:303:17: note: in expansion of macro 'class_mutex_constructor'
     303 |                 class_##_name##_constructor
         |                 ^~~~~~
   include/linux/cleanup.h:423:9: note: in expansion of macro 'CLASS'
     423 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^~~~~
   drivers/staging/iio/adc/ad7816.c:139:9: note: in expansion of macro 'guard'
     139 |         guard(mutex)(&chip->lock);
         |         ^~~~~
>> drivers/staging/iio/adc/ad7816.c:139:27: error: 'struct ad7816_chip_info' has no member named 'lock'
     139 |         guard(mutex)(&chip->lock);
         |                           ^~
   include/linux/cleanup.h:559:97: note: in definition of macro 'WITH_LOCK_GUARD_1_ATTRS'
     559 |         *__UNIQUE_ID(unlock) __cleanup(__class_##_name##_cleanup_ctx) = (void *)(unsigned long)(_T)
         |                                                                                                 ^~
   include/linux/cleanup.h:303:17: note: in expansion of macro 'class_mutex_constructor'
     303 |                 class_##_name##_constructor
         |                 ^~~~~~
   include/linux/cleanup.h:423:9: note: in expansion of macro 'CLASS'
     423 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^~~~~
   drivers/staging/iio/adc/ad7816.c:139:9: note: in expansion of macro 'guard'
     139 |         guard(mutex)(&chip->lock);
         |         ^~~~~
   drivers/staging/iio/adc/ad7816.c: In function 'ad7816_store_channel':
   drivers/staging/iio/adc/ad7816.c:205:27: error: 'struct ad7816_chip_info' has no member named 'lock'
     205 |         guard(mutex)(&chip->lock);
         |                           ^~
   include/linux/cleanup.h:558:37: note: in definition of macro 'WITH_LOCK_GUARD_1_ATTRS'
     558 |         class_##_name##_constructor(_T),                                \
         |                                     ^~
   include/linux/cleanup.h:303:17: note: in expansion of macro 'class_mutex_constructor'
     303 |                 class_##_name##_constructor
         |                 ^~~~~~
   include/linux/cleanup.h:423:9: note: in expansion of macro 'CLASS'
     423 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^~~~~
   drivers/staging/iio/adc/ad7816.c:205:9: note: in expansion of macro 'guard'
     205 |         guard(mutex)(&chip->lock);
         |         ^~~~~
   drivers/staging/iio/adc/ad7816.c:205:27: error: 'struct ad7816_chip_info' has no member named 'lock'
     205 |         guard(mutex)(&chip->lock);
         |                           ^~
   include/linux/cleanup.h:559:97: note: in definition of macro 'WITH_LOCK_GUARD_1_ATTRS'
     559 |         *__UNIQUE_ID(unlock) __cleanup(__class_##_name##_cleanup_ctx) = (void *)(unsigned long)(_T)
         |                                                                                                 ^~
   include/linux/cleanup.h:303:17: note: in expansion of macro 'class_mutex_constructor'
     303 |                 class_##_name##_constructor
         |                 ^~~~~~
   include/linux/cleanup.h:423:9: note: in expansion of macro 'CLASS'
     423 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^~~~~
   drivers/staging/iio/adc/ad7816.c:205:9: note: in expansion of macro 'guard'
     205 |         guard(mutex)(&chip->lock);
         |         ^~~~~


vim +139 drivers/staging/iio/adc/ad7816.c

   > 8	#include <linux/interrupt.h>
     9	#include <linux/gpio/consumer.h>
    10	#include <linux/device.h>
    11	#include <linux/kernel.h>
    12	#include <linux/slab.h>
    13	#include <linux/sysfs.h>
    14	#include <linux/list.h>
    15	#include <linux/spi/spi.h>
    16	#include <linux/module.h>
    17	
    18	#include <linux/iio/iio.h>
    19	#include <linux/iio/sysfs.h>
    20	#include <linux/iio/events.h>
    21	
    22	/*
    23	 * AD7816 config masks
    24	 */
    25	#define AD7816_FULL			0x1
    26	#define AD7816_PD			0x2
    27	#define AD7816_CS_MASK			0x7
    28	#define AD7816_CS_MAX			0x4
    29	
    30	/*
    31	 * AD7816 temperature masks
    32	 */
    33	#define AD7816_VALUE_OFFSET		6
    34	#define AD7816_BOUND_VALUE_BASE		0x8
    35	#define AD7816_BOUND_VALUE_MIN		-95
    36	#define AD7816_BOUND_VALUE_MAX		152
    37	#define AD7816_TEMP_FLOAT_OFFSET	2
    38	#define AD7816_TEMP_FLOAT_MASK		0x3
    39	
    40	/*
    41	 * struct ad7816_chip_info - chip specific information
    42	 */
    43	
    44	struct ad7816_chip_info {
    45		kernel_ulong_t id;
    46		struct spi_device *spi_dev;
    47		struct gpio_desc *rdwr_pin;
    48		struct gpio_desc *convert_pin;
    49		struct gpio_desc *busy_pin;
    50		u8  oti_data[AD7816_CS_MAX + 1];
    51		u8  channel_id;	/* 0 always be temperature */
    52		u8  mode;
    53	};
    54	
    55	enum ad7816_type {
    56		ID_AD7816,
    57		ID_AD7817,
    58		ID_AD7818,
    59	};
    60	
    61	/*
    62	 * ad7816 data access by SPI
    63	 */
    64	static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
    65	{
    66		struct spi_device *spi_dev = chip->spi_dev;
    67		int ret;
    68		__be16 buf;
    69	
    70		gpiod_set_value(chip->rdwr_pin, 1);
    71		gpiod_set_value(chip->rdwr_pin, 0);
    72		ret = spi_write(spi_dev, &chip->channel_id, sizeof(chip->channel_id));
    73		if (ret < 0) {
    74			dev_err(&spi_dev->dev, "SPI channel setting error\n");
    75			return ret;
    76		}
    77		gpiod_set_value(chip->rdwr_pin, 1);
    78	
    79		if (chip->mode == AD7816_PD) { /* operating mode 2 */
    80			gpiod_set_value(chip->convert_pin, 1);
    81			gpiod_set_value(chip->convert_pin, 0);
    82		} else { /* operating mode 1 */
    83			gpiod_set_value(chip->convert_pin, 0);
    84			gpiod_set_value(chip->convert_pin, 1);
    85		}
    86	
    87		if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
    88			while (gpiod_get_value(chip->busy_pin))
    89				cpu_relax();
    90		}
    91	
    92		gpiod_set_value(chip->rdwr_pin, 0);
    93		gpiod_set_value(chip->rdwr_pin, 1);
    94		ret = spi_read(spi_dev, &buf, sizeof(*data));
    95		if (ret < 0) {
    96			dev_err(&spi_dev->dev, "SPI data read error\n");
    97			return ret;
    98		}
    99	
   100		*data = be16_to_cpu(buf);
   101	
   102		return ret;
   103	}
   104	
   105	static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
   106	{
   107		struct spi_device *spi_dev = chip->spi_dev;
   108		int ret;
   109	
   110		gpiod_set_value(chip->rdwr_pin, 1);
   111		gpiod_set_value(chip->rdwr_pin, 0);
   112		ret = spi_write(spi_dev, &data, sizeof(data));
   113		if (ret < 0)
   114			dev_err(&spi_dev->dev, "SPI oti data write error\n");
   115	
   116		return ret;
   117	}
   118	
   119	static ssize_t ad7816_show_mode(struct device *dev,
   120					struct device_attribute *attr,
   121					char *buf)
   122	{
   123		struct iio_dev *indio_dev = dev_to_iio_dev(dev);
   124		struct ad7816_chip_info *chip = iio_priv(indio_dev);
   125	
   126		if (chip->mode)
   127			return sysfs_emit(buf, "power-save\n");
   128		return sysfs_emit(buf, "full\n");
   129	}
   130	
   131	static ssize_t ad7816_store_mode(struct device *dev,
   132					 struct device_attribute *attr,
   133					 const char *buf,
   134					 size_t len)
   135	{
   136		struct iio_dev *indio_dev = dev_to_iio_dev(dev);
   137		struct ad7816_chip_info *chip = iio_priv(indio_dev);
   138	
 > 139		guard(mutex)(&chip->lock);
   140	
   141		if (strcmp(buf, "full") == 0) {
   142			gpiod_set_value(chip->rdwr_pin, 1);
   143			chip->mode = AD7816_FULL;
   144		} else {
   145			gpiod_set_value(chip->rdwr_pin, 0);
   146			chip->mode = AD7816_PD;
   147		}
   148	
   149		return len;
   150	}
   151	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
