Return-Path: <dan.carpenter@oracle.com>
Date: Mon, 4 Jun 2012 23:36:55 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 01/18] iio: Add helper functions for enum style channel
 attributes
Message-ID: <20120604203655.GA4297@mwanda>
References: <1338802588-10585-1-git-send-email-lars@metafoo.de>
 <20120604105510.GB4400@mwanda>
 <4FCD16AB.5020909@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FCD16AB.5020909@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jun 04, 2012 at 10:12:27PM +0200, Lars-Peter Clausen wrote:
> On 06/04/2012 12:55 PM, Dan Carpenter wrote:
> > On Mon, Jun 04, 2012 at 11:36:11AM +0200, Lars-Peter Clausen wrote:
> >> +ssize_t iio_enum_available_read(struct iio_dev *indio_dev,
> >> +	uintptr_t priv, const struct iio_chan_spec *chan, char *buf)
> >> +{
> >> +	const struct iio_enum *e = (const struct iio_enum *)priv;
> >> +	unsigned int i;
> >> +	size_t len = 0;
> >> +
> >> +	if (!e->num_items)
> >> +		return 0;
> >> +
> >> +	for (i = 0; i < e->num_items; ++i)
> >> +		len += snprintf(buf + len, PAGE_SIZE - len, "%s ", e->items[i]);
> >> +
> >> +	/* replace last space with a newline */
> >> +	buf[len - 1] = '\n';
> >> +
> > 
> > It would be better to use scnprintf() here instead of snprintf().
> > snprintf() returns the number of characters that would have been
> > printed if there were space (not counting the NULL), so len - 1 can
> > be beyond the end of the array.
> 
> It's even worse, if len is greater than PAGE_SIZE we'll pass a pretty large
> number for the buffer size to snprintf and it will happily write beyond the
> buffers limits. So as it is right now the snprintf isn't really any better than
> a sprintf. I'll resend the patch with scnprintf.

No.  Negative numbers just trigger the WARN_ON_ONCE() in
vsnprintf() and not print anything.

Although, in user space, snprintf() does treat negatives as a large
positive.

regards,
dan carpenter
