Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7B313D53C;
	Sun, 13 Sep 2026 22:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789337228; cv=none; b=VC+B89QR956x2Rco5uK4tyeZAWwl74dXd3A8O1Gsr+/1NT9ios4w/iV9zGviDw2EjgG9ZDoLKcZUNzDtYXylMPyL7hGxOab8QdarsVWY7dDSwMnbIjb1ydSMLA5URrR6LE5EGkDyUMPR55OUVwVMq6CUvZF5Zb8o3xdhnlDb5ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789337228; c=relaxed/simple;
	bh=wgOxdAAZQpRA1nQlYqMgVYfq8oEoIFKzjhpxEXivjYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B63KPuaguluBGOvwYzvXjNO5juhwWX2Iz94fwzCvVj5lLshAB/dSUVgjxQLKLjIDg9o3k836wHmvvva9le4bWnws4UGxbpThArjHX7v2/AYMnWYa1SmN5+73fwATLV7mw6J7OFjISQNJX1gQ8yIZgNo7OF1Z/e6cYDvUYblTMs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MO+Q5sbQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MO+Q5sbQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B3A1F000FF;
	Sun, 13 Sep 2026 22:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789337226;
	bh=bnW4CVwupfk4CQ9mvNUYXBR+c+dvbdKCRwR5sU1ZHeg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MO+Q5sbQ5K4qr2TGGh8rlz2aO/PWHXgWrxR6Z4fc/Bk8kUxs5aLZAgoMTJjatm9B4
	 TGJESwVImzI3odX+d1zrxMZ7gENETQsAhg7YVdOEcpnbTWiF2HTz4bljGq1knKuxJI
	 bi2jLP0QY0119OFCXo9PkhYK2fNorYoNkTTLwrD3nrKApK7n53lzwRe3t+48bg+ZOy
	 BHQAVV5/+rYyhzPgF120LTM0VAbmhNMPnfZvcFSAGIYVLdazJWUGyNMdBb6tgOk9iw
	 f3bJ3LK0ezO16rNj24ncx0NLHGIQwPUOZCU8t+G4uvHgBwIqlKDUCo0rvZvpmDzEtt
	 EHJL/w0qxi1yw==
Date: Sun, 13 Sep 2026 23:07:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Salah Triki <salah.triki@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: tmp006: Fix endianness byte swap in
 trigger handler
Message-ID: <20260913230701.4c56791a@jic23-hlaptop>
In-Reply-To: <20260907164733.000066f9@gmail.com>
References: <20260907082216.52821-1-salah.triki@gmail.com>
	<20260907164733.000066f9@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Sep 2026 16:47:33 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon,  7 Sep 2026 09:22:15 +0100
> Salah Triki <salah.triki@gmail.com> wrote:
> 
> > In tmp006_trigger_handler(), i2c_smbus_read_word_data() is used to read
> > the VOBJECT and TAMBIENT registers. However, the TMP006 stores register
> > values in Big Endian byte order, while i2c_smbus_read_word_data() assumes
> > Little Endian.
> > 
> > This causes byte-swapped values to be pushed to the IIO buffer on Little
> > Endian architectures, leading to corrupted sensor readings when using
> > triggered buffers.
> > 
> > Fix this by switching to i2c_smbus_read_word_swapped() inside the trigger
> > handler.
> > 
> > Fixes: 91f75ccf9f03 ("iio: temperature: tmp006: add triggered buffer support")
> > Assisted-by: LLM
> > Signed-off-by: Salah Triki <salah.triki@gmail.com>
> > ---
> >  drivers/iio/temperature/tmp006.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
> > index d9f6449ec0d8..f3b3de0bf221 100644
> > --- a/drivers/iio/temperature/tmp006.c
> > +++ b/drivers/iio/temperature/tmp006.c
> > @@ -256,12 +256,12 @@ static irqreturn_t tmp006_trigger_handler(int irq, void *p)
> >  	} scan = { };
> >  	s32 ret;
> >  
> > -	ret = i2c_smbus_read_word_data(data->client, TMP006_VOBJECT);
> > +	ret = i2c_smbus_read_word_swapped(data->client, TMP006_VOBJECT);  
> 
> Sashiko has something to say:
> 
> Does this code introduce a regression where sensor readings are corrupted for
> userspace clients reading from the triggered IIO buffer on Little Endian
> architectures?
> 
> Before this patch, i2c_smbus_read_word_data() returned a byte-swapped word.
> When this was assigned to the s16 array in tmp006_trigger_handler() on a Little
> Endian CPU, the memory layout became [msb, lsb]. This implicitly matched the
> IIO_BE (Big Endian) endianness declared in the tmp006_channels array, so it
> worked correctly.
> 
> By switching to i2c_smbus_read_word_swapped(), the value is now in native CPU
> endianness [lsb, msb]. However, the channel specification in tmp006_channels
> still specifies IIO_BE:
> drivers/iio/temperature/tmp006.c:tmp006_channels[] {
>     ...
>         .scan_type = {
>             .endianness = IIO_BE,
>         },
>     ...
> }
> 
> Because the ABI still advertises the data as Big Endian, userspace will parse
> the little-endian data as big-endian.
> 
> Should the channel specification be updated from IIO_BE to IIO_CPU, or should
> scan.channels be declared as __be16 and populated using cpu_to_be16() to
> preserve the existing Big Endian ABI?
> 
Nice catch for sashiko.  It is absolutely correct.  Thanks for
highlighting this one!

Jonathan


