Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7414E3FA5F1
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777535310; cv=pass; b=RWky+cTMMAuybLMJlwxhAS+jcVarLmNgSz5hKJR3QmhEdMu+t2h2a7YcvxfnyZa+pYLr4LUfOvjPHtC+nruoVTnepQl2bqJvxinpwjx43yw5jQwHsBE6ZA1GFZynTZi+FnURuZC11cQUCi2NYY8b/arjbS8KIopYdbmWVUmSJLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777535310; c=relaxed/simple;
	bh=jVAQXm3Ej+L08r/069lVRi0imgXM2GGI0oOYeoOrkz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flGuP/O2EqCSZc33UgCWa07yZNzVEAzcFqT7lyKwgqH20LFakTwSuaWdt878qd18jsthpJTtSkJvGSgWBffy6GoaHoRPRJFx7EUV74sUQW8rCbAtRAMhyTuGrJKHh9ZBHoM2Sj8NrADn1x3ZT7bMYlU6JHqB+ELSszS2fv1GY2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1u62XSV; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1u62XSV"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d7badbd7dso276276f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 00:48:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777535307; cv=none;
        d=google.com; s=arc-20240605;
        b=apYsDgJCQ7rHrqMw1zFFsXuKZ2QcQSMcdV6d06RDsJGQZJJvLSSsVrkK1x0tUnsNXQ
         Z7WofvHtQo/oChcgxQYtMpljcoFvUT0svI5Rcxs3WG5RmdleAs+7/uGQrlSEYqPXaGAZ
         3SMWELIrqH5ePPDsvVjNV9J9fZMRPQLi+F3d+MH1TirHrcWYoUJcVWAMdKI1Z1cLu4Qs
         fabF/g+2xHIk1Ot9N4tkEoMzOYLCIulEf8JJCZg7U5w6d8KTzp8l+KAFUfoZZgAvPCde
         4nOAXEQ+faQoi4qe6+2p2Ob1rHm0qudlJu39poGxNC8u9xBwJyWmLFzg68c2RtwDC7P+
         P/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kMySpXwB+w9VbSxGpiPywWI/BlZDaoH5qqaFBSZophw=;
        fh=9zh6VbP6JB1K3rsWFD6qsKtu5boywzsXnPthglVAn6A=;
        b=D6tksF/TyLHW/8ghWu0mpfOR9ro7e9NdJZPE+gCYGZkD0dnryI12FzHjTPKllyFmcO
         ekipkewTpUguY5JA6GwYT+LIufODuz7/SHZLhm0XqG4hThqCRjqjyrQ44nZynYzHaORx
         y1dYRLNy6ZDaoEqceimDM2eu/cn5VzsiwHSGD04LBSa5mTI1I7VheuNWkMfr6dX9eMHz
         wcPpTtZQlnrrSyPyYpmhIpgoK5xh0Ga1BSQutvXy+QMjb+WOImFwXllZq7Qva/xNOa5V
         0qLBHplN5dAzrSKPreQaXxOfFQezXtCRd6/EIqD4MQnEa/5xgf7pfgkh9N/vp5tb/WgX
         5LeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777535307; x=1778140107; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kMySpXwB+w9VbSxGpiPywWI/BlZDaoH5qqaFBSZophw=;
        b=f1u62XSVfm8QippFWfq7ljCc+53D3EwuknxQOnAhTtCpLUYLPStBbN+7KpbuqHj/tj
         ab97OXkF/pXPJXvEb8u4ukp+7VV9qMiALL9v6hnEGW8iI66P090wN2qoFpQFc3K/f+IZ
         zmpS1lETjbiSiovSIGE/OOjrMPSsqp66/0y1YxLIjV3t0uKuGnBAF08Hqid1mvRmDM6M
         A7OmJnnKVBnbs9AxkvKhakfIHjoisDnPkH9mqY1ponr+L63x3NjVtg6xF+lU38Y5D4r8
         daWAW7GMFlEolNpAo+RxDIzssoLf1h7ici2Fbd+izsM8ERvntJYNsUx69uY9COq4Fl2k
         hT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777535307; x=1778140107;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMySpXwB+w9VbSxGpiPywWI/BlZDaoH5qqaFBSZophw=;
        b=YgeLXTpPq6Su1ycr8370PFrHjpHACgxCCPbTjowcbxbGE8pR6MibHRiYBCG3keozRT
         mw5njoFIko+HRyTC/Z6MFUEEfAk/whvPfUF5pbAW/d16q++fcKsAzb6lwxciOgqDCbGZ
         ry4HncwCubMgWuzteFZTQgE3A7xslBmpqHQViLPx52twgMp/+IAf9xPclLVrb79JCskg
         4/bq6eUHK6QEqburdXX0+2hufOJDp+DnQcuoz8ni/GOcvBxfCzwpu6pfDASUDGZ2/lsY
         JqgCpCVrgIpOJLVcEA3P+FQqkSry+3dOk5cAijzuvd1wdwbF54rVsrav9/LstnBcs5jf
         z0Uw==
X-Forwarded-Encrypted: i=1; AFNElJ+Z4mqgvXuCcKmjtZiePv5fK3ft/pZmNxasxZGcjCCEmTf2F0pfirxb06iGlejwN3iTJnsdeRK1b/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYMKOtN9pBnwV8SyH8Y1KoewwXtKV7KmmakJG2RfpEO7Y50mZw
	z9Oe/AC6JMy6x7lPmabEMl5EjGRliLNek7H97fzWGXkW+Jo+6AoOJJ2NH/XB1enDOIM44D/Y1hL
	WkGY8qTj2TlpdtK8aMv+sCiwcYmWeDL4=
X-Gm-Gg: AeBDietdqnEep8SBMq6P9pvNmrcymVdy50FydvOBZI0716SbDxLH7mGb8cZyndI4zzD
	dEfc+SlskLbXWoTK1JjObrB2eObjXU3WCN9sQ+pfHOqfgviOuME5FjTeEGvzl0m+116MihFczdt
	xkfn6jluUR+rM8Gv2d/HKwbP7zIVEk2Up2fa+yhhA5k/Y3om31AJzpOAlIhpKes/Pjn013aMAHr
	iQeQI1T/LH0pLoCUYsOVeJzn6S8u+0B1iTthOLENEWMK+IX/yzjA5ZLetRwt8umz1/CpDLGXBLD
	WUdd6Tr3Mk6Gub/nwDa/tWr1Xka8GcWsuBLr/zWMQfSIKZxafzIN/eorYLkba/ZZ0jL7Yuv40Sw
	QZQX/asaHbmEOX2b07q+HtIyXD8UL+oVPCiXN+/dT8UkjmlgBMRfN9LF/8LJ5jWTGOuoglx/nTu
	V4W2nGNfr9uuu5F7iXIzFlciQD8fA=
X-Received: by 2002:a5d:64e3:0:b0:43d:242:b9bb with SMTP id
 ffacd0b85a97d-4493e1c18edmr2588788f8f.18.1777535306599; Thu, 30 Apr 2026
 00:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
 <20260429-si1133-checkup-v3-8-469f21d960eb@gmail.com> <afJbshe8SURhqKqA@ashevche-desk.local>
In-Reply-To: <afJbshe8SURhqKqA@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 30 Apr 2026 09:48:14 +0200
X-Gm-Features: AVHnY4JWPVxBiKtegyMC_XoXN-vudrNG0noakvn0cgxwQLBOt9QdRBdqhXur9a8
Message-ID: <CALoEA-xacJ-8p6VHrYcOn_uJWLWxyoErtUSr1_XTTwR1BR9TcA@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] iio: light: si1133: prevent race condition on timeout
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Apr 2026 at 21:27, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> Reported-by?
>
> Also with this seems the Fixes tag is appropriate (and in the other patch).
> Also note, fixes should go first in the series.

Yeah, makes sense.

> ...
>
> > -             if (!wait_for_completion_timeout(&data->completion, timeout))
> > +             if (!wait_for_completion_timeout(&data->completion, timeout)) {
> > +                     /* Mask the IRQ to prevent delayed interrupt waking up
> > +                      * any subsequent command.
> > +                      */
> > +                     regmap_write(data->regmap, SI1133_REG_IRQ_ENABLE, 0);
> >                       return -ETIMEDOUT;
> > +             }
>
> Seems like you dropped {} and reinstantiated them. It's not good style. Just
> make sure that the first patch that does something leaves it in the form that
> next patches won't have too many + or - lines that basically revert previous
> subchanges. I call this style ping-pong and highly discourage from using it.

Agreed, I seem to have missed this.

>
> >                       /*
>
> > -                      * reset counter on err to prevent sofware and hardware
> > -                      * counters being out of sync
> > +                      * Reset counter on err to prevent sofware and hardware
> > +                      * counters being out of sync.
> >                        */
>
> Ha-ha, doesn't belong to this change (see also previous reply).

I noticed this immediately after sending the series :((( I must've edited
it while rebasing...

-- 
Kind regards

CJD
