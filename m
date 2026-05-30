Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9254312834
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 20:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780173760; cv=none; b=NfqaFz6e+5F6c0eBBiLgIqfgKtp0R0Qy9sjQz/8bQyCP4pqhmgEEqWTmIpK8rRLdeaGk31jyRS30dqcpOmaNBsi66bKbGxtTIukfroZQeoK5SlOWK/w4zj3C8OGcvLhAiLqnuijmBivT9P6kdZN7HHqU07yw/W1xaKqiLj8gQXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780173760; c=relaxed/simple;
	bh=9JHbE4HNOkaWdA9aiO+m3bHYkQAb5mezw87RyiCnHPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txE3EoEx1f4w/5POBd0L1bAYwBrOdSKoQ16U8pJawmzok3cOoZzeUlrkWD9UNB56kSnbQco2ILN8w9XSf5ejLwYnRqb+RLPPDzK3nMGBL9rzZZNRaxzpizujzGaGQk9wqncx+BCwWk//XRnTMWUL2R8xNVh2BeOSgI9OrmnC7fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfiu2Q1P; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfiu2Q1P"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45eee266c6cso1809879f8f.1
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 13:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780173757; x=1780778557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3tfGgufw87JlCJA1EHDdaMQtis24J507tckYXm4wyE=;
        b=gfiu2Q1P9xBOIn1Q4VRF9t5obDLFJBpIjij4HApYiFINgfBQmwnC75/1bsKFtR8jbI
         4dBA94cSZmTxA3E0WOdW7KfwqAUxqvuj1gcq11ZwRYhu475qILHrb9irb9fiake/TIwF
         Dwk5A88/Ip9Ek7BGchVS7ekfLapoDpREvCcJQB2Z+S4VByU7jGZCR2i3dKTRlQqaVZ2s
         pD3Jft8rhahz1vxtV/WsfQjRF0n9DzbJwU1Qdl2Zf8h5vANw3IU9uJpR0N84ParZdYA2
         9IJpMl+g+UWQsRZt8k5V3dn1xT0+IJYsctPp2L7kZbelfrWBuayRNn6EGGrbQR/dpefT
         7kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780173757; x=1780778557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a3tfGgufw87JlCJA1EHDdaMQtis24J507tckYXm4wyE=;
        b=GSpRLbXU1A89p2RA/hUN6gbHBo3RQhrRFiuMBubQyXHZ1G8YiodZ6mTiSvsZVe0TJ1
         izDsJ/iRxBo6gJiJdD6eg3v3eYIAHDliHn5ByFaaKeplz3AffV4Eiztm0MwayJ2d8dZs
         LDRLk8GFDs6DZ08aRN5+DcHxfLWRjCTQhdiTMi4pCG52Pt8csf9VPPdbeNolPSsBo8QY
         gjNI0G4Aub6JMdfnNrRqWw6+OBoqM2jhOP9VM54W/Al7QIRmYAP+cqaIw4UWdegkU+uv
         f9Ed1Stb6efFu68JT1AZKVorvHwX+yEJ4ymtI/Y3x5QLuT0i496iQhUs6m5ki5ies0PA
         eJ+g==
X-Forwarded-Encrypted: i=1; AFNElJ+lTtKNNEzz0oKCFjyy2tmhpCwcZQO+uA0EYNJuTVbp8Y2Mks6cCVWgZnkYtTuySzl10fDLoDDVHPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrkes0eH4AqZaa1qVg9GMxImGx21RJ9chFnKPuwD+uO59Z0cL6
	FZ9NXGtIZA47oQ3NyUEpXQ+xu/aKd4j5n2wqMFBXhZ4ahvJ4DQrYcN8r
X-Gm-Gg: Acq92OFbeW45g+JQ7pI8VUH5YCeUEZIsBnzRHmkipBC0fITyCxEWWZwqpc0XhfHF6FV
	SBB41IauyJyc3HtE4r0c3khht8/r3q/qOkT71CAfKUAki+liCO2aXGRB6kkaXwNifQD8C5xpfnt
	zxb1x9RNujk+0UxZGMuaIij1dYQrOlYudgbalR+jUhGpqtjr8UbdHqoZQaWak4w9kWrPe2ljL8f
	oDhR2EiOYzKprxJJ+HnTQmH04hiF6rHhk/tfuJYzBqrWi89tJA/hHISMCv/LRx8bbmlD7lkDHS4
	klttMOJ4ovXwq6UdaqW+r9Alf0B7f0UWxdYPxXgFGkx/d99VJzJLBd1qEaYg7tcRJJT3ggWR7Sv
	WqqFXidLKNDcLCTTJTm76oowLhLNmXC7eKC9LAkLekbbLUro8taR3InhGotaKLuhJFt2+dvVZbg
	crrAyd7tewMnqd8lo=
X-Received: by 2002:a5d:58f6:0:b0:45e:e50e:3bc with SMTP id ffacd0b85a97d-45ef6b71573mr7238155f8f.29.1780173757308;
        Sat, 30 May 2026 13:42:37 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef356a4c4sm13944636f8f.31.2026.05.30.13.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 13:42:36 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wadim Mueller <wafgo01@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: flow: add Sensirion SLF3S liquid flow sensor
Date: Sat, 30 May 2026 22:42:05 +0200
Message-ID: <binding-reply-1780172572434549738-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260528-transparent-adventurous-python-af8f69@quoll>
References: <20260527184257.141635-1-wafgo01@gmail.com> <20260527184257.141635-3-wafgo01@gmail.com> <20260528-transparent-adventurous-python-af8f69@quoll>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, May 28, 2026 at 11:07:18AM +0200, Krzysztof Kozlowski wrote:
> Do not attach (thread) your patchsets to some other threads (unrelated
> or older versions). [...]

Understood, v3 will be a new thread.

> No need for cc of maintainers here which are output by
> get_maintainers.pl. [...] Anyway, your SoB must be the last.

Ok, will drop the manual Cc block and put SoB last.

> > +      - const: sensirion,slf3s
> 
> That's confusing - why do you have generic compatible allowed to be
> alone?

The driver detects the sub-type anyway, so the generic-only form
does not add anything. Will drop it and keep only the fallback
pair.

> > +  sensirion,medium:
> 
> Sounds like you configure driver probe behavior. Why this is board-level
> static configuration (DT)?

Agreed, that is runtime config and not hardware description. Will
drop the property and expose it as a sysfs RW attribute instead.

> Please make example complete - add all properties.

Will do.

> > +F:drivers/iio/flow/
> 
> Drop, you don't maintain that directory here.

Will drop, only the binding YAML and slf3s.c stay.

Thanks,
Wadim
