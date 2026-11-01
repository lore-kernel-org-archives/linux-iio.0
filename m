Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793495091;
	b=30NOE87Jt9ME7UlsUA4Z5jqvWkQNhYqfBQ2a8/+nwwc/By5H4LZVqUgigBo1UOp7bsY8
	 5sdeAudpKpq2EbKUr2ek83NYvn8gwHqkiFi2lnmS/Z3nQIDOXwTx2zAIgCGYAut2fHUXI
	 W0Y0kqFmgV8zYd1FqsvW3wMYdaGk39cuGFQSZvnEOHj4+g3y/ua/m4QWVz4zUSRsswPII
	 RncL98DMnC9t1vzynZ1o2sKiS8+ss5Sq8I2fgq/v6p8qDEM5pBk+BWz4izthkTstaGVQ9
	 FKr5GbUNauz2p8xhU9US+nlpUjpkm4b1f1cGO3izr2Lg0BghYTH2GtTfHl/+PQh0eGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793495091;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WBnebek7ZBpuLmqJrRSo0Ht4VOQGeqUNOTJfiexzAbc=;
	b=QBmhIavin5m4dtoAwhItOZGiiAp5WK5HE+pJJPkuQvBWLHc8oSASil90c5839AQf14+S
	 /6d4Q81Gansj/nRuRdW63OaoWwfZEKZNNPvitYluPmVObqnWQuOn6SvTzrO/NAp6Ud84+
	 xZ6MQ/sBjN4HxkMyLuRGHndt7/pKkTUbtStxnmV6sgmMb1k/+2FRQ9rMwBYHAGj5n0Ukk
	 G/NlLO7JMBvFKg9aIP0mTmZhE3ZOX9nz0JJtsyta7tM0Cd4hxuV2Mf9+/PVhjwOUNAq6l
	 tqh6TG8bpg2LWND1LMhigP9HuWsi3nIznIcITediER0OPaT4CoajNaHVJ/Smv0oFf8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UD1F+OMI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0920606A31A;
	Sun,  1 Nov 2026 01:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UD1F+OMI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F36E1F000C1;
	Sun,  1 Nov 2026 01:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793495090;
	bh=WBnebek7ZBpuLmqJrRSo0Ht4VOQGeqUNOTJfiexzAbc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UD1F+OMIneBZbs1a1d6MBVfUjAB6c89pebJ01ZAbJGvG2nRNMK73+TtDFXf7yQcWP
	 R8usJXGowG1KtO3cLmxjrZtni0ajh+XmC4JJ784djihuJ1OHJZAGwFpLk15dDmhqP4
	 bxo5xaGDE4/97e2Qn9Az67XlE1EsDYrsVcH+9l2cIE3lA2XV4r3LL1ON9ysFyfVd8X
	 ZnQpYLg/rOYCxxHWVuH3d2xK7QcJk+qUfiz5uD387sCOjjGIy32ME9qtBB/2TdO/dj
	 fnXVqmVoeuTRx8RhJzZPdjbIYCkLXFOpQ3zrHlzbV2PIkVHhIHtKYNn6L89yU3rTi2
	 HrmGmUGcorzLA==
Date: Sun, 1 Nov 2026 01:04:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, Joel Stanley
 <joel@jms.id.au>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Sashiko
 <sashiko-bot@kernel.org>, Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: Re: [PATCH 2/3] iio: pressure: dps310: reset the chip at probe
Message-ID: <20261101010444.2803dab4@jic23-hlaptop>
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
Why do we do it in remove?  Does it put it in a power saving mode
or similar? It's fairly unusual to bother resetting in that path
given as you've seen here, we pretty much have to reset in probe.

Jonathan

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

