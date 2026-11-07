Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794078414;
	b=v1QB/Ks+9/vAcHtPQobIOIM/GvNULjx+90QizL6LE+jLkZ7rlt+NFh2BTi7QjErWPU9N
	 PM6z4zalz6DK3Y3KSFQsRYm9YskAYqtEGOQVmthqa8VIXCh4ZKEDHFvllxeDOW9TU68YC
	 hKvjfwCfuH8U1af/nj1sEkNSOywoeDE/xTkr6plTvl14OSa8lICpdU20TSCo4Sgm+XZ9f
	 gPFSKsF4jxRxS9yNpdMK9304bFGaOHwOXYHWKi0peHIruWCHWhdE2XBdPHn72Wn+QnkdY
	 Xlt+QH0V0GDrhSujPzxJeV3sVQ5WA7V8lA/yLp5mYd7gk6BWD+sKWmeuRjc331DdxLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794078414;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VIYjp1wmNavcNgbonukUegdtGGvEbio4bmblQ7wRVsI=;
	b=nt1nESWotp+gZzpSgaKtbZQ2pljK9qV7pv/We0326yy/f2uzr2tOEGYc9twfw2dRQy18
	 MnYs1dYv3L/BDpCUL8+7Z0Y6QwHDPrs7HuTCtQ4+YXLLYCcNJH2lZ1DGvif2evCOiWVFV
	 fDZPZtOwBsYzUGb1qMUyF4p3XU/AKHcKv2zxDv+KvRzwOHZGoj5aSaxVGrPPYhgitrYZU
	 C2Id/uswWV0Bnq8zhrFu5/2iG6Fts/k1iN7QrdOklu9EyR/u45Cf1XSSyy59d+UuxSEpF
	 A6KCmwSmtRrZgwbHWEudie6ynz1mwHsu40Q/GzC15WZqbOKCb1+yWwHnzZJbtoVXufA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRQQWdUe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC109606A326;
	Sat,  7 Nov 2026 19:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRQQWdUe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8251F0089F;
	Sat,  7 Nov 2026 19:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794078413;
	bh=VIYjp1wmNavcNgbonukUegdtGGvEbio4bmblQ7wRVsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VRQQWdUems5bGs++C7Yqsj4CddHbcd5ZrFj/rvaD3nfVXDQaxe82zEPYpZUkEzwR/
	 Jnb/9ewjljaL9MNPxLUHBS5cceE4wGc33aGr55y/OdFeI/rKvJGiiGgsZbBdSyWXLh
	 6OjEBX046hR+pM/0afZXoe+saWR2ZBK0XUcLnKrtiqi93qKJZy8Qe9rVfCA9SVuBZa
	 wAYi/Q6n7xDLMnKiYwnoKn152GEBVbpcV2VlSQ0teinso4XADm3q3mXCmZ5JQ9ddAA
	 ObxZQNx0FI7srnkApWxaKwzdvC7j6pLjMEp7YpcqfC4IEuH9/WakK1SOCf8tT0Rm8g
	 cE2UFcYguP9dQ==
Date: Sat, 7 Nov 2026 19:06:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Gwendal Grignou <gwendal@chromium.org>,
 Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: proximity: sx9310: reject unsupported hardware
 gain values
Message-ID: <20261107190645.403d5556@jic23-hlaptop>
In-Reply-To: <20261107111710.442318-2-kapoorarnav43@gmail.com>
References: <20261107111710.442318-1-kapoorarnav43@gmail.com>
	<20261107111710.442318-2-kapoorarnav43@gmail.com>
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

On Sat,  7 Nov 2026 16:47:03 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> sx9310_write_gain() passes any value from userspace to ilog2() and then
> FIELD_PREP() into the 2-bit gain field without checking it. Only gains
> of 1, 2, 4 and 8 are supported (and listed in hardwaregain_available),
> but other values are not rejected; they are silently changed:
> 
>   - 3, 5, 6, 7 are rounded down to the next power of two;

There is nothing in the ABI rules that says a driver should not round these
values.  So whilst I don't mind a specific driver not doing that I'm not
sure we should modify the ABI of a driver to start rejecting them after
it has been out there for a while.  The only key thing is that value
read back after a write reflects the true scaling.

>   - 16 and larger wrap around in the 2-bit field, e.g. 16 sets a gain
>     of 1 and 32 a gain of 2;
>   - 0 and negative values set the maximum gain of 8, because ilog2(0)
>     is -1 and a negative int becomes a large unsigned value.

These two improvements are good and unlike rounding behaviour setting (including
reasonable rounding down to 32 - so anything that would not otherwise be 64) an
out of range scale or 0 / negative are not things correct userspace should
be doing.


> 
> The write returns success in every case, so userspace cannot tell that
> the gain it asked for was not applied.
> 
> Return -EINVAL for anything other than 1, 2, 4 or 8.
> 
> Fixes: 227c83faa2f8 ("iio: sx9310: Support hardware gain factor")
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> ---
>  drivers/iio/proximity/sx9310.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 2585b9c6fb69..27b5d604a409 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -665,6 +665,9 @@ static int sx9310_write_gain(struct sx_common_data *data,
>  {
>  	unsigned int gain, mask;
>  
> +	if (val <= 0 || val > 8 || !is_power_of_2(val))
Upshot of above is check for <= 0 here.
> +		return -EINVAL;
> +
>  	gain = ilog2(val);
and check this fits in the field.  FIELD_FIT() will link that
explicitly to where it is being written. That only works here
because all the values that fit are valid (I think!)

Jonathan

>  
>  	switch (chan->channel) {

