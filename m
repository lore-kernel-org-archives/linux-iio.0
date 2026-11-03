Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749547;
	b=YV99NE5cqOS+DYzlk+t9VM6pmzF7elcR91ryc6QzDJjEfJrADLM1U+yNFVMjoHucBaan
	 rAmLeOV0sitgxkCc3s01KuzngtTPB1bj/rCoI24mJ4z57+T5A9iiLb1+Is1bCtuhZQxTo
	 W9hLnY91oBw310tZWMRjo3MvZPcxF6gp1db72a/yh/mjuETEtdhmCiozCOpvJh3Ykb2gb
	 Bfv+tQHqDCL/hBTRUahzy2n2OuVQzaGO++bsEbHEj9cajAiWjt0LJuJ9R7UQHZrTSkvWd
	 cX73UWaZB2xz6qqCywFAZH+hUAQB0pwx3+NLEJLNaw0ZolWx/lbnpbdJRRJIZPdBtug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749547;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ffOZbXiokqRRn62lI+LM5DVMQ4ebjZs01vfcvrIqkzk=;
	b=RDg+5zBq4XVGByUBeK9WpOH77XwNHnIjda0TNoQC75exXEcK9xk1GTUWM9rTU/Wlz9X/
	 vPQ1+6nBicfrnt4wuVjFoDVFWjgDYgObzf4MnkZKbHP3Pu4WH5KoHfWoyIS8jjyt/f0b0
	 eErWZuHsHlqX7X8mW5tKxjrwAndYAX/AyObI2roqZmuoOvL9k6bPhqi2J2J+X5HZ3hhTM
	 8yxo9RmKCwrl4FVyiauilyysW0pZ/bRu4j27zhSjyPsyoIlwpPbA6NKeXgJQhfNrW8Jaj
	 u9M8TB96ccutgBv+14fJwDirjoHpZHbNYCsgLCgVPjI+aCaRgNS/ae/z04tsbRL+/Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abwuEZ86;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C6C606A329;
	Tue,  3 Nov 2026 23:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abwuEZ86
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3801F00A20;
	Tue,  3 Nov 2026 23:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793749546;
	bh=ffOZbXiokqRRn62lI+LM5DVMQ4ebjZs01vfcvrIqkzk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=abwuEZ86/Q5MY4byRpLDXJtZ+aRudH7OXv2RtUDFlnigSkC5jBHCuLP6oXQzt6zaY
	 1sRfDAb+rN1DZI+H80vjdVReYug2PBzH1YjXWZ2kAtDYYEP/Ro4V9zFd3nAADZFBvD
	 GQeeAICaaP0t/I50Pepxfh3is06k/q6R9p++Pv/9Ge+iGYZh76kwY0v5wMBXQlBuB6
	 1+fDQTOEkAjtU/iNo69D48xU7FUzBzoCivtxF3hdbyfFGlBkqQWxi3kGx947RSXxgX
	 xqTZTMKKsDWiDlbdZz+Bi58IxTTycdj7R7Kni0sHTdLqThlWJgKCu04bVcDP6yDfbI
	 J8JF23/suI7oA==
Date: Tue, 3 Nov 2026 23:45:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Cc: rva333@protonmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "=?UTF-8?B?TsOtY29sYXM=?= F. R.
 A. Prado" <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/3] iio: adc: mt6359-auxadc: mask conversion ready bit
 in mt6358_read_imp
Message-ID: <20261103234540.46cc8c1b@jic23-hlaptop>
In-Reply-To: <20261103-6768-6358-fixes-v1-2-2a868a33152b@protonmail.com>
References: <20261103-6768-6358-fixes-v1-0-2a868a33152b@protonmail.com>
	<20261103-6768-6358-fixes-v1-2-2a868a33152b@protonmail.com>
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

On Tue, 03 Nov 2026 18:32:08 +0200
Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:

> From: Roman Vivchar <rva333@protonmail.com>
> 
> In mt6358_read_imp() the raw ADC value is returned directly without
> masking out ready bit, resulting in incorrect battery voltage reporting.

Can you add where the ready bit is.  That might help someone
looking at wrong values and wondering if this is what is causing them.

This one is pretty glaring as bugs go (given I think this means the
top bit is set?) so any reason it wasn't obvious to anyone testing
this device?

Jonathan


> 
> Apply the mask to strip the ready bit, matching the behavior in
> mt6359_auxadc_read_adc() function.
> 
> Fixes: 3587914bf61d ("iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC")
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>  drivers/iio/adc/mt6359-auxadc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
> index 951d236f972b..09432d0974cf 100644
> --- a/drivers/iio/adc/mt6359-auxadc.c
> +++ b/drivers/iio/adc/mt6359-auxadc.c
> @@ -502,7 +502,7 @@ static int mt6358_read_imp(struct mt6359_auxadc *adc_dev,
>  	mt6358_stop_imp_conv(adc_dev);
>  
>  	if (vbat)
> -		*vbat = val_v;
> +		*vbat = val_v & GENMASK(chan->scan_type.realbits - 1, 0);
>  	if (ibat)
>  		*ibat = 0;
>  
> 

