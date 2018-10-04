Return-Path: <SRS0=REWE=MQ=poczta.fm=sst@kernel.org>
Date: Thu, 4 Oct 2018 19:04:30 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, Michael.Hennerich@analog.com,
	jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 1/2] staging: iio: cdc: ad7150: use pointer to shorten
 the line length
Message-ID: <20181004170430.GG24866@x220.localdomain>
References: <20181001193223.GD24866@x220.localdomain>
 <20181001193305.GE24866@x220.localdomain>
 <4549c428-bf12-8e5b-0556-f953b22da89c@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4549c428-bf12-8e5b-0556-f953b22da89c@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

On paź 04, 2018 17:21, Lars-Peter Clausen wrote:
> On 10/01/2018 09:33 PM, Slawomir Stepien wrote:
> >  drivers/staging/iio/cdc/ad7150.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> > index d16084d7068c..5b5b766a0405 100644
> > --- a/drivers/staging/iio/cdc/ad7150.c
> > +++ b/drivers/staging/iio/cdc/ad7150.c
> > @@ -102,18 +102,19 @@ static int ad7150_read_raw(struct iio_dev *indio_dev,
> >  {
> >  	int ret;
> >  	struct ad7150_chip_info *chip = iio_priv(indio_dev);
> > +	const int *channel = &chan->channel;
> 
> Instead of taking a pointer, just take the value of the channel index and
> use that. The generated code should be very similar but its a bit nicer to read.

OK. I've been thinking about that for a moment, but in the end decided to go
with the pointer. I don't mind the value. I'll prepare v2. Thank you.

-- 
Slawomir Stepien
