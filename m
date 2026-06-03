Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C67352F87
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497770; cv=none; b=H95qtOcoWQORSwpTe5pJQj1rAFLV1YY07zXN+dDN+rstV/YHXdF23dy3fZJaiuFr4izqf7VuWiJgjNfpcFyE+4PGNnlBW8UcMXb+b2g9CW8Xt0ZFgWgY1oE/vZYEU8pZmm4Q9DpmjwQTcz5qJOWW/r6UZjZv6NLhUy2CvPYsGdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497770; c=relaxed/simple;
	bh=TElSRUVHBNGTnko5oEEDBAu/L+B9LgigDWbZewSLW9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLGDYvFRrcoBcZD9bEIotq402ZKCdtTVv4Ad7qdClJrCHQb0F29cymQxJgLkrjTCU1tTEU0xjMcnZB7X2sHW4ggWXQ44xJLX4t7DDbfOBFG+xn48abRr07sJxhi3+86VJCykWFoDGff3t7iKyDXgNMaHPq4OxLVMmpLHCjXvNkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBx/fM1y; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBx/fM1y"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7e2f3646c10so49021167b3.0
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 07:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780497768; x=1781102568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rHKWer5YzIktM08gYTN/IYle79QxK5fXHWRMtT9CjIU=;
        b=nBx/fM1yzPAqi/VuwUplae+U9iBBMedtRsHNR0VBATfa1ALwrC/UNy+sjVLchIS+zk
         gfTFe0j2c1gyNRDOM1A3Q7G3mTceA6br3d+eZWazFG4OkyuevsChAwRqCuHtaZXMO1v7
         4lpw2f6GOxBTlpW8bQR/+d3kVSQEayXOv1Jkqvjosb8+KuyNp9uFCmKlv7C7KKb6byM3
         kJNUVNxkmLxaYCH5kBW8nsml9VMMhmhDjpw0j40DE7HfdObWbdlDZJaD+YwzG7y+0KT8
         i7RFf/88m/5vbU0L+pHbjeP11TWLpFpcBxpSKwGdDNVxjZ01ciZzV4VXbzXUv0H2POMA
         XV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780497768; x=1781102568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHKWer5YzIktM08gYTN/IYle79QxK5fXHWRMtT9CjIU=;
        b=nbBhBK65RTTPqSWF4NwETQuJ1A7IHlELZ2eRSn7PXV5Hvg8zlwK9xQPPmkbbMaSCJ8
         RMqdkGo3t2HuhIKED0BLUuqYeSZP0eVFNnUYc0sgzwRRv0+4RJ38sKcpqqACMoBurf1H
         zVYDvr5ESTUItJFgou3v/XQXVsNUeHTvW0HUvTMfqqXEbDEvKf48r3HcEe7DKKJlneel
         WYzAS7p8+Q+/zTgiwfolsMgJGjDgLaqXoKhP8oHcHhhbJ7dEdNZ/zILlwsgXeAJ3CnF3
         FaJDOvp0JKuwEMWWNElB7PSd34wfo4TGMIme7ZcsgxUmTXb/513AK585v7Gr72BVv1JL
         p3XQ==
X-Forwarded-Encrypted: i=1; AFNElJ+IoFRCLYVRS9r1C74ayohQYH0a3ZA1mY+8qW1EF3GYldOgS1VTvv/Egf6rIjxKAfQkoPsiumlWNTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8WdqP//fru/BTRszMhQfDZ2UA3oEsd1ogcNSU2YuRmuNFla91
	8Jno0GoP6PMRenhQS9qlR5v3odlN00U719Kh16XHF0VisYrXhMBSd4to
X-Gm-Gg: Acq92OH1hICh4+XAqlpIEJxZiO6Qq3G2dHymRW4nh8FRetlAIze/e4H7klRL5Acr1xv
	xF7qb7UiYlcoiZl43mi4AK5OV59EY7Q/K75V1rYzJ2Q/BmUSginpKQgpYO0GY0uuvBpFbwE0QVG
	qZuoYuIM1JcEurxg65C+WSedoufsyw5L6osjSPcpk4V56Ja46ZwClgV8ErxmFp9as3U466zAvh1
	rcF4EllMXt37/NqLEOrT9Spd/HcNBOtIK8G8Oar3SalOW0NFldpTXF/B7IbM+i8mY7Bxw78zT4g
	D3fAqA0b85qC4+xd8ZiyBVdGKbiaeaDyuyrXdHpqL8tJvJT0Jgz1MmTlUfgL8U0uAZSiyuI1+Fh
	nQNRlb3vppI0QhdSINtSR/OixZ4hQXvPyEj+3hoFNDtJfY9sQ+sPIa6hHxC12KsjtKY0bIWGRbX
	iHXMQ5D+EloLO9QbisH/wgCc7cwjyWugzq6Njfo7bMbI4vNVFgnSdtYw==
X-Received: by 2002:a05:690c:6806:b0:7d0:261a:692 with SMTP id 00721157ae682-7ea4b7e7289mr36006357b3.44.1780497767939;
        Wed, 03 Jun 2026 07:42:47 -0700 (PDT)
Received: from localhost ([2804:30c:1f02:6000:8b59:7c96:762e:9faa])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea2148b48fsm17466527b3.12.2026.06.03.07.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:42:46 -0700 (PDT)
Date: Wed, 3 Jun 2026 11:43:14 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: flow: add Sensirion SLF3S
 liquid flow sensor
Message-ID: <aiA9gjJzWuX6taWv@debian-BULLSEYE-live-builder-AMD64>
References: <20260530205435.37326-1-wafgo01@gmail.com>
 <20260530205435.37326-3-wafgo01@gmail.com>
 <ahxzpBcqN6o6q4a4@debian-BULLSEYE-live-builder-AMD64>
 <20260602-slf3s-v3-reply-08-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-slf3s-v3-reply-08-wafgo01@gmail.com>

On 06/03, Wadim Mueller wrote:
> On Sun, 31 May 2026 14:45:08 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> 
> > We could add a mention to the IRQ pin to make the doc more complete.
> >   interrupts:
> >     maxItems: 1
> 
> I would let interrupts out for now. The driver is polled and in v2 the
> feedback was to not put properties in the binding which we do not use. If
> later a board uses the IRQ pin we can add it. Ok for you?
> 

Well, okay for me. I suggested that because of the guidelines for dt-bindings [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/writing-bindings.rst?h=v7.1-rc6#n17

Though, TBH, I'm also frequently tempted to leave interrupt properties out of
bindings. It's not uncommon to have IIO drivers that don't support interrupt
lines and, for those cases, having to describe the interrupts in dt ends up
becoming just an extra task. Even though I don't know/recall the reason why dt
maintainers have such guideline, they probably have a good reason to have that
(right?). If the guidance has changed, then maybe we can update the guidelines
for writing bindings?

With best regards,
Marcelo
