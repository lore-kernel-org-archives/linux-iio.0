Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34512882BE
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 23:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781478261; cv=pass; b=iqPSyNh7sB0HLQVgUmVwOJxp57cc3xyAnXr5qDAwLKi0fD/kRDvPcRr0++3htLGp0pdJJVZ0H/KuHEMR1Qg6U4nB9UdUPQ83MIOzWTzMJxnBZHiSzK2wlUWMlMVhm8XW+qqgIqoUF2213joJckFHhE8zbYNu0NHpi+Du78lSeqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781478261; c=relaxed/simple;
	bh=rzW3LaS9K4mSg6IJCxAjz00Q7mrH4V7agp6NPZUYSYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ob0IsHT4A+91ZgjK7G0A5gbXwMDHktrSNg+Mt5qf9oRRmFKBZcoKFkhYmoPu+DGqpF4sk5byBOFreAE1eN7iWDqFH7b+mNKXRQWvOtJoD6Pv1Kgj2+Ap2qc09DAfPYabVGnXXJcdsgVVrRXQTDTm5C9Ieqb6FD1IBwbROBe1asg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wtdnv3HF; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wtdnv3HF"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-13809223fd4so2764982c88.1
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 16:04:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781478260; cv=none;
        d=google.com; s=arc-20240605;
        b=bVHvtjENc8haBT3DsEoWCm20FVXu/Vsm/pj3BFi4lophsv1ry40UU4xiX7xsa85Jy0
         /3W3UdD97CNAUdvlnnS9szQrrmXKXqZ+SUXJMIK6pmB1yCq40LdHdlPYrTOtiOnVgeH8
         iC3fswA9ojkP4R80bHrt5nT8Kb7Bkls4Loje7n4+OJgtceW0xpdd+Iro8TicuPdRQbN+
         1gIEdJphg8Qgk3ggwkKJA90MGVuyqO8RR54rJ1cKuGciyrh1cZGGjp4VpkXfdYCb1/SP
         Ffo/Mcced+9Q3OjbJvyETm6wewWPz5K6aJWO3dlkSoypqN/YdgFDncgUt/wFrIlyMjui
         PCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qQFoZgJYV1TW//O4GE6lS9bPSVNoPKLwy+jMEzoPsoY=;
        fh=QdXIv3k3u41e/UG+0MGgjxMP/PFVIctwmM5c6X20cK4=;
        b=GbliseUQxMqFA+j6aermFrJfKtWz2qQS7dfHvcmfQZT955ZWRXELqQ5Xcy30GntVy5
         j9kEFwVUey3MIHAlvd2/1WtBRmUefv++aAZ63sUnQR/LuRsZ1tnGeZ27CWDgkmf9mMrE
         gG4GXEZ7jXGuxuqPrDCohLsrxJoBxAMqh4kztPmadL5OVsMGzxcgH0FDWGIfMHtqWtC2
         lYRm++QTdu0ZdwzlZEGElEOdyCLdz6Een8OPnADScmy1vrXbdQo/u7pNDX6m3GK6fjz9
         Z7jbBOI0BX2Ibhc03RGMD1AE45xjvW45h7Bb0rlj1/iPRaZm/4VRTOazggIsj96hZ+eN
         rWYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781478260; x=1782083060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQFoZgJYV1TW//O4GE6lS9bPSVNoPKLwy+jMEzoPsoY=;
        b=Wtdnv3HF1dOWaenZWZJsMUv06Wmjm5VfuKIBs7NEzsxdSUnOnLCZiMxgStk3LSOLSe
         aU6UdoF2yPTVtwydTwAcFj8yDEnenmbw7uVJEw2HOll8/2l5ck8rQVfPBR9cjhLNBAyk
         +sFYHDY3n8Y0UilqOjS8LgC4Cua0DEeL/llKDCF7tWJmC1+/nRJEEJU3ilbIMeG0SjG3
         WKna0bONp5JmUHzPMtriIkmDUfegxe+17NLZ952zaAYkksTTIUH2WSxIxbRZMRj7zuAs
         EeOlJshiQUbEAtUfB3CegGJfqtbrCWOsj6YQgh6KHqCa0dgOh+Z9soKpEbvbMbPBTsBx
         pKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781478260; x=1782083060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qQFoZgJYV1TW//O4GE6lS9bPSVNoPKLwy+jMEzoPsoY=;
        b=YuieYoLQL+43rgq9wmz6HB2Aw73u/qymmfgS8ElGCvvJuOK49UnhQ0tS3qoJl2D6/I
         UUajnQpEbMEvNL9qGBFgOdKXMLR1Pr5q26XQFHhv9AA2unswDS5dAPVgOprfDjMxD31G
         WxejAllstPmpFxfuQBstXFa+eIQ6EiNJp7TC87Ol5cyEKopqAxo9uCGyp+EkVPcV48M+
         HYopN6iYO+2FwSfSvtHvVaiMS/Ek7bLCol81+0SrrWzkgD2w/NP+xR2F7tCk30rsi/HY
         ysRdUIOjMGm6dAUr70Qst0ojDdUTMBM/W8QtnGEyP5DjJCdGD8B7yq8Z7RZOThsmTiuV
         TqUg==
X-Forwarded-Encrypted: i=1; AFNElJ/KLtjMdaVhFTDlbV3m7QJa6i/mBPVBQ5C3va1zBCcj3xc4KGZC8FxmEIV4OSkLUo+4ZS0gVpUxy1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs/LZeRICKSvwKY7YXmdKq6EmoAkjIX7mKQ9nxPNSfnCsPJ06R
	IGQ1Y3qtmesA+8TWlu16WCeijoSUe5gnCyVEry9f4XUWfIsN2TD5nSx3udWNHi8cS7IZeQ+C+aV
	yLrjr4O7IfkEkdJQ1ItUgwOIH0E0yGxM=
X-Gm-Gg: Acq92OEiD4SUeaCJZTtB0BzBUkIIO3jzVxLxm4niXZTi9i8eZaZnRmzs61M8TXUAIT4
	/pKZ8lhN53QVPLWuMUJGUD+4gCmc2My1ykAhGJsVfX50JYjxFFqQVwKmZmgG26EGJ8f23fXzRJw
	Koidbl6NzEMdFHSrw3enKnwL+0hzIFTw64Q6gcilRdSTDvO8ZG9QdbS0J9Mn+7fHiTAbMVk2gfW
	8uWFWVjLP5ZM7wpFcety6VIUw+1r5YYSOWw1l2xqtplv8qCyox6s4zuZ+izvJVLcJGrK48y5WOt
	DYLK/SoI2DYQxmcGe0xzuCwQl91o7abnSzV2RRRKwQGEdOHGwz/uXd8XH+QvKsJURp96xEo=
X-Received: by 2002:a05:7301:1e8a:b0:304:3c33:7ae7 with SMTP id
 5a478bee46e88-3081ff40823mr6282361eec.7.1781478259594; Sun, 14 Jun 2026
 16:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607234343.22109-1-kimjinseob88@gmail.com>
 <20260607234343.22109-2-kimjinseob88@gmail.com> <20260609-glacial-colossal-38b4937ec620@spud>
 <CALMSew+cL0_kG6W15RapxLtE+Fw2_DYdrYoRFSjENQktWw2H4Q@mail.gmail.com> <20260614185551.10ca9e0f@jic23-huawei>
In-Reply-To: <20260614185551.10ca9e0f@jic23-huawei>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Mon, 15 Jun 2026 08:04:08 +0900
X-Gm-Features: AVVi8Cc1I5qF5SI6k_QOccx57286vKkIyKY9ls4Qi2qkv9NyvMEQc1iX0U3ok0I
Message-ID: <CALMSew+y_S2LJ6bBiRWyZniEaD+V21kvOiXg_=Gr9dnppUZ3mw@mail.gmail.com>
Subject: Re: [PATCH RFC v4 1/6] dt-bindings: iio: add Open Sensor Fusion device
To: Jonathan Cameron <jic23@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, linux-iio@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 6=EC=9B=94 15=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 2:55, J=
onathan Cameron <jic23@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, 10 Jun 2026 18:33:54 +0900
> Kim Jinseob <kimjinseob88@gmail.com> wrote:

> When a device needs power, the regulator is required, not optional from a=
 binding
> point of view.  If it is always one people can use a fixed regulator to r=
epresent it.
>
> Now from a driver point of view, the regulator framework in linux provide=
s stub regulators
> for missing ones - on assumption they are always on.  So we can just requ=
est the
> regulators in the driver.  Keep it simple for now and use a
> devm_regulator_get_enable() in probe so we have power on for all the time
> the driver is loaded. Can do fancy stuff later when you have a board wher=
e the
> power is controlled.

Understood, thanks.

I will make vcc-supply a required property in the binding and use
devm_regulator_get_enable() in probe in the next revision, keeping the
power handling simple for now.

Jinseob
