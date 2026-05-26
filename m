Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0882D1303
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801336; cv=none; b=Taf3AEuwsZe9mumT/atJJZko/q74XvkSkrqmNPbh++Rz1FBRxaRo59o6qXwmr1k2ocXp4FcYLFfqRkciX7lmz4SByefOC4J+6RBJ14CHKojdA9POdw7PmoiTebPFPer6B7Hmm/EJqxN5sTQS6Iytu2DxY1ECorOYNxZVa87twM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801336; c=relaxed/simple;
	bh=zSBjgcvu6auRgA0TX0k90GlmfalJTICB7dmZHyZca70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2E3BWaTVQxPdIStsW9cD5NUsrR6dCu/pUkB6bsjHBDJG6FH5Uzwg67iXxOx9QKYrzo5MAC/yDlX7+pAK91PMOPomGaZu3PBIjn78Q4yO4wXlTRxy9RskgzjAqlBcwLww8AgPZsqsl4rs4x7eEQe0jmjzsd1YKHWpUeBv6CBm+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KupNge7l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KupNge7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434D31F000E9;
	Tue, 26 May 2026 13:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779801335;
	bh=rBaVzeY760dPTp1sUKmW8x86YPifDd0dfS7cYLq+IcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KupNge7llyVBfreA7I02DctYBA418oJ/DxiyGkzjlxdlKlXaYyAFTbgLOrtNhUBx8
	 /5Ken1HJpsPXiGSPxSUKZoNMzCzFwOA0RQFQy/l4RmJNpEhDHYYMsP6yJOj9um9mMQ
	 jlbroK6ObKMd5IU3Hq8e9MP7XqZerLRDcfSOkOB+lKCqtqJNrRJKFiKsCywh7TGiMb
	 lFN5+iL7N2C6n/plxBzb2ZovUPyQb/38Uyr46pSi4oSoVB5EoK1QSGqWU9g4kSnW3c
	 3t5pw2eLAv9aCOzw0I0UIwnUU8P2COpkGeknrCQOJPKj+fvLkbsWWlXS/k0kadkKUj
	 pA3uITt1ZNBCQ==
Date: Tue, 26 May 2026 14:15:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: matheus.feitosa@usp.br, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, LucasRabaquim <lucas.rabaquim@usp.br>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: tsl2591: simplify tsl2591_persist
 functions via lookup table
Message-ID: <20260526141527.2be50ce5@jic23-huawei>
In-Reply-To: <ahHt0BgZimUSuJDQ@debian-BULLSEYE-live-builder-AMD64>
References: <20260522182058.199762-1-matheus.feitosa@usp.br>
	<ahHt0BgZimUSuJDQ@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 May 2026 15:11:28 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Hello Matheus, Lucas.
> 
> On 05/22, matheus.feitosa@usp.br wrote:
> > From: Matheus Silveira <matheus.feitosa@usp.br>
> > 
> > Replace switch statements with an indexed lookup table for
> > persist cycle conversions.
> > 
> > Both functions contain redundant switch statements. This
> > reduces code duplication and makes future updates to
> > TSL2591_PRST_ALS_INT_CYCLE_* definitions easier to maintain
> > by keeping the mapping in a single place.
> > 
> > Signed-off-by: Matheus Silveira <matheus.feitosa@usp.br>
> > Co-developed-by: LucasRabaquim <lucas.rabaquim@usp.br>
> > Signed-off-by: LucasRabaquim <lucas.rabaquim@usp.br>  
> Do the above tags got the expected name strings?
> Maybe you wanted 'Lucas Rabaquim' instead of 'LucasRabaquim' ?
> 
> > ---
> > Changes in V3:
> >  - Remove struct persist_entry and replace the struct
> >    list with an array of u8 values
> >  - Remove the loop from tsl2591_persist_cycle_to_lit()
> >    as suggested by Andy Shevchenko
> >  - Align tsl2591_persist_lit_to_cycle() with
> >    tsl2591_als_time_to_fval()
> >  - Keep the loop in tsl2591_persist_lit_to_cycle()
> >    as suggested during discussion by David Lechner
> > ---
> >  drivers/iio/light/tsl2591.c | 95 +++++++++++--------------------------
> >  1 file changed, 29 insertions(+), 66 deletions(-)
> > 
> > diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c  
> ...
> >  static int tsl2591_persist_lit_to_cycle(const u8 als_persist)
> >  {  
> ...
> > +	int i;  
> Can now use in-loop declarations.
> > +
> > +	for (i = 0; i < ARRAY_SIZE(tsl2591_persist_table); i++) {  
> Hmm, TSL2591_PRST_ALS_INT_CYCLE_0 is not an index of tsl2591_persist_table.
> Maybe start looking from index 1?

Good spot.  Given the array elements are assigned by defined index values
perhaps use TSL2591_PRST_ALS_INT_CYCLE_ANY rather than the numeric value 1?

> +	for (unsigned int i = 1; i < ARRAY_SIZE(tsl2591_persist_table); i++) {
> 
> > +		if (als_persist == tsl2591_persist_table[i])
> > +			return i;
> >  	}
> > +
> > +	return -EINVAL;
> >  }  
> 
> With the above nit and double check of tag names,
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

