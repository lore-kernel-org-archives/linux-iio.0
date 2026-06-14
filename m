Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B0139FCBF;
	Sun, 14 Jun 2026 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781442715; cv=none; b=MebrjQxcrqms5mv8eMcEVglUhbx29+Z9efvEivgedeRPqahKtO8OoG2dlTsOCar7HUwx0nYux39HZdQ35ePneWq9ITzjt4dVNbS4Eqa7fM7QmRfz6FTfm6Mj4hqf+l8B3P++vxOgcl/130AYAsaV9BeaEdyFqf0jf1Y6u5bCUAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781442715; c=relaxed/simple;
	bh=fJvBFQC+Ke6uclRe9o1SV5f0OByvNrsZAzcryGkdzO0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnSlE237W0nDvF63C+HwcZLhj4cOmKtePusP8sLmBOMiDKmdpGmfSA54MAcp1ZifpWGAUrbHtKk5rKDdMq2dO58A+BVac5eSkW2A48Bcv4GpW5ZiOffzIfuD5rC2VuV9ePyw2O7HC8CGbq2BHS/bxc9trmMYL7OhGihklJM9r9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1X0uK+w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1X0uK+w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167501F000E9;
	Sun, 14 Jun 2026 13:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781442714;
	bh=75u5cjmHDQ4BpCAdFk59dTu+UZQbhDAoNNk3d+PgrTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=o1X0uK+wTcrAR/XtZ06ym3CjmNaKEFeT1HbsgMDOUsmRTjc75WfFI3VxgqBLZDow4
	 u/W0CIThELg6huGwsMeNm0V6F4HogZQO+NrERVbyweoUyMLkcYfKOAmy0mk6LMuM+7
	 /9cq9jtd1aUb2J0OrntxCWOib4/RVNk4erqjQx43RqM2es9SSDK3flD45Bm1lDbsR5
	 NvgMp4hv3CUXxrQVa0T1lz/OSmxVNM7wdxwTgBGZ9+kOdxidcZpXJ4Qk4lgzkkzGy6
	 zVGmp9aP8aP4WeWnbbnU6U8GvrrjMPyL1ePncuXFrFC/7APkFvcPzlVIxkVflRCgza
	 rNkaT5SfxExyQ==
Date: Sun, 14 Jun 2026 14:11:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: hexlabsecurity@proton.me, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH] iio: accel: bmc150: clamp the device-reported FIFO
 frame count
Message-ID: <20260614141146.697dde04@jic23-huawei>
In-Reply-To: <20260613-b4-disp-24d6b15f-v1-1-f5c3fe7294fc@proton.me>
References: <20260613-b4-disp-24d6b15f-v1-1-f5c3fe7294fc@proton.me>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Jun 2026 02:18:39 -0500
Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org> wrote:

> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> __bmc150_accel_fifo_flush() copies the number of samples the device
> reports in its hardware FIFO into an on-stack buffer
> 
> 	u16 buffer[BMC150_ACCEL_FIFO_LENGTH * 3];
> 
> which is sized for at most BMC150_ACCEL_FIFO_LENGTH (32) samples. The
> frame count is read from the FIFO_STATUS register and only masked to its
> 7 valid bits:
> 
> 	count = val & 0x7F;
> 
> so it can be 0..127. The only other limit applied to it is the optional
> caller-supplied sample budget:
> 
> 	if (samples && count > samples)
> 		count = samples;
> 
> which does not constrain count on the flush-all path (samples == 0), and
> leaves it well above 32 whenever samples is larger. count samples are
> then transferred into buffer[]:
> 
> 	bmc150_accel_fifo_transfer(data, (u8 *)buffer, count);
> 
> bmc150_accel_fifo_transfer() reads count * 6 bytes through regmap, so a
> malfunctioning, malicious or counterfeit accelerometer (or an attacker
> tampering with the I2C/SPI bus) that reports up to 127 frames writes up
> to 762 bytes into the 192-byte buffer: a stack out-of-bounds write of up
> to 570 bytes that clobbers the stack canary, saved registers and the
> return address.
> 
> Clamp count to BMC150_ACCEL_FIFO_LENGTH, the number of samples buffer[]
> is sized for, before the transfer, mirroring the watermark clamp already
> done in bmc150_accel_set_watermark(). A well-formed flush reports at most
> BMC150_ACCEL_FIFO_LENGTH frames, so legitimate devices are unaffected.
> 
Agreed on the analysis. Thanks for doing this.

I wonder why the field is 7 bits given it can only contain 0 to 32 which only
needs 6 bits...  (Digs in datasheet...) Ah, you can enable just one channel
at a time, however I can't find a statement that doing so increases the number
of frames stored (rather than masking what is read out).  There is plenty
of stuff saying the buffer is full at 32. 

Anyhow, never mind that as we don't really care why the datasheet
is illogical ;)

One small thing inline.


> Fixes: 3bbec9773389 ("iio: bmc150_accel: add support for hardware fifo")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
>  drivers/iio/accel/bmc150-accel-core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 2398eb7e12cd..dc8a6285cf3d 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -991,6 +991,8 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
>  	if (samples && count > samples)
>  		count = samples;
>  
> +	count = min_t(u8, count, BMC150_ACCEL_FIFO_LENGTH);

Why not min()?   I believe that will do the operation as an integer, but
the compiler should be fine spotting that the value that results will
always fit in count.

> +
>  	ret = bmc150_accel_fifo_transfer(data, (u8 *)buffer, count);
>  	if (ret)
>  		return ret;
> 
> ---
> base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
> change-id: 20260613-b4-disp-24d6b15f-90f0487ac141
> 
> Best regards,

