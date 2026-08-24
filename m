Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD1036A033
	for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584002; cv=pass; b=FgLenzDAxILrOuLLoOCAy7DGN8b+z2l4ksPYGZOmzMihqule81sgTZIDwJKMMoU0kqsQ6lTo83iP/3PmieXUTBxA4OaSy3suFtvSl8b91QbyLFjnk6U0NoqaeMwHWtIeKCJ/Ip2x8LWN7nkwm7Hn0q4hav2YdGJNMjuC9bajt+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584002; c=relaxed/simple;
	bh=naIq0ZpmGxBdoTfDsurltwtaOqacNnDJ7BlEOCQ+980=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gv1I65a353hwbeqWWoY5HrXyzXwd+FoPLJl1Xg8Mczg0MRyLe8Ax9GeCerinDp/az5r1L7vvxZ55boKHT4HookrmXSzqtrJkY2y0hmnQNeKbFnsK08wsSgkrppO59SBnhYh76MhgR+H0lQgNIdoE9lLNHIIt05H5unh3Fvf+BGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=seWWnFYy; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seWWnFYy"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f904e80eeso1355844f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 08:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787583999; cv=none;
        d=google.com; s=arc-20260327;
        b=BCE64kxgPvcMfQ21A6efcfqx+eiJDjcQsIsVE2YAbbFQUE+KvltC+7G6iXn9WVWbsd
         AVoSjZFKoto0c7sZsyrlLovXeRmJoykzg6t5MunerohQsnv9+bPOyQHyJ12lyS38J0mB
         gZHgggkC8EFP06GOAV3VALd3nMUvgeBtDHq5TVjbEpD50UTdcHDSDkG6yvoWXunEEC/M
         pdy/rFNnIWPHDQH8PalDY+U6z9mfY+rF6vupPtofw/aLgNHgebRmQjemOWQsu0pODkFZ
         Xr3oFRNZjnTfD8aqlOvQV/brl2rtt7VTwXiKRcS463ZYZR4mscWV7aUMLFAeEI1BEEZQ
         1fHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wWKW6FAqvXyfKJK93X1IXADKoVVutdhRp1q1BW0OB64=;
        fh=GeG1VcUOXbszgSNn/jJE/OTeWvZF+qU2zWAGGAad5ro=;
        b=YBytg2siMBRxCDyXs5/+VV0sMPE8RxvwdDZZDr0/4H9h4SVpgz7d0wniBEh6xho3Ad
         uNdzOepjZDOQ82WYRKFA5YbIc8fBgi2McNVX8LGQGKI5u79jIYGE1kODeA5BImf5r5WW
         2aXyJfA9CPNjQnrnlJw9J2WKXhoE0YCH+pWZ9LYTMHEP/HCVNnvwVmp/1BXTcPajCOrX
         VhdVJPeuD/4QoYm0HbStEjgF8wLeUObMrTbulTA1ld35qOOmuX2sqtqS5QLMCKjzjLOp
         7FpPOJPxUJ1yy/C6c9RuivNSnup3pNjSUTAG/rrwCFefbADIoIQY5gb03SrhISbhRm4w
         /WKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787583999; x=1788188799; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wWKW6FAqvXyfKJK93X1IXADKoVVutdhRp1q1BW0OB64=;
        b=seWWnFYy9jVU9gKGTufivjTVyd8T1CIwfmhJwpf80CqzzfMll+H1sroSl/zEky7NTa
         TgJ57FMfoUcTaMM8uigL3dEQu2gFIUrn69y31qqK2U/IBFGhR+RnhNRMrkPrIfbqCeY5
         S4N7nCQPY0F9mt8QQHuhVPKCRVHngRcdADDtLHy6A3U4cjybQW4z2T8a9JBOp2ZOzoY5
         WG3jYxCkqFdA7s6Exjg/EW+w2WhQ9j+DCtDu4jk6pqjw0EWf2fyGuSxn9WnXG75HmdG2
         +/Hv57JXty4B/ROmB3zMSz1u2G5vrbPQMw9G/b1dJkHltQDoS/YZMU3vt/EmXtXH8uIB
         bc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583999; x=1788188799;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wWKW6FAqvXyfKJK93X1IXADKoVVutdhRp1q1BW0OB64=;
        b=EE+uw7y+XaDrbNjuE+fpBdjwnhdJEo+gc480+H7XsHyACGf/nNePAHAQDJ1RCRu8pE
         uCwqXr3wgSmTR1QMwpjQZSujlZlA5NW49gTYesDQ6oSLRNei/NgaAiyzuwAJ2PxhGaqP
         3pMzsIWu1uKNVckRH2OGviSt+Q32MGTqk0EeUDhP5mudwHYPDZF5wDFcTOpApN7p3Afs
         3s7l9jhQCEm95/7b2OU7HsG8IA/Jmr/gLTvUfMYXQT03yNN6J9R4L5qTJrCpEJROjoGb
         IYrr0G4BfxirxPrj1NatVIajMZuqXWucU20b9KVP0zfb2iOJgQMc+vHvKooE/o0XxpK4
         4Dzw==
X-Forwarded-Encrypted: i=1; AHgh+RoCHDdQxS8pPHZmQOCxU9s9d0y/nm43OLkUw+MExhJ+XtMluQL6LZc/7eCxD5PmXFjYc8PX66Rib8w=@vger.kernel.org
X-Gm-Message-State: AFuF++mFrnArLs3QU/MNhVwi1qB6l/qi3joS37uI4CwurbQ8y3f4zZF4
	K5+V4eKfUr3H2p/SU4QbTRVOuplJVE54kDQYCX8dOMSipqwSJ5rmw5R8gqc1VF1K53BfOmtfdtq
	KgkVcAKRBNbCcbWqrePeOlmQbJkzJ1OUtCTofjNo=
X-Gm-Gg: AR+sD11TakWXZuJ3U+V7OadIe1UGqn+FlSy5eXeZCb6MB02QcA5LfJnFQWPCzFpwhZv
	i3USTtLbU1fVu56WXIb73JUCVgmeP2wNfkR9hR5tg1dtksdEPLWVJoLmfkpHiwOfACbVgLEEzmJ
	Z+guY6HYfeK7BBGoXYY2FVrlKmyt6VJlV8vl4XWpXj9uc//iv/OzsaEYtSR3jBm1xct/S7genTq
	tCvxLwuxgzkhTqAFfuz93auzFw8+Sc0QwHIR3C5FSsE98ElGWcAqTPn2UR/bXzwU4wMn2kOI0oH
	No168WfW4t4DwtYeStxnhPf5xdDvchfNABS/eMi8zpAOwEPYf60ZY6xnUwyjTO5lrejArZ48sVa
	lZFgpYOj3zP21UDuE4bW9yNxZqQYpD0Bzaigbc5GA2CJEuADJVlQdx8thtf7fpshwXqaMQcqRbZ
	MQS17MxLHS+Ij6akvCdAbhNFM0bzGI/Bi8Dqrtll+Mf1w3LqQ1f+fUyczc/8T7Zqbu5mVyPjrEL
	sDoJY09WLg1i8ocNJI4APC94RGLnmcu+901VGkE+1bJV44eMEM=
X-Received: by 2002:a5d:64c6:0:b0:47f:8f8f:db74 with SMTP id
 ffacd0b85a97d-482c0b87e35mr34299470f8f.12.1787583999042; Mon, 24 Aug 2026
 08:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823222502.30764-1-rishab.madhugiri@gmail.com>
 <aowVI_n7s0VAmN3D@ashevche-desk.local> <20260824120503.00003500@gmail.com> <aoxZq7sc4ndMG-V8@ashevche-desk.local>
In-Reply-To: <aoxZq7sc4ndMG-V8@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 24 Aug 2026 17:06:24 +0200
X-Gm-Features: AcwNN1XjJBxJVRN1y0m0Rn6S2Uglxf9je2RDYLXmmtpPcmML3_1kmW4yvA34SU0
Message-ID: <CALoEA-w8RMArm=STmnaGJJdyHpR7V-58uFz4m9U74aDe+QJe6Q@mail.gmail.com>
Subject: Re: [PATCH] iio: core: Avoid BUG() on invalid clock types
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rishab Madhugiri <rishab.madhugiri@gmail.com>, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Aug 2026 at 16:48, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Aug 24, 2026 at 12:05:03PM +0200, Joshua Crofts wrote:
> > On Mon, 24 Aug 2026 12:55:47 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >
> > > On Sun, Aug 23, 2026 at 10:25:02PM +0000, Rishab Madhugiri wrote:
> > > > Replace deprecated use of BUG() in default switch cases of
> > > > iio_get_time_ns() and current_timestamp_clock_show() with
> > > > WARN_ONCE() and return correct fallback or error codes.
> > >
> > > Why?!
> >
> > Because BUG() and BUG_ON() shouldn't be used anymore, no? Linus himself
> > said that he hates the macros.
>
> Why? Please, study the case. As for the above change, there are two questions
> (at least):
> - Why BUG() is deprecated? Where is it stated?

https://docs.kernel.org/process/deprecated.html?hl=en-GB#bug-and-bug-on

> - What will WARN*() gain us here? (Note some specific kernel command line
>   parameter that may convert WARN to BUG)

As Jonathan mentioned earlier, the original BUG() was there to prevent the
compiler from complaining that all possible values weren't handled. So BUG()
or WARN*() here is a placeholder. Just removing the BUG() call should be
valid since it's impossible to hit(?)

--
Kind regards,
Joshua Crofts
