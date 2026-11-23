Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795461017;
	b=QXtx1+zdgYZ40z+sIiaWaNauUVKm9n/0O8vwvVMIaPoSTsy+bfrQaomDjxBB0kOpdnu+
	 bSTjKV1ME4OpIfxC9B5Y9X310Km3oWw0ogUJkPwhDo4cz6vXwg0GAPd8gZaG7By3LHBWD
	 ZxRNC0HBVeeM3ykGCKh9QzYH5SFPzqBHpA74An+EVV+ExouJBA++HVqb7Y0eJCdbhEMDE
	 Cc6Ra1jMuD5iVKPE4e894RkXN7ZFGrWppakJkoMvjOrKKs+bsrM8MPd/H9galGhp51ig2
	 sL6TBENIPQvmIthR5ab5a61aZd8BdA44vrB0OGgbhffx9347q+QqfG//99nYUatiHIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SN2t5kKUSYT0EN3bMFCno8MHopz+s/PrHUa4yUTEFts=;
	b=UNXAMDr23gHenMX2isNFnaLzLdqLyNzEGk9Y8dpvTdgAxK2hSAY+ufwXVYxngb7KTkNW
	 U9Zl3hieDdhmvOqE5IOukecgo/y/nV3c6YcLhX6JmM8P2SxbVAnyp4pIg4mSmeOrf+Y+4
	 jt2f8S/9OG4j756MKdWAY2TvCQAtlau9IIik38Hs6NFxTgNEuLYFv6NZvI85/gohOLksl
	 IMohq1CwHqesQfZgxJ9yb1tw7qPj/9xmeH4M6uv5AaSV63GaluhNhkQHUWx8vLegEs/mI
	 t1lgRW1jQtvbw1i66S14NgJUwAXdyN9eJIPoFEVt/K9kB6mFhZuF4v78f3q81T1DUJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="YByzpS/O";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765BB606A685
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 19:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 765BB606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YByzpS/O
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-38587f3de36so4414940eec.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 11:10:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795461016; cv=none;
        d=google.com; s=arc-20260327;
        b=d9AKzpn9y7Sg5e/GTZcw3x2ipu31Uf/POi73hE6wuKtT75EYTrv+hLXAGvSpnxs3oj
         SIcxTIvqgVe4E/kchAE6R0qPwaYAuDDiDraxVutnpcGvKDBdPc6PJNHYSGyJIkNccLp9
         9ZsaWvKbWvzsqMeaV2cvXHLOvKhjbEG683AWGlN+MCCKTWsl5Yps2NUXfRuFdymkfSmt
         8H2y/H6IVD3nX1SsYbOlpzNVzCS2A4VJMaUX5IkymyMKbs8W3AMXAbATCCRzjBXgCvvs
         KcKFiuRgGd2C8gEHXPiJsIXxCN/EwY51Lr58Uyh0BR77Tzr+b0f28aZnlo12C1mmwRKs
         p91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SN2t5kKUSYT0EN3bMFCno8MHopz+s/PrHUa4yUTEFts=;
        fh=bTlc2lo58Tu60Gbr/oCMnf2dRokTrdo9rEDA3m8TJLc=;
        b=bLKHLMS7Qj9kavkiVfno5pCJ9M1mfwje9N53Cl9ymwZ2VtwkNUIzY1J2gghct9g4Xf
         CQNrc3RrOSQdha47A13RFNTfoQBisGPHpzkTVd4mO4FuODmDJq03z8bUK7cCA/u8LdvC
         REp2Y08HPtq0eOIOEcPLKYbiNuCGFj/vhsK/gPRgN/hQaw0ohEWesUa5gnir/BnUu9Q9
         sZ6Du6nPKQzrLTWs4W0uNzOn/tIZx2JM6X5XNGEA91GLrxxVS7fU0Kve7NMLNOlP2WQv
         qccVWleOarGVu6qoDdYb3L0qDXyc/U3iQvEJgSt3LG9FSoHD7Nz0QOQoMwIlWYKbmMgq
         LkwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795461016; x=1796065816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SN2t5kKUSYT0EN3bMFCno8MHopz+s/PrHUa4yUTEFts=;
        b=YByzpS/OYf79mWwg8ZXz5g2gqNsa9mjTwv1Lgx2QaXdA8HmmpnkqNCmWYyZaCE5AaC
         N3Hb7phIk8xVuDn2j/lz2KKbN7zl60AGlg+WWvB1iCZioHgqNNmkwpkqNzY9FqWsqGxY
         7mBP+xOqWG0whyqBo9V7vOtiYqL5nJMACdcIyAery82/JonullVJESxQRfrUC3+UcGUN
         2jkXNHmDhr5TbTkBq3bfcqrgMwzYTN9Um2UhbD/k6SFe4aIi2YMy8/xHbR3hqQ0ULGo7
         mEAxAIQwGP8MikFwoKNIjGt8ISPeARNxrdTy6F9+HZoqpQ2prTD38KLbxyZhr1OAk+IO
         UaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795461016; x=1796065816;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SN2t5kKUSYT0EN3bMFCno8MHopz+s/PrHUa4yUTEFts=;
        b=zChGKQp0RM+Vn6bPf9NPgIOD2YWOMmApEC+O3o3QDCowkedqUQ4/Om9oZZN48wh/aw
         nLvAo/PvmJdsFRiQ2gtDivyVBiT4nwIoxj/qZluxjmQc0s+H2ZC21thW8fPZJGkGmW9b
         VPE12xIbI0g6DA0pEFj4zbCyGxsx+n2kPTHaslJ/zscNiZnu43H30mzbW0TRLaCnRv9w
         iTjnLv+515x+tt/jlNWBiJdhtHPTI9NJ+aKVYxh900TBM0bxe/ilT4ep/9NKgEIXbdxY
         x636LhctRdRk8SDK7FcPE5z+4iJAKAQiIPSI5O2YEqZLWyTN4HDJo3xSoDp2yQ+WmHYC
         PR1w==
X-Forwarded-Encrypted: i=1; AL+hErGNBnEjMmsHXrnJDi1mPffe4d6mQD8jjCezrB+zyVOPdArjbap86CnkBXUgNRd2vgPrGR8qORzi3dY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8bwDLhGvVD/hvnv8R7gpbSC/LWNitk9C9NeNI0YbDG88NSm03i
	21/E2Q9TeTvFNb73lKwRh0Dc7tF9+6IHimsR40SAeCB5ndCo/HRB3rPTza8jcT02oYNJ+++kgSN
	5uM+9DAn/CMTRaR/LoS782RSb+xMbarU=
X-Gm-Gg: AZFdTZe/z+geRsC37j0KInXiiWjcPiaKY9QllRm3CCUH+/7aWPm4OZ1PMG8Joww1IGG
	JvC2m5NNL0QNBlpChPDtbuuMwceR7NQxfYVyyeOKx+qnBSuBUUk6zV3QvaDm0kTLU91zy1EFpPZ
	RmMFPiXnh5U0Wafv+x1Sp/ccaVV9NEn4hMExBPRMA97r+pbIXcOHUTwfDFFM/75h+VdqSDh0SCC
	0vA3IffEM53adf2KbHAR8HM3HCVk78fCMGdWEQCyo2z4+vHKBx/sRK4MFuxTA/3wjC+81a8Rd0D
	rx0jyVk9ibKNrf5hfuh0cUXm1xLA9n4xZmNzexPxQJdQ5BX/PQf+I3T3hhHGTVgW0XKTrtoGZb4
	2OyxFG2wvW+fhVqEz7KUr/gY1Zh7VaFXbqxDWSabDRIzJqVqX0gb9cm4yrM4fICoq0Wr+MnsLv/
	y/Yuofdi3ItBnCKcNOhABTl1K87ikdOg==
X-Received: by 2002:a05:693c:87d1:20b0:386:a816:ca16 with SMTP id
 5a478bee46e88-386a816ce29mr5178321eec.15.1795461016480; Mon, 23 Nov 2026
 11:10:16 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123150725.212836-1-clamor95@gmail.com> <20261123150725.212836-3-clamor95@gmail.com>
 <awSLzG6IxXjKLBCx@ashevche-desk.local>
In-Reply-To: <awSLzG6IxXjKLBCx@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 23 Nov 2026 21:10:05 +0200
X-Gm-Features: Aa3M54qd0Q0FdKFQ-JpohuyS51xXnBrzclr62AhndFD0zExmhfAz7QgWmQX6nVQ
Message-ID: <CAPVz0n3Mm+GdsS_P7Yc98FVKOijXFzWocVCkzUhg+LPJ8dY+4g@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mfd: max8907: Add ADC client support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, mfd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 23 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 20:5=
4 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Nov 23, 2026 at 05:07:23PM +0200, Svyatoslav Ryhel wrote:
> > The Maxim MAX8907 has an 8-channel ADC at a fixed location. Add client
> > support for it along with its regmap and interrupts.
>
> ...
>
> > +static const struct regmap_irq max8907_adc_irqs[] =3D {
> > +     { .reg_offset =3D 0, .mask =3D BIT(0), },
> > +     { .reg_offset =3D 0, .mask =3D BIT(1), },
>
> When {} on the same line, the inner trailing comma is not needed (if we e=
ver
> need to extend this we would need to change a line anyway, so there is no
> benefit of having a trailing comma).
>
> If it's just this, no need to resend. Just a hint for the future.
>

Thank you, I must have overlooked.

> > +};
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
