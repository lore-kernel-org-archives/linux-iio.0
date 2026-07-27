Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C61F3DDDAC
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138467; cv=none; b=EK305Gs9Ik8oah0cxO5CzY7gfReGU0uEr3vWRA3Ck5V+ahFcl9cNiFUN2ImuNQoleGrGiCIsJYuVis9+N1d3/3MXpb7oHEQv8NVooALGF1Wnp/SPxOpNR50Gpwq7nYxP7AZ5Tmt80Lqvn0IaNb64ccWWFKI+szQN1TOQ9APz8dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138467; c=relaxed/simple;
	bh=JvxUq/iYUDkBFhAJpNpfuCTuKCodr+3K1ReumsuOTW0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwbkoJr1O7PXKMbZ+K6d63CJp/DzW9OAbMM8GO6x8oEcTeeEAIjnAir4hFOfZ9+22e0v9YFrJEt81n8mnTx4Ak/qpsmRL9VKJ4MIf9pi6eHZdmpIxeMfaWpv6dMYZUoUk+2rTxdlWKzZSJTpLsP0NzyIB3fwyHSLu+prMTC7fiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Us/mk17p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Us/mk17p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A24F1F00A3D
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 07:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785138466;
	bh=LMdxTbEBC7qZA8RQ+1HVgfF515tY7oL1xF/DhlIoUos=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Us/mk17pVkhDMx0imCnsR1/FdtpGBdBr5EmUo+4q/epDMSC7W/btrpK9pjt8V9aST
	 p7WukUWMZvs0i3uErF8fp85fRYDt+Bw2RTch+g50/U3EvoFsGLFQa+ngHhBauHZDnM
	 9hXmKph8cFZcqF14pCY8lqoaXj5XFOBkh0J1aD+PVOx2SpwM/OYtWvSLcgVtiX2byY
	 HUvqZcg0cBbNBuNRdd85ez67E+mDKUuzzlIltzw2zHw4h2ElwVLxO0wGdc4sLcjdef
	 yWexROKJuXWE74MNxbukUV9VLryzaYWhpjxs8lqMKAoKcFb+355pbUrfBAjFJJJURs
	 OP2OSaucWDKEg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b021916bd3so2589791e87.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 00:47:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrVm2YN1hB+gJcJaEkIhC7nOp6szt2Uj3EEb47qPqnAl0BvnonZOuHU3qzizW7BDIjDRWOY07zBbQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YziX/gUNOuaxvcqPzIDJGNw5rmK755P1uOBslF87dnuSuVn4Mdq
	v+QtnURggA1gBFJK1ZkyoMpiwZQoMalVYHZY/ds3j7ifjaKIU3age5Dxqtw/DxSd41ZHD3TwGAF
	pGEuOyrYy1IfOJZf7yPalPVgdRjfxzKasBMw7J98xAw==
X-Received: by 2002:a05:6512:1191:b0:5b2:8a6a:1dca with SMTP id
 2adb3069b0e04-5b2c1b297b1mr1336942e87.36.1785138464623; Mon, 27 Jul 2026
 00:47:44 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 00:47:42 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 00:47:42 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260726141029.GAamYVVeVnJfH5ebH5@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726101739.33170-1-farbere@amazon.com> <20260726141029.GAamYVVeVnJfH5ebH5@fat_crate.local>
Date: Mon, 27 Jul 2026 00:47:42 -0700
X-Gmail-Original-Message-ID: <CAMRc=McOT6m1CsmheePCxpZnB+GJmrqYa+D77Dz76Ovy0FPadg@mail.gmail.com>
X-Gm-Features: AUfX_mwvXfjV5Db7FPNy2PNZM2AvQmMoXAOyTg5q8xJTdsDrQvC7kqKotPet8MQ
Message-ID: <CAMRc=McOT6m1CsmheePCxpZnB+GJmrqYa+D77Dz76Ovy0FPadg@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] notifier: add device-managed registration APIs
 and convert drivers
To: Borislav Petkov <bp@alien8.de>
Cc: rafael@kernel.org, tony.luck@intel.com, guohanjun@huawei.com, 
	mchehab@kernel.org, xueshuai@linux.alibaba.com, lenb@kernel.org, 
	laurent.pinchart@ideasonboard.com, linusw@kernel.org, brgl@kernel.org, 
	orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	dmitry.torokhov@gmail.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	W_Armin@gmx.de, ukleinek@kernel.org, fabio.m.de.francesco@linux.intel.com, 
	kaihengf@nvidia.com, ankita@nvidia.com, leitao@debian.org, pedro.pbg@usp.br, 
	paulmck@kernel.org, frederic@kernel.org, kees@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, Eliav Farber <farbere@amazon.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Jul 2026 16:10:29 +0200, Borislav Petkov <bp@alien8.de> said:
> On Sun, Jul 26, 2026 at 10:17:26AM +0000, Eliav Farber wrote:
>> Many drivers repeat the same boilerplate when registering notifiers with
>> device lifetime:
>
> From: Documentation/process/submitting-patches.rst
>
> Don't get discouraged - or impatient
> ------------------------------------
>
> After you have submitted your change, be patient and wait.  Reviewers are
> busy people and may not get to your patch right away.
>
> Once upon a time, patches used to disappear into the void without comment,
> but the development process works more smoothly than that now.  You should
> receive comments within a week or so; if that does not happen, make sure
> that you have sent your patches to the right place.  Wait for a minimum of
> 						     ^^^^^^^^^^^^^^^^^^^^^
> one week before resubmitting or pinging reviewers - possibly longer during
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> busy times like merge windows.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>

If the above snippet is not clear enough: *do not send three different versions
of a series on a Sunday*.

Thanks,
Bartosz
