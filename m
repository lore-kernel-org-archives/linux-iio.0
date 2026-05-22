Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D5938E8D9
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435443; cv=pass; b=IMmsB/9Q21hF9GUNTuJltzbFwQQA545Qw6dihDLWAfLHS1xwt681y3BlHqguXMh/FIRF3Mow25eXhc8SS2GRh9UEA5SP/3N1lIZsvOJLSL82jhi/FLeWHtkGw8WpgZRmAPfqWlENzODVIVUMrxJ9zPPy2psw82O52TFyV5crJQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435443; c=relaxed/simple;
	bh=u73be74yIOdobqNyGKTScnkafJc1cB/CNX2zNp7XSnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhWJ9CgdtCYYbTltEZe2zIUEgE/tAjIMfu+P05zFZR4pyOF2rDzJFyH3++u2U/ezq+wI9tvEbwTLm7zeVEaq5SgI66+TM/frS6kJuI5KSEqmthXKn5gEqXiNLImYkBrY4RXy2MtNy0Cfb89j0KhoNz5WMzCBkkcVk5YFjaO6IcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=by2hbN1K; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="by2hbN1K"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45e9f4a3510so1216514f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 00:37:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779435440; cv=none;
        d=google.com; s=arc-20240605;
        b=KJkw7NLXvwxLKbCwuKhfuQ/3MkL0FadqhZFEnp5Wp1Bt6BK3ZD+mllCncccG8gP+qP
         UQRME7bK4mTW7yepEtOnzQtIqD9nZRmoXMRhXdJVcNOaIQZQilZccxtmkPtSDBHcKEfP
         udCvQ9oKHE3oWyB3jkw/CxGDm1j2l4t4RdHIKhWmsMe38I/ethlxwAU9xp2pDL3AKztx
         fiADAo8vmbJMWIyZWeMlH4IuzLKMswW/dyOkN+ITFnm1+ww/rwSBIlWfYMQAT71taK58
         bJdUjlWFjRJNzd7mdUvco1kXohc8DON0Cv+ToqI8Pg8ttPeRojIuoWWJo0UdwlyApCAh
         UJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XT8tHMWexZpv+xCe1ZROIGgg7ftHFJ+LVIyp2FJ49AY=;
        fh=iHMrfFRMU1UBphMGRI4cFr4IlWSj00ARsC4L0CPb6UM=;
        b=cLr8OxqAPMfBMlECuy0Vvz6jnNl48qLdiauVtsYRyEYfHvEV0jLeijNljcvn4SKCyx
         /xKEXlej8ttm/iEOtGoafqaNX5551Q7VveI02Clda6CwP9XupwRlH1WOPCW3U3IUNB82
         0jihqgM4x/Zmct1tp9K2dB2YSEzNuXpO+GhzhfAx8Vvuk//km2KMBoveyNycEOukrVlG
         3koITKcyyusBK3GA5XqxVVOUE8BPInYKplnxPocO2V4UTXcOW5lasJzHs9KT90ziMQNQ
         7p2HMEO1I47RPnJfvWUAMRfBhHWRThC0mxpMm20eY95LyjTiplU4Syuxq/E0+arj+DIc
         J6gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779435440; x=1780040240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XT8tHMWexZpv+xCe1ZROIGgg7ftHFJ+LVIyp2FJ49AY=;
        b=by2hbN1KkwkmG3V8u6i6TNd9ihkpK4HTGD8lWGWJLNDAGmnTqR6drIS3qGVA1MlKb/
         tlesRWeVKSIbuwSrEg+9e3Q3ckqDBCwZXhs2D34J5rpokxa8t5z2L6DTT51gqtYmYXhx
         vqXmK/kH88VI7NrfMziHXNrLDdy40W5UEWy8unKJI67Uq9DnjzDsH4vJJo1H9aLz9PPd
         JvKfrQsbe7OZQDqRgiQADW4tfvtpMCmxyQjA/+/utHGGqDHvIMwDmHxF19oZ4lnyXvCg
         X86aPvotKIbIKsnh7YgeCn1mViRYxBDUVrgrA/OOh7nJUGSi/lHvMIKIRFbtSmTPC3kv
         8Zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435440; x=1780040240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XT8tHMWexZpv+xCe1ZROIGgg7ftHFJ+LVIyp2FJ49AY=;
        b=hd4TFh/zCn3/cN65uKo5clmzgZbgG5dz/D5u3XsD8/1mAmLZUdmhnMfPh/imaFUrPn
         MSWYBlMDuqy46l/+UuBrU11NhEAW7tgBzphPQT4HfLHtdNctAvGJMyUiXf/MXV5/RlKB
         NqlreNqVvXSAh+PMCn2FdDZLvWSxXqbJfl/rXToacEaLBfDPNbgJcAYt60IgJmV79dIP
         GyfU6IcqXBFyQ+nvUqftsKz1l7K+L0cBjV7TzEtpoZ/Vv1ujjTgIe0h3jPmTXe4tiEzH
         qdDnJr4R5MiCrQjAjuH636XfUEMLr1TCkPUsafm+4VeuGwIMOOAIYvFft/Ptf0dYayMu
         QaQA==
X-Forwarded-Encrypted: i=1; AFNElJ8BUziMy69VArOD0qUwXNzzJ3FUjYFAlISHK8ClLkRewTBXtHMwJOMqLvR7PAckh0trCv1u5fAeo38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdjD1X5QHGXUPYz3EaBPCOgrTijicJz1Jsl3NqxLCNfKqQgd3r
	/9KL/Mo0ulmlmeJxgSuu43WPtnyebGMJA6WS4V2J736v67JwrqZsOU8GJwdwMvdGn4eFyc430vf
	doVqbF9JLIR7UhpL36pDaAYN+LFPaqxU=
X-Gm-Gg: Acq92OECWR4RsLQGPeDB2WCMZYlULrSEhMmcYo0sBRywHLnWdKkVSa4Mr7NgczvbyI3
	EF04f0142KpZtDOu+YsVzpqz1PHA63ujE3OvzSuR7pf5Q51CBSsMjHsuEXGDnIktRGAxNdkJV8o
	zGXPgqJIp76TDnchs8CLXYKyFEm76kkkYHpinoP5kMqPZUUJE2S4SEAyn/RQr/xjVGiLp9Z6qPP
	6MJKqjex21Rrk5SVpKkkOAEuGWT7g1tJstOn0gGxncTedJ7qmLHW8gbTNyrSwjwVoHUwePy685k
	s4kyHazDQxCMra/tbVz5veRsNVDMv8ORzdTFMgdU+xgNtD3DA6ZEqwy7XahjlRDXY6iHtff93C5
	oVVKCMIiAOztcDVcMXCSmUHTQ2zBMHv18iURso6nyjgxPO3Nc12Y9jaZ5H9ky22JezG8vI49mIo
	4qjlIFr4GnjLqIuwe1
X-Received: by 2002:a05:6000:4606:b0:44b:cb31:b767 with SMTP id
 ffacd0b85a97d-45eb38bdf65mr3228502f8f.36.1779435440425; Fri, 22 May 2026
 00:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521164323.770626-1-liviu.stan@analog.com> <20260521164323.770626-3-liviu.stan@analog.com>
In-Reply-To: <20260521164323.770626-3-liviu.stan@analog.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 22 May 2026 09:37:10 +0200
X-Gm-Features: AVHnY4Ip-_ZGYEwV54TTHL5V2TOhrgQyjVFPodBlztyOzZfkRbYsFMNIXO3g8DM
Message-ID: <CALoEA-zkTDYBUVs1rxFQxEaJio71YmgdowqVGx7toXUpAnj-Aw@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] iio: temperature: ltc2983: Use local device
 pointer consistently
To: Liviu Stan <liviu.stan@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Francesco Lavra <flavra@baylibre.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 May 2026 at 20:17, Liviu Stan <liviu.stan@analog.com> wrote:
>
> Some functions define a local 'dev' pointer but still use bare
> '&st->spi->dev' in some code paths, and some don't have it at all.
> Replace bare references with the local pointer for consistency.
>
> Signed-off-by: Liviu Stan <liviu.stan@analog.com>
> ---
> Changes in v3:
> - Dropped the Fixes: tag
> - Fixed one remaining dev_dbg() call in __ltc2983_chan_assign_common()
>   that was still using the raw device pointer instead of the dev local
>   variable introduced by this patch
>
>  drivers/iio/temperature/ltc2983.c | 83 +++++++++++++++++--------------
>  1 file changed, 47 insertions(+), 36 deletions(-)

LGTM

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
