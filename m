Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D666637EFF9;
	Thu,  4 Jun 2026 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569777; cv=none; b=WESI79ti2R00fEXqo7+UViftTSjQ/mlks28gevLdAGwCbrUEl87VtFKQGBpND0kxQKsGaTMfKtlsGlOB3Doct0Kk9ZluYF1r0RSdge2RKXvblbXRDoiwEbVvo5NoT5kBiZTsd6QlotVpVQYPz+1QyeCu3YggTzSYE5rBSANZtZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569777; c=relaxed/simple;
	bh=W/ZoxX/Jwu2Ztq4ah3ps14Rmca1QIszABtBDW1GI4uw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twqgJBfWLl1yILc7Lpqtc5P3vHOiEJ5dgIht7H+t8eCJcyb4duuyxN6tDbwcJhmgsHdnMf6FmB5mnYUGsz+JkVIrS5mEp3M+OqAYDLEzVg8BupcQgsA7ZN/m2F17/yjHTre9PseLEQw1bmi1rVVuW9yb0i/hsEMGuhA73LUdGH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4Oz+tRU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4Oz+tRU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3762A1F00893;
	Thu,  4 Jun 2026 10:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780569776;
	bh=vgDazCCMRyTee16fiBKqlVntuEd5XwEDoAvtziv7/Ho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h4Oz+tRUAQ3jcCRhRGYVlr+egINwiHWCslpotFVCxHnv/scGfk8nb3r4+BxRJOIdG
	 +R9l+j9eHezIhiQqk4Kt+6U6KXu/vZ2orhXn9vbXcVZtIW3M5KtvAYCuV2Xvhel5Xu
	 RAK0bKqy4gVizgvqHfvHecvqcv7YFSpc1zdL9qD+q0225/O9/JnKBm+DnXvZ8PHJlt
	 9eeEy4awwXs8OlXrEXe+vMkI2QDrU191C7BxT/Zo0ZX9u3ZGEhEmWpHQhMdvvRbivq
	 gWi20mLHz3seLlnF9+ZSKVZTHkb4SBvhqOt+OpbyU0liV+MxJGn11f8pZ8e4Ttv/Ej
	 mVbcQq/byjTYA==
Date: Thu, 4 Jun 2026 11:42:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 shuah@kernel.org, joshua.crofts1@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3 8/8] iio: tcs3472: implement wait time and sampling
 frequency
Message-ID: <20260604114250.3fb62d93@jic23-huawei>
In-Reply-To: <d82b27d8-4e0e-4749-bea7-a09f43554fb2@gmail.com>
References: <20260522123420.45495-1-aldocontelk@gmail.com>
	<20260522123420.45495-9-aldocontelk@gmail.com>
	<d82b27d8-4e0e-4749-bea7-a09f43554fb2@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 10:10:02 +0200
Aldo Conte <aldocontelk@gmail.com> wrote:

> On 22/05/26 14:34, Aldo Conte wrote:
> > @@ -196,15 +359,29 @@ static int tcs3472_write_raw(struct iio_dev *indio_dev,
> >   		if (val != 0)
> >   			return -EINVAL;
> >   		for (i = 0; i < 256; i++) {
> > -			if (val2 == (256 - i) * 2400) {
> > -				data->atime = i;
> > -				return i2c_smbus_write_byte_data(
> > -					data->client, TCS3472_ATIME,
> > -					data->atime);
> > -			}
> > -
> > +			if (val2 != (256 - i) * 2400)
> > +				continue;
> > +
> > +			data->atime = i;
> > +			ret = i2c_smbus_write_byte_data(data->client,
> > +							TCS3472_ATIME,
> > +							data->atime);
> > +			if (ret)
> > +				return ret;  
> 
> Hi Jonathan,
> 
> Two questions on the INT_TIME case in tcs3472_write_raw() before
> I send v4.
> 
> - The compute/write/commit pattern issue you raised elsewhere
> also applies here. I plan to swap the order: write first with i
> 
> return i2c_smbus_write_byte_data( data->client, TCS3472_ATIME, i);
> 
> then update data->atime only on success. OK?

Yes. That's conventional way to do it as ensures the cache reflects
the most likely state (fails that don't write are probably slightly
more likely than fails that do).



> 
> - Sashiko flagged a race ( 
> https://sashiko.dev/#/patchset/20260522123420.45495-1-aldocontelk%40gmail.com ) :
> target_freq_hz/uhz are read without
> the lock and then passed to tcs3472_set_sampling_freq() which
> takes the lock internally. Two options:
> 
> 1)  Take the lock briefly in write_raw() to write ATIME, update
>      data->atime, and snapshot target_freq_hz/uhz. Then release the
>      lock and call tcs3472_set_sampling_freq() (which takes the lock
>      again internally). Minimal change, but ATIME and WTIME updates
>      are not atomic with each other.
> 
> 2)  Split tcs3472_set_sampling_freq() into a public wrapper that
>      takes the lock and a __tcs3472_set_sampling_freq() helper with
>      the lock already held. Then in write_raw() take the lock once,
>      write ATIME, and call the helper. This keeps ATIME and WTIME
>      updates atomic.
> 
> In these cases, what is used to do?

2 is cleanest solution so do that.


> Thanks,
> Aldo
> 
> > +
> > +			/*
> > +			 * ATIME just changed, so the cycle time changed too.
> > +			 * Re-run the sampling frequency logic to recompute
> > +			 * WTIME and preserve the user's last requested
> > +			 * frequency.
> > +			 */
> > +			return tcs3472_set_sampling_freq(data,
> > +							 data->target_freq_hz,
> > +							 data->target_freq_uhz);
> >   		}
> >   		return -EINVAL;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		return tcs3472_set_sampling_freq(data, val, val2);
> >   	default:
> >   		return -EINVAL;
> >   	}  
> 
> 

