Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:57212 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826Ab2FRMPz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 18 Jun 2012 08:15:55 -0400
Date: Mon, 18 Jun 2012 14:15:53 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Lars-Peter Clausen <lars@metafoo.de>
cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 01/10] iio: iio_buffer_register: Skip channels with
 negative scan index
In-Reply-To: <4FDF1A43.7010701@cam.ac.uk>
Message-ID: <alpine.DEB.2.01.1206181414060.26163@pmeerw.net>
References: <1340019903-13305-1-git-send-email-lars@metafoo.de> <4FDF1A43.7010701@cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> > index to a negative number, which will cause iio_buffer_register to ignore
> > the
> > channel.

ah, nice, I wondered about the same thing :)

> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -285,6 +285,9 @@ int iio_buffer_register(struct iio_dev *indio_dev,
> >   	if (channels) {
> >   		/* new magic */
> >   		for (i = 0; i<  num_channels; i++) {
> > +			if (channels[i].scan_index<  0)
> > +				continue;
> > +
> >   			/* Establish necessary mask length */
> >   			if (channels[i].scan_index>
> >   			(int)indio_dev->masklength - 1)

whitespace before/after < could be improved

-- 

Peter Meerwald
+43-664-2444418 (mobile)
