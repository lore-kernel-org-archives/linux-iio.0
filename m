Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3BB28373;
	Mon, 17 Aug 2026 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786929438; cv=none; b=DKFIKvkPbW4ysPXiju+wlDW+9NKzMTCLzehVvlpMDjmwWCdg0U2GYeVq32vkupGc8O7I+Zzob0FdZztKT+8DOXFJROX17u2lvlGrzdibvy/A7OsY3a9a0hdiOpK0+RH4eQEs85tyuQN0vIywyVjwYkz8eygWMTuHvY9dL++4LnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786929438; c=relaxed/simple;
	bh=5QBY8NpjzgqhrOm/772Yu5s7603M/P1qcDrNxibi7zI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FcN+e5F0g0bOeo3UnICZjB5+JM7a1/AlKjeNc8mWJ+/dwz9KvsEqCCqUEq2qKyChggu4XZj4OIs8p8W2W+mrB6ZCbTVGTLxBDl/mfJA9wnhu9pTRhkvteGhUkQMuVj23LXYB+5hfJnK3z8vXg2c4oHhp2tn1eeXa8MTrnFJx2ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiAauyqA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiAauyqA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998801F000E9;
	Mon, 17 Aug 2026 01:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786929436;
	bh=CcZdEwerkvPIx1gdRvGibhKjxnhCAY47D29euYg69T8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MiAauyqAGpqHlUBfFjXlC9h7tTD7tHq3Xj38XEgG0+2ZERFZK20A6PHkFdjPC/vuw
	 kZWm6WnT1NUjBoq4+HJjGn5wmVTgcckLmpR9TeyD5LzBchbfJ6g7cF2voSJqX3KHCH
	 zpX7i3hcszFiW3w1EbZyq56TCqEqH8vAvVDBkvhxs8bTb5hC5KCX+tc2FNKLSGxEwX
	 NDFY5Sk8Qsy+pyNowGznt7oAA1HZFtc3Tgv4rROg/ohvy+5TrHBc1vjQJtNpwvkZCH
	 cQgqxVsKBkonxaYMBe6qBX9gauWCfLbJVKNTx2oci/FJzG9TvyuG5acGYVMOZzdteV
	 c7Zlv72BFcO6g==
Date: Mon, 17 Aug 2026 02:17:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, Mehdi
 Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>, Topi
 =?UTF-8?B?U29ua2Fqw6Rydmk=?= <sonkajarvi@hotmail.com>
Subject: Re: [PATCH 01/12] iio: adc: rohm-bd79124: Fix rising alarm
Message-ID: <20260817021711.149777d4@jic23-huawei>
In-Reply-To: <b38dd82c759db17796054b6847fd7f770be27efd.1786347811.git.mazziesaccount@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
	<b38dd82c759db17796054b6847fd7f770be27efd.1786347811.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 10:49:56 +0300
Matti Vaittinen <matti.vaittinen@linux.dev> wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The rising alarm is using the cached falling alarm value causing wrong
> value to be used.
> 
> Fix this by using the correct cached value for rising alarm.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: 3f57a3b9ab74 ("iio: adc: Support ROHM BD79124 ADC")
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/rohm-bd79124.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/rohm-bd79124.c b/drivers/iio/adc/rohm-bd79124.c
> index 864f3b1366b5..f703c74309cc 100644
> --- a/drivers/iio/adc/rohm-bd79124.c
> +++ b/drivers/iio/adc/rohm-bd79124.c
> @@ -525,7 +525,7 @@ static int bd79124_enable_event(struct bd79124_data *data,
>  		return ret;
>  
>  	if (dir == IIO_EV_DIR_RISING) {
> -		limit = &data->alarm_f_limit[channel];
> +		limit = &data->alarm_r_limit[channel];
>  		reg = BD79124_GET_HIGH_LIMIT_REG(channel);
>  	} else {
>  		limit = &data->alarm_f_limit[channel];

