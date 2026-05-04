Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D1D3E1207
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911041; cv=pass; b=t8ianx4tkC6EDwwmGXNFKknG6ioxwO02ZKDkXFMjLYLuk7vFDfU11YKV+Ny8uP7E9cdxihzYIVXBNwYpb7HQV6oR79zqsCJfpL6T2pN5gnMJ3e39x3ks4L1XclKWKMARQsUjjRPs2PFUrwU/MIoGMd2q27aH/oNhQ+nCUgExFQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911041; c=relaxed/simple;
	bh=QXSLC9K2LUyolFUxq1Np6YwX9Z+I2FxGsd//jAT5sO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzQrZcLIU9Ew7P5cEFFyHDkW77tjoSbgCCYAM6uBUnP6DcWX+CTmBqA+uchAX3hDfYH+pY5EbGMNK6iBmI23tCSW4o39YSMbz4RHPLn9UTG4BagltODiVWjZmctpDrEPM6AXQF1wbR/i9U3oxRQZyzZjN8MTdC4noEqvlYi6yi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuQ39qo7; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuQ39qo7"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79a46260385so52164267b3.3
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 09:10:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777911040; cv=none;
        d=google.com; s=arc-20240605;
        b=KCbDiFTHHScQ0pAlx3DPs8jSfBC8MHsBY87bQBsvTYIaA9TH/ypgOUbuna9d/adApp
         HFXuSXwi9h/MyYPOrCRxH86aluOUDoDhjxcz7/Z/hnU4fKTSEwKyIseISJv3/Lz5SAX/
         t2fzTe5w06nD2pw5rilniuxAMrZSzJr9nQqZQ/xWovaODuaVhru9v1aqXznHbxkwMLGQ
         GuA7Sx3OZrBu3IWxLA1Nxgj+W21lPNLQ8MtX+lIiKZMMtOS+sVvYYw6N47RffSX5vgYf
         k2mkwVpvFcmCWvJ9QdOzg8nmpZ8pN+n6mJg4HzMnm/Z+HW9KmmSYpO5uLRBmN51y7bAK
         izAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qutAn5+FACFY9CJnkdgihQani3q+IAXospNoRfuglOI=;
        fh=obf9ONFuSZGO8bwvpHTvV5oxrKR4mbAXeC3qMVznNQE=;
        b=YbOgpEMgqZNSzoHUjlS/pj5yssUYa9Ls1yEve+HWLhtd8MuBPvUWASnmddb0uT9Lsk
         PePlKs5+wECBP8Q/7KuDjpE+pbV1PFn6Q1xEh9WK8tDHIiws0LVr/1OpPu8sJj+/F0gj
         c9UIBPwbSrMGmbn8p83+0Q1NPDP/VDML7OXY9abbpnamt0fed5PqfKn/kt4YMKIo6nUV
         3iMXvIXRP7ySuJiRR6Dn0T6R0vOwfYZnaGn3D1ecxclWsld4K4x4PCJ4L+c3TTvgxXPr
         w1LClGwt8nwyghGs+DhAKT3Wis488V2vEGIzc2rt1ypFCy63vq2nrxHIfrljscF+1vmO
         D9pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777911040; x=1778515840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qutAn5+FACFY9CJnkdgihQani3q+IAXospNoRfuglOI=;
        b=NuQ39qo74QIfXvwPwFIGl0oHGQkORJL/fBHQKc/rEH231oI1pLfwlQZ7GsgXGNeKuS
         LtKBHhjvXCUswm7lSHH572CyUS7wIIUxz10hs0aTw9ysJ79OjYJvjlBtJdzdVNNaOySU
         cctw6ClyTtt44KHc45sgDfhfvHi9o8fwZUM2d5g29Geic/tD38VHtvfJ/H7GSoBidA8Y
         C53RlbFwfcyuJr+ciGp9Td4fuYgkWiNjAAq8dlZZH0CRcnJHckCESJ8vX2nMX9avlRJ7
         ngv1vtVXqiQLM7XtXHWP5b4NAS0eurdTGMR9G39RSDNOfISLdFXDbWLX3rjyf+P42PPn
         ruxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777911040; x=1778515840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qutAn5+FACFY9CJnkdgihQani3q+IAXospNoRfuglOI=;
        b=ZYFjJu1p8YL8W/mq74QRPbbrM4MoR+QGnvAFUQYcdm+mgExsqtAcc+V4m5sX17mmtu
         PwRbNfkSrW9BZJUHio7XrUylZWi/hoNQwJV43HhQd1IQ1kKDkQ5/kFxO32c7E+W4vsUm
         z9Wcl5GJ/dZ9R0GkcT8O6NWbnDoBQYAaK6amJb/+wb/WDytqxLPeazzYU4ctRCNLTO2J
         +BgKZ5szIa5wIeUBEPHOa+jSGej8F7ZVWEczqec6IXFarUynQELIc+exC7IBZiw+U9/2
         acmLCwdYW//1UEqrCnT+nvkApjzCLgT0AchnGag8qcH/JOGcgJANvOTc7uyDr0zcncyt
         EA9g==
X-Forwarded-Encrypted: i=1; AFNElJ9eA5OTWxMqFzuLZl1FR0852Rj9ce8fxLi/dlLg/cDD3Mixo1s2fW7ixS8XNn3wpGWZ3d2xdyIevlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDIrYJjv0YL7nIGO8ab7uZhMgEFxoosyUw7TF3cDhJhBZWOXmr
	Gz45BcJT/2ySdIUau+Mn/XGOKo4g5Tm64w2Gh9inuwhnogJkbTHC8OeVRRuUlGwolgMFa/SZnDh
	RZ5oc40TXi9X7OcSF1o1QVTSUWhGz8DlyCc4hOCs=
X-Gm-Gg: AeBDieu08US5JrR3yz1QZoxfUIFt/chMVdYkN6mLQT9gKXXLjZr55XGahcocZH0KXCp
	dA4kBujvAqZNhY3kPe6/wuBbKv0VG5xcMPt+51pVdaTl5DEPlsXsc33eofAqP2cQspMoMOJIDpt
	n4sykyXcPhLYY+5uY51YHJOrABRZbQQwIEpWTLje2a4PmjkJ2FuQpl9n1MX5cEatsdB9R4Lc9bR
	L+5RYmWxbHD6U9KJOnM3fzYF3+Q0LLHr77O2eDhPNo98HnE9etOoGpbkHSrTWpynHZi3PQA/BhX
	5urbXmOwLYS3+nXSh8JW+eFWsvjexss=
X-Received: by 2002:a05:690c:c6cb:b0:7bd:4792:66f0 with SMTP id
 00721157ae682-7bd7716fbc0mr81990687b3.46.1777911039612; Mon, 04 May 2026
 09:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504092059.1536094-1-angusg778@gmail.com> <20260504162346.53668925@jic23-huawei>
In-Reply-To: <20260504162346.53668925@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 4 May 2026 11:10:27 -0500
X-Gm-Features: AVHnY4Knbk-TsM_DmQ2n_xN8NRlpmOqGAfjG9IJqfTYXUwMg5Fq9WPp19C79NKs
Message-ID: <CAKqfh0FiqN3ztMxYRWasj8+2+z0wvYanrdfvze4z3U8YVcgS9A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] staging: iio: ad9834: driver cleanup
To: Jonathan Cameron <jic23@kernel.org>
Cc: Angus Gardner <angusg778@gmail.com>, linux-iio@vger.kernel.org, 
	linux-staging@lists.linux.dev, gregkh@linuxfoundation.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 10:23=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon,  4 May 2026 19:20:56 +1000
> Angus Gardner <angusg778@gmail.com> wrote:
>
> > v2: Split into a series of three patches as suggested by reviewer feedb=
ack.
> >     Also add a missing dev_err_probe() conversion for the SPI init erro=
r
> >     path pointed out by Joshua.
> >
> > v1: https://lore.kernel.org/linux-staging/20260502021815.3953423-1-angu=
sg778@gmail.com/
> Hi Angus
>
> Series looks good to me (Thanks Maxwell and Joshua for reviewing!)
>
> Applied to the testing branch of iio.git.
>

I realized I forgot to add my explicit reviewed-by to the v2 of the
"use dev_err_probe() in probe function" patch. If it's not too much
trouble, could I get my reviewed-by tag added to that patch? If not
then no worries.

best regards,
maxwell

(p.s., feel free to call me Max, cheers)
