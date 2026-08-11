Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73333AE6E5
	for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 02:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786416331; cv=none; b=s2WGSYFpbPo9ebjGuIrJQA2QkU/a+eaElSGss4X3QAmuf2SBzxf2pG9C6q5dqEVp84QdlSQFYYOTdaafVzn3C9TeyFKnxNP4/LcUg+fZrlBYPm9eJlfUDNFnFUK5SKNsWK99+cYP+16TgzYmzehA2JfPSUZxkTx1cbNncBTrqNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786416331; c=relaxed/simple;
	bh=lX4DHJLmOFL2hJOsNkjbJDJK9Gej8ssxYmi+Jgr4XxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ab9jX8ER5AqY6OIxCD4SwCX9c8DBEsSBTPrADAgklDyrs39sjsBwFBcaO0AGMK29LZaz34V+ZBwKK0b6elpDVlePSxFpr4AHnkPWi43/KvSt+/rKYEelJUOR8yZ5pnlK3FEK7WB8t5mHDzWAdnyJudYHxOtTolE5RFWteFff3oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o6CB5ann; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6CB5ann"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbe827e3cb4so2790537a12.3
        for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 19:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786416321; x=1787021121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LhWDK5hddMROTflmtcNenCZqcdR+LSNsUsjL3zUAaNE=;
        b=o6CB5annWGCwgRV9gWqqHffxj8MtdMbCqK7ZywDheOG3P2hx46ms+xH14eP1D5KkwC
         TppXWbVHowRnzUO5Y5VSeBdhfFFPoBq8varq+vAgzqsFFZuN/cmvuW6kMAJL1s4Xu5Uz
         jRSz1JeOZeDhHeh8MxGCevor6J0KhWhlg1jCIUfqrkh2260I0g7d1BuYyTYt2Idw1Cct
         HRxnXSXPsy1qXq4S8c1l4ZxZEn1M7+4k1V9i1N1IQ+gwWPHw7IO5onQTdEfOcM8SYBtf
         /uSbFDlrQYesX/ygYvczqMzN6VsNyCtH1RACHRdliGHgMDQCOIkXgQjlGtZtU0QjzB1g
         qOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786416321; x=1787021121;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LhWDK5hddMROTflmtcNenCZqcdR+LSNsUsjL3zUAaNE=;
        b=UZE/mZX+/tj/vwXy1bk7/TVqw488ksJ14iDlSUPci3vI+U+De9lff+rCqe0vD+sQx8
         K5LUT0G+pSf2CMw+s6CcMe6o+RZ5sHyDJs01lNAyMQ0dS8DrJi5DG+WBdyk0IT/0bqrp
         /ZK/PwSIgF/d95HAVe+er1DrxHq3FuW/RwMSepQtQVSC2Kqbs4UJhhbwdP2VQ3LE13vD
         CwYIBFab9k7XV/oxf7oAYDQJSnWgkLzese4J6hlsXhyYGP5QOinJ7Xt9uuWC9LbEyrAo
         6qavsLFhwTJrYwFaJY5ngjDLleGeIAn8TMe2s2kK9IrHEz/rQxydDQ7v2+nm4EHDP8TS
         4LoA==
X-Forwarded-Encrypted: i=1; AHgh+RqheRbRZmVl1/DH422vgH+DuWW8GVbAwoOsChmVDgmU4uGUM1urgr4GfQ171iIs6GyaWGcqGUGZF9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMCoWSV+pGX1qcrHoQ15hZ0z4+KFy9NSM60EQv7sXjUU3h6LXM
	YgvfEAs5FTXUoMje0pXpz8ZKrseArqq+80FkdCTSssG57h7fE0jmDwqrPwOAhMTI
X-Gm-Gg: AR+sD12AOOEIErrhv2ztwLRca1tX+pz/usW+w7dhgA0WgQiX+6UYx68PywHSP5teo3+
	ERaApd+5g1tJuaZCovJWVsvAN1VSPi4onETgzugoRHQ7F7P8XgKROacPG8Bh96D5MPJG2WChN0h
	RoDoeIH2xxkT2ROYl3aRpaB21wxDnbDnVnoRW7uYZrk21pM090G7YEZo35SMWfSP1wWkK+Wo53z
	bsbGwEwf+GP5B66EI7hoXx/qY0ZwHKoaatDbChiednYB/mtRTTkCgM5uCXMHqiKWrRf0vFCu6ew
	uOohfVcR7mcKIQ8sZ6Q5PELdOirRdVkrTLhOfobljNatCADDLba4AZiiuRWQD8TtSdM++FskodZ
	IMS9i4eHvpP0g0c25Oi0170bdisB1o7zUp7LLWe6wJe1XDiDEygqKRPm8EPbhN0MusI9wmyIMXR
	CCwHel+0wnvReOYshw2KapXJF9tKQ93xC9p+TBeLirdlPFJdpt0ojVQduRSl+iggdC0TQ5U//BF
	H8kypDT
X-Received: by 2002:a05:6a21:1fc5:b0:398:8870:b58f with SMTP id adf61e73a8af0-3cc2b872b58mr522952637.14.1786416320953;
        Mon, 10 Aug 2026 19:45:20 -0700 (PDT)
Received: from localhost ([2804:30c:4018:dc00:8be4:f5b8:4af1:4728])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1412035e08dsm151216c88.1.2026.08.10.19.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 19:45:20 -0700 (PDT)
Date: Mon, 10 Aug 2026 23:45:55 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, julianbraha@gmail.com
Subject: Re: [PATCH v9 5/6] iio: adc: ltc2378: Add support for LTC2338-18
Message-ID: <anqM43NvcVhhkkWI@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1785186980.git.marcelo.schmitt@analog.com>
 <39f2ff86cf736ff97286d6451fcc45fdba6732f9.1785186980.git.marcelo.schmitt@analog.com>
 <anl_v428aTL6waBK@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anl_v428aTL6waBK@ashevche-desk.local>

Hi Andy,

On 08/10, Andy Shevchenko wrote:
> On Mon, Jul 27, 2026 at 06:31:58PM -0300, Marcelo Schmitt wrote:
> > LTC2338-18 is similar to LTC2378-18, differentiating from the already
> > supported part mainly on the embedment of an internal voltage reference and
> > addition of a resistor divider network connected to the input signal path.
> > Extend the device driver, handling the internal reference and input signal
> > attenuation, enabling it to also support LTC2338-18.
> 
> ...
> 
> > +static int ltc2378_refin_setup(struct device *dev, struct ltc2378_state *st)
> > +{
> > +	int ret;
> > +
> > +	/*
> > +	 * The internal reference buffer amplifies both the internal reference
> > +	 * and REFIN by a factor of 2.
> > +	 */
> > +	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
> > +	if (ret == -ENODEV) { /* refin is optional */
> > +		st->ref_uV = st->info->internal_ref_uV * 2;
> > +		return 0;
> > +	}
> > +
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "failed to read refin regulator\n");
> > +
> > +	st->ref_uV = ret * 2;
> > +
> > +	return 0;
> 
> I'm not sure about others' preferences, but I would do it as if-else-if and
> remove dup return 0.
> 
> 	if (ret == -ENODEV) /* refin is optional */
> 		st->ref_uV = st->info->internal_ref_uV * 2;
> 	else if (ret < 0)
> 		return dev_err_probe(dev, ret, "failed to read refin regulator\n");
> 	else
> 		st->ref_uV = ret * 2;
> 
> 	return 0;
> 
> It also makes code shorter (in amount of LoC).

This has already been applied to IIO testing. I do send another version of this
specific patch if that's okay.

With Best Regards,
Marcelo
