Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48543B38BB;
	Mon, 27 Apr 2026 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283584; cv=none; b=p/j8GkgpEy8rHVdcIbYrsu8jXZ1UvrEL2yva57v1H3jXeWXcxDadygDBBsi91wK7DVgd+vVo2N245BiOkU9JDzoh9ly9s2iKlOPaPq/0t+7AyryPPTmRuU/Qa/Md1B+gpffv94UMRuX1xMNMWN3Mc6cgE0zVdpMGB+8dHEDRxQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283584; c=relaxed/simple;
	bh=wUZ7Pj1S/JLGGyZMyobr+IyuW1VydLzhPjGR1yuHCpk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYvMP9/8KdGZszFA1A0RQ8+OG1zQypv9nWbFPgAdqrDzKma/P/Rv3umJTMaI7UDXDJrAMbVI6FyfOryGWFwkbXbaZJxUIK+51evUfeLT8wVD7vpKCPl4+3pyIij58Xa2iHOF37MwfCWavINpwflaPH5eBNVRkKl81xra0m85ELA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2uXjeGt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2uXjeGt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEAAC19425;
	Mon, 27 Apr 2026 09:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777283584;
	bh=wUZ7Pj1S/JLGGyZMyobr+IyuW1VydLzhPjGR1yuHCpk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i2uXjeGtqcMf2476rIP0TGk2IIilX+QeeusIFT+wo7Rc2cfsxqhCgodGb8dVpyDCO
	 m2HUNBAyL3r26TiN9CL0WjzZ8Yw4rsYQo1AyJAKx7iNfGedO+4B7iKlyJIamVU9IV8
	 DAfPOFinwF3kbNmBiqk/ViYir/Bxr8WgqgUEpcLklrsaSUHLGDhIsbOKrQFmlBKRj3
	 zuqnXTBwWGDV2TpEwj56FANMRkELvHJF/+PWTLhX1dR3MbFv+UqLz5A5RzQWwLUXp4
	 EIvfyhm1jO7nMJY6DOezeBKJKDz89YYOTSuG9nFVvBLn7W5wutwRdam5PxHWjfB9AW
	 OkfcfBzvd9BTg==
Date: Mon, 27 Apr 2026 10:52:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
 antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7625: fix type mismatch in clamp() macro
Message-ID: <20260427105255.0dd96e51@jic23-huawei>
In-Reply-To: <ae8Q0MtuZgMxCOM9@ashevche-desk.local>
References: <20260425071615.20406-2-giorgitchankvetadze1997@gmail.com>
	<ae8Q0MtuZgMxCOM9@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 10:31:28 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Apr 25, 2026 at 11:16:16AM +0400, Giorgi Tchankvetadze wrote:
> > clamp() expects compatible operand types. The period calculation uses
> > nanosecond constants, while the local target variable was narrower than
> > the upper bound expression.
> > 
> > Make target unsigned long and use unsigned long bounds, including
> > NSEC_PER_USEC for the upper limit. This keeps the operands naturally
> > aligned without adding casts.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> ...
> 
> > -	u32 target;
> > +	unsigned long target;
> >  	struct pwm_waveform clk_gate_wf = { }, cnv_wf = { };
> >  	int ret;  
> 
> Preferred to keep the reversed xmas tree order (no need to resend, hopefully
> Jonathan tweaks this whilst applying).
> 
> 	struct pwm_waveform clk_gate_wf = { }, cnv_wf = { };
> 	unsigned long target;
> 	int ret;
> 

Done and applied. Thanks.

J
