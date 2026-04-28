Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D7C450904
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399399; cv=pass; b=oeJSnCOucnjstwduAP1ZcZykv9DpEMbRuR45hDBQK0NthtoWTgLRwswoXwxVg8Qth5ZJw29L2oEaqAjppG5CPaeOEoFRYge176Ps+2S82VyDrOXmuSIk9rwY6iyuKBl0BLvb+xarr+ovfo7QDrgf2jWgHCT0rag2HlzkPo16iAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399399; c=relaxed/simple;
	bh=Gj5kNKHiKM0+Au1qFMRM23lhq4ixWxWNBV6x1UuRbIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNyn8MBDZDzYN6pW/Nyvwum9TjT176bSlIFvksa6ykkcDE9nO0/DV7ATu/O1o8z/JSNY6miyJ1HsjpVNaqy2xUe1yad37M93T3en3Xe9ssnXLEj7yY5AXD7/3ebYEvqKU8GhLwB2U4opahFBqXNIaDraZAJQYVzEKBNesU7xxiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGOUFOaF; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGOUFOaF"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d7badbd7dso5791775f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 11:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777399397; cv=none;
        d=google.com; s=arc-20240605;
        b=ShA/qBxm3iQqBe0ChtVijQZzcp12dW2XDs5Usc4OOOepAEhHp6GDDmIpuhE0rZ0wj4
         n6ykah2mogXoKWab7VF55cWz2M59Jf6Zz1wmZIivS/XyoayoyZaGwciDjLgHwKmv6DrI
         JteIJoLYb7RQTZiNVTJJ67gUAp3OtPNejVqtGMwMLcm8/SSrKI7clggTMy0FZMPA291V
         wkl3nX7IGUr3DS/gZf2+yp67wepZxK52JdAblhMODc79CliEK1ZkXOSi8/ZxmzbV7tcc
         pDdsW+QDSAiUI53P36QgRQdFZBhPL6sePvyYyveLGjvXniaNxCTe7eDgjY5ThJZc89Hl
         k4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=clMjyO+6vB7UWgH7GxcJd/5ADKnu72scSHbOBreXs2s=;
        fh=uXsM05w/sSFFVk309EkZBvav/ugpNtZ+hdoOoGFe9/E=;
        b=ezr3Z5zyU/DlVdGUvPhj5UXs9/rAn160kv8DKK+7AoV8EPaXQBOv0S9aEYPvWmRwxv
         eMzn3zNdJpird/2xH4zXJyhCLZVnHJjSJLaaUla6vumsWp8rNYB0GWgOBNqaetbvbMGI
         8M7WMJoPcApx2Sw1qJudUuLPaGlPgO7BtIUcaCACdfZZmMSEfSQPe+IokjDA1TodMiyg
         VW32LU/mvDoeb4yuB21d9EQF2yRygxQBFd6vsPS27GeyyUOpFRkdokqsTXSCx43TpVYT
         qqA0/SU9yXO6AFMJ5k2UpM9Q5W5ApI64zq9wrQEitx8UY44vA8G7/zg1sq9RSOba62ed
         2KQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777399397; x=1778004197; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=clMjyO+6vB7UWgH7GxcJd/5ADKnu72scSHbOBreXs2s=;
        b=BGOUFOaFR8Hv9S1kyHlJJJOLoKgGTuoxWDop5+qkoD+l8xoGL/9otGHU939KhRLM+B
         nyrG1R9B/nqx2LTlyw7pE442wDexxokbJwPqyVte2HbzN1Fscry7VDPXNr0kKUOMJkr5
         DPBwtGH9cYaTC9EKwg9zKi7j33QTm+rNTc5NfDj1dmss4qJ+ILUEu6exPTWVhi+Blilv
         nY8nKcLcEt6Dk6PelsQA+g+DU+In7YTUgN3NMWBrJwxuOfwdQ12j5c8zj6hkQPM/nQy+
         jBFp7tzEGb6I1ajRU2Wgr5NiXNwMYg/TFwYJ6Mq0jZvjjKIq4HZ2DJaErtLUEA3iMzv1
         dcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777399397; x=1778004197;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clMjyO+6vB7UWgH7GxcJd/5ADKnu72scSHbOBreXs2s=;
        b=Jjvf0fLXdzib0Ip8z/RadU0LWNvVDqmGWd82Icb3U70OHyXDmWDt4x8DxXqRb0HYCg
         /O5nen7YIZDIYSpLF0oELuTaK+z6fbYB2IVJJOEqNovgTnwaoFHL3hlo+fg4ZeztI+oz
         WUDgXaHJW9ELPo5yuSX2uekv720auwBqUPgKks8pbaH6b3NHMb8YqkaTF7iTtwOBV2M2
         KU5GarEDIiCOQ9koIh6NEejncYbeLw711Q45uCNj5VfTf1vWK466IU5GEHqKtQU2SXNL
         F8lkcccylm6VNL8DFpgCpDpQa04TpetdJeQITzCDcQkwxOC3VfvFJ8TYXorWAl0enzjt
         60yg==
X-Forwarded-Encrypted: i=1; AFNElJ+fKTHxuOSMf58zkuMlRtVWz6JL87yI8wfBwRKmTO9P4usPUpM1CGq8n8EN+F7B/beQ2dFc6/9fYeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEH8bGOrW2L0nt6ONNuTiC8DE/nGC5XDoGJ24bl+fJoXYFfNu4
	oT5r400CXMOvNpGtac/oi2M8ixnEl3kpwy+XNoMmw7EQBuABavwWnrOBovSUk6Dk03pRAOvhosV
	b6el0jvkZUXhLL35wIDAfFGD6S2vil1k=
X-Gm-Gg: AeBDieugTMJHBdVpmrftBCdE54gXxTufRCFTMagdH7yu9vWCaDVrHDEEZx9/N+7hl+J
	XzfSyddQOiR/d78Er1uy0JdaUkUjdEfXGX2h2rv5agmL4HLf25lDrchWMEGPDsWN728F3jJpll2
	ZgTotdDq/z2uJ2MjHz58AxdhohXp6XpXmo0gRdPe7YhSOVzG+LEdEaOVzqgmcpBLoba4LlgBprw
	wKZcD2eqwVVxM2GV0jM4AgNIVN608lSoyH8QYrMoqMmOPtaUqe5dbF/OyIjCe5JlVOEuohdsna4
	ipgKqbJKdg188flDcANKNpKMXVT4zV0Wtf4rgV9ENy+An7LbHPRX6seP4Vdup/Mg7uRkWuK0q2B
	zfDCB21rIyNVSDR0VPdD8Et7wUkQl1dyBULDjG+roVpxpy7eOb0wdksIj13C/439S1EMf1GP1HX
	ZSxFnER5rLO6O5//1cWNSLyZ+d4v80mjcxxhA7SigmTQ7w+CROXQ==
X-Received: by 2002:a05:6000:2f8a:b0:43d:21a:9a3e with SMTP id
 ffacd0b85a97d-4464a9134a2mr7070378f8f.32.1777399396376; Tue, 28 Apr 2026
 11:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427100950.33936-1-piyushpatle228@gmail.com>
 <20260427100950.33936-4-piyushpatle228@gmail.com> <CALoEA-wAUpZ7_2_3kB33mNB_Y_DAc_p7QwPR9a5pxL1iET_cdw@mail.gmail.com>
 <ae9otn7HuPKVtzsk@ashevche-desk.local> <CALoEA-w=giUoevbAh+i66ATKfXCr9WUE0R6G6DOMq2xE8cibEA@mail.gmail.com>
 <20260428185404.26f3da04@jic23-huawei>
In-Reply-To: <20260428185404.26f3da04@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 28 Apr 2026 20:03:04 +0200
X-Gm-Features: AVHnY4LDI48Ptd6qgL4Ex-MeV9CkZfBLPM2365IsepDAk2KUQnnN6Wnzh3ySm70
Message-ID: <CALoEA-wvYy3Ji-3PsCduHMomwEG9KmpxSvL9xVY2vUPC_BnM3A@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] iio: adc: hx711: update Kconfig, module
 description and file header
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Piyush Patle <piyushpatle228@gmail.com>, 
	ak@it-klinger.de, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Apr 2026 at 19:54, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 27 Apr 2026 15:49:06 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>
> > On Mon, 27 Apr 2026 at 15:46, Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > >
> > > On Mon, Apr 27, 2026 at 12:26:53PM +0200, Joshua Crofts wrote:
> > > > On Mon, 27 Apr 2026 at 12:23, Piyush Patle <piyushpatle228@gmail.com> wrote:
> > >
> > > ...
> > >
> > > > > +         which are used for bridge sensors such as weigh cells.
> > > >
> > > > Typo here.
> > >
> > > It's better if you point exactly what the typo is.
> > > I think you meant "weigh" that should be "weight"?
> >
> > Yep, that's it, my mistake.
>
> Nope. They are called weigh cells not weight cells.

I stand corrected.

-- 
Kind regards

CJD
