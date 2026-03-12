Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5622838B142
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328365; cv=none; b=qLBQWLPbxUhRfCrDHrZFXRWAW3NRdt6QfrBrMwZFe/V0B5fQAyYJyNjDSE4q6QtGnt672nTwpPI6xkoCd2+/EaBeShtPqcDO8B2yLA2HwkYkbR0GEbczL7wyDs+kpYXXAmhGeJ0IZ25yiGBTRQGzJ+C6pDkwPKhYSZ98ifyPnO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328365; c=relaxed/simple;
	bh=xL8m87uKS9y7aocchYesBcn3/kaLnfg9HDUZiyM5xYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWi070AhiJRmk+3AoTCnhTJa6AvYlj53f15BOX7CwiCoMn4Ligg4+jT4/8GkPPHFNjjq7u4f5SyXCDen24RFc6gW3Mh4mMI6zUNWwgvSEr2lgQ19FJ8rwHsE7yX44+mqJr4duOJ+DTk/lzKGBrl6Mwgmi+CPhC1+QbVfvYVjl9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7986fb839f5so11184647b3.0
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 08:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773328363; x=1773933163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xL8m87uKS9y7aocchYesBcn3/kaLnfg9HDUZiyM5xYA=;
        b=mFWHzQxsW2PJ66ZmtebNtRVw2QLh0/ZKeKhneTyoUI+nZkXfeHoE/hJPSgOLaIgQJa
         SypFcwXA5C+LxR2opDZCedBRMm4Leg+v55UNxTVOmKjmRF1y759wPEJWyIBQzcHUa6tF
         Kip+DDusAljmrHZAK9rXa3alModXwBwwbNWvK8OPFFq7Aq9vTrsMFwYDKAsUHEkZLbv4
         m+STWiJoIABSYrvmTIXyEJpQZl/35GtbVAqsTAdHREUZts6oVlKwBJVZ06gh6vU73GMO
         ATDqL5WivUynCW7Bxfr9cozdvXBsOA4FU8supw7KRW6dG+94G65lVSeFD1uNaElHHLQV
         yqSg==
X-Gm-Message-State: AOJu0Yy6FI9BmVPc3tYOfjt1KUeD4+UAb6jWBn2FuZCe6rv1UqXQYAFq
	InGYPyvw66//beC7M71IIsRGKfCgMxIbxBzQmDsn6K9mRrBGFHhMPv5oJjJflp7Gy28A/g==
X-Gm-Gg: ATEYQzzZjy+5dUjosFLJEGWBBE7WbwHEH3/StkSVC3Ae6v9GXCvhK4Y82W0QCm58j3V
	G68ePGktzWphLksX4UramlcpqxKqEv6NWnmBwD49nHP7ho4zRaze6jtbk+i9LHFp1EWqLfJrZ+y
	YFQ20QQMChd8KWhgjL5f7aEE9iN3M5nkhcdyHQMWUU1gGNkQhSSBQ7Hh1dFX6jVWDGVTE+CsC9h
	3JdfcCurs53WzWBMKseWoDlqjsiEO9IDF8Hbq5PN8EL2CK7nvxGIVAvr9Wu/X1FO5H4FF2wpg/+
	X+Pi30nZA/5GlPidsj0Oc4wLxNr3BnrbTee4a2rqJJuDoXRMI37yivuGvTqYEty5blALqeFGS/C
	IVFR7AQGtp9j2yHp63/65YYlZf3m85054Vr4PfD9NwqAXYumcVzPuBifUIOyhqpRZU5BsN6UMTC
	9d6AzwGzjYrgGV/kcGm3ffZid3On5ynpBpWUd+yZijOSJP5hDvFPSyKm2MMmOUg9ubDXo=
X-Received: by 2002:a05:690c:90:b0:798:56eb:f238 with SMTP id 00721157ae682-79917f69570mr63404147b3.36.1773328362951;
        Thu, 12 Mar 2026 08:12:42 -0700 (PDT)
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com. [74.125.224.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917e1df14sm31349417b3.17.2026.03.12.08.12.41
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 08:12:42 -0700 (PDT)
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64ad9238d8fso1267786d50.3
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 08:12:41 -0700 (PDT)
X-Received: by 2002:a05:690c:498e:b0:794:cd8e:3616 with SMTP id
 00721157ae682-79917ecc0ecmr62120677b3.21.1773328361720; Thu, 12 Mar 2026
 08:12:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311224044.21480-1-email@sirat.me> <abLNbGUmaA7K0s68@ashevche-desk.local>
In-Reply-To: <abLNbGUmaA7K0s68@ashevche-desk.local>
From: Sirat <email@sirat.me>
Date: Thu, 12 Mar 2026 21:12:30 +0600
X-Gmail-Original-Message-ID: <CANn+LW+F2bVMAGwoF8q9yBpF3x5r_hWDqvE3_JYjcLd16A_cEA@mail.gmail.com>
X-Gm-Features: AaiRm52FISbjek1ffTmmZvvhnepNiWW88rSSPxALXAFJ0Q2YHDic6R6kDrORw6w
Message-ID: <CANn+LW+F2bVMAGwoF8q9yBpF3x5r_hWDqvE3_JYjcLd16A_cEA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] iio: proximity: add driver for ST VL53L1X ToF sensor
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 8:28=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Mar 12, 2026 at 04:40:35AM +0600, Siratul Islam wrote:
...
> > ---
> > Changes in v3:
> > - Merge DT binding into existing st,vl53l0x.yaml (per Krzysztof).
> > - Use "reset-gpios" in the binding but xshut_gpio in the driver since t=
hat's the actual pin name.
>
> But why is it "reset" in the bindings? If it's a power rail or enable pin=
, why
> not call it as a such in the bindings? The connection on PCB level is dif=
ferent story.
>
In v2, I actually used a separate st,vl53l1x.yaml binding with
`xshut-gpios` and a required `vdd-supply`.
But Krzysztof pointed out that they share the same pins so the
existing st,vl53l0x.yaml should suffice,
using reset as the xshut pin.

I think a choice has to be made here:
1. Either I use the st,vl53l0x.yaml binding with wrong pin name and
optional vdd-supply to not break existing code.
2. Or use a separate binding st,vl53l1x.yaml with 1. correct pin name,
and 2. require vdd-supply

Krzysztof, do you have a preference on how we should handle this?
>
>
