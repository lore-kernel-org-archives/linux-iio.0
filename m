Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA8336F8EB;
	Fri, 22 May 2026 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471343; cv=none; b=PfKNQZzwjydtgttUdEeTIVurj6BTEx8PNmnzyRdx0MAhT+vCSIuf09VOOuvSpA6sODS/Xuz1NGs7CnU0yOCRCTBQ/J7plJI97y24P+wBbgyYqElVeMl51lERy53CYaszRDeXtN4ins0nFBf4ba1ErI5RexvsIiLzBX54WUlCWaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471343; c=relaxed/simple;
	bh=dcUyWznfhDqWNBIo08vTRrGvLpjKm3T3z6X1wmz1gaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgFG6xiCD50s2A3N/NoHJoGdRwOlkgutu/VXH/MYf3/szW9ap6VVe1PZzZ0GqNKwpCjfRGsr7x70B7NEEDbb6a9nf/DJfhMbxhZzCwR7GJ7r4e9ghh8Osn5o45fslM2SxCdjbcStAQM98o7RUG98slDr3WQiO6sg27RHNmbSVf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKew/20c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKew/20c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78CF1F000E9;
	Fri, 22 May 2026 17:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779471341;
	bh=/0RFs9fv0Uvl1dCX5nyKSgsZXWwYo7sXQOPAk4gWGQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CKew/20cSpzNJqq6ZKcspawLqAnLu4veqXZETfN4CoyM/CSXUMI1DfkZf0oM87O+L
	 6BymnhMgzVfD8j6kFMbnmUtH1UamksJ7ntT6l6hF1IUysXE6+YO81skmkLeU5Y4wGd
	 56ICodiuMx8a8s2C27G8KqtYxyzfaIZ9PmswTaBB+/Ql7o3aFRkjNcyIhbdLqABX61
	 S2I1+yKNmMgNPgV/m9O8a8SVC7d3Hh0DE3sfCEWWRWMRwhPEnb48CIphB3eOA2YfwR
	 z2vQ4/7Jxs8DZ3fBjXKcvzzFqx+tMmxMttmiA4qMbtQMdZjynWgJULXcSD90cH+2FZ
	 fxn7HJvdwWWVg==
Date: Fri, 22 May 2026 18:35:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: adc: nxp-sar-adc: Fix the delay calculation
 in nxp_sar_adc_wait_for()
Message-ID: <20260522183533.358a1f30@jic23-huawei>
In-Reply-To: <20260519215607.78241-1-andriy.shevchenko@linux.intel.com>
References: <20260519215607.78241-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 23:56:06 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The original code was using ndelay() twice. In one case the delay
> is calculated as 1/3 of ADC clock and in the other as 80 ADC clocks.
> But according to the comments in all cases it should be a multiplier
> of the ADC clock, and not a fraction of it. Inadvertently
> nxp_sar_adc_wait_for() takes the wrong case and spread it over
> the code make it wrong in all places. Fix this by modifying a helper
> to correctly use the multiplier.
> 
> Fixes: 7e5c0f97c66a ("iio: adc: nxp-sar-adc: Avoid division by zero")
> Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260416090122.758990-1-andriy.shevchenko%40linux.intel.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Daniel, could you take a look at this one.

Explanation seems fine but original patch was yours so I'd like
some 'aware' eyes on it!

> ---
>  drivers/iio/adc/nxp-sar-adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
> index 01f3da56e987..68d237ef30c2 100644
> --- a/drivers/iio/adc/nxp-sar-adc.c
> +++ b/drivers/iio/adc/nxp-sar-adc.c
> @@ -198,13 +198,13 @@ static void nxp_sar_adc_irq_cfg(struct nxp_sar_adc *info, bool enable)
>  		writel(0, NXP_SAR_ADC_IMR(info->regs));
>  }
>  
> -static void nxp_sar_adc_wait_for(struct nxp_sar_adc *info, unsigned int cycles)
> +static void nxp_sar_adc_wait_for(struct nxp_sar_adc *info, u64 cycles)
>  {
>  	u64 rate;
>  
>  	rate = clk_get_rate(info->clk);
>  	if (rate)
> -		ndelay(div64_u64(NSEC_PER_SEC, rate * cycles));
> +		ndelay(div64_u64(NSEC_PER_SEC * cycles, rate));
>  }
>  
>  static bool nxp_sar_adc_set_enabled(struct nxp_sar_adc *info, bool enable)

