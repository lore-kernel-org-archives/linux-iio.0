Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2D2261B71
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051207; cv=none; b=dHTSba5Vc3/qBcfwWhAnJQKcuV7sWkdJrz9I3a2lcCT8LqXjxjYmMQQLX3aCIsYJWWu98x9oUWYSVTzGWdMZEc/1c8x/lKJsfK0RaUO6EVTpbdWfTJ36u9cofmu7lcf29lrZsMH58/yigaup9yl9ot+QW2gbritNCCWX1Kpwp2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051207; c=relaxed/simple;
	bh=Fxbkvo6H20xBcVBLy6SQ2S7wEso77MZ/z0S982pnDjU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4ZW3r3Hgw0ur8lL2raYq+MGkHVpj59Gi804DgGZXsQ2f+mBDkY54ApkupEKaWgiarP+UPik961FcIqyPoKMMYFhmaDO4hT6s05QMH2Y7bvM9DL5sztdsfVR24ImF6x3jPeNBvkhhxgO0Jh+dAeQhDq5gdD8ymXsfqqTpAXMZns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bifBZAGM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bifBZAGM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76281F00893;
	Fri, 29 May 2026 10:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780051206;
	bh=PBQl4rz15UI8SxCZ9gQfMpVc/xUtp6kqRbwgA+5lBus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bifBZAGMcimL0k/5aAhAzOdJHzA8LaXHYzOky3wKf/MEa2OzLXQTTApqQ4Wl3qoQO
	 YCV7h5/1LWWx1Wga6vIRsVutRTF7T+MQQHhrbriAD3bBYnQH2vm8SGahtFgV9xseZG
	 AShxBygE3LWJz7fZP/k+F4qO7sWV2EOSlachS7VaTX8cziq9vLI81EEoZsVPyTNTtQ
	 r9qjbmHMZlExefAp2mo6umoj8aVuQ0ksApXn7+nvesbMozu4R2YDT2aUlDCFfBgMyK
	 cO7IumJTPXtIhhiO8RwG5O9il31xOMe2OgaYchBThodeD42ELafhqdkkQ6ZAFNPggo
	 2f6yXiSa6Tj9w==
Date: Fri, 29 May 2026 11:39:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: matheus.feitosa@usp.br
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, Lucas
 Rabaquim <lucas.rabaquim@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4] light: tsl2591: simplify tsl2591_persist functions
 via lookup table
Message-ID: <20260529113956.1c4198fc@jic23-huawei>
In-Reply-To: <20260528185912.24774-1-matheus.feitosa@usp.br>
References: <20260528185912.24774-1-matheus.feitosa@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 15:55:12 -0300
matheus.feitosa@usp.br wrote:

> From: Matheus Silveira <matheus.feitosa@usp.br>
> 
> Replace switch statements with an indexed lookup table for
> persist cycle conversions.
> 
> Both functions contain redundant switch statements. This
> reduces code duplication and makes future updates to
> TSL2591_PRST_ALS_INT_CYCLE_* definitions easier to maintain
> by keeping the mapping in a single place.
> 
> Signed-off-by: Matheus Silveira <matheus.feitosa@usp.br>
> Co-developed-by: Lucas Rabaquim <lucas.rabaquim@usp.br>
> Signed-off-by: Lucas Rabaquim <lucas.rabaquim@usp.br>
See feedback from sashiko:
https://sashiko.dev/#/patchset/20260528185912.24774-1-matheus.feitosa%40usp.br

As far as I can tell: tsl2591_compatible_als_persist_cycle() was not
doing anything useful before this patch - so whilst you are here please send
an additional patch to rip that out (if you agree it is pointless!)

Otherwise, I missed a small formatting thing. I tidied that up whilst
applying.  Applied to the testing branch of iio.git

Thanks

Jonathan

> ---
> Changes in v3:
>  - Remove struct persist_entry and replace the struct
>    list with an array of u8 values
>  - Remove the loop from tsl2591_persist_cycle_to_lit()
>    as suggested by Andy Shevchenko
>  - Align tsl2591_persist_lit_to_cycle() with
>    tsl2591_als_time_to_fval()
>  - Keep the loop in tsl2591_persist_lit_to_cycle()
>    as suggested during discussion by David Lechner
> 
> Changes in v4:
>  - Fix Lucas's name in tags
>  - Start lookup loop from TSL2591_PRST_ALS_INT_CYCLE_ANY
>    as suggested by Marcelo Schmitt and Jonathan Cameron
> ---
>  drivers/iio/light/tsl2591.c | 95 +++++++++++--------------------------
>  1 file changed, 29 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
> index 08476f193a44..2b91ecb86ade 100644
> --- a/drivers/iio/light/tsl2591.c
> +++ b/drivers/iio/light/tsl2591.c

>  static int tsl2591_persist_lit_to_cycle(const u8 als_persist)
>  {
> -	switch (als_persist) {
> -	case 1:
> -		return TSL2591_PRST_ALS_INT_CYCLE_ANY;
> -	case 2:
> -		return TSL2591_PRST_ALS_INT_CYCLE_2;
> -	case 3:
> -		return TSL2591_PRST_ALS_INT_CYCLE_3;
> -	case 5:
> -		return TSL2591_PRST_ALS_INT_CYCLE_5;
> -	case 10:
> -		return TSL2591_PRST_ALS_INT_CYCLE_10;
> -	case 15:
> -		return TSL2591_PRST_ALS_INT_CYCLE_15;
> -	case 20:
> -		return TSL2591_PRST_ALS_INT_CYCLE_20;
> -	case 25:
> -		return TSL2591_PRST_ALS_INT_CYCLE_25;
> -	case 30:
> -		return TSL2591_PRST_ALS_INT_CYCLE_30;
> -	case 35:
> -		return TSL2591_PRST_ALS_INT_CYCLE_35;
> -	case 40:
> -		return TSL2591_PRST_ALS_INT_CYCLE_40;
> -	case 45:
> -		return TSL2591_PRST_ALS_INT_CYCLE_45;
> -	case 50:
> -		return TSL2591_PRST_ALS_INT_CYCLE_50;
> -	case 55:
> -		return TSL2591_PRST_ALS_INT_CYCLE_55;
> -	case 60:
> -		return TSL2591_PRST_ALS_INT_CYCLE_60;
> -	default:
> -		return -EINVAL;
> +	for (unsigned int i = TSL2591_PRST_ALS_INT_CYCLE_ANY;
> +		i < ARRAY_SIZE(tsl2591_persist_table);
> +		i++) {
This is not particularly nicely formatted. Better aligned as

	for (unsigned int i = TSL2591_PRST_ALS_INT_CYCLE_ANY;
	     i < ARRAY_SIZE(tsl2591_persist_table); i++) {
		if (als_persist == tsl2591_persist_table[i])

> +		if (als_persist == tsl2591_persist_table[i])
> +			return i;
>  	}
> +
> +	return -EINVAL;
>  }
>  
>  static int tsl2591_compatible_int_time(struct tsl2591_chip *chip,

