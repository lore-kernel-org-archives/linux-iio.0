Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F9D399364
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774428508; cv=none; b=S8djaBtlgin+QWMujAfDccKtDQA9Y5yTmeg+a31B8KLL6uCeFkB4lZlOYet2HuR1lPBpFt5Mjo7brym0YRR4af76GbYQYNFC+VmP0az+5lkGs4wrNBVesrOtTyldKSnSe9aoWwCdeNfK7FmBxl8BxRPsCn68QuUnZuOEMP2PR/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774428508; c=relaxed/simple;
	bh=Ui/B+EjELq89M7DdOa1qJ2iByB45eUm71MnYOkLiSuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBXQ6XSuPhurW1a5SQtr5LckPM4FruYZeLiMoHKKYdBihMPxmkwXfrs1484ArWHd+m1yiYwgkgazwk8fmPT2KpX30/K0m6TPMX29vHySB1zmXOIKxWURn1S+o7pFlX2biWTq589K4bGPU2v9guoxQ2qZDDz1kZWxVkbXwAYuPtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64eecef1a3fso234988d50.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 01:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774428506; x=1775033306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ui/B+EjELq89M7DdOa1qJ2iByB45eUm71MnYOkLiSuk=;
        b=M4cqraDN+3IEqJibR7LzTDaV22cU3zupA2ROoBxc9dT3dHjJ0Vl47/aox5GOPG3PTJ
         lDLWDqDZBTgj/6MgTVNWo2zG8wgVPO1DLT97T3weoyXbPfFMOOt+y3RfxSyH+aafcj8j
         cWLwhW3y++g+g8/KYSqH1x/SLEQUV0lkembvrb6WmapIruWc2lJUZRvj89IUsKVg53zt
         NMJagFjpgWoQ+iJlvxkadAOvccB9P+n/ToDLSD53q2egTD+sMQS38ABBaRlFGO5TWPRe
         SBnWBNNQSIRBR/ydU//1f19RcQCDTo0E7WJagBK1ld/1++UG8Ci723xpXjM5f1Vu9pc9
         WK1A==
X-Gm-Message-State: AOJu0YwBadtOMI4zrMmnXHVg60ceSgl7fDqLBmmCCLEE7wJnL7UmktBc
	A1qtdNZ1+/5hpJfTW1/3FgRQs2rpKfw7T2j1kGL7DBkHHDjgG4RI//23DfmrvFfq
X-Gm-Gg: ATEYQzx7iX/xHmIa8CM+KFp258zfe8dKEp/mWjqCukosfhcJUPecriFIhd+JD5pXJrM
	8ZYaYvUDTAHawQxnv0dDYjveOxODkomMvlBGtc7Ndy4Fp84XcCK+mo59CPa83H1WcnvCmvAi3cF
	edSx+vlGSWF29aMhvaitTF0BmflsIXr9iVzepU9qXkp7LsILNk+T0xZLCxFwGo9j1CaTBVleRfe
	/IY2gz3W4LzghSV5d2k6aYcCY4uBAuY7OtquL28K1eB/ok+yCCo/FZIRQlMna4LrBMZSeczS0Hd
	6CReQSNFlrQEsNJxRLFika0JzSzr0Tyf8MjlO6zan+U16fg9NTQIQ/8fwf6UULCveB/4vnTjsDK
	+EDwdIkDIAt2L6uITcH+Vakr76G2QBHlIaGWL82SYXzVdzlLAV2v9E/LzG5PGzwZ8tHVUaws0yV
	iimJSKAPNapFZ6CO6++N2SG2iT9Jt5oDNBxD+Kx8NF2K97YJs30usEMmXH9vVZscf6c6XyOI6ym
	UhmZgUTFzWL4g0HW0Q/7vtkuEyX3hs+ujcWjRRljw0GeJ8yvCmb2g+0
X-Received: by 2002:a05:690c:7243:b0:79a:b861:e2fd with SMTP id 00721157ae682-79acf3b54cemr26079267b3.21.1774428505760;
        Wed, 25 Mar 2026 01:48:25 -0700 (PDT)
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com. [74.125.224.45])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79ad5aa3691sm4354597b3.7.2026.03.25.01.48.25
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 01:48:25 -0700 (PDT)
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ad79df972so7433751d50.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 01:48:25 -0700 (PDT)
X-Received: by 2002:a53:ab0f:0:b0:64e:a737:e1ab with SMTP id
 956f58d0204a3-64ee616314dmr1908327d50.37.1774428504983; Wed, 25 Mar 2026
 01:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325063254.18062-1-email@sirat.me> <20260325063254.18062-2-email@sirat.me>
 <20260325-gentle-earthworm-of-progress-1f9f46@quoll>
In-Reply-To: <20260325-gentle-earthworm-of-progress-1f9f46@quoll>
From: Sirat <email@sirat.me>
Date: Wed, 25 Mar 2026 14:48:13 +0600
X-Gmail-Original-Message-ID: <CANn+LW+Y6j0xk2x02-BUL9qNq2gf-PXspi4wP_KGd7Abz3hOYw@mail.gmail.com>
X-Gm-Features: AQROBzCPEuZJqZcCIIPP-FKaXO5te60icvGpBgjyHBWGoldVR2MwA1H_0wSNnhM
Message-ID: <CANn+LW+Y6j0xk2x02-BUL9qNq2gf-PXspi4wP_KGd7Abz3hOYw@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: proximity: add ST VL53L1X ToF sensor
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 2:05=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Wed, Mar 25, 2026 at 12:32:22PM +0600, Siratul Islam wrote:
> > Add device tree binding documentation for the STMicroelectronics
> > VL53L1X Time-of-Flight ranging sensor connected via I2C.
> >
> > Make vdd-supply required. The device requires power to operate
> > and the property should have been required from the start.
>
> That's ABI break and device for many years was working fine, so this
> should not be changed.
>
Jonathan and David asked that vdd-supply be made required. I feel like
there is a conflict here that I am not able to resolve myself.

What I think about it is the binding does not correctly describe the
hardware and we should consider this a bug and fix it.
The driver worked because of a fallback mechanism (dummy/fake
regulator) and not because power was optional.

But I am willing to follow whatever consensus is agreed upon.

Thanks,
Sirat
