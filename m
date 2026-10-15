Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437BA36CDFE
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 07:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050122; cv=none; b=eZvHma28qB2kkyeD1PCwCTSOoiw4pqMQw3H9EBRok3aEXF//ywjbGtE+WGlZ+TBKlLV9dmVwHyTCSUAplwgE5ULUxIIveIVcqjLbWLTLeuTqW65XadgV1lQe5ydvn6ZfFypmIfqcTq2zm2xAbC+ycCza2r7NBkvg982JA7wNuUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050122; c=relaxed/simple;
	bh=7hUOE8btigyGRD2TTmBp6G5vlIKkBzkcr/ByALuXRJY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxAkRCS7M4fpsjfuNwLSkxuSsk+BJ/8L+R8xRGdZ1IwswcBNSSnDGr48AZpDFMi3Z5/A7EWFJXqdlnRwgQj5kjjSN5scvQbQGqwuSj6/POt0p1wBzQnR0TSWTZ9dtSoWGooNX/g/+0vNXLQtdsb2t74rCSwgprNhk3hvxWm7IiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUAwrXUh; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUAwrXUh"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso3604930f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 00:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792050117; x=1792654917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tNQZzmh/L9MH0WQdX7vNuWW0ZjqB6ODxMRs3YkUCNgg=;
        b=dUAwrXUhmEO+OfR1nE7ZwOp5gMRqKu7vGsYJK4EWjHeje8TJMXHTly6FWVxrdhuS9W
         atApGnP2PcG/c24MlM+DjeJA0GnBVU80NwKPSO//zY/anAvAU53y1zH2ZIqX34QX/Wd3
         up+bGO7bnwe1UIpx6qBb4Bg2Cv/vbTqcKuzSrCYbnPgj5poBtyTdxILdBDrtN3FroHF4
         wXGLVsbPbXJKQ4XmFEC19CsmXV7nAPv7qLhvbwPXv1e1dQoLKn9OfSuk1O9vrIwTgFWv
         E6kL4B0g0H7OFmgavvLvUBablGYCfxUbJU9D8rSuy6BFUGLNwQySslamJEiNmVXqsoW4
         mz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792050117; x=1792654917;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tNQZzmh/L9MH0WQdX7vNuWW0ZjqB6ODxMRs3YkUCNgg=;
        b=KvFi76tUe3f9516DLWBSmK4miuZwnGx8ZR3Xa+lQ0MR7ZEDI7sG+o+hnsIxUKpw0Gx
         9BzFLfTuIROU1pbJtlLfkHt6AetaEwre4Eiviws8xn9CVQI0R4bJ+kNX8YfLIliX69l+
         b0cHFF20nwnnxVB+AYn/nzsA7fJQC5uVbrve00otoc5kdY3Gsu6SznRgVaic2OWO3HAy
         UylJiegBC+sipZy5vcVU+7gmtoPfDGBH002uj39dq4qGWQoytKfeDAyxtD0/NmzAJMbg
         oIgaoUodp/aBV1O8PfhfOmxHYGISyayigRUNJR/oMVzC6o1XLOz7qM2n4Ot0nVIwIpSs
         xwDw==
X-Forwarded-Encrypted: i=1; AKwUvByT/lebXWunrtVsrUwDhG/x3KHj1VYdNjqBP5Uaq6jGvj8wL+PKT31hEnmV+mta34p8rdGFvxDqPKg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIO5CvBXCJPbHtoMLJp9TYkHlrK3kwWJfbNX8PgNYpo2eGlZrqn
	NU5udqlHisl7SGkhKa0Zap9hXb/hRr93RFPwoNUafWxQ5xM6ApJSnyUY
X-Gm-Gg: AYBFou2qr1dXHYIBq/VVH2r4ZRLkA8x74omgTGsDQpS0vqyPBG2RISUw0clb27iAAOK
	Pgb2mZ2eGkcPX+psfb+EQmVrLzPf0tTrGn7smwD1P2nB1oyL7Ym/j3V53XDse+Bd7XhlPUFV6o+
	OIYCxqGW2CrH5A38LOFYMgUhzr2mWGRcf2/nLG3HqYoLg3DKHBtMTY4LR7klS/zgA2VAAtZ7lhb
	NYO2joHS+vP/VjyuiIXtxwz7RiZ1gQVhbdFNmx69xsQPmGBgO4j9R499kAv894+zcAwuOmBPl+A
	VXljo9pkVQC6OkonkY/L0bUqrWzkOtX99cOm5t9Fb0MHWg/FsnGgZVwm8waayr13drDA/XSVgRs
	5OkFi64omdG8kmPgYSo1JGu/WuhZyWKulX1P6UTe5RrAkoOuI+6SjhRgzTKDjwlznniU7+K3wwi
	gK10tjHkv/EXF2G/tNiNiqnXdGUQ4om3lny6Q9l7+RuGtu7z3+r7JcTRMVBbKOZKIa8+0ptQUQF
	3utumpQP5C0g+BZ46aMGAIHu7yfMC8TOPQnOwJuGpuIW1x5quiDoPg3kMhV4B5PurMCKu2vL4EC
	mAtSXQ8O/dZ0ItPy4P740dsJjQF+4Eb+xxhH/CH+lVYHUppc7mJHhXfyx14o4lmufAKZDvif5VZ
	1KAwQOxPBLUBdJaJkbwTM52gbcC0abelK0ziB7fDnXm/XkbiMt0VPeWa9zDaYr3QA9MEScsrNAR
	UmA9mK
X-Received: by 2002:a05:6000:41cc:b0:48c:7037:aee9 with SMTP id ffacd0b85a97d-48dbad48cc3mr33849866f8f.50.1792050117131;
        Thu, 15 Oct 2026 00:41:57 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bd777fsm15479605f8f.57.2026.10.15.00.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 00:41:56 -0700 (PDT)
Date: Thu, 15 Oct 2026 09:41:54 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shi Hao
 <i.shihao.999@gmail.com>, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: light: add as7343
Message-ID: <20261015094154.0000506c@gmail.com>
In-Reply-To: <as5LCasyTFjTNL0x@zephyrus-g14.localdomain>
References: <20261013115639.167433-1-marcus.yu.56@gmail.com>
	<20261013115639.167433-2-marcus.yu.56@gmail.com>
	<20261013143639.000017b9@gmail.com>
	<as5LCasyTFjTNL0x@zephyrus-g14.localdomain>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 23:15:21 +0800
Chang Yu <marcus.yu.56@gmail.com> wrote:

> > Should be unevaluatedProperties as you're using $refs in the binding,
> > but Jonathan could tweak that when applying.
> >   
> There was a discussion about this back in v2 in which Conor was suggesting
> keeping additionalProperties: false if I recall. I don't know the exact
> pros vs cons so I'll defer to the experts here.

Fair enough, if dt maintainers say so then it's fine.

-- 
Kind regards,
Joshua Crofts
