Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AEB392806
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 05:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779427255; cv=pass; b=Fdx6h8r5+cbz44mdIiiVjvHv9G919ksBHbBE4hVbBV8DGdhD864Xa0zTeALqhO1nmUOImHrIObRfRuh208tZqvBUDDgaj6k9JupPF9aUYsNbzhxI2dV91b7+gwFZRaAqIBYnfYl6AluG9MA1xVtcMYxnTN2xAhSI5UlFNJ43Myg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779427255; c=relaxed/simple;
	bh=2YdI/r/z3tOyjcNlH+ate8q+SfjvzA5JtCeL0rJ9ysA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhikxPmAKv0fBOJrSh6u1RzqyPJ0S40sFgWiTjuGnidapg0hJoS9x8jZqGkP9zBREtv1OmlopW6o4qe/mJGjvtfCZW1/UZF6ADX/ljqLNwROx5+KVxPXbBjx4alkJFGACbLZP/Gor1vZ7wsyeOVAPFwU8zJNhfIw8uYSEwOCNnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flzqDMHi; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flzqDMHi"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65c0bda7f15so6940749d50.0
        for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 22:20:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779427251; cv=none;
        d=google.com; s=arc-20240605;
        b=cd4Ww+bsbPXD9C44c/wnMHmnXPOnoK9X8xahpbddZ32VoyD/PAaaR/0ocgcC1HyQ5z
         ODmaBPAsKrImMT+bzau1Az37pnJj0F/TAhv1cM0Wnw3QUgBs/8cZtmmog7WlVpaIIkBE
         wyVbsxTkoSsazDr/E+DaZVC1iD1CArKJTaGPZdNY8TUkxXYMa+eT780uvTOZfWpfNrqS
         kyc3d4j0QhkM5unoJwttpMzuHhsjxsncL1kb5JIoD55jr6neiGkPssR0tVHIFvCPm4NP
         JexFolWdlCdjiJHUp0Eg5OIUwxpHgKX2ncKOlb1WCuWgd95Vcl5xKDdoGnrRqOx5NNpe
         +LHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2YdI/r/z3tOyjcNlH+ate8q+SfjvzA5JtCeL0rJ9ysA=;
        fh=AlTK8TmVMDgLihFF274z1Li6yv0bmpN/J9yTEtRd2HQ=;
        b=DbbWBfchK38LU7nE4rO3VUHJvKR1a9JuPohmn8aYIOsz341EpavFFlOAfgPzigdii2
         LcBarQkFyYWK2B3iJdCnz3TtrFpdnt5Mbipvc+A5oCe+cvojkG4+ems3+4ubeOQHfwzj
         /X2l9wGhk3noo+Ing3xBBQrjtmnj/uo3dng5wIIbM7zH5Jhca3/mQ2Su6z0QnbT72FCN
         ZVTcVpGP3uBZfLtYbt5lxpcDG9m1bDboSePoo/2gsV+9Xr96hB63woKA8hhabTpkfsmr
         ulK1AY4nX2dH044nz3BmHYkJ0tyYNo/zIm8v3fECpwqF0Exb2MSIMlENTFKTyWZAFBDE
         WGbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779427251; x=1780032051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YdI/r/z3tOyjcNlH+ate8q+SfjvzA5JtCeL0rJ9ysA=;
        b=flzqDMHiBmYOMqHqG0AH82DUcPWIRfH/e8tUcfrhEs5H+DbU8gEp2WmW39TtF951Nz
         WxcSwly3Yo7aBAwnLB9D24ZSQOUYXHZabRaIYeu2x9oHkMQuONvO+gOyX3e5NDKeR7Nk
         LTT7DThS93rrttc2qCJVlGLsyMRtc1ZRPLZjZ2LbJNA7CMJN1+P+FCxN2CMKpafOoUGu
         8HztBgOxSjtDU4NORv0g8t80HuhPZMxL+diJk3N7rT7sm4m/VkfL8R+S2StD3KHFGwMA
         VZflwQjKsYIxynB6VzhgAUsNmkmystCCfKhdM8gjmyZgQHVj3xeVkebnW3myO8WcR7uB
         Gikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779427251; x=1780032051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2YdI/r/z3tOyjcNlH+ate8q+SfjvzA5JtCeL0rJ9ysA=;
        b=GPBZji0EEB9DIiCGeXz0a6RO/HOWji8F6iAjwAhnB06jr/ktAdVCsihQb49fNae5tA
         XqkI01babuYX6ZuLU/9ixJVmO7aJ/jiObWNrU2FXTlTeevHJf5BKHMKeBT8qVdX5v+XQ
         ZwcDnhZpv/yoWMfi8mxWjwa6kCeHr6AMWka06R74rfw57qo3cZRaDnq0e2cZuw/2Edva
         EOtuGBlrubdkaDsQWjW+92D7jonmNDy9JEynmDXsEkw1qBW2mt+rgvf5Ne4FWKCa9jrq
         R5IWrXjuIUesoYnd95C08Br1TzqQk4vRjJn5HoVQa77daPAkCZE8orMyrVA348r4esHa
         bhow==
X-Forwarded-Encrypted: i=1; AFNElJ9zjU/Qu58o8+Cl00jXso7Ep/rXE43y/HU2FPmcHjzKFUdV+uQ9NTj6Nkx+/d1OBkBeuu+bqQuq7Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmnaTwdyBWc5E0OQlHJ/an/BNi8bk8yydzSxHVR6YSNMZA/Gis
	GZwuxc1Blr/OhO6lSz3f/ZdIoyEKLQv6bgM58bXb6mHXoqNy5X5vZzCMhGF7ifKIWJ6ajJWKInQ
	FzM/RRwlp/rEIKP3ThoYhN6nHQ2pPKak=
X-Gm-Gg: Acq92OHDlCfnnlouUWGpV70lexLjm7oULtYbrphYwNPh3NfbLxaVFZ7MQ44c8IA+ZzU
	aUe6qpsM1jRynDO1vIg2Heh6xn5djE78rvVIRUubnXhiVI8buQypOomFDHs64+ddkh8HeyR3HSj
	1il/mjMTW88c7LNZKBwBMMsAPc0CL9W5Eibo8StkenGRkJyfy6QsOxmbdbIEXBWBEfO0zGGP9FA
	31VYwGLx/ovnbA2O4pK0AgRo9MxFD45aGuxAxnFTEF4inSiiRK+gUAmd0rxrLxe2lnujseKTKyx
	mUTe
X-Received: by 2002:a05:690e:158c:10b0:65e:39d1:d9f4 with SMTP id
 956f58d0204a3-65ec961e095mr1918344d50.9.1779427251503; Thu, 21 May 2026
 22:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521-opt3001-cleanup-v3-0-820169dec8c3@gmail.com>
 <20260521-opt3001-cleanup-v3-5-820169dec8c3@gmail.com> <CAKqfh0GeFG7Jw8==fjve9oZ=xy4AnitzF6z84iTLtNKB4wLLHA@mail.gmail.com>
 <CALoEA-w7mjwABNsUVGWbW8FbA6qRvwThjKVC4_85-T0k7rkn1w@mail.gmail.com>
In-Reply-To: <CALoEA-w7mjwABNsUVGWbW8FbA6qRvwThjKVC4_85-T0k7rkn1w@mail.gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 22 May 2026 00:19:16 -0500
X-Gm-Features: AVHnY4J0cIO-07v8O-mspqOcRpVC33BWLRqjdJi_sG8Z95yx6OD1j8tARa1bGO4
Message-ID: <CAKqfh0H5uaQ3AOODBOtT844JLRunVhm11Mxv9Hrgcd7kWs+-mg@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] iio: light: opt3001: prefer dev_err_probe()
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
	Michael Hornung <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 12:07=E2=80=AFAM Joshua Crofts <joshua.crofts1@gmai=
l.com> wrote:
>
> On Fri, 22 May 2026 at 03:49, Maxwell Doose <m32285159@gmail.com> wrote:
> > Ah, but all of the above don't seem like _probe() functions. I'm not
> > an expert on dev_err_probe() but I'm pretty sure it's only for use (or
> > at least, designed for use) in _probe() functions. Only function where
> > I know it's 100% fine in is the one below.
>
> Hi Max,
>
> Actually if you have any functions that are *only* called in _probe(), th=
en
> it is okay to move them to dev_err_probe(), you just have to ensure
> you're not calling dev_err_probe() twice - once in the function and
> once at the call site.
>

Ahh, interesting, I never knew that. Thanks for letting me know,
that's cool. I guess it's more flexible than I thought.

best regards,
max


> --
> Kind regards
>
> CJD
