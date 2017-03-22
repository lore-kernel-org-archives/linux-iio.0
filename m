Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48408 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbdCVUOR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Mar 2017 16:14:17 -0400
Subject: Re: [PATCH v7] staging: adis16060_core: Replace mlock with buf_lock
 and refactor code
To: kbuild test robot <lkp@intel.com>,
        simran singhal <singhalsimran0@gmail.com>
References: <201703230313.COe3PSCe%fengguang.wu@intel.com>
Cc: kbuild-all@01.org, lars@metafoo.de, devel@driverdev.osuosl.org,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6b8ee8a9-c147-64ad-bcf9-c126f21145fc@kernel.org>
Date: Wed, 22 Mar 2017 20:14:07 +0000
MIME-Version: 1.0
In-Reply-To: <201703230313.COe3PSCe%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/03/17 20:00, kbuild test robot wrote:
> Hi simran,
> 
> [auto build test WARNING on iio/togreg]
> [also build test WARNING on v4.11-rc3 next-20170322]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/simran-singhal/staging-adis16060_core-Replace-mlock-with-buf_lock-and-refactor-code/20170323-031726
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: x86_64-randconfig-s0-03230201 (attached as .config)
> compiler: gcc-4.4 (Debian 4.4.7-8) 4.4.7
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/staging/iio/gyro/adis16060_core.c: In function 'adis16060_read_raw':
>>> drivers/staging/iio/gyro/adis16060_core.c:79: warning: unused variable 'st'
Already fixed in V8 which has been applied to the togreg branch of iio.git.

Thanks,
Jonathan
> 
> vim +/st +79 drivers/staging/iio/gyro/adis16060_core.c
> 
>     63		if (!ret)
>     64			*val = ((st->buf[0] & 0x3) << 12) |
>     65				 (st->buf[1] << 4) |
>     66				 ((st->buf[2] >> 4) & 0xF);
>     67		mutex_unlock(&st->buf_lock);
>     68	
>     69		return ret;
>     70	}
>     71	
>     72	static int adis16060_read_raw(struct iio_dev *indio_dev,
>     73				      struct iio_chan_spec const *chan,
>     74				      int *val, int *val2,
>     75				      long mask)
>     76	{
>     77		u16 tval = 0;
>     78		int ret;
>   > 79		struct adis16060_state *st = iio_priv(indio_dev);
>     80	
>     81		switch (mask) {
>     82		case IIO_CHAN_INFO_RAW:
>     83			ret = adis16060_spi_write_than_read(indio_dev,
>     84							    chan->address, &tval);
>     85			if (ret < 0)
>     86				return ret;
>     87	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

