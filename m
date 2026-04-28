Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EB444B67E;
	Tue, 28 Apr 2026 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392582; cv=none; b=DCfZyMmBsCx8VeUl6/T8MBVUED9GnvrXMH45+QCiP4O3kOlE6eM8tYpoW43XQ3TkCjCmMGLXJfDl08urokoOT96dWu2Kl9AORMGpHj2kFwDFRmtxEUZFA0JpiwwygBZk8Za5mXh9k/dH/ljAL+TwjM/MuckCF8YSiAnTNu0Ko3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392582; c=relaxed/simple;
	bh=NMCdntPrzwWMEYhbF68r/CUkWpbbMlQQ+Na88Lpwpg4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDqTudyeSul2NQANUpKzKIOqP6EzK1cURedZ6u4UlAuV4sevYR3sBA0SCJaxqrGHhE+rZQN9vZix+Qkj10fuK+uXRz4a3oxSD8Xg/igaW08zaZTAZunvIets9RncHuC7i5QmQ5pVU0JyMDq6a7U7guTzFR5/Kk2EEO2G8Vrw9NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNXy0e3P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNXy0e3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96056C2BCAF;
	Tue, 28 Apr 2026 16:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777392582;
	bh=NMCdntPrzwWMEYhbF68r/CUkWpbbMlQQ+Na88Lpwpg4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FNXy0e3P1WQyR6Pl5cW+WS7sU0Kql8FFE81jR+vUlhlszEco3BiYaVACsTybXDN0W
	 gio1jEq3f+6FuNuS+btz2wT9CiEy4aDyOmn5QD0Q8b0EyUQeb/pfDpuCKzgFBWPFBr
	 /rqwkFi6EUcGrKo5t+QkXd1mjxijXSNkqD+NjF6H/wAkuVULKeekvdz0LrOzszPW/k
	 tk4TuO/71UaIsdwzlyBMoX4pf3WHCZ4IuwRwonpH5K8ZI0v9R0Z6JPhHT4l0BEaGEy
	 jxB18tZloHxUC99YtopofSmcroq+ix1bozGFxY5jFMUCeoWYmIP8Cpq5IMbOd1xeGg
	 +d0Rmlhv9T0Dw==
Date: Tue, 28 Apr 2026 17:09:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4] iio: adc: mt6359: fix unchecked return value in
 mt6358_read_imp
Message-ID: <20260428170933.36bc8a17@jic23-huawei>
In-Reply-To: <20260427201238.20823-1-salah.triki@gmail.com>
References: <20260427201238.20823-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 21:12:38 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> In mt6358_read_imp(), the variable val_v is passed to regmap_read()
> but the return value is not checked. If the read fails, val_v remains
> uninitialized and its random stack content is subsequently reported
> as a measurement result.
> 
> Initialize val_v to zero to ensure a predictable value is reported
> in case of bus failure and to prevent potential stack data leakage.
> This also satisfies static analyzers that might otherwise flag the
> variable as used uninitialized.
> 
> Fixes: 3587914bf61 ("iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>

Applied and marked for stable. Risk of this occurring is very low, but
the risk of the patch causing trouble is effectively zero so I'm fine
with this being backported.

Thanks

Jonathan


> ---
> Changes in v4:
> - Move val_v initialization just before regmap_read() call as suggested 
>   by Andy Shevchenko to improve maintainability.
> 
> Changes in v3:
> - Initialize val_v to zero at declaration instead of checking regmap_read()
>   return value, as suggested by Jonathan Cameron and Andy Shevchenko.
> - Update commit message to reflect this new approach
> 
> Changes in v2:
> - Added Fixes tag.
> - Re-examined the entire driver for unchecked regmap operations.
>   While several regmap_write() and regmap_set_bits() calls also ignore
>   return values, I focused on this specific regmap_read() in
>   mt6358_read_imp() because it leads to an uninitialized variable usage
>   (val_v). This makes this fix critical for reporting correct data
>   to userspace
> 
>  drivers/iio/adc/mt6359-auxadc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
> index 6b9ed9b1fde2..1d9724ef0983 100644
> --- a/drivers/iio/adc/mt6359-auxadc.c
> +++ b/drivers/iio/adc/mt6359-auxadc.c
> @@ -497,6 +497,7 @@ static int mt6358_read_imp(struct mt6359_auxadc *adc_dev,
>  		return ret;
>  
>  	/* Read the params before stopping */
> +	val_v = 0;
>  	regmap_read(regmap, reg_adc0 + (cinfo->imp_adc_num << 1), &val_v);
>  
>  	mt6358_stop_imp_conv(adc_dev);

