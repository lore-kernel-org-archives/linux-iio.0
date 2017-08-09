Return-Path: <SRS0=zDw+=7L=linux-mips.org=ladis@kernel.org>
Date: Wed, 9 Aug 2017 18:27:13 +0200
Sender: Ladislav Michl <ladis@linux-mips.org>
From: Ladislav Michl <ladis@linux-mips.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@intel.com>,
        Matt Ranostay <matt.ranostay@intel.com>
Subject: Re: [PATCH 1/2] iio: adc: ti-ads1015: fix conversion time
Message-ID: <20170809162713.ndmbrrmr36fostjm@lenoch>
References: <20170801082521.namcrs4wyufwqyuh@lenoch>
 <20170801082605.kxzqtnrbt6glplmu@lenoch>
 <20170809151523.1533bba1@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170809151523.1533bba1@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Aug 09, 2017 at 03:15:23PM +0100, Jonathan Cameron wrote:
> On Tue, 1 Aug 2017 10:26:05 +0200
> Ladislav Michl <ladis@linux-mips.org> wrote:
> 
> > When reading diffrent channel value than device is currently processing
> > wait time of conversion period is applied, which is not enough as device
> > might be already in the middle of conversion and therefore previously
> > converted value is returned - the one belonging to another channel.
> > Fix it by waiting for two sampling periods.
> > 
> > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> Strangely we already have a fix in place for this it seems.
> 
> See the fixes-togreg branch of iio.git

Thanks for the pointer, I obviously was not aware about patch serie made by
Mita-san. Really nice work, far more superior to this simple fix :-)

Best regards,
	ladis

> Clearly a popular device at the moment!
> 
> Thanks,
> 
> Jonathan
> > ---
> >  drivers/iio/adc/ti-ads1015.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> > index 884b8e461b17..86fd2753869d 100644
> > --- a/drivers/iio/adc/ti-ads1015.c
> > +++ b/drivers/iio/adc/ti-ads1015.c
> > @@ -260,7 +260,7 @@ int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
> >  		return ret;
> >  
> >  	if (change) {
> > -		conv_time = DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr]);
> > +		conv_time = 2 * DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr]);
> >  		usleep_range(conv_time, conv_time + 1);
> >  	}
> >  
