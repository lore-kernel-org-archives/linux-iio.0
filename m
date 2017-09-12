Return-Path: <SRS0=qIH8=AN=posteo.de=martink@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 12 Sep 2017 09:01:27 +0200
From: Martin Kepplinger <martink@posteo.de>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
 pmeerw@pmeerw.net, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: dln2-adc: initialize local struct before
 using it
In-Reply-To: <201709120955.os6Hccx2%fengguang.wu@intel.com>
References: <201709120955.os6Hccx2%fengguang.wu@intel.com>
Message-ID: <1ddf9c2d45a9a93cd21e4ba597a3004f@posteo.de>
List-ID: <linux-iio@vger.kernel.org>

Am 12.09.2017 03:32 schrieb kbuild test robot:
> Hi Martin,
> 
> [auto build test WARNING on iio/togreg]
> [also build test WARNING on next-20170911]
> [cannot apply to v4.13]
> [if your patch is applied to the wrong git tree, please drop us a note
> to help improve the system]
> 
> url:
> https://github.com/0day-ci/linux/commits/Martin-Kepplinger/iio-adc-dln2-adc-initialize-local-struct-before-using-it/20170912-064250
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git 
> togreg
> config: tile-allyesconfig (attached as .config)
> compiler: tilegx-linux-gcc (GCC) 4.6.2
> reproduce:
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=tile
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/iio/adc/dln2-adc.c: In function 'dln2_adc_trigger_h':
>>> drivers/iio/adc/dln2-adc.c:492:2: warning: missing braces around 
>>> initializer [-Wmissing-braces]
>    drivers/iio/adc/dln2-adc.c:492:2: warning: (near initialization for
> 'data.values') [-Wmissing-braces]
> 
> vim +492 drivers/iio/adc/dln2-adc.c
> 
>    484
>    485	static irqreturn_t dln2_adc_trigger_h(int irq, void *p)
>    486	{
>    487		struct iio_poll_func *pf = p;
>    488		struct iio_dev *indio_dev = pf->indio_dev;
>    489		struct {
>    490			__le16 values[DLN2_ADC_MAX_CHANNELS];
>    491			int64_t timestamp_space;
>  > 492		} data = { 0 };


ok :) I guess

    } data = {{ 0 }};

would be ok for gcc in this case. How far has this patch gone? Do you 
want a fix
on top or the patch re-done? Or do you just do it yourself?

thanks,

                   martin
