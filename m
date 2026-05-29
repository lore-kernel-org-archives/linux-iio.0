Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883AB21A453
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780058843; cv=pass; b=Ir/b7TmM8hi1NJNAhXzhdoUjB1nmsXAfbOBp9WQIRmodlhmb7WSzFP2YW8leSMTxk6TxUFL9OCMqNEQletMOA80VGwACmex1PpIfHGxsGwBgqbOo2/lPVDO/oNtPu2neATdiIr9gZI9RbpERUdPU5l9SvFZiR2xpSuihQhnYLxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780058843; c=relaxed/simple;
	bh=gxNcfrriIjSv2ErPB2KszZ+tnSTwuzgtq1xME5V2rQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pM3G5zBm8Iwsrc2joiUOs9B/RJZLDAmZxq3MbOqqtl3/qfsmFjrrAjq13t+wpOWJqeSMwm6NyE1JCO+AplYIgSdH0aYNSQNCl9G39ayYk8rD47T4rwxeAQ46Vi68/e0bF/DZen+JJiOflGl5mPLCkcWT046m8M145F0z7R3rUhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/5YKOQp; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/5YKOQp"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-304d8e3bb72so428947eec.1
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 05:47:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780058842; cv=none;
        d=google.com; s=arc-20240605;
        b=jbx1HhoK7mGN9fPmrR/2PSOKPYY6ik3wAhhPTeoP4w6N60fAQX6nwjjZw4Alu2+0Gm
         7bE30jtGI+2TUGHEZJKZr7f2m/5UL+rzBs9X8sjfAbW/kGlaPrC0uNT788CHTPGlDgwa
         hZPF7EMjxt19MKEKMktGAejAV47zA1E31/bCpWIfsykCXvgaCUZG69APHLpRu/kzOe4c
         QIjJS8PmlHfFUwawYH/fVe1rnwFkcUs4Xwai8SYbo+W8wvNWE4EhMLlOB58Y54O24RM+
         NF4El2Ia4HPfCX6+MgeHDPvkRdgkNbXMecdZHiWL3aLxF6avzmfy24nMYq16vC/zaRsm
         IUWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kxd7pDN4r+x1pc20wnNZSk5uzpveedLJxkfd4XwHmSY=;
        fh=UBjF/oaYi4vC6OARkco+8hEEXBrCV+v5SUUTBWTLU8U=;
        b=aRG1TyaFhamTvAqSjznszWXbkQwP00TTrO2DLfTUaNQaF39N86uxq1x2MFEEiykacF
         jO2RW1kZWLdOTQOXUMlsYaNZ5wDc5pD7l08O6z2Un5uKz9ayAbxJznp4JXBzqgrnF0z3
         /9YbrXY1bZ4FVKvgZ8c2eg2hTYM66r3U9gc+AT+bIzv90x/Dcm4KEDPOP5XwlUvS8VV6
         Q8Nmctp0ENAG6RMDqykqpNh4Wn9UBMxk9EiynMUhBQ6OG30nw02e8kofIjyGAYIAdDnL
         gOPUQr8jud47fJW2T/H9s46JrJ/uxJ4/9ThtUyvfD+23dOkMWI6dPrsYzYn+NLymii7w
         vEpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780058842; x=1780663642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kxd7pDN4r+x1pc20wnNZSk5uzpveedLJxkfd4XwHmSY=;
        b=R/5YKOQpsW9pcJs4cZKhF2RpxbLFZbFV27A5WWjHHAcmURvyN1FQ/6Cm6dv//GrICP
         iCkYDeXFR5uEDsA1BLuPbncwanrztBiPD/CuXO92m5msQZYZd9kKFAbwopRnmlGYKvsY
         E2ZcPkmidNZw1YSnoWIxiuNXqpdyjYF3RZmzgRo4WYjGkSCp1gwmwYdIRU2MI1475vXW
         y88IclEbFoW4+/cYnBXgeDeiQaDxx4pQNjCxWXUZ0GL9cFwcjbeuhbgS6TgRvqEE+bai
         STpxk0So7ENoB5hDuOEASgEp+FnfJu4evTHGFIqjLcCVK68Xp+gIvuAayz6at+A9998s
         /ubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780058842; x=1780663642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxd7pDN4r+x1pc20wnNZSk5uzpveedLJxkfd4XwHmSY=;
        b=B4IU3eQVIE98hBo7nlnXKU3eVLdrTaHZsm9UUz+1ugBd8qRWK4jqwqGrIyh7GWbipm
         +Ypf5jXuQQX7NAtqI5CBQXnNhL5bDWwp1ChwwROrPRl1ei+MEWQ0xzHw4meFCtWtEMCs
         /sx56fjTGXD4jsz2Y4mEy3A45tN4oA+Y4hsTZJvTlpTz9DlmKkwAvNNS8yRc+NSwhcT9
         9kLhoA2cEgL/uF0hqkPjImpzovmsukjNjRLpzm7VWDcCS9JD+IQT4vl/Jc0CrH77vdkv
         RIELUsw042eiJSi/VUOfTl5COmXMUTtp4oKR6JWv70n2oOwb7I7FcfXbZLqbiFim0YRc
         SElg==
X-Gm-Message-State: AOJu0YxU3tdjR/5CjxWFEY6zF/ej5OwFeNIsabk0nM+UTkw53V4P/9TV
	/5VXFWUFUVMs4fUFYKZ0tAw3GFXg4Xtlh3pDPa1X/Iur2xf91VkK6z7W9t4y/qp0+dyRFKoKozN
	494DF9mQvVO2aHlVUytlRp9KaB+1XWmI=
X-Gm-Gg: Acq92OHo3+FceTZ8vdsTfqBNqS+9tz0XaczdCArCroIu4pk9YF68QKoOQy8196HMFWC
	0zQ2IL2EW3/qRUskxijo2u+JaQmj0lMKsNkCduPmaHxpBIFap8nyqqW9leBCNxuZm6+OAV2mJjH
	tqw9JOkNRo8QxiYZL5wTr9UpaqKg3L9wHRLzXuGMzm1Cjyo8VfBv/WlihtFOhRe8MyhX7lqFKN9
	RRF+5jEN5hrrKBkh8bJNv9NChtcxuZeDpPlqx2Ue6vk+l/f5ADKHrdxQnIam8/93bjxoOHVqu9W
	R50+CFVIzsQzBPZsm977dHT9xH/jysdPbE6b0wlIfA4Ppl8AGqCgjVlNqg7fsSum7KtIrYWt94e
	Mpe34jw==
X-Received: by 2002:a05:7301:2b08:b0:304:e7ca:4b62 with SMTP id
 5a478bee46e88-304eb106cddmr1229257eec.3.1780058841699; Fri, 29 May 2026
 05:47:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524085312.15369-1-kimjinseob88@gmail.com>
 <20260524085312.15369-6-kimjinseob88@gmail.com> <20260528150636.38d8e091@jic23-huawei>
In-Reply-To: <20260528150636.38d8e091@jic23-huawei>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Fri, 29 May 2026 21:47:09 +0900
X-Gm-Features: AVHnY4IGxGowofBHcDiPlgbcncVC-q3E32X35d6DaNb4JwsYtVV5e3x015JdIr0
Message-ID: <CALMSewK0pL7hgRQsgn82zb0Y27RiQVxY+oj7nqRDQZ=b8cOPzA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/7] iio: osf: add UART serdev transport
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, May 28, 2026 at 11:06:00PM +0100, Jonathan Cameron wrote:

> Various things inline.

Addressed in RFC v3.

> Why is help text talking about a patch?

Addressed in RFC v3. I updated the Kconfig help text so it describes the
driver rather than the patch split.

> You zero them memory before passing to this.  That seems like a sensible
> pattern in which case this memset is unneeded.

Addressed in RFC v3. The unnecessary memset in osf_core_init() was removed.

> If these can happen add a comment on why. If not remove them as overly cautious
> checking.

Addressed in RFC v3. I removed the internal-only NULL checks in the core
receive path while keeping the protocol and stream boundary checks.

> Perhaps check ret in each of these and return early if set. Then we only
> do the shared path below on success.

Addressed in RFC v3. The receive path now uses a simpler early-return style.

> Given there is nothing else to do on error, return -EOPNOTSUPP; perhaps.

Addressed in RFC v3.

> Given these don't match up with things in probe() please add some comments
> to explain what they are undoing.

Addressed in RFC v3. I added a short remove-path ordering comment before the
serdev close/reset/unregister sequence.

Thanks

Jinseob
