Return-Path: <akpm@linux-foundation.org>
Date: Wed, 28 Jul 2010 16:19:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Greg KH <greg@kroah.com>, Randy Dunlap <randy.dunlap@oracle.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] staging:iio:adis16350 add dummy ring functions for
 no ring build case
Message-Id: <20100728161916.192fc5d3.akpm@linux-foundation.org>
In-Reply-To: <4C509D84.9090408@cam.ac.uk>
References: <1280344119-18885-1-git-send-email-jic23@cam.ac.uk>
	<4C509D84.9090408@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Wed, 28 Jul 2010 22:13:40 +0100
Jonathan Cameron <jic23@cam.ac.uk> wrote:

> On 07/28/10 20:08, Jonathan Cameron wrote:
> > Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> > ---
> Sorry these should both be static.
> Should have run sparse before throwing these out...

static inline, actually.

> >  drivers/staging/iio/imu/adis16350.h |    8 ++++++++
> >  1 files changed, 8 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/imu/adis16350.h b/drivers/staging/iio/imu/adis16350.h
> > index 738deba..0d2eda8 100644
> > --- a/drivers/staging/iio/imu/adis16350.h
> > +++ b/drivers/staging/iio/imu/adis16350.h
> > @@ -165,5 +165,13 @@ adis16350_read_data_from_ring(struct device *dev,
> >  	return 0;
> >  }
> >  
> > +int adis16350_configure_ring(struct iio_dev *indio_dev)
> > +{
> > +	return 0;
> > +}
> > +
> > +void adis16350_unconfigure_ring(struct iio_dev *indio_dev)
> > +{
> > +}
> >  #endif /* CONFIG_IIO_RING_BUFFER */
> >  #endif /* SPI_ADIS16350_H_ */
