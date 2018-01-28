Return-Path: <SRS0=MwoA=EX=gmail.com=shreeya.patel23498@kernel.org>
Message-ID: <1517130583.2100.11.camel@gmail.com>
Subject: Re: [PATCH v2] Staging: iio: ade7758: expand buf_lock to cover both
 buffer and state protection
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date: Sun, 28 Jan 2018 14:39:43 +0530
In-Reply-To: <20180128083140.6388275c@archlinux>
References: <1516898408-8129-1-git-send-email-shreeya.patel23498@gmail.com>
	 <20180128083140.6388275c@archlinux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Sun, 2018-01-28 at 08:31 +0000, Jonathan Cameron wrote:
> On Thu, 25 Jan 2018 22:10:08 +0530
> Shreeya Patel <shreeya.patel23498@gmail.com> wrote:
> 
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
> > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> Hi Shreeya,
> 
> This is now technically correct which is great.
> I would make one minor change to make it slightly easier to read.
> 
> The read / write frequency functions now require the buf_lock to
> be held.  That's not obvious so I would avoid this but moving
> the locking inside the functions where it is then clear that
> they are taking the unlocked forms of the register read/ write.
> 
> This would also then make it clear why the normal locked form
> of _read_reg_8 is fine in the read_freq case but not the
> write_freq case.  (Hence just use the normal locked form
> for the read and don't explicitly take the locks when
> reading the frequency - leave it to the register read function)
> 

Hi,

I have introduced unlocked form of the _read_reg_8 also, which is wrong
on my side. I should have discarded the mlocks in the read_freq case
first, then there would have been no need of having unlocked form of
the _read_reg_8 :(

Please discard this patch and I'll send two patches in which first I'll
remove the mlocks from the read case and then I'll have only the
unlocked form of the _write_reg_8. In this way, there won't be any
useless code in the file for the read case.

Sorry, it took me a bit more time to understand.

Thanks
 
> Thanks,
> 
> Jonathan
> > 
> > ---
> > 
> > Changes in v2
> >   -Add static keyword to newly introduced functions and remove some
> > added comments which are not required.
> > 
> > 
> >  drivers/staging/iio/meter/ade7758.h      |  2 +-
> >  drivers/staging/iio/meter/ade7758_core.c | 47
> > +++++++++++++++++++++++---------
> >  2 files changed, 35 insertions(+), 14 deletions(-)
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
> > index 7b7ffe5..fed4684 100644
> > --- a/drivers/staging/iio/meter/ade7758_core.c
> > +++ b/drivers/staging/iio/meter/ade7758_core.c
> > @@ -24,17 +24,25 @@
> >  #include "meter.h"
> >  #include "ade7758.h"
> >  
> > -int ade7758_spi_write_reg_8(struct device *dev, u8 reg_address, u8
> > val)
> > +static int __ade7758_spi_write_reg_8(struct device *dev, u8
> > reg_address, u8 val)
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
> > @@ -91,7 +99,7 @@ static int ade7758_spi_write_reg_24(struct device
> > *dev, u8 reg_address,
> >  	return ret;
> >  }
> >  
> > -int ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8
> > *val)
> > +static int __ade7758_spi_read_reg_8(struct device *dev, u8
> > reg_address, u8 *val)
> >  {
> >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >  	struct ade7758_state *st = iio_priv(indio_dev);
> > @@ -111,7 +119,6 @@ int ade7758_spi_read_reg_8(struct device *dev,
> > u8 reg_address, u8 *val)
> >  		},
> >  	};
> >  
> > -	mutex_lock(&st->buf_lock);
> >  	st->tx[0] = ADE7758_READ_REG(reg_address);
> >  	st->tx[1] = 0;
> >  
> > @@ -124,7 +131,19 @@ int ade7758_spi_read_reg_8(struct device *dev,
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
> > @@ -470,7 +489,7 @@ static int ade7758_read_samp_freq(struct device
> > *dev, int *val)
> >  	int ret;
> >  	u8 t;
> >  
> > -	ret = ade7758_spi_read_reg_8(dev, ADE7758_WAVMODE, &t);
> > +	ret = __ade7758_spi_read_reg_8(dev, ADE7758_WAVMODE, &t);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -503,14 +522,14 @@ static int ade7758_write_samp_freq(struct
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
> > @@ -523,12 +542,13 @@ static int ade7758_read_raw(struct iio_dev
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
> >  		ret = ade7758_read_samp_freq(&indio_dev->dev,
> > val);
> > -		mutex_unlock(&indio_dev->mlock);
> > +		mutex_unlock(&st->buf_lock);
> >  		return ret;
> >  	default:
> >  		return -EINVAL;
> > @@ -542,14 +562,15 @@ static int ade7758_write_raw(struct iio_dev
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
> >  		ret = ade7758_write_samp_freq(&indio_dev->dev,
> > val);
> > -		mutex_unlock(&indio_dev->mlock);
> > +		mutex_unlock(&st->buf_lock);
> >  		return ret;
> >  	default:
> >  		return -EINVAL;
