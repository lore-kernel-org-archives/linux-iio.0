Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE22B33F377
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119128; cv=pass; b=tqFUZvfKnABrcgcOqSOKIVZ+VrD5zsu6bvgtFXA6rTL9hatc7/V3uK7YgsNlkO/iVShBjNX8O1l61T68aMbNJ5HhWK4Q9sGGg3wGfUmM3Z2pe8rHJbXt1SiPGdu3CWMcuifKmxdw6PdWuBiuSELKh0KvVQDNHuCozgPOGxPfkrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119128; c=relaxed/simple;
	bh=jyO6QYu2JIVfWWX1h6H23s9IKHuJCyjiNohNuv46jC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDZFqGRS9B9KHjulAklBjZhmFq5OXs2hJx9dWkHYdKqje8251eaokN+d5bLpOaCgqESySeqjpn6wDLWEGU9MBSJHFCd0yaV7qayfLkO9Dwmo+0xmlrwLBkqpsnOAFxROlh3ga7OmY3BuyJwEC7NTSf9QTjwha4XNxIKLqndpGDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6uy2NCi; arc=pass smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6uy2NCi"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-8ccf7b7d188so75795776d6.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 12:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781119126; cv=none;
        d=google.com; s=arc-20240605;
        b=hPaNs2x6mhGOAnyW+0jZV7Ob9zjB8LtPqOXDiS6IIcvjrR60aAWKDT2kua52LDTEmU
         Pr/PdLN7dW5W71nQwrzhL7E1PfAW82U54pl87mQaiJDgzsC35t2qzQG4tQ/qd5WUD5/J
         xcQWMDl6Mkk5T49rpyeM7I6dbCq4rELnQfUW5aVbZGaMTrAtrrUSEOT+ioRdBMaJETCD
         8EkHSFWVLyXXzVxntpPfOHsqD1LHUjuCiCS/sqUwKkgVxAlzzcEyPBU9GDNHHnP2lgkJ
         r8bvCNQPKnjR7Xn5Bbbywa1qnO7I8toclJm2kxnQuRVZ5kV//2hIGyaFsMC1kbVWSRP5
         NSdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jyO6QYu2JIVfWWX1h6H23s9IKHuJCyjiNohNuv46jC0=;
        fh=2bGAJSo1YRG1y6UPlQos4Xx7XgOvdmN7Fa763wzuRi0=;
        b=R+JVxghJTooLKZ3AUeG1UdrjmjgomsSbz9GGUMDrae1ACkpe90RK7NWFkv0XJJYmqi
         CORY2711B0LsLharm0yT0cRsoEm8xwZCgDp6Aufag1R8NvhgG5MwBmnrr15adI5yVIo+
         JOtKWFbPSMSbloikSLlpywh3nx9LTux0CkpFpM10IdbXWdbq3YhQYtVPrBlwp3DZ+Rc4
         b4J6H/hMl4c76yXut+LPwnehAJVg8B0otVwDAXr2mmBJNJRyfrjb1Yt3hl8O8piev3wo
         YTbntX72o+drRLLbjLunmBLW/QPXP0riVOgQMiT9DJ//20bS7FiwF5rPwdkL1ZsSA0vs
         AESg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781119126; x=1781723926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyO6QYu2JIVfWWX1h6H23s9IKHuJCyjiNohNuv46jC0=;
        b=e6uy2NCi6mS+77jf3Co42Vdt93onnJd9duwZxzNuH/HvkJ20Rqqzdr1pTj2BRJ5q88
         7rX0TozI4Fu4LsiUKrEruMYYRjvlgGFuBkRyjh/RnS1fY9N5UCUVsFr2hyXHdmd6TkRu
         gp+5AkfSZWf60B1oElARmk06XSPRF+nBU50/0qZL/vd+Dxaa5thpxCO1ZCh0NDwHf5vI
         4oaYktFy2aogxgs0/Apf6MZ1dZx4Nukq+YDxC+opHZjWhvylIK7CRMICaxXKogpViQir
         GAHQBruV2tVdUCbuM5R9b6VDNvbJD0p4KQa3XA2lTAch+I+Ph+kyDzNIWSc8wljvGcZn
         9YOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781119126; x=1781723926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jyO6QYu2JIVfWWX1h6H23s9IKHuJCyjiNohNuv46jC0=;
        b=oeLxHgjxkI3LjBecLvvvxOL0kVs5LbHB/itLcr4F1ZbTDVwLbrlrE31XbSt2Vz7ksn
         HZ1/CuOrLvEmX9X6ci1S2Tef08zysa62HFfA1zdDhdmpU+hhNRar9Q4B0HAP/LmBpO4W
         k77oSRiC98vc1H5RdCTHtwVRN3/C8ln4ahuUJDDCxcn0ZVlCh3k+5DDwNPpeWVtxKDqq
         pjGhXEhZLmUyA/UqPFa4HBV4UX9DRAxUdELx2z17fDITIBhXqWDAGsJQ+ogB8G++l2Xb
         TqhleOM9/gjE8bmwNFc0Xt+JYJDvEaaNKBlsceehXFuRMBsgkVRSIGCsmD37ZTvQ096Q
         sbkA==
X-Forwarded-Encrypted: i=1; AFNElJ/npbir2cTenVtcKTqKaGk7iLPO95rEXNGj0tnDfak0Nd41pQ6W7MesnP+BjJQJeUqGhGFojI8LI3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTWfM/9ZgPR0b4zxk/sYBBFiiVwO5dhQeZ4mN23H3eEFlwMkOP
	qd6pk7/n7mdTds8PTCDxNUcNDOjpWOPNKxI9P0NUu29XB2DSgkojYdB0NljycbxNNi8AYWzjgNd
	t9FfNz0+OsRAJ7ybD42OQ6ZhLRjr2CPM=
X-Gm-Gg: Acq92OHZbhPUTfIQvvjbL6MK+gRMRRW6FPA6qHzjBwClGC1Sw/qdPMxTSBY3dzQyPQG
	2VroNJOTedikOY0L/stUJ2jlFXvtiOlgA1eqJs5JFWSjalOZJFbkQgRG4wJECZlfZdqIWQv1Eq2
	0xKvONSIM6MKPSNXuFGjN6kVvr1HV51RWX/Gw3RJ0R86ZQNTQrf9efdYubOtDpNPkmwe3ljj/KX
	dOv8ov22J0XqY2jbY4T2GgxiAcpHMvzMpCuseVEUKoh5Xfc/rKCzHKLH3YE14Gb5oULM6LOMOaW
	UvKAvXLGRaTsHzyXhouc02683Lz+JPu4lVAqnsFAw671Obzv+KWB+Q5mscD1Jww3MPVK0G9j/28
	=
X-Received: by 2002:a05:6214:2a87:b0:8cc:e8f4:1636 with SMTP id
 6a1803df08f44-8cf1cc96d49mr143593796d6.25.1781119125540; Wed, 10 Jun 2026
 12:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610040501.204967-1-enelsonmoore@gmail.com>
 <ailpoosKZwGskxUo@ashevche-desk.local> <20260610155921.0000655c@gmail.com>
In-Reply-To: <20260610155921.0000655c@gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Wed, 10 Jun 2026 12:18:34 -0700
X-Gm-Features: AVVi8Cd5Ng2v0ABrIOtRPLCyrtOLiUJ4FMGlJXLOFuIhteF8Nuwx58QZ5EnaMvI
Message-ID: <CADkSEUj1WgANDfQD_8RKM+sWgWgJZ-f9p9jRuniQYs7RA=Eg7A@mail.gmail.com>
Subject: Re: [PATCH] iio: core-trigger: correct CONFIG_IIO_TRIGGER macro name
 in #endif comment
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, linux-iio@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Andy and Joshua,

On Wed, Jun 10, 2026 at 6:59=E2=80=AFAM Joshua Crofts <joshua.crofts1@gmail=
.com> wrote:
>
> On Wed, 10 Jun 2026 16:41:54 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > (Btw, did you do that manually or using some scripts?)

I used a script I am writing. It attempts to filter out enums,
changelog entries, and example/dummy values, which makes the list
significantly shorter, although it does so by committing the cardinal
sin of parsing C using grep :). It also has an easily editable list of
known false positives. Once I reduce the rate of false positives to an
acceptable level (I notably need to exclude typedefs), I will post the
script on GitHub.

> > Wow! This line is from 2009
>
> Perhaps there should be an award for finding issues this old :)

You're welcome! :p

Ethan
