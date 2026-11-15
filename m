Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794703978;
	b=TBM/jqxxW3RfOLmfd8Lq8HfUVQgB4h3BKehNciniS0WBYRC0nVLSUH4tsIcUA45jH20h
	 d3QbyOR42CDcBDj8zBiS2FieJKh7rNH3DP+2BNPUSin58fUyJwD2zpZi+fzhUWyGo7Fga
	 EPmP+HT4Hqs5OVHSO+tFXEuzdcKAUEePzoY+3LyQTMT4nkmEg521i5LhAXj5MDfZw7Y8N
	 2CAvwuM1gDQgE4vDjMoku2G6hqMH03vMTiqHMxD0L4HUjGyL8cd66stQFsYLQaekfRwRF
	 Hpy2jy6N04S4xeQd+7rbNqs+shXLYGIcZb64oeY/Eo1qGjp23w3XKB1/LehpLCM6JOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794703978;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pgt4oZ2WN8u01ga7Sr4+oVx6S9OSfcnwOm7/oUBJ1+g=;
	b=fEEh47jaT7qDrRmgDoglp1ulm8tKBzXZ/Y8FWaaGdJosfzIrLP6wvQLm3xBMWrMRrppx
	 jivJIBzBBx/cNAtfsoATM+Cx7ZkYLqZqo+kNVKrTDPHZSRUROGEAogQ4Iaf6BEbKjAKzi
	 JMUryQtOvnKJuwkBSL2kjmHkcCRZoPU2LYy82534zSbHR4QwnH9vgwiIpVZIsQPo8L52R
	 U0hQEZ0nNjExzrmkkkZLSt8EUHvaGDzzCBcMoeu51yQeREmoqviNpoTkqqUGYRrPaMQfn
	 9v6/EBLE4tVdbhsxnfH40pVBSJiQnOnBd6eGqODp0bA/F6LCFA5kfV85ppLO5U9mNgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YoJZLbjL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EA5606A323;
	Sun, 15 Nov 2026 00:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YoJZLbjL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3321F000C4;
	Sun, 15 Nov 2026 00:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794703978;
	bh=pgt4oZ2WN8u01ga7Sr4+oVx6S9OSfcnwOm7/oUBJ1+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YoJZLbjLl5pW82lKxjooxbaV6WLHCNjxerihDg3XmyihZHEweGwmO4UwRInaSbWKk
	 QJ/1qtOsiZ1UIoJIR/D9Fz90hb/uDZRkb046cJKW0Orq01MacxIBUpVFxlSIK1YmfZ
	 13a2jnjf1ivx4ebeyfZGGAhDUZS3fmAkP3S/Nlj+bIHx7zUaPY2s08bozR8fhi6cuc
	 8vBZVivsrlDoqyLvmr9tPA/DYcjgK9awpqtjRI6L6Xhxtab1zh2QHcmtiEE9pJDhCf
	 8MX4UfLpTFH5QHsbkr/eKVBCTFc96h1ySw+miN+GK+jDXYayKdVjDlrpagsdbw/pqM
	 KfHDrBw8kkPHQ==
Date: Sun, 15 Nov 2026 00:52:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Gwendal Grignou <gwendal@chromium.org>,
 Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx9310: fix semtech,proxraw-strength =
 <0>
Message-ID: <20261115005253.2b2d7f01@jic23-hlaptop>
In-Reply-To: <20261107143523.465188-1-kapoorarnav43@gmail.com>
References: <20261107143523.465188-1-kapoorarnav43@gmail.com>
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

On Sat,  7 Nov 2026 20:05:20 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> The binding allows semtech,proxraw-strength values of 0, 2, 4 and 8,
> where 0 turns the PROXRAW filter off and the others select a strength of
> 1 - 1/N, i.e. register codes 1 to 3.
> 
> sx9310_get_default_reg() converts the property with ilog2(raw). For 0,
> ilog2() returns -1, which FIELD_PREP() masks to 3 in the 2-bit RAWFILT
> field. A board that asks for the filter to be off therefore gets the
> strongest filter, the same as semtech,proxraw-strength = <8>.
> 
> Keep 0 as register code 0.
> 
> Fixes: 5b19ca2c78a0 ("iio: sx9310: Set various settings from DT")
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
I've applied this one to the testing branch of iio.git.

I note you've sent quite a few patches touching this same driver.
That's all good, but if you can group them into series that would
be even better!  It makes sure I at least merge them on the
same tree!

Thanks,

Jonathan

> ---
> No in-tree DT uses semtech,proxraw-strength = <0> (sc7180-trogdor-lazor
> uses 8), so this only affects out-of-tree boards. I checked the
> mapping with a userspace copy of the ilog2()/FIELD_PREP() conversion:
> 0 and 8 both give RAWFILT = 3 before this patch, 0 gives 0 after it.
> 
> Compile-tested only (W=1); I don't have SX9310 hardware.
> 
>  drivers/iio/proximity/sx9310.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 2585b9c6fb69..a39277237d39 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -855,7 +855,8 @@ sx9310_get_default_reg(struct device *dev, int idx,
>  		if (ret) {
>  			raw = FIELD_GET(SX9310_REG_PROX_CTRL5_RAWFILT_MASK,
>  					reg_def->def);
> -		} else {
> +		} else if (raw) {
> +			/* 0 means off; 2, 4 and 8 are codes 1 to 3. */
>  			raw = ilog2(raw);
>  		}
>  
> 
> base-commit: 340d44bdf9db0f095f99845b5ad8628781d79b6f

