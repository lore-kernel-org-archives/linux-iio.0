Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD1D2E22B5
	for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785017642; cv=none; b=SfUSjYMO3l8UeEIafpKBcE2jxQlVvFO2f18qYdju98vg5dF+qTGjyuemUAY8XI6Bx8KoYF6CnqU3JJ2hkvrrKEEsOucktN/sHL0hjCalY+bLV+0aUgEaho/yjT2Rogh6sf8XKlvoGHWSp7uEO0/8sed3PUGq5wp4AfMM+KGXrhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785017642; c=relaxed/simple;
	bh=QHnVSPJTCnOzjKm+wDZ/fqbf2BKbbn+ETi21TvqU0qU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFPXC+Cl70aj+Vd+jnLbMQUJG4LDe+MzJfuoaTS+eoimhim3RB2pjNe9ZkrOyCiWTIpK+ROigfCwHOH9mjnJ9Q2UEfcI7mAkTlPpaZwxwgHwhdFRjqwQOf7w+ThgoxsYOMsypYi+nGQ9dpBGvnMi6SBhXz1HXD3xwzpOUvgRRTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=F7WZo6V7; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=nKAKYUk9; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="F7WZo6V7";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="nKAKYUk9"
DKIM-Signature: a=rsa-sha256; b=F7WZo6V79rVHxN6LX2hefXSyNlmC5zjIjiurMsCJEgi9MZPR2ZMYSSWuxu1jxmYWwT3nRhmgUu9Rjzb4wGmwXaK4Q5/Z8gAi+kZeFrnWf3+usSKhSuEvSr24njYkTCU3skSvxjY2jnhaJ4iE8ozh/HVsn89NBvbGjNrMS9yBzZacMo5948wZFjxdjvnhxM9jBQvDVgPlJIG4Pfxz6D37SBEltBZKvYUy2kMDlfv4AygPryKkpUSminVuTCi92DQ97eMkYLWSG0YMcdeG/VZhmGMrMvmg/jGD0wExqCPWg17Vb/CB2LYI8508tYwyIxLaOZleDVF9u8kb7fzF0S9vBQ==; s=purelymail3; d=maxwelld.cc; v=1; bh=QHnVSPJTCnOzjKm+wDZ/fqbf2BKbbn+ETi21TvqU0qU=; h=Received:Received:From:Date:Subject:To;
DKIM-Signature: a=rsa-sha256; b=nKAKYUk9o6YWVqaOMzCOot/QacbCdcqKCoNoB3mQVL8vhnOiBxpFn4y/JoRTRcurvmjk+CWQwutxQWq56pQghP2GcYgkR07Vr7IHIyxTKltrmJN8OZOV+AHcGG3/2+bXsoWN+/sQhgM5vxJmlo4WS3bRNcacO3NTu3mQhdTzuiGJd6uySjQzvxOqPju+e7S40BE0KSXVLvsFWeC82UmI+/q7yejpagQrMYehJ5P2nwpO4aWenRQeWY7/l3IhSuoRdFxjoT2olP2md+ipUdXa05Laum9UVQxV90L7WdGVmGUcJg/3l1WAnCxeCHgSx1po81dfvm4ITZ2HzgAAEXRgoA==; s=purelymail3; d=purelymail.com; v=1; bh=QHnVSPJTCnOzjKm+wDZ/fqbf2BKbbn+ETi21TvqU0qU=; h=Feedback-ID:Received:Received:From:Date:Subject:To;
Feedback-ID: 1013395:40550:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1836604110
          for <linux-iio@vger.kernel.org>
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 25 Jul 2026 22:13:59 +0000 (UTC)
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-664c6304683so1341557d50.2
        for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 15:13:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpsT6IMK6PiXgr5Uh3LuZ4PpmUrZKMQdmJCi1X8Z7ZZjmlX97szTJNijB6W0B8f3GFvOtacxtpBbgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9IwAY94pa7On7ColHg+/GVOCa0hwToEIQrktHI5ksTYcZEkEI
	HqZKJBezJmha1QIL2t0qENU812LYuAm7GI9fEr9edBiSvxHFX+Q08rX9KLQf1/RZlTgJa5raR1+
	FdEADfS/lKtZHp1jdnXCJ33zxcjWY6tc=
X-Received: by 2002:a05:690e:148a:b0:668:49fb:b680 with SMTP id
 956f58d0204a3-668c799e7efmr867816d50.23.1785017639595; Sat, 25 Jul 2026
 15:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713223046.20779-1-maxwell@maxwelld.cc> <20260713223046.20779-2-maxwell@maxwelld.cc>
 <CAKqfh0Gu-iZ5ucKXWY=wzkUHSm1r7-YjaXExuq=tGcjqg5eerA@mail.gmail.com> <20260725224427.6eaf616f@jic23-huawei>
In-Reply-To: <20260725224427.6eaf616f@jic23-huawei>
From: Maxwell Doose <maxwell@maxwelld.cc>
Date: Sat, 25 Jul 2026 18:14:59 -0400
X-Gmail-Original-Message-ID: <CAKqfh0EjaV+qOA_pV27Va5u5vJ=Tas4dgYg6KN6qWTTzmA40Ug@mail.gmail.com>
X-Gm-Features: AUfX_myVb9mfCbh-aIQ6hqfyqDu559R64xcMPRzUGjcK0LcgiqchqxB3qi5d0OI
Message-ID: <CAKqfh0EjaV+qOA_pV27Va5u5vJ=Tas4dgYg6KN6qWTTzmA40Ug@mail.gmail.com>
Subject: Re: [PATCH 1/3] mailmap: add email mapping
To: Jonathan Cameron <jic23@kernel.org>
Cc: Tomasz Duszynski <tduszyns@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 5:44=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 24 Jul 2026 22:10:59 -0400
> Maxwell Doose <m32285159@gmail.com> wrote:
>
> > On Mon, Jul 13, 2026 at 6:31=E2=80=AFPM Maxwell Doose <maxwell@maxwelld=
.cc> wrote:
> > >
> > > I'm transitioning to a new email, add mapping to keep email up to dat=
e.
> > >
> > > Signed-off-by: Maxwell Doose <maxwell@maxwelld.cc>
> > > ---
> > >  .mailmap | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> >
> > Ping
> >
> > I'm also away right now (sorry for not mentioning).
> >
> Krzysztof requested the lot are squashed into one patch, so I was assumin=
g I'd
> get a v2.
>

Alright can do but I'm away and don't have access to my computer right
now so it'll be a couple of days.

--
best regards,
max

(P.S. sorry for the email inconsistencies)
