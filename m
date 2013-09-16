Return-Path: <lee.jones@linaro.org>
Date: Mon, 16 Sep 2013 09:22:17 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 21/38] iio: sensors-core: st: Clean-up error handling in
 st_sensors_read_axis_data()
Message-ID: <20130916082217.GE3999@lee--X1>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-22-git-send-email-lee.jones@linaro.org>
 <523495D0.1050002@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <523495D0.1050002@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sat, 14 Sep 2013, Jonathan Cameron wrote:

> On 09/10/13 13:49, Lee Jones wrote:
> > Gets rid of those unnecessary gotos.
> 
> Unfortunately it introduced a bug whilst it is at it.  Sometimes
> those gotos are necessary and the 'right' way to do things.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/iio/common/st_sensors/st_sensors_core.c | 17 +++++++----------
> >  1 file changed, 7 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> > index 8c4c54c..148f0e5 100644
> > --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> > +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> > @@ -331,26 +331,23 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
> >  	unsigned int byte_for_channel = ch->scan_type.storagebits >> 3;
> >  
> >  	outdata = kmalloc(byte_for_channel, GFP_KERNEL);
> > -	if (!outdata) {
> > -		err = -EINVAL;
> > -		goto st_sensors_read_axis_data_error;
> > -	}
> > +	if (!outdata)
> > +		return -ENOMEM;
> I agree this change makes complete sense.
> >  
> >  	err = sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
> >  				ch->address, byte_for_channel,
> >  				outdata, sdata->multiread_bit);
> > -	if (err < 0)
> > -		goto st_sensors_free_memory;
> > +	if (err < 0) {
> > +		kfree(outdata);
> > +		return err;
> > +	}
> I don't like this change as....
> >  
> >  	if (byte_for_channel == 2)
> >  		*data = (s16)get_unaligned_le16(outdata);
> >  	else if (byte_for_channel == 3)
> >  		*data = (s32)st_sensors_get_unaligned_le24(outdata);
> >  
> > -st_sensors_free_memory:
> > -	kfree(outdata);
> you now don't free out data in the case of no error.  This is precisely the case
> where a goto is the correct way to handle things as the free need to occur whether
> or not the error occurs.

Ah, you're quite right. I'll fix up.

> > -st_sensors_read_axis_data_error:
> > -	return err;
> > +	return 0;
> >  }
> >  
> >  int st_sensors_read_info_raw(struct iio_dev *indio_dev,
> > 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
