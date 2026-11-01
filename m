Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793494990;
	b=Iuxf4Kyvz88lYPie8fSxnADqB4rH8gvPXyPjjOkicT87CTeltU9ZblH3tb4ISLluxe9Y
	 BKy41BLnJyombibwr1WuGr122B4FDTvMt4Ohb+zz6uTILcVmz/A6/dJpPFACqkuHSbKUS
	 B+mNC8Dv/l7N67XLgdjxj8MpRIMnB1WYjlefxw+LSBj2gEObEtiurl/gqMlWKtW4pzYB9
	 c2y3BTOk/wn774MKY1moPD38lrFCVrT9xrazXWC8Onk2xcWNzhPKw7rvwvQJm1z+YE08n
	 zW69xQ9PN00hRz7lQRWifF33GVtnOlrh3uFDMhlxo+S1xk/gl9+ahi0Rx0oBSN4Zk8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793494990;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ktcivWHIEFAFkwReSja1sIlL4LUQfANO3aW6MldUu48=;
	b=m+t5NVna6KYxwghdvSFaaOxrw7ESBHQE5TDmsXQtfc3h6Y11Ip5Q8bmq3xn3mMUBnkbp
	 F6Py4HgUIxujb7YXwBW424nTeqfkXSa00HIo6QJgFuPKPGcQlW6fWxSlGJLkVi6TRlk1U
	 tnx3GWZgYOMZ3HoLE2LmhkxZDt8gI3pKgVjws62ZFHyX0UOUbELFhy4G71zD7hfund/gO
	 Mk9ec/3ONgP9ll9xCDehV8Yoxc1T1+SXMvaqJ8oBcmgzgC/ZjBYdK6UIydoe5HxfFAVrn
	 E3m83Aufm7mR96ZKdK6kxYLY7WfDvGAtdf893WbbcCPYrdHKKHLYecCxl4adyCIJgxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jn+tfC5i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6247C606A31F;
	Sun,  1 Nov 2026 01:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jn+tfC5i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B32C1F000C1;
	Sun,  1 Nov 2026 01:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793494989;
	bh=ktcivWHIEFAFkwReSja1sIlL4LUQfANO3aW6MldUu48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jn+tfC5iJkEIDAQjKuyVlhF1j5dMK9nbBuvAA+0a7ocihShbfncCuXyke2HAwEl0O
	 KxARV+cZXvmhxkHOdyG0J4pGF5a1jDszVtl32ECFF8XvLfsFWCHvAy8iy/CPZLqkEA
	 4yz4QfK8yEI0NlCSH53lJ9UDRhPcCWS6bOqlllxehIja1VrocIvlxMayG1z6Jki7Hv
	 vBIlxL0DVLsWTQbkBgWJXBNFWNoNxm3HTZ/xOAQKvSphVRCl7ahJWZa2TArjTZm66t
	 vAlaTf7Q8r/6+gyP4Oy5GMLIQykU9j2dq+GLKjVv5MSxDYjC2VdRgHE2PPmBrWjyRs
	 IwvHGq+KKy25Q==
Date: Sun, 1 Nov 2026 01:03:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, Joel Stanley
 <joel@jms.id.au>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Sashiko
 <sashiko-bot@kernel.org>, Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: Re: [PATCH 2/3] iio: pressure: dps310: reset the chip at probe
Message-ID: <20261101010302.619adb33@jic23-hlaptop>
In-Reply-To: <20261029220635.18816-3-zoone.rupert@gmail.com>
References: <20261029220635.18816-1-zoone.rupert@gmail.com>
	<20261029220635.18816-3-zoone.rupert@gmail.com>
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

On Fri, 30 Oct 2026 00:06:34 +0200
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> The chip keeps its registers across a warm reboot, and probe changes
> only the shift bits in CFG_REG. A reboot during a FIFO capture leaves
> FIFO_EN set, so the ready bits never come and every raw read times
> out. The timeout reset does not clear it either, since the CFG_REG
> update that follows writes FIFO_EN back from the register cache.
> 
> Reset the chip first, as remove already does.
> 
> Fixes: 90f0d1016398 ("iio: pressure: dps310: read buffered samples from the hardware FIFO")
That's not a stable hash because it is recent enough that
it is on the tree I've rebased since then and will do again on
rc1.  Given this will go in at same time as the fifo anyway
during next merge cycle, I tend to just drop the fixes tags
in cases like this to avoid having to fix them up.

Other than that, series looks fine to me, but given you asked Paulius
for a test I'll wait on that!

Thanks

Jonathan


> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260921183132.233136-1-zoone.rupert%40gmail.com
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
> ---
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> 
>  drivers/iio/pressure/dps310.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index b6aa5dbe2bcd..29778f25bb33 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -1445,6 +1445,11 @@ static int dps310_probe(struct i2c_client *client)
>  	if (rc)
>  		return rc;
>  
> +	/* The chip keeps its state across a warm reboot */
> +	rc = dps310_reset_wait(data);
> +	if (rc)
> +		return rc;
> +
>  	rc = dps310_startup(data);
>  	if (rc)
>  		return rc;

