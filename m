Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8387236AB41
	for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 03:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769139775; cv=pass; b=CBD0ciPOYR0E1SW0T0NsPl3xmG3V10a201ci0urF1vDVfZbrV43itphrpNSxE6aPEaxtyw2jbjiAVEN1Xq+nYUmCOWZOBn6rfGA4owJCiF3brjluLrLn5rzbr2owX6WL08QlCud/JlrRkjU79kEnDtS9C5PvPcZX40ReCqRkAeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769139775; c=relaxed/simple;
	bh=6TD0b32Ln62S7BZ6s194Ux9yyd2kJC3SHQtMWpNgI6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oxt+P8W3oK4S8yueJsCZFlordwTivrtZnKdkLkqFAgCOgap31HZPysM3Gh52AjhB3KMz/yEOfr/JYZxiivBqRf/wdTn6NXJCSk5RwfSQmFgY/MJ6LUuM/kOHmggGCy88IpWAfc4aVh+S9zaP0bJOpyb+RmG38AgnjeilCrWQDU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Za/+gGKc; arc=pass smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Za/+gGKc"
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-658078d6655so3657911a12.3
        for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 19:42:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769139763; cv=none;
        d=google.com; s=arc-20240605;
        b=W5g55SZzXIYEfxOcOTFupEgbWVn3JL0Ug9A61Zfm3d/fm5L+eNptrxg5DnzTqhhYW1
         pmX23f9Xx4Z8XeFoZc+czfyUNMFBMuglAv6ibemn2nH4MOII0T3L0KUafr667elPDJHD
         emazb1/SYME6EdAqJSaiQTSZjdDC6jTcTmlS++kvtyboElYb+f9dZNCBtu+G+Kb0qbXi
         qm19xU1KfuX1py5lxoDzK1reo+SevAYd2Zcm1+8H9u+fp01InH2bbo859GK9R7ssty1m
         MkWG2vzitdrbwOfA1dTLUYH6pkI5wyJruRlXCq7bZpMTRHjmVtOednxVivIrrsBFb3tu
         EsCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fhu7ZvgNpYhQg9Ywe592OTR90AlliHNVlH8p51OKWVY=;
        fh=uVlhHU20hJ37Sf6mdo5Zn6vqes+8UhHbfZBInKbUDLA=;
        b=cYElI9IY1F1kKuSuOdbu/Fd1jjgG1HLGqxXA+p7F8/FOwzcRu56O+z6hGfgp/hDos3
         4B64o342tt6d00QyYZfW8JunvEVTSwi1AjSx6w7g34TDn1B8HY9t1O3bfH+N5N7+ZnqJ
         w3ZkU1JisyY8J8kdaVVk0ixDW5EZmlEOPCrR3S1K+mJriTfSa76H6WWHzvTkvMWcHin4
         eWdoc8K9CftWERI6Uf0leNjjx4ajqOVMTYUCdztMZvWrlzFy3fIjkyPd1qipGXtAYBNF
         WW/6XafgvPwnXNgGiHdCeC3HSS/LMH43WGnNwOZiZR2DtA+lpQzcjkcy1N/2sbvWY1yZ
         Opfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769139763; x=1769744563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fhu7ZvgNpYhQg9Ywe592OTR90AlliHNVlH8p51OKWVY=;
        b=Za/+gGKcZLqVa5TEN8qceyh49Kj7b7P8k2+23DEDRkdPmtEORv8ODEmvnt7ffTVfyo
         bM7dA7GwDTnUfsYXg8fJb9A3Bf8I7DdzD1GTxF5pfgjow2+0TyNjnMUbWrqUigLNCkUn
         x2hGIR71MLU4WNZnXjNmNhGZ78xVFb/CZ4Kbtq/RjC4qPfvGf1pOHhCriUl3EZzSVDvB
         Segm2/Hl8HiIgspFqQYATrL0iYMiG4NofHxegZ9SBWQY/9RK0o+X9vadRwByylxa2KfX
         1WmT+ZRCr5/2QLTwq0tNXRcw3+GtbAAdrTkWvLmp7LtPLknnpS9K7eP7NTWqRLXgSYeJ
         Nyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769139763; x=1769744563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fhu7ZvgNpYhQg9Ywe592OTR90AlliHNVlH8p51OKWVY=;
        b=wxa+Mn8lxnoYttASDEzpS09j7dp55PCoBtGke2/mg7UIdqgVQwXNMRpnZVVn0SfJya
         8MJmo2lmLhq6U9FvMYJR7X6m4BN4hQ7T93jnm3swg2yH8Gm62g73SKfW2xnuf8iHNiQs
         jx1ZOSTJNzr77iMTONlqFwGOKrRzt27TAyLZ4yNYAWmJAw716BziGBGz1yTv5DxxVgCn
         ZApd0/Ujo1LjDgUGPyZNUVHhFRC3IQ7UQvDoTJwjqsqYeJQdPnJZsaKU7ATjlJ3Ay78W
         dITqAkESzHY5aF4tT8jcUVDpGKkVt6cQjSauDjQlajaiY/uItL1r1VWYRIdtP4Dd0fYj
         SdTA==
X-Forwarded-Encrypted: i=1; AJvYcCWSC7h/90X7X4SX0o+/HefBkJDB3VIXki0IZvk3SuPQlU5NF7l8SkIvltRjc8FIGWC0JdapX4S8gZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEmgeA7EXAe2wpECJQAHhQGSIcCx5mIFK7qxmOA5Xz6FTFBKR2
	jNlfWsS5lCv3hIaidY5Wr92oForfc9tIwbd4ngWzG0ts8zHrjbZIcjFCQhHKXrtPC6fJQqMBjTh
	WahVmo6IZkC2yKyorcDr3jmvm9p9nHrM=
X-Gm-Gg: AZuq6aJXvmF48Rdm5DX7h+kGtpG0ANlbG2DuSkWdBIJiy9YH0N06VSArH+z7ONNf8m/
	GlRex7y/18iAfbx5l39vfR+qSkMisgfJQ/DkxmpPXs2RD0EdBTJE6sEnvGweay0F9s9xxx4l3ZG
	yb640NsQm4Aq/QFgibWivXa+jSm2GrrwMUa8CRBMccEIoGbu646o7G2ngUt9GyxId/DJr6olzl2
	X61qD1rWQ/+PjN3csLR2Tw/JxrDUNHv0Po4KzLnWpGBPotlhlwd3SykdD4+RQ/dmu8vsqg=
X-Received: by 2002:a17:907:60d1:b0:b87:12d2:fa1a with SMTP id
 a640c23a62f3a-b885aba2205mr97858966b.12.1769139763184; Thu, 22 Jan 2026
 19:42:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121-b4-rfd77402_v5-v6-0-5b944d0605dd@gmail.com>
 <20260121-b4-rfd77402_v5-v6-1-5b944d0605dd@gmail.com> <aXCUKMcCyYBf4ZdJ@smile.fi.intel.com>
 <20260122205749.4f939243@jic23-huawei>
In-Reply-To: <20260122205749.4f939243@jic23-huawei>
From: Shrikant <raskar.shree97@gmail.com>
Date: Fri, 23 Jan 2026 09:12:31 +0530
X-Gm-Features: AZwV_QgQuDKgw7KT5YR5_NjgPa2A5HegVahG1WA2RPaAl1612szEP6Mpgb8ciBQ
Message-ID: <CAHc1_P6cPk8T1SXK6jmYPsqzqbwM0h6_9eJ82OiRO-uC1Sn+AA@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] iio: proximity: rfd77402: Reorder header includes
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 2:27=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Wed, 21 Jan 2026 10:54:00 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>
> > On Wed, Jan 21, 2026 at 02:05:41AM +0530, Shrikant Raskar via B4 Relay =
wrote:
> >
> > > Reorder header includes to follow kernel include
> > > ordering conventions.
> >
> > FWIW,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> >
>
> Patches 1 and 2 were already queued up.  I've rebuilt the merge
> in my tree to drop patch 2 without breaking the rest of the history.
>
> Shrikant, it is common for maintainer to pick up the early
> part of a series whilst later parts still need more work.
> If that happens, please rebase on the appropriate tree or
> just drop those patches form your series that have already been
> applied. Otherwise this mess happens where new review comes
> in. Review is always good, but it should be clear if it
> is on applied patches or not!
>
Sorry for creating the confusion, the patches 1 and 2 which were
applied in v4 were dropped from v5 onwards as per your suggestion.
Please see the links of the accepted patches for your reference.
1. https://lore.kernel.org/all/20260101-b4-rfd77402_irq-v4-1-42cd54359e9f@g=
mail.com/
2. https://lore.kernel.org/all/20260101-b4-rfd77402_irq-v4-2-42cd54359e9f@g=
mail.com/

As per reviewer comments , I have split the existing patches into
multiple commits like:
1. Added pre-cursor commit for include order
2. Added separate commit for devm mutex initialization
3. Added separate commit for kernel-doc for privata data.

Because of these separated commits, the total number of
patches in series are still 5.

Regards,
Shrikant
