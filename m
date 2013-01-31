Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx-relay12-muc.antispameurope.com ([217.64.175.212]:46529 "EHLO
	mx-relay12-muc.antispameurope.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750978Ab3AaLy4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 31 Jan 2013 06:54:56 -0500
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
To: "Lars-Peter Clausen" <lars@metafoo.de>
Subject: Re: [PATCH] iio: gyro: Add itg3200
Date: Thu, 31 Jan 2013 12:54:49 +0100
Cc: linux-iio@vger.kernel.org, jic23@cam.ac.uk,
	Thorsten Nowak <thorsten.nowak@iis.fraunhofer.de>
References: <1345192038-5665-1-git-send-email-not@iis.fhg.de> <1359471547-32178-1-git-send-email-manuel.stahl@iis.fraunhofer.de> <51093AB8.2070809@metafoo.de>
In-Reply-To: <51093AB8.2070809@metafoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201301311254.49626.manuel.stahl@iis.fraunhofer.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am Mittwoch, 30. Januar 2013, 16:22:32 schrieb Lars-Peter Clausen:
> On 01/29/2013 03:59 PM, Manuel Stahl wrote:
> > Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> 
> Hi,
> 
> Looks mostly good. One usage of outdated API and otherwise mostly just minor
> style issues.

Ah sorry, I used 3.7 as reference.

[...]

> > +static irqreturn_t itg3200_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct itg3200 *st = iio_priv(indio_dev);
> > +	struct iio_buffer *buffer = indio_dev->buffer;
> > +	__be16 buf[ITG3200_SCAN_ELEMENTS + sizeof(s64)/sizeof(u16)];
> > +
> > +	/* Clear IRQ */
> > +	itg3200_read_irq_status(indio_dev);
> > +
> > +	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength)) {
> > +		int ret;
> > +		unsigned i, j = 0;
> > +
> > +		ret = itg3200_read_all_channels(st->i2c, buf);
> > +		if (ret < 0)
> > +			goto error_ret;
> > +
> > +		/* Select only active scan elements */
> > +		for (i = 0; i < ITG3200_SCAN_ELEMENTS; i++)
> > +			if (iio_scan_mask_query(indio_dev, buffer, i))
> > +				buf[j++] = buf[i];
> 
> The IIO core can take care of this kind of demuxing for you. If you set
> available_scan_masks to { 0xffff..., 0x0 } it will know that the device will
> only be able to sample all channels at once. A user will still be able to
> select a subset of channels and the IIO core will take care of picking the
> right samples.

Where do I set the available_scan_masks?

> 
> > +	}
> > +
> > +	if (indio_dev->scan_timestamp)
> > +		memcpy(buf + indio_dev->scan_bytes - sizeof(s64),
> > +				&pf->timestamp, sizeof(pf->timestamp));
> > +
> > +	iio_push_to_buffer(buffer, (u8 *)buf, pf->timestamp);
> 
> This won't work in the latest version of IIO, use
> 
> iio_push_to_buffers(indio_dev, (u8 *)buf); instead

[...]

> Do we really need this wrapper? I think it might be better to move
> itg3200_set_irq_data_rdy here, especially considering that it is unused in
> case buffer support is not enabled.
> 
> Similar I think it makes sense to move itg3200_read_all_channels and
> itg3200_read_irq_status to tg3200_buffer.c

That's OK, I just need to put the register definitions into the header file.
Actually itg3200_read_irq_status is not needed anyway since we use a
non latched IRQ line.

I would also combine itg3200_buffer.c and itg3200_trigger.c into a single file.
Any suggestions for the name?

-- 
Regards,
Manuel Stahl
