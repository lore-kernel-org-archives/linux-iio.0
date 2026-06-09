Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A5737206F
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023291; cv=pass; b=klfyf4Iwld9sUdxH7RKO+opWCxIHBtRzIW0WsYV1fZsv7BpSEmrdeVLE8pJh0GXHj1jyG8x851Q+/EDmhztvsvFc3xkBWHFpmuYAdaTXuYpkdtOEzTJKtdAaNVRfh2me/7xZYodtlvzEPzt+w3Qtroo1PMY8cdKDi9h06WPKnoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023291; c=relaxed/simple;
	bh=E2GCKIOLtfV53ggPo+NGPJvjLDxOwlQa/g0l6GIWSuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpHSFRxvTL7tQdiFojiQEWbOlFa/CjZhLxMdeUx4Fke8fwLVfafUa2KyTICIzlX+PzvT3+l/B0XyA5ECLmCh2XZ+Cs/G9qfPk3XNKkUwqzWZI3LvGlYuyLg7UNrxNScHsffcgAU00EAbzyPkBe+766INFXabIS/uqdI/wqp6Kjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIRywoC7; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIRywoC7"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-396775c26f9so52177941fa.3
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 09:41:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781023289; cv=none;
        d=google.com; s=arc-20240605;
        b=e6n2R84umtLnqJWR28dPHVkX9/0fzqx4VGwpQ1uDUM+R5p8PitM0klXB/2xtvZq3Yy
         s5IDzOo2E2R4wUT8LdAZzFYgf6KLGiYpzXYZXlLlu9LgmmJLmAR4kb+jFbG1rVkZA1+e
         ODDKdWpTmJWChXj1iqkByNvirOwvT28E/rSS1XKKpv5VII0w8XkIWKd+XVqFUWodyIhz
         dSOjeVh6cHMbErAl4a+mjDwS15LaTgLnEQv0vUHyrrOFjQLylsd3lKaDkdbUIlRnR6Bx
         lKP9+s63+z5l5DFpz132tSyNyvbbNUNrpo455+uHkL4JNsfjx+VQoOjvIsyL6T/b2waf
         SWwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JbVtrbPRmQGLBtb4NcidkH30D+QB4F0TUQOAbXH9LEU=;
        fh=AeLPIDxHXtfOUaUA9t39hptfMd+ICXiXFfk31V8weUE=;
        b=iulwtxyqulba9VKLWELUsduoRpCtA9MGC5tFgKQ+Iis9JIm//f2id9XK+/TUyh4Ggy
         zwJ+bfkbpP6gDHRsfMIvXWcRLFM5/9BxhfJsKDqr+cDpFrPYbhJRr0hjRGjv+sJNGWJ4
         w/F5qAiVku38GE0xOPD2vXbQOiO9nWO9TnVsVdvJv1iRy2q1Zm2NwzTZMCbtqtYNn+SS
         8yZ+CWQSI31E+M3i8hN8RreY4qBMBkkWdHLBNP0nVK1eIMBfE5CFvG4BmAmBl1w+MOa5
         1AEkKVI6haw21wgwZqYcYPPcRD4ePpDBCQLkA/iOn3JXHJsZLXW/HcwEXGc+ZoMz9HC5
         KNPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781023289; x=1781628089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbVtrbPRmQGLBtb4NcidkH30D+QB4F0TUQOAbXH9LEU=;
        b=PIRywoC7jRPDfIsDQePtTZP+TehrcS7vVKAWJbIWMk8GOVt3ztqKGg5u6KRBDA/JA/
         +hGJABbZbTqcDvfPD1WgsC5KsgnXyL5TTgj+hcQk2CIGi2MP5DlmOO8NxXWs/xAgc+wj
         4kXxsUjRGFm1pUI++J+k3BjMNVvaEFsR9LmhgDITm4DSlHLBkfqL/CBpuKT9iIUPNxbm
         +hRFRgxpv+wMXQ1PQx/aRP4Yd0bsyZZmV2ABin6QDqPSU8D/SCmWU5gUkeQk/Qhbzbdk
         A5r+bTRkk4bDC5M59GzgPh/p+t93yNQhreS6C9Rz6t9pLovdHbCXefITnDLVKSqbfQrM
         VRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023289; x=1781628089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JbVtrbPRmQGLBtb4NcidkH30D+QB4F0TUQOAbXH9LEU=;
        b=YlJReSji9fiwSz6wcZy2RRDiHGmfOuTo8nxACN2AnQBqzDde7B1swG6pldM0rsNdO9
         9lzaEu4zVfC+PmgsHHfh8rEgyoXxGhJfb/L/Dvb5lx3RADfaw0kVI3vYK1xaZqsyr2WB
         iDggot+Si/XHyPKJS4FZkdk/VFImQ8oN49THOK6c9V9YUvAckstRSdVsjGz2/McGmtLA
         5ycIks8XpF+vQ/xsxpMWKxkGL39NA0wTbEocRhGXgG1isvxKLaTkwQ9WOi0TymrHrDDX
         WVZLYEWmcX54bnU3o2DupJw+XZrIn+K/twP0OnBZUsYQvfSDlx/OJsgeTY8nymN+1gX6
         6hAA==
X-Forwarded-Encrypted: i=1; AFNElJ8VxTW4u8jFsy3H16n1MAH39LERIKwJJR1xbd+/t7R0JJQVNEZWQMvF6RqG+tjNVOWa63XelplP4kc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0wpawTGwP8BqIykHGx1BcWkXruR7aDlVrfORM6BY1s+iJMiRx
	xBHzI3i1NSgX3Fwq8LbwZYMxyE8FvZY6uH3qsJprOtLE1iVOCBEc6aeK9wi5I/Pd7nOSQ5f14Z4
	tCwTedLiqygtKIrS3hDCYx2AxFiDxKCLlu9yl
X-Gm-Gg: Acq92OFZY9CiIXPRb5vf1tOeORHkWuE+4Xo18qXEeBc+TnepAOZewlPzyyyvAv2KRS9
	xCb7zhmSygC7I42ePpNXWY8wuuQ33K8gj92QJeRvul5URjgtKqQSUrAHJ9M+AfPQBNNdOFa/yrj
	z1md3Zzd6eAQ17MKGVR3lSYRTxxBJlji2vrZeXICm3l/aGDS6Pw7ftB8H7f9tD6xOf34rCdAp/G
	ONI4u5g4ZlXcNMze/6MQBQfaQDSbS8cjNE0BauUc3mlZZXV0LNqGc2JcbzRwKNy+KmVydVNK8qS
	bF9euycOPlZla2n2xA==
X-Received: by 2002:a05:6512:a93:b0:5a4:496:5bac with SMTP id
 2adb3069b0e04-5aa87bd5171mr6091292e87.36.1781023288477; Tue, 09 Jun 2026
 09:41:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609161701.52513-2-m32285159@gmail.com> <c9418ca9-5563-45a8-b995-d2bf7514d819@baylibre.com>
In-Reply-To: <c9418ca9-5563-45a8-b995-d2bf7514d819@baylibre.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 9 Jun 2026 11:41:58 -0500
X-Gm-Features: AVVi8CeB5Cz3-YRRLOs9srWuk1EOE3Tb2CijlwWS3Fx5DtPSuXMKb63HwLEYvMo
Message-ID: <CAKqfh0GF32Vwcoyr_rLdq9Q_-DESGAiNYWk=SEAODStzOs=MkA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Replace Tomasz Duszynski as maintainer for SPS30
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 11:22=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 6/9/26 11:16 AM, Maxwell Doose wrote:
> > Hi all.
> >
> > This is basically the 2nd half of replacing Tomasz's entries, once
> > again, in the SPS30 dt-bindings and his entry in MAINTAINERS. All of hi=
s
> > entries across IIO appear to be dead, which is why this is being sent.
> > Jonathan Cameron's approved of this [1] so his entries in iio are being
> > replaced and an RFC regarding this topic with Tomasz Cced has been
> > sitting on lore.kernel.org for about a month now.
> >
> > Maxwell Doose (2):
> >   dt-bindings: iio: sensirion,sps30: Add myself as maintainer
> >   MAINTAINERS: Add myself as maintainer for SPS30
> >
> >  .../devicetree/bindings/iio/chemical/sensirion,sps30.yaml       | 2 +-
> >  MAINTAINERS                                                     | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > [1] https://lore.kernel.org/linux-iio/20260609140712.2e5d1640@jic23-hua=
wei/
>
> Do you have this hardware?

No, however I should be able to get it fairly easily.
