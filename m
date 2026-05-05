Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4396223DEA
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778019610; cv=pass; b=f+MGHsCn2ODck/3r/rLyQptbllQPHh2RF7ZIwGqmBEJ+o1Z7zahQoEj+IX8dZ0k2Uj92wmx/r0ZbJF/eRIwpKikBKB5UGfUwBirKhAvy6+aSla1YQfn/RQLFztONfxnZbuF/gZrWb0omlXfOGTYrtN9Etl8HGyRQwdJljIkqC7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778019610; c=relaxed/simple;
	bh=xgNynJPTQvLDnKaFZRr6xsTlWM4rfoKY1aVdZB52t20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6gR4D/7AJVTMDsS4iEpfNVpAcdXGvu4oP3XILJLsZCo8ZmIHwmMriE4GsQzt/IuuFkSjFjYE7ZeiOVbcTTZzJECntANAw06r8MgnN5rXReetXX7r9dfwpE3AWtK6eRha31VE5Swu20nQu5p5W4ENBkJnICQv4zR7UU51CkH7t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpQoOy7M; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpQoOy7M"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79a2ee65171so61134247b3.2
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 15:20:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778019608; cv=none;
        d=google.com; s=arc-20240605;
        b=Jf673T94IKNVzfZmz6paeeF0NAenNW9/4t/nxjivEMffz1UKBHe3kADhIXQ1cUH6fx
         XNWSR+pP0qvFpuf/INjDEF1AgYxJsZALidCnyY+piwsq3gEfvI0buXzrqjnz1pXaaDWP
         tF7X4YF2rEyVBMnEqmbCbfqZQOUPGvLdH6++dk68FHIcLUzzshSxBgYYZ1ZYcnUtXE8T
         RqeNLiDmGvy62YPjHItSzOGX230z5VbF4eI8jayvry0oxB3hT2LvQ5IIvMMo7rN1ewsJ
         SkeGZyO4Ub62xiXQsnse7TQrvdAnBLNB98UOokiXC35ohSgj9oVRHJU1nVIaxDUAFWnz
         CCyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xgNynJPTQvLDnKaFZRr6xsTlWM4rfoKY1aVdZB52t20=;
        fh=09kUMs1WXocUREWt6VD6Lbq5UOSBmvTXajXUMXfqEtc=;
        b=cj4iF/AI6PO3MHWh9F2WHuomG8CzwbSYYOTx06RdraHe/1kn8j0Tp6PwZC3rh4fbwO
         3B8gUnlJRxGyr08mhF/Q/+WTU412hphXHsGmr7/IrolL/RQCVz3y60K0CEgONxoAurGu
         l5H3JBeRo8dQgsSNE4wLi7Bnl0ruj25MvWkVpVDAQdzZNsDAwm1vtZ9LFhRzp5ZfpVbu
         Oh3GjCxVDytWcFzFIRfrWq3JFCHzTP9kCsmPIWE+Ud8641xnYtYf3IIJ6eyAemGNme7s
         3C74eCvjkCwID15QxdOmn8tdj5Gm0Bbxx1dXBRf9cybQkfSIndPNjEl9V9XhHwqJPZ8L
         kcTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778019608; x=1778624408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgNynJPTQvLDnKaFZRr6xsTlWM4rfoKY1aVdZB52t20=;
        b=hpQoOy7MURrxdWC1wWJ9OaDo2dTlaxDIYOSxGDDn93mOsX2e5nDj1GIOrHCdD4mZJC
         YiB3idRTSHAJHwQOGEuqG4CSLlYG8Q8yEdxMLaltNZSvcYmTFS6WAb/Mxsu/V4wfbT2S
         1vkORZONLji78LIdKnN+ULaXIlk/GiX/plugPF0yQIDT4pUEwxI0KMY9XjreeSj34xc4
         HSQ4eHrGY0GtHAsS7isfCwphgGE4aXEfvVLHIbuvDzaBiU97rlXr3inuOYkS1s0T7jMv
         EyxeBLnGwSZNHcCTam1CDPhbzIyhxp+7/qhyeAmuzqyUfZWmMYuB3scvTJ7nKemlK1k6
         NTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778019608; x=1778624408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xgNynJPTQvLDnKaFZRr6xsTlWM4rfoKY1aVdZB52t20=;
        b=R0tiOaVyupTWxnwUU9iQ1d23z45wcXw+yI0Y+lOWqQOAWhCBLbKPp0h2LOyB2a/DNG
         lgqp7qfwqbQZaVugXmA3oWi73FeGDjRiE9lgcKyupNHSAAjmGoZFXJlczjU98nfFi0pl
         kdhYcwRURPntasfxoNE2RGuff5Yc2Y01Iv8eQ0ZtGB5x3pfGz3GJChKel8F8DcE0cOIm
         8pIsRypHB/Hwxv8TC6akbKKax6QK3EDb6N2IHVoUdwBwZKr9qGvh1Z+6kIhpI+HYuH1v
         4nE8mlBfhhltCtjd+IucfmdWwNB5CQs2mVuN1w56JO112D959IOcX376FwnVtyeMEL+i
         S70A==
X-Forwarded-Encrypted: i=1; AFNElJ9jMjEkbswUb/DtR4OVAC5lAWDHR+BBq+vaUMfhB+32XWGjbimVYcGLYAmq9HsVZHYvQ0KNHgYsaAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVynD/s4R0MuV5T76BM6BmRXGD29CXKqFf36vmjScccB76oJ4e
	J7yqqz5GDVutbcSh1EsfQDVMJG3fi08hyeoLdfclpjM2QnT8qXyZcMV855QxchnpA5wBmgDdbq8
	NiwtxNbEkTuD1jWhbWWYmWVAONe8iJIw=
X-Gm-Gg: AeBDieti/7BMSiiuZ5tCa6RHlk8jWjemGo7LDcKYHFR7ZclS/pLKiN+ImzfzIbkA4JV
	rNAlkACqe36sfJLQhjTKh+W73fqeosC7ej91lbg3ueW8dS11QMxsI0zpMbbSvcF0LAoyhnppxbu
	TZpCCswC8GTfrelSiARp14+qfZP06RNxTuvlbegJYlw79yKunDUtpZcsgqUD4bXr5vit8AZ3wB5
	578LCtrbBuVgStd2vxoBY4Fu97d3PIiyLkEpzDTu5OkLrAJsixl0WNtZ+4timtE4sYoPurEY9iz
	qGnw9Q46DXhQ1ZI14SCBNMyTAg==
X-Received: by 2002:a05:690c:e04b:b0:7b8:926e:3ef4 with SMTP id
 00721157ae682-7bdf5dc6f08mr12520457b3.17.1778019607741; Tue, 05 May 2026
 15:20:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505211751.102563-1-salah.triki@gmail.com> <CALoEA-xNNxDRCYxL0hWB3rEsNVPA=8U8Vk73B1vA70FzZqW=yA@mail.gmail.com>
In-Reply-To: <CALoEA-xNNxDRCYxL0hWB3rEsNVPA=8U8Vk73B1vA70FzZqW=yA@mail.gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 5 May 2026 17:19:56 -0500
X-Gm-Features: AVHnY4IUUedELRvhNyf4n0TRBPVTGuezLoXO9Waf65cftkV_xh4BS-A0bxYcgno
Message-ID: <CAKqfh0Fb84j55ZNr3XFBxqQvnLGeFPr7e78hH6_rSs2Rv1sm5Q@mail.gmail.com>
Subject: Re: [PATCH] iio: viperboard: Fix error handling in vprbrd_iio_read_raw
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Salah Triki <salah.triki@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 5:06=E2=80=AFPM Joshua Crofts <joshua.crofts1@gmail.=
com> wrote:
>
> On Tue, 5 May 2026 at 23:18, Salah Triki <salah.triki@gmail.com> wrote:
> >
> > The driver proceeds to the reception phase even if the preceding
> > transmission fails.
> >
> > This uses a goto error label for an early bail out and ensures the mute=
x is
> > properly unlocked in case of failure.
> >
> > Fixes: ffd8a6e7a778 ("iio: adc: Add viperboard adc driver")
> > Signed-off-by: Salah Triki <salah.triki@gmail.com>
>
> Nitpick, but I would add adc into the patch title ("iio: adc: viperboard:=
 ...").
>
[snip]
>
> Code-wise LGTM.
>
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
>

Agree with Joshua here. Should add adc to subject but lgtm.

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

best regards,
max

(p.s., might be a good idea to send a patch for this file replacing
all of the mutex_lock()s and unlock()s with guard()())

> --
> Kind regards
>
> CJD
>
