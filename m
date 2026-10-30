Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793348358;
	b=KKVCnRT5TtVWUhDBQp7EkSxLQ+ajDtVjlqxt+wb4HsWTF8zr3WiE3r8EfyWGvHWU01AS
	 pj8tVZoSWSkNM3irauCSMSLHNw9yn61Hw4awZmj+hvr5bxZvQ/auOaMZTDjddGD5C88r5
	 lnEmepGEr3xM2PZfW6bDRHGAvaSlaCI3Awdd7IEX61aji7HqpvHb472dsoL5MtxEc3bPi
	 82gSUrbZOyeBszw3XrPkniOy17rLlh1Lj0AV6CLlgQ6JVct3rtGURxHAJwjIynXSBEhVu
	 4/Bd+LVjBN/vamfjYBKgp7Cd/6LLGumULt5t3XJ2nIczgCN7pijxnWc6j1SyWb2o5iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348358;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=l9nRtv/g4rXlyc2OHJmDGEK0B7e/zuJG39yjSylvfqg=;
	b=aGCN9sb+5HUKbKPf7N1B/zKRGVEmw9s6jiMLT3ctzEmx0aOzlSw/Pz9wSE15rkW6ZPZI
	 WVoDomsqO1SFNzyKawRSHvrg9daNDLsIwZ9xryux0w1WVmVa/NCa9TUGmgr53FdUzUIaG
	 X5QMDMSxBMZWSL1HZlEJc7pYostD2nIGwovn+vFRW0D1fVMYaG9BiQeBMu2WJux3BztGe
	 Nl42Cw9DXMLH7uzyPwn2gxBKs4Is8AweULwUVuDlhUe1Ul+Pa0dkz4y195IDItFb9QFpB
	 rcL7X9jgRDXdDy367QhVtzq5Flgcn01U4Mtu0rYBBp39pT5FpvsM9OR2FF/7k+SZatQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CbMz8dRC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40602606A31A;
	Fri, 30 Oct 2026 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CbMz8dRC
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793348357;
	b=w7+78jFYhHv78P056Y9YSXDMgxI+P53lRVJ0ln4yY3gca0RWqH+rwlpGyanAeCNaYlo+
	 spHQX1Og42vcBBDacldsl9pMN8P9A7ImQ5VD0u0AjKpivctdtpOH7O8XdhUzCKQ4cDtQi
	 J/VWtw+d5RHj5ZUjAMo+Ew+9DB4LCQU5gcLW6T4z34BaKid27GKQIXXVTXZMmfh3/tnq9
	 WXQPB32/1s+z11UsVW3ON4WwJ6CswDd7p8G0cN0OZ4PQv9JSqhPdp1h1PUPcF9RKff5FG
	 gHVqc9pT2p3slY9+NlGKNdrNCv6HRGCVECe2KwPmBcuEFX8ybjcGKF3I1z/dubK7WpQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793348357;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=l9nRtv/g4rXlyc2OHJmDGEK0B7e/zuJG39yjSylvfqg=;
	b=qdv9AcdtDmrpNWeR5kdaYC7PLiu2FIFm6RAfgfjJGNaJTs0+ZNm9mZLRt/Bw8MWZnVTs
	 RaM0CR/4/wa6wxg7ruM3wI9pBiTEiXbi9MsR8+OLSD2CuVfWFeCHbLO5Hq/6d53kHAbPo
	 kl2KOICO8qJN5aEigUWTTY2wkqyHEwnHcnK7YAWMvouaAUa3eDO7x/D8Kd9mGBVdzGvH5
	 7gX5TWC4M+EQn9XDQNkLF85ucQtjIAtUB7gPKXM6Z1Gqt5Gkju/gvpT54/uRpJ7E9cWNP
	 nvCLkangsj8PezPtwFobj6OGghXa8CDCJK29mNxrvBhSGQLEmE3MXk/lA0y7iNnIdfA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 49D5C1F00A1C;
	Fri, 30 Oct 2026 08:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793348357;
	bh=l9nRtv/g4rXlyc2OHJmDGEK0B7e/zuJG39yjSylvfqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CbMz8dRCfREeWqfUGLF4esTO1azW1tsZfQBktWGVhryw2z4avKQJxCCZfMHyjLanq
	 S4MVLxnJkHLz3wmnsbMQ25ZEhcAs9mgBVHzppT6f2TeTfxP2CT91A8RU8Y6uEdUL5w
	 edhqFuTMcQf6lVhzj8K0HRz3FUW0vMLfTAq0Bjxx6s8HzLkYRjvIKb40H6OkBTqIrD
	 g1OlLc/O/kQKb50QUrPgC7o5+MTMUqYSBywBW4vzNlEwaFnFdkmzmcphiZV6llZ5ev
	 gHrSmOaCKl1AygSNhk38V/sy15oWt+swdYslrT9NRNTsHqUlGkjXITyezNbzqQD3Jo
	 aGs6+Qffz8EVg==
Date: Fri, 30 Oct 2026 09:19:07 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, Joel Stanley
 <joel@jms.id.au>, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, Paulius
 Zaleckas <paulius.zaleckas@gmail.com>
Subject: Re: [PATCH 2/3] iio: pressure: dps310: reset the chip at probe
Message-ID: <20261030091907.0000709e@kernel.org>
In-Reply-To: <20261029220635.18816-3-zoone.rupert@gmail.com>
References: <20261029220635.18816-1-zoone.rupert@gmail.com>
	<20261029220635.18816-3-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
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

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
