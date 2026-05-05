Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F7638946A
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983410; cv=none; b=JpYZJNPDELGBIc6QLhs/w96ZH+F6w7v5g0wsY46h6tpLj1vBFivodWjDWpC2EJBn6euAtqsxe3oQPb1PNYefx1WRdox/VCXCgRPPSCfcYjuqhlcKszQN9aXOAVrSS8mC9RAqKLBZbA4OO4GR7nVqxrrUtpl97cEnVwfFbX+8OVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983410; c=relaxed/simple;
	bh=FcGmWb+ew4dz0XS7LVu7tVVFe4tI9C3o/RNc1mz554k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzjknV1DsQfZ6kHmdpoa8qtuFs2iMNKW0O6MEeOC2/VgvJCMfas5VMlclutR6jbIKQ4raep5oL2f4DVCXZo3vqurknLD5QStcUfwe9Bi7soQqAqDzFq5wVZ1e0/IuqSada567zJmC06syIHp/K+JkGitZFe6hyw4TOEqOFSB1Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0XiPabc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0XiPabc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD318C2BCB4;
	Tue,  5 May 2026 12:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777983410;
	bh=FcGmWb+ew4dz0XS7LVu7tVVFe4tI9C3o/RNc1mz554k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L0XiPabc1ezfNR0O79Tbpy5J9B0/WTu9VcRugR94M2xL8NoCYkf8EQ3o6dGYeeRY4
	 UgJgq/jXMNkfTJtoo2JnqS3w78fOXVMAIeSkT7lT/l8ALPKXht667bjWYAbY+B5S52
	 P6ZGXF2/spT9GzcGjIh1tzrWUaBmADFTr/3SEmPqB+U2eNo1eW0NPrgGEcKMq+sovE
	 Bof+fgTtXTIRpFfd+rYVwWWOIvzF2fVwb+rwI8sNkGlAFI/N2+6EtFAaveUHWPQebP
	 I1DkMjGV6LZCyaA1MhFhR3KjXQuQDR87mB5cENg9NJKds7Iq6c204CrqEp5x5ig9NM
	 C9azdScaBsIBA==
Date: Tue, 5 May 2026 13:16:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rafael Lopes Santana <santanarl@usp.br>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] Replace manual bitfield manipulations with field_get
Message-ID: <20260505131642.75f3c72a@jic23-huawei>
In-Reply-To: <20260501011548.15369-1-santanarl@usp.br>
References: <20260501011548.15369-1-santanarl@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Apr 2026 22:15:46 -0300
Rafael Lopes Santana <santanarl@usp.br> wrote:

> From: Rafael Lopes Santana <santanarl@usp.br>
> 
> Signed-off-by: Rafael Lopes Santana <santanarl@usp.br>
Hi Rafael,

Additional comments inline.

Given this is packing code that is using shifts in one direction even
in your new version I'm not seeing a clear advantage to this change.

> ---
>  drivers/iio/proximity/aw96103.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
> index 3472a2c36e44..a8a6ae02438a 100644
> --- a/drivers/iio/proximity/aw96103.c
> +++ b/drivers/iio/proximity/aw96103.c
> @@ -591,7 +591,7 @@ static void aw96103_cfg_update(const struct firmware *fw, void *data)
>  	}
>  
>  	for (i = 0; i < aw96103->max_channels; i++) {
> -		if ((aw96103->chan_en >> i) & 0x01)
> +		if ((field_get(BIT(i), aw96103->chan_en)))
>  			aw96103->channels_arr[i].used = true;
>  		else
>  			aw96103->channels_arr[i].used = false;
> @@ -643,10 +643,10 @@ static irqreturn_t aw96103_irq(int irq, void *data)
>  		if (!aw96103->channels_arr[i].used)
>  			continue;
>  
> -		curr_status = (((curr_status_val >> (24 + i)) & 0x1)) |
> -			      (((curr_status_val >> (16 + i)) & 0x1) << 1) |
> -			      (((curr_status_val >> (8 + i)) & 0x1) << 2) |
> -			      (((curr_status_val >> i) & 0x1) << 3);
> +		curr_status = (field_get(BIT(24+i), curr_status_val)) |

Look at coding style for the kernel. You are missing some white space here.

I don't like this but if you were to do it for consistency it would be

		curr_status = FIELD_PREP(BIT(0), field_get(BIT(24 + i), cur_status_val) |
			      FIELD_PREP(BIT(1), field_get(BIT(16 + i), cur_status_val) |
			      FIELD_PREP(BIT(2), field_get(BIT(8 + i), cur_status_val) |
			      FIELD_PREP(BIT(3), field_get(BIT(i), cur_status_val);

The benefit of that is slightly more than what you have but it's still ugly enough
I'm not sure it's worth doing.  Note FIELD_PREP() in this direction as the mask is constant

Given the bit smashing going on here is always going to be ugly I'm not sure
any of these are better than the original though I'm open to hearing what others
think of this more complete version.


> +			      ((field_get(BIT(16+i), curr_status_val)) << 1) |
> +			      ((field_get(BIT(8+i), curr_status_val)) << 2) |
> +			      ((field_get(BIT(i), curr_status_val)) << 3);
>  		if (aw96103->channels_arr[i].old_irq_status == curr_status)
>  			continue;
>  

