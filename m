Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F202412C03
	for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441731; cv=none; b=mzPe1S4HDahkhTISeewwb2MHYlUPG86sgZDLX4kAkVT6R8ARd+13oSwpf9FyseHkrLNjtmb0/7/+7bgaarsNwfjAsf0Dxgaq1WgBqIRtl/ttak1Epv5lD4+QjOeiZolvZNNYNa/enxWmHsnXgfecDkH30ZvDl+zWKNcEcefz9OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441731; c=relaxed/simple;
	bh=gy976lH9zUQLHYmMnEBCphjLCeBoKGQK83hMJSRXzGs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kLklNGBcK0+A1/IpbTY0s4Ur9H0fVYVc7AnZN5WR1Qn2EQlO00b2w/XWw8XR0ZvjtY9ERnHARqQXxI0A7PX3vc0fiPCtWpKmu0UjhDzKfuKXWjcWn0dF2dJz9GzgzVxzCYSAzH63lUmWLlUgc6gqP9QgtFlruf+txTmggQDWhZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jurwtXa1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jurwtXa1"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c1c50c1e29bso383976266b.3
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 02:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786441727; x=1787046527; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gy976lH9zUQLHYmMnEBCphjLCeBoKGQK83hMJSRXzGs=;
        b=jurwtXa1jX86V9Dpoc521mpr0LOfYgZNWj5jxkmIlfig9MbL4Zfd/uk7NPiQ+WG8d9
         MkIqq3jnQQnjRFk9tyNv1+TBB0MlVaTFcbTP/Buk5QfvKJ+gvPQ98prOyQqijFjtf2HN
         l7hS7DaoRZci+NhKMuFp6U+6qSLx8ItqIP7/N27zqLphYqm4aW9Ut61qTGo6qWgSVcpD
         HRlHgDi5bx3wysXG/uNFeZ2zxbJXCYyUOyERolamgbSqis/jU2eoGJrBX9M8/kDFZWqi
         EejKuDlutThm9KfEhCEJDLjV6oFWHAn2mxzl9sjhokeLVXkAsKH5YO790gtMGW3eo2bg
         fD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786441727; x=1787046527;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gy976lH9zUQLHYmMnEBCphjLCeBoKGQK83hMJSRXzGs=;
        b=q//PEIkw+MZ1OosGnCixIhbEXV/8w9FoS8uQtQ4dgaE5DnzhMYBAc+9+Ju61KQvFKD
         Ky+r8XEP47IrvDiBBEgGWZVccHaL9T8rHF5okuIJYT5A902hZl4KwxWBlbXXS1n+tm4Z
         g248sbp2lL8o44vV5h7Vx2RMxQQwZwBgWLOdU1FYy/IgV4Guj8QVG2nAkpHGXhf9Wl6q
         pb8JizHNaeJRVwEpJpQp9qF7Dd5PWDrSl/YZPk9vI1crd1OMtGLOEwI4qSXodvA8YX/7
         XmmkPlDaadFSSopojuKzKGiSBcPGMWD+F6jEiW1MZeJWddftj1SdXRNLr8jKpABHY4vT
         GcfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqn2E5WWmCRthj3AKpB5pbkf4ADQgb5t9/m5IskQwxLobLlpHvYSA8LRY0Ap6CKKzXeDmHlsmmvc9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFGYNHe4bbwkADUQnOMWFpMhqU3qhoaNuHD8kSrABsBh8he3uK
	9aUWQxhE25Ya7+fneryg8HEBeMogEvBwSDLSw6Rma2Ovx9TBPV9rtSMU
X-Gm-Gg: AR+sD12O+URtyyHO9ZZwAUXWm+9fz7Dp5R1OvlUyR16cbMWEamJhUq4YnG0SNM29NyI
	s3o8eB779eS+V9otFDw4APEDBgBK8sSxsyEt7+q8xlKNx0pooC1XK2YVE/T66qgOtQkiLliYNVL
	jb/gjuBmMwx7EHNKRa1sLCjSV0EIriN+1KLt9TK6vM5P8X1lpHXxqlPQUmR+9TYVZQUi89qMhas
	I1w406syGeoKv671TeDl7Dbkq0syU9lLTFKM+wU57iyLpAwhpOZ3/OAVi4TnvmkxmFP17fWJiM5
	obZ03KBSVZPlRT3gT42w78A4CBFOm1DekzyIw4KcDEkOzRWdM22PHcTbs1eEx5YrGf/GgqyQXNd
	4BfZugbD5yyZP6xdTpwVABT9hqr+g0DmwWNi3rD5VQD7PzAdVE0V6NNehSDsYY7xM/VBqpovg2k
	cmV4HANJwHesEMDEi4pJQd0+HsMyUuE3ZAfnJS5Ii6bwD07vadNfMZRaM=
X-Received: by 2002:a17:907:3e90:b0:c12:8db1:b6de with SMTP id a640c23a62f3a-c20e631466bmr86856466b.32.1786441726967;
        Tue, 11 Aug 2026 02:48:46 -0700 (PDT)
Received: from localhost ([87.129.199.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20e414d5ecsm32745466b.26.2026.08.11.02.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 02:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Aug 2026 11:48:45 +0200
Message-Id: <DKM0QN83P2C9.1OHOGCFIUGS4Q@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: flow: slf3s: restart measurement if VDD disable
 fails
From: "Wadim Mueller" <wafgo01@gmail.com>
To: "Maxwell Doose" <maxwell@maxwelld.cc>, "Linmao Li" <lilinmao@kylinos.cn>
X-Mailer: aerc 0.17.0
References: <20260805110255.504576-1-lilinmao@kylinos.cn>
 <CAKqfh0G82W5wWg2xMs_qRcUAWCk1Uq1BXTPAD885h6k8sJi8Gw@mail.gmail.com>
 <b61d786c-9200-46c6-9072-d7c43639b6b5@kylinos.cn>
 <DKLOQNAMLRWA.20JM0MR23ECCK@maxwelld.cc>
In-Reply-To: <DKLOQNAMLRWA.20JM0MR23ECCK@maxwelld.cc>

On Tue Aug 11, 2026 at 2:24 AM CEST, Maxwell Doose wrote:
> On Wed Aug 5, 2026 at 9:21 PM CDT
> Linmao Li <lilinmao@kylinos.cn> wrote:
>
> >
> > One thing I noticed while doing this, not specific to my patch: the
> > datasheets for all three supported variants say that after the stop
> > command the sensor "needs up to 0.5 ms to power down the heater, enter
> > idle mode and be receptive for a new command".=C2=A0 probe() and
> > slf3s_set_medium() both send the next command right away, and my
> > rollback can too.=C2=A0 Is that something you have had to care about in
> >
> > practice?
> >
>
> Perhaps something that would be good to test on actual hardware to see
> if it matters. Maybe Wadim can check? However in all of the (very very
> basic) drivers I've written I've tried my best to account for hardware
> delays so I would do some more research into this.
>
> thanks,
> max

It's definitely a missing piece. I haven't observed any issues with the
current implementation, but the required timing should still be respected.

I'll add the delay in a follow-up patch.

Thanks,
Wadim
