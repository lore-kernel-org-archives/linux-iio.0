Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752368AbdIXPeg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Sep 2017 11:34:36 -0400
Date: Sun, 24 Sep 2017 16:34:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/4] iio: light: vl6180: Move range check to integration
 time setter, cleanup
Message-ID: <20170924163432.7064fcfa@archlinux>
In-Reply-To: <alpine.DEB.2.20.1709190817310.8589@vps.pmeerw.net>
References: <20170919031144.4968-1-stefan.bruens@rwth-aachen.de>
        <20170919031144.4968-2-stefan.bruens@rwth-aachen.de>
        <alpine.DEB.2.20.1709190817310.8589@vps.pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 19 Sep 2017 08:17:51 +0200 (CEST)
Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:

> > This improves code uniformity (range checks for als_gain are also done
> > in the setter). Also unmangle rounding and calculation of register value.  
> 
> nitpick below
And another one from me...

Jonathan
>  
> > The calculated integration time it_ms is required in the next patch of
> > the series.
> > 
> > Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
> > ---
> >  drivers/iio/light/vl6180.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
> > index 6e25b724d941..57577d5d18ac 100644
> > --- a/drivers/iio/light/vl6180.c
> > +++ b/drivers/iio/light/vl6180.c
> > @@ -386,16 +386,21 @@ static int vl6180_set_als_gain(struct vl6180_data *data, int val, int val2)
> >  	return -EINVAL;
> >  }
> >  
> > -static int vl6180_set_it(struct vl6180_data *data, int val2)
> > +static int vl6180_set_it(struct vl6180_data *data, int val, int val2)
> >  {
> > -	int ret;
> > +	int ret, it_ms;
> > +
> > +	it_ms = ((val2 + 500) / 1000); /* round to ms */  
> 
> outer parenthesis not necessary
> 
> > +	if (val != 0 || it_ms < 1 || it_ms > 512)
> > +		return -EINVAL;
> >  
> >  	mutex_lock(&data->lock);
> >  	ret = vl6180_hold(data, true);
> >  	if (ret < 0)
> >  		goto fail;
> > -	ret = vl6180_write_word(data->client, VL6180_ALS_IT,
> > -		(val2 - 500) / 1000); /* write value in ms */
> > +
> > +	ret = vl6180_write_word(data->client, VL6180_ALS_IT, it_ms - 1);
> > +
> >  fail:
> >  	vl6180_hold(data, false);
> >  	mutex_unlock(&data->lock);
> > @@ -411,15 +416,14 @@ static int vl6180_write_raw(struct iio_dev *indio_dev,
> >  
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_INT_TIME:
> > -		if (val != 0 || val2 < 500 || val2 >= 512500)
> > -			return -EINVAL;
> > +		return vl6180_set_it(data, val, val2);
> >  
> > -		return vl6180_set_it(data, val2);

> >  	case IIO_CHAN_INFO_HARDWAREGAIN:
> >  		if (chan->type != IIO_LIGHT)
> >  			return -EINVAL;
> >  
> >  		return vl6180_set_als_gain(data, val, val2);
> > +
Unrelated white space changes shouldn't be in the same patch
as a real change. Please split them out.

> >  	default:
> >  		return -EINVAL;
> >  	}
> >   
> 

