Return-Path: <SRS0=0tEj=ET=gmail.com=shreeya.patel23498@kernel.org>
Message-ID: <1516806094.2655.6.camel@gmail.com>
Subject: Re: [PATCH] Staging: iio: ade7758: Expand buf_lock to cover both
 buffer
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>, "lars@metafoo.de"
 <lars@metafoo.de>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "Hennerich,
 Michael" <Michael.Hennerich@analog.com>,  "jic23@kernel.org"
 <jic23@kernel.org>
Date: Wed, 24 Jan 2018 20:31:34 +0530
In-Reply-To: <1516707617.2960.19.camel@analog.com>
References: <1516654973-6434-1-git-send-email-shreeya.patel23498@gmail.com>
	 <1516707617.2960.19.camel@analog.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Tue, 2018-01-23 at 11:40 +0000, Ardelean, Alexandru wrote:
> On Tue, 2018-01-23 at 02:32 +0530, Shreeya Patel wrote:
> > 
> > iio_dev->mlock is to be used only by the IIO core for protecting
> > device mode changes between INDIO_DIRECT and INDIO_BUFFER.
> > 
> > This patch replaces the use of mlock with the already established
> > buf_lock mutex.
> > 
> > Introducing 'unlocked' __ade7758_spi_write_reg_8 and
> > __ade7758_spi_read_reg_8 functions to be used by
> > ade7758_write_samp_freq
> > and ade7758_read_samp_freq which avoids nested locks and maintains
> > atomicity between bus and device frequency changes.
> > 
> hey,
> 
> note: i took the liberty of re-adjusting the reply list ;
> initial scope seemed too wide ;
> added Barry Song, as he's listed as the author of the driver ;
> 
> about the patch:
> overall looks good
> comments inline
> 
> > 
> > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> > ---
> >  drivers/staging/iio/meter/ade7758.h      |  2 +-
> >  drivers/staging/iio/meter/ade7758_core.c | 49
> > +++++++++++++++++++++++---------
> >  2 files changed, 37 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/meter/ade7758.h
> > b/drivers/staging/iio/meter/ade7758.h
> > index 6ae78d8..2de81b5 100644
> > --- a/drivers/staging/iio/meter/ade7758.h
> > +++ b/drivers/staging/iio/meter/ade7758.h
> > @@ -111,7 +111,7 @@
> >   * @trig:		data ready trigger registered with iio
> >   * @tx:			transmit buffer
> >   * @rx:			receive buffer
> > - * @buf_lock:		mutex to protect tx and rx
> > + * @buf_lock:		mutex to protect tx, rx, read and
> > write frequency
> >   **/
> >  struct ade7758_state {
> >  	struct spi_device	*us;
> > diff --git a/drivers/staging/iio/meter/ade7758_core.c
> > b/drivers/staging/iio/meter/ade7758_core.c
> > index 7b7ffe5..7f8f8c4 100644
> > --- a/drivers/staging/iio/meter/ade7758_core.c
> > +++ b/drivers/staging/iio/meter/ade7758_core.c
> > @@ -24,17 +24,26 @@
> >  #include "meter.h"
> >  #include "ade7758.h"
> >  
> > -int ade7758_spi_write_reg_8(struct device *dev, u8 reg_address, u8
> > val)
> > +/* Unlocked version of ade7758_spi_write_reg_8 function */
> you can probably remove this comment

Ok. I'll do this change.
> 
> > 
> > +int __ade7758_spi_write_reg_8(struct device *dev, u8 reg_address,
> > u8 val)
> maybe make this static ; 
> this function does not seem to be exported outside of this file

I had thought of doing it so, but then I found that the functions 
ade7758_spi_write_reg_8 and ade7758_spi_read_reg_8 were mentioned
under the following comments in the ade7758.h file.

/* At the moment triggers are only used for ring buffer
 * filling. This may change!
 */

So I did not make it static.


> 
> > 
> >  {
> > -	int ret;
> >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >  	struct ade7758_state *st = iio_priv(indio_dev);
> >  
> > -	mutex_lock(&st->buf_lock);
> >  	st->tx[0] = ADE7758_WRITE_REG(reg_address);
> >  	st->tx[1] = val;
> >  
> > -	ret = spi_write(st->us, st->tx, 2);
> > +	return spi_write(st->us, st->tx, 2);
> > +}
> > +
> > +int ade7758_spi_write_reg_8(struct device *dev, u8 reg_address, u8
> > val)
> > +{
> > +	int ret;
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct ade7758_state *st = iio_priv(indio_dev);
> > +
> > +	mutex_lock(&st->buf_lock);
> > +	ret = __ade7758_spi_write_reg_8(dev, reg_address, val);
> >  	mutex_unlock(&st->buf_lock);
> >  
> >  	return ret;
> > @@ -91,7 +100,8 @@ static int ade7758_spi_write_reg_24(struct
> > device *dev, u8 reg_address,
> >  	return ret;
> >  }
> >  
> > -int ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8
> > *val)
> > +/* Unlocked version of ade7758_spi_read_reg_16 function */
> you can probably remove this comment as well
> 
> > 
> > +int __ade7758_spi_read_reg_8(struct device *dev, u8 reg_address,
> > u8 *val)
> make this static as well
> 
> > 
> >  {
> >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >  	struct ade7758_state *st = iio_priv(indio_dev);
> > @@ -111,7 +121,6 @@ int ade7758_spi_read_reg_8(struct device *dev,
> > u8 reg_address, u8 *val)
> >  		},
> >  	};
> >  
> > -	mutex_lock(&st->buf_lock);
> >  	st->tx[0] = ADE7758_READ_REG(reg_address);
> >  	st->tx[1] = 0;
> >  
> > @@ -124,7 +133,19 @@ int ade7758_spi_read_reg_8(struct device *dev,
> > u8 reg_address, u8 *val)
> >  	*val = st->rx[0];
> >  
> >  error_ret:
> > +	return ret;
> > +}
> > +
> > +int ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8
> > *val)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct ade7758_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	mutex_lock(&st->buf_lock);
> > +	ret = __ade7758_spi_read_reg_8(dev, reg_address, val);
> >  	mutex_unlock(&st->buf_lock);
> > +
> >  	return ret;
> >  }
> >  
> > @@ -470,7 +491,7 @@ static int ade7758_read_samp_freq(struct device
> > *dev, int *val)
> >  	int ret;
> >  	u8 t;
> >  
> > -	ret = ade7758_spi_read_reg_8(dev, ADE7758_WAVMODE, &t);
> > +	ret = __ade7758_spi_read_reg_8(dev, ADE7758_WAVMODE, &t);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -503,14 +524,14 @@ static int ade7758_write_samp_freq(struct
> > device *dev, int val)
> >  		goto out;
> >  	}
> >  
> > -	ret = ade7758_spi_read_reg_8(dev, ADE7758_WAVMODE, &reg);
> > +	ret = __ade7758_spi_read_reg_8(dev, ADE7758_WAVMODE,
> > &reg);
> >  	if (ret)
> >  		goto out;
> >  
> >  	reg &= ~(5 << 3);
> >  	reg |= t << 5;
> >  
> > -	ret = ade7758_spi_write_reg_8(dev, ADE7758_WAVMODE, reg);
> > +	ret = __ade7758_spi_write_reg_8(dev, ADE7758_WAVMODE,
> > reg);
> >  
> >  out:
> >  	return ret;
> > @@ -523,12 +544,13 @@ static int ade7758_read_raw(struct iio_dev
> > *indio_dev,
> >  			    long mask)
> >  {
> >  	int ret;
> > +	struct ade7758_state *st = iio_priv(indio_dev);
> >  
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_SAMP_FREQ:
> > -		mutex_lock(&indio_dev->mlock);
> > +		mutex_lock(&st->buf_lock);
> This may be ok.
> I did not seem to find a general consensus on which lock should be
> held here.
> Some drivers use buf_lock, some use the device's mlock.
> 
> I guess someone more familiar with the IIO framework would be more
> suited to comment here.
> 
> > 
> >  		ret = ade7758_read_samp_freq(&indio_dev->dev,
> > val);
> > -		mutex_unlock(&indio_dev->mlock);
> > +		mutex_unlock(&st->buf_lock);
> >  		return ret;
> >  	default:
> >  		return -EINVAL;
> > @@ -542,14 +564,15 @@ static int ade7758_write_raw(struct iio_dev
> > *indio_dev,
> >  			     int val, int val2, long mask)
> >  {
> >  	int ret;
> > +	struct ade7758_state *st = iio_priv(indio_dev);
> >  
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_SAMP_FREQ:
> >  		if (val2)
> >  			return -EINVAL;
> > -		mutex_lock(&indio_dev->mlock);
> > +		mutex_lock(&st->buf_lock);
> same here about the lock
> 
> > 
> >  		ret = ade7758_write_samp_freq(&indio_dev->dev,
> > val);
> > -		mutex_unlock(&indio_dev->mlock);
> > +		mutex_unlock(&st->buf_lock);
> >  		return ret;
> >  	default:
> >  		return -EINVAL;


Thank you for your review :)
