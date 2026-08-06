Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291C042122D
	for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2026 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052603; cv=pass; b=XsSGPI4fI+DmM1LY4LFpeghrPGPyecyc+FXN9MDo1VHWXVjsQZSrWD/6VVEq9e3eWt7b6HY8q/CgHPJHes01rYifU1t9/zEnPDl5VAbDbKg20UJbqtXuAmHavdkuCT9klvVZoIE6ViZBKDTIjMc7p9hniWiQszie28A/buAVeKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052603; c=relaxed/simple;
	bh=B4RhCkP9S/2UPiy2bHOf4EZfWfEQo8ptwLer6SDVHUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMxFrlsofbxfrlzijyhtSLve9PUPY7OM5TVxJoC37PGL14+bWIz6ijPnjvy54melpI3PV74U5hb/knf3VA6n1V8LCcNBRNinnHd60Cf+ScK/Z3l2UF9Om3mi75oTCJ6qheFLnr12MeivgBuVzqftN/ZRN3cgcHGkT9yLl33WhY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TS1+V/eG; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS1+V/eG"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4518ad44e83so1744599fac.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Aug 2026 14:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786052601; cv=none;
        d=google.com; s=arc-20260327;
        b=ZBXVkBU32aw74I77q5gq2pVhlB/zjjFYtrgu5iGwXH61jmohhIQ3sUvzwGyBdO+NTy
         NM2p4U98vOH0RNPD/8Z15n8BbKHdoJLKq17eM0SgcdFVkehATrWn+Vc2q2q6ZDPhOa+2
         CamUHrovRl2/nUf9EW14bp4ravnwNnJpH92831W7BwQFy6Lj/zJulmxavMsghiNuF6LG
         +29tcvgKlDsJBCgVPMzir1CwtFI1ZD/ps4UBLPxSgDu9TWZqM7IywNRjTW5oZ9/NH7xR
         gSWpACrboXvurF5EmyZUW02pgDQyK93zKBZxvSwyoDePgl2RuiH+nBhV7FafXLtr1R8G
         Tx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=teq5dtPqyWSwQIzSbfOi9mILXkjf6R2fNiUCCXuIGlw=;
        fh=Dmer/ObQCjkT5dbsq9OtCeChlQ5RpUeyQC0IzzxOsBU=;
        b=HqSReiNy5vIc95e72VhaxBD+ixHDT+FcuSPEpcyJmT5RIE1UnX3XXPglso1ecYfF4y
         u7tUW+nnlS1ObVfORmV6DPTFTV1Jdv016Fwdc2gor5zHFFTSDPbxwaBQIpHZI12gL+Fq
         uv1RorB0fluzdlDkesCJrpve5EKEb2bQK1hXfq5i8iBFiRybZVyFS21T8dU/rVeyEBUu
         uiZZB+RNvqB6Dr27UqhH/6uqUf7muFSarRoyz5TxOBmJNKOprKIM5MT+v6Tgm9O6X623
         A/9pJFG2Uy3CkV1Z2WR0yfSKG0QyFA9wtAeId0S9KMsUIrlzie41zjV0n9ahJvE3/Vgu
         WObA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786052601; x=1786657401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=teq5dtPqyWSwQIzSbfOi9mILXkjf6R2fNiUCCXuIGlw=;
        b=TS1+V/eG5pQddZXtVoS+nUOmlt25sGZwUwvz2IsGDWfit2K11UitBTZKgbaSns/0SY
         PaJkMsLV9M3BhJLme0/gB0AEYzWUcBSmW3DVyHrFXX9frn9U8hW5Em47mh4G3pCBx5x9
         nAyDsxNaHX52ABbDUTt6pDNGSEZ98FwnH2D8PiXCNj2ElsdWs7WfTkaxAZD5UlMRyEFr
         jNeWP/tI/vJa+3ervJx7k7M6EM830lNbJW2kLqCJB7di1AEy7KZVYDpEzOVZFy48DMqJ
         vii3JPh01FlQJnW/WwjUH4ZDn2PJFMNyhQOmb7nqG1MAvGsLK4RpvsGCRtZ62/hekL5E
         9gSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786052601; x=1786657401;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=teq5dtPqyWSwQIzSbfOi9mILXkjf6R2fNiUCCXuIGlw=;
        b=U6C6ktZcMMXkMvSoHSTAI82+clYPuloM/mxHlHq/u+gF9nnxF5suIfCIvyYGv3KCtn
         FqDkZwmDlmiWDKOpFW+PtHab4nD2nc69UBBS6h2pWpB0MOrZMaJRovTZthuBkfN3t8+b
         NwihjbH2omFJKgMH+TXtTM2qIazvl3wPa5Z1YTmBo4rcz291lPiCpYQdStqDYejE8edm
         2vBXaeVZJKpjv/blJM4ttBo1x7FXKO4C2ms+nA406M+nAdf2RlzGBXRWJ5jVmMZIppBb
         bsvPv75xnBlNe/czaCIH/Sj7BuJbU017lBHutP9b4WLdds3A76HoNUhHMnjUUAdldyTp
         pvJQ==
X-Forwarded-Encrypted: i=1; AHgh+RqKx6wHb0LVJ1tQbvMy+Hz578E0gNHd4b1VWdIsLrC2eZ3LnpU4QGCClEjleGloH1SSzgf/lG+vDu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLdEEt3yPu2UCRCHNxLA3taZv2eQEbmlKd1Sel++IVB/bg+nFm
	Sa6Jw2R/7YtTwb8Ya6Ek4G6ies3KIcTm5zXR2Cczes7t9uUf2Pb3q1AXt5DRzXZ2cpOKYUsVhlN
	BEbgWrpbz/Ji8K+Uiptj+U9vik1IM3xo=
X-Gm-Gg: AR+sD11XU5lBfuSlJs/t8THSr4owJJ75cC2tUNhJ723todR22gZKqBTE5JRz8hSxL9c
	PbHV//KK8LVEOeycPNUgoWack3kDRR86znKwVKS+eGcO3UzUedwsXvBDaOJOCzuJmoAbDBQbFAI
	DvVCBoUsLUt4wOcAUb37EiyY+uze5IKxgrCWjQurJn2B4bnb3jnZoOfw7BqjiCU52Z/eEiaOyV1
	KRADyECfizoR0AK0bpaLQKeTFBlh1Y4Aye3L+Q5mOirVUxoqQ8ALTcakbI7UzYw/PNQ9Ke0l+8+
	o0v/i1B60CneBjZ1GNJv58mWlj6FUfkwiGF1dwFgJZdu14fOzDD8jKI=
X-Received: by 2002:a05:6871:10a:b0:44a:e7ac:b14 with SMTP id
 586e51a60fabf-459e2f73b52mr2523280fac.11.1786052601015; Thu, 06 Aug 2026
 14:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802014945.17221-1-adinata.softwareengineer@gmail.com> <20260802181449.12b7e117@jic23-huawei>
In-Reply-To: <20260802181449.12b7e117@jic23-huawei>
From: Adi <adinata.softwareengineer@gmail.com>
Date: Fri, 7 Aug 2026 05:43:07 +0800
X-Gm-Features: AUfX_mxkCFVARBKks4zpYdZV7Yd4C2QJHclf4P5bGdi5j-O4q42jHt_KobUlmNU
Message-ID: <CABZ6vuAL=FMMQp5UTJQJMJi+7nnF+OOYtdRYbbZWveSjninsrg@mail.gmail.com>
Subject: Re: [PATCH] iio: humidity: hts221: Fix checkpatch symbolic perms warning
To: Jonathan Cameron <jic23@kernel.org>
Cc: lorenzo@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 1:14=E2=80=AFAM Jonathan Cameron <jic23@kernel.org> =
wrote:
> Hi Adi,
>
> Rather than doing this minor change please take on making these
> report via the read_avail() callback.
>
> This is a reasonably old driver, so some of that infrastructure may
> not have existed back then.  Moving to the callback makes the
> available info accessible to in kernel consumers and ensures correct
> formatting etc.
>
> To make that sort of change you'll need to work out how to test it.
> Probably just commenting out accesses to the device and reading only
> the files you are affecting will be enough here.
>
> Thanks,
>
> Jonathan

Hi Jonathan,

Thank you for the suggestion and feedback. I will create a new patch series
with a cover letter for this hts221 driver.

Regards,
Adi Nata
