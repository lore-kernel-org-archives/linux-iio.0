Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DE14908C7
	for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2026 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525533; cv=none; b=bbzpcPYRKs5gVxlIt3TIly++5wmhODVsxhqlH3F78gsUJuSDPB6u75/JlDuJcPe/tYNiPNpnKDO9LFZAq/HdMeDBxvRpA6NFJjdsI629y2vmmPCxybo2zaBweML6emVyNa87GgmUJeV5ZkEi/mmhlPME/tcd/2XqvBa0PqRL0u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525533; c=relaxed/simple;
	bh=g7NoS6ItxIGS2czWYih8v2M2HKgwLHdxDoGS2gvncFw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=plg6FvMaSOSj7uGqnzip59lQKGf6nkVIc8EzMBjah/g5aBHXn6LkkY1hdtk0If4i7cBuloS2KqJL77td2zJS+wFynmHMIH5DlQ3vqWOO+jLMxXFJjKEhXUfByw69OnziJEOP+GTN9xHshLnt1RGVcfjn0T15gUqo5e0i8r+utsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaslRoiv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaslRoiv"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49b0eab380eso8326945e9.0
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2026 05:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788525530; x=1789130330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G4DYlh2I6RnjE99fsWSxZQSaKzcVINVi/U+pJerpuOc=;
        b=SaslRoiv2+RUqgBCTRUB4iw1S2XFdmXstCu+f4evLUT0aR+YdtWtoDux+RYkT/UAY/
         ffizGuELka+1KFdW25JT80ZGqHSJT31Y2Bfk8CedlcB8Q/BYPtR2qraLXrTG1Cu+A3oS
         YfiVNsNBzm0eMZWCa5HN522DrB0VCCUkX0H7XiQqpAbEreqwIp/jhEkg5f+ecwTWZv50
         YI2Q9dzirtIrZsHAj+mJVECpt2kEGo8IIv2rOSdZU54Z5pIDcANKPwcBxy7Ggr1ULIsk
         rBYlIX8N2z+BCwc9T/g4lqTHe0tZ4ZUgD8HtySZxcMJ8GwY7ABFu8s0zVq7d+mqDuG01
         zm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525530; x=1789130330;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G4DYlh2I6RnjE99fsWSxZQSaKzcVINVi/U+pJerpuOc=;
        b=NhLXR9kOBZPqtLsjkym2tWvad7FtEeDqya1Qc5EGl0BwV12FASfaJJi3BBXF2srQym
         crgFcuquHtDhqiS+t2gX8ItVzcTod55l5DGVw1JwtQfbNSzevNRHZsP9PwNycg7lcLsA
         og/CXzVUvEG4kXjXvcYh7cUIgFy9tW7nQGExg0/CYK0adBGYh8F3XJzVY7l5OXy6C+Ot
         RIGP6HdZyXaAQZvOtFPuSeqZejyzTkRfLHoUEWOz3bDC7xxX608mmJKWyrnJeNGovpbP
         SbHCqPjMIGzDqcnRAl2Wmy76ArL2bVf99srD+ZDpSGk58gmt8hm+UODqpIIyWKX6jTMV
         F8fg==
X-Forwarded-Encrypted: i=1; AKwUvBzfnvLQ6tEA/U3v+3DzlImuSJQOOiMUMiHzxLcRO7uNTh3/HA6uKYRpZBsrSm+4qWntdwrwM6VXh0k=@vger.kernel.org
X-Gm-Message-State: AFuF++lMi76mPwbtRVWOVZHjO/irlzgy7em/R5DPTxWbQ9zCpJKCASC6
	Wg0ZsJgULcIEPuATqRF/1u3CjEug3BmEp1q1OaGG6LJqIkMiUql+kRlt
X-Gm-Gg: AYBFou1knf2YI3z/GbN8i9C6Ewctv2Py90dnGJIxiOHMGS59xvfT3v1BO3GosoprkGq
	amvCy2/ZqqanEx8PgSTsKh6XdAxP3huWTzZt1p1gem/UvjhOTMll7H9yqlM6/y236a88qPxi+jz
	BEJFCgb1uUFuX5m3jMVqw4HCwQ5yCtlUU/UbhKnxzdYSAq1OkZYLuyC8/DiSAxnW0mjl7Ol65dr
	yr30UehUDUO5P1ubSZzjdjIGg489oaXTgDj2iqKCgCFSE3Kiz0bsyQHMep6kkXwBeSIsCP/K+2u
	EBfvUfQNEU2ObXYfw/Vdah0JiyIw5gvWeB1Ix2ItjEwHc7C3kVJVte+cvMiBiY5VOLdMA/aMzT/
	5rAmIQcQY6k1Uu2kTBCkPQMi+F9yHYnpfdbyJXOomwH7YA5bPi41mSosyLYkJKmhzavWa6USreF
	dKZldmhU3+p9JwosqusPGVKvblqg6tCjm7F9wSrziQqsn/4Qn0ALKflOUO8p2eSwx9DlhK3uRbs
	7z18WZj82dkV0bedcETzlHdRWCoxx1CQ4ag+M/su0GTiP5aK60B+6JjC8aEyvB5j70MQ+ZPhcfn
	wWKVI87M+5M15DGrV2MUsuYGkzCt/B3cpwY+WEyWdtl6HxBpagPiv+8uHGYK7VUJ3tpHIJyqNwp
	e244HCmrMUgVnwbX+gEWAP7rZks2PrqKqSZQf0E6mPfukItcQLe+3t6a8GwSRexJigGBBZg==
X-Received: by 2002:a05:600d:8497:10b0:49c:f13e:e4f with SMTP id 5b1f17b1804b1-49cf891bce9mr30914215e9.12.1788525529833;
        Fri, 04 Sep 2026 05:38:49 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf75ce49esm117105705e9.1.2026.09.04.05.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:38:49 -0700 (PDT)
Date: Fri, 4 Sep 2026 14:38:48 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Tuna =?UTF-8?Q?K=C4=B1l=C4=B1=C3=A7?= <tuna@tunakilic.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: mcp47a1: Allow full-scale output
Message-ID: <20260904143848.00000d7d@gmail.com>
In-Reply-To: <20260904122513.175298-1-tuna@tunakilic.com>
References: <20260904122513.175298-1-tuna@tunakilic.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Tuna,

Thanks for the patch!

On Fri,  4 Sep 2026 12:25:17 +0000 (UTC)
Tuna K=C4=B1l=C4=B1=C3=A7 <tuna@tunakilic.com> wrote:

> The MCP47A1 has 64 resistors but exposes 65 wiper positions. The valid
> DAC codes are 0 through 64, and code 64 selects VREF.
>=20
> The driver currently advertises 0 through 63 and uses 64 as the length
> argument to in_range(), which also rejects 64. Therefore userspace
> cannot select full-scale output.
>=20
> Advertise code 64 and make validation cover all 65 codes. Keep 64 as
> the scale denominator because the output voltage is VREF multiplied by
> the code and divided by 64.
>=20
> Fixes: 350d1fb9204b ("iio: dac: mcp47a1: add support for new device")
> Signed-off-by: Tuna K=C4=B1l=C4=B1=C3=A7 <tuna@tunakilic.com>
> ---

This makes sense, I must've misread the datasheet...

Can I ask how this was found? Manual code analysis or AI?

--=20
Kind regards,
Joshua Crofts
