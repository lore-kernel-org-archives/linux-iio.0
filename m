Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936A1344030
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 20:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307643; cv=pass; b=ClfJgV2FhawqXBykb7XAerlOuT+ioTVPf2F5H/FS2UXQCYXnWhC67C6xIprRDAcWOdMRQY6EShY5XpjquOj79ncv+Xbpq8Qe7klZiDasmRgXpg1tQOwPPLhI79u5j48gXoZI88msatrWT9Qcpws8uq/M0BpHV20dJxYkNCqNulc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307643; c=relaxed/simple;
	bh=C5fLxlALN8cJkXmqKTu/L/NIXq55LS1VOn5r0/lEAss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPQLS0cQ1RqWcE3wJzh2B2bmcmLAoNlXfoghiIyT1qI87xQqQ3LQbbqHghyBCKcQ8f0MLhnV5nlINHLlqX8b2fr3z0qCh3Iq3NvoKF/NfXsjaAFDTano1mT2GenJv3x1UknrQ6B3aTQjQElDT2NTNR1a+Q6+MosfEBNI2uWAgzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwsmoE8C; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwsmoE8C"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bd6f65c781so43682417b3.1
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 13:07:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779307642; cv=none;
        d=google.com; s=arc-20240605;
        b=C4JJzRgQXlNmseXsdRfSEWq0UJyjeyrll7hI6kTihNcQdP3Le0Fa96Rr81crlrwHj1
         aFutHoadfnnK+8lPDyf/336HwtlcLG/xUsoUyGkuEzdpmx7YdBwuJzwjWDVNhsRKBneH
         t4R/Bvf72Xs4D5Yv+tkSp33kmsr7eMrjxpIlBwycmKSIr+GFiXFSUngzHOTZ0yKVWxoY
         VO/Y9RpfSUPsNO3T+d8RUN9N41rdKv11ntc+MZN11yfXjImCFgm5WwOuq2iqoe0DLWpY
         6V/4wK9h/2zMnfYG7v63WwXqM6q5FeeMau6kO9cN1XySyRtV8sxMojD1krzCCFjUru3S
         H3LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C5fLxlALN8cJkXmqKTu/L/NIXq55LS1VOn5r0/lEAss=;
        fh=MB0aW4qdGz958zdRq+Awt3sqwOcMIwBtUacNFt9xN/k=;
        b=c8ktDTcKhOf5dyQl2w1whUSobVUqzjyQJkDkZ/y4buWCHkJWciyLNdsxjzNSFM7jnu
         YvOWXDz+3ZYyWrk3cVkhb0QVE07nSQlwMe/xNOL419mRJDcOPSB9arQEllyuJ+QeGP+M
         eeh2mGtB8CkOUUdsTdG1ZJsetJQVBr8l/PPAk0n6/1i+OlnadXx/ZrBB2aykcLct9efl
         YFOWvyVjkYslP3nzZ/CGLxoO29d3RD9YGLqv480jDkF4RRpanVN0EI34Cso8zJERr3+U
         n68Z2lDu75ppXtdG3Wy4P25ZTh8pqUi+TdDkixd2jO5EmXm2ytckj5sRD6bNOsmyswCY
         tjHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779307642; x=1779912442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5fLxlALN8cJkXmqKTu/L/NIXq55LS1VOn5r0/lEAss=;
        b=jwsmoE8CPTj9PAoPbs6SAhylTpDWPqkUfJumGPILmieo+vG8Tyz8YFxrxtI0ZKhOPn
         XomT+J4eYytEm/4TryAi1E342XR4M0Iib5hEk5n04F8QtSMP7WC/1FShNlzwRg5Y3GqT
         xxp1Pguq5MM+OclmyZIpEMYmgCJfAbw7DJO8+lCsypEXN9q624WJyCiep0gRS9ICEXrw
         lvyJkakI4hQnJuUFjsilzNglJvFT7kYmWBMMmIeGus1GE/c2Uy2/bU3Zxsyf18TdjqA/
         Yl0JUKS3v2g1b0tPAzQHsDlVAbhsrD32B9BsWpf3PwYx/N3y+g102a8BRJZnyy+GCsf1
         lhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779307642; x=1779912442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C5fLxlALN8cJkXmqKTu/L/NIXq55LS1VOn5r0/lEAss=;
        b=PlXhoD2uZPFas5M2bGYp1DjjFOPufpp1OfR+OsuRKSIFSXCu2rdSfqE7+e0m3KQgi2
         kgx1P9AY7/cv0+sH3SSOiZfsX91i/MyYhYjRnBAb05y1cT1U75Eu4p+nH9QbSHxcVxwF
         6cW7Oofsq/tRRseTmvcKbO3ar7Zi3/fqq4Invjg+0rbZkkEuEWVI8s/K/WMRE2DqGJVW
         z7IBOcwNrUWbQYktDUxYOykQDqTVc0cNWU+aNsUK8J514vp2m0sFckIsKEH5Y+eUl6B8
         9ci9bNyolJeiV3Xo7+HlPLlyyejq5t6TBVQ4lmpFZ2Gnr0pSKqMM9JCX21ngLBltl5bS
         UxAw==
X-Forwarded-Encrypted: i=1; AFNElJ/oBktVC64+I9AQDcxW7HNOT8vHOSINCK9GM1Tzm25pwujdDg4dejEcTQrLt48zqitS4dnB/0BXrBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz01LoIxfTXu6/LVF4BObVtMIgpA+px2RNLbZjKNESDiOPzqcVM
	KFYb+zvr1gMK6NoXdGt8pQEBYy7+8BtEy8ie/AucQhY29sxFv1uIsUcvAUgwGHM8gOquhoKfazQ
	ibxbVDtiP1AY+S6rJlWLTIjJrQhTg/4g=
X-Gm-Gg: Acq92OGCWHj9qBktdLsI4chSgYDay55Fkzro0Ztm6XGqKWOYWhEzliOXe2gBIyi7vse
	cxBOktqo91iYyH/kACQEUBTL3r45Og9hgcZHkT/QSl/39TzBV05ZJvXCfFyWbyPfjGaJbkaVACz
	9mIPNK9Gm4E7+WvEpQd0arQc/6xwa2JWHQSp4W+uLC3j4e48uK550YG0iGZMK0niZwAi/4KI18x
	oAjpsVuNxLAr5CT8PeIEXBB6pBjUFvBxEF+Wk/6/eiFN46w6j3Rg+5C0Im4lHQXjzzK1zBOoYo6
	8pDCjiq7nw==
X-Received: by 2002:a05:690c:6609:b0:7cf:d535:9970 with SMTP id
 00721157ae682-7d1c519c927mr8898597b3.20.1779307641592; Wed, 20 May 2026
 13:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519212602.30541-1-m32285159@gmail.com> <20260520122229.15326-1-sozdayvek@gmail.com>
 <CAKqfh0G43HY9Mt5WW=0evk4Rveh_4hqkMdragdZcd+cQBNGr2g@mail.gmail.com> <20260520200412.32068dcb@jic23-huawei>
In-Reply-To: <20260520200412.32068dcb@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 20 May 2026 15:07:10 -0500
X-Gm-Features: AVHnY4J_5RCnov4bD9ZA5MxtzJl9sXEVLY9zr0MX5QhISFowZc8fEXjUbQSQ0n4
Message-ID: <CAKqfh0HuhE69rB8_QrLrMq229Q84=SGPVxAFWwYpk1hR=vMiVg@mail.gmail.com>
Subject: Re: [PATCH v4] iio: chemical: sps30: Replace manual locking with RAII locking
To: Jonathan Cameron <jic23@kernel.org>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, tomasz.duszynski@octakon.com, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 2:04=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Wed, 20 May 2026 11:49:33 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
>
> > On Wed, May 20, 2026 at 7:22=E2=80=AFAM Stepan Ionichev <sozdayvek@gmai=
l.com> wrote:
> > >
> > > The hunk in sps30_read_raw() adds an empty line before "default:" in
> > > the switch, which is unrelated to the RAII conversion and probably
> > > worth dropping.
> > >
> >
> > First one is a stray change, my bad.
> >
> >
> > > Also, moving guard(mutex) into sps30_do_meas() changes its contract:
> > > previously callers had to hold state->lock around the call, now the
> > > function takes it itself. A line in the commit log would help future
> > > readers avoid the obvious "I'll just wrap it in mutex_lock()" pitfall=
.
> > >
> > > Stepan
> >
> > See:
> > >> Add guard(mutex)() into sps30_do_meas() as every caller locks it's c=
all.
> >
> > Basic but still denotes that sps30_do_meas() holds the lock.
>
> I'd tweak to something a tiny bit more detailed like
>
> Move mutex locking (and switch to guard()) into sps30_do_meas() as every
> caller takes the lock just for this call.
>

Will do, while I'm at it I'll also fix the stray whitespace.

best regards,
max



> >
> > best regards,
> > max
> >
>
