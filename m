Return-Path: <dmitry.torokhov@gmail.com>
Date: Mon, 25 Apr 2016 14:14:12 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Marek Vasut <marex@denx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH RFT V2 3/3] iio: mxs-lradc: implement suspend/resume
 support
Message-ID: <20160425211412.GF26059@dtor-ws>
References: <1461269478-449-1-git-send-email-stefan.wahren@i2se.com>
 <1461269478-449-4-git-send-email-stefan.wahren@i2se.com>
 <20160421210810.GC25466@dtor-ws>
 <571A27FC.4030301@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <571A27FC.4030301@i2se.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Apr 22, 2016 at 03:32:44PM +0200, Stefan Wahren wrote:
> Hi Dmitry,
> 
> Am 21.04.2016 um 23:08 schrieb Dmitry Torokhov:
> > On Thu, Apr 21, 2016 at 08:11:18PM +0000, Stefan Wahren wrote:
> >> This patch implements suspend/resume support for mxs-lradc.
> >> It's possible to use the touchscreen as wakeup source.
> >>
> >> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> >> ---
> >>  drivers/iio/adc/mxs-lradc.c |   61 +++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 61 insertions(+)
> >>
> >> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
> >> index cfc558f..6bd387f 100644
> >> --- a/drivers/iio/adc/mxs-lradc.c
> >> +++ b/drivers/iio/adc/mxs-lradc.c
> >> @@ -29,6 +29,7 @@
> >>  #include <linux/of.h>
> >>  #include <linux/of_device.h>
> >>  #include <linux/platform_device.h>
> >> +#include <linux/pm.h>
> >>  #include <linux/slab.h>
> >>  #include <linux/stmp_device.h>
> >>  #include <linux/sysfs.h>
> >> @@ -1745,10 +1746,70 @@ static int mxs_lradc_remove(struct platform_device *pdev)
> >>  	return 0;
> >>  }
> >>  
> >> +static int __maybe_unused mxs_lradc_suspend(struct device *dev)
> >> +{
> >> +	struct iio_dev *iio = dev_get_drvdata(dev);
> >> +	struct mxs_lradc *lradc = iio_priv(iio);
> >> +	struct input_dev *input = lradc->ts_input;
> >> +	int ret = 0;
> >> +
> >> +	if (input) {
> >> +		mutex_lock(&input->mutex);
> >> +
> >> +		/* Enable touchscreen wakeup irq */
> >> +		if (input->users && device_may_wakeup(dev))
> >> +			ret = enable_irq_wake(lradc->irq[0]);
> >> +		else
> >> +			mxs_lradc_disable_ts(lradc);
> >> +
> >> +		mutex_unlock(&input->mutex);
> >> +	}
> >> +
> >> +	if (ret)
> >> +		return ret;
> > I'd rather we had it right after we do:
> >
> > 			ret = enable_irq_wake(lradc->irq[0]);
> 
> but we must unlock the mutex first before return. An option would be to
> place the return inside the input branch.

Ah, right, ignore me then.

-- 
Dmitry
