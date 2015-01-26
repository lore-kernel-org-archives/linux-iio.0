Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:35710 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754589AbbAZJrc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jan 2015 04:47:32 -0500
Received: by mail-wg0-f53.google.com with SMTP id a1so7913786wgh.12
        for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2015 01:47:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54C55EAD.8020404@gmx.de>
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com>
	<1419122556-8100-4-git-send-email-octavian.purdila@intel.com>
	<54C55EAD.8020404@gmx.de>
Date: Mon, 26 Jan 2015 11:40:51 +0200
Message-ID: <CAE1zotK0VhB_2Zq72nnMCNe_ZERGOQmPd3+-6Hzc9JeY-JGMTw@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] iio: add watermark logic to iio read and poll
From: Octavian Purdila <octavian.purdila@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jan 25, 2015 at 11:22 PM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>
> Octavian Purdila schrieb am 21.12.2014 um 01:42:
> > From: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
> >
> > Currently the IIO buffer blocking read only wait until at least one
> > data element is available.
> > This patch makes the reader sleep until enough data is collected before
> > returning to userspace. This should limit the read() calls count when
> > trying to get data in batches.
> >
>
> Hi,
> I have a question and a minor recommendation, please see inline.
>

Thanks for looking at this.

Any feedback on the hardware buffer stuff? We are still trying to find
the right ABIs. I did not get feedback after my last reply, did it got
lost?

<snip>

> >       struct iio_dev *indio_dev = filp->private_data;
> >       struct iio_buffer *rb = indio_dev->buffer;
> > +     size_t datum_size = rb->bytes_per_datum;
> > +     size_t to_read = min_t(size_t, n / datum_size, rb->low_watermark);
> Are you sure that rb->bytes_per_datum can not be zero, when accessed here? From
> what I could see, there is a chance of it being zero, if the scan_mask is clear
> and timestamps are disabled.
>

Good catch, I will fix that.

> > +
> > +     /* We can't just test for watermark to decide if we wake the poll queue
> > +      * because read may request less samples than the watermark
> I think this comment could end with a full stop. Also, first line should be
> empty.
>

Correct.
