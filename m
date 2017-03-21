Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:64343 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932968AbdCUOcV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 21 Mar 2017 10:32:21 -0400
Date: Tue, 21 Mar 2017 22:31:58 +0800
From: kbuild test robot <lkp@intel.com>
To: simran singhal <singhalsimran0@gmail.com>
Cc: kbuild-all@01.org, lars@metafoo.de, Michael.Hennerich@analog.com,
        jic23@kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [PATCH v5] staging: Use buf_lock instead of mlock and Refactor
 code
Message-ID: <201703212205.WEm2baAJ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
In-Reply-To: <20170319125039.GA23385@singhal-Inspiron-5558>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi simran,

[auto build test WARNING on iio/togreg]
[also build test WARNING on v4.11-rc3 next-20170321]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/simran-singhal/staging-Use-buf_lock-instead-of-mlock-and-Refactor-code/20170321-213956
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: x86_64-randconfig-x016-201712 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/stddef.h:1:0,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/linux/list.h:4,
                    from include/linux/module.h:9,
                    from drivers/staging/iio/gyro/adis16060_core.c:9:
   drivers/staging/iio/gyro/adis16060_core.c: In function 'adis16060_read_raw':
   include/linux/compiler.h:149:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
     ^
   include/linux/compiler.h:147:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
>> drivers/staging/iio/gyro/adis16060_core.c:89:3: note: in expansion of macro 'if'
      if (ret < 0)
      ^~
   drivers/staging/iio/gyro/adis16060_core.c:91:4: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
       return ret;
       ^~~~~~

vim +/if +89 drivers/staging/iio/gyro/adis16060_core.c

e071f6b8 Barry Song       2010-10-27   3   *
e071f6b8 Barry Song       2010-10-27   4   * Copyright 2010 Analog Devices Inc.
e071f6b8 Barry Song       2010-10-27   5   *
e071f6b8 Barry Song       2010-10-27   6   * Licensed under the GPL-2 or later.
e071f6b8 Barry Song       2010-10-27   7   */
e071f6b8 Barry Song       2010-10-27   8  
45296236 Paul Gortmaker   2011-08-30  @9  #include <linux/module.h>
e071f6b8 Barry Song       2010-10-27  10  #include <linux/delay.h>
e071f6b8 Barry Song       2010-10-27  11  #include <linux/mutex.h>
e071f6b8 Barry Song       2010-10-27  12  #include <linux/device.h>
e071f6b8 Barry Song       2010-10-27  13  #include <linux/kernel.h>
e071f6b8 Barry Song       2010-10-27  14  #include <linux/spi/spi.h>
e071f6b8 Barry Song       2010-10-27  15  #include <linux/slab.h>
e071f6b8 Barry Song       2010-10-27  16  #include <linux/sysfs.h>
14f98326 Jonathan Cameron 2011-02-28  17  
06458e27 Jonathan Cameron 2012-04-25  18  #include <linux/iio/iio.h>
06458e27 Jonathan Cameron 2012-04-25  19  #include <linux/iio/sysfs.h>
e071f6b8 Barry Song       2010-10-27  20  
14f98326 Jonathan Cameron 2011-02-28  21  #define ADIS16060_GYRO		0x20 /* Measure Angular Rate (Gyro) */
14f98326 Jonathan Cameron 2011-02-28  22  #define ADIS16060_TEMP_OUT	0x10 /* Measure Temperature */
14f98326 Jonathan Cameron 2011-02-28  23  #define ADIS16060_AIN2		0x80 /* Measure AIN2 */
14f98326 Jonathan Cameron 2011-02-28  24  #define ADIS16060_AIN1		0x40 /* Measure AIN1 */
14f98326 Jonathan Cameron 2011-02-28  25  
14f98326 Jonathan Cameron 2011-02-28  26  /**
14f98326 Jonathan Cameron 2011-02-28  27   * struct adis16060_state - device instance specific data
14f98326 Jonathan Cameron 2011-02-28  28   * @us_w:		actual spi_device to write config
14f98326 Jonathan Cameron 2011-02-28  29   * @us_r:		actual spi_device to read back data
25985edc Lucas De Marchi  2011-03-30  30   * @buf:		transmit or receive buffer
14f98326 Jonathan Cameron 2011-02-28  31   * @buf_lock:		mutex to protect tx and rx
14f98326 Jonathan Cameron 2011-02-28  32   **/
14f98326 Jonathan Cameron 2011-02-28  33  struct adis16060_state {
14f98326 Jonathan Cameron 2011-02-28  34  	struct spi_device		*us_w;
14f98326 Jonathan Cameron 2011-02-28  35  	struct spi_device		*us_r;
14f98326 Jonathan Cameron 2011-02-28  36  	struct mutex			buf_lock;
14f98326 Jonathan Cameron 2011-02-28  37  
14f98326 Jonathan Cameron 2011-02-28  38  	u8 buf[3] ____cacheline_aligned;
14f98326 Jonathan Cameron 2011-02-28  39  };
e071f6b8 Barry Song       2010-10-27  40  
3a5952f9 Jonathan Cameron 2011-06-27  41  static struct iio_dev *adis16060_iio_dev;
e071f6b8 Barry Song       2010-10-27  42  
71db16e5 simran singhal   2017-03-19  43  static int adis16060_spi_write_than_read(struct iio_dev *indio_dev,
71db16e5 simran singhal   2017-03-19  44  					 u8 conf, u16 *val)
e071f6b8 Barry Song       2010-10-27  45  {
e071f6b8 Barry Song       2010-10-27  46  	int ret;
3a5952f9 Jonathan Cameron 2011-06-27  47  	struct adis16060_state *st = iio_priv(indio_dev);
e071f6b8 Barry Song       2010-10-27  48  
e071f6b8 Barry Song       2010-10-27  49  	mutex_lock(&st->buf_lock);
71db16e5 simran singhal   2017-03-19  50  	st->buf[2] = conf; /* The last 8 bits clocked in are latched */
14f98326 Jonathan Cameron 2011-02-28  51  	ret = spi_write(st->us_w, st->buf, 3);
e071f6b8 Barry Song       2010-10-27  52  
71db16e5 simran singhal   2017-03-19  53  	if (ret < 0) {
71db16e5 simran singhal   2017-03-19  54  		mutex_unlock(&st->buf_lock);
e071f6b8 Barry Song       2010-10-27  55  		return ret;
e071f6b8 Barry Song       2010-10-27  56  	}
e071f6b8 Barry Song       2010-10-27  57  
14f98326 Jonathan Cameron 2011-02-28  58  	ret = spi_read(st->us_r, st->buf, 3);
e071f6b8 Barry Song       2010-10-27  59  
d14ae859 Jonathan Cameron 2011-02-11  60  	/* The internal successive approximation ADC begins the
d14ae859 Jonathan Cameron 2011-02-11  61  	 * conversion process on the falling edge of MSEL1 and
d14ae859 Jonathan Cameron 2011-02-11  62  	 * starts to place data MSB first on the DOUT line at
d14ae859 Jonathan Cameron 2011-02-11  63  	 * the 6th falling edge of SCLK
e071f6b8 Barry Song       2010-10-27  64  	 */
05824120 Cristina Moraru  2015-10-20  65  	if (!ret)
14f98326 Jonathan Cameron 2011-02-28  66  		*val = ((st->buf[0] & 0x3) << 12) |
14f98326 Jonathan Cameron 2011-02-28  67  			 (st->buf[1] << 4) |
14f98326 Jonathan Cameron 2011-02-28  68  			 ((st->buf[2] >> 4) & 0xF);
e071f6b8 Barry Song       2010-10-27  69  	mutex_unlock(&st->buf_lock);
e071f6b8 Barry Song       2010-10-27  70  
e071f6b8 Barry Song       2010-10-27  71  	return ret;
e071f6b8 Barry Song       2010-10-27  72  }
e071f6b8 Barry Song       2010-10-27  73  
4f2ca080 Jonathan Cameron 2011-08-12  74  static int adis16060_read_raw(struct iio_dev *indio_dev,
4f2ca080 Jonathan Cameron 2011-08-12  75  			      struct iio_chan_spec const *chan,
4f2ca080 Jonathan Cameron 2011-08-12  76  			      int *val, int *val2,
4f2ca080 Jonathan Cameron 2011-08-12  77  			      long mask)
e071f6b8 Barry Song       2010-10-27  78  {
4f2ca080 Jonathan Cameron 2011-08-12  79  	u16 tval = 0;
4f2ca080 Jonathan Cameron 2011-08-12  80  	int ret;
71db16e5 simran singhal   2017-03-19  81  	struct adis16060_state *st = iio_priv(indio_dev);
e071f6b8 Barry Song       2010-10-27  82  
4f2ca080 Jonathan Cameron 2011-08-12  83  	switch (mask) {
fbaff213 Jonathan Cameron 2012-04-15  84  	case IIO_CHAN_INFO_RAW:
e071f6b8 Barry Song       2010-10-27  85  		/* Take the iio_dev status lock */
71db16e5 simran singhal   2017-03-19  86  		mutex_lock(&st->buf_lock);
71db16e5 simran singhal   2017-03-19  87  		ret = adis16060_spi_write_than_read(indio_dev,
71db16e5 simran singhal   2017-03-19  88  						    chan->address, &tval);
31a99443 Cristina Moraru  2015-10-25 @89  		if (ret < 0)
71db16e5 simran singhal   2017-03-19  90  			mutex_unlock(&st->buf_lock);
71db16e5 simran singhal   2017-03-19  91  			return ret;
31a99443 Cristina Moraru  2015-10-25  92  

:::::: The code at line 89 was first introduced by commit
:::::: 31a99443a53aa65cdaaaaa3bcd5ed685eec87419 staging: iio: adis16060_core: Fix error handling

:::::: TO: Cristina Moraru <cristina.moraru09@gmail.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--zYM0uCDKw75PZbzx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
kE38HxxQR9yCWQEA

--zYM0uCDKw75PZbzx--
