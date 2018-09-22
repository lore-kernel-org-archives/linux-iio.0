Return-Path: <SRS0=cMqV=ME=gmail.com=songqiang1304521@kernel.org>
Date: Sat, 22 Sep 2018 19:19:59 +0800
From: Song Qiang <songqiang1304521@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: kbuild test robot <lkp@intel.com>,
	Eugen Hristev <eugen.hristev@microchip.com>, kbuild-all@01.org,
	ludovic.desroches@microchip.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, nicolas.ferre@microchip.com,
	Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 2/2] iio: adc: at91: fix wrong channel number in
 triggered buffer mode
Message-ID: <20180922111959.GA27711@Eros>
References: <1537447238-18674-2-git-send-email-eugen.hristev@microchip.com>
 <201809211544.zop1vk8B%fengguang.wu@intel.com>
 <20180922113616.2d849fb0@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180922113616.2d849fb0@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Sep 22, 2018 at 11:36:16AM +0100, Jonathan Cameron wrote:
> On Fri, 21 Sep 2018 15:26:03 +0800
> kbuild test robot <lkp@intel.com> wrote:
> 
> > Hi Eugen,
> This one is leaving me stumped...
> 
> Anyone care to point out what I'm missing that is wrong here?
> 
> Also Eugen, please don't cc stable on a patch directly.  It is fine to send
> a backport request once a patch has hit mainline, but before that it's just
> adding noise to a list as they won't take it directly anyway.
> 
> Jonathan
> 

Hi Jonathan,

I run some test code here and found out that C compilers don't allow
us to assign a 'const int *' to 'int *', while assign a 'const int' to
'int' is fine.
In this case this driver was tring to assign a 'struct iio_chan_spec
const *' to a 'struct iio_chan_spec *', mostly because of this issue.

I googled this issue and someone on stack overflow said it's because
this kind of action will break the check mechanism of 'const'.

yours,
Song Qiang

> > 
> > I love your patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on iio/togreg]
> > [also build test WARNING on v4.19-rc4 next-20180919]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Eugen-Hristev/iio-adc-at91-fix-acking-DRDY-irq-on-simple-conversions/20180920-215908
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> > config: arm-allmodconfig (attached as .config)
> > compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.2.0 make.cross ARCH=arm 
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    drivers/iio/adc/at91_adc.c: In function 'at91_adc_trigger_handler':
> > >> drivers/iio/adc/at91_adc.c:257:8: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]  
> >       chan = idev->channels + i;
> >            ^
> > 
> > vim +/const +257 drivers/iio/adc/at91_adc.c
> > 
> >    245	
> >    246	static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
> >    247	{
> >    248		struct iio_poll_func *pf = p;
> >    249		struct iio_dev *idev = pf->indio_dev;
> >    250		struct at91_adc_state *st = iio_priv(idev);
> >    251		struct iio_chan_spec *chan;
> >    252		int i, j = 0;
> >    253	
> >    254		for (i = 0; i < idev->masklength; i++) {
> >    255			if (!test_bit(i, idev->active_scan_mask))
> >    256				continue;
> >  > 257			chan = idev->channels + i;  
> >    258			st->buffer[j] = at91_adc_readl(st, AT91_ADC_CHAN(st, chan->channel));
> >    259			j++;
> >    260		}
> >    261	
> >    262		iio_push_to_buffers_with_timestamp(idev, st->buffer, pf->timestamp);
> >    263	
> >    264		iio_trigger_notify_done(idev->trig);
> >    265	
> >    266		/* Needed to ACK the DRDY interruption */
> >    267		at91_adc_readl(st, AT91_ADC_LCDR);
> >    268	
> >    269		enable_irq(st->irq);
> >    270	
> >    271		return IRQ_HANDLED;
> >    272	}
> >    273	
> > 
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology Center
> > https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
