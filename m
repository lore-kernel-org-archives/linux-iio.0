Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76C63C98BF;
	Sun, 27 Sep 2026 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531978; cv=none; b=c6uK4yjBmP4cOuisp6Sj6f/GBOnttWjdlVtN5uVaAEM6/AsjCmyYf8waHdgWiVxAfrh0ybSAWkpJ3N7Kf+pOINVnqy0t8F34elOgY63UH0Wz8NyW69tIWuFpOWWeFiFSqKI8/G4H9F4+bFMZtFUQH8QJc3bC80adanpqGtzJ1xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531978; c=relaxed/simple;
	bh=PTJwNzxHC0JLHfX1M87bJjL/C6AQFfuultpt+k6kcRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbuRcVZMajn+uM0JLQAp96r5zzuFB0CQFkECcInx1vwMj+8/UfiH1oHLUKsp3MJuBCIkxdFYBCY83iLn+xKrDEFNL3Y3fEuVDwgY2Dr5d53kuoy76/3PeWO/9aHRu/ySEPfUESIR20+10Xpe3xK7RnPMPII4EA/QMgA+TuZjWU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bj5TF79i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bj5TF79i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D701F000FF;
	Sun, 27 Sep 2026 17:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790531976;
	bh=jKX1hNu8JN77nrUnKVqFivHurfvZIBwO7xuCL/DDob0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Bj5TF79i2FGenm6oaBgqo6f68Umjy/5ukQxDwghivvCmZpNKpQ5E7j6Q4um66B1Qr
	 4fDJDdurAxNwavieugnwrHaxwvVFyAieJBZID99jJQ6y584fKAq1RJk9402fv64JDq
	 EV5GHSDkriWItMAGvoCkCgUkIBGlwU6X+GyIJUAZiZY23ayMgU7cRLsQQoZnm6F3PS
	 Hp1DhkZqbR5SbjsLS9HgWFTPFI7x/DN4yBp5bp2N50ig7ca6ryCIePoXoKCynj+5eu
	 W/+YbhIOkC1OhYIp3rbda+wnDQ8JrmcXNjJRIuchbsQiD3OKwgvmPeekokXWiIEVMP
	 0dwHFZRJpOoag==
Date: Sun, 27 Sep 2026 18:59:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shehryar Ahmad <shehryar.amd@gmail.com>
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 andy@kernel.org, linux@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Robert Budai <robert.budai@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Dragos Bogdan
 <dragos.bogdan@analog.com>
Subject: Re: [RFC PATCH] iio: adis_buffer: fix buffer ordering for IIO core
 demultiplexing
Message-ID: <20260927185929.70635769@jic23-hlaptop>
In-Reply-To: <20260925110239.59320-1-shehryar.amd@gmail.com>
References: <20260925110239.59320-1-shehryar.amd@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 16:02:39 +0500
Shehryar Ahmad <shehryar.amd@gmail.com> wrote:

> Hi Jonathan,
> 
> After issue raised by Sashiko in adis16203 graduation series [1], looking at
> other drivers if they might have same issue. It appears that the root
> cause is in adis_buffer.c itself. The library constructs the SPI
> transaction in channel array order while IIO core demultiplexes in
> scan_index order.
> 
> adis16209 and adis16260 have the same mismatched ordering that
> adis16201/16203 had.
> 
> Rather than reordering channel arrays in affected driver,
> would it be sensible to make adis_update_scan_mode() iterate
> in scan_index order instead of channel array order?
> 
> Would this be the right approach, or is there something I'm missing?

It is definitely plausible.  For this I'd need some input from someone
who can actually test some of these parts.

Nuno, you are listed as library maintainer - so can you get someone to
look at this please. +CC various other folk from maintainers or who have worked
in this area in last few years.

Otherwise, just a comment to use a Link tag for cross references.

Thanks,

Jonathan


> 
> [1]: https://lore.kernel.org/all/20260914015321.7a660ab5@jic23-hlaptop/
> 
Link: https://lore.kernel.org/all/20260914015321.7a660ab5@jic23-hlaptop/ #[1]
> Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
> ---
>  drivers/iio/imu/adis_buffer.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> index 501da4eae..45200b753 100644
> --- a/drivers/iio/imu/adis_buffer.c
> +++ b/drivers/iio/imu/adis_buffer.c
> @@ -110,10 +110,10 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
>  		spi_message_add_tail(&adis->xfer[j], &adis->msg);
>  	}
>  
> -	chan = indio_dev->channels;
> -	for (i = 0; i < indio_dev->num_channels; i++, chan++) {
> -		if (!test_bit(chan->scan_index, scan_mask))
> -			continue;
> +	for_each_set_bit(i, scan_mask, iio_get_masklength(indio_dev)) {
> +		chan = iio_find_channel_from_si(indio_dev, i);
> +		if (!chan)
> +			return -EINVAL;
>  		if (chan->scan_type.storagebits == 32)
>  			*tx++ = cpu_to_be16((chan->address + 2) << 8);
>  		*tx++ = cpu_to_be16(chan->address << 8);

