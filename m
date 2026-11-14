Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794696958;
	b=myw2Ix004ptrWrncHEYk+UWs2w5nP5wenkqS7PErIKcPXD1RrUTqetJMXVKg2iEtLRHh
	 0+zqmtUfKOm6Ug91XSoYYHREaE719TR0cS81ewyoQwUuTI4iTT6WC0t39JrGqrhjPgAUz
	 s19B+4e7BiLT9Nk9aw9GjqzCyroK10bSoFDGGsF59OkbI39mlu5J9JDfUZFn5UBmmnwjE
	 GxEd+WeNi9eHkiu0dECFFWJWbBFzuQY/dQv7ccaihQLUu9RPpdzTQNX+wXhgmKTDHpF2n
	 fMEWywC2Yzte9k6SkEh7KtVbH7wP0i56/fv62zzcwGGbjP1HgKxRLSoJYDHaoawVERw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794696958;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7Qrh9FYX6BFJk9/zdudMZppLx3PknQr/O5zXB8kIjIc=;
	b=rJsfUGLQVoxnSp6I8RdQS81Vg0FO1/mW2TSScEVybKwalbboBZZnigqMGV1I2fpbthXs
	 gMtlxD0+05a6eolWk6Y7zHCs2zmVCLvOWAVLfHSsX5gyp9QkSq+tlvoEUSKmZdpSOasQc
	 C3Nsd1jFrrfKpJKxcF4lUz2EUz+cI6TsSukeNb1KTix34OC4vdBgPzMJjWKzKaYpL+yBQ
	 0DlcoZEjXx5N0J8JCb+w/Pufivn6zjzF1pKH6W8+tHDgyyeH0IC+iKeNAvVzrDnilaDeT
	 8WKwpEXcqN280S6i2mCnHAK/g29GPWGo/xEy7Rsg8wtPkAvsd/c+qa52FPfgCy3Q23Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hee/g18r";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F88606A334;
	Sat, 14 Nov 2026 22:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hee/g18r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AD11F000C4;
	Sat, 14 Nov 2026 22:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794696958;
	bh=7Qrh9FYX6BFJk9/zdudMZppLx3PknQr/O5zXB8kIjIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hee/g18rbQXddlkTCoyqy7GL7WWR/ZuZ3MMRHiqUiDgAAl+j4a6C42CjYLMZuoVFc
	 MgMJ9Ud4feYhv3iK4SXSjzxv+gAlL+yFZEtRpZlHEswyyartAGbkcLTOXgkZ2N571u
	 Ga2wuML416zj67SpaS2nXhnvHMPKfF57QmfzJWSC4F3Q/DSph1FyXDVeVhz3FzRJbM
	 WKJibbmcc61jJqhR8KbvBubSmiw9mv06Em1zwCKHfQ3lrieb5hTBFJ91HKtuZd7MvR
	 VOMQ2u8yRPP1RVTeYOvz+7o5z1BlW+yRBLIM0PHgjEuzeMQPHeYCwBQOEFg0nUq8pJ
	 +tLXmzx35Ktmw==
Date: Sat, 14 Nov 2026 22:55:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Esben Haabendal <esben@geanix.com>, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, "Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>, Pan Chuang <panchuang@vivo.com>, Hemanth
 Selam <hemanth.selam@gmail.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Nikita Travkin <nikita@trvn.ru>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] iio: light: ltr501: Switch to read_avail() op
 from manual attribute registration
Message-ID: <20261114225549.003f9244@jic23-hlaptop>
In-Reply-To: <20261108094253.83899-2-clamor95@gmail.com>
References: <20261108094253.83899-1-clamor95@gmail.com>
	<20261108094253.83899-2-clamor95@gmail.com>
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

On Sun,  8 Nov 2026 11:42:50 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Switch to the read_avail() operation from manual attribute group
> registration. This eliminates the need for per-chip attribute_group
> structures and related ltr501_chip_info iio_info entries.
> 
> Adjust LTR501_INTENSITY_CHANNEL to account for the new
> info_mask_*_available layout, allowing the removal of _shared since all
> intensity channels share the same layout of available entries.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Sashiko caught the bug I noticed as well..
https://sashiko.dev/#/patchset/20261108094253.83899-1-clamor95%40gmail.com
> ---
>  drivers/iio/light/ltr501.c | 192 +++++++++++++++----------------------
>  1 file changed, 76 insertions(+), 116 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 302be2fc314c5..1ddd0dfd55ea2 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -133,6 +133,22 @@ static const struct ltr501_gain ltr559_ps_gain_tbl[] = {
>  	{0, 15624},
>  };
>  
> +static const int int_time_avail[] = {
> +	0, 50000,
> +	0, 100000,
> +	0, 200000,
> +	0, 400000
> +};
> +
> +static const int samp_freq_avail[] = {
> +	20, 0,
> +	10, 0,
> +	5,  0,
> +	2,  0,
> +	1,  0,
> +	0,  500000
> +};

> -static ssize_t ltr501_show_proximity_scale_avail(struct device *dev,
> -						 struct device_attribute *attr,
> -						 char *buf)
> +static int ltr501_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length, long mask)
>  {
> -	struct ltr501_data *data = iio_priv(dev_to_iio_dev(dev));
> +	struct ltr501_data *data = iio_priv(indio_dev);
>  	const struct ltr501_chip_info *info = data->chip_info;
> -	ssize_t len = 0;
> -	int i;
> -
> -	for (i = 0; i < info->ps_gain_tbl_size; i++) {
> -		if (info->ps_gain[i].scale == LTR501_RESERVED_GAIN)
> -			continue;
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06d ",
> -				 info->ps_gain[i].scale,
> -				 info->ps_gain[i].uscale);
> -	}
>  
> -	buf[len - 1] = '\n';
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_INTENSITY) {
> +			int valid_als_gains[ARRAY_SIZE(ltr559_als_gain_tbl) * 2];
> +			int j = 0;
> +
> +			for (int i = 0; i < info->als_gain_tbl_size; i++) {
> +				if (info->als_gain[i].scale == LTR501_RESERVED_GAIN)
> +					continue;
> +
> +				valid_als_gains[j++] = info->als_gain[i].scale;
> +				valid_als_gains[j++] = info->als_gain[i].uscale;
> +			}
> +
> +			*length = j;
> +			*vals = (const int *)valid_als_gains;

As sashiko points out you just passed out a dangling pointer to the stack.
So this never works.  Even without that, there are some rather badly handled
issues with consumers of read_avail and lifetimes.  We had some fixes about
a year ago but they never made it upstream and it's not currently high
priority for me at least to revisit.  Upshot is that we are much better
returning a pointer to pseudo const data.  Can initialise before registering
the device but after that we should only use pointers that remain stable
and not change the data so as to avoid potential tearing.

Given the reserved entries are in the middle, you'll need to stash a copy
of the array with them scrubbed out. Do that in probe and put it somewhere
in the iio_priv() structure

> +		} else {
> +			*length = info->ps_gain_tbl_size * 2;
> +			*vals = (const int *)info->ps_gain;
> +		}
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;
>  
> -	return len;
> -}
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*vals = int_time_avail;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		*length = ARRAY_SIZE(int_time_avail);
> +		return IIO_AVAIL_LIST;


