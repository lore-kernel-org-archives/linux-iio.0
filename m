Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750951AbeBQMX6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Feb 2018 07:23:58 -0500
Date: Sat, 17 Feb 2018 12:23:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Himanshu Jha <himanshujha199640@gmail.com>, 21cnbao@gmail.com,
        devel@driverdev.osuosl.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH 3/4] staging: iio: accel: Use sign_extend32 and adjust a
 switch statement
Message-ID: <20180217122353.7ee9bf96@archlinux>
In-Reply-To: <20180212131000.h4tbinr4s6m4ckh4@mwanda>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
        <1518436499-8584-4-git-send-email-himanshujha199640@gmail.com>
        <20180212131000.h4tbinr4s6m4ckh4@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 12 Feb 2018 16:10:01 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Mon, Feb 12, 2018 at 05:24:58PM +0530, Himanshu Jha wrote:
> > Use sign_extend32 function instead of manually coding it. Also, adjust a  
>                                                             ^^^^^
> > switch block to explicitly match channels and return -EINVAL as default
> > case which improves code readability.  
> 
> Greg likes to say something along the lines of "when you start your
> sentence with "Also, " that could be a clue that it should be a separate
> patch.".
> 
> > 
> > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> > ---
> >  drivers/staging/iio/accel/adis16201.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> > index 011d2c5..6800347 100644
> > --- a/drivers/staging/iio/accel/adis16201.c
> > +++ b/drivers/staging/iio/accel/adis16201.c
> > @@ -112,12 +112,17 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
> >  	case IIO_CHAN_INFO_SCALE:
> >  		switch (chan->type) {
> >  		case IIO_VOLTAGE:
> > -			if (chan->channel == 0) {
> > +			switch (chan->channel) {
> > +			case 0:
> >  				*val = 1;
> >  				*val2 = 220000;
> > -			} else {
> > +				break;
> > +			case 1:
> >  				*val = 0;
> >  				*val2 = 610000;
> > +				break;
> > +			default:
> > +				return -EINVAL;
> >  			}  
> 
> I don't think this improves readability.  The -EINVAL is to handle a
> driver bug which we haven't introduced yet.  Probably we would be better
> off printing a warning or something?  But it feels weird to introduce so
> much code to handle a bug which would actually be pretty difficult to
> write.  The original code is fine.

Hmm. My thought here was that it is not obvious from the code
that we only have channel 0 and channel 1.  The if statement
kind of implies that channel 0 is special compared to 'all the other'
elements where as what we are actually doing is picking from
a set of options. So semantically it's a switch statement being
implemented as an if else pair ;)

Perhaps we can compromise on the addition of a comment on the else
case to say it only applies to channel 1?

Dan, what do you think?

It isn't particularly important either way though so feel free to
just drop this one.

> 
> >  			return IIO_VAL_INT_PLUS_MICRO;
> >  		case IIO_TEMP:
> > @@ -155,9 +160,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
> >  		if (ret)
> >  			return ret;
> >  
> > -		val16 &= (1 << bits) - 1;
> > -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> > -		*val = val16;
> > +		*val = sign_extend32(val16, bits - 1);  
> 
> Yeah.  This is a nice clean up.
> 
> regards,
> dan carpenter
> 

