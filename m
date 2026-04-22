Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E713C276D
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850088; cv=pass; b=N/D1T1FxJNeaTC3GXVvpa+iuUMz4SCv26reiVGDz8Y3TutwB5nUL4M9025fhTcydDgUnJkCVMLjjN4mr5NqanuCGWCaZSSVE+H8Ce6UW4a7SukzpwztCoQK2sVE+UOtZr1eJpTrdmwJ2PtyVKTzkTqrMivY/LbgOz4WJkoqRPzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850088; c=relaxed/simple;
	bh=X/Rt1Pdm9uOSSIYyaVTPpgUoKj4VsVDL7zEWT4clByg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nd48DL2x52EQpX2lk5wpYc3JSXBFJzpyirVivSPtmgQ3QYHv1o7SkHfQjoGVWMLRYh3IUACNrKGbknmMUHDDQKi694PLRWjhUJIh4iwl/HuoIrL5GVIcO7waExhjxFyboDabI+AGUY14FfAA1neCU8HZ4REaA5dqIqnU84YFdsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGOxVmLh; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGOxVmLh"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so4808329f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 02:28:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776850085; cv=none;
        d=google.com; s=arc-20240605;
        b=Q9l1oR8orcr7SdYht35hYST3vPQ5r9A7u2HCcSMmL/2/j5pcmYBOWDijv+6vt9eo/z
         IJH9WbfnGHnAQvQvQ3jNMjScSPVmvJib/AfjQMKa0ikrKbITtFRuQKYBuczGffiCOidZ
         SzUZhB0sRLJCCmUivubvsJoHOrJC1S/qsiONEdH6JrRkn0DHND1ndy0hpFUiqfj1Hbny
         h/3eQOo7CJhfAXGg2bYKKvbl6WrL4U76aoWHkCX5YM7ZkmPhgJCWQrR1EagrBY11y0yK
         SaI18Q5xpB5lCj7RYR4NTKEEtfsYhGKgkHu9ylCeLUdUcWyVZCGwvscZGdOhJ31CBSlQ
         2RiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cUfXusHC+Uq7HaNk5+rncX33RA6OdFKY7wiC8tJos4E=;
        fh=F234r2uAPm3YRImWmu5AJYDpu1qef26hGQiFpyiD7GA=;
        b=B1n9B/lVst3yapUpZgv5nJ3qfubHXE74wwb6uPhLkTvue4XsJpCHm2sqB1WLrQ2w54
         vmmYUfC6kbBZA4hmOA+SiW8vWqiVMiOyxgjwn9M0zHOFktCVsxrsMSVHX1fvZlELdlRT
         +zvlJx1/ukH77Iz7c0ShoQedduW4kCrx4s5QJNTMIyljMknWQ9qLOzC2UOIdOTm6DeSZ
         9v7K7/3JckH1yeYoqPdkx2Jp3pzJyChAkqicOCP9t6vmlN18H3JsRabqDpY4HMn+Fh/M
         lcmo09Z38BGod6dPP3TxA8/TzHFPRBk8P5xWazhasWxBbsEu/aQepUVydY9Fom0HEmkX
         mlOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776850085; x=1777454885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cUfXusHC+Uq7HaNk5+rncX33RA6OdFKY7wiC8tJos4E=;
        b=OGOxVmLhkVS2AC+1wtyLskO5LR13DfHiBBhK7tx9HZrncxhlieLCG11vx0T4YJL7e7
         PDqVhJHFINjAgsyVdkUgX4341+LIv+A+Yj1KlQxyIB02+t13uU20vOPtM0RLv/ytMl5d
         sSLYV14dbNSHhemPLyTpcAz+hpsqFHlQn8fOT9+Fs0gzkhJTg/9785rz/GmfL/sUaDex
         8QxWoAjoUJXTUUaaAST1Gq7GoEKgJzaCHece8ByK0Ma+gvf0zYlmz5y9nOsATaeWHDpU
         4dPc9ZTOUiSnfTAxCcgeEocDNJRknJrxv8Iro1ZG+O0fXn0adci9LDPcyuyoezDiVkk+
         Ph2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776850085; x=1777454885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUfXusHC+Uq7HaNk5+rncX33RA6OdFKY7wiC8tJos4E=;
        b=C6igD8jqv3uZxzVn23flEE295Asq908nn3yiehFFooYnOLXEKfMczXtdlWlsoh29ax
         RETZk9yqCA8HF0d22f+Urj2Zkym28h4MbZzeCniuWTE83BYWVL5EFGDTCsHpFY7914s0
         fQINTyueVS5mRNtPSdjJzPzSQ7or0ZoZXgMjXX/yq9GyQcm0MNiBNXa7Wt48SCQf0WbM
         Hgu2dKAuec/CCyXGBAfTK3hSzhvzgp6U8DpF8YwK9jmzmcXjzPac7r9Ye3kNiPCtDevf
         CtLRVlGjvuArhO0ZArAzo2/q0uDACdV1iYc5NwEk7ovJs3rwumPQT87MX19nhBEP4+Bz
         by4A==
X-Forwarded-Encrypted: i=1; AFNElJ+iG5zm0wsC0lgYRSthVDF1DfAnAVeRrmO2PmuJf8B3zpAMAaNrnBsdXnJnlf1nOEVFxYDh0DXkSyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6gsglTNJ8Kh+dDmcR6Q0Fi+QFxWq0zBWWmV8XpUoai8xhnES0
	5KEBdXTZr0Tljvhw5opN2cwnqruRY2tG89hrm9AzQjOOuHIXnceU28P898IlFL89u40QMaidtT6
	ZfFv07ekkpVD6+4ivbeaCJeXHsedztnk=
X-Gm-Gg: AeBDievnmOlFTeqvgfOqWhmjc6FQGBq/jCBt/A5NJOL/Y/LyJPSUkhBbAUOx+p61aMu
	xfFvOhWhPLbtD2MoKsUu/oqCk+hcYl5EOAE48cNh661w537jHolk9Utnektce6HtuBwp84blXM8
	GeIYVm6SIo8jV0Yvr66ngkngVO7D1jFQ9Lc2J59KSsNGqjS6vSN9WO2Gzdkk0UPSjOV2hl3EO93
	DNXvHu/D5NrN4N7cKnVacmNKXlJUGmURZG/R34DGRvL8n2FSNpSFlPxoHDxJCI1SPooajUgts9k
	wwBfpvwG7/rynlSEFUzi7yIJfkovZ6uVG19sogNQ9nUsrxcEXobCyyDpWKXH4ajDiINC0FeMSg7
	w/SZ3Z1T0ft6WEcejJTmPnePkSTmtlVzockceg/4SyDigPGOAoDGbUcw3wtpqRckHCuv9nFporK
	LjDXlDgi8WvIAXg1da
X-Received: by 2002:a05:6000:2f83:b0:43c:fd7e:72eb with SMTP id
 ffacd0b85a97d-43fe3e144b5mr34681117f8f.41.1776850085301; Wed, 22 Apr 2026
 02:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421100722.1296-1-joshua.crofts1@gmail.com>
 <20260421100722.1296-4-joshua.crofts1@gmail.com> <aeiMPrBs4BJE0H_k@ashevche-desk.local>
 <CALoEA-w7T-15paJ2j2kGyaWjeK9FpHynS+vD0rpv1dBKEo3gcg@mail.gmail.com>
 <aeiTh6uw6yLW-D43@ashevche-desk.local> <aeiTzA73ePa_cNVh@ashevche-desk.local>
In-Reply-To: <aeiTzA73ePa_cNVh@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 22 Apr 2026 11:27:54 +0200
X-Gm-Features: AQROBzB3lMa8x-IP3jIU2OgDhsRLeqXc6Yh6Nzz4RKHWxKYIvoy6psrGMKqAG-Y
Message-ID: <CALoEA-zyWpNMLXJ9FGgYNCyFiDcO+F9VWMSDToGeV+fkDOUAWA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] iio: magnetometer: ak8975: change 'u8*' to 'u8 *'
 in cast
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Apr 2026 at 11:24, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> > I was not clear enough. There are double quotes on purpose. They has to be
> > interpreted as
> >
> > Please also add to your commit message this sentence:
> >
> > " ... the example of the sentence ... "

Right, my bad. And here I was analyzing where my indentation broke.

> And to make it crystal clear, the double quotes should *not* appear
> in the commit message from this example :-)

This was unnecessary, lol.

-- 
Kind regards

CJD
