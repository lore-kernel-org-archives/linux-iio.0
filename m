Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3940B314A9F
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430301; cv=none; b=H403guzNgQ8U/cLSucpephXPzxLSIVzeC3uLoaI2Tqh+WKaaW5KfWu17/g24F4LdKM29kL0+Wj6rUxFI5VOUvdUdQ5u8IB8lCWbbV4CQNHkBR3WcVkIVkXQHD9FkIXH3xgyf21tdHwI4qX/avxQhwaIjbhfKoRSB3w6E2FUjXLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430301; c=relaxed/simple;
	bh=qrYKJpnV5q5wsZW/KCJEGBve3p9zylQB/0fgxRV8QwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcpnAZFAQFmEVpwOuHO+FJF/WhIYkH+QOm9NnfxwC9DtULtZQnQrEjKSxogG4wEvYg0fN8hAjF7AoGCw4y0OIue3S+tLizz8pFzDI4i0ez93wurjs5JYrROc8orSWLl2CQWpwzULLA/6MCnRU1UyFlKt2fY9vLGsNPHfaCnRQhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79827d28fc4so54983607b3.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 02:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774430299; x=1775035099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kqw4hGAptzQW40hqgwgs8wt06iUhcX/hjN2fKnH5lLk=;
        b=ZPaUQgIiTOez94PPSU6GW2wm79yo4v5LmoUD8oQs1/pInbtBclV1aq6j9WO50aTEPI
         PMH0epqfC8pdgc8p2OtmJKR4hK6ZLeyYGFzD4//IW3mkv+xj24MGtD5f3cXrxAt8EO+H
         9Jeqp0Ui7SjPCPKWwhIyrRST5Vikl7fPDrgOd/MXpT6DfHkcetxgotf/ruhRR/y/xUCi
         T6/5Uc8dnb9oXNcRaD/sXfy8gunkPKkg/Gc8MiEsr1RxjsGErbHthalsBNb9IzRrtHT7
         kaMWCgyGllmRisKN2CcjoJGS6CmeQ98FdLSrB1EDpkn6D+uA2IODvEgpbNbAWzCKfDYr
         hsHw==
X-Gm-Message-State: AOJu0YxZIFiucnFIWW/hZbuJMJJlosdy8MGn78aLyfJS0e5iqqP8nP/b
	SnBvv8ebTplJaYRuPnG7CtMtA96YuP3KBvpk5fqyLItWSUSWml45C/JX4/4/+rZP
X-Gm-Gg: ATEYQzxGKi0dikC978Vc0xBJAIIl9riUTeyR+6bDXT745aej/8Y1mRdMwtW11CznPMX
	9dQhzB/XNDA+39Hn//u634pQOEYRK4jBlus5w2DZzJIcRE+JujODjTS2ws/Ybx0vS4VcaTkbI7e
	gaD5fh8RDJm83AaD7hKjdKB0xZGX9Ak35RZQnpThFtRHkJwxWj5m+UFHuWFFYN6MDYcp8vdm9Io
	uIgZeZ0tBL33HCPL5K0L2OyJ8TW9sRCxIJulix3IWa9NCyuyI81QhI5BqlgIlQW6mTj5g96LuxP
	pZHIOGngzSeqI58nGI4jsVdBdF0I635LlCsR4n2wvR/m4P87jMXHcilU3CaZfzSCYhnIlmnBk12
	VA+wVt97TVvZnJTZCUdyHZH6z3fy3U6Jllu8k6en9fZT22/E3DykYQZoBanA2ODBJNbYgp8tBLW
	ufQSUNfw2z3P1KC27bqqAb8uzcmZFqCzci9TC13Q5NqZNvTU5Yu4BmKl8/cbr9F3MvhvaU5adbH
	rWRNMYxMnpSs9O7sbFHKEzhGABILmeyOqF2U+lXce8DZw==
X-Received: by 2002:a05:690c:6b07:b0:795:294c:fd4d with SMTP id 00721157ae682-79acf614d01mr28381587b3.37.1774430298960;
        Wed, 25 Mar 2026 02:18:18 -0700 (PDT)
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com. [74.125.224.52])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79aca5fef49sm17256437b3.30.2026.03.25.02.18.17
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 02:18:17 -0700 (PDT)
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64e9f9226a7so5716992d50.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 02:18:17 -0700 (PDT)
X-Received: by 2002:a05:690e:dc9:b0:64e:a7bd:b9d0 with SMTP id
 956f58d0204a3-64ee6180639mr2634258d50.68.1774430297013; Wed, 25 Mar 2026
 02:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325063254.18062-1-email@sirat.me> <20260325063254.18062-2-email@sirat.me>
 <20260325-gentle-earthworm-of-progress-1f9f46@quoll> <CANn+LW+Y6j0xk2x02-BUL9qNq2gf-PXspi4wP_KGd7Abz3hOYw@mail.gmail.com>
 <4d10b6c0-d599-4fc5-b9ed-ce669ac46e84@kernel.org>
In-Reply-To: <4d10b6c0-d599-4fc5-b9ed-ce669ac46e84@kernel.org>
From: Sirat <email@sirat.me>
Date: Wed, 25 Mar 2026 15:18:05 +0600
X-Gmail-Original-Message-ID: <CANn+LWJQM45rAT+mzS9ZEGBgmqChbxUtStdzhbzthXUPJ=2csg@mail.gmail.com>
X-Gm-Features: AQROBzDJdQ9Ro-BvrJ9gUlQ4zZ0Q8A9d8tMT9v5AumlPlE1K2xslZ-F-ZXsII98
Message-ID: <CANn+LWJQM45rAT+mzS9ZEGBgmqChbxUtStdzhbzthXUPJ=2csg@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: proximity: add ST VL53L1X ToF sensor
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 2:58=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 25/03/2026 09:48, Sirat wrote:
> > On Wed, Mar 25, 2026 at 2:05=E2=80=AFPM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On Wed, Mar 25, 2026 at 12:32:22PM +0600, Siratul Islam wrote:
> >>> Add device tree binding documentation for the STMicroelectronics
> >>> VL53L1X Time-of-Flight ranging sensor connected via I2C.
> >>>
> >>> Make vdd-supply required. The device requires power to operate
> >>> and the property should have been required from the start.
> >>
> >> That's ABI break and device for many years was working fine, so this
> >> should not be changed.
> >>
> > Jonathan and David asked that vdd-supply be made required. I feel like
> > there is a conflict here that I am not able to resolve myself.
> >
> > What I think about it is the binding does not correctly describe the
> > hardware and we should consider this a bug and fix it.
> > The driver worked because of a fallback mechanism (dummy/fake
> > regulator) and not because power was optional.
> >
>
>
> I looked at v6 and v5 and I do not see such comment for binding that
> existing device should change ABI. Can you point me to it?
>
"Make it required and add a note to the commit message to say why the
requirement should always have been there. Devices tend not to work
with no power." - Jonathan (v3:
https://lore.kernel.org/linux-iio/20260322115704.10b2e0d4@jic23-huawei)

"No, bindings should not depend on driver implementation." - David
(When I asked if I should  drop the hard requirement in the binding,
v6: https://lore.kernel.org/linux-iio/55e92148-b5de-4fb8-af0b-9476235341bc@=
baylibre.com/)

"From the point of view of the devicetree, it doesn't matter what the
driver does. It matters that the chip can't work without power. ;-)" -
David (v1: https://lore.kernel.org/linux-iio/d0ec6a2f-6d30-4774-8950-15dd3c=
4b020b@baylibre.com)

I'm not sure if this is the correct way to quote. But I have added the link=
s.

Thanks,
Sirat
