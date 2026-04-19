Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A6D1E8320
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776598571; cv=none; b=soEK9SsPk189uFsCeliDLTPSTQxcuwjFRd7DLyALO7Z2z4vS3SkGHGx2MwBiDoOmz88wFxO5mIQofo6Mu54bK2hjOZxXwo12LEfUnzEIiGkoqS0cnka+16IGV9M/hiyGA2L0/42QTBb1yKclgloSs7wUhP8S7UcTYedQBZ9tZuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776598571; c=relaxed/simple;
	bh=9Ub78AZhK7unoaCHoR3j4s5olHM3a9ErNUDGAZVBiSE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzijCg4rkcyK5RJNDQcGEnLh5hmLSGj21/vMbk02wKzRJqGnf7PhxhbXDH2yKKNpueI7RI1JsJjki7VZAs2k9Ku7I/osihEQ7lRoelCZbhhooPdIRrgtuEZSnXZJUfnedmx6Zl+TmuxwHOGa7dqQFvVDJfbtax9Nd+2IFV17dYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpeP1u9r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpeP1u9r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3692C2BCAF;
	Sun, 19 Apr 2026 11:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776598571;
	bh=9Ub78AZhK7unoaCHoR3j4s5olHM3a9ErNUDGAZVBiSE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dpeP1u9rwLxeB7B9mUjp0IWzSIOIt9+5hPdiEWh1trqv3h6ZVJLKolt+tSKo4w8TL
	 B0e7cQyjkCGrsWtRv2BEsAq5rTlEsATU5azhVmsMBoQFxl/AilVxzvZQ1xK3GMOplT
	 nJcK9Dawxrkia3E0QmedkgwAw7aD1xrlyBswocI/ngerKOiVLv+vvLKpkir8CwTE/V
	 /ZW6WnJRqSCpdCbawMvutPMoRDjSse4XqTpveyrdHKepWNdv+EryJx4nqlWypP24HP
	 C2Ag97TjAa8MdP8z4cHFJoMrzQSFPQsJCG4om+sS3FpY2LtphTqejsmZncWPylAYCa
	 ONjDJUdhkCu1A==
Date: Sun, 19 Apr 2026 12:36:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: LucasRabaquim <lucas.rabaquim@usp.br>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, Matheus
 Feitosa <matheus.feitosa@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: tsl2591: simplify tsl2591_persist
 functions via lookup table
Message-ID: <20260419123604.591dc3ec@jic23-huawei>
In-Reply-To: <20260419003557.45287-1-lucas.rabaquim@usp.br>
References: <20260419003557.45287-1-lucas.rabaquim@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Apr 2026 21:35:43 -0300
LucasRabaquim <lucas.rabaquim@usp.br> wrote:

> Replace the switch-case logic in tsl2591_persist_cycle_to_lit()
> and tsl2591_persist_lit_to_cycle() with a bidirectional
> lookup table tsl2591_persist_table.
> 
> These functions have redundant switch-cases. Now they use a for-loop,
> like in tsl2591_als_time_to_fval(). The change simplifies
> addition or modification of TSL2591_PRST_ALS_INT_CYCLE_* values by
> associating cycle and lit values in a single entry defined by
> tsl2591_persist_entry type, reducing code duplication and verbosity.
> 
> Signed-off-by: LucasRabaquim <lucas.rabaquim@usp.br>
> Co-developed-by: Matheus Feitosa <matheus.feitosa@usp.br>
> Signed-off-by: Matheus Feitosa <matheus.feitosa@usp.br>
Hi.

First a general process thing.  Slow down!  You might well have
gotten more feedback on v1 if it had been on list without being
replaced for more than a day.  I'd advise generally not sending new
versions for at least a week so multiple reviewers have time to look
at the changes.

In general the change looks good, but I'll leave it on list for
a while before considering picking it up.

Thanks,

Jonathan


> ---
>  drivers/iio/light/tsl2591.c | 104 +++++++++++++-----------------------
>  1 file changed, 38 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
> index c5557867ea43..3fe34a48ec2b 100644
> --- a/drivers/iio/light/tsl2591.c
> +++ b/drivers/iio/light/tsl2591.c
> @@ -170,6 +170,12 @@ struct tsl2591_chip {
>  	bool events_enabled;
>  };
>  
> +/* Persist cycle conversion table mapping register cycles to lit values */
> +struct tsl2591_persist_entry {
> +	u8 cycle;
> +	u8 lit;
> +};
> +
>  /*
>   * Period table is ALS persist cycle x integration time setting
>   * Integration times: 100ms, 200ms, 300ms, 400ms, 500ms, 600ms
> @@ -229,80 +235,46 @@ static int tsl2591_multiplier_to_gain(const u32 multiplier)
>  	}
>  }
>  
> +static const struct tsl2591_persist_entry tsl2591_persist_table[] = {
> +	{ TSL2591_PRST_ALS_INT_CYCLE_ANY,  1  },
> +	{ TSL2591_PRST_ALS_INT_CYCLE_2,    2  },
> +	{ TSL2591_PRST_ALS_INT_CYCLE_3,    3  },
> +	{ TSL2591_PRST_ALS_INT_CYCLE_5,    5  },
> +	{ TSL2591_PRST_ALS_INT_CYCLE_10,   10 },
> +	{ TSL2591_PRST_ALS_INT_CYCLE_15,   15 },
> +	{ TSL2591_PRST_ALS_INT_CYCLE_20,   20 },
> +	{ TSL2591_PRST_ALS_INT_CYCLE_25,   25 },
> +	{ TSL2591_PRST_ALS_INT_CYCLE_30,   30 },
> +	{ TSL2591_PRST_ALS_INT_CYCLE_35,   35 },
> +	{ TSL2591_PRST_ALS_INT_CYCLE_40,   40 },
> +	{ TSL2591_PRST_ALS_INT_CYCLE_45,   45 },
> +	{ TSL2591_PRST_ALS_INT_CYCLE_50,   50 },
> +	{ TSL2591_PRST_ALS_INT_CYCLE_55,   55 },
> +	{ TSL2591_PRST_ALS_INT_CYCLE_60,   60 },
> +};
> +
>  static int tsl2591_persist_cycle_to_lit(const u8 als_persist)
>  {
> -	switch (als_persist) {
> -	case TSL2591_PRST_ALS_INT_CYCLE_ANY:
> -		return 1;
> -	case TSL2591_PRST_ALS_INT_CYCLE_2:
> -		return 2;
> -	case TSL2591_PRST_ALS_INT_CYCLE_3:
> -		return 3;
> -	case TSL2591_PRST_ALS_INT_CYCLE_5:
> -		return 5;
> -	case TSL2591_PRST_ALS_INT_CYCLE_10:
> -		return 10;
> -	case TSL2591_PRST_ALS_INT_CYCLE_15:
> -		return 15;
> -	case TSL2591_PRST_ALS_INT_CYCLE_20:
> -		return 20;
> -	case TSL2591_PRST_ALS_INT_CYCLE_25:
> -		return 25;
> -	case TSL2591_PRST_ALS_INT_CYCLE_30:
> -		return 30;
> -	case TSL2591_PRST_ALS_INT_CYCLE_35:
> -		return 35;
> -	case TSL2591_PRST_ALS_INT_CYCLE_40:
> -		return 40;
> -	case TSL2591_PRST_ALS_INT_CYCLE_45:
> -		return 45;
> -	case TSL2591_PRST_ALS_INT_CYCLE_50:
> -		return 50;
> -	case TSL2591_PRST_ALS_INT_CYCLE_55:
> -		return 55;
> -	case TSL2591_PRST_ALS_INT_CYCLE_60:
> -		return 60;
> -	default:
> -		return -EINVAL;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(tsl2591_persist_table); i++) {
> +		if (als_persist == tsl2591_persist_table[i].cycle)
> +			return tsl2591_persist_table[i].lit;
>  	}
> +
> +	return -EINVAL;
>  }
>  
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
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(tsl2591_persist_table); i++) {
> +		if (als_persist == tsl2591_persist_table[i].lit)
> +			return tsl2591_persist_table[i].cycle;
>  	}
> +
> +	return -EINVAL;
>  }
>  
>  static int tsl2591_compatible_int_time(struct tsl2591_chip *chip,

