Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40790 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934042AbdCUTc5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 15:32:57 -0400
Subject: Re: [PATCH v5] staging: Use buf_lock instead of mlock and Refactor
 code
To: SIMRAN SINGHAL <singhalsimran0@gmail.com>,
        kbuild test robot <lkp@intel.com>
References: <20170319125039.GA23385@singhal-Inspiron-5558>
 <201703212205.WEm2baAJ%fengguang.wu@intel.com>
 <CALrZqyMGtbOYUnXATQ5zpfgtg26+Ld=Go-5tG-Aneyxe8=cKdw@mail.gmail.com>
Cc: kbuild-all@01.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        outreachy-kernel <outreachy-kernel@googlegroups.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <48bceda7-916e-8e0d-e84c-2a6c66a73a49@kernel.org>
Date: Tue, 21 Mar 2017 19:32:53 +0000
MIME-Version: 1.0
In-Reply-To: <CALrZqyMGtbOYUnXATQ5zpfgtg26+Ld=Go-5tG-Aneyxe8=cKdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/03/17 15:05, SIMRAN SINGHAL wrote:
> On Tue, Mar 21, 2017 at 8:01 PM, kbuild test robot <lkp@intel.com> wrote:
>> Hi simran,
>>
>> [auto build test WARNING on iio/togreg]
>> [also build test WARNING on v4.11-rc3 next-20170321]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/simran-singhal/staging-Use-buf_lock-instead-of-mlock-and-Refactor-code/20170321-213956
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
>> config: x86_64-randconfig-x016-201712 (attached as .config)
>> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
>> reproduce:
>>         # save the attached .config to linux build tree
>>         make ARCH=x86_64
>>
>> All warnings (new ones prefixed by >>):
>>
> I am not getting any error, and I have already sent the v7 of this patch
> please check out that:
> https://groups.google.com/forum/#!topic/outreachy-kernel/5uz6IpcOpMA
> 
> 
>>    In file included from include/uapi/linux/stddef.h:1:0,
>>                     from include/linux/stddef.h:4,
>>                     from include/uapi/linux/posix_types.h:4,
>>                     from include/uapi/linux/types.h:13,
>>                     from include/linux/types.h:5,
>>                     from include/linux/list.h:4,
>>                     from include/linux/module.h:9,
>>                     from drivers/staging/iio/gyro/adis16060_core.c:9:
>>    drivers/staging/iio/gyro/adis16060_core.c: In function 'adis16060_read_raw':
>>    include/linux/compiler.h:149:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
>>      if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
>>      ^
>>    include/linux/compiler.h:147:23: note: in expansion of macro '__trace_if'
>>     #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
>>                           ^~~~~~~~~~
>>>> drivers/staging/iio/gyro/adis16060_core.c:89:3: note: in expansion of macro 'if'
>>       if (ret < 0)
>>       ^~
>>    drivers/staging/iio/gyro/adis16060_core.c:91:4: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
>>        return ret;
>>        ^~~~~~
All this rather complex bit of magic is saying, is that the indenting on the return
is probably wrong.  Which it isn't, but there is something else wrong that
would make the autobuilder think so.  No brackets around the two lines that
should run if the if statement is true!

This is the autobuilder magic running directly on patches on the mailing list.
I force the equivalent tests by pushing patches out first in a testing branch,
so that this stuff can be fixed before patches go into a non rebasing branch
(fixing them there makes for a very messy history).

If the autobuilder bots have spare cycles, they tend to start running patches
off the mailing list - hence magic like this one, though the results can be
hard to read sometimes!

Jonathan
>>
>> vim +/if +89 drivers/staging/iio/gyro/adis16060_core.c
>>
>> e071f6b8 Barry Song       2010-10-27   3   *
>> e071f6b8 Barry Song       2010-10-27   4   * Copyright 2010 Analog Devices Inc.
>> e071f6b8 Barry Song       2010-10-27   5   *
>> e071f6b8 Barry Song       2010-10-27   6   * Licensed under the GPL-2 or later.
>> e071f6b8 Barry Song       2010-10-27   7   */
>> e071f6b8 Barry Song       2010-10-27   8
>> 45296236 Paul Gortmaker   2011-08-30  @9  #include <linux/module.h>
>> e071f6b8 Barry Song       2010-10-27  10  #include <linux/delay.h>
>> e071f6b8 Barry Song       2010-10-27  11  #include <linux/mutex.h>
>> e071f6b8 Barry Song       2010-10-27  12  #include <linux/device.h>
>> e071f6b8 Barry Song       2010-10-27  13  #include <linux/kernel.h>
>> e071f6b8 Barry Song       2010-10-27  14  #include <linux/spi/spi.h>
>> e071f6b8 Barry Song       2010-10-27  15  #include <linux/slab.h>
>> e071f6b8 Barry Song       2010-10-27  16  #include <linux/sysfs.h>
>> 14f98326 Jonathan Cameron 2011-02-28  17
>> 06458e27 Jonathan Cameron 2012-04-25  18  #include <linux/iio/iio.h>
>> 06458e27 Jonathan Cameron 2012-04-25  19  #include <linux/iio/sysfs.h>
>> e071f6b8 Barry Song       2010-10-27  20
>> 14f98326 Jonathan Cameron 2011-02-28  21  #define ADIS16060_GYRO                0x20 /* Measure Angular Rate (Gyro) */
>> 14f98326 Jonathan Cameron 2011-02-28  22  #define ADIS16060_TEMP_OUT    0x10 /* Measure Temperature */
>> 14f98326 Jonathan Cameron 2011-02-28  23  #define ADIS16060_AIN2                0x80 /* Measure AIN2 */
>> 14f98326 Jonathan Cameron 2011-02-28  24  #define ADIS16060_AIN1                0x40 /* Measure AIN1 */
>> 14f98326 Jonathan Cameron 2011-02-28  25
>> 14f98326 Jonathan Cameron 2011-02-28  26  /**
>> 14f98326 Jonathan Cameron 2011-02-28  27   * struct adis16060_state - device instance specific data
>> 14f98326 Jonathan Cameron 2011-02-28  28   * @us_w:             actual spi_device to write config
>> 14f98326 Jonathan Cameron 2011-02-28  29   * @us_r:             actual spi_device to read back data
>> 25985edc Lucas De Marchi  2011-03-30  30   * @buf:              transmit or receive buffer
>> 14f98326 Jonathan Cameron 2011-02-28  31   * @buf_lock:         mutex to protect tx and rx
>> 14f98326 Jonathan Cameron 2011-02-28  32   **/
>> 14f98326 Jonathan Cameron 2011-02-28  33  struct adis16060_state {
>> 14f98326 Jonathan Cameron 2011-02-28  34        struct spi_device               *us_w;
>> 14f98326 Jonathan Cameron 2011-02-28  35        struct spi_device               *us_r;
>> 14f98326 Jonathan Cameron 2011-02-28  36        struct mutex                    buf_lock;
>> 14f98326 Jonathan Cameron 2011-02-28  37
>> 14f98326 Jonathan Cameron 2011-02-28  38        u8 buf[3] ____cacheline_aligned;
>> 14f98326 Jonathan Cameron 2011-02-28  39  };
>> e071f6b8 Barry Song       2010-10-27  40
>> 3a5952f9 Jonathan Cameron 2011-06-27  41  static struct iio_dev *adis16060_iio_dev;
>> e071f6b8 Barry Song       2010-10-27  42
>> 71db16e5 simran singhal   2017-03-19  43  static int adis16060_spi_write_than_read(struct iio_dev *indio_dev,
>> 71db16e5 simran singhal   2017-03-19  44                                         u8 conf, u16 *val)
>> e071f6b8 Barry Song       2010-10-27  45  {
>> e071f6b8 Barry Song       2010-10-27  46        int ret;
>> 3a5952f9 Jonathan Cameron 2011-06-27  47        struct adis16060_state *st = iio_priv(indio_dev);
>> e071f6b8 Barry Song       2010-10-27  48
>> e071f6b8 Barry Song       2010-10-27  49        mutex_lock(&st->buf_lock);
>> 71db16e5 simran singhal   2017-03-19  50        st->buf[2] = conf; /* The last 8 bits clocked in are latched */
>> 14f98326 Jonathan Cameron 2011-02-28  51        ret = spi_write(st->us_w, st->buf, 3);
>> e071f6b8 Barry Song       2010-10-27  52
>> 71db16e5 simran singhal   2017-03-19  53        if (ret < 0) {
>> 71db16e5 simran singhal   2017-03-19  54                mutex_unlock(&st->buf_lock);
>> e071f6b8 Barry Song       2010-10-27  55                return ret;
>> e071f6b8 Barry Song       2010-10-27  56        }
>> e071f6b8 Barry Song       2010-10-27  57
>> 14f98326 Jonathan Cameron 2011-02-28  58        ret = spi_read(st->us_r, st->buf, 3);
>> e071f6b8 Barry Song       2010-10-27  59
>> d14ae859 Jonathan Cameron 2011-02-11  60        /* The internal successive approximation ADC begins the
>> d14ae859 Jonathan Cameron 2011-02-11  61         * conversion process on the falling edge of MSEL1 and
>> d14ae859 Jonathan Cameron 2011-02-11  62         * starts to place data MSB first on the DOUT line at
>> d14ae859 Jonathan Cameron 2011-02-11  63         * the 6th falling edge of SCLK
>> e071f6b8 Barry Song       2010-10-27  64         */
>> 05824120 Cristina Moraru  2015-10-20  65        if (!ret)
>> 14f98326 Jonathan Cameron 2011-02-28  66                *val = ((st->buf[0] & 0x3) << 12) |
>> 14f98326 Jonathan Cameron 2011-02-28  67                         (st->buf[1] << 4) |
>> 14f98326 Jonathan Cameron 2011-02-28  68                         ((st->buf[2] >> 4) & 0xF);
>> e071f6b8 Barry Song       2010-10-27  69        mutex_unlock(&st->buf_lock);
>> e071f6b8 Barry Song       2010-10-27  70
>> e071f6b8 Barry Song       2010-10-27  71        return ret;
>> e071f6b8 Barry Song       2010-10-27  72  }
>> e071f6b8 Barry Song       2010-10-27  73
>> 4f2ca080 Jonathan Cameron 2011-08-12  74  static int adis16060_read_raw(struct iio_dev *indio_dev,
>> 4f2ca080 Jonathan Cameron 2011-08-12  75                              struct iio_chan_spec const *chan,
>> 4f2ca080 Jonathan Cameron 2011-08-12  76                              int *val, int *val2,
>> 4f2ca080 Jonathan Cameron 2011-08-12  77                              long mask)
>> e071f6b8 Barry Song       2010-10-27  78  {
>> 4f2ca080 Jonathan Cameron 2011-08-12  79        u16 tval = 0;
>> 4f2ca080 Jonathan Cameron 2011-08-12  80        int ret;
>> 71db16e5 simran singhal   2017-03-19  81        struct adis16060_state *st = iio_priv(indio_dev);
>> e071f6b8 Barry Song       2010-10-27  82
>> 4f2ca080 Jonathan Cameron 2011-08-12  83        switch (mask) {
>> fbaff213 Jonathan Cameron 2012-04-15  84        case IIO_CHAN_INFO_RAW:
>> e071f6b8 Barry Song       2010-10-27  85                /* Take the iio_dev status lock */
>> 71db16e5 simran singhal   2017-03-19  86                mutex_lock(&st->buf_lock);
>> 71db16e5 simran singhal   2017-03-19  87                ret = adis16060_spi_write_than_read(indio_dev,
>> 71db16e5 simran singhal   2017-03-19  88                                                    chan->address, &tval);
>> 31a99443 Cristina Moraru  2015-10-25 @89                if (ret < 0)
>> 71db16e5 simran singhal   2017-03-19  90                        mutex_unlock(&st->buf_lock);
>> 71db16e5 simran singhal   2017-03-19  91                        return ret;
>> 31a99443 Cristina Moraru  2015-10-25  92
>>
>> :::::: The code at line 89 was first introduced by commit
>> :::::: 31a99443a53aa65cdaaaaa3bcd5ed685eec87419 staging: iio: adis16060_core: Fix error handling
>>
>> :::::: TO: Cristina Moraru <cristina.moraru09@gmail.com>
>> :::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

