Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6B613D886;
	Thu, 20 Aug 2026 02:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787191885; cv=none; b=UYqRkf5qF5P5f2DZqVfmxyOeI/HG141w7euk3MDobz22Eqx0KZwwC498Tfwiy2VbFvXb1Dgx7Kqvk8b3Ui45FTh3apmIx6F7YY2QLlFGuuy5i2znz9jeiMmhDCOqMA9yeO5s523w+tfROvy8EYwEqmFZnv5SRExcYhsxB3YgyVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787191885; c=relaxed/simple;
	bh=Eo98q6k8B3L20N8ycKUABkBz2TXpM1a2g9IqI/8v4/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7xgrfFTHhIsOkAPdq+xst3rKeeRKG+7qYGjmPnCsazWpmyMF9lyalrxYPeQ0Ufc9+q5WUIWBVY4Ly64trwy/yF5aTzD0Dy6GXD0xDPQ73ejz9JhEGBcykApIyNPSaUyyVEkk/zcA7Zr9KGtJN5JRZrPStQHZEKkra52SLtGtXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFwi7p9p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFwi7p9p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697441F000E9;
	Thu, 20 Aug 2026 02:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787191884;
	bh=DRJHgOPjQHwXBU8lYUe+gNAafFMz0frS8N6juLj+XzE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nFwi7p9pJxr4q2BKsLAxqwPWNW0GeVS+UtOYRemqwKmu7rQoXJ8X3ThwKNB8c8Y6/
	 maknnQwCsad0uA85ZuoAUBls6Vv1TDbLaCVCr3sFxO6d7qGHAIiX51yW2AxlgqkiE3
	 106dLadlMw6V51sRPNYVWWW+jdFD/rJgg1nNV33WIGtHOsAjcLMciaYqGB/Fd8sxPV
	 AtLkjOwP53/NvSV18kvz6e+Fg5nKPO/HIdl2xZQa8Ll7yiIC1mDaKyeC//9ZKLnsdJ
	 IejVIaah55pH5Nt3hjTe8vmWfP9+1oSTcH+Pz/4eGwRH+OoyjifcTA4DyTDQIoGi9g
	 eceJAw83mjJCA==
Date: Thu, 20 Aug 2026 03:11:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Gabriel Rondon <grondon@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: accel: kionix-kx022a: use
 iio_push_to_buffers_with_ts()
Message-ID: <20260820031119.47cc45b0@jic23-huawei>
In-Reply-To: <c4606bde-6132-4407-9fcf-32ec35b1ed1c@gmail.com>
References: <20260818215122.52715-1-grondon@gmail.com>
	<20260818215122.52715-3-grondon@gmail.com>
	<c4606bde-6132-4407-9fcf-32ec35b1ed1c@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 08:11:45 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 19/08/2026 00:51, Gabriel Rondon wrote:
> > Replace the deprecated iio_push_to_buffers_with_timestamp() with
> > iio_push_to_buffers_with_ts(), which takes the destination buffer size
> > and checks it against scan_bytes at runtime.
> > 
> > Both push sites now use data->scan ({ __le16 channels[3]; aligned_s64
> > ts; }, IIO_DMA_MINALIGN aligned), which is 16 bytes and matches
> > scan_bytes for the 3-axis plus s64 timestamp layout used by all
> > supported variants, so pass sizeof(data->scan).  
> 
> Eh, what is this explanation above? As far as I understand, the 
> iio_push_to_buffers_with_ts() has a safety mechanism of checking the 
> passed buffer size. So, size of the buffer must be passed, no matter 
> what the buffer is designed to contain.
Fair point - this evolved in an odd direction. Dropped that paragraph.
> 
> By the way, to my eye the commit message looks AI generated, which is 
> perfectly fine. But AFAICS, AI generated patches should be tagged as AI 
> generated. Hence, if you use AI to do the changes, please ask the AI to 
> check the docs and also add necessary tags :)
> 
> > Signed-off-by: Gabriel Rondon <grondon@gmail.com>  
> 
> Other than the commit message:
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> > ---
> >   drivers/iio/accel/kionix-kx022a.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> > index cf2cb751b4e8..86f17431aa23 100644
> > --- a/drivers/iio/accel/kionix-kx022a.c
> > +++ b/drivers/iio/accel/kionix-kx022a.c
> > @@ -863,7 +863,8 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> >   		for_each_set_bit(bit, idev->active_scan_mask, AXIS_MAX)
> >   			chs[bit] = sam[bit];
> >   
> > -		iio_push_to_buffers_with_timestamp(idev, &data->scan, tstamp);
> > +		iio_push_to_buffers_with_ts(idev, &data->scan,
> > +					    sizeof(data->scan), tstamp);
> >   
> >   		tstamp += sample_period;
> >   	}
> > @@ -1033,7 +1034,8 @@ static irqreturn_t kx022a_trigger_handler(int irq, void *p)
> >   	if (ret < 0)
> >   		goto err_read;
> >   
> > -	iio_push_to_buffers_with_timestamp(idev, &data->scan, data->timestamp);
> > +	iio_push_to_buffers_with_ts(idev, &data->scan, sizeof(data->scan),
> > +				    data->timestamp);
> >   err_read:
> >   	iio_trigger_notify_done(idev->trig);
> >     
> 
> 

