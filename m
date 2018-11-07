Return-Path: <SRS0=3hpd=NS=poczta.fm=sst@kernel.org>
Date: Wed, 7 Nov 2018 23:39:35 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc: "lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] staging: iio: adc: ad7280a: do not pass the copy of
 struct element
Message-ID: <20181107223935.GA25135@x220.localdomain>
References: <20181106214308.10619-1-sst@poczta.fm>
 <82f74f8b82df3faf44e46b19f03654b173d0fbf1.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <82f74f8b82df3faf44e46b19f03654b173d0fbf1.camel@analog.com>
List-ID: <linux-iio@vger.kernel.org>

On lis 07, 2018 10:16, Ardelean, Alexandru wrote:
> On Tue, 2018-11-06 at 22:43 +0100, Slawomir Stepien wrote:
> > There is no need to pass this parameter since is always a copy of
> > parameter that is available via st pointer.
> > 
> 
> Hey,
> 
> Comments inline.
> 
> Thanks
> Alex
> 
> > Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> > ---
> > Note: this has been rebased on kernel/git/jic23/iio.git testing branch. I
> > hope
> >       that's OK!
> > 
> > Changes since v1:
> > * Change my email address
> > ---
> >  drivers/staging/iio/adc/ad7280a.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7280a.c
> > b/drivers/staging/iio/adc/ad7280a.c
> > index 89c2c2deca64..fc6237ddb460 100644
> > --- a/drivers/staging/iio/adc/ad7280a.c
> > +++ b/drivers/staging/iio/adc/ad7280a.c
> > @@ -291,7 +291,7 @@ static int ad7280_read_channel(struct ad7280_state
> > *st, unsigned int devaddr,
> >  	return (tmp >> 11) & 0xFFF;
> >  }
> >  
> > -static int ad7280_read_all_channels(struct ad7280_state *st, unsigned
> > int cnt,
> > +static int ad7280_read_all_channels(struct ad7280_state *st,
> >  				    unsigned int *array)
> >  {
> 
> [Generally speaking] When passing an array of elements to a function in C,
> it's a good idea to also pass the count of elements, so that you know how
> many elements to iterate over.
> So, this code should be fine as-is.
> 
> I agree that the element count is stored on `st`, but having `cnt` as a
> parameter on the ad7280_read_all_channels() function keeps it neatly
> coupled with `array` and gives you the flexibility to read less than `cnt`
> channels.
> 
> I don't feel this change (even though correct) is really worth the trouble,
> since it doesn't really add much value to the existing code.

Yes. You are right here. It's not worth the trouble.
Thank you for this review Alex.

> But if there are any opinions otherwise, I don't feel really strongly about
> doing it one way (before this patch) or the other (with this patch).
> 
> >  	int i, ret;
> > @@ -312,7 +312,7 @@ static int ad7280_read_all_channels(struct
> > ad7280_state *st, unsigned int cnt,
> >  
> >  	ad7280_delay(st);
> >  
> > -	for (i = 0; i < cnt; i++) {
> > +	for (i = 0; i < st->scan_cnt; i++) {
> >  		ret = __ad7280_read32(st, &tmp);
> >  		if (ret)
> >  			return ret;
> > @@ -687,7 +687,7 @@ static irqreturn_t ad7280_event_handler(int irq, void
> > *private)
> >  	if (!channels)
> >  		return IRQ_HANDLED;
> >  
> > -	ret = ad7280_read_all_channels(st, st->scan_cnt, channels);
> > +	ret = ad7280_read_all_channels(st, channels);
> >  	if (ret < 0)
> >  		goto out;
> >  
> > @@ -791,7 +791,7 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
> >  	case IIO_CHAN_INFO_RAW:
> >  		mutex_lock(&st->lock);
> >  		if (chan->address == AD7280A_ALL_CELLS)
> > -			ret = ad7280_read_all_channels(st, st->scan_cnt,
> > NULL);
> > +			ret = ad7280_read_all_channels(st, NULL);
> >  		else
> >  			ret = ad7280_read_channel(st, chan->address >> 8,
> >  						  chan->address & 0xFF);

-- 
Slawomir Stepien
