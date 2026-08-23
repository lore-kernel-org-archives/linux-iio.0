Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652702D739C;
	Sun, 23 Aug 2026 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787511144; cv=none; b=UCJLEcCI8ShTHL5wTRL0WkLgES3mwVVESlwGyMeTu+YoaWzGiyjY5NiHQAyTy95ORwMMV7UyKLGkzSoPhG81n47MQAmzxdfFQU+KikAyBUq+uyHH+2akiDKZZTtqJovm49SxwzhkPk29mwr3XsQRT5pb6Q8ysB9YVeoM4gUcaBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787511144; c=relaxed/simple;
	bh=KUl1AqtWTXQbecNndtyBJEf66uctYoL0wVkb9y1c8lc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHANsxyvN2WFutze79MHHMXCFZr8jA1YHEKxFjulUM45PeU0L87I+gEVy+rG7fImaILQrnagOnHz9s7Xsz2rcXYwamlRQL41prBmtkNqDEzvo/KOaBwrgMU2K2icB86fcAxozUsNK9vhEazf8VzZfXo8++AQnJOesTxxGUGshoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dc6yP20G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dc6yP20G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B761F000E9;
	Sun, 23 Aug 2026 18:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787511143;
	bh=kjIxxffX32/hEkhg7SnBH0Nz1LhdUYxOfTcqBKNNbT8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dc6yP20Gg0umiHpjBFeL//ktLswGPmmu4GTYw2QNozPkfSVz+yfOI/p43FMz9hfMC
	 fluLK8LADs4O+gNKmhQpgOPlXSGvCyQNXozTXHzc4z/AOkSTvITXDwxF1QGRVKVN3I
	 un1kN2B4JK8ujoiolmV8PunE3tWH4loUkposWPGNS6Zv2fe8kscBy321klnspojmE5
	 /SBBBhQ/FWADkFCueY4Z1rMp4Kxxf1960CIk1zPH3H0P+QWZr8LwTyBFkdSrFGXB3D
	 sh/nvwjRLOdnChZpnmGJJc12AxaGyDA6C2tzyYl0OSQjexz1eDwiZHZrPnB/BkBkgQ
	 FCrvxAYgJ3Wxw==
Date: Sun, 23 Aug 2026 19:52:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier
 Moysan <olivier.moysan@foss.st.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <jananisunil.dev@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v4 01/14] iio: adc: adi-axi-adc: Initialize state mutex
Message-ID: <20260823195215.5c73a417@jic23-huawei>
In-Reply-To: <20260821-ad7768-driver-v4-1-bb8fbd06d4eb@analog.com>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
	<20260821-ad7768-driver-v4-1-bb8fbd06d4eb@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Aug 2026 16:06:54 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> The AXI ADC register access paths serialize transactions with st->lock,
> but probe does not initialize it. Initialize the mutex before registering
> the backend.
> 
> Fixes: 7ecb8ee5c93b ("iio: adc: adi-axi-adc: support digital interface calibration")
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
Where a patch has already been queued, please add a note here to say so.

Until the bots get a little more clever about dependencies than I think
they are today, it makes sense to keep the patches in the series but I
don't want anyone to waste their time checking again stuff we already have
headed for upstream!

Jonathan

>  drivers/iio/adc/adi-axi-adc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index 26b9c75bd4d8..b5e59b1871b6 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -684,6 +684,10 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
>  	if (!st)
>  		return -ENOMEM;
>  
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
>  	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> 

