Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D83C30DECE
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778017340; cv=pass; b=K1Ml/qsUK+jhpFhvvR8KGTiDexIzRBv8iQ5omL0mmQ9JktrTEtxMQhDvIfs7SrlkxLaOUjDjstVm2AZu+dtZg8kg5TKlO76myeaEPGSuB3pYzJZeRY/Xq5pTakO+oumMx8fyO1jaxyUnKAWhQU+Yk1rtCKyCghOJHI95PWs4x5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778017340; c=relaxed/simple;
	bh=fC12YzpgVZCYrcrS0iStM3SGPpjkpG6T65bOF8Ijfwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+GuhyDcPIqL5nugXKKjpHeZmAwEsSk4F8cfyCJf29jIYulf1u4lr0dGAywwTMawgFmyDpDwKa5+YIj5oPdNnT8CneuHiJ+FOxm7IH35UuiQRkKrHI4DnD7Gkj5kB5D3coqYLeYo7vw5SkPGZS/WBMRbCTlLRKp5Q7vj7wwoU+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQL0j1eg; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQL0j1eg"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79495b1aaa7so61594207b3.1
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 14:42:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778017338; cv=none;
        d=google.com; s=arc-20240605;
        b=CsQJIS9IFuOVsy3L+iv8xjCYidj5tas7cGP0vMk00WJomlCMS9lVYqh3bR8zn8+fNz
         sqfUpBEvwtKCiGykG/RMsy6pxVfZYmPGGp+R96yF4nat6HpIQpjP4EabRoDdDanBMWiM
         Gc33NWWApAkPhs7PiucfRDgWnXDR2JXWm+Dqws19RX5nRBdiLAvh46Dyhmgu/r3eTTi9
         rGEBbInNhO3HoBOWbpI3euFwRMSTYApF06vrGT5y+Y9eY7SOM1L2Hbgk2kWyL+7UWpEu
         iASfdjx2gK8NAqnpYb6yDaGiMsE+2suACfhZ/4XKQVy1gYMoo7gW72StKn4DqS1l/Sku
         uHVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fC12YzpgVZCYrcrS0iStM3SGPpjkpG6T65bOF8Ijfwg=;
        fh=kqzGXa2HiSjmauhHR8R7xPjrSE4OjYYumGK8EG+j9Bo=;
        b=WQQjHdOoDQCPtqj1E0AeT77+DqyyvP9keJljqv2SH0Qr3w1aL82AAJGMjdYvfW3+6+
         hjQ6r1WWVWt4Dg7RCOu5CuA4VzfOWtnC4db8OZ2C0O/PiL5Zc7GxZ/sP+16EPTqqi32C
         hREWedXjoRbdPCQ5xsAHivHMVnfWydg4i379Wk1yvuQfaOWSO4cyLcUZ0XJmFiWqiw0c
         2EHDugoaKlymeiKdAB8heJje6m/+qYCls5CKh+5cmC6mYvjvt2PkldIEnPMAKTCdlUK+
         htk1QGnVRrVOFY5OmnntqFPg8l23l2O3xS+YTKSMcSYwIp45bOhjKTNnDt3LOvQ00kfK
         0AvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778017338; x=1778622138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fC12YzpgVZCYrcrS0iStM3SGPpjkpG6T65bOF8Ijfwg=;
        b=TQL0j1egYX9iEW21ZX+iZgAbuVJR7blSTRTFnSvv5KUVi6SVbvtnBo1087e6HX/ddv
         eoqrLcisl4uZFiKGsSBVGmUOMPcWgwbKGdRJlC5fAAwmtKPQjpitmi6AkZYazjfD0CtX
         joyKXl5WEt2SlGMXz5HDFg4hhntahZoo7Nk5CugDEoXLVfmOEDKGV2xLmKYTUhbZkgZj
         6c6azLyHfrwGe6lmCRWR4seXZ7FRVD6ySRwFVzzGxntwzKAPmXvAHQPggYFHh18jys+f
         F1Ges7lIiwAwLUvVP6Hpr1mD7eqH/ARssukYy/JXkCT8fpDaR9hQACsasGAnFin39Tbi
         j1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778017338; x=1778622138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fC12YzpgVZCYrcrS0iStM3SGPpjkpG6T65bOF8Ijfwg=;
        b=sniRWl0IfRy7nv57Ck/TfKtnXiZqa3Cm+n4x7hTWuoGIpUDs0yyy0x06WbT0yzORB6
         TcdxEKrpGu1Kt0NSN+Pji7tZWnX29wsU3/RX+MR+7R2Jl9cz4s4e+x+IzQ2EBdBP2PyV
         87/20XN8r6qahPqmloDft5/eleikeHEZjxf2fWtsF8xTFwbHFvl3JNBYo63ZrVqu4DPx
         p0tIDekOotddl2Ux3qaaDUOQ7U3pjFf7LGEA82Ugol4LwgfF6e4b2W3yH/1Lix5eCjKJ
         6W7lIeBVvxDAkAGc9Y16rpBkJ2LNPo4ZioWNLqtumMaI25K0sYQvGi2Tc7dp3VcY7Vwu
         6C4w==
X-Forwarded-Encrypted: i=1; AFNElJ/HMB4cE0TlCIpuI2nJRXeTbO8IxdVojbWQFGM0hUPEwZmhvnzOCOtFGMi3Y+zhuUntMt+rBLOKIgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLwxA6P6zwTD7HTqn791dElCmubdazWSmThRc7aloDjxYZEmT4
	AK96fdZR1GaGQgoTPA6B1uhj7VOTyqfcK5F1Cuf09kusxh4acLTdSrIBOauwfMbPCW3mWrdDQdf
	RACj5hCL2RhkuAIRESBjkFbTLnXlxo+4=
X-Gm-Gg: AeBDieseh3Y/1upAZfx9pIya11ELgKPDIbRhTAjJUfovSf7ThYK77+TwMwxu++UUitq
	0W2eLJggni/jBXHlLfF97xidJWif6mp/XvLPo1M6+wONw8RUL75947HTTyarIhLEDmDgQEhIQib
	lYXiOZUZXjUg4LLdxF6nlPxCC6Yp3VltW4xTofJHqO6dIxtGYjXKXFwSg5lB/ihLOOcYoyPWEWt
	rovSen1EMMZCg90E9eLG8rouR1h7o2FQnNzNxQuvMDWjpH8ht7DRw8SH3lXZzAMhePKPGUsiTfN
	0Lq+QcSu6vNw1ic=
X-Received: by 2002:a05:690c:17:b0:7ba:ee75:f100 with SMTP id
 00721157ae682-7bdf5d7f399mr12709427b3.10.1778017338200; Tue, 05 May 2026
 14:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-3-831b9b5550fc@gmail.com> <CAKqfh0Hz_zc6+7m2ca8uY-kPNs=ttOh=qni7MdrwFwThEx69TA@mail.gmail.com>
 <CALoEA-xNCjBZ5xdEzEC1zoXL36=Zq5Bfwb0zwP0cU5W0Fs6Spg@mail.gmail.com>
In-Reply-To: <CALoEA-xNCjBZ5xdEzEC1zoXL36=Zq5Bfwb0zwP0cU5W0Fs6Spg@mail.gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 5 May 2026 16:42:07 -0500
X-Gm-Features: AVHnY4JnE34pVXCuZj11Chc_5krKLzCB1ZCFDDA2yr4OmyULcx-WZhOPXztgqtc
Message-ID: <CAKqfh0Hx2Mfb3me2JOQs6hpEKsCexZ9hAuE2fOX1qRdoqg659w@mail.gmail.com>
Subject: Re: [PATCH v5 03/18] iio: magnetometer: ak8975: replace
 usleep_range() with fsleep()
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 4:26=E2=80=AFPM Joshua Crofts <joshua.crofts1@gmail.=
com> wrote:
>
> Hi Max,
>
> > Looks fine overall but has this been tested on actual hardware? Just
> > want to double check since this touches the set_mode and power_on
> > logic.
>
> Fair enough, this series mostly concerned code cleanup and moving
> away from older driver programming practices, so it shouldn't mess
> with the functioning logic as much - however it would be more than
> welcome if someone had the hardware to test it.
>
> > Also I will say it may be better to keep usleep_range() since
> > it's more explicit, which will likely be better for the future to make
> > it obvious. Also, I was taking a look at the docs for fsleep() and it
> > provides "maximum 25% slack", which means we're stripping away almost
> > 375us on one of these calls. And besides, it would eventually just
> > call usleep_range() anyways.
>
> I disagree here. If you look at the documentation for msleep(), you can s=
ee
> that "slack" is actually an addition to the delay time, not a
> subtraction. fsleep()
> will always guarantee a delay of at least what's supplied as the paramete=
r.
>

Sorry if there was any confusion, I just double checked the docs
myself, I was saying if we do fsleep(100); wouldn't that mean the
allowable range is 100-125us? Might put some extra strain vs. the
400us we had before. If I'm incorrect on that you can call me out on
that.

>
> About fsleep() translating to usleep_range() - yes, you're correct about =
that,
> however not only it's more modern practice, it also doesn't require the
> programmer to add an additional arbitrary max value, fsleep() just
> adds it itself.
> As for explicitness, I think fsleep(500) is explicit enough, as described=
 above.
>

Probably true, but like above my only concern is timing.

best regards,
max



>
> --
> Kind regards
>
> CJD
