Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5D137DEAD
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 20:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779828902; cv=pass; b=qCVkYzsPAxeFnLTkGP5wFhBz4dQv2mhe9MAkmq1PQVadgWeVlEeHtTIg6yjCnZm6hZ6Hci1R5x+v3H3WKKk7T0hKgekDve3EBEeZlRk4VfCFTMJe4ySIZnqVUQ2LqR2Uyh/TgFDIvaIPr3GC+dBCP6gNpKn56KUNIJvidvqp6kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779828902; c=relaxed/simple;
	bh=fETlrkQR+rc/8sic5BN0xkquNsZXlYpf4D6aInCz9k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUBAbXEMSR9JtH+VeRwFv1YlMDgNgPJWe69pLbV6bmoCb/aZ02gOEyv/BJRkp+J7CD6MT2MpbSVBum4yCqguQFyhDw4xgvJAQezPQxW0iKNTfB4oI3V5BbUfoaEV4uLYfzeNUUwA2uKojChKtRmCqKEAV55qQD+/OKvhiK+NqVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDxhmR3m; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDxhmR3m"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6587cee8b57so12153554d50.2
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 13:55:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779828900; cv=none;
        d=google.com; s=arc-20240605;
        b=CM2r1geLz0mv73jphxkbmdxmdJIweq+VR++mVCvo+zYiku+Rj5yeTL8H6Ilgw5LfCe
         L9kdUBAb+ekQoyeGLPycXBSQkSMk9cyrwZeXHAnUs0Sj1EyTi5ri/A6Cr0UL6XmrsLOA
         1xpM2Nlx8vh1WzNGAMjq760jCHRMtBE3YTOjSdI8ahkiqmrBKgEWPHH56ADV0wXcaocw
         cVIPEqhWyFRPDnz5e5PP8uB7v6Fj4EWHP8N1KF7J/fauIij92jR94BUtri9odAfY7FwR
         VSUhtNTKGN4Mg0guMlkD1kYCfauwjzXgwyHeF/H45IcHlQgHSjzRb9NTGcUaZf9FCRml
         B5Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kCoTiZGubefWxkg0PokQrP5fkZHllIjc/WJPwBH1DZc=;
        fh=3VbXS74/JAHp9yS6Cbamudqcgb9IkW5zZLErG3LLB6I=;
        b=N645Pk3AIRo4JPeQ/BnMvWO7PVmWQic3zzG1OVe+ti1O5qTydrt6iR8HEDQgfn7Dz1
         OhE8tbBb3yGrEewjxRsm6jxyyloE7nctEPiTsG7LriKoKKBy2XoFd2U701j772lfXrCb
         SKxN4xwmagmNAY5nB25GcGEKC5Lnh/Ayl5eIYgl4MLj79O7T33OQF3IQDs1wfv3o4UaN
         k5GaAPpHcz2lrJf8SKgD2a4S08AWexMWKL3mnubvjVZjLrEoje8lQrNSxdPchZbPVQ8c
         BrhPpU0v5sxGWoOHbOGKrUyBdFjbMbaEQLzMQ7Zqhq/sbe3o3rAXjOxAoxqkCbqI3kv6
         l7fA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779828900; x=1780433700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCoTiZGubefWxkg0PokQrP5fkZHllIjc/WJPwBH1DZc=;
        b=LDxhmR3mCLbh9PUbBhnbRMPdeufEN+On/HfBIBfVnVCX8bHiN9IIORu7+YYtRKQKDG
         JEtQGG7EbeTOkvRPdmLfQLuHorlvWsOdV8JO/4OoenXiT0E82WMoaryKGFNJIb051F1f
         mqiCBYfOLC6VgoRA4VpNfg0EnFG82d1KIaluQK91Chu03FGD7nYORqu4ogbavZFT7Tpx
         4liZ2INt+KkevP/6h/s1vFvL3ozntE39B7ag6u5fmqR2WOY9iVx/UOqvfGUh9yfa4CNT
         h70/mw8Wn5Wocwh/pFV0wnoObAsLWgfPa3Aae5Z2k+gV6Pw6NBug9kCjILoDLsLWZGyS
         U7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779828900; x=1780433700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kCoTiZGubefWxkg0PokQrP5fkZHllIjc/WJPwBH1DZc=;
        b=BlLca31v3SUoFXFvV9lpGhMhO8Arg98WjWuMI/sC1G4FG5qaEZJHLLfZiyYsaVtpsC
         DzAYtw7YbEQ9Oawc3HEKzSzI17qPd+xxUTST3cZyO58m5tmKBvnfpNt+gnEtF6cBSnWp
         kRXaw7Z4w13VnSE7nBg9ClqKJ/kzEp3NTiZDl9tzt8UvQ2OURQlt/Kb/7GBxotagAPMX
         bKvI3dfnn87Pqr1lru9wq+8mQr9kca1YP6gpUQ8ZduIX34jHuxCykiy/NJA+bNNAqEB9
         Px6IsQ3MsNwN9C+U5aNllaHI/VZMlDC+8B3HvhdQtbJaJdj9gQdWkW+urNu5j09FA1zI
         fbYg==
X-Forwarded-Encrypted: i=1; AFNElJ9L6uIYH5iYzhAoyDGByneBCzNYNCB3n67PxkvnVSWeNpCTPkJ7KmJ86JXr80sjovlaYAp9Gyz8IGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoEofY/kqI0+amBLqwffhU3jQzwUPIWNEiKq5oqL7hL62RL9Wv
	1VIM4SxmCVvOQsEVZmx1t+Dn/g7seHx9eRBQnIGar5mGHLPeS8icw81CRzayWpwjUBlzpRMvf3W
	3fiUoBmi/PgjRw+XZ8YHC/xMdlEfzu7qUdQTq
X-Gm-Gg: Acq92OHscZA8i9f4zFcyLJJqF+1aJV/jomNna/Dm2cW5kgTVg1qaj4CiGQZfyW5jmJS
	PxH7LeCgkLuQ6MAQOLz7cociNdUsY3OwCaQdKrFpYZap292FzQqI7jvtu6PKl6W+IumcBS45NOB
	4x5YZ0WhO5L0hQ6XTNtJQocng/psHfM4HPRVI0ORMJUM+bZGbFjQtH3Xh4WGVoQfaBXkL0vP93R
	Xsz9mZxocvyxAvK1DXNDUIwJ5R+riNxRJxPgkigKkr9nrUGfswd2l7S7vKISripT46c8Sy3/Ip1
	GYv0tvEk4gqiCS8tua174exjFZ11Vey7qpIUPWs3
X-Received: by 2002:a05:690e:4850:b0:651:cf77:f7cd with SMTP id
 956f58d0204a3-65ec963f9ffmr13950537d50.13.1779828900477; Tue, 26 May 2026
 13:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524020309.18618-1-m32285159@gmail.com> <CALoEA-w7i4wQR_k9Eb6KPQLiLk6ZVrFmFoY9wHaO+7=ng=H-tg@mail.gmail.com>
 <20260526153842.61e15dfd@jic23-huawei>
In-Reply-To: <20260526153842.61e15dfd@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 26 May 2026 15:54:49 -0500
X-Gm-Features: AVHnY4IThspKmr_e2QUhwMVBzVy48hMrdp5Yq2oPDkWIhkx_5zhlb3XD-VfbTQc
Message-ID: <CAKqfh0HRXGS2-eMUc+v9ihnP=pNkms4AJRmJck3bNJ0TXKSQLg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: chemical: scd30: Cleanup initializations in scd30_float_to_fp()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 9:38=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 25 May 2026 08:49:17 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>
> > On Sun, 24 May 2026 at 04:04, Maxwell Doose <m32285159@gmail.com> wrote=
:
> > >
> > > Include linux/bitfield.h for FIELD_GET().
> > >
> > > Create new macros for bit manipulation in combination with manual bit
> > > manipulation being replaced with FIELD_GET().
> > >
> > > The current variable declaration and initializations are barely reada=
ble
> > > and use comma separations across multiple lines. Refactor the
> > > initializations so that mantissa and exp have separate declarations a=
nd
> > > sign gets initialized later.
> >
> > > Signed-off-by: Maxwell Doose <m32285159@gmail.com>
>
> Sashiko review of this one is really interesting.  If you fancy doing a b=
it
> of digging it would be good to verify that it is correct on the original
> code giving a very wrong answer on 64 bit platforms.
>
> I poked the compiler explorer (https://godbolt.org/) with and without -m3=
2
> passed to 64bit gcc. Looks like sashiko is right to me.  However given th=
e way
> it is used I think we are in undefined behaviour territory so it might
> 'work' unless the compiler is feel malicious.
>
> Upshot, verify it for your own understanding and then add a fixes tag
> for wherever that issue came from.
>
> https://sashiko.dev/#/patchset/20260524020309.18618-1-m32285159%40gmail.c=
om
>

Woof, this'll be quite a doozy to look into. I'm no good in terms of
understanding compilers (I ought to do a deeper dive into stuff like
that at some point), but I guess compiler explorer is sufficient for
now (note that I'm also no good at understanding assembly). I think
(and correct me if I'm wrong) that under the hood, BIT(n) does (1UL <<
n) and since an unsigned long is 64 bits on 64-bit architectures,
float32 gets sign extended to 0xFFFFFFFF7FFFFFFF which is a problem.

Regardless, will send a v3 with fixes, reported-by, and closes tags (I
guess sashiko technically reported it) as well as an explanation for
the fixes tag.

best regards,
max
