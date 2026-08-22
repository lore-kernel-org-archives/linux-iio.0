Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F045F3624A5
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787386583; cv=none; b=nbxXTPIOOEply4x0B7Gtf7KZIX39vlXv7jkSZD6lLjTrJlAUbohmhgVOkHXPXGSZs05LYqf1UFQPmXqtlenUzowoZJJEA/ha8GXN5m2GjU32akGmuxg3tlDrqRpxnUNof6bAI/FBh7VfWFQDZ8PMG6Z6D5n5/A90P31rG2G2eNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787386583; c=relaxed/simple;
	bh=TV3WZupbrYiiF+JqzUgyXDZQaN5aQcSsej1mVUbAssA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CtiYzJKR7xe0D+lgI5dqfCcHOyDVc638ZuiDXQK8TB+Jb521Ov24Jo4nhSiyvqdkOqlmtDraDh8tBLf/TmVcUc6Sunin8cVxdSYD1zR9kbNnqn3FUBlP9k3fmuHmcJeIzdvSxTdFC3hmw35lcTCkDCp7mZUnUY1nNQDvQ9876R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VESXHYFV; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VESXHYFV"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a28cbdso3298587a12.3
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787386580; x=1787991380; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J/gqM6k2vXmc46oIqgEoMF+rXBbgRi1NIKf+Vh5Uza4=;
        b=VESXHYFV7yp78ZsuXqL4RYw3avRflJZFEDq8VLICYQx9IwXHBL+h2GKQ5nq6bz7led
         w6W6wvE4eki2yhbdcP/TKWSuF5j6dKF0GfNo0ZwwIjvBdwvcrgX7tiEELqLQEn/MYBi9
         qzaR0gM6QOO1NVlIM6hzb6UJPiT2lnp0HxblIF+ze+R4BnZz1vMVHxXcCIpxFjN/SN1c
         lwTHOO0Qyw2J0KcmoNNZYYT7/diqgg2rjGjsDQ/bZzbzfx8MgEhYm/g0ZZllTGmmf0JB
         hNDovTrEXN0tGYQx8LUCknKNeX56eZkVHtgCPyS34aEoMSYDQpDYj1mIRkGSxKuxjDtB
         IGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787386580; x=1787991380;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J/gqM6k2vXmc46oIqgEoMF+rXBbgRi1NIKf+Vh5Uza4=;
        b=pl0sz25DkF7wJC2lJ15dET7wohlMmtDqhT3+W1KQWMcnNT7yhzz5tuD/WJ0RzgrPXW
         ShqlJd4RQu7x2afK8KMZJ4kHBoZuM2RroN1pRQqMcrEl5kswsKiKg1nVeVW9VqEaw6SJ
         wDI7dNR4EdJ3TBmCEVmGwpEeCSTMs+m7CMPuNLMc4cAMWbSp+dDN4/QjrrKMxjdd99Hy
         H389bkUbUE5fdzyeydIIn9Gvy/9zvsEbNLkk2ZJkZHEegzloJHvPyPjz/F5yFeaePGUW
         dyLBnAHdCW473eRPkeDnrIo9qR0JqoLq3NsTJZGKze3QFdIfD4C2lR6lUkiJgYFs3Kj+
         SJNA==
X-Forwarded-Encrypted: i=1; AHgh+RrnA68BLkVGZK6M1pQJXZ4j2WcofnzECYbLrWn6GOOYZWLCqcyWBvGSFUrFRMWJRHuTBzJCbgcphoI=@vger.kernel.org
X-Gm-Message-State: AFuF++kyFyplO9Eh6KN9cDJUHChglTUO7EqLxpeX+h3GPHjafs5dj4aU
	TLffRHTy95w1EtSmkP4wJM0ZA2UUwS8QUN8x+M8pNc0t0NoQrZ7+FIvE
X-Gm-Gg: AR+sD10eqaTMvz6GMOrA/bVGOLBrtJ2wNWTw24H+KIscSgLFY9wV5UvPcVsYqESoTUv
	YiPC1Ch2+3MkqE07NRho7AS9c1l4yBpFqfIv5GSxbsGVRMgIYSd7r9rZFBwoJmd1sXDwGJ1liIF
	kHd9atpPnRR0Dx4FpZCYpbF12n4yfC9bbuelTg7R0g+UvzBbMPqCJA4Mr6nyLm5YgQAdaXOxk+O
	7nSkoWGLHgou1Idt2wlEbzMUcR4mQSk+RiF23gTYzsMVvr/NM1jmDQwYh9sGvSTsuLDiPSxYFf+
	IMp+y26NkPxdjKeBuk/Q3ulH43grq7y1m2Nd9TC6z/dUdmePc6AlY9AhE4d4cxw8vPwc50TkTXg
	sBIorgqrCYY3yhnJFKdZ7GkENWslSwjVuue7THiH/jnI2+1IF4ViIShBr8RcVHoQKjsZVJvqec3
	Sv8AiWd9G93kQw7aL81nr+sEX4FPnCaWa/MRdMMoH4Pg+YNH91aETYs57dsTCqKh66IjeKXtkUi
	WkYtkP2NFdyjVlf5gqjHART+i35rg7jkgKqkpp3k+de38NrDXXSqmKl+8xXoA0Chw7t+xGE6S+7
	K0Catl6KXEsFDXXLctYI7cNB76QPh1Wn+oLAwlMdDtD+5+kh6aLIPaTIPosevFzcHIinb/1qdLA
	dLbRb0fl50MJl+DqixEox0XVWfwFJPdw=
X-Received: by 2002:a05:6402:5049:b0:6a3:f63a:4997 with SMTP id 4fb4d7f45d1cf-6a582af9535mr4786164a12.3.1787386580114;
        Sat, 22 Aug 2026 01:16:20 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0c327asm10786611a12.8.2026.08.22.01.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:16:19 -0700 (PDT)
Date: Sat, 22 Aug 2026 10:16:18 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: tmp117: fix calibbias cache update on
 I2C write failure
Message-ID: <20260822101618.2690a7e9@systembl0wer>
In-Reply-To: <20260822004929.13643-1-salah.triki@gmail.com>
References: <20260822004929.13643-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Aug 2026 01:49:28 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> The calibbias cache (data->calibbias) was updated before the I2C
> write to TMP117_REG_TEMP_OFFSET was known to succeed. If the write
> failed, the function correctly returned an error, but the driver's
> internal cache had already been updated to the new value.
> 
> This causes the cache and the actual hardware register to go out of
> sync: a subsequent write of the same value would be silently
> skipped by the early "if (off == data->calibbias) return 0;" check,
> since the cache matches even though the register was never
> successfully updated.
> 
> Update data->calibbias only after confirming the I2C write
> succeeded, so the cache always reflects the actual state of the
> device.
> 
> Fixes: df041e737a38 ("iio: temperature: add driver support for ti tmp117")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/iio/temperature/tmp117.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
> index 6bc18616ad15..7d74f401bb80 100644
> --- a/drivers/iio/temperature/tmp117.c
> +++ b/drivers/iio/temperature/tmp117.c
> @@ -95,15 +95,20 @@ static int tmp117_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec
>  {
>  	struct tmp117_data *data = iio_priv(indio_dev);
>  	s16 off;
> +	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		off = clamp_t(int, val, S16_MIN, S16_MAX);
>  		if (off == data->calibbias)
>  			return 0;

Add a blank line here.

> +		ret = i2c_smbus_write_word_swapped(data->client, TMP117_REG_TEMP_OFFSET, off);
> +

And remove the blank line here - return value checks should be grouped
with the function we're checking.

> +		if (ret)
> +			return ret;
> +
>  		data->calibbias = off;
> -		return i2c_smbus_write_word_swapped(data->client,
> -						TMP117_REG_TEMP_OFFSET, off);
> +		return 0;
>  
>  	default:
>  		return -EINVAL;



-- 
Kind regards,
Joshua Crofts
