Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793154182;
	b=IXBoyWifnOj28KB/EClLSELKgGnlzcfZ5OXP7UALWefG5LeRcI4tQijPrB6IdmBzmDEn
	 O4CDbyHcBrrL2PlBHlAhGWVsIt+J1sgsGupqvn2Hf6bhxRfCHlQOEAjpCenjjQ8nh+Nib
	 dy3Odsd5+X/uKWP5PTJwJV2+GBMaZtlAE7nx4fm/96PV0K5C4I65Wm4/kaYrErbc4PKvP
	 lZnvQCRcwGBdXN0Fh1AqaJ0KmCNQQZCTanynPoLsZCEDgF0q75+xsLPzb/X5q4m6iRKhn
	 gDKH5ArWW+pymekf/LImZ0tY+OY8YfynD36Ym2e4f11ai0FA56E3noQgZcAmlnEPvgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793154182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=g0KBJHkcotWZ5pbwfJssjN2rt/eD5H7NBoxiLo804zM=;
	b=VPov8OIqaxeihb6nY3iAbFGKC6lFK/SmgOKJbRgu5H05e/Dx/qS6uJPa8lYdkptyaBDO
	 pxpLzRm4AP3+LnNaqlYCmhKl8R3ZkTDtcwZvx0Iy0X5ub25iAh4Qt6yBEpf9SJvy3sX0E
	 8FS8tF/hBGvFVyXcc81TmjKC68GxMH7A7Aajos8DiCOlN3AExFhefe2NoaO82gHrsKPW1
	 obDhicjbbVhKJUGAQQVFV9N/7MuqsQPA04rdzd4VR3dO2FSHENfWseJkto+xS/9xEogQs
	 wPWRvRTCuxsP+3U0qVVpCliMOKzx1L6OhIAPpbznbcaCWr0pfOetq2+0x+byU0vu/rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X0vXpkTn;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE68606A31F
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 02:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCE68606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X0vXpkTn
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7cc0e865dd1so151081137.1
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 19:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793154181; x=1793758981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g0KBJHkcotWZ5pbwfJssjN2rt/eD5H7NBoxiLo804zM=;
        b=X0vXpkTncO0c24ApbUJZYem4GIl8iQWduK/bkG26GR/UO7EXmUkft+ww1Tb75uaqcg
         fRDfq3P5noIcxXovYJO0g/h3oyY2Hh64kGK5itnmtsyyJ0qv6nS1ueBTjYKFwkeSxPXH
         NLattyYQ8cfA2i8ISYabPgyNybVL2Fyq41JoW+Hy2tq5nQli3KvNNo8a8eMbEJO5B1+i
         srMKZT7AIVHCgryI9mNjOGC2FZuD+NlME1j3APWs62uLEheQ8/aB0Ex50U4uxoiSJLUX
         6HpHaRh0ZQnxw1ykxtaS7M4SEO/RKhbLxIlQhytiGFJiyuukg30bxOpRazyZg860/Vq8
         G80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793154181; x=1793758981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g0KBJHkcotWZ5pbwfJssjN2rt/eD5H7NBoxiLo804zM=;
        b=oCgyVOpbQXV4Ti0V5fxgctbKCxDzvhT2WtzmsAo3RT/OW/XtxRABm5wh/hGZIyvK6P
         WudtuLTcSuiaKFTZT9yP6AUIBvjje4nkiUI90llcxBrPYjWS281ArE1TdxrerAZ1xlOQ
         lAqUQ+a78586Drc7IXva3ho7Ms+LV2hcARsgJ7F0vT7qSQHkf2SywD8ZZ5kCOx7tgE7U
         boFWPw6I9CJpfRmdzEsQwj0sc8QgWmpFWeE0w9U30uj6l2MYEXAop7fCELOFMJ9Jgfe9
         a8fCyuHw4V4u8EVTDL17GMlOvQRPVs8RT1c2NAlpiMKMt3B5gx47LaoIMRTzCd5M0nV6
         fAJg==
X-Forwarded-Encrypted: i=1; AKwUvBx/JBi7d29+WPbFeD1MYolOfBtnnqpC9v+Ty9hn5kRU4ffBqpUVjSkjPI4G2BhAmcW7/GqoCYSpxyg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcOlbXyi20Wt9ctW3/FhezIwBybtgaNgJKNhZpdcFcFNkqcVe4
	XANrVG8AX3MWvFVSl0ueH3VHpQWKExh8BnnVAF/BeNpmpXCNPmmU+Q5a
X-Gm-Gg: AYBFou2O8XjAN9ahUrj8oV5LC9o2mpHWZAZBCsiu9ixXg1+6O1YUrVfd7jPtOdrf14R
	r6q1r+4piVodME4nAK4GXV38HDom3lSjQHlXodrrHjGQLXYhak87Va1oUcB/+MoRTqI1X5VIMT0
	E0SqYG+XU55hsoZHVxrJJJdEifNkIfa/VsK8LBx0g2MDiVOBTPHTN5bTTOl1XguZPt1lFUOdg5o
	YXXQJGrly5L4KcXGDLPJOwhRxCAoxdjSBTOCf3j6YbTzAioL3xdRs7Hl4ePE2BvOJ/eZUqllsxW
	0Wyof/1jp6aSBVw7MKR9rdZm0hXB+iMGL7msfhHteYBTOpc4kFnawLhOfrm8DpMH1jG0ntntQ9V
	yD3WaVQnNzjJjhApv69z7wghdfIouSQhlJJhBPaMp7ruhS8xVh8QtGeM0Jp14H9is8jnddUzfuF
	w20WKz4E8QV/2m3OuNmHS1ruPrP/yrqAstXETrwHKtBlkOdZeH/Rxd1PqaT2S0reb6sqs2IGGNA
	lEbIgGhR6MZLppAjXnTMSbdEvlIYdupWpngk1Hg1oeOLcH+0wDetI/bDZiAOzoe8N7dWjigs2kQ
	HVqgEZgxP8mUoI9Sv2w+qMof1+dyPEYtXOfaItEhPF2UBbr/AI8G
X-Received: by 2002:a05:6102:1626:b0:7cc:2bb7:131d with SMTP id ada2fe7eead31-7d03a4eabe3mr460742137.9.1793154180806;
        Tue, 27 Oct 2026 19:23:00 -0700 (PDT)
Received: from stephan-Inspiron-15-3520.. ([2804:5d20:6009:6701:4df:52dc:4559:394e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4f8e0327sm414520e0c.4.2026.10.27.19.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 19:22:59 -0700 (PDT)
From: Stephan Costa Barros <stephanbrrs8@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio: adc: ti-ads1298: prepare for more chip families
Date: Tue, 27 Oct 2026 23:22:52 -0300
Message-ID: <20261028022252.30530-1-stephanbrrs8@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <at5mQNfPsoQFyraj@ashevche-desk.local>
References: <20261024231335.280955-1-stephanbrrs8@gmail.com> <20261024231335.280955-5-stephanbrrs8@gmail.com> <at5mQNfPsoQFyraj@ashevche-desk.local>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Oct 25, 2026 at 10:27:44PM +0200, Andy Shevchenko wrote:
> > +		*val = regval & ADS1298_MASK_CONFIG3_VREF_4V ?
> > +		       ADS1298_VREF_4V_MV : info->vref_mv;
>
> Can't we assign the default and always use info->vref_mV here?

Yes. The ADS129x has two internal references (2.4 V, or 4 V with
VREF_4V) and the ADS1299 one (4.5 V). In v3 init chooses the reference
once and keeps it, and read_raw only uses it.

> I think this patch is overloaded. You need to split it to a series (to make
> chip_info a separate preparatory change, for example).

Agreed, Jonathan asked for it too. chip_info becomes its own
preparatory patch. The _mV names, pahole, MICRO / MILLI, -ENODATA and
the single line: will do.

Thanks,
Stephan
