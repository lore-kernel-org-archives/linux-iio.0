Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B3A30EF89
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777016158; cv=none; b=fXWw5NCKZrqC8EkrmGbPdST5JqQ6bDePQJHxc5hA0b7sdYkIZutO+qda/Cfg6JdWkTnzo1gKBgWfXQBcUJaa64AGeZ5Fr7jw9uIF3BZRZO6ONYke5h07C4pgwDJNuRoH7F5WQCUbMMEWPisJhzOtooyA7kApYT8hkpbljpaLMA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777016158; c=relaxed/simple;
	bh=wDgcirggJduBcVdRsft7PykNXrKztvJ+7d8v88xJsoc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQY2/XcGQ/nV+YQ2Jj1bBZ9A1sN4sRDZSm2nNftZB8MPSiUOmMhlM21seCPc/WktI3vUnpG3cgwPpTby4Xk/CtIGElN2TT5nFVQ1Y8CtNctUtqbyrLdg3XI60auBdmmBCz0QkLvBc+70tpGwcRi0yzPVqbgJemt3IKQMgU9mOLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOLd6VB6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOLd6VB6"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso6438999f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 00:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777016155; x=1777620955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3o7ZPgK+KU82N6aJZP72mCPOuaPHic03cUfPsM2xL1A=;
        b=cOLd6VB6ZrbG0bDWdLWwbBehZiOi8Z1uPvgzo8dMz14WINH2iKKGA291sNLlIsjxWF
         VvRogTcwHflCsnbGKYy5QvE48D9H6sufRPlOHi5Kl3wIWW1fiwejVIGRV32aC58pySlm
         qfboBujzyP8yucqLRB3MkY7/eQCl3pcRzSJxpMPcLYMpRRHxpwr3EZxHZZHf39qGPQSF
         POp424KwlMib8NTmgZFTgoWKXMWNT/cg0tIVNnVJChSM4Szp2VKcf0OKuPgKeTvH3oJz
         tqP/0zarMpqkV5/FYF+QYGb+huqU0udwVX/ze4tgTXONYn+5Ucci5Pj9j5k3CX70BrGR
         bs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777016155; x=1777620955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3o7ZPgK+KU82N6aJZP72mCPOuaPHic03cUfPsM2xL1A=;
        b=CA7OhBA1otpFwN2ZqhZ+NMTA51kD/5IJMHdgQesG8Rj+pkVzxlhSoX5IUI+jqWL+VZ
         It6X3sYyEYq51Jror7wFSvGD4HUejU4iTqnM2J2fZHXbXSKMXjilrV3+fcVRGQpAN6Qm
         LiKGDGZRTc9tEocaQmsruxZVqLdYl+FDItAHoXfNcSp3gEn7RFY19Uuk3BQtkiKOplWF
         3UyxsYZRhQE7VEU34tfkaMMHUXx76ecy8xHr9/tYbFKyq4n0LZl8WGCFdp3KbPxTdSR5
         7da9y01bnc30tutbbfuNm9DD116cm7ofDAJX7fjcwLIk5SmM2Nu8nMLJxQBctX+lkMJM
         pvfw==
X-Forwarded-Encrypted: i=1; AFNElJ/aNWWJ7hOIuGN9dRE9JlaB9rFOniNgs0lqxZIrT9nUCZH6stVAmlMkb33b46xdQQVntW0KigRQ9kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZj2cAM33FTXF2gXc6SsErfhOe3TQLGU2LmOAvCezlEJbIV2FU
	XdsL/nsC+8qNrzZjJwRWtqJoU4B48OQIS3zshav7W1DtEGfZbtOj5rGm
X-Gm-Gg: AeBDiesBh7h4LqfSXSG25cx/0x3QYvVJAOvREZ2sqfWNCaMs/sx0/nmyORoUh8+9bMb
	+2WvvbZrn2YbOJgEPXKe3PhbbAo4z1VAcSLNjYTCxF9a1nHYuPCabktlPCdjCenZ+ZrfDSKY0BQ
	b4ThsQXmkfjJk+LYvFESrPKxsZvgf4OR4P/O3SchRwRa93LTApiK8RyrQDwDg2DyNWlx20Ng1bt
	aHXfT8aED6E55DeHGz+3pZ9+4m8swszmC/iDZkf8RNR449kcgPRC30TunVBKZTQG90EfkhlRwqW
	T9KVfSREPsFLs5glvJS94QijgrznzUl7FjSjzfUs7Q4iWRms23RV0Srzt6mlPu8Pgbr2rQR/yJZ
	kVMuD3RIrrR0ojIExEMyRMmbWl5NolBb0wXVCzq/QVXxKbCFfjeOC45ja1RoYnepff6qRJpkHVC
	YIQbD8ERL0HIg1osIdhp9kYr9cnDDwsyvPNLjSJSTL7gAvf8mx8BHU7BKkiqeTvl/8DqYNFoBMH
	1jgVW3/R6kTwtQ9gMGO9EOimWXhAgpOguTxIVQy68dGtqZHf3Z1Mnb2rPBemg==
X-Received: by 2002:a05:6000:2284:b0:43b:42af:75e with SMTP id ffacd0b85a97d-43fe3e23abbmr47806405f8f.44.1777016154793;
        Fri, 24 Apr 2026 00:35:54 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1176sm59625994f8f.3.2026.04.24.00.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 00:35:54 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Fri, 24 Apr 2026 08:35:51 +0100
To: Conor Dooley <conor@kernel.org>, rodrigo.alencar@analog.com
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Auchter <michael.auchter@ni.com>, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 06/22] dt-bindings: iio: dac: ad5686: rework on power
 supplies
Message-ID: <p76mchyeawpgqghojx6ww4yrw3fxxv7u32clkn4wwa7hzb3yx4@52ivn6p5hxu2>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
 <20260422-ad5313r-iio-support-v1-6-ed7dca001d1b@analog.com>
 <20260423-revenue-sensation-c62f759e457a@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423-revenue-sensation-c62f759e457a@spud>

On 26/04/23 06:32PM, Conor Dooley wrote:
> On Wed, Apr 22, 2026 at 03:45:40PM +0100, Rodrigo Alencar via B4 Relay wrote:
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add supplies for VDD, VLOGIC and VREF input voltage pins. The vcc-supply
> > property is deprecated. Certain devices require vref-supply to be
> 
> Why is it deprecated? Is the naming incorrect?

Yes, vcc does not exist. It is also misleading as it may sound as the input
power supply, but in fact it is being used a voltage reference for the DAC output,
which has a proper name, vref.
 
> > available once an internal reference voltage is absent. Still, this patch
> > does not add those as 'required' so that the ABI is not broken.

...

> > +  vref-supply:
> > +    description:
> > +      Reference voltage supply. If not supplied the internal reference is used.
> > +
> >    vcc-supply:
> > -    description: If not supplied the internal reference is used.
> > +    deprecated: true
> > +    description: Use vref-supply instead.

-- 
Kind regards,

Rodrigo Alencar
