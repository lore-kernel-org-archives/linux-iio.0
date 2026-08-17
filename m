Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04431A6828;
	Mon, 17 Aug 2026 01:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786930482; cv=none; b=k4fsUa9qSMJiN/lD0nezgu+P28+7zHEBRgUGF22+Vv8n/HnwYHH/+RfyaNXRr3p4NC4ImHMEEtAMuSO/8egIIAsRMpj0EWFWBDvr+0AilN19AWWBQQHwHDTaXCCW3R9zlI7M/jlexvrETVQmQN8DzUOwQvZATJHDPm9TAj0psbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786930482; c=relaxed/simple;
	bh=YuAZcQO+zgynwGxo3l2gvESASF5xpj+ak3aXIXD0yds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YEGdl4kSr50mBA2MrVuA4mV8UMR3DhAcpR9cF4Wa5J/I4R7MfbPSDbaMljeQvpSY9Re44xQFkWx1yJ4ogj91VFDVZWglkUNL/R9BCAceL2zZHkYtVu2osFX+kgTaFHe91zCmFmMaIZhRFV4Er98t7fxEYQ/c9yuc4lmlr1s101g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtwWDid5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtwWDid5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D671F000E9;
	Mon, 17 Aug 2026 01:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786930480;
	bh=WaTeJLeJV2PQE/EXv/gEYDH0kSg7vqO3kBuZMgq2eps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gtwWDid5PNNxRqPMpi3UcQK8sp9oSk7bsyKvK2HJ7k8hJcv14tqt4WqNCmY4HxNZ8
	 qwDmyVU+s0CBQiTO19crOLhls3Xz1ZegNmznAGEl+IpW90bAKZGN7QX03u2WUAZCrz
	 7vaMXGGj+KnyCbTSYU3pxxL7ekw17I/CaSd5OIVG/rN/MVOpo7foPwpWY2y12Bp/8y
	 52ugYgxIPIstjCwK3B2rh7QYGnK2Ce0EVwH6tLFrObahqPCT0MJKp8uSd7D9eA+PCt
	 EVUwwmNKBPRLllcdaYWbuzATlBW8hCdSWkM/kfGsWk8CjdU2hNXvZ8UpGaeXSB4Lz7
	 WECgFObbT+qWw==
Date: Mon, 17 Aug 2026 02:34:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, Mehdi
 Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>, Topi
 =?UTF-8?B?U29ua2Fqw6Rydmk=?= <sonkajarvi@hotmail.com>
Subject: Re: [PATCH 06/12] iio: pressure: rohm-bm1390: Return error when
 read fails
Message-ID: <20260817023436.1cf2d10e@jic23-huawei>
In-Reply-To: <ba361c8c8405d5e4f9d94fe0ec34b6c316593472.1786347811.git.mazziesaccount@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
	<ba361c8c8405d5e4f9d94fe0ec34b6c316593472.1786347811.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 10:52:47 +0300
Matti Vaittinen <matti.vaittinen@linux.dev> wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The data reading function ignores the cached error value, and
> unconditionally returns 0. Return cached 'ret' -value after stopping
> the measurement so user knows if read failed and data is garbage.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: 534674463a59 ("iio: bm1390: simplify using guard(mutex)")
Applied.
Thanks,

J
> ---
>  drivers/iio/pressure/rohm-bm1390.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
> index b3be9de03678..d00d7ed54cb1 100644
> --- a/drivers/iio/pressure/rohm-bm1390.c
> +++ b/drivers/iio/pressure/rohm-bm1390.c
> @@ -289,7 +289,7 @@ static int bm1390_read_data(struct bm1390_data *data,
>  	if (warn)
>  		dev_warn(data->dev, "Failed to stop measurement (%d)\n", warn);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int bm1390_read_raw(struct iio_dev *idev,

