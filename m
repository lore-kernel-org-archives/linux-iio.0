Return-Path: <gregkh@linuxfoundation.org>
Date: Tue, 5 Jun 2012 13:45:27 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, devel@driverdev.osuosl.org,
	Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 01/18] iio: Add helper functions for enum style channel
 attributes
Message-ID: <20120605044527.GA10353@kroah.com>
References: <1338802588-10585-1-git-send-email-lars@metafoo.de>
 <20120604105510.GB4400@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120604105510.GB4400@mwanda>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jun 04, 2012 at 01:55:10PM +0300, Dan Carpenter wrote:
> On Mon, Jun 04, 2012 at 11:36:11AM +0200, Lars-Peter Clausen wrote:
> > +ssize_t iio_enum_available_read(struct iio_dev *indio_dev,
> > +	uintptr_t priv, const struct iio_chan_spec *chan, char *buf)
> > +{
> > +	const struct iio_enum *e = (const struct iio_enum *)priv;
> > +	unsigned int i;
> > +	size_t len = 0;
> > +
> > +	if (!e->num_items)
> > +		return 0;
> > +
> > +	for (i = 0; i < e->num_items; ++i)
> > +		len += snprintf(buf + len, PAGE_SIZE - len, "%s ", e->items[i]);
> > +
> > +	/* replace last space with a newline */
> > +	buf[len - 1] = '\n';
> > +
> 
> It would be better to use scnprintf() here instead of snprintf().
> snprintf() returns the number of characters that would have been
> printed if there were space (not counting the NULL), so len - 1 can
> be beyond the end of the array.

Good idea.  Lars, care to send a follow-on patch that fixes this up?

thanks,

greg k-h
