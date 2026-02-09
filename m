Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ABD328B63
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770628028; cv=pass; b=mdn7UFW8tpNhvB7aZN+dMGzWLQKXzAQl9SYc8ZOxf8FcgIYHWsZnT7R07M4VQ1CRN3zmETTarnfuaxMWeqCSHCRlnMzkK2yx2bZLtdi4l5GHwgvF0v6FUGoAK7A+IxNIzTrgMvWZHc6JpWNpjZ8+HHqjrKktyK33BYZ4oIgwels=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770628028; c=relaxed/simple;
	bh=ARNZTT0ZHaBrZDbctujL9G/d4o2dbqa30Uva3TCyzX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXhcI2VhI1BBGS+qgRxWs8/LPmv3NIMHdLykV3R5S+bRda+6ityx1nQudeE6hkCxeddWLaVksHcPC5ZjXJoK4/hrvwZWKgL+7jKcUB+UMqZr7bt9+HT1MzFtd9O77bhsOklHPUkawO4E/VYzFLdbl9dQsKoxeCnlghiD1vYVFXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPYJolRd; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPYJolRd"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4376de3f128so500150f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Feb 2026 01:07:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770628026; cv=none;
        d=google.com; s=arc-20240605;
        b=hoVoVDG/LrCYPraDzg6FiUbq5NpGqh+JSzZPNSrWq87XzUj0Q/1NpTWYFUg4AJZAxj
         UbnMHdldGLo6oLbOu3BQDC9GE6Ifsyjr73NMR98tvl0O9ohqnW3mG0GCsCKtCZMZ5Huh
         zSV+hTlMEINHNyS3/x4M8PLs9+7sRSqsv04aP86cxsUYQ1TfI+v9IbjVUHMLLzJ9s9QB
         EIaTsIUTV2cfC0pdXKVAoyGKD87ubFt51N1WicsNtAaNy53TLp988sZ31+7UOmnFb602
         IZN5l/JLeZhvYWDvWAWFuEZpl279gEyxE/EREmQlob0LEwGe3DLaA4RJsL8p+PX8Pgaj
         D94Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ARNZTT0ZHaBrZDbctujL9G/d4o2dbqa30Uva3TCyzX4=;
        fh=p6YivcWxqGnlslKd4AAnDgUInn1wDo9rvqgntsI+/H8=;
        b=LkUiYG6EQKKeU6MtDGaDaA14rnboG/F0AfrFYvegECErSJdPGsGdEeEBe3Wxas6izc
         5O+vvWiv3/DJQWeK14fdkw6qTye4ogRMpQgruzTeQ20D3/Xs3OpZo9E3xumOOcK5THxW
         Q49x+0//Iqlc0MIKrXw7/0sBxODnI3vKzEqhw+32g0IMgyNQUqRH1YWM39t6ATDAbM5Q
         x1YWhmvTbZ8bgZ2BoxKq9KOIArnxRMs39VPskHDS4A9EKRwfD4R04pIxQmyElvaurx14
         z6QjbxovwRZcRqM8p6W+UKm8xqKrP7QOd4vVkkND1o4grkQa5Q2q9XnoDPKoyqdXVC0w
         6Zkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770628026; x=1771232826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARNZTT0ZHaBrZDbctujL9G/d4o2dbqa30Uva3TCyzX4=;
        b=LPYJolRdSSRxYinDkCi8JHgOkqNUZp76bD7EU177xUHiKXM35vsveBHoZzt6v47BEc
         qRYpoUeeMhtVogm4fl74RxdQTJN/ScwZUSw4ICCqDIKS9fVbB0/XWfxT2Kej7tWpWVK0
         0zoLN4iS4SRV5PKuKeMaojzs+cC8FVgVUlyc+rQ1flBNTFV6IKvYZ1aUuQVd36Do/bX3
         X+z9pF2PlsICvgaQCDJ1hCr5RTS4X2d+wm709uOgQaWiZP5GqayqvEyB+hEVQjc5d/1+
         sVnF0K2Qmb84CjkXeWkwn/IKD8PUIUr/Nn05TX/aTz4/ojqbtGLzYlqwfHN/xS78LLOV
         YtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770628026; x=1771232826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ARNZTT0ZHaBrZDbctujL9G/d4o2dbqa30Uva3TCyzX4=;
        b=Zk+wHR4/mqxzkp/enK+/HSyRbVYN45xboKYLz6r6xH04cEC5xmVBgOAliNtVitEY4q
         g0Zx+9VsxFlL3WEK+lcwLfdCHePpc9jOk+eH7IYaUHwb9JRiLuNCW00M8jPykTsBf6fr
         pLb924ASXFlsLyeXFS7uvTFLXDM2G4tRoE9wseYheq+AuHLPCj/qA1PrQfPoVINk6HCM
         OospVA2aTijhkXoeDiFDxQB12XjhFiu67YqR96Sg0XsOIrSof37hINUFopyTh4/+s+oM
         wHFGwa+izQZwS8cUw1/hUkGCOGCJZSxuI4EAMcD1aFIJEJZKErkCH/tVtX1p23BoDt2y
         ldmg==
X-Forwarded-Encrypted: i=1; AJvYcCUhlvqVEJdosO6pB6JjeoZW1Pts1qfdP1Xz7DCX/TAlAKJimeqsUVlVR24Y1lYiNKxxYWYyY71b8vQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMe5ZuVsYkOr7X+LboiLR58Ifc5hPLqsCZYcV5AwgsVdevX7LB
	cou4sdFWvVQkz42gqJTPthM1Ci9DDiYGNFvJ6NO0733BJvWVJiKyTPlsOaRSPpC5yV/jRsjIuAn
	yfA2KE+s+J7pDEnJcqh9g0YLAoe53MWM=
X-Gm-Gg: AZuq6aLRJNGibLWEQiLd2oS1O3mRWf5/JhijbtNOP1Zp1fyru3PkhQbjKL2gBxkj2n2
	R8ie7bPLFKKq5LV57WDa99aLV80wG6u9VgrDXeOl/BX6ColRu1QOyCvisx5kT6jbASq62YduXzR
	yhGr+HyWBc4+NSSQBI6OrHWtY8WjrvrvwvPnu7g3btNJooPQl4npMovyd2AIB9J1JSLmzTaqbJC
	bQQKE01hny5EZXSkbxkmZoawelNs/omem9QQVjGaU89xGVgdneydPHKXmWEWaBkt/qqJ67f
X-Received: by 2002:a05:6000:2913:b0:432:5c34:fb32 with SMTP id
 ffacd0b85a97d-4362933f436mr17440511f8f.23.1770628025680; Mon, 09 Feb 2026
 01:07:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206172845.145407-1-clamor95@gmail.com> <20260206172845.145407-11-clamor95@gmail.com>
 <aYiHnUW93AB0ARJH@smile.fi.intel.com> <D8B3E97F-3405-4EBD-882D-677F530E4EDB@gmail.com>
 <aYmYcd0431P5sUtq@smile.fi.intel.com> <5AA39777-F5C8-4AD5-A5C2-47265C8213F5@gmail.com>
 <aYmg_7uq2rAWJgGK@smile.fi.intel.com>
In-Reply-To: <aYmg_7uq2rAWJgGK@smile.fi.intel.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 9 Feb 2026 11:06:54 +0200
X-Gm-Features: AZwV_QgwoS53VSYtsaxPBt7zkNokx4yMZnC0-ZnRQ3AbohXwTZvajTpszTk4bdc
Message-ID: <CAPVz0n0+UxdocZdLtqPz=5m5RMV_K2Ldqsf53-13hUiLpV6c6A@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] mfd: motorola-cpcap: diverge configuration per-board
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Dixit Parmar <dixitparmar19@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 9 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 10:55 Andy =
Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Feb 09, 2026 at 10:42:02AM +0200, Svyatoslav Ryhel wrote:
> > 9 =D0=BB=D1=8E=D1=82=D0=BE=D0=B3=D0=BE 2026=E2=80=AF=D1=80. 10:18:57 GM=
T+02:00, Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=
=D0=B5:
> > >On Sun, Feb 08, 2026 at 05:19:49PM +0200, Svyatoslav Ryhel wrote:
> > >> 8 =D0=BB=D1=8E=D1=82=D0=BE=D0=B3=D0=BE 2026=E2=80=AF=D1=80. 14:54:53=
 GMT+02:00, Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=
=88=D0=B5:
> > >> >On Fri, Feb 06, 2026 at 07:28:44PM +0200, Svyatoslav Ryhel wrote:
>
> ...
>
> > >> And please, may you contain all your reviewing in one iteration. The=
n both of
> > >> us will spend less time working on the patch. Thank you!
> > >
> > >It's an impossible request, you should understand that. If you want, u=
se AI
> > >or your robot colleagues for that, I'm just a human being, I can't see
> > >everything at once.
> >
> > Ability to see only nits and don't see the possible issues seems to be =
a talent.
>
> Paying respect to the reviewers requires some talent, indeed.
>
> ...
>
> Also, train your logic a bit, why do humans have so many professions? Acc=
ording
> to your "logic" one should be a doctor and a cook and a programmer. Why n=
ot?
>
> Or even closer to this case, a doctor must be a surgeon, a dentist, a the=
rapist,
> and you name it. Why not?
>

If seems that my expectations were too high. Apologies, my mistake. I
will keep in mind to spare you from wasting your time on reviewing my
patches in the future.

Regards.

> --
> With Best Regards,
> Andy Shevchenko
>
>
