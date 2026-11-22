Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795305709;
	b=bmnOiAbR5ssf1BCQTdxZstBOFgqpJrN0V8qaB3tBknPf5FnJOzwabSRs2EbXVjIYh/Y0
	 Ofb2E5h1Le9H+nPJEImc1qj7RNuKUyRPHWsYxX4S6+2G7l0MfY+fHlFnnp6lCv2nfXOgL
	 g+/usX42G0WpJugBw/D2tQAjgYJ3sl2PX+or8r3K0EyC9jhtgJMZF4HUQb1sHdbRpQ+su
	 X/E/7v3W43YaCD/gnM1PcjZMWbnkjrg1m8t2tH/a4Ug2/pVmxtHBI+Qi3Aau9cNepAxFF
	 KQhBqrtJn/4zg/U9g2PP8a3DwFn2Wgpl4S+upT208IhWsOVufv8CrVv1uxCxcjllqIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795305709;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=cqXJytTphT/ByglZO+CrjGR/1OSHt8FffBD/o/tRqNU=;
	b=z2RMl/GMDmZz3UZcayxfOH5/eAx52wSSUEmg60QwO6nB2N1U5b1JewiPMCwApKFqiGkr
	 5spQpE956tsj6ejghYNK4d6HgliLI9p/D8FbdalytL0Oy/Lttyt2WRnrKQV9JRtkuuxeG
	 Q5pOmyYZEdEfIPmym2eEWAoGFJlEI6qjI3Wv6TgpNbH9jojYkSpUU8+gxAfiWcXcBE3oh
	 dtXa7BO12bu8HLPtCktxqvj4s9lam6ZPgFeMH7WZB+cPkKnig/2VxJo4RZZFksXj0Avil
	 m7K3CjRNLlqxD8b9bxfoA6Q3W+MljH3R+IqywFTFleznnONKmliqeVkaqFt09FTp4kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0VE26cq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3DD606A320
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 00:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0VE26cq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352141F000C0;
	Sun, 22 Nov 2026 00:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795305708;
	bh=cqXJytTphT/ByglZO+CrjGR/1OSHt8FffBD/o/tRqNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=o0VE26cqXwvQl7aeJnCx91F1NIOEAx7AnCxe14ck+x3FtyPeSwWtHYAJczJlQnTpp
	 zddvmgv5sNLYjlZ6goQB83dU18pFEBX75d6M0Ff74/cYVQaD5mpD859eUorlq9J686
	 5BbBXRqgIik7J3R+b3w0gf3jxkQeHSkEcH9SULUT+eyqQfYqd9jq3PbBoqSKO4FDV8
	 jHe/9mn98qupPwO6pE6HF4OqiSU/QFbhxgn3gE5alC7zqGHHQOf9ruID2bfz3l+oEu
	 cksZ33k4OWr9gaWkW+FpMbePsWoMEGuAnOMAxoEEQ8hjyLjBTsmPJbVC7Nbbg/xwOK
	 0WmF4k/giNtuA==
Date: Sun, 22 Nov 2026 00:01:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 1/1] iio: dac: ad5766: Convert GENMASK() to use
 static parameters
Message-ID: <20261122000143.46d9fc2c@jic23-hlaptop>
In-Reply-To: <20261117160857.1799863-1-andriy.shevchenko@linux.intel.com>
References: <20261117160857.1799863-1-andriy.shevchenko@linux.intel.com>
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

On Tue, 17 Nov 2026 17:08:43 +0100
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> There is no need to use run-time calculated masks in the code. Besides,
> GENMASK() over non-static parameters might lead compiler to generate
> much worse code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
I'm too lazy to find out what the compilers actually generate.
Lots of options around code like this for what they might do.
Anyhow, it is logically simpler so why not!

Applied.

> v2: fixed typo
> 
>  drivers/iio/dac/ad5766.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c
> index 061b43fc0345..ba6c54e2c9ac 100644
> --- a/drivers/iio/dac/ad5766.c
> +++ b/drivers/iio/dac/ad5766.c
> @@ -18,9 +18,9 @@
>  
>  #define AD5766_UPPER_WORD_SPI_MASK		GENMASK(31, 16)
>  #define AD5766_LOWER_WORD_SPI_MASK		GENMASK(15, 0)
> -#define AD5766_DITHER_SOURCE_MASK(ch)		GENMASK(((2 * ch) + 1), (2 * ch))
> +#define AD5766_DITHER_SOURCE_MASK(ch)		(GENMASK(1, 0) << ((ch) * 2))
>  #define AD5766_DITHER_SOURCE(ch, source)	BIT((ch * 2) + source)
> -#define AD5766_DITHER_SCALE_MASK(x)		AD5766_DITHER_SOURCE_MASK(x)
> +#define AD5766_DITHER_SCALE_MASK(ch)		(GENMASK(1, 0) << ((ch) * 2))
>  #define AD5766_DITHER_SCALE(ch, scale)		(scale << (ch * 2))
>  #define AD5766_DITHER_ENABLE_MASK(ch)		BIT(ch)
>  #define AD5766_DITHER_ENABLE(ch, state)		((!state) << ch)

