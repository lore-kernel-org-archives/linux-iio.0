Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793071147;
	b=Rdjre3dmbIjMhHY6bgEXy+5wcu9C5M7p57fpNQ3YE0gzUHrJO8wrRISHienrSALzLEbK
	 cmltHu7Hlejmu/kK3rddEuMq8Jq3c7bLpHcFuUonAFc0BLNHpItUXE36wyEQpQV+5QEL7
	 BLRoAFJY8We4xPFHrNA6zLgkFIgO+iWNHInlA4ejFHqimlgklhiovbQa8CeF8E/B1QsPi
	 SvjRMAmj3Gs/iJ167rKT/CbKLh7QqdOKi/9gywY1F1ERPcjlBoMBTpjHJouD9TSHVFbPz
	 JFza8DVT9XjTHmhbNh3pxkYNFA9dU+KsdqmvRYabjDtBg3AJODWQa/Z7hWvmxt/IpnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793071147;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=izAlUOy0reOKcb/qt5CmSyq8SKxX32qVrxwpktK3QGQ=;
	b=KZYAkH064nXPqmvoHR7/cMGO9GpMn8D8vMtsLmgGoRM1wgPup5bTLwds2MOQ6QI4MgqK
	 8azC4ErFBJxoY3jINbk6eTuueP7pnCzO7FJBjpBYdnF9DfbSnpozZSV7VvfwA8c1G9lVo
	 u0HqH3o7ckMtB738tcRLs2wp17/0R5a2eCkSLzdlcxebH6BSNo7R3KK6Zc9og5GWMYvC5
	 GwrM0nLku++eNCk1Kb9CfUp0EcI1K3jDp8xIOzMV0sXP4q2tLk+uiEPhMdDjBbkl70ETm
	 T6OHQztQxm2ivJYv3hzMu1f3OWLrWSfuqGMvlADSljyYqi0fHuFjhO+uuP6ZMbNHM0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hf8aeQww;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355F5606A31D
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 03:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hf8aeQww
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A389D1F01825;
	Tue, 27 Oct 2026 03:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793071146;
	bh=izAlUOy0reOKcb/qt5CmSyq8SKxX32qVrxwpktK3QGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hf8aeQwwiECP688w1qsQoK8MUOy68Ot1iUeFgwWtKsj+1tPCOMyYqah6LILzOWN2W
	 i6pM69KqeGSLL09pctkR3fbNHjr9a6Zf5U/8G0Vtq4XVC42xA64eMlFioDIVsCvwD0
	 frUORJm0PMz9YEUzM7TKzt39E3n62Ctn1BgM5AagHfMiIDHvKD0MEtLPr2oFHDbi+n
	 gKRHB3Bf8DYraJYwM0IYeGOzObxsekHQirkGDXyps1BXjkml30/D2yOqhkpGQCN2rz
	 rqaHrcNeHuaVE2WX6pYEKFxxkdk63i8GW2c5KHbu+w7k+KqdsFdgPEewMVaeRqVeXP
	 U/SgBO7ZX0HLQ==
Date: Tue, 27 Oct 2026 03:19:03 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Cheng-Yi Chiang <cychiang@chromium.org>,
	Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 36/39] iio: common: cros_ec_sensors: use
 iio_push_to_buffers_with_ts()
Message-ID: <auAYJyyHq0_Hdv8r@google.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
 <20261026-iio-v1-36-8b136778eedf@oss.qualcomm.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-iio-v1-36-8b136778eedf@oss.qualcomm.com>

On Mon, Oct 26, 2026 at 04:05:54PM -0700, Jonathan Cameron wrote:
> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
> at both call sites.
> 
> Replace the raw samples byte array with a scan struct containing the
> channel data and an aligned timestamp, matching the layout it was
> already manually maintaining and removing the need for the
> CROS_EC_SAMPLE_SIZE size calculation and the casts used to access it
> as an array of s16.
> 
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

The patch looks good to me.  Just a minor note below.

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
...
> @@ -192,19 +191,17 @@ int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
>  	if (!iio_device_try_claim_buffer_mode(indio_dev))
>  		return 0;
>  
> -	out = (s16 *)st->samples;
> -	iio_for_each_active_channel(indio_dev, i) {
> -		*out = data[i];
> -		out++;
> -	}
> +	j = 0;
> +	iio_for_each_active_channel(indio_dev, i)
> +		st->scan.channels[j++] = data[i];

This is a pre-existing issue, but there is no bounds check on `j`.  I'm
not sure if the number of active channels can ever exceed 4.
