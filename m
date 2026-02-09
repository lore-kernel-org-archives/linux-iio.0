Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1520228312F
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770646751; cv=none; b=bJneS/lzgxFHEzq2r62XC/gnnKxwfxnptuKgdW/0eSNnVo/uklzdwPZrpwi4fRmzINLutLCbpCvqM2kEdzG2j4cjZDUsPGVYj48QxeL3YuvRJXtqpv/5bXJAVyotY7hJnkTEwSl5x4wkKJz8qdAVilKgSdIRZnBIUHakRdioPdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770646751; c=relaxed/simple;
	bh=0GCa7J6f0mA5Y9Jl0Wa4qDqz2wmeArNeQHxDflhAAXc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nEiW+daGuiUIcdtDIX4ukNjDH+kYgb02eXnN03KjfulPRJZ6qj0krqp+SgTH4S1ZBsZ6nvFHjwe+99ka77zm2wm3i83JhEuZ5FDubK/jRk5cyg1fVm498L+A/9+c6j26tZDKzBcuUdsxTH0dCzSo52ot8nPLbz0x6lcX95Bluok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBzYB15u; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBzYB15u"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-483337aa225so6918725e9.2
        for <linux-iio@vger.kernel.org>; Mon, 09 Feb 2026 06:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770646749; x=1771251549; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0GCa7J6f0mA5Y9Jl0Wa4qDqz2wmeArNeQHxDflhAAXc=;
        b=YBzYB15utqS4P35ETdBoSPCL+1jINATIgZzKXl1rXe71x3Atu0XrI5nOjBvqcF0xGi
         8+b8Ed1PoyiHQ2MMZdXWYzxmLlb/IBGjiNXdpso6YvByuThcCgQsH+C7d3jKoDZ1d45p
         epI/XyDmf/PIxnUyDLx9HNiMjypyr93EhrN1AqwKL9PMgCGDyQPtKfTg5zX7IMf89N03
         j0JtxlllCpT6C6617b2jGoscpjcag/1bh9ezaHy2nsUAhFrBWz5Hyg1NQeQkLUknYoMw
         DmZ9EUM6EbqraQD4fqFwAG8EFOog8x3OokAWd6yldflCsf/DLlyjK/AMQBuF0e7U8PQ/
         M+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770646749; x=1771251549;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GCa7J6f0mA5Y9Jl0Wa4qDqz2wmeArNeQHxDflhAAXc=;
        b=NHl0fc3baPTGk59BPO93ZXGdRJi6NAuQELtmwK587snYiZS938xdeQiLQ7N3jLjegY
         dW/4wsEU5iFlOSowW8Tj3FmvmLvEa89at5berSzxEWovUiFn7icHaT8oAqel0fDLfMPa
         0krZzuT/agN8jHOqMzfEOC/qdghnqHe8+wAWn4M1f1cAOzQ3fUZt3Cu2wlsEor7bO3Rb
         mng1sI7SdwuaHHr+05Z2kE2IvmD92qniR38xO49I5H9x59dPir+5ESx52yWbRitf41p1
         8gkyROVhUoBNtcesSPSAVi0J4UHLd5/AqHhH5AZbdz9F7PuS84RygUnZ279P9gYo3Cr4
         3MPA==
X-Forwarded-Encrypted: i=1; AJvYcCWFYJcl9qEAcLWfSXrQOJHtYDCnM/pY8u2NPImU8B2gWXMiMfBIRoYUJX/NUStYXxPwNSqL0H8BYLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM3gMmuu+TRaS31kozxuNXFyolgSzg9cBQdBZty9XAhFd6sm0W
	+eCobNUa1iflMo/EdPGh9JmjjHWhukA8qUqw3nIEjf1HaW8nStTRZEzZ
X-Gm-Gg: AZuq6aJSxOgkOoHTm63QgG6Q3YTalIRjmGAjyeCOu3eIliNUaIfdG4HyDQKDk6/H9Nj
	KG8J1j638mBQg7vt6/19sy7vaAi2LqW7en4dmjqgpj6ANJHfGpCC+k6OyYc5IITLk0B42xKhOHi
	WgCZmkT5RFZ0L1xTgFnjsf39YwkVLoNfvU9hh5JuIwtH3oax9D1c10bw7QczpfLmqm3VWhk+gPe
	7RLNy06dj8BSt7jYmatpZMZ8TbDuQFoa4Od8L83y2ZCzGTjM5yEEr9EGpqy0htaj6T9KqRtvTtM
	Jj4LwIJENrqhTHlPeibU42UzUzzyuNRLh7JsI6SFUC3woWUz7hp2JGcKvFct2cRfyQQP6aFsJVS
	3dR4MEt9JGIKgpLV5SkDb/mnnV8TGAE0m0/oaLneORJgc86/83mDnTPw58f+m5tQdWNPpVgaosF
	CIPq5YU04bvgv3qW+xPgEb64NvnDP77g==
X-Received: by 2002:a05:600c:c16a:b0:475:dcbb:7903 with SMTP id 5b1f17b1804b1-483201e1895mr154271225e9.9.1770646749159;
        Mon, 09 Feb 2026 06:19:09 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629745f7asm23928496f8f.33.2026.02.09.06.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 06:19:08 -0800 (PST)
Message-ID: <df548836ef42d38fc8f89a23572c24d0501c619e.camel@gmail.com>
Subject: Re: [PATCH v6 5/5] iio: adc: ad9467: check for backend capabilities
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Tomas Melin
 <tomas.melin@vaisala.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa
	 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David Lechner
	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Olivier Moysan
	 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chris Mason <clm@meta.com>
Date: Mon, 09 Feb 2026 14:19:51 +0000
In-Reply-To: <20260208193034.7c780426@jic23-huawei>
References: 
	<20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com>
		<20260205-b4-ad9467-optional-backend-v6-5-7ca20c40c59a@vaisala.com>
	 <20260208193034.7c780426@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-02-08 at 19:30 +0000, Jonathan Cameron wrote:
> On Thu, 05 Feb 2026 12:24:11 +0000
> Tomas Melin <tomas.melin@vaisala.com> wrote:
>=20
> > Add capability checks for operation with backends that do not necessari=
ly
> > support full set of features, but are otherwise compatible with the dev=
ice.
> > This ensures a fully functional device, but with limited capabilities.
> >=20
> > Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> I've mentioned before that I've started messing around with Chris Mason's
> set of Claude Code prompts and today I was trying out the new stuff menti=
oned in:
> https://lore.kernel.org/all/b187e0c1-1df8-4529-bfe4-0a1d65221adc@meta.com=
/
>=20

Yeps, we're doing the same and adding the above to our CI. I guess an IIO s=
kill will
be helpful long term.

>=20
> Given this patch set is pretty much ready to merge I asked it to take a l=
ook
> and it came up with something that certainly merited me taking a look.
>=20
> =C2=A0Issue: In ad9467_chan_test_mode_write(), the testmode_on path is gu=
arded
> =C2=A0 by IIO_BACKEND_CAP_CALIBRATION but the matching testmode_off path =
is not.
> =C2=A0 On backends without that capability, entering PN test mode succeed=
s but
> =C2=A0 exiting fails with -EOPNOTSUPP, leaving the ADC stuck in test mode=
.
>=20
> I may be missing some protection path, but I think it is right and if you
> were to set up the test modes with a backend that doesn't support the
> relevant functionality you would indeed be able to turn them on but never
> off again.
>=20
> So this might be the first bug in IIO that the LLM found and human's, inc=
luding
> me, missed!=C2=A0=20

Yes, that seems to be the case.

- Nuno S=C3=A1

