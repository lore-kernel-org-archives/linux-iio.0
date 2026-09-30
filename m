Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FF538944D
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790787865; cv=pass; b=W2o/ynOa44rRlX6P7Lf16VOTN7a1pYkmaHSw7ylEncFTxegCssda8iyFTp6bPyM/ETOIRM93QVqVyR7bGGjnzYluoMZ64F0Iupd9C1BvjuA36DfTL/0JBwahPVcDlAqF++9p/gjvEXr3ECRxM/y3lkAz4qcujIKo4shVDlrPbjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790787865; c=relaxed/simple;
	bh=YPB0OuzgSu6bYeqdbKJsDvFZ0QIOxvCezfQ72jpnedE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3B+OBGP7vUx8bzZ8ZCBApX30cr4QMB7XxofbVb+VS5u30nwZSjAc5ewZhp6QWvJiAzr5BQkR++kUjQEqpUSkkm0mnpNPBBSLr/6ClWwMKI+mkUg3lqIvJOFF+mSWO59VyarQiEUbxk2xfc3IZ71DZRuWvX20wvNWpYleiK81Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivTyT5JU; arc=pass smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivTyT5JU"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48884b0219bso3026495f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 10:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790787863; cv=none;
        d=google.com; s=arc-20260327;
        b=DZqXQRwUlMJjxpJR4Fpi9pBOgyspecqJO2fa6+QDIMRSKsAFExqEPzVjERtJMtM/1s
         orXoDsh5tnbBvcdA4qbhMjuVVoGEHIEtHoSnX/Ws57/sYUOBQNWL0HbooTDSCcU3ov2T
         ga30lebyhFsvyfiBxWxgYg3SZF01Ezo/d8XEzFe+NSBu17inH+31fHCO7tpEBoy5STHj
         Y8BSrDPLe02QDEgbfe5fuputO+Yd07woOknCueDJJckgD7PG/w+kqZX5XVSS6sRzynUX
         GmirdIk4UvH+uhAUwmatB/aKoYPry+J6KSuvYT929XoGCeIaysf4N1iKNtPptjTHOsEk
         SScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zbCTMDLKH8sxYxpZqqOg0zEN33xQKgj6205FhZee8H4=;
        fh=wZNlQbYyw9IxZb/CxL6I3tI1m+yaGzuvB64jLHWwyCM=;
        b=azO20yoy4Pbj0AggLbK1R4YrQrgxByqIgLKrnUQXdnpfZLeKaNeHbr0JYDzybIbAGN
         7W+wDQ4tdqYo3P/q3FtU/RbilXCiCKQozDuoveF+BBrg+waoAkB8fOgvRkRYb+r9kLIk
         boFQyVQVBhmS8Ag4xEbTG5qgsW31/C6b5v2UBynX/VbnGFjmSuUMMysgyl23qMbmJdwP
         Y5QWrOFmTlf3BpNtWeXqMyXsKZ+VpO1ok0Gx9fX/avhOmHbNawqjQ5NK2NQ/UPV/gmy6
         a2TEPB36N91xgyopJ+j64TCKXc7kZwdRkmDOVNd0IIZr63J2DpvsSRijxzSxdTOqpzmi
         qjtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790787863; x=1791392663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zbCTMDLKH8sxYxpZqqOg0zEN33xQKgj6205FhZee8H4=;
        b=ivTyT5JUHKeGqQuEuNbfdAGYblvHXNS4/cO+fgAoTGcyxuty/wgF03oAUMwj1lM80i
         lp0f/IBpZKvT2slcDmaOsfl6LAoSc19DgvJlOJRXn+OQukYfFWu1BlJ5BVCNd3ImmpPc
         eBKqB95iAqIn7eWFOAoQxmZG7v4Y3fvy7vllRxa7mfnOORdW6rbHcVmuI0qVx96C5efk
         HvrKNEKcYn9yTYyFKSgMWj/sf0T2+Cf8L0WFXC7pYWmf85Hu3ttNEybGwuxhu1q4nDFm
         Z4JJskBc9pGj38DTriJuzMWfv1K2RkxK8kfCthViHRDvkGP3q8iODb4iJ0Y5XAco1fcX
         QfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790787863; x=1791392663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zbCTMDLKH8sxYxpZqqOg0zEN33xQKgj6205FhZee8H4=;
        b=WYSGO0aRlijLkmeLtW4xmGrzGCYV+FruPwvedXIXiuk6/Wt9rKTSL7PC3FcGeHLPWk
         LuUSFVsVH8lUzMujPdru8+VEivKwZVHD74sTPINo3MZDl5GRljGCrY3VwZWXST8NWgU8
         kOgX1Qs2cP71cscqVobTq/oPoaJ5Z5gwv/N9EQp/cAsQdwl12MzUqTVqaSKPb7xauP8c
         QeB2CHY3zd6weFh2IblipOHFQ15iq8MZ2oR7tUELndVgwzn0H9Vy6JBElCdETi74UH+6
         4l6osS4VsZCPKDG871Sw905g3j2rgLlH1eu44b0VFJNPfFjwCX8vBOkCKZqxIZQSDc7/
         da0A==
X-Forwarded-Encrypted: i=1; AKwUvBxIbo49be17Vk2OQi89D0JU3mIOnk4GLNAJuehl1RjrpjmCsdEmnEols91W8VK8+OEYg55rzpOWoAg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLY5xcNolPeNqU/R2CB+SGhet82fhUcRfdULdxxhzumQmxEB/sy
	WPvhgXquNYP9Klit9HThP+C1f+z7T26za7Ov19UhpvAjAm+Bz5DGX+OaGPEl9WcDosypoh4CFmk
	BNQRJ/Xh3ihLPbYc4JopwMhbSnsm0TNk=
X-Gm-Gg: AYBFou1w9WM5Gjk07hwGE+S7RTvcwhcNDQn94yGJa/kF4pqGTaoPDwA0mRECqrDP4YU
	OXV+pNcaJjlD58LrWQHIVjCGs+bYqdXAz/8cELKvZSV/cy3ALPuSDFpNlFbb5xq4crdRR3DEUvL
	Po8jcFWj15LndeA1jLxb3rhcmwy78w75kcBre0Q3igCJtD+C5ag4phBiwYKXRGEVhi+qq8K5hZQ
	7xYpdwXt+7cuC8By1AFTf4qchcv8YN/Tql9eqkyoulV+AEI+JUbJwtbnyWh7Bud+f131/ZKfP8W
	UDGXefVAV3fQYQx78b4aeJnzQX7ePhRzZwpa3uj6Xf0oavOFPvlQO7zl8aoBoLSDPmP4OuXr05i
	xm9Pt/iUN6PN/Uhw7Egl0ytGwckllctoM1hXVyE2zVVzspu2r9pyNPIecZwncUwuCoX6vPzR2Gb
	I=
X-Received: by 2002:a05:6000:4283:b0:487:106f:ee31 with SMTP id
 ffacd0b85a97d-48b02524089mr4421323f8f.27.1790787862365; Wed, 30 Sep 2026
 10:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929124248.237032-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260929124248.237032-8-prabhakar.mahadev-lad.rj@bp.renesas.com> <arzWMViKacekCSdS@ashevche-desk.local>
In-Reply-To: <arzWMViKacekCSdS@ashevche-desk.local>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 30 Sep 2026 18:03:56 +0100
X-Gm-Features: AclHuK9LOI7GwX6WVy-CRezdreahkEzOs_5YWlyyazInLnkw8984BuD6XWEzDWY
Message-ID: <CA+V-a8swr65n3hnGA_a2L-uGfLbzAKeQ3TqddjcyC+iWF52Vgg@mail.gmail.com>
Subject: Re: [PATCH 7/8] iio: adc: rzt2h: Use scan type for ADC scale
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

On Wed, Sep 30, 2026 at 10:28=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Sep 29, 2026 at 01:42:47PM +0100, Prabhakar wrote:
>
> > Prepare the driver for RZ/V2H(P) support, where the ADC supports both
> > 12-bit and 8-bit conversion resolutions.
> >
> > Use the current IIO scan type to determine the ADC resolution when
> > reporting the scale instead of assuming a fixed 12-bit resolution.
>
> ...
>
> > +#define RZT2H_ADC_VREF_MV            1800
>
> _mV (yes, as it's called officially for millivolts).
>
Ok, I will rename the macro.

Cheers,
Prabhakar
