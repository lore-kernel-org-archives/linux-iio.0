Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B923DEFFC
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 12:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414421; cv=pass; b=IsAMB5IqDUn0ZXzEyGUAmOkIfBnjxiVemNSTfN4ceQE8MNfU2nwW3vEKi3lqpGkSWrbh9MPsz8LAv1FxBhaX8TAcYttFrAsw6ITGvT2nBMBxVKYHUswgCChSz7NGQWmEabI/7xLnrC0N8a/FX6ChkQG65h/hhs5xgkVmkXmLvHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414421; c=relaxed/simple;
	bh=57gmab27H+NiRucFf3CyiDJlRJIR87MgR1UBZGb6bBM=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMgN2+3J8FuujVsA4tVwa+jGgSceVz2cZz8vVnVvJ3qB7l7i1hMjRxwscWZhOiyZxuGLoTkl90swtAQlOdzWFFVz5kB+3pPVH8KTh0g+vAAKcMiyR1IuSWK6sMWQw3vVgE0a60SRYvo5oCU5mOOPLNPCzoxqGDZXdGbONqMld7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G86IfJhF; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G86IfJhF"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-78fb1fb9508so417406137.1
        for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 05:53:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792414417; cv=none;
        d=google.com; s=arc-20260327;
        b=nWyj+Ppmw2EPkBmExKNqgNz6in6kGuDjceG1T3APPVC08oj+q7c758sf2TAxotafh5
         9tgMdPi2CXVBw11oFVoRTx2SBbhbXxteB8oSF9WtC6gz77en8LcGIpftNZtK7g3iqZ1P
         WBaRs4X4u0ga+S9Rkq13pC6XqF53Ul1jKUPDGbIgQTFhRg3wTO0pYimd4woiYNJclAXq
         M4uZh9FU50f1b7QUFkGUzjHEY+CQ9mR06xP6FRflMSw1mbv6KJ2Rd2QZiKpyA2P2Io2i
         sYn6FH+TQQxqqwqN+HloRy1ZMuTfIL0MIyRu7StMqdACbftQ260Wtfk5QJ2uBhgB3sLH
         YPsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=3/NLlVqFCmhHYroSfjpjqG8QkfUxXfmrd0tU9Bct3fk=;
        fh=3t270P6W0BorYpbJKzmtQ9hUkdmW9bOoBsWpwjLXIc0=;
        b=I1Ol0eVBurqUS0qnxjtT0+bj9/Q7xYCfdeXDNoDbPrg5UGd4uhpO72O+PH4NPRq+Vw
         okwXtUMJbZ8WvallOp8aZ2do1oDlz7SIXIR3I4oqTrD0XOGEWiH4xtzu+aG+xm8pTqsN
         r/vO8q9NBj9hud9i+pylPG4NhhdiLEBP7baBEsbLhbXhJrN2fekafT/D7lZtfBaflsbs
         5vEP0ZUrLGRdhYRtBSWjlq63XBhpg4bjCJrllDtGHoda5YT16bnCiD1AuFnD+79yBV/A
         j+nxLlKh3cUDyATMMxpklKBEnrTQYYTR1aCzJlPhsEqWEyU8fobioI+VK991+wJx0iuO
         RrtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792414417; x=1793019217; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3/NLlVqFCmhHYroSfjpjqG8QkfUxXfmrd0tU9Bct3fk=;
        b=G86IfJhFKtisRX4iI3xEJfm4QccbjcJM+c4D3xZNeCyiQrZ2vQen3LMKoeF7JYD2+u
         CBmvvuNRo7ZvD6bLHG2/k77zV2JzUvmBS6gd/l0GE+8vOvYjrtBsgErpw9r2Bwit5J/Z
         /evQpQASGHqLN4yZsPUpcTrTJYzEtZG5gRGiknKoHILHZqtnc/9uGTWY7LtFrwc/YGPp
         qgZW4K38UMdTDyffNX2qVvm+qVzqtFzwhJINtrpJkmTIo99i7TEtj9nEcKJCh4kG2VDJ
         d5Gqkt3ZFQQ8KEmvBpPaVhReIlEXYd/vlMuo0u/tIIyGefYr13LxbLm65fzT5QisQWi7
         s2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792414417; x=1793019217;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3/NLlVqFCmhHYroSfjpjqG8QkfUxXfmrd0tU9Bct3fk=;
        b=EpYKjuKmavPzD8+XmpyGFpciujYG1sOeGif5XpNhHI4aqZAvaK6BSMOGNfvMw4oXwR
         doAZ7Cc+zwykaFAQgBSLfSjkwc6ZhQ/kF0IeUMdwy6v+cl6voH10k6L5TRSdzT9470CV
         9UTKLAcFQXh05dRHzaGNb3ctbFXqeoFwxM7hSgLBizVajmWdCzUnSJtVQEk6ukvpm87l
         j8qQnWstMXXOpK4BdoBM+44pDj7mIWiJzO3Fi4fdAqpkiMUtPcLHeW1Hk1ALAFnA4klg
         e60oyoFeaiFGWdOuTzfGVBWDnvswsADAUU75tOW0Puefh3bDaidpaDYlDfeES8k7RiG8
         uKFw==
X-Forwarded-Encrypted: i=1; AKwUvBzYGF6pNX5uyUq0T/pkZcsMWLEo7VYQOOhZdpYv9xVKCa5lEW3mi2+TBPGP51K431e1QulU6zbh+4U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJl8ZYTnkkw3ouDEkUnYW/7YEC+E31odIxSVlVFffTg+x8S36PD
	kGUQ8WiJmLZZJTq0mt90cGsM6FWyue3g68ZE5F8ukH+g+hrBZbYHPY8pyimXv2otU/vJ9YRaXjQ
	jfFVIVi5CeA3hZIZqyS4gYWgq2bUkKI0=
X-Gm-Gg: AYBFou1X+fRMmvaDEOlBMN7zzg+K/O7mPzuGPrvmK/N6j80h+vy2r34RlR8/plWMLS/
	JYiGmCN8j+Q23wplAivcvjyHYyQbu/sw9/SVXWgdZpv71m8SwYTWwi7g4V2SMTfWSzYPgXE8x9q
	wPj/BxAHRQcXaX3vsNjm9aeCHw+R2knk4EDED5PwP+Kuw3/kd+JrRINwP38kS/mioP8x4EoEkuv
	ppd48M78wKfRpiwn7E11hIsIXkSRy5m1dkakEyqoUKSuyzteRrUQa/g81qLF6A7ZdBifj2I1YL3
	av954/szx6MWsMzS9N7nmbCJBG+vmBEzJZugjuXj0b36y+otJjY=
X-Received: by 2002:a05:6102:75a:b0:7ba:7a64:5946 with SMTP id
 ada2fe7eead31-7cc1823be8bmr2109998137.35.1792414416776; Mon, 19 Oct 2026
 05:53:36 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 19 Oct 2026 07:53:36 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 19 Oct 2026 07:53:36 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <atXu-v1i-xfbEpr8@ashevche-desk.local>
References: <20261018-adxl345-event-state-v3-1@gmail.com> <atXu-v1i-xfbEpr8@ashevche-desk.local>
From: Iron Berrington <berringtoni36@gmail.com>
Date: Mon, 19 Oct 2026 07:53:36 -0500
X-Gm-Features: AclHuK9aJJ9socvVeKS3UCCh5J3roGS5cdnAdGir0viMETLtUE_cFR_H88lVd2g
Message-ID: <CAF2O-sNPw9=ihB=zW1Te6Lyu+wd45QUPJH1oHX4U6EB=KxCHVQ@mail.gmail.com>
Subject: Re: [PATCH v3] iio: accel: adxl345: separate event state from query errors
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Lothar Rubusch <l.rubusch@gmail.com>, 
	Joshua Crofts <joshua.crofts1@gmail.com>, linux@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

Thanks for the review. In v4, I'll replace the two breaks in the
coupling query helper with direct returns, and move the error checks
into the rising and falling cases in adxl345_read_mag_config().

Best regards,
Wenqiang


On Mon, 19 Oct 2026 13:20:42 +0300, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Sun, Oct 18, 2026 at 09:42:00PM +0800, Wenqiang Zhao via B4 Relay wrote:
> > From: Wenqiang Zhao <berringtoni36@gmail.com>
> >
> > The activity/inactivity query helpers return either a boolean result or a
> > negative regmap error. adxl345_read_mag_config() converts the latter to 1
> > with !!, reporting a failed read as an enabled event. The disable path
> > also turns a coupling query error into a successful write.
> >
> > Return query status separately from the boolean result by passing bool
> > output parameters to both helpers. Rename them from is_* to get_* and
> > update the event read, disable and link-bit callers to check the status
> > before using the result. Preserve the successful coupling-mismatch
> > no-op when disabling an event.
>
> ...
>
> >  	switch (type) {
> >  	case ADXL345_ACTIVITY:
> >  	case ADXL345_INACTIVITY:
> > -		return coupling == ADXL345_COUPLING_DC;
> > +		*matches = coupling == ADXL345_COUPLING_DC;
> > +		break;
> >  	case ADXL345_ACTIVITY_AC:
> >  	case ADXL345_INACTIVITY_AC:
> > -		return coupling == ADXL345_COUPLING_AC;
> > +		*matches = coupling == ADXL345_COUPLING_AC;
> > +		break;
> >  	default:
> >  		return -EINVAL;
> >  	}
> > +
> > +	return 0;
>
> Replace 'break;':s with the direct 'return 0;':s.
>
> ...
>
> >  static int adxl345_read_mag_config(struct adxl345_state *st,
> >  				   enum adxl345_activity_type type_act,
> >  				   enum adxl345_activity_type type_inact)
> >  {
> > +	bool enabled;
> > +	int ret;
> > +
> >  	switch (dir) {
> >  	case IIO_EV_DIR_RISING:
> > -		ret = adxl345_get_act_inact_en(st, type_act, &enabled);
> > +		ret = adxl345_get_act_inact_en(st, type_act, &enabled);
> >  		break;
>
> It's better to spread
>
> 		if (ret)
> 			return ret;
>
> here...
>
> >  	case IIO_EV_DIR_FALLING:
> > -		ret = adxl345_get_act_inact_en(st, type_inact, &enabled);
> > +		ret = adxl345_get_act_inact_en(st, type_inact, &enabled);
> >  		break;
>
> ...and here...
>
> >  	default:
> >  		return -EINVAL;
> >  	}
>
> > +	if (ret)
> > +		return ret;
> > +
>
> ...and avoid adding this one.
>
> >  	return enabled;
> >  }
>
> --
> With Best Regards,
> Andy Shevchenko
