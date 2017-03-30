Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33325 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933378AbdC3SZw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Mar 2017 14:25:52 -0400
Received: by mail-io0-f194.google.com with SMTP id f84so3745845ioj.0
        for <linux-iio@vger.kernel.org>; Thu, 30 Mar 2017 11:25:51 -0700 (PDT)
Date: Thu, 30 Mar 2017 11:25:49 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Gargi Sharma <gs051095@gmail.com>,
        outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org,
        lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Subject: Re: [RFC/PATCH v3] staging: iio: update locking method during
 frequency writes
Message-ID: <20170330182549.GB6160@d830.WORKGROUP>
References: <1490866426-15575-1-git-send-email-gs051095@gmail.com>
 <ce65c22f-2c3a-a8b0-fcbb-8198829a4b65@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ce65c22f-2c3a-a8b0-fcbb-8198829a4b65@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Mar 30, 2017 at 07:22:49PM +0100, Jonathan Cameron wrote:
> On 30/03/17 10:33, Gargi Sharma wrote:
> > The driver needs to insure atomicity during frequency
> > changes of bus and device. The iiodev->mlock as used
> > was not doing that. Replace it with the drivers existing
> > buffer lock and introduce an auxiliary spi_write() that does
> > not hold the lock.
> > 
> > Signed-off-by: Gargi Sharma <gs051095@gmail.com>
> Only one comment on this.  Why an RFC?  I nearly
> ignored this in my sweep of easy patches to pick up
> this evening purely because I thought there might still
> be something that needed real thought in it.

Oh, that was my bad influence!
We were reviewing proposals for these in Outreachy and I'd
suggested the RFC label for the proposals.  Thanks for
addressing it.
alisons

> 
> It's a clean nice patch that I don't think any substantial
> questions have been raised against - so just submit it as
> patch. As an RFC it is underselling itself!
> 
> Anyhow, never mind, I did look and have applied it ;)
> 
> Applied to the togreg branch of iio.git and pushed out
> as testing for the autobuilders to play with it.
> 
> Thanks.
> 
> Jonathan
> > ---
> > Changes in v3:
> >         - Removed unnecessary ret variable inside
> >           __ade7754_spi_write_reg_8 function.
> > Changes in v2:
> >         - Added auxiliary function.
> >         - Updated the buf_lock comment appropriately.
> > ---
> >  drivers/staging/iio/meter/ade7754.c | 24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
> > index c8d2d4c..91f8740 100644
> > --- a/drivers/staging/iio/meter/ade7754.c
> > +++ b/drivers/staging/iio/meter/ade7754.c
> > @@ -97,7 +97,7 @@
> >  /**
> >   * struct ade7754_state - device instance specific data
> >   * @us:			actual spi_device
> > - * @buf_lock:		mutex to protect tx and rx
> > + * @buf_lock:		mutex to protect tx, rx and write frequency
> >   * @tx:			transmit buffer
> >   * @rx:			receive buffer
> >   **/
> > @@ -108,17 +108,25 @@ struct ade7754_state {
> >  	u8			rx[ADE7754_MAX_RX];
> >  };
> >  
> > -static int ade7754_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
> > +/* Unlocked version of ade7754_spi_write_reg_8 function */
> > +static int __ade7754_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
> >  {
> > -	int ret;
> >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >  	struct ade7754_state *st = iio_priv(indio_dev);
> >  
> > -	mutex_lock(&st->buf_lock);
> >  	st->tx[0] = ADE7754_WRITE_REG(reg_address);
> >  	st->tx[1] = val;
> > +	return spi_write(st->us, st->tx, 2);
> > +}
> >  
> > -	ret = spi_write(st->us, st->tx, 2);
> > +static int ade7754_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
> > +{
> > +	int ret;
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct ade7754_state *st = iio_priv(indio_dev);
> > +
> > +	mutex_lock(&st->buf_lock);
> > +	ret = __ade7754_spi_write_reg_8(dev, reg_address, val);
> >  	mutex_unlock(&st->buf_lock);
> >  
> >  	return ret;
> > @@ -513,7 +521,7 @@ static ssize_t ade7754_write_frequency(struct device *dev,
> >  	if (!val)
> >  		return -EINVAL;
> >  
> > -	mutex_lock(&indio_dev->mlock);
> > +	mutex_lock(&st->buf_lock);
> >  
> >  	t = 26000 / val;
> >  	if (t > 0)
> > @@ -531,10 +539,10 @@ static ssize_t ade7754_write_frequency(struct device *dev,
> >  	reg &= ~(3 << 3);
> >  	reg |= t << 3;
> >  
> > -	ret = ade7754_spi_write_reg_8(dev, ADE7754_WAVMODE, reg);
> > +	ret = __ade7754_spi_write_reg_8(dev, ADE7754_WAVMODE, reg);
> >  
> >  out:
> > -	mutex_unlock(&indio_dev->mlock);
> > +	mutex_unlock(&st->buf_lock);
> >  
> >  	return ret ? ret : len;
> >  }
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
