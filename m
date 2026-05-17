Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B25135E1AB
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779014696; cv=pass; b=ZdRt2+yTD4JNBMbtWqkmq6Aq+MoRwNZJA/eyMMDYdNW6AEFcO8kV4N9QAlwEDAQDmXR4Kj6P+u0qUVPDGrInSgbRH4qk3lrcVBBWHXcK5gyRrYpqtujL1NZnTrbYvQzAWXBh1yB93A40yVrrMAlbI2yIJltnWd1OpQG02zXXL10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779014696; c=relaxed/simple;
	bh=hM1fGuSM6Fo3EiKs9ZLHcJmX57N7AvndiFQcnsXzrXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwJmraj1I6QMuIie1oLFSmjEX/KTL0OJ6KI6C2RHvbM0OFL+5pdlUAic/e2HChxSoNHUP1INcwif4UDXx+PV1jb69A3YIji0s7yShYtQhpf6+yxS5nssYzzumXPYoL37tAlHyPMhf9k5If0MUklkbTjtgvD/J3GKQAUAui005Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oDWJ91Bb; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDWJ91Bb"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c156c4a9efso1502721eec.1
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 03:44:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779014694; cv=none;
        d=google.com; s=arc-20240605;
        b=aub9JNEUX+7t9OyoWLE0HAI+YtJuypZIeETiEJurIzv6wbOp8L2sUKjE56/zZD34gE
         50UK1Eyxn2MSrPSTVFtobb2dioFEvA5XQvcJoQZZb+W6Gkc2Z0nimXB9MDZf4mCrxypu
         mU64zRKKEeCJsVK0iQ9f4wqZyEvv58TdUlJkOXqI/yLkFQq4TsysKYW1e730zfYq4ekr
         FNpzNrqFLGW2pCovadCcPw3+qwBFdG37dRSJjqskhOBhFpzVtdQRjypsde+EOqnb+Ip8
         YCZII8IIMBO5wTVB12WFsQ1RFJJ8sF+hqk9kAPL7GDeZvp/piyQrnqd8tJrOhYYfj5WI
         cqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hM1fGuSM6Fo3EiKs9ZLHcJmX57N7AvndiFQcnsXzrXE=;
        fh=vnc/V0DwXoJtfPHWp9eYoI3d7617tZ74fCYh4xI+SSc=;
        b=Ta0iQTki2TBm3bFlWm4gBkVCxdV5AuahpvYMBAzv5iX2IVPCKct/7WXQVuOXghV6m2
         LsDJ+CmKK0/AjezSf9mo1GJsSBSWjxvtnorsVt57ZKySrW0oKtqoDLXBxSRXUYsJa6Ky
         zsjXfyolVu0nni4hRYx0xKH7BFBhPFuPkZc2P8Yc9ioIwyBAaTnpMngHq2w57UH9vX6o
         ziUe0ERSLnKFP2D5Gx6rpefUPnTMZbY37O4nJPKfBWXlw5NZ16nJ9Kn7EYvcMXom1Aj9
         LR+ri9KiU92EZF8OW5QiEHVT5HteUpnhmOZk+I6MZIIdtY250VftLFCdgTn56fKyU1U8
         sw9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779014694; x=1779619494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hM1fGuSM6Fo3EiKs9ZLHcJmX57N7AvndiFQcnsXzrXE=;
        b=oDWJ91BbKlEmtbnEIPmaQuFMaf28jEa+z48mE6988VcnS+WHxZRsv35sS5Vb2HwRGX
         oP1mRwHV0q+aR8MRE83r111QZ5rsPh9b8RBpjZ6/hpq3mm8299Zym7OU0DuNsxOTuGvY
         gQWywgDBj0pCyv7ahPlQlQXMPMFnZP8MrngRDyw2jeg53erPwhSXBZF5RzMgg3SGtTCR
         hwRgEFuyZ8CcZ03Ycq1W6KSUhb78InX8gZSXIPl1JUNCQL5J64RR7gbTqpFrCXM3H2eC
         63LRFEj0uiTbpnipujDJBo250uVVpKXg3+vbFoSvroO48s/kak1BtTKrL2hiXLc4ZFeB
         DDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779014694; x=1779619494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hM1fGuSM6Fo3EiKs9ZLHcJmX57N7AvndiFQcnsXzrXE=;
        b=Iloob40WkUKg5Mqn9Vs7SvmoEeViFahiTlHrCplowQWPSikzgp3hM7Yo4A2+kcqh/n
         OWdqkhmXZfW8hsH//YM7oAsFGlO2ZJJFnwUYMDtC/tloB4Uo0S6NDOKxntxG1PEqH4eC
         hi12z0J9fwxjgwcfjLZgkdMLvikNG1wuXR0LqqLNkL3Ig1wgT7oFxja1OsD6E3LFKvn6
         jS9+1l8XIXdLOQ4Fwwc7hPPqskHiIe624VHudj7c4RLw+LZMsZs60rw98QfWDhCyk3Uq
         Yspk9rW6pyqMGa1kco0pwTZhpJTwG3ovpArTjMtMDJwliMv04XqiHlOttbmd8629N3Mj
         M61A==
X-Forwarded-Encrypted: i=1; AFNElJ8I5bsUyajoaHYegjWkJbeW9Cogo5FglWvJwB2aPPzY1s0a8cdroPXhUgSWBUsl60T2M1pawySRxcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9FOjkrfjo4pkw0WM3hwntfV5/ao/AFHdJRnqpyv/JYMScQoBD
	TBqwRKHXWQGnfXGHI7rCofNfd1l1jAzwRKti4m3RlX6B0tk7fza0vBhVcjfOCShlEjQuc4rWbhX
	FQRm2zHtviS92zm6dtnzomBDsxZpk6O0=
X-Gm-Gg: Acq92OFtsASENp/i4Uwcdsx0hnXAW3QOqDIOCtGGqraURosA/4VJbFg5HY4M7AL+MTc
	zagfo7BVnyTlStY8Kzv81kKRTcRjWCVqW1U7JpGX+8umpBb70cKYEvjsaAaTtcLOUwithUKOazY
	9+HMOVeerfol4IFF0PSXGGRHnS3eRUCDWGorfdxaXOn/51mCn7+eAu4I9OaGR6bPzS6slkTmGjq
	WkCBfWSsJFljLfaF02lHz2mLnpunTImLDn3pmrNN0RNq7zLh7M21a9NksewxZcFq7+9Gq6JEtbN
	+6f8zLirVXC1GCRqrE8=
X-Received: by 2002:a05:7300:641b:b0:2ef:83d4:647f with SMTP id
 5a478bee46e88-3039865213amr4762888eec.25.1779014693685; Sun, 17 May 2026
 03:44:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517074306.30937-1-clamor95@gmail.com> <agl1T8O6kwP7SFZ1@ashevche-desk.local>
 <CAPVz0n0tfbwa1AbgO4eKrmNunHvmTFLDqXDFd1=VfLayuafH8w@mail.gmail.com>
 <agmWVdi3TkBb2cxV@ashevche-desk.local> <CAPVz0n3Kn5VVxWxCgq2EcRiOaLWnB85hD+-S2Eou=H1PyycJCQ@mail.gmail.com>
 <agmbFQHezUl5Nydn@ashevche-desk.local>
In-Reply-To: <agmbFQHezUl5Nydn@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 17 May 2026 13:44:42 +0300
X-Gm-Features: AVHnY4JnKOSw1H09HcRgWGFJYaj6RZPBdJ63zUWme_H-q0TpGJTcjfCXnVmnBUA
Message-ID: <CAPVz0n2VAUBNJOLXiGEaRn-x1esd6qeheXa=Br69cZnqmZ1QGg@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] mfd: lm3533: convert to OF bindings, improve support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, johan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 13:4=
0 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, May 17, 2026 at 01:34:32PM +0300, Svyatoslav Ryhel wrote:
> > =D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE =
13:20 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=
=B5:
> > > On Sun, May 17, 2026 at 01:13:22PM +0300, Svyatoslav Ryhel wrote:
> > > > =D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=
=BE 10:59 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=
=D0=B5:
> > > > > On Sun, May 17, 2026 at 10:43:00AM +0300, Svyatoslav Ryhel wrote:
> > > > > > Convert LM3533 to OF bindings, add missing VIN supply, add supp=
ort for
> > > > > > setting mapping mode and LED sources based on device tree.
> > > > >
> > > > > How is this being different to
> > > > > https://lore.kernel.org/lkml/20250218132702.114669-1-clamor95@gma=
il.com/
> > > > > ?
> > > >
> > > > I have decided to have a fresh look, this is continuation.
> > >
> > > Then it should be something like v4?
> >
> > That was more than a year ago, lets start fresh. Those patches are
> > gone, though I did add many of suggestions from there.
> >
> > > > > What about this comment
> > > > > https://lore.kernel.org/lkml/ZmBcvtLCzllQDWVX@hovoldconsulting.co=
m/
> > > > > ? Have you talked to Bjorn A and Johan?
> > > >
> > > > No, but since grep -r "lm3533_platform_data" * gives 0 results ther=
e
> > > > are no platform_data users of lm3533.
> > >
> > > Johan was against driver removal (while it sounds logical due to abov=
e) and
> > > referred to some other patches from somebody else. I think you need t=
o
> > > synchronise with the people to have a clear roadmap that all stakehol=
ders
> > > are agree with. With that, the split and other technical issues can b=
e solved
> > > during the normal process.
> >
> > And this discussion was 2 years ago, and
> >
> > "This device is used in a bunch of Sony phones and Bjorn A posted a
> > series adding devicetree bindings a few years ago"
> >
> > They have had more than enough time, don't you think? You would
> > definitely know if there were any activity since you are IIO reviewer
> > and would be included, were there any activity?
>
> At least it's polite to Cc them your version.
>

I assume yes, I have added Johan but there is no email for Bjorn A.

> --
> With Best Regards,
> Andy Shevchenko
>
>
