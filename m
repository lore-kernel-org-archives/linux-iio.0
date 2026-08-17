Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BFB233923;
	Mon, 17 Aug 2026 01:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786929177; cv=none; b=k+JYXDbpv5GlSTLSXSS3DifY7PA+hTwtQ9syba6z06tP9WIKYFf41q3Iu9/2Afrdp825jigW0Fr5NaW90MCvi9SH7OheH5uJAxmiGOPHZDmoTfKaWqxGyHdCR1qp7aDxrDKdbvcxq26O43ZW0n8DLk38JkYTBWkm8rNi3A/5DT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786929177; c=relaxed/simple;
	bh=+pRZo26vEvE6Kmw+ZKRjR6t2Zwvjey2WBqLTvA7aSP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5UrylUQS0ptB3peCpL6h9KVCJUSZle08pKI6oz0q45Yu1KdxmXJ7pE0mf0dORS4BCh5xYW30ZVSsdCGNDn1gfoomQFQ/35eV3eXnr8BBi1K2HMDXXLgn8mIAPPCm1cyhDxveITc/fnB7duRtPuvf1oVtocUoKvHguDmWQ1Tcw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNuBpG3j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNuBpG3j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86EE1F000E9;
	Mon, 17 Aug 2026 01:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786929175;
	bh=fDdwnsC0Q9B443savPcafKA+OPITeVjQW+jiRd+PY/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GNuBpG3jv8N/vK7glUDUT1lI54WUXT4dy4H+maQTzvWL6eePKkc4Hq7S2Dp1UMnIO
	 jOvYjfR4QF+RXFR5dcOknSIxMK+ZjNaWcFyQJ4JfPhoETMSWFj4aWQ0prRmUZSMMYJ
	 lZ8PD/WYltq8UFgXdra8G3ZUhtP6K0q/o8lR0mntR6X/5mmsHytEb6umuDstXrLv8I
	 ncCM4x9M9Bx/sf+eQ3BiXccARzqjeb9qcwQEYOF+gxruQ5Trr5DItcEEMcA1PR2MHi
	 UA1GBR7nZaOD31hFS7K7N//FYBtFxLfdI8Qjt4tW8i5LPskgH6NCyTkZ/iLh0Q0twM
	 p77MWhW5nZP0Q==
Date: Mon, 17 Aug 2026 02:12:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, Mehdi
 Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>, Topi
 =?UTF-8?B?U29ua2Fqw6Rydmk=?= <sonkajarvi@hotmail.com>
Subject: Re: [PATCH 07/12] iio: pressure: rohm-bm1390: Fix AVE_NUM
 initialization
Message-ID: <20260817021252.5ef32a57@jic23-huawei>
In-Reply-To: <7784e12793187a75dc10b0e84471f0cefe4d28b9.1786347811.git.mazziesaccount@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
	<7784e12793187a75dc10b0e84471f0cefe4d28b9.1786347811.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 10:53:07 +0300
Matti Vaittinen <matti.vaittinen@linux.dev> wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The BM1390 tries to initialize the AVE_NUM to 110b at the start-up. The
> field location is not taken into account, and value is written unsifted.
> This causes the AVE_NUM to be initialized to zero.
> 
> Use FIELD_PREP() to shift the intended AVE_NUM value to correct field.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
> ---
>  drivers/iio/pressure/rohm-bm1390.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
> index d00d7ed54cb1..29454570f257 100644
> --- a/drivers/iio/pressure/rohm-bm1390.c
> +++ b/drivers/iio/pressure/rohm-bm1390.c
> @@ -479,6 +479,7 @@ static const struct iio_info bm1390_info = {
>  
>  static int bm1390_chip_init(struct bm1390_data *data)
>  {
> +	u8 regval;
>  	int ret;
>  
>  	ret = regmap_write_bits(data->regmap, BM1390_REG_POWER,
> @@ -512,8 +513,9 @@ static int bm1390_chip_init(struct bm1390_data *data)
>  	 * Default to use IIR filter in "middle" mode. Also the AVE_NUM must
>  	 * be fixed when IIR is in use.
>  	 */
> +	regval = FIELD_PREP(BM1390_MASK_AVE_NUM, BM1390_IIR_AVE_NUM);
>  	ret = regmap_update_bits(data->regmap, BM1390_REG_MODE_CTRL,
> -				 BM1390_MASK_AVE_NUM, BM1390_IIR_AVE_NUM);
> +				 BM1390_MASK_AVE_NUM,
				 FIELD_PREP(BM1390_MASK_AVE_NUM, BM1390_IIR_AVE_NUM));

If respining I would drop the local variable and just go a bit long on the line.
I like the mask to be clearly visible in both parameters and a local variable
prevents that. Fine if the line is really long, but it's only about 83 chars here.

Jonathan
>  	if (ret)
>  		return ret;
>  

