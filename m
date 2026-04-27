Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482DE3C0625
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296702; cv=none; b=YEbLCicUaNYzaB2HktU6aBa2XkV3HqR+LV2VDn4nkYW5KexCf40gaI7025jHpexsIJrNarh1+qgTsOKLJmYL2W/MlAn9GbqwrWupHoTCtTYHlARUVTNnF9Zyq510pV2MRb/XNrvMPfuxrTJ+Qj/89GOzL1mODx4CNGddX0LvGZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296702; c=relaxed/simple;
	bh=5A7d0xEr6UZg3zALUZ6HYgjPXriLWdN9GklYjVNl/f4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fO3R2LNOWvAjEwj0RJElVpYpqHToXW//4fveCpJz1QCK9S2xDfcKSjiiClrcgDcVlgnSkIQl82dEE6woBIlpP3AVkH7K+5PNgoAZeIUIBUNHmIVwhte6yOMIiMq4WdYrcITqR5YrEaGhUuwakuoXiKXg3wt0vcS3Pb+s8OwsyP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIcqQ1Gq; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIcqQ1Gq"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44261378651so1321826f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 06:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777296700; x=1777901500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRnlVjG0EUtLNoWywJoZdaf/5UhwPl/dJQnQyyvjvgs=;
        b=HIcqQ1GqCciey2E+G4aEiH7DZasxs3wPBkbpyKmbK7UMtrHieJTgosn8Qoqv2Bje4q
         Og/3rhMPHVBdJKqSkl4SYZTg3nRuZL8AaldjB/CJQzaiI3LGhb++GGjg0Y6sdgCAeemZ
         wjWkkW/nGb+LoDDYA+PGCT9MtOm3Oas9MBJ2GTTdf6K3ow+Npu6+RtzpB7aRGkbLqtuf
         avaM7WtfbM4QvRfYQ+U7P05/VAFYZGEbuyGr4fUfCeAnyCdLR+XKHJUWvmiWgVeJyIO1
         Xkhdd7BKwqTiheKBDsKDZEy2ZD8ovRgDMUfQrTxLELHHCrJQbFqVdbgKwr68sonPEoWK
         wGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777296700; x=1777901500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mRnlVjG0EUtLNoWywJoZdaf/5UhwPl/dJQnQyyvjvgs=;
        b=rTq/BgGRsvUvYPSPmaW4sombSl7MIdJPOAOr9j+P7djgRzjiJsvdb+Ah3A3GW79euS
         CqKGJDLfPi909hTN3LHtuMqzTdNvfmgFjujCuJC5UFEycYIHnUWJ/0lKejAcwVbcCC0U
         27pSGc1Cn9bvjDO1eo3eZHPwHCODKWIJtOE/6D6M1vYzBjvoQrrj4G6RqzC30aVowWpd
         aSh2C8Bz3KiXXx61SFwEeY6laqHSBVIZ0LgxiDe1MxvbtuqusTnrVs1b73V0X8E3dZbK
         HAJ9SM/T7cioBxS8Iokxyh3rmQA93xEmPxW6uwJBM/vGxo6zNOoH6POfjn4kwRybk9Wq
         OP8A==
X-Forwarded-Encrypted: i=1; AFNElJ+UOJAmBr5MxkYyha2XE7Gl+5FyisrT0Gphg4rWoBT46fdpgDopTF4HkgX0delwh4g1eq1mh/PEd9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVLDXjh+51FUW5HTkZhSkcwpAxMaGN8LnjZOtNdRnHjFHzTwOv
	WBeKhCvwnMcjmJbPg36C44sbZwh4xsD4q2sc/lSEPclnY7yd3LYGMUH/
X-Gm-Gg: AeBDieuHFGMcR3t5tMm9Nthq59NOAzBOQG17UDQ4vHcgoU7IA435sQC5pWeaAYPvp4V
	6oG3PWrkfZIHJ3A37AgqOpGarPkUWDgTf0xwcvcaPYPMdwh1X7XKqBL8sssVUQvaWoIjahlx3/N
	KgCoE1SrbOjhQtrSQmnIBx4AwO5g/FqU6jKf8IF+QmQTt9LKMxl72ny/QJVyGoA+4MG9MEibeP+
	zSHHjwKA2kGHHf6650CnoKIxSA6h6cE9jQmZ473pJvpBKevLqIiQ6Ein36Pvdxa/b8h3YbZhPHP
	Qxq3e8monO1/iqNGvU4KZh64zB5nTeJPtZBbAXUhdfp19TdPAIJz4BK5tsool0676Cf8/0dtVip
	WK69L7RQ86EKRkfe0S1GCY8oscOygzgSOBK2FE16ndMYu0M9LRysCJZwWFsq4Y6mAAiw1TwNYn7
	CoJ3R3Pnagh4sI2J2xRVjRfjlMcOL7yAqcL1Qh2eMLjSybQ7Y69Fi8Pu+ejrLa7NrJkdQq64yrP
	y4=
X-Received: by 2002:a5d:5848:0:b0:439:bee4:8a93 with SMTP id ffacd0b85a97d-43fe4073758mr67744932f8f.12.1777296699402;
        Mon, 27 Apr 2026 06:31:39 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc0f31sm81263613f8f.12.2026.04.27.06.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 06:31:39 -0700 (PDT)
Date: Mon, 27 Apr 2026 14:31:37 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2] iio: adc: ti-ads7138: replace kmalloc() with stack
 allocation in i2c_write_block
Message-ID: <20260427143137.27bc4552@pumpkin>
In-Reply-To: <20260427112705.71138-3-giorgitchankvetadze1997@gmail.com>
References: <20260427112705.71138-3-giorgitchankvetadze1997@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 15:27:07 +0400
Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:

> The ads7138_i2c_write_block() function currently utilizes kmalloc()
> to allocate a buffer for I2C transfers. However, the length
> parameter passed to this function is strictly 2 bytes across all
> driver invocations, making the total payload buffer size exactly 4 bytes.
> Invoking the heap allocator for a 4-byte buffer introduces
> unnecessary SLUB overhead. 

Have you confirmed that the buffer is never used for DMA?

Provided the lock that blocks concurrent access from two threads
is actually outside this code, a buffer for short transfers could
be allocated within 'struct i2c_client'.

	David

> 
> Replace the kmalloc() call with a statically sized 4-byte stack array.
> Add a boundary check returning -EINVAL to ensure future driver
> modifications do not overflow the stack buffer if a length
> greater than 2 is requested.
> Furthermore, dropping the dynamic allocation entirely removes the need to
> include <linux/slab.h> (which was the original motivation for this patch)
> and streamlines the PIO transfer path.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
> ---
>  drivers/iio/adc/ti-ads7138.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads7138.c b/drivers/iio/adc/ti-ads7138.c
> index ee5c1b8e3a8e..172893cbc17d 100644
> --- a/drivers/iio/adc/ti-ads7138.c
> +++ b/drivers/iio/adc/ti-ads7138.c
> @@ -102,21 +102,20 @@ static const int ads7138_oversampling_ratios[] = {
>  static int ads7138_i2c_write_block(const struct i2c_client *client, u8 reg,
>  				   u8 *values, u8 length)
>  {
> +	u8 buf[4];
>  	int ret;
> -	int len = length + 2; /* "+ 2" for OPCODE and reg */
>  
> -	u8 *buf __free(kfree) = kmalloc(len, GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> +	if (length != 2)
> +		return -EINVAL;
>  
>  	buf[0] = ADS7138_OPCODE_BLOCK_WRITE;
>  	buf[1] = reg;
>  	memcpy(&buf[2], values, length);
>  
> -	ret = i2c_master_send(client, buf, len);
> +	ret = i2c_master_send(client, buf, ARRAY_SIZE(buf));
>  	if (ret < 0)
>  		return ret;
> -	if (ret != len)
> +	if (ret != ARRAY_SIZE(buf))
>  		return -EIO;
>  
>  	return 0;

