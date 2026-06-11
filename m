Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965E7346FA0
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781180625; cv=pass; b=Mz9bWQo9EcPxsqjqN353JuP+NZozt+X0TsizJ1xdFoZU5vQKhkTQGEsmkcUJgFHfgykzDk3iDQ38FnQNMVMMttGFkSEqa8WZvr6v9L31P8pieWsq5z4rKluv2yREtJP23WM/oc92ZmmpiiNIMXOEJckqC9PCT5M1he7/bZAdLZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781180625; c=relaxed/simple;
	bh=USzxsT/rGuBT80iTTvsaf5Z0QIstt3wY0fzNpEQe2y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2+UhnDtJI5aou9jsclBJ4qS4RkhrJcylu2MXvBgwUeG4uppDo94PEwboh2EMrjtMIBiIlMN4b9eWbdHTmWdR2etZ25FgMsK9xoMY6O1l11PkQBKiPn/7lKZL6hhOMNqgCj/W332gEt82Z9PQa+4f7EGt7z0kDw99kLlm1dH8b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/F0mnHP; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/F0mnHP"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6604176b575so7334780d50.1
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 05:23:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781180623; cv=none;
        d=google.com; s=arc-20240605;
        b=gTUnWU2764UGXonKVvyGG5QGX0GmTObQbD3YB8zThhO1cZwcGpuXqrlHjuFkBtZoi5
         fRC0obVBjj8OWw2yCg+V8vOmN/D0agAPn+z/R5Dd+LLiQzzW//u9VTHna9+e7OecjQCT
         9F4Cvso35AlSmtcYP3ud+wa6PLAI8GuVGRVayIIqFO9WTyPV9L36YgDjXAQsDvq4E/y7
         7AjyrH3qn7rsiHczRVO2/e3e1+9yhDYFTTbzD8SE3g3pM5aNwQrWQo3bVXP3Ap31T042
         mE0kxrPNUREEqIVJq6KqFEIwKQYz6IvKqszbTrABwJhEjoXIEo3P6/SLLhFDY1rKNw7z
         iswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=USzxsT/rGuBT80iTTvsaf5Z0QIstt3wY0fzNpEQe2y0=;
        fh=8DtKz8HBhlQaY2Npv37PYOzr5e2UIA2voKxY7gDDFZI=;
        b=Ibaa+xeiaSxE9Sr/t0OTM6w91OHYIDV5/YP9UPahdT+RvJYvlX9vSYdBg7MC6n7sMY
         dPEQ0f4GzlT1yqpV3DFJLm5dgf3kU9cnxG6PjfkUTCkxjLyGEfINsXZR9hGNOM3O9SsV
         s9uZ/0B/VjmjR9H9lMfDt1uHwRcvA2APYAUzXtSCmMo90pf3rbXl2U+LnDa7P3msYFMz
         +MXLv5uDHwggNztn4RwhNMCye3yL9qY9Y0qAOy/OsCvgoVJjNHnDb6HxQQtad9HtBHZ+
         AmXOhNmuORPHcebbUbbeJrUJzlLDIz0B5fwNXSI5c4RE3Ulfidlfz0oSA4mcJpIxWswx
         aClg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781180623; x=1781785423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USzxsT/rGuBT80iTTvsaf5Z0QIstt3wY0fzNpEQe2y0=;
        b=W/F0mnHPeYeZox/rEXxmJsxxi1Hzt1EsQeg6Aj3nYCrUZPcxYosmLGdihHnpXPBasT
         C0+g9X/x8CXzg0xIHJHolZNnOoY5DPHQ5b+5hqQMHw3kAuZkZGZ+yNjz6vAsXjFnG1Xg
         xaPfv79nd3JUM2R76a7WQFsr5MzfBKittrNTDPfMwc7S6Rhua1cgBsfB2Mi+D4M3xGdo
         X6wS43/wZ9Gnv1izHeoMMEdPDmOPx5Ltt0X+WelpxWRwhSoFvnFxBv4LrpTOtPPyQ6H7
         yvbAkm0mg4PEWoRq1tWCCBLsw2MQOCmuKAnk0oc/MRZPR6duxwo3VzbeySjuR4Vs4LE3
         HS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781180623; x=1781785423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=USzxsT/rGuBT80iTTvsaf5Z0QIstt3wY0fzNpEQe2y0=;
        b=c2zA9LKAhcmxD2HsGeTcAwR5abs1OMiumMZQs6t6ZY5Mrr/3rN2D1pcgOeoN11TE/W
         cZcBrQuv+b9XvGx9WI7dAkmfTm52pradH9BGqUjMevLZ6fjU7eYYsbZBSZrrqEhmb3Nh
         SDWCbMn6Gh21O8YP8jd+Khk8A4SrT6z0PmF+s6fLHyPxaDwy1XxDqCBeUv55eN2tFjFt
         IH2AJ6vrLBrgn2zqyZrCTedZtiUmoqQ1RTyW0roE7RRiAkM0O+qfTpTeCqGS0WMaV9+k
         +pFvfOmLOISatK4+E6NYCuT5XLVR+OFXM3qyq5g/b9cfmq+kjYQjP83WIAdyfeuKDsv6
         XlTg==
X-Forwarded-Encrypted: i=1; AFNElJ+U0urzmGJnJ2CBjWAHtBjf78V3/1/iDQQCKTPm2eC3JSnT/b7n4QWhHHzLbgWofDHuA/x9P5OmyZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd62QSLYlHaRrXeFZn9S/DmXLPzP3zuCa5TyHvK2ROwUhpphXv
	MNoNRYCSQyqhKdJGsjuDCoLuAnupiQFuobWNczUQk4Hi+3qrvNInuKLDTdyol061WxXYa3tDEGB
	48V8JvjKdLvkGlJFxBsVEuNZFcBFSIGk=
X-Gm-Gg: Acq92OFtAntc+oShdIw0DXNm0nJR7BcM7rboomdP7SsXk+zkbSysa5elJLC6lutuEf/
	jXGu6/xcVEI+8oolH8j3y6Y+/hlEnfeqD+4E+wsQQA/ZYErp+sbMn+Xwo/pwQHlzFfJaIQzyITk
	g4eYC1EyZVbaXsqTzdKDTO5R/W+fT1SRKJeE7TCE+qDi9N12gtrV2HkYZV+zA5479vHsZ2HOZc0
	k7H3vHhq5zHye5lxottRD9zeeLhbZHSis9hY7MxFEe4e7hkNTSGjWRqpnuH0CLAz/fX/Do5gvjJ
	rdOKs6etpy8cAIkpRHDSMWHD3wIVBBkVVZ+iwuXqIavKKC7WlQotXW1NfclBl7Q=
X-Received: by 2002:a53:ac92:0:b0:658:e645:7736 with SMTP id
 956f58d0204a3-662698670a6mr2191068d50.39.1781180623358; Thu, 11 Jun 2026
 05:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609160326.45123-1-m32285159@gmail.com> <20260609160326.45123-3-m32285159@gmail.com>
 <20260610-pastoral-dark-ostrich-5ca3f6@quoll> <CAKqfh0Hi8EkShh3s4dUqAJRDExQLR0NVOvd4An+bY5hat4-Lhw@mail.gmail.com>
 <e00caff5-55e4-428f-bc57-3885699b221c@kernel.org> <aipatjyVcltbspRJ@ashevche-desk.local>
 <6c5a657b-f316-4982-8cb8-8c09f1b1669a@kernel.org> <aipfPwT4RJGdA4TT@ashevche-desk.local>
 <aipfxL3ttO1-7W1T@ashevche-desk.local>
In-Reply-To: <aipfxL3ttO1-7W1T@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Thu, 11 Jun 2026 07:24:16 -0500
X-Gm-Features: AVVi8Ccz6yEXC5qaHOYCTp6OBFq_A0v0VfBI7K5RpHEHuZOGWBTkca5pd6-Gp60
Message-ID: <CAKqfh0FQb6tSZrrTHGWcoQqPe-OwD-mW02GOOn9y+ysstRPVzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Add myself as maintainer for PMS7003
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Tomasz Duszynski <tduszyns@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 2:12=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Jun 11, 2026 at 10:09:57AM +0300, Andy Shevchenko wrote:
> > On Thu, Jun 11, 2026 at 08:58:47AM +0200, Krzysztof Kozlowski wrote:
> > > On 11/06/2026 08:50, Andy Shevchenko wrote:
> > > > On Thu, Jun 11, 2026 at 08:37:33AM +0200, Krzysztof Kozlowski wrote=
:
> > > >> On 11/06/2026 00:24, Maxwell Doose wrote:
> > > >>> On Wed, Jun 10, 2026 at 4:09=E2=80=AFAM Krzysztof Kozlowski <krzk=
@kernel.org> wrote:
> > > >>>> On Tue, Jun 09, 2026 at 11:03:26AM -0500, Maxwell Doose wrote:
> > > >>>>> Tomasz's entry is no longer valid, as he is not active anymore.=
 Add
> > > >>>>
> > > >>>> Why is not longer valid? I see activity in Feb...
> > > >>>
> > > >>> Strange. According to git log --author=3D"Tomasz Duszynski" last =
commit
> > > >>> I have from him is 2023. We also did have an RFC open for a month=
 on
> > > >>> linux-iio with Tomasz Cced with no response.
> > > >>
> > > >> So you did not check enough... and no one needs to read RFC :/
> > > >
> > > > Hmm... lore.kernel.org shows last activity November last year (07-1=
1-2025).
> > > > What other sources do you suggest to check?
> > >
> > > No, only lore.
> >
> > I used this request:
> > https://lore.kernel.org/all/?q=3Df%3A%22Tomasz+Duszynski%22
> >
> > > As I said, February this year.
> > >
> > > https://lore.kernel.org/all/CAObtm8zKUAWNS23nRMhc9ZR-zn7xeVOFPiV4ai_x=
7Bkd5puiyA@mail.gmail.com/
> >
> > Okay, you used UTF-8 name, Where did you get it from? MAINTAINERS has n=
o
> > diacritics.
>
> OTOH, you may have used simply email approach. With
> https://lore.kernel.org/all/?q=3Df%3Atduszyns%40gmail.com
> I got it as well.

Ok, now I see it. I will say though that we've emailed Tomasz at least
10 times at this point for various things and hasn't responded to even
one :/ if we need to we can allow Jonathan to chime in.
