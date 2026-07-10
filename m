Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4396A364EB8
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697068; cv=pass; b=ZPWGDY9YV1ajIy/vJa6au3OK0cYmEDHN/Wa19DXrhFbrlqxt6dzxIXPwpCGvTBc2odEboL5pU7D4goXUabu2/gC3RVunDjh5F+m14uIeh21pOjp2/gKRZhOOyIRyjFe3kxAq4zsTARYQnTy5wD4yivnW/oagPBH53LuJCfTGUpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697068; c=relaxed/simple;
	bh=EqyqUxpIYNWHP1s0GX+47xMaDhlkc859gdGdTZYGzl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sgs7DF/4fontJRYkR3aqMK2aNi6EY9Wz7PoYy97ovMAdhGjaItli/d5Lc6tQKgERnUXZsRR0TBT00kr2CC4xKvnBTYjkENEkUvdicyl4WaXoUHxEHUKKKg+4L/53Rf6yPpGCXgTpcUc1SmIhshINPBVMBcGKBP/mpv6/In+Ohkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKFjtHwc; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKFjtHwc"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so599703a12.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 08:24:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783697067; cv=none;
        d=google.com; s=arc-20260327;
        b=WClApeCd+QZF0/T/vtHTPGoch9bh4HNc313U+oG6W/jAS+VwydwhUopXmEJdhF+Re4
         CT6L81LQbcu7KRtIJ6Zk/5YJwm/CLWZGm8s2f53EM6Zo1nyJxQ1WZM58r4Z0KGJ+Tfgg
         BXj8cJ4X40lEVUzM18Ih3VviJfr3AGEnaAcSs5lg5fjqjp60cv/1S+QR+jJ6QgChF+RO
         stBUGIroxu40kPe8JmR1JBNImdBiwXXGkdNL0Tm9yCbOMPnetCxL5WpY0rmhoeeecI8D
         5IN5ihyFP20tAk0FY0wGe+ObuaqQtXw9m1M1ifoBjpDIM3Y+VwQedXfx6YnceLQvkQmK
         ArRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EqyqUxpIYNWHP1s0GX+47xMaDhlkc859gdGdTZYGzl8=;
        fh=UHBEAXP11pH42SwbI7/J2sdtpb8R2lQDh3k3qKZ9jFc=;
        b=RQWQYr0da4i9saLjlErdpZ388eDzdq6ZIJRuWbSKAoprBR1zbsI5i2RS+rPd0wfOUd
         T+Me99Bx+6P7lQeMP8WE0amRNHbYP3OG92ZTC/BW5l8jb0eDb0jb+qm7heetjPtexX7S
         iFw4CCQs1OP2hUo/DmsK2dOBbX0dkyhd9f0xWuzPNUQkcHX4hCElIfirOfZd7GvJOavn
         r8xmjZBCof6zHeH+94pSFHJt9LMh7ukdNcKI/Tf7FsPo5gxQnDFRk0X5njKWRydvqfeO
         s9DG4qCOEefpM8zdv9Jd92HAHkbO8mqbt2BIZEYyu7R3FSIFGoMNBbcfKb2+Red5qmFT
         iENw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783697067; x=1784301867; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EqyqUxpIYNWHP1s0GX+47xMaDhlkc859gdGdTZYGzl8=;
        b=TKFjtHwc0C/UCtAWzmS5fCt4F1AaLrSWXByvKBvD/ctrsW7DXdTWlqCSqeEH1kCoYJ
         z3qt2vJuIJ/fM1HFweqyoRGyMWVobPTBa/CqSlWEiWKrZJOufkYGdPV7U3ImZNglXGwK
         80Sl+DSBRgEwrl7bNU7d5d9+KFXYUtW+K6juNlbcLroVM3InCWgYgQV3FtaOpkJWx/eS
         1uvHzTOsB+JMQ5o/E3oQ0BDTTU35wyzzoZL4/5zgQ3r+NvklqYBu8BDt2YF8uSnh0Y0o
         d0SEj1HOxtwQrUW1WuAcJ98MI97Zqh4apzWcmRorHMAprFwufwAEhUhDU1WKzCbQiRlr
         Inqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783697067; x=1784301867;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EqyqUxpIYNWHP1s0GX+47xMaDhlkc859gdGdTZYGzl8=;
        b=j3xBnRYhCHS31ydPmVyzhi+s7xKP2Ym0qUFNQSU9Nc6l9rzUIfao9+EvFa1zscPRLt
         b2dDebdgePvene9HZM3ASNNwDfiL2ZolNYe3riLJgKT3YptKhswxf1GzNC0L5X/BxBRV
         3pRJkF1KhbyBFC7FKrnDtdlaDYvYbbv4jK3wrd0ysEAdG51YC5ny3qOKp7CgZGZaJFiw
         qgpdN3a0+67ZLGWkwT3UgS+ch0uz5NIZbjW6n1rz0XH0s1ryBM8VkSYpLMsbO+ZdK5nV
         NDLWQ0CAkeomNgF2ck3MiEfYTH1UEtKoHvVJq3pLPX/syBWaNHZ5FZ0Vjga+EEOLTAsY
         5sGw==
X-Forwarded-Encrypted: i=1; AHgh+Ro3lR2pK01V51XuvX6ZtUX6lEUiNLpbTPFNdyNGP4T89LLyE/Ce/f2k8gIb8U+ZwmnJfnNzobzcauA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztoOdKAN55o7WKGubHDRCAvAJXcQPCYnKELGsJMbNTKGouIUA9
	PARsSzPFM5yETv4uVZglihmovb8TBJh1VJoXjSGpc6KZiq7hHXaAYhV++35UYTmodiaPI/1LyI5
	Ea0m8BtAiSPZvwSAOHgHFK7w5rZ1Blo8=
X-Gm-Gg: AfdE7cmV5nR8D1LmRBLwI0e7oTLh2Rhdo9/WLXcSQMGr9JqGEz6yXmB9smzTg+isyp6
	wAVNmkUR+8bNQzx31gNUck9jmczRa/bBoSVaSuc3gXeU6bbL4Id2O3kv3F37878G/JZdekVETYL
	bIVePk6RxU97W0st61iEKsQ97+De7ESTBezlh4WvuS0AJLswZVERuKmavyUIeLaXwoP6EUJcASn
	/Z4AkTas4WScd0eXovyxeI3/i62fKbi9fMPLDFZgVeq1V4oiRRhBRlYZda9i0913tMTtqXCXUpp
	xNpcx0N43Yk7aM9byRP/L0ZaI8fhEkYFpte6UD1mtXB2wEh7Zi1//UaaK96n
X-Received: by 2002:a05:6a20:258d:b0:3c0:b55a:80ff with SMTP id
 adf61e73a8af0-3c0bcfc669cmr15058954637.24.1783697066297; Fri, 10 Jul 2026
 08:24:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707014525.1015-1-kimjinseob88@gmail.com> <20260707014525.1015-5-kimjinseob88@gmail.com>
 <ak0cVeEUhNP1wTkQ@ashevche-desk.local>
In-Reply-To: <ak0cVeEUhNP1wTkQ@ashevche-desk.local>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Sat, 11 Jul 2026 00:24:12 +0900
X-Gm-Features: AUfX_mxU46GPfSBn7INGwH9DSFKpdE3Tct9lB7NY0v2qLaRw04FyfJBrzDmLygk
Message-ID: <CALMSewLACs7+QEq=3Pp=Wo6dvmEu0hFjmuOx8oe0AGoZHPmADw@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] iio: osf: add authenticated stream parser
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Why so complicated? le32_to_cpup() + just integer comparison should work, no?
> Alternatively get_unaligned_le32() if the buffer is unaligned.

I have reworked this in my local next revision. Complete four-byte
candidates are now compared using get_unaligned_le32() and
OSF_FRAME_MAGIC.

A small separate check remains only for preserving a trailing one-,
two-, or three-byte "OSF0" prefix when the magic is split across
receive callbacks. I added a comment explaining that case.

> Seems like reinvention of min() from minmax.h.

Agreed. The open-coded minimum calculations are now replaced with min().

> I believe I have commented on this already. Please, go and double check all comments.

> My comment was to use the same pattern as in _init() above.

osf_stream_reset() now uses the same early-return pattern as
osf_stream_init(). I also re-audited the earlier comments, including the
common magic definition, loop-local variables, redundant casts, GENMASK(),
Kconfig wording, and partial-frame statistics.

> Why all this dances? first_err is 0, we all know this.

The zero-length path now directly returns osf_stream_process(stream).

> This error checking and handling is unusual. It requires a good comment
> explaining what's going on.

The parser continues processing the current received chunk after a
recoverable framing error so that later valid frames in the same chunk are
not delayed until another callback. Only the first error is retained for
diagnostic logging, while the serdev callback still reports the complete
byte count as consumed.

I added a source comment documenting this behavior and verified that
CRC-valid frames ignored by the core are consumed in full without
resynchronizing into their payload.

thanks,

jinseob
