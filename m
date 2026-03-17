Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CA735B651
	for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744060; cv=none; b=ofQXyk7fLLEafU2cmsO8fnlWhxFbFRjdDONN/bDGL1JdNU9bn+rOS4rAOs6GPy7ZwR2ALiQyGfvIUWWcHAmrjr24BTg+pGzwhQzcoddV+HJCwtRi9gbjxmd3oa/ZRS0WP1ZJQby5sm009Sac/smMZiWZgBaGRGikNAPeovg4bGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744060; c=relaxed/simple;
	bh=d4KD+yU5s7d45rA5ExgcEGlswfbkgijWZZsbyiom9Ug=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fZJFAbyqYbXz7Z7RhQrM5R75kN/zX9iJDj0kYyf8Nzm5yROPo4LaFjfb3F87oP03Pq5hKA+41rrQsd9NiTUuo1pGXl4warSwg2oZrCUXI2Mdcx7Ki2aLifth040mhwxhdJqDfiVLCNZlfsx4+EE0/vYc4yig2CXKVexwcIdjXBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=G8J/BKoo; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="G8J/BKoo"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439bcec8613so4262014f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 03:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773744057; x=1774348857; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d4KD+yU5s7d45rA5ExgcEGlswfbkgijWZZsbyiom9Ug=;
        b=G8J/BKoo9f+EWdZfUu9gMkvuFwkHmjOw4+tOVbNC62eQlglZjwB8z3xjB6TcMoxYti
         u5uE0iTBBCGjfl1/jitKphMYSXRQufoeQvhmU89sfr8dX3+i4XwKXbV8ae+86ZW+2Kkx
         HEDa2AJ1AFamz7an2IN301dUSCgyjIpNsu4ALMxcdB8ammNV4uAQ/WeZT0Za4Jv1yxRF
         SCURgTaccLhh6sh+5bniMYOT8xTY0lFjE76sBXtxs+YnJ/eo6JuKX+nHGP/HHnnI1CMd
         Rv/Qjss3vnNDG9QYUJB9/N1I0e3qShMBqbtiIupEIg2YSQZrDYPJvqNIqaITMP9bbiqi
         f4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773744057; x=1774348857;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d4KD+yU5s7d45rA5ExgcEGlswfbkgijWZZsbyiom9Ug=;
        b=Ja23XIIenhexbU9Gz2bNXP7DUDXC+eucCeJK6aAyb535ejg/oVwnM2uQ0SXFXI9FO0
         ZXjg3c4tT3giJOiAkxXvlH9TGJGx8TGvKvlImJr4/PFo3V833EB9iuak3dOH5SZ0J9Zx
         uudec9QbENi8BoYTNWjWiAVrE1vfDQ0BeHn+v+4M7CX7Dpgv4SYp1pyBdHm1/C37ctPN
         7DiNOHS84XysEtb6LTQFwqGD8lPm0cwxSNY4n+D7jxc64gqb6P42tNA35gHOnaTRLTBs
         1Qj+LDmjCM+dzEkj5rLpL5ZcL0+CeGn+/CSMqRUH34aaFK56caP4xK6ySkXJIEDh+fFA
         /lCg==
X-Forwarded-Encrypted: i=1; AJvYcCXLNchJr+5wplkbYFb5CXp/fww3BWqbo6M5OU2Rx5SJxbX4IvCRsh9Hc6dNIdS352tM5NF59m7UKqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1iwdsd7q5hblYg+yQljOIAQzu2dSMWnjJL1fd9ZELbUsEPz02
	h94rP2lM4/sXiX0unUrKM05uLEJJOVniVQrhvyyMoE49jgkNpSEmK7/ull9nSzDUHao=
X-Gm-Gg: ATEYQzxOpgDHYPzN4ey0Vx+HQy+5IrSj1f4Vn7jK1pIslBOqXkYDd/CVs2Xkvoz6UqZ
	XXI82ZKDhxdZiKI38+4Q3VGCLzoZ02PGB5OqNdH/4uxTzHzphWGxfV43qFgYVuCra8uhnEVQ02f
	CnIqZXxcWcPOYDp7v2YykUm1llkvSy3a3V6rg8dGevwEyfRrgBZJUMC2d116fZuOdQTy8OOYVKH
	cNjFCaqCXkCZYo9vq65FJQ/mFl5b9O00XcloQXr1btWkftdVYXZi57RdLJdvHnzu1tzgBALbAQR
	KSKYeR0kUpXhUxIyi8DEoeji2O9azv9cfm6KRiiBlpSNHslK+6PqacCb6j0JuufdpAoRbBxvw63
	8IRJNUazkqZ3R2pc5/Y4bOnbIgKXUBkMI1foDe0Erc5Cw5odOtxmfRohpYkA1dIY8dF5YQ9VISV
	qFTVOiAvA=
X-Received: by 2002:a05:6000:2283:b0:436:3707:2bf0 with SMTP id ffacd0b85a97d-43a04db7556mr30851486f8f.35.1773744057079;
        Tue, 17 Mar 2026 03:40:57 -0700 (PDT)
Received: from [10.128.148.212] ([151.37.253.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b41dd93c0sm17716128f8f.10.2026.03.17.03.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 03:40:56 -0700 (PDT)
Message-ID: <1d268ffefd2a035331fd4ab7a920559fdf11cdda.camel@baylibre.com>
Subject: Re: [PATCH v7 4/6] iio: ABI: Add support for floating-point numbers
 in buffer scan elements
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko
	 <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Andy Shevchenko <andy@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Date: Tue, 17 Mar 2026 11:40:54 +0100
In-Reply-To: <20260307125150.3bc60a45@jic23-huawei>
References: <20260304080519.2844101-1-flavra@baylibre.com>
	 <20260304080658.2844434-1-flavra@baylibre.com>
	 <70f25902-5c79-46f9-8c67-99633b22b5ac@baylibre.com>
	 <098886563f5fdcde837989d0556ed9a2d8d3203b.camel@baylibre.com>
	 <CAHp75Vdni=OgHiDi8G5s6CgBFZZuypOyJSo5DFjaKYFkLGPqkQ@mail.gmail.com>
	 <dd6d1436-d509-4233-ba1f-5a3f870f35fb@baylibre.com>
	 <aarED5TAWg2qFtxi@ashevche-desk.local>
	 <20260307125150.3bc60a45@jic23-huawei>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-03-07 at 12:51 +0000, Jonathan Cameron wrote:
> On Fri, 6 Mar 2026 14:09:51 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>=20
> > On Thu, Mar 05, 2026 at 08:37:48AM -0600, David Lechner wrote:
> > > On 3/5/26 3:23 AM, Andy Shevchenko wrote:=C2=A0=20
> > > > On Thu, Mar 5, 2026 at 11:09=E2=80=AFAM Francesco Lavra
> > > > <flavra@baylibre.com> wrote:=C2=A0=20
> > > > > On Wed, 2026-03-04 at 16:45 -0600, David Lechner wrote:=C2=A0=20
> > > > > > On 3/4/26 2:06 AM, Francesco Lavra wrote:=C2=A0=20
> > > > > > > In the data storage description of a scan element, the first
> > > > > > > character
> > > > > > > after the colon can have the values 's' and 'u' to specify
> > > > > > > signed and
> > > > > > > unsigned integers, respectively.
> > > > > > > Add 'f' as an allowed value to specify floating-point numbers
> > > > > > > formatted
> > > > > > > according to the IEEE 754 standard.=C2=A0=20
> >=20
> > ...
> >=20
> > > > > > > -=C2=A0 Format is [be|le]:[s|u]bits/storagebits[Xrepeat][>>sh=
ift]
> > > > > > > .
> > > > > > > +=C2=A0 Format is
> > > > > > > [be|le]:[f|s|u]bits/storagebits[Xrepeat][>>shift] .
> > > > > > >=20
> > > > > > > =C2=A0=C2=A0 * *be* or *le*, specifies big or little endian.
> > > > > > > +=C2=A0 * *f*, specifies if floating-point.
> > > > > > > =C2=A0=C2=A0 * *s* or *u*, specifies if signed (2's complemen=
t) or
> > > > > > > unsigned.=C2=A0=20
> > > > > >=20
> > > > > > I would keep all of the format options on one bullet point.=C2=
=A0=20
> > > > >=20
> > > > > That's what I did initially, but Andy suggested doing differently
> > > > > [1].=C2=A0=20
> > > >=20
> > > > And still I think it's better to not mix them. The floating in the
> > > > same sentence is confusing (along with 2's complement mention and
> > > > sign).=C2=A0=20
> > >=20
> > > Then I would split up all 3. It is strange to mix some and not
> > > all.=C2=A0=20
> >=20
> > I don't find it 'strange'. The integer are grouped together, floats do
> > not
> > belong to that group.
> Maybe two paragaraphs in one bullet point?
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* *f*, specifies if float=
ing-point.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *s* or *u*, specif=
ies if signed (2's complement) or unsigned.=C2=A0=20
>=20
> Though then we'll definitely need to check it didn't break the formatting
> in the docs generated from these files.

This does break the formatting in the HTML docs, where the two paragraphs
end up in the same line.

> For me any of the above are fine.

I will keep it as is.

> > ...
> >=20
> > > > > > > -is [be|le]:[s|u]bits/storagebits[Xrepeat][>>shift], where:
> > > > > > > +is [be|le]:[f|s|u]bits/storagebits[Xrepeat][>>shift], where:
> > > > > > >=20
> > > > > > > =C2=A0- **be** or **le** specifies big or little-endian.
> > > > > > > +- **f** specifies if floating-point.
> > > > > > > =C2=A0- **s** or **u** specifies if signed (2's complement) o=
r
> > > > > > > unsigned.=C2=A0=20
> > > > > >=20
> > > > > > same here=C2=A0=20
> > > > >=20
> > > > > [1]
> > > > > https://lore.kernel.org/linux-iio/aZ7dCdLs5xcJ4UGW@smile.fi.intel=
.com/
> > > > > =C2=A0
> > > >=20
> > > > Same here.

Same here.
