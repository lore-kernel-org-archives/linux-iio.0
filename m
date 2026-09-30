Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C315158BF
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790786746; cv=pass; b=CbqXOoRzQkpgbcqiE9uIG+MOPPwfolvpGj9uU6VgA1M1PxmQW1IA0ZnRLUi9CXPi4hZ6RgFG1cR1nNfgRTMwzmgdN+VOFe7Vx1GErEoWKPOknn+WVN4a18JGDNyQqbk/2qZ3d2BpG7TBLI25DWG/aFW5xc9Nps4NTWK+3V5IgPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790786746; c=relaxed/simple;
	bh=bhyLwLX3Cbs39RNIdfvjdkMauqLBTv5+SoflpxyeT3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mw0wMeNAyxcRCtB58bNA+GI2NaHJdWYU4Ng8HvF198wT2Ih/aGxVm8oTJPrI4lpAyyPhYSGndbFmg+VIIlWn3sZzYgcQ1nRtdPvbrWVMRzVKEzXmDohpW7eVIXTLA4RDlbEn1CdOx2RwcnCvsqFubD3Aokz3ZCeJyfFhN3T4/rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knt9JlSv; arc=pass smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knt9JlSv"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48af5ae31d8so1756968f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 09:45:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790786742; cv=none;
        d=google.com; s=arc-20260327;
        b=RS+VUO/si7wqMyd4BfRE87F3Oumjvg3yIuRyk9omuPYWQBcGg+YyzWoDuxojUekhl3
         3D/GXk5O7fX3tdhfsSS21wFogSxhCy/RxLhamz8G+SiccsIW9PKBcHxESEagqTjoUQNQ
         mC1MptHe2XbHy98lGazcBclr0NA3dhnPHfpVLQ/9KISD3IGJP6V5ViRvrqlhKoFlbWEn
         tHKgD98uPDd8nuKbXm5pBy9JBgYWpD6X28vuW+YgSY5WoKYHFqCui5lp4a9Tq6HTwKkP
         jf2mtkej2aqdbIUqZ5En7fSILIW62j/SXeWVBNglQgqeOq9YL87YoVXYTCIYt1Xgrxxt
         Eh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0qr/Ipxr22SFcNZfSu174bMZPRwg/L3HUY1rLAYBi7I=;
        fh=6F9BblZXn55klU6Su5RXSdNd1P7mW4O3Jjj74WNXSKQ=;
        b=ez6llFRHPeu+nIVVs8l/khhp7RrLWz82DHcvehbf31cOE0/9Kc9Gau1duTmKkF1tfx
         RbACTJjnZVlY2aj2cdvvLvgjsvsgPQcLCMpm+GV6TjX2AHC4bc3OcpCVxExs7mO89DsJ
         CcnLBNFk5JTt8SRqLzC8aq+McIry3jFLAf0e7e/LVXfShAXu27B+nPW0kCKzesrGVCcw
         AS1VTHlLlspAMwpsdXJ+B2DGCoNuDbGvmdFNU15liAXbiF684z1LkuS7hvMYc6LTSXjh
         ii2FY1777uclHTj65albQpai6aeKI1wFMMv3tyu+7Ce7BQ9VS2japsP3XrnVQsDxVDZw
         D10g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790786742; x=1791391542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0qr/Ipxr22SFcNZfSu174bMZPRwg/L3HUY1rLAYBi7I=;
        b=knt9JlSvHA/ihsQPnXC8Pto5tXIsmr4YXVA0pm0Xeq04GwRzp6MsVZB+aY/hHa2h0B
         yoUINlKRc7bS70qcFZbuxmrJdB6q5eXGOikRuXFhxbpGHqoJhTwLYYEF1UHagKwG0gXy
         smgn3xzTfk8D7fH3T3hp0/0ZP/6h+q4/t/IOMcqsEqYs+Kt7j6W7oyp1RV3y3BIPeQfv
         ExJZWrWTNyXvM4UOF/MrFQMgRTZglQSFgAR+ipYkC4v1+FyStGbHL49dSKF3GNXc8TZp
         XHHNx7oxo1GNGTpT8zQi/WQk9KXrCuLD885xnE5/KnF3WygGxo8SMqjrgsi/S4AjuqUC
         8rSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790786742; x=1791391542;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0qr/Ipxr22SFcNZfSu174bMZPRwg/L3HUY1rLAYBi7I=;
        b=fI0cwT66Z8t6VTqOIKu9UCF1p5obMDZ66Rrx9u/TVyqcPG5rCoNj5OLSXeH8U0xJrV
         sDJVyX3wwr3E8hlH/Aybv3mJdlZPHxmHsPlQoraZjdeGOy8aRR3K3M2Iwrros4m24/U/
         Nm48XKlgyPygxYuM8fm5AkfRTWobNxBDrSLg3XGdliKK6fGICBAQQKkJrAdE4zsGcP0v
         FMGFFJpZRSDVQ3EMTN3ZB9P7LO9nBWVHMA1iFG58GEiqF2htFGQ6E1SO5+zivtCU7OhM
         PL9pl8Wc1BAVUxjKmVFjo7f22ltM1kxJSOWretA3y0Avn4xSZ/uEGpwFGWr0am/ZfBZX
         siSw==
X-Forwarded-Encrypted: i=1; AKwUvBzWDqd5viCkmIHmxYJ3FlaetQufYUP5QaQUNX+r/Up6Vc0Al/s7NS/5RHHc+E4eYv05oD4Ge4E9dyM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdJmKsz/5NQ46oy5T1Y0nQGl45yuLVakJqIn9loKL+7qpWSyzY
	HJ3Y32Im8XJAbA9I/rU0cBoovhHVbiXTvYwggea1iFaDvQd8j/xMw9SO+O2E4+U5uOltkiJm20G
	ItOwwwK6inw2ha5RLkdroon32F8feCk8=
X-Gm-Gg: AYBFou09xkMIfFzKIvP0ajRE+Wf62D08F5M4JwIHpK8K41PAb2TLCaqm2yprKT7z5QD
	pgOlSIqn+1dEMgncX57dKr0B6ofXKUQ7+p82mS7F6QvydTkmIh/f5+LtzN43Ghoj22oDQxWL4+E
	rYOl0nnOyzx3HdXyqiT1zUKQoljvWCYs9pjY2MLaeusfVYdUj1/ukp2sEtJTwGDdQkB/IURDL2G
	384J+Hj4eDdo/wjIj3ecYNK5nNLgcfaRp+Lj9iBS9C3dSSuaNa1OKohq4HY4IcFabH0vKy1Ltj5
	4gmmpafC4/MqmPbdUeX06AsfSsOzbgcYOs0C3L/xa4iEBHCVD56ar0mx1e6DeLr7vCAVIh3OZCT
	nX3coWFoxLQiBHgGDnMky0RzPscgvsKp3U8fuHYGBieoptNebMODUzbvf/Vzhm30PuDb8FF/Tsw
	==
X-Received: by 2002:a05:6000:4a01:b0:48a:f36d:fb57 with SMTP id
 ffacd0b85a97d-48b024ea6cfmr4110706f8f.18.1790786742198; Wed, 30 Sep 2026
 09:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929124248.237032-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260929124248.237032-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <arzVHnMtKqQx5rdZ@ashevche-desk.local>
In-Reply-To: <arzVHnMtKqQx5rdZ@ashevche-desk.local>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 30 Sep 2026 17:45:15 +0100
X-Gm-Features: AclHuK9DK0fHm8pKCkWA6Zd6bNeQSmhN0p4rElp5jeZV36-WUljPpymXoO3Fm8M
Message-ID: <CA+V-a8sgRHDbJqnp6_-0NO8V5f-J96ZtdC698-2n0Z7n71x5qg@mail.gmail.com>
Subject: Re: [PATCH 2/8] iio: adc: rzt2h: Wait for the analog part to stop
 after a forced stop
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Prabhakar <prabhakar.csengg+renesas@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Thank you for the review.

On Wed, Sep 30, 2026 at 10:24=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Sep 29, 2026 at 01:42:42PM +0100, Prabhakar wrote:
>
> > When ADCSR.ADST is cleared to forcibly stop a conversion, the analog pa=
rt
> > of the A/D converter can take up to 2 ADCLK cycles to stop operating.
> >
> > Wait for the write to ADCSR to complete and allow the analog part to st=
op
> > before reconfiguring or restarting the converter.
>
> ...
>
> > +     /*
> > +      * When a conversion is forcibly stopped, the analog part of the =
A/D
> > +      * converter takes up to 2 ADCLK cycles to stop operating.
> > +      */
> > +     ndelay(DIV_ROUND_UP_ULL((u64)RZT2H_ADC_STOP_CYCLES * NSEC_PER_SEC=
,
> > +                             adc->adclk_rate));
>
> I do not see the point in having _ULL (64-bit) division. Do you?
>
Agreed, I will make use of DIV_ROUND_UP() instead.

Cheers,
Prabhakar
