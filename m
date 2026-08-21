Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59B947CA60
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787310238; cv=none; b=YN7GOJzZzhTw4XV5vPp3LFK3EdAEwwmPGMOwBiqNG+t3QVblfSqGf5fdP1oFkCZVMWQz0hUB0HZg+b/E7OllOGKC1BOOs0geHoOcRjsq19eoQMnF6UVIRRWkQudX5LKydupNzFjASUsj/385JLERW4lVx/p2RavnVyX7iz8/GKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787310238; c=relaxed/simple;
	bh=B38wB0vUMdlZRx2N7kf9ZWst50Iqp8nsPF5uH+lKrGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7QbIuW14lYhoa/+zw0AWF6kMcjW0MT+jNsorMgYJG/1hiXNSsQyGDl1cWoTecFKQA7nNlLIA16Fz5I9uNf1VKi3te2DKhYVL9ji1xD9HLjURQ2aKAvW1wOXoRwreoyVIZ2zU57cj3RVNIHxZCRrpkoH9ctL8rhHzjLU4w5FZaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F61Za3s+; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F61Za3s+"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15cd3fd760so108981866b.2
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 04:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787310234; x=1787915034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pJu78dGyTk0n73zePooVLlpbfkvwvlQMnvrMH6WIan0=;
        b=F61Za3s+8rXlDe0ZAz+ukvDz7sBbHNEQrRAtwigWg/ZnmLRyJN2gByduRRnOOXO7OP
         y6k1ftCxt91+kw1+yiftNs+wCPLjXWxaWTFGNRsTy7DJzilA/D00xUZCba2KZ9TXQ97M
         5kLmw8jInGX8qoYrhqlXr0YnxBwojWp2IHNRzcDHzXTxowFA1jOmkQj/EbzS1VMy1zJb
         HcTb5lXEpp7xhxEKb6x1/zJ9oFX1H3wlXoGBHyD/gIo/QqLpdZaxs7eQl+w435xtO8tP
         buOc/2fNGTvMTJqfB0GU6tNkKbDH7LCJr/6wo+pNllDMB6vMYJ0jMPjuE6yxnZRx+gJZ
         EgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787310234; x=1787915034;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pJu78dGyTk0n73zePooVLlpbfkvwvlQMnvrMH6WIan0=;
        b=FQBcDK2VqhN3rZ9kqcEP9uGuonRUTlHttloNVncD/KUo3exi2fNkVEkUywWfNoVqck
         Z6W50xWZ1FvODU+Wh5m1/Wyz/UbB3EHid20ZuWPxsPzYxLQSkZ5WrlDOR1UihjrCQnN2
         lbdRUxLxoQ5KgtDMOllIwRlU9fYp/9oSBnX78OBAkgZ6yvk8tOIkeaj51DXJw5NoLr2M
         MFYjm65BJ3CuxM3p20nAGmb8FGOJPnHr2xy8Q7mMDQP3T5tMYKj1bsyES+9BcuUwdCz3
         egOGzwzzwMcgB/pmsvG27NsK3MMzrgADhGzdiRq6SecuNrJVNsz/oyFeO+WYq9awKZ0k
         rB3A==
X-Forwarded-Encrypted: i=1; AHgh+Rprt6kZ+e9H+IIeHPoIPZGaLBc/NY899G/cyiudxhnGQBWPw+Gonxbb97Our0/WVmPhUukEv+6BTH4=@vger.kernel.org
X-Gm-Message-State: AFuF++kSBMgH8HFavsSPGdWQVTMghtj7JZlr4ez6yA4QNjLxG8tm6bOd
	X2Nf76BPholI9iaWn1EWwy913CifNs8bgYwFfxH6S6Zin/03zQk/uDEu
X-Gm-Gg: AR+sD13xqMTFuuC9h3UJl6AcwmTA+Yexp4/agrVTvwIoLgPh91NvG5nju+miOdblAQT
	cuyLU6K2mXiCMP7YzlLesZgxpaUrN52wyxoPm0lxJYts8BqXqPpryHx9/J25tdXC9qmS/EPZEWs
	uNbcPUS4k7BTzMv32mCD2GU6uyMCHgMOcHAEbT9SGnqphKGksC1TTPmqIskTmnIrJHw59E+CBCd
	FADEJHIHmnewOgl1XLLX88O4EXjHloR30ske+xqjLJF3hNXoLg5gE+txdXy7K2kl8IC2T4MQi1P
	GPO6ehyltaJ+tpxWjKOPTICTOVG5bIN29VuOO7ddIbyvjjVfojlcBemB+Ynz955IZSbpA+MFtyS
	64HSW/fnXIXbHCR0vQsHcBHKTOhBT9iBPDQ16Pkpm8yfR4mvHzL0YSBMGfMpdWev50HKAs7YVPF
	q02bu9iE2vyrcTItBi47OTBd4Y9p/+Fil6L8b2hRDTzcU9unr/ymN1RcobRihJlMO5HrRYCGi+G
	oYMpkKVBow5OVI4HGnIO4lknTvfUKyEAagai3B++ojZ7bDnVxKyPPTwJSj1qj1wY7aRMssCVCe2
	eFD7Ge3KMW1DgZhbIlbvTYvoXz5jAEyzCRXOMYd98c7dB31ql1GSfbogBzKCD5JfFoqvcwPFiA9
	OqfT1RIQLN+uah3HjjqpOebzLuGUpLSxf+ufsTqdwgNJyzYpsU1/qX0Hr+XD71HC0LfYkVw==
X-Received: by 2002:a17:907:e1c5:10b0:c24:6445:d19 with SMTP id a640c23a62f3a-c246a7120d4mr413937166b.17.1787310234188;
        Fri, 21 Aug 2026 04:03:54 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2458b58a50sm456656866b.26.2026.08.21.04.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 04:03:53 -0700 (PDT)
Date: Fri, 21 Aug 2026 13:03:51 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux@analog.com, linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: meson-saradc: Make sure clk_init_data is
 fully initialized
Message-ID: <20260821130351.000052a0@gmail.com>
In-Reply-To: <7470364f0d70b6e9c06fd094768cfa91c7784d42.1787240005.git.geert+renesas@glider.be>
References: <cover.1787240005.git.geert+renesas@glider.be>
	<7470364f0d70b6e9c06fd094768cfa91c7784d42.1787240005.git.geert+renesas@glider.be>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Aug 2026 12:04:06 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> Make sure all members are fully initialized, to avoid such bugs, and to
> prevent future breakage when converting drivers to a different method
> for specifying the parents.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
