Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF563126D0
	for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779995433; cv=pass; b=HjaNK/kwjQtn6NNZbxrLUzylDD+zr4ey/o5wNFtI/QOIoS5iaf/iUNzOSu1i66P9oglxokjaOdIp7MHr/wyz55wSie2w+SUunhKIVd/yzdMXH2vMNczB9ObIWR5KbejXoSgEBVAdNUhisu66sm3NV1OMP65aM482sAayp3+mYuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779995433; c=relaxed/simple;
	bh=HGBXGLYnnWCDpRIUY1Y91DwdcdokFSFMEt1EuXNDHAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSGkk3+rLmYEgIc3ZOaMI2R40bfNi8fJBg2uqbzIdo7DYGgarqehy6Mp6WWZwXYKOlNEJLUjnmJon/b2SV9TuAClgpTsnlGZHPAfnw08y77KXDW6B2J5LGUobuX5nCV+rBpytZWWP9LnNWfjg2WwvtOdYhBw7PqbHIjfBGbFQy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1E/MziQ; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1E/MziQ"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-834f1075805so9876372b3a.2
        for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 12:10:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779995432; cv=none;
        d=google.com; s=arc-20240605;
        b=gDLJhvoafHTpsyGhccjXbcSZMyXlekxgfannazrYbmBWtZf+3M2fJJOTd4619ZvpoR
         lBue/+1ah99h3dNgACxMCvrm+kX8L5MF2f7oys4XWHz/eoBnH0QfBFBI0pTx+hDXt8Y9
         shey7au0ScEzLyk65ZncID0JvuRN0pqQJl2gjEXOE02cF1I1WpVyv2yQrgvcUnMO8DwH
         7xwveMg3q7I0rRbNfuQyhM/zdu+V8x5t/meauiA6HEqXXxVJwhsm3xLXydEijp3dItMH
         GDDkLxm6AjsKJh7bYFymJR9/LwAAv+2YJQlFCcbdUfwJIlwb3/57RQY9BMfUbLXYSLUE
         kaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HGBXGLYnnWCDpRIUY1Y91DwdcdokFSFMEt1EuXNDHAc=;
        fh=2n1qHL5LtXyp5ji9N6AMP2B/efCVBHELCDayH1qfDO0=;
        b=Y1YGpvRkV4JGQYIbYf4lIbv7Dfnt497MpnTeaPfJP0dGR7no/XUeHtm2YWtnWR8ArT
         Hu6ukAKOVuOci44Zy8E7wyhvyUtXueWfl628t6jPRAWfF7qbp/lBPdK3VUrf5I3TIohF
         qLpjGq9oOWL2xX85VUISDNaEBvDQknPEkbzgjCTliSYMO7TSOu9TJSvCLkaBsBUkAyD8
         mvqbuok1MXeVgH/NHAf2QwwaveiL+RYqXjOkk2qu5mfS/XKzakDECNh6ju86MXm6b7sj
         n2Y+plXbX15achJzdFHuOtaPOfcnZOOXRlFlHRqMbAdplz7QYIBaLLCBQ1S/cwGKiZ9N
         o80w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779995432; x=1780600232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGBXGLYnnWCDpRIUY1Y91DwdcdokFSFMEt1EuXNDHAc=;
        b=i1E/MziQMBixVSgTNM6vEUOulCEER82JSV9/qtxN67i03k5TAr9uqFBCO63aCjhK3U
         Wr1/wrde6o/GE94k63/QGbUZYB1UZwG2Z+Du3YxCGTc3FjapqLXv9eYc+BSgWPjo8P54
         yy8bC0j3HWh5Yy50rA++feBNafrxP+8rG2NO1XPMWtS4HISFaEzzRh77YaVP10Ix7TvK
         9pu6oguI8rdOOcCBXupC3YyKJCtkNCJ6cEh52Ac7o62+TEWYavSQdTiV+U3OEucPg30O
         LCSXj3gMyUuKKVDx95CLdxWxT1rE+hOsO/f7FOz5NjlPOPynDsskUulHT6qx/TbFrwye
         40rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779995432; x=1780600232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HGBXGLYnnWCDpRIUY1Y91DwdcdokFSFMEt1EuXNDHAc=;
        b=H1OvJBCz7TUKyuETPRGI2QMcatb2yXNhHU/jqP8OakiggUennnwdekiBKEA/IFx5vd
         R4bYJOGIWiPObCBXy3mXpyJTeqXD/r2ZMzn1R7hKRyymysTi3Nf1WZMe7moGLz2lgPGE
         meWEm+3wXVw/LiMM9QpUdoU21NVC/rEJpwxwZaYRGI1m/exJdbpC1qcDqZjEm+lYkZ5y
         Bdq/XHjQyGacL9AfFCa0EHhfXY/uFI382AvtsHo3v0aZonKcXNjlckqcm/z92qW2ZvWY
         asvdxFVZ3C5vAnKzZIUp8yawJtHBD1jrMKs+UvjeZoXPFfIo4pXIljW1LSUj97dNb8Ly
         NPig==
X-Gm-Message-State: AOJu0YweU316eYH15uJdWVD4vpmzATN3fVWjT/oS5qMpoo4JwUPdNYRk
	7C3VphAx7D3rzQhXqo/GCn1qgXqnsvh+PKHKKpPXZDyJBBUhkvPJWMb6FxKYZXLlb1TAi6he8Cd
	qrCogPsttVXLwADWlDhhUf4MCJS9Hidw=
X-Gm-Gg: Acq92OHbtoVOy0Ry5WVt0mpslhO9EjoVY6mVZhnCZ/oKqRmg9begf/Fa5aiy86xMeO0
	3nPfIwDge6p0vgiywTmEk9cgfEBXoeirlSg+S3e6oVgx3p8nr8RFIXaL23CM6c8Bh+OHnElvMoM
	1CfKYfYyRlA8XYsKg1jyGl3CfRPV4nhj0GAmue1AYdxn4sS3+rZSMBEwfc4vG4dhBUBtNDGVhHV
	TVD6kFiAhHlR0RsLN0JSaFT4YDwmeAKzV+PHbbEiUWI9408FQoSKgVG6nSc8xGyAFzwmcku9zeB
	PZN2yBOj7mgGQd4JLVrPKDV0nJEAv52BzdSqJEX/A8Z/wn2boNu6
X-Received: by 2002:a05:6a00:3d08:b0:82f:425b:4c27 with SMTP id
 d2e1a72fcca58-8420bfd8774mr333287b3a.14.1779995431860; Thu, 28 May 2026
 12:10:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527164312.355729-1-jakubszczudlo40@gmail.com>
 <20260527164312.355729-2-jakubszczudlo40@gmail.com> <6af67454-0728-48a0-a823-2457f0bda386@kernel.org>
In-Reply-To: <6af67454-0728-48a0-a823-2457f0bda386@kernel.org>
From: =?UTF-8?Q?Jakub_Szczud=C5=82o?= <jakubszczudlo40@gmail.com>
Date: Thu, 28 May 2026 21:10:17 +0200
X-Gm-Features: AVHnY4KOX222--WQuShv0VugcJkPyq2v4865thjfn0WlzbC0NIXdPNr3CAabD7E
Message-ID: <CA+gq5Jjff1F8vmu0o3i8LFk=Stn6VSvAr8Wa5RaPF13LGTzkLA@mail.gmail.com>
Subject: Re: [PATCH 2/4] add ti,ads1110.yaml
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for all your feedback. I will take it into account and work
on extending the current driver so that it also supports the ADS1110.

Best regards,
Jakub


czw., 28 maj 2026 o 16:27 Krzysztof Kozlowski <krzk@kernel.org> napisa=C5=
=82(a):
>
> On 27/05/2026 18:43, Jakub Szczudlo wrote:
> > Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
>
> Please run scripts/checkpatch.pl on the patches and fix reported
> warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
> patches and (probably) fix more warnings. Some warnings can be ignored,
> especially from --strict run, but the code here looks like it needs a
> fix. Feel free to get in touch if the warning is not clear.
>
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-pat=
ches.html#i-for-patch-submitters
>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
>
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
>
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.
>
> Best regards,
> Krzysztof



--=20
Pozdrawiam
Jakub Szczud=C5=82o
