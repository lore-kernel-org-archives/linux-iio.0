Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795839403;
	b=ODOhbMTyf1KepMp3RBpcbyXppjXqPQ8vi/nDMyWf7xKRHL8mXzo4YBxb6niOEj2l0PhZ
	 9HVZeRhGrrMkvhdtaAPEBd3cL4dTPgtG3UUkJwUYEqy41GJ3yR0Z10vR2NkROzsetZsbd
	 TVn325qraXMgxu2V9x9QwuLKFNxJZi2ISNC+k2CYY4eWjxAooDZ4lPSBlRTbYyA8LpRH3
	 Nnnw1nsx0plVFr76TDTNUH3uuOltGWVHoo8bCZbrtlxnfuQSUuIMYjZv/W3KO37/M5lrn
	 zPR9msoS/3RwRZkrVA65kxH/GSO0NHNhzAHxGj0JhSIDYxjCLjs8a9Ht4yQsCgB72wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795839403;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ioyn5RhrPNY21LncaCMMS1+0/zyLFVxeFv1Zo6OoAW0=;
	b=Qd0XtT93wVbiN0f0VYucuyRlgp4z6xxLIMG2ZRZClKT3XsAH+qlpxI1LyIzi/maiU9Kp
	 +8LQgJ87crH4RdDg6o77WojO7JSvhK3TxQ6wGKJm/C/pxtmMiCbwc60VxYnD0Nf/qHnEm
	 Fwee5+hFIq/FHxmuShqRo3QHqgidYaTeI68ceY910DvyC4wi/mz3i1Jq8cfW8Ps+nbufG
	 cIL5QRJgqL4y5W6m05YKX7alt5zfzHkXvJWC6V5s/qddWmJexzfBzbduZnoW5RmYdbln0
	 eczWnjpuBg+0TpDE267ltSiTnuxKfCoq4oxRajaPXukMMnArZbynWJuAzvaASGErZmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fdV6zSrq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E10E606A31C;
	Sat, 28 Nov 2026 04:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fdV6zSrq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E301F00893;
	Sat, 28 Nov 2026 04:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795839402;
	bh=ioyn5RhrPNY21LncaCMMS1+0/zyLFVxeFv1Zo6OoAW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fdV6zSrqM79O0OpC0Ss/fdBHcgNMnEjPrgVA4FQn7c+YHheZs82VwLHKOgjE+sPj/
	 hLdIQOHEu+7B2KrxCbj6CXWZ/IoWNr9lMpTAq3iif0zanZKt+3JT3DiyrQKyolSC/0
	 vjwQTHcqhG+TR2OBvQTbmFh9V9w3n9htyBDjUqGlv7g6yzAeW9AIeqa9IpxBYN8OvV
	 vu1sNuLnO8ihopuajH4fQ5k/UgSrys8D/FVzv8GUfN3zdEy0pjTzp3xfH2TQ1MAuNs
	 MpjJVFvSY5yX+srf9qyAwCttG83ec1KYR926q2GkecO8wy3g2w3ZGu4LLhCZnSOskb
	 Jxlx/EKSjho/A==
Date: Sat, 28 Nov 2026 04:16:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Wang Shuaijie <wangshuaijie@awinic.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: proximity: aw96103: reject out-of-range
 debounce and hysteresis values
Message-ID: <20261128041635.418f3808@jic23-hlaptop>
In-Reply-To: <20261126053033.603086-5-kapoorarnav43@gmail.com>
References: <20261126053033.603086-1-kapoorarnav43@gmail.com>
	<20261126053033.603086-5-kapoorarnav43@gmail.com>
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

On Thu, 26 Nov 2026 11:00:28 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> The debounce (OUTDEB, INDEB) and hysteresis (THHYST) settings are 2-bit
> fields of PROXCTRL. aw96103_write_event_val() passes the value through
> FIELD_PREP() without checking it, which masks it to the field, so an
> out-of-range value is silently written as a different one: 4 becomes 0
> and -1 becomes 3.
> 
> Return -EINVAL for values outside 0..3. Both debounce fields have the
> same width, so one check covers the two directions.
> 
> Fixes: 07b241262dca ("iio: proximity: aw96103: Add support for aw96103/aw96105 proximity sensor")
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> ---
>  drivers/iio/proximity/aw96103.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
> index b4aa31a65369..24557a8f764d 100644
> --- a/drivers/iio/proximity/aw96103.c
> +++ b/drivers/iio/proximity/aw96103.c
> @@ -401,6 +401,9 @@ static int aw96103_write_event_val(struct iio_dev *indio_dev,
>  		return regmap_write(aw96103->regmap,
>  				    AW96103_REG_PROXTH0_CH(chan->channel), val);
>  	case IIO_EV_INFO_PERIOD:
> +		if (val < 0 || val > FIELD_MAX(AW96103_OUTDEB_MASK))

Maybe just use FIELD_FIT()?  I think that should cover all eventualities?

Jonathan

> +			return -EINVAL;
> +
>  		switch (dir) {
>  		case IIO_EV_DIR_RISING:
>  			return regmap_update_bits(aw96103->regmap,
> @@ -417,6 +420,9 @@ static int aw96103_write_event_val(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		}
>  	case IIO_EV_INFO_HYSTERESIS:
> +		if (val < 0 || val > FIELD_MAX(AW96103_THHYST_MASK))
> +			return -EINVAL;
> +
>  		return regmap_update_bits(aw96103->regmap,
>  					AW96103_REG_PROXCTRL_CH(chan->channel),
>  					AW96103_THHYST_MASK,

