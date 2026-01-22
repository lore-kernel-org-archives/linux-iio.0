Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963A8225A35;
	Thu, 22 Jan 2026 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769109184; cv=none; b=XzbiFocvGgakrfmimID6mWe1xWs4N1ucKUNLsyjTNQyr4bAwHi0T9UylotWYUnoFTpLCyCCX2bIZWAqcxoPl8oogB7jtMQg4tt5vHefB0I6wLWMG/J8TxQZ+3Qa7E9ZtCCO0w74e/sq/mvQSngm7wqTMGkT/2dhmfTdu7pQgde0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769109184; c=relaxed/simple;
	bh=s8StBZTiw1xRcpnDWfw7Nii1uuXJlUKEnjWgKjjqA6o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ae8GlByX0A6TlkBIkzvS4I/drzPe/6SMBh1f9btrhEeyqpfLMRQdU2FRw7ojbg0bbZl8ghcq0Vlk2WgWYZv3/JZlHeoxWQPD1UH7i2O/80Z5sVb4v4NiOQPwLvbHEPUHnSCIqAYwrTuPFRt4LVJo9F/daGa+5WXM/4S0e/8a+aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=to9Y6l3g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="to9Y6l3g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87532C116C6;
	Thu, 22 Jan 2026 19:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769109183;
	bh=s8StBZTiw1xRcpnDWfw7Nii1uuXJlUKEnjWgKjjqA6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=to9Y6l3gz1+qv5d585Ij6dE+X9dFzdhOrDLqHzXrPMd1rXXQIyqGPggKDGKw8CwF+
	 negwkASiStUyhDUubLXy/shdywsrCeueIL82BWdR0+u3vXafqoj/oDdTvqiHk0S3a+
	 2RV1uqzQ9j51tl/3J4PRRMQFg/4NpItBs4o2zoJZQChLiqX9tkF/MaIODehW8Ye6qk
	 uw2k2RsdzZ85mb3/4weYJbOH1M5JniLYIopgqdiw/rAy9eikHKWGEGc/Y9FKXdJBEc
	 Vxha33ZIr1ANtJXa2uBLg1VVm/9QDBmQPWk3kM6n/zfeX4FUCT4h9Hb6gtnCfqbXYl
	 h11j5IJ1Z3O2A==
Date: Thu, 22 Jan 2026 19:12:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Benson
 Leung <bleung@chromium.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>, Shrikant Raskar
 <raskar.shree97@gmail.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Guenter Roeck
 <groeck@chromium.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev
Subject: Re: [PATCH v5 5/7] iio: light: vcnl4000: Use IIO cleanup helpers
Message-ID: <20260122191252.320750d4@jic23-huawei>
In-Reply-To: <20260120-lock-impr-v5-5-d4d22347041f@gmail.com>
References: <20260120-lock-impr-v5-0-d4d22347041f@gmail.com>
	<20260120-lock-impr-v5-5-d4d22347041f@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jan 2026 01:20:45 -0500
Kurt Borja <kuurtb@gmail.com> wrote:

> Use IIO_DEV_ACQUIRE_DIRECT_MODE() helper to automatically release direct
> mode.
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Given sparse doesn't play well with this stuff, this is (I think) more or l=
ess expected.
drivers/iio/light/vcnl4000.c: note: in included file (through include/linux=
/iio/buffer.h):                                                            =
             =20
./include/linux/iio/iio.h:687:20: warning: context imbalance in 'vcnl4010_r=
ead_raw' - different lock contexts for basic block                         =
             =20
./include/linux/iio/iio.h:687:20: warning: context imbalance in 'vcnl4010_w=
rite_raw' - different lock contexts for basic block                        =
             =20
./include/linux/iio/iio.h:687:20: warning: context imbalance in 'vcnl4010_c=
onfig_threshold' - different lock contexts for basic block  =20

Hopefully it will one day catch up or we'll move to an alternative for lock=
 checking.

J
> ---
>  drivers/iio/light/vcnl4000.c | 49 ++++++++++++++++----------------------=
------
>  1 file changed, 18 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 4dbb2294a843..a36c23813679 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -1078,20 +1078,17 @@ static int vcnl4010_read_raw(struct iio_dev *indi=
o_dev,
> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -	case IIO_CHAN_INFO_SCALE:
> -		if (!iio_device_claim_direct(indio_dev))
> +	case IIO_CHAN_INFO_SCALE: {
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
>  			return -EBUSY;
> =20
>  		/* Protect against event capture. */
> -		if (vcnl4010_is_in_periodic_mode(data)) {
> -			ret =3D -EBUSY;
> -		} else {
> -			ret =3D vcnl4000_read_raw(indio_dev, chan, val, val2,
> -						mask);
> -		}
> +		if (vcnl4010_is_in_periodic_mode(data))
> +			return -EBUSY;
> =20
> -		iio_device_release_direct(indio_dev);
> -		return ret;
> +		return vcnl4000_read_raw(indio_dev, chan, val, val2, mask);
> +	}
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		switch (chan->type) {
>  		case IIO_PROXIMITY:
> @@ -1148,36 +1145,27 @@ static int vcnl4010_write_raw(struct iio_dev *ind=
io_dev,
>  			      struct iio_chan_spec const *chan,
>  			      int val, int val2, long mask)
>  {
> -	int ret;
>  	struct vcnl4000_data *data =3D iio_priv(indio_dev);
> =20
> -	if (!iio_device_claim_direct(indio_dev))
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
>  		return -EBUSY;
> =20
>  	/* Protect against event capture. */
> -	if (vcnl4010_is_in_periodic_mode(data)) {
> -		ret =3D -EBUSY;
> -		goto end;
> -	}
> +	if (vcnl4010_is_in_periodic_mode(data))
> +		return -EBUSY;
> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		switch (chan->type) {
>  		case IIO_PROXIMITY:
> -			ret =3D vcnl4010_write_proxy_samp_freq(data, val, val2);
> -			goto end;
> +			return vcnl4010_write_proxy_samp_freq(data, val, val2);
>  		default:
> -			ret =3D -EINVAL;
> -			goto end;
> +			return -EINVAL;
>  		}
>  	default:
> -		ret =3D -EINVAL;
> -		goto end;
> +		return -EINVAL;
>  	}
> -
> -end:
> -	iio_device_release_direct(indio_dev);
> -	return ret;
>  }
> =20
>  static int vcnl4010_read_event(struct iio_dev *indio_dev,
> @@ -1438,14 +1426,13 @@ static int vcnl4010_config_threshold_disable(stru=
ct vcnl4000_data *data)
>  static int vcnl4010_config_threshold(struct iio_dev *indio_dev, bool sta=
te)
>  {
>  	struct vcnl4000_data *data =3D iio_priv(indio_dev);
> -	int ret;
> =20
>  	if (state) {
> -		if (!iio_device_claim_direct(indio_dev))
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
>  			return -EBUSY;
> -		ret =3D vcnl4010_config_threshold_enable(data);
> -		iio_device_release_direct(indio_dev);
> -		return ret;
> +
> +		return vcnl4010_config_threshold_enable(data);
>  	} else {
>  		return vcnl4010_config_threshold_disable(data);
>  	}
>=20

