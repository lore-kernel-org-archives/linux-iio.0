Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D934B693;
	Sat,  7 Mar 2026 11:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772883021; cv=none; b=S3gHSJvYevv3VMxr0aV3DIHZZ52FhnntUQcef8hc+rfZVCOjknOYIYPm0RVP/FOMfXG8FSEPDRAmKShlOuapiNnkoX9UUGo7H+lyEDTJoxAmTyyJ9MQschm47fZKabSYwp5A4ftAo79/Os9UHKq7ETFfbd75Qd6cY5r11CJQgVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772883021; c=relaxed/simple;
	bh=2CUVF99qWhu/7jlppu/a4NP/AlTSyIlV4CS7j851hoo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCD/8mwZtB8tRc5OUWFLsod/ovPJpbX7lhJTA+klLs3bBit2PP5QwMjx7wxF06L+hGgEKyo8DHj9lNUUS9p3Pi4NFYrnVBpdxtrQceHE8z2qVdDkX2XGJouKj5Tt6d4QCfkMu8+E9g3trNQNO3VjWp8kyBVfaEkSW52/hcjUT40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEj+1fn1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEj+1fn1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E01C19422;
	Sat,  7 Mar 2026 11:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772883020;
	bh=2CUVF99qWhu/7jlppu/a4NP/AlTSyIlV4CS7j851hoo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IEj+1fn1uMG5ete1sYnRb8JY399tNrmdDZeEKl4sGVHF/XavtPbFSeB3iNZwjRpWK
	 LPGb5M9UDASAGx9QRGkfDd/kcEMIpBrERvoFvVq3P2Ilzm4HTcI7TVNCTrPdtycAGd
	 +drGASlTbNQ2iHp++g+XK922V/XgKolieBCubV0K7juWFjd4RmqwBpJ6XuMB2tLQgf
	 jiy5FSBdXCbF4MBR5S11mdqzXH1fTSW14LjNvnLdN4YxN3rNAAgdef1QTJhCDmSDha
	 KU9QS5yaJo1KyCKEHb18ByGsCi1Skh39AOXEOLrUBdFOrmf7f2xXgUq/dCv2cznvLV
	 S1Uki026kPY2g==
Date: Sat, 7 Mar 2026 11:30:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Michael Harris <michaelharriscode@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] staging: iio: adt7316: remove shift/offset
 macros
Message-ID: <20260307113011.16da6098@jic23-huawei>
In-Reply-To: <20260305-adt7316-correct-macros-v2-2-3702e3841c42@gmail.com>
References: <20260305-adt7316-correct-macros-v2-0-3702e3841c42@gmail.com>
	<20260305-adt7316-correct-macros-v2-2-3702e3841c42@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Mar 2026 23:16:59 -0800
Michael Harris <michaelharriscode@gmail.com> wrote:

> Remove shift/offset macros and instead use the corresponding mask with
> FIELD_GET(), FIELD_PREP(), or FIELD_FIT().
> 
> In cases where an appropriate mask didn't exist, it was created.
> 
> One of the shift/offset macros was used for a convoluted dynamic
> bitfield extraction. In its place, a helper function,
> adt7316_extract_ad_lsb(), was created so the shift/offset could be
> removed.
> 
> Signed-off-by: Michael Harris <michaelharriscode@gmail.com>

> ---
>  drivers/staging/iio/addac/adt7316.c | 59 ++++++++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 1412808c50c76a68b5771a25c46dd3308c5cbcdb..b8b66f4dd14bb59c3d29fdd569d84f0dd786db9e 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -17,6 +17,7 @@
>  #include <linux/i2c.h>
>  #include <linux/rtc.h>
>  #include <linux/module.h>
> +#include <linux/bitfield.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/events.h>
> @@ -31,10 +32,11 @@
>  #define ADT7316_LSB_IN_TEMP_VDD		0x3
>  #define ADT7316_LSB_IN_TEMP_MASK	0x3
>  #define ADT7316_LSB_VDD_MASK		0xC

Convert all masks to GENMASK_U32() rather than just the ones where you
are removing a shift.  That will give us more consistent code and
makes sense as part of this patch.


> -#define ADT7316_LSB_VDD_OFFSET		2
>  #define ADT7316_LSB_EX_TEMP_AIN		0x4
> -#define ADT7316_LSB_EX_TEMP_MASK	0x3
> -#define ADT7516_LSB_AIN_SHIFT		2
> +#define ADT7316_LSB_EX_TEMP_AIN1_MASK	GENMASK_U32(1, 0)
Why GENMASK_U32()?  The registers seem to be 8 bit.
I'm not sure we care that much about the extra checks the sized
variant brings but if we do want to use it use the U8() variant.

Jonathan


