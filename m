Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08243BC672
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783145; cv=none; b=rqZ3UWaScK/PKiTOp09X8D68GzfKirmK2bg30MbTvHmd7HqbDZi6A7gqMunPnL+UYWyJbOqxJuPybG7skBtzgMqGKCm65pw4wggX/rqdSQVZeuo8p90aFutmg7ot/s4X/CvVVVZ1vJKqPZJXQpW1UHmcRZsZy6AL0a0IqwAEGy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783145; c=relaxed/simple;
	bh=YHxk1pnt6HsOpDIIWoM5EGKsJaR3LXs4k6Sr+YEPp/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UeBDay8jSrlbPuqfGzFr3kO5RdD+5Z6qBNvYfgbGbKsoC2XlDTunDgEe8IKqdxNCrbGwrvVlzduP9eBMRkcm6bwgNffw4DyK1xDDPT5nHIJGf113LkSJCcIH01WZuK/RT3Z7Y9IoN/pJGCdtb8s6yIDvjgHI9ewVrfKFUSxZPMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOl2/mxj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOl2/mxj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AABC2BCB0;
	Tue, 21 Apr 2026 14:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776783144;
	bh=YHxk1pnt6HsOpDIIWoM5EGKsJaR3LXs4k6Sr+YEPp/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IOl2/mxjKSEA+YxpG1SdG+nfch/313qM87eyJvsT60ir80bts/cSog71BWWhcdn9Y
	 7VAL//NjW36eqd42b32eJQqHY7Bi8pkF5CP+RO7h5WfYPU+Fu9kUNJ0A3WIISFlQe6
	 pvBU/R37zS5ea/da9Rqm5LWApSTw53r9D0XwVJPHKwxxyIyGnG5m9jdShv8qCFVRPT
	 OLrXQkKFwSOzVYZKHScIChPiYXmD85TWAV7EBLHArBiso1jvpNjgFnudZ57Yu6C2rv
	 PFRlYsnH7HrrNI3HEgX+6LIGXYVHKjv7CfzYFz+0UrCiBwPuqFM+mcDJsGOMWIo59X
	 Zob1VYf/Wk6Bg==
Date: Tue, 21 Apr 2026 15:52:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marcelo Machado Lage <marcelomlage@usp.br>, andy@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, Vinicius Lira <vinilira@usp.br>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: mcp3422: write bit operations with
 bitfield.h macros
Message-ID: <20260421155216.7709e87f@jic23-huawei>
In-Reply-To: <aeaLk7Cmhp7faQYn@ashevche-desk.local>
References: <20260420191455.529923-1-marcelomlage@usp.br>
	<20260420191455.529923-3-marcelomlage@usp.br>
	<aeaLk7Cmhp7faQYn@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Apr 2026 23:24:51 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Apr 20, 2026 at 04:14:55PM -0300, Marcelo Machado Lage wrote:
> > Replace manual bit manipulations with FIELD_GET(), FIELD_PREP() and
> > FIELD_MODIFY() calls. The resulting code is more readable and
> > maintainable, and 6 macros previously defined in the header are not
> > needed anymore.  
> 
> ...
> 
> >  	/* meaningful default configuration */
> >  	config = (MCP3422_CONT_SAMPLING
> > -		| MCP3422_CHANNEL_VALUE(0)
> > -		| MCP3422_PGA_VALUE(MCP3422_PGA_1)
> > -		| MCP3422_SAMPLE_RATE_VALUE(MCP3422_SRATE_240));
> > +		| FIELD_PREP(MCP3422_CHANNEL_MASK, 0)
> > +		| FIELD_PREP(MCP3422_PGA_MASK, MCP3422_PGA_1)
> > +		| FIELD_PREP(MCP3422_SRATE_MASK, MCP3422_SRATE_240));  
> 
> While at it, please fix the style by making the operator to be the last on
> the respective lines.
> 
> 	config = MCP3422_CONT_SAMPLING |
> 		 FIELD_PREP(MCP3422_CHANNEL_MASK, 0) |
> 		 FIELD_PREP(MCP3422_PGA_MASK, MCP3422_PGA_1) |
> 		 FIELD_PREP(MCP3422_SRATE_MASK, MCP3422_SRATE_240));
> 
> But, to me sounds better if you just resplit it it to
> 
> 	config = MCP3422_CONT_SAMPLING;
> 	FIELD_MODIFY(...);
> 	FIELD_MODIFY(...);
> 	FIELD_MODIFY(...);
> 
To me FIELD_MODIFY() kind of hints it might already be set but in this
case the whole value is being written.  So maybe just reorganize
as per Andy's first suggestion above.
