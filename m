Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3FE1465B4;
	Mon, 17 Aug 2026 01:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786930343; cv=none; b=RFEE6TZA4M3xksU/ujVmEYjpGPKz+s1YOPAn0yacpZhUiWs6iCJR6sCoX+dAlei7hJQIwXkFxtg6fMTH6eG4h4lV04Jm5MbADI/hL4aeOk3uUKcC0PLJiz6IlGs8hxvaeX1xd2gB7L1MHJwHjAr8iMmGrqMG0nnIpKQWhLqRQHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786930343; c=relaxed/simple;
	bh=3TSVsC2RUoazx7wqypZgx+zIDEOBgjlwmXeShHAxZIM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZISM4SpVVdwUFDaaqhb9b12i03VgG2SInVYe+f4vo0vqy2jCycubBGH/Jbw4Z6etoLB8zsno5IX4sLcuUpE56jrMJ0akKsNrvEYlHCSMPeAePainIBE0x/hx2QV7dq3a/+YAqMrJkjayo0cf5yGmgv8SjAL/FypTS4P9lDVV0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWGlL2fV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWGlL2fV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A60F1F000E9;
	Mon, 17 Aug 2026 01:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786930342;
	bh=gMHmLFOAg8wYwt6wlEQnj7umMhobXL2MaAHLLcSX/yk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZWGlL2fVTU/xLQ5ykSn2r/1jxnFVs9xq/z6uBN3BR3CaFI/E4Hp8TZxDnQrkxyCyk
	 mZjkkSCsapnyxmNjyx55R+KtZLYsTjuNhK+ZRT0pCTQtHxiK4syvRSJy49EjjYb92L
	 whuwSOJNsQYzGgXwBEd9wnAlh5lVfaoUg+KzViTldCIrKRUco4rCZ7H7f/KEdqnrNK
	 l0/jbgtn531pdduIUaMfqrHsuWlN0QdeGabMpQxFyeG3D+ecUsd3zoSIr32aBPDa7u
	 qad38ybKKRk8gHunSfQTuQqzuMcvwLioXuWNBhcRqosXxijszdnYn01fm4UOLMpx6X
	 i097VfhWPflfw==
Date: Mon, 17 Aug 2026 02:32:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, Mehdi
 Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>, Topi
 =?UTF-8?B?U29ua2Fqw6Rydmk=?= <sonkajarvi@hotmail.com>
Subject: Re: [PATCH 05/12] iio: dac: rohm-bd79703: Do not allow writing
 SCALE
Message-ID: <20260817023217.2fd9e42c@jic23-huawei>
In-Reply-To: <bf75f4bb0d3d620e5c613c04cfc874767a51ff38.1786347811.git.mazziesaccount@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
	<bf75f4bb0d3d620e5c613c04cfc874767a51ff38.1786347811.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 10:51:38 +0300
Matti Vaittinen <matti.vaittinen@linux.dev> wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The BD79703 has adds IIO_CHAN_INFO_SCALE in the info_mask_shared_by_type
> so users can read the scale, which depends on the used reference
> voltage. This, however, enables users to try writing the scale as well.
> This isn't really supported but the bd79703_write_raw() does not check
> the mask, and if written scale values pass the validation, the driver
> will proceed writing the DAC value when users writes the scale.
> 
> Prevent the unsupported scale setting and return an error.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: af6aca656a85 ("iio: dac: Support ROHM BD79703 DAC")

Applied.  

BTW convention is Fixes goes before SoB.
I did wonder if is documented anywhere and claude sent me
to the tip docs.
https://www.kernel.org/doc/Documentation/process/maintainer-tip.rst

IIO can follow that.

Anyhow, I'll swap them around whilst applying.

> ---
>  drivers/iio/dac/rohm-bd79703.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/dac/rohm-bd79703.c b/drivers/iio/dac/rohm-bd79703.c
> index e91090e4a66d..68e66e7286d8 100644
> --- a/drivers/iio/dac/rohm-bd79703.c
> +++ b/drivers/iio/dac/rohm-bd79703.c
> @@ -73,6 +73,9 @@ static int bd79703_write_raw(struct iio_dev *idev,
>  {
>  	struct bd79703_data *data = iio_priv(idev);
>  
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
>  	if (val < 0 || val >= 1 << BD79703_DAC_BITS)
>  		return -EINVAL;
>  

