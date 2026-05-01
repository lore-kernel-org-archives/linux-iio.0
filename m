Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B01F32860F
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777661312; cv=pass; b=omj3nTh3DuEWFWUeZW0X1GxuXAruMi09KBzTOnnK6uLrM63P3emyfBUVxteYKJgunezp+9fj+WNPfe8L0U8/RscZMpNYzaNluQcLs8nbIF0Bp0W5Ub25KpN+pKq1rnZZ+ZEARjAz+qnNpbo3BAx36iCjaxxBlxotpuej5iAJJpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777661312; c=relaxed/simple;
	bh=O9/TrQEj4XCLdm+8Z4R+cW0ma9V73redHdr78xG9oRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8Ui4ai3YMdSWtXW6lkK7CuuLvoG8AQcnaSdn3Mm2nh4KcXpWKWyBObhDbQ5TtCoDI/cMRUGWZs6DC1K/2vFTZMmlffOmVkHYYUpMCwjfsibbAb4C1anjbhQAlwLTivDyWIbr7ayMZika1v9uKDYZxskS0MuHP7vumEBevYF1hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tN0apDBB; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tN0apDBB"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8f97c626aaso444818066b.2
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 11:48:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777661310; cv=none;
        d=google.com; s=arc-20240605;
        b=BfjUq7x+NVKs5q07lzOVGghcrSNgy5Gf/KMDpgA7IiEoaVjsZKiIba5VdNzvc8KPua
         tA9guXf358ym8cIxW3wHc6lmvBsNOtUodwvmpso7XbbQVmdml21a67cMPVFE41fJ6USI
         gNUq8RgtMsGqwwG7FJ/gqqEVr+pSOGuwUgPZVOqhp6dRZ2HRw8kC1t6nSFv3hncFyhB9
         vumGay61+u9CiKD9K5I87nV7DDWezWBryKV1Gr9W65kMwf/dtsEuJMu0sPzcJgqnLLNq
         Lfg4TY5aIBhfFHTwwdpGhRWlEUJO2UasYWQhgGQIsjI/lxI+m3ZlSAwjCUagkP06F6oN
         WBCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O9/TrQEj4XCLdm+8Z4R+cW0ma9V73redHdr78xG9oRg=;
        fh=6dOj2b4EAM2a4hFRTchm4sV5n5gaX3z1eEvx0v+W4WQ=;
        b=QUVmywRa/THlTN5FJt0ZLi1XOvc/WdFJP9NVLHQoI5T6ZHNX0QVO+K7fSDSfBiGJEB
         0ZQ/lS7KHFS2dEffperYtbWSaOs8+SQtuptpXBUIKx+q85la0kbc3fSEjsCjLv8pP8DW
         Cx3ufu0DbX0x3xs8EMHqc5rvMLGmjpfeHf9lJ5CBy63Lz/F6rgpodb6GPQ7VeDZz1sUa
         ewaxGaQg0C2sLnJXn8HnE4bIuA0mX919i/OLl+3cU59cAJTYCXO2jCKqwX//davP+gqb
         wIN9BSlKiFK7qg2BRurgUoPWi/hYuEOU+XXKnWi2+6URUluhTiB7aSxfBEJEnELx47jZ
         YTKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777661310; x=1778266110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9/TrQEj4XCLdm+8Z4R+cW0ma9V73redHdr78xG9oRg=;
        b=tN0apDBB/P5wierTnoRlXCnrZSXMEnHCzMMDttGzrF0UPNdYelqFMhvISth2hqbhqw
         Srd9hGS449SeSpeDgh4RBImkPPsziZD60PxMrw3PO1bOP4T/cUHdXniGYnnxAxld2vgT
         ck44ljtB3A1eLUp0UOszo2Vtg2vynFJh3TkkHU1LCyzeLbC0pEAv+gPa+ThrCoK78THm
         BRTHNA7wqVirU463OUILYENH8dy6en2rAMeWI09Ki3SnX8oOQCwtrAr+4GFcZ+5lXS+o
         uCL9BDZ8LzDPGgtjcB65GAKW90zyu8xWVKb8+Tdpo6bx/l3SMcDxh1uD3q2jGkafUw6j
         V7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777661310; x=1778266110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O9/TrQEj4XCLdm+8Z4R+cW0ma9V73redHdr78xG9oRg=;
        b=WBPIZEUORsa9nhRr4MpAm2kfTOXtyc8QpqcuKMat673wtXzxMHIl2E8kVxv4BxrIGk
         B1D+c00Fi0CiIZi9om5mhLW2iR+BZ8oc5OsE4YmFl/A8E2KwnT7qykRM0kg3nFprX+Hg
         0PfaxuePqwrrg5j+NTYUgYSDIFmk9tXo72wLQdGzR4racL/jjlFMODGAAklHCw2JEEPG
         ylgk9Bq4UtpQRQHl3U8gp0H2gJlOgqc49OWmgNoNc9kOObTj6NuxHBctYroBj/XcWwui
         TNkyWMNbeeXf7z7A6ISusHcsXLGjeLh9HyFZmsXrQV8TGQyvecKiGB6D383zIcgJYacL
         IBVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9zt2WjgKWJBYztKg3+XN2WsMIfD92bxIWWaPVikM8g1/GH0X/6eWCijE9e2PwcTx/NgKeIr33ieeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXdC1oW9RZNqGO7Pk7N6Y/y7zwG7nKoOroYHXXRNJ1PxzEFS4D
	GvRy3IGS27H1MaXy8tb/Pm3dMXfiyW/utmWV5ZThyghh/l1SSsMFVGqpKyVVHVcZuPTral4mwXD
	WWAKnw76SVjCyyB3/h/oe3oRGTcb0rDM=
X-Gm-Gg: AeBDievGdoniX362l4dl+HLP6tyCa/fJ0beVT6+3SYj1z1Q5dZW2gbl3xy0g6d56FZL
	fcPAm9uV5my12RhKtvclTpNuYR03Ggam7HEAn5Oiml52cExDVv8Ngn8tEFWMa70SkIMMkmKwy26
	SH1fwa1U7vtWhucPP7UwFBv8h5/Qnlpn3kADEg+Ceg8Sbmum5elT+8N6tSMnwBQqqC5PkvhzAOT
	ZrPexQGQZgrTkI+PF88EAGejZagc/lk6LwAH0m3qUK3pjojIsZpn57aFRvSA6SDAFfWZ3vhNgxC
	Tnm/GhBeSSlrcA2/sOSZq1wlmq8XXloeeBn7pPjnYkuEdIf7YHcOh61pdmucn87cZMuSKmwbyvS
	hO/triapVuwCRhlGf7Q==
X-Received: by 2002:a17:907:c312:b0:bbd:6abc:2621 with SMTP id
 a640c23a62f3a-bbffd9c9995mr12283066b.37.1777661309547; Fri, 01 May 2026
 11:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501011548.15369-1-santanarl@usp.br> <CALoEA-wzsykL5V675HFYNn-xZpuCa+XEOa-LbJ0KqrVSR=ZUnA@mail.gmail.com>
 <CALoEA-ycuys-pNg_HWZVrkoiAXVToWouS5LV0GX1UsWz5G_Mvw@mail.gmail.com>
 <CAHp75VdQuy1P=jiK9vsCVP444hUB-1aNDCtmoZK1YU9gH0yTDw@mail.gmail.com> <CALoEA-yX+NoGF2-9dB9_+LV2YPCN3LskdR_hWBPeBbbO8bJAwA@mail.gmail.com>
In-Reply-To: <CALoEA-yX+NoGF2-9dB9_+LV2YPCN3LskdR_hWBPeBbbO8bJAwA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 May 2026 21:47:52 +0300
X-Gm-Features: AVHnY4J5g1i0oX42ukZrmyXZT0XTsF_nV7Vflr_Yp4ygCvMHLGi9YRh3b1MDrmE
Message-ID: <CAHp75VepGeiSJCJ_AuA22bJ4iQo+3bGhjLPA7=O2cFwfrGGAnw@mail.gmail.com>
Subject: Re: [PATCH] Replace manual bitfield manipulations with field_get
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Rafael Lopes Santana <santanarl@usp.br>, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 9:41=E2=80=AFPM Joshua Crofts <joshua.crofts1@gmail.=
com> wrote:
>
> On Fri, 1 May 2026 at 20:18, Andy Shevchenko <andy.shevchenko@gmail.com> =
wrote:
> > I am not sure I follow this. Too many parentheses is not a C language
> > style. It's not LISP, and we only do unneeded parentheses for the
> > cases where it's not immediately obvious by operator precedence.
>
> This is not a case of operator precedence, I meant it as if you
> mention a macro that takes a parameter in the commit message,
> it should be styled as MACRO_NAME(), at least that's what I
> interpreted from previous code reviews. (same goes for functions -
> function_name()). More of a nitpick though.

I see, I meant the parentheses in the real code. There are too many of
them after conversion to field_get().


--=20
With Best Regards,
Andy Shevchenko
