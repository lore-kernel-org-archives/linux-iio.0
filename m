Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6A93D3335
	for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2026 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841552; cv=none; b=Ekxzmm6QQLwompTh9baagxGnqG4MnUWOZxu/iKWHBp9JYfDt1IYANWaYOv/yh/Y2jriOkxjMtZFGpiNhWMzgg1Cd5hqAE2PprGEnWKMM5dHetqaHdMWBZwsrm8JsgcX19PiZKczBenW4CCqaiq898YAz9KpZ3hOubQYRrLfkHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841552; c=relaxed/simple;
	bh=YIQP7ejzDG349m1rvEJbhDPG7v8UGmk7AIQiEV62gOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnwhhLxmH2JGrBVYSurVciXS8+mK1XMSRwUXhbBxgAZap2dlk4sTU9V9PpKUeIhCoPIkDhcyTlhJK9hTy7wSYcYxdDDjkq2CHBJyuqFjyB45pL4is0RnASKWNLFUdgLJjo1ozR0othoS88J7uLKt95xcqOw3ZpuObOz/PQaD23w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAvZAT8k; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAvZAT8k"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ab232cc803so32989115ad.3
        for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2026 06:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773841550; x=1774446350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JRxQVwH2F6WiA6bLH2qLvv2wOCsdbPiHOwcJf4Qqctc=;
        b=ZAvZAT8k+XkRMFyWqTSqt2OSUoxBmfQVQKSdcocI74DssFjNGjJaPDkcnquezB2eh5
         O/A+iJf2BftMvl5ZRblVg8VwvDowX2bZjNsXlSSzhy40snkRUlbYt+egpMYL6A6DbvQy
         KY8pzhp44rc7LqC9MMcbwN89ZwManulaTGPXTgiLq5PmppYkUzqYAr9X5229/ce+NPdr
         AhhORrfnnYc8uqEYRhGP8FACOi6FoZutgLnztSfspZzfz+Lm8srgn5SGV+FN2H2uMdvr
         OXqtQRf4Dqho/ghlzUcthUDdilleT23+lSqlJOKR1BYSDO7UtcWLG6mb2Rt7aibjLGQ5
         gykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773841550; x=1774446350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRxQVwH2F6WiA6bLH2qLvv2wOCsdbPiHOwcJf4Qqctc=;
        b=VL7aET7tA/V+Oyuz8iwx4QQL4Dj1nRVANrre0Sd0RgIXvQX5NC0NJWITS/QOOwIoZT
         dKK/ZPEqhNMR0fXOwadMOhr8Fi64DLe2+dJ+gvT98qPaxsZW+ZptOJ5OjbsiaV3l7mYe
         iLVlHZsgFrC95b4n4Fs3ki92a9mPDugrPEl6RnmjUXRsSS8EjI6nwySsItPFc4vtsK1N
         Uu3HkK9QNVYHBRbVKgKBg5lveA5DQ2ATnVxHLrnvhIfSFp+NwJIkuK+fajM7S/45xxh0
         EgOKeYQ6FASVQ5wyZ5U8EZtdNTi+2IaIzNumLeA7QKd9kPvQW4z5zA6y/X2Q6WTQ+7c2
         8o5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTB3BiQUmlHo7b6Ms6F0cgXxH0jAfcaQHzRrjOC1jT/pqmfg+2yO+4shNDs3p9UFWYrN9LA11rpxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhOyS5AC83t4DsNljF0uX5bz/H5SnbNlrhMOEtRZDOb71y8iTH
	nI4PuB6dwRvsEwtJgtC6iy9RskzsIojVuckNxFyPrS5p0VI87zOTlmzqfok8zQ==
X-Gm-Gg: ATEYQzzOg4Fw+t5ycYlX3R5xnBSODZRwyG9RueDEHzwuQEff0V6n+6hu4jS2apvzVnB
	sHKq1iMVPLc8DFI9mVCpQiip9XErsLeyaHJxUq6kjGiypRapW8NO2on49LODB4IKnYDXxpSgCnB
	NOAxoMVsB2Y3K5XbQtvx5uu5SUrY/vFNG9y8T++9WRVEZCK4Ff/fh+2E4QNNorUgFENPyti0m66
	BR563d7FfRU9BA0wmGiqPJ9WJvnrwDH75w91SQEnrJucTD1Kjp7IcrjHu15PZM8tbQim3nRcMVU
	9Ox8XQpK/NPLHQ7mxen63fqm9RzVGGoWBaXC6CPUqwC/WqFyDY7+EmEWhtUmF2U72FElxxHCbT/
	UqHSYrsV+ZcNwySNebOcqqkMmhoJ9iO3yHu+DB85yMsPpFzlJBlJZXHdgdOodoFftor33U+al4G
	YSylsPxnss+4w1F+r0Uw4=
X-Received: by 2002:a17:903:984:b0:2ae:5e75:3821 with SMTP id d9443c01a7336-2b06e32be1dmr34251435ad.18.1773841550416;
        Wed, 18 Mar 2026 06:45:50 -0700 (PDT)
Received: from fedora ([122.173.30.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e41972csm27769085ad.14.2026.03.18.06.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 06:45:50 -0700 (PDT)
Date: Wed, 18 Mar 2026 19:15:12 +0530
From: ShiHao <i.shihao.999@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	mazziesaccount@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v5 08/14] iio: resolver: fix typo from degredation to
 degradation
Message-ID: <abqsaI6-hznIv7dO@fedora>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
 <20260316090023.14691-9-i.shihao.999@gmail.com>
 <abgt1yoYTnQEiAlk@ashevche-desk.local>
 <abguXZJjIXMdqcU5@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abguXZJjIXMdqcU5@ashevche-desk.local>

On Mon, Mar 16, 2026 at 06:22:53PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 16, 2026 at 06:20:44PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 16, 2026 at 02:30:16PM +0530, Shi Hao wrote:
> > > Fix incorrect spelling from degredation to degradation.
> 
> ...
> 
> > > 		/* Sine/cosine DOS overrange fault.*/
> > 
> > Side note: missing space after period. If this is a single issu in the entire
> > folder, fix it here.
> 
> No need to resend just for this. Let Jonathan decide what to do with it.
> 
> ...
> 
> > > -		/* Degredation of signal overrange threshold. */
> > > +		/* Degradation of signal overrange threshold. */
> > 
> > 
> > (Left for the sake of context.)
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

hey, 

	Just wanted to ask a quick question. Do i need to send it again
	? or is it going to be accepted ? 

best regards 
 shi hao
