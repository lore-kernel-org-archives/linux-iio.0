Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC760221F39;
	Mon, 17 Aug 2026 01:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786930556; cv=none; b=d/VqmAdG0iqAQjHdDqd4kiwJMBeim3fVfQAiVgONPrEKhFYx8nHplI1mQgKa5Rfkduoy2XVqV+uyzQe0zx/bhTuN2Ac5rR+ViSkjYzG5ii5CY5LQSJBU6LfOM2pSgOUY5SPSbmxcciF9R4R2iObFw602U3Ak161tU9+Q346Awxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786930556; c=relaxed/simple;
	bh=6H/K/XdQY2ww/4EstFKhy52hKgigXKqFBvX7CJzIQsg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xc08Ch+gBZBBomqRV42F91Ra04Lv/JIzGke24cO3YDuHrzegGzwWlY1lDsK9GziVC/wjism6ch3QLVmw/d6/iqXE7nXrBuApv3MRhzxIMH6dOjfzAt3cCvk5D/mY4TGakYtmzyyfRiOFRwd7IcQlVfb/+iNUwnW577efB/+cwNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHgb7AIb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHgb7AIb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C251F000E9;
	Mon, 17 Aug 2026 01:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786930555;
	bh=hdctLFWGDhsL9CZx2qzbLRC7qAxPcCLbzUHP2LnYSX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GHgb7AIb9kGylimllhSh+1NQPdfwnr97BTY7Vw3cfrmiLAnrOPP+VHcJ/ey5VqvNp
	 uVIPPmntpMdjNCrXkj23URsacMLmZyRvXT5Niu0DPcQ+d6PGwNHthuZWt/3FJOpgZ0
	 RjQ+bGKFiolXFa97NCxBTpTVEk5O/6txcx/VfcQbWrYDWuJBFIy5+TewGg8YgqTPpx
	 zSkOp1AtcAsrpbgrXXFURIMwhFwpOqryhRI5u4BJE5Sd9ac4coop7UwZrtkZ/RQaNK
	 J372veEdbj2TMc28HSSenq7aaaWAZWjZfJVk6o7meEMwna0agAW2NJzvO8TmgNs0iu
	 ZWl2flm9eOTgg==
Date: Mon, 17 Aug 2026 02:35:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, Mehdi
 Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>, Topi
 =?UTF-8?B?U29ua2Fqw6Rydmk=?= <sonkajarvi@hotmail.com>
Subject: Re: [PATCH 08/12] iio: light: rohm-bu27034: Fix error return
Message-ID: <20260817023548.75940431@jic23-huawei>
In-Reply-To: <bfe7f9146960bf0fffb3ce09a14e7912394f5ad8.1786347811.git.mazziesaccount@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
	<bfe7f9146960bf0fffb3ce09a14e7912394f5ad8.1786347811.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 10:53:35 +0300
Matti Vaittinen <matti.vaittinen@linux.dev> wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> When BU27034 fails to read gain value at integration-time setting, it
> returns 0. This leaves caller unaware of the fact that setting the
> integration time failed.
> 
> Fix this by returning the relevant error instead of zero.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: 439c2cef8157 ("iio: bu27034: simplify using guard(mutex)")
Applied.

Note I skipped 7 until that discussion comes to a conclusion.

Thanks,

Jonathan

> ---
>  drivers/iio/light/rohm-bu27034.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27034.c
> index 28d111ac8c0a..f9a421618406 100644
> --- a/drivers/iio/light/rohm-bu27034.c
> +++ b/drivers/iio/light/rohm-bu27034.c
> @@ -415,7 +415,7 @@ static int bu27034_try_set_int_time(struct bu27034_data *data, int time_us)
>  	for (i = 0; i < numg; i++) {
>  		ret = bu27034_get_gain(data, gains[i].chan, &gains[i].old_gain);
>  		if (ret)
> -			return 0;
> +			return ret;
>  
>  		ret = iio_gts_find_new_gain_by_old_gain_time(&data->gts,
>  							     gains[i].old_gain,

