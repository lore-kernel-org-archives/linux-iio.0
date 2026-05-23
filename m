Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789083090C1
	for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779559874; cv=none; b=Bhhn4YHbs3YlJgL2EVzFQeEtuW4BmOt3FgDvFY0xCDhAw4HL95DjQZIv3HGNoA7mZUWGdD85N2GBr4CHSuh4DuVy0UtSe0/ypVS4cw1MNNL+hGw0ApgYKXbz6ILtS1gKTYKXgX9dBZ0tpxdZbtXvHP1fHgNuOYkGLPVKDKjzsRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779559874; c=relaxed/simple;
	bh=NBWQelWLIr7h5UIsUW5fcrgUxD4JimHxlxbsVlf9ReY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTffJAJti5cH1G2pEXImsZVB6Gv40F1El+p5IPtvsRgyPYJkMMX7z2cZhTOscTacDmcqcv4SQxZUS3yoRxorYM5mvJt+Gs6WjTDO9YtJlQgbzsaZIKTSG9vBikCXFpWt0qcR7FeuuUli0Gh2mJl0N+acz5jPXr4zLwELRhlKjDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sd/RLjyK; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sd/RLjyK"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-6312d29596cso6330770137.1
        for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 11:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779559871; x=1780164671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8FTv60XZ8C6uv713dJk+1qHB/fuZySWXNjFpDMBsqbo=;
        b=sd/RLjyKFnex7YokwEDIjGBc19/D4r0+qGWnHNRdnSnQRFlrrM6HmqOQhz7VpFtQgv
         lwB0xlwRnbt9dHqRwoqkxDRp0Ug9wwSPjWCboHVwigguqFgfurJ9OtLucRrOWw35XRge
         xmpSjUnCo/C6jYQ6Udbva9IMhl2dBb42+lIT+NMChseveiR9SpXZuumCjCKQzmuXwz9k
         oA3c36lTE5Fnp7ASzXqNreYX3alGWGRdWQ7vmhln8kKIjMgBZ94Ks9Z4NAwUYZkYcYti
         MD9etvOg5Sr8AMc1XSrgTpfTDCjYAyDevEEALmx7qh6VU02r9FD4m4lrjb5l5/2u1bwp
         e5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779559871; x=1780164671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FTv60XZ8C6uv713dJk+1qHB/fuZySWXNjFpDMBsqbo=;
        b=VrCTej/gUwu6tFs9XXps0RYSJMsNcUZamFn9+oIkYRHiDIrsK8GGWyqsadCaEyUeIB
         /4P/V5iva8RDy58JqDvfAF/sE9I22OsR8Fic1AnCvj51FsIn9w6rw77AFakbhZD2iue1
         XE3YFXDEtGfjY1SeYb7K1msidURZ5I4T75aMA2DYjtZm4+boaMw/++KXUGu6lUhUVm2h
         lzCALeBktSM5eCLy8CWXIs9MWd2/zQ8TuQO59jYLWSB7mzlcTpdSdExtOLT/oj1yRKzk
         /BBmzZaMQYPNLrFc/WnxqJZxHsV1qlK5UZRH5RJ874WzLXpM4IyFiNHvwgnxq1cUAdB6
         2KAQ==
X-Forwarded-Encrypted: i=1; AFNElJ83rb0w+T92qe51NL6IADGn9GY9tN2a4tXWpoubgBiziYvSLUZuRC2y0M4SX3NF5n8Z4NW7b2ynNe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEgTTzpk6kqPaZkj9zFaK/8vSDTvMTnnWOj4FrpCPeAl4Bfs/z
	3PbEeY/qILgqs1QVYXq6B/uxDZoISdLtFH2LuVlMhq89MdOLGAmUEG/F
X-Gm-Gg: Acq92OEg581BseWq8VhghuFe3e5hTsxlKyHwpThTw80zoa465IOMvlFaYpDULdCJ19G
	kMxncekWhxKB/4b3aDdau+xyTfJxMQYutfYQNnQDTVOgF7Agl5G7JxcTId7Q/lDY6t9QDwIFIhg
	rJvhDV9EbX7XWT3wPkrsQnE9pqxvKSclIrjFEd697/buwzTqcutJT9gyP4C4mcMPKxaXIWgv/dE
	fJwk612N1vo8wj1khDcJ/2bkCHfriwMMClfqaY/g1wgmLnXcPtHMJcfYf/FUJ9qJ+jZzkWYP/aL
	egnghj7DGC/EnUeXmWNAtWFHvDPO9qkcrI5IP9qA9lz7w0+gkC8H3rrebrfDMNi97GO1j9Z5VvH
	Vk+eIyJp3XDqRvEy5zxSglfC6kekHk46qW0tAG/p4T3c7km4lmhN1Cn28Aycs+nLR8E7B3Z5DjD
	Q0/7bkCZsbs0v8/9QVZzyz7fsZzGGkVOL7
X-Received: by 2002:a05:6102:c07:b0:643:80f1:33d1 with SMTP id ada2fe7eead31-67c75870a04mr4870153137.13.1779559871070;
        Sat, 23 May 2026 11:11:11 -0700 (PDT)
Received: from localhost ([2804:30c:1f02:6000:8b59:7c96:762e:9faa])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96173b6d3a4sm5606279241.12.2026.05.23.11.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 11:11:09 -0700 (PDT)
Date: Sat, 23 May 2026 15:11:28 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: matheus.feitosa@usp.br
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, LucasRabaquim <lucas.rabaquim@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: tsl2591: simplify tsl2591_persist
 functions via lookup table
Message-ID: <ahHt0BgZimUSuJDQ@debian-BULLSEYE-live-builder-AMD64>
References: <20260522182058.199762-1-matheus.feitosa@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522182058.199762-1-matheus.feitosa@usp.br>

Hello Matheus, Lucas.

On 05/22, matheus.feitosa@usp.br wrote:
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
> Co-developed-by: LucasRabaquim <lucas.rabaquim@usp.br>
> Signed-off-by: LucasRabaquim <lucas.rabaquim@usp.br>
Do the above tags got the expected name strings?
Maybe you wanted 'Lucas Rabaquim' instead of 'LucasRabaquim' ?

> ---
> Changes in V3:
>  - Remove struct persist_entry and replace the struct
>    list with an array of u8 values
>  - Remove the loop from tsl2591_persist_cycle_to_lit()
>    as suggested by Andy Shevchenko
>  - Align tsl2591_persist_lit_to_cycle() with
>    tsl2591_als_time_to_fval()
>  - Keep the loop in tsl2591_persist_lit_to_cycle()
>    as suggested during discussion by David Lechner
> ---
>  drivers/iio/light/tsl2591.c | 95 +++++++++++--------------------------
>  1 file changed, 29 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
...
>  static int tsl2591_persist_lit_to_cycle(const u8 als_persist)
>  {
...
> +	int i;
Can now use in-loop declarations.
> +
> +	for (i = 0; i < ARRAY_SIZE(tsl2591_persist_table); i++) {
Hmm, TSL2591_PRST_ALS_INT_CYCLE_0 is not an index of tsl2591_persist_table.
Maybe start looking from index 1?
+	for (unsigned int i = 1; i < ARRAY_SIZE(tsl2591_persist_table); i++) {

> +		if (als_persist == tsl2591_persist_table[i])
> +			return i;
>  	}
> +
> +	return -EINVAL;
>  }

With the above nit and double check of tag names,
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
