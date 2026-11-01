Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559221;
	b=FaiNZFdDn4gSgsfjmy5gFO9OWnrQhMqXoegRzKcrmjiCia3pp61A3QnzbdZUbC9H3A/5
	 aRMD36Vrlv801AJmFe/TvJNx41JpKkdyrvqJECstrjlniPKJ/D+5tggAWD/8XhRHBuMu5
	 AxVMr+s2xkpQKbLwsuL+aM1HnWsb/zSEHOwFe/zN6Huw9mLGQn0Q3K25k+jfWwyLAS8H+
	 4uqLqDt+mBAjudVNbt5x5I8Y+joloCm7I+qUvA259qoqSl5TJaKkdx6/WY7wBniI+NugF
	 wYweiXQnFT55EfX6d/beshBKYiNy1l7/p+vrlD8JfBignC8ggkV+cb5NtIOFU6iYGOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559221;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=O7nr/yKGnN/+M712VH7dPBKqFnx9GUMB2SXsPy6Lq/w=;
	b=4fGtTTKvVgvtLx3h21Tfutr1M5cR+QsBCLAXGRZFd5f44WRvz8NXgbIHBCzzJDZeWrcy
	 9gsavN1rh3nzo/9olmV/KXlPTyfhgD9qvaxbyJhZFM2X1ckIa38iGNQJDeAaQ8Nxsrx0I
	 ACI2POUf39BYWJePib+leRHbLcBouQ8jE1bFewBl/VmCIR4WJvKE2hrgbKWqEgPNoTdcV
	 lmqal0AQkd75L6mIykQcnrafi8TXB9DNCHp3FDVe39lIHn0d3zFSPTt6y8XCEP6Y265B0
	 L9Vy0e/Y280VkU9z1GRk7dMzz6gKITu7mDflk1GZni4DmufLCTlDXz4GUh37Dv+8lUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JeTToXO1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19126606A324;
	Sun,  1 Nov 2026 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JeTToXO1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669D71F000C1;
	Sun,  1 Nov 2026 18:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793559220;
	bh=O7nr/yKGnN/+M712VH7dPBKqFnx9GUMB2SXsPy6Lq/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JeTToXO1ns3g1Lf8brAFk14jEkw8EwVGlD2GoEOoUsO8Xsb9Msume7fzVl+fhZQPN
	 q6WaI7R0rC4isz3s3VpLH8nJD5YTENxOns+nwHlFij+nw6vs7FjjrnJ7tHOc5b+2Cq
	 GOdAMsSSsiOLopqKd0B8lqubh/OEW7egc52tQfT3vDL30Tfv8nXneyio/7+Vym/nIS
	 dlOqylKibUSGokmUOtnQj9HQvRcQDgnzsMK9gkv2Vy+T6GRvCypnnemEmXFS5EsxZX
	 MdOXn3NffR0XTTTo0hLPhEJsBszpuYYmLr5H33zJfbD2IljvfJMOhO/f5WTZaMsHvO
	 DVbblg8Ah1bUA==
Date: Sun, 1 Nov 2026 18:53:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH v3 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <20261101185335.6a5165f4@jic23-hlaptop>
In-Reply-To: <SN1PR12MB25286CE39CC09CDD0D07889BA5602@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <auBTxjakiTKn1LL_@ashevche-desk.local>
	<SN1PR12MB25286CE39CC09CDD0D07889BA5602@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Oct 2026 05:04:38 -0500
Victor Chernyakin <chernyakin.victor.j@outlook.com> wrote:

> > > I don't like the duplication either, but I think the real problem here is
> > > that read_avail is just a somewhat awkward interface that doesn't allow me
> > > to return s64 values directly. To me, having this separate decomposed table
> > > just for read_avail and otherwise working with s64 values is the least bad
> > > approach.  
> > 
> > What about adding .read_avail64() (in a separate change)? Problem solved!  
> 
> If Jonathan is open to such a new API, I could work on that! I think
> if we're going to add it, instead of just changing the two int* parameters
> to one s64*, we could add a union for the function to write into. 

Doing it for read_avail() and not read_raw() would be a odd.
For read_raw() we went down the decompose path because in initial drivers
it was only one or two out of a whole bunch of values that needed
the 64 bit form.

The challenge of touching these interfaces is how to make things both
backwards compatible and avoid need to do major refactors.
There is precedence in the addition of read_raw_multi().
Drivers that use that have to use it for everything rather than mix and match
with read_raw().

Note that we need to also carefully think about impacts on the inkern
interfaces as they use all these callbacks and the consumer drivers need
to understand the results - anything in this space goes beyond the
simple sysfs interfaces.

So there are various things we could do and I'm not sure which one makes sense.
Maybe we do have enough users now to justify a new interface. I was unconvinced
in the past but things do chagne.

Anyhow, options - note I don't want to do read_avail only as that to me
leaves us in a silly intermediate place.  So just consider read_raw().
read_avail() should follow naturally.

1. read_raw_multi() path.  Drivers opt in to do everything in 64 bit.
   Maybe painful and that inkern.c consumer bit needs some papering over.
   I haven't thought about how painful that will be.
2. read_avail() vs read_raw() path.  Given not all properties have meaningful
   available values. Hence thes two use separate masks and opt in.  Here we
   need to avoid that as would be significant bloat.
3. Mix and match. read_raw() for some things, read_raw_multi() for others.
   How to decide?  I don't like try one and see if it returns an error.
   Could use something similar to the write_fmt callback.  So drivers
   could say what the format of a read_raw was and use that to pick between
   callbacks.

Generally I'm not sure.  Probably needs some experimentation to find the
cleaners solution for all the paths that use these callbacks.


> That way,
> not everything needs to be represented as raw s64's; we could introduce
> a proper range type for example:
> 
> struct iio_range {
>     s64 min;
>     s64 step;
>     s64 max;
> };
> 
> struct iio_available_value {
>     enum iio_available_type type; /* IIO_AVAIL_RANGE, etc. */
>     union {
>         const struct iio_range *range;
>         struct {
>             const s64 *vals;
>             int num_vals;
>         } list;
>     };
> };
> 
> /* Used like so: */
> 
> static const struct iio_range fdc1004_calibbias = {
> 	.min  = -0x8000 * 488281250UL,
> 	.step = +0x0001 * 488281250UL,
> 	.max  = +0x7FFF * 488281250UL,
> };
> 
> static int fdc1004_read_avail_ext(struct iio_dev *indio_dev,
> 			                      const struct iio_chan_spec *chan,
> 			                      iio_available_value *out, long info)
> {
> 	switch (info) {
> 	case IIO_CHAN_INFO_CALIBBIAS:
>         out->range = &fdc1004_calibbias; /* No casts! */
>         out->type = IIO_AVAIL_RANGE;
> 		return IIO_VAL_DECIMAL64_FEMTO;
>     }
> }
This ends up as a bit of an implementation detail. Might make
sense to have such a structure / union. I'm not sure yet.

Jonathan
> 

