Return-Path: <SRS0=lFjb=GD=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Tue, 13 Mar 2018 10:06:29 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Graff Yang <graff.yang@gmail.com>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, daniel.baluta@nxp.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging:iio:ad2s1210: Add write_raw to handle
 frequency
Message-ID: <20180313130629.c6zmvoy5o7a5ax2c@smtp.gmail.com>
References: <cover.1520878492.git.rodrigosiqueiramelo@gmail.com>
 <ae60ca5cf37d1678cb6b498450f75f93f3d498d2.1520878492.git.rodrigosiqueiramelo@gmail.com>
 <20180313090249.cdurikolfwc5qyol@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180313090249.cdurikolfwc5qyol@mwanda>
List-ID: <linux-iio@vger.kernel.org>

On 03/13, Dan Carpenter wrote:
> On Mon, Mar 12, 2018 at 03:21:52PM -0300, Rodrigo Siqueira wrote:
> > The write interface of AD2S1210 utilizes IIO_DEVICE_ATTR, which violate
> > the official IIO ABI. This patch, add the write_raw function responsible
> > for handling the fclkin and fexcit channel; also it removes the use of
> > IIO_DEVICE_ATTR for fclkin and fexcit.
> > 
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > ---
> >  drivers/staging/iio/resolver/ad2s1210.c | 117 +++++++++++++++-----------------
> >  1 file changed, 55 insertions(+), 62 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> > index 27a42ed10fcd..ea6ade4e563c 100644
> > --- a/drivers/staging/iio/resolver/ad2s1210.c
> > +++ b/drivers/staging/iio/resolver/ad2s1210.c
> > @@ -60,6 +60,8 @@
> >  
> >  #define AD2S1210_DEF_EXCIT	10000
> >  
> > +#define ERROR_MESSAGE "ad2s1210: %s out of range\n"
> > +
> 
> Don't make this a define.  That's horrible.  It's a pointless layer of
> abstraction.
> 
> 
> >  enum ad2s1210_mode {
> >  	MOD_POS = 0,
> >  	MOD_VEL,
> > @@ -210,64 +212,6 @@ static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
> >  	return ad2s1210_config_write(st, 0x0);
> >  }
> >  
> > -static ssize_t ad2s1210_store_fclkin(struct device *dev,
> > -				     struct device_attribute *attr,
> > -				     const char *buf,
> > -				     size_t len)
> > -{
> > -	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> > -	unsigned int fclkin;
> > -	int ret;
> > -
> > -	ret = kstrtouint(buf, 10, &fclkin);
> > -	if (ret)
> > -		return ret;
> > -	if (fclkin < AD2S1210_MIN_CLKIN || fclkin > AD2S1210_MAX_CLKIN) {
> > -		dev_err(dev, "ad2s1210: fclkin out of range\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	mutex_lock(&st->lock);
> > -	st->fclkin = fclkin;
> > -
> > -	ret = ad2s1210_update_frequency_control_word(st);
> > -	if (ret < 0)
> > -		goto error_ret;
> > -	ret = ad2s1210_soft_reset(st);
> > -error_ret:
> > -	mutex_unlock(&st->lock);
> > -
> > -	return ret < 0 ? ret : len;
> > -}
> > -
> > -static ssize_t ad2s1210_store_fexcit(struct device *dev,
> > -				     struct device_attribute *attr,
> > -				     const char *buf, size_t len)
> > -{
> > -	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> > -	unsigned int fexcit;
> > -	int ret;
> > -
> > -	ret = kstrtouint(buf, 10, &fexcit);
> > -	if (ret < 0)
> > -		return ret;
> > -	if (fexcit < AD2S1210_MIN_EXCIT || fexcit > AD2S1210_MAX_EXCIT) {
> > -		dev_err(dev,
> > -			"ad2s1210: excitation frequency out of range\n");
> > -		return -EINVAL;
> > -	}
> > -	mutex_lock(&st->lock);
> > -	st->fexcit = fexcit;
> > -	ret = ad2s1210_update_frequency_control_word(st);
> > -	if (ret < 0)
> > -		goto error_ret;
> > -	ret = ad2s1210_soft_reset(st);
> > -error_ret:
> > -	mutex_unlock(&st->lock);
> > -
> > -	return ret < 0 ? ret : len;
> > -}
> > -
> >  static ssize_t ad2s1210_show_control(struct device *dev,
> >  				     struct device_attribute *attr,
> >  				     char *buf)
> > @@ -545,8 +489,58 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
> >  	return ret;
> >  }
> >  
> > -static IIO_DEVICE_ATTR(fclkin, 0644, NULL, ad2s1210_store_fclkin, 0);
> > -static IIO_DEVICE_ATTR(fexcit, 0644, NULL, ad2s1210_store_fexcit, 0);
> > +static int ad2s1210_write_raw(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan, int val,
> > +			      int val2, long mask)
> > +{
> > +	struct ad2s1210_state *st = iio_priv(indio_dev);
> > +	unsigned int clk = val;
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_FREQUENCY:
> > +		switch (chan->channel) {
> 
> This is a switch statement with only one case.  Make it an if statement
> and chop out some indenting.
> 
> 	if (mask != IIO_CHAN_INFO_FREQUENCY)
> 		return -EINVAL;
> 
> > +		case FCLKIN:
> > +			if (clk < AD2S1210_MIN_CLKIN ||
> > +			    clk > AD2S1210_MAX_CLKIN) {
> > +				dev_err(&indio_dev->dev, ERROR_MESSAGE,

Hi Dan,

Just a note, I did it because I will add more things to this function.
However, I agree with you, and I will follow your recommendation for
keep things simple and focused on the present. 

> Ah...  I see why you did the ERROR_MESSAGE define, to get around the 80
> character limit.  Don't do that.  Just go over 80 characters if you need
> to.
> 
> 
> > +					"fclkin");
> > +				ret = -EINVAL;
> > +				goto error_ret;
> 
> Direct returns are better.  Less chance of bugs statistically.

I totally get your point here, and I will fix it. However, just for
curiosity, why goto in this situation has more chance to generate bugs
statically?

I will send a v2 with your recommendantions.
Thanks for the review and feedbacks :)
 
> regards,
> dan carpenter
> 
