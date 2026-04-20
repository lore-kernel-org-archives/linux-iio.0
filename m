Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D90027F72C
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776696396; cv=pass; b=oCM0v6nkbKesqqGC5dwKjtZk4FWY4LFf+/mLMrMMEr2qutiWueII3BL31TH8aPjSG30jClvrZPSac2/oTd86qRzpJpxgAXBHf2j1dXVs63sDnft0lYg+N/0WmR5o9mODzm4NgUj3aWcsVRiHG3uljSPGeDbmFyAkT6WWq9D5qsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776696396; c=relaxed/simple;
	bh=cPQhcvSXT6egN+N1e3u7wYQObezpFHmNxgtDrTs1hBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u65oF0OpF61jUNECbTyYvuJjgUBbTG0QOp+K+ds/00/YnVJW1SaBfyzi5QmusL8PRiNPPXwi6gsE64eMhMFDgiCkStjbG6bY+QttF5xqc6e5DSj3CzbULmj/siVNy1fjZI8oiyhbs/mfr1c4RWGmLRXPyHdgNGmfY2MA4r6xvzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaGmYH3g; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaGmYH3g"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7a43424f861so30949517b3.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 07:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776696394; cv=none;
        d=google.com; s=arc-20240605;
        b=eqrh7mjcl4P7yaaBDvNgMT+wdTh85F8ZLjeF9Bgb4yxfKsqWDPig6jzFl/2rIxTiBN
         4FhgV6awK/1oSo/wR2IkuyEgD6f/ALDdjR0toHjI6BQLzYEsBcom19Yuy/ZaWEfEZXfJ
         yIPMBZdNlLQx1jdarzGpBFoCkHpHR4OshO/clwRoxE7NzhNkN/12F1UcpIfJfQoDqJLz
         DHvSwTrjmkKvZLljNjspaOKVUWL74qhz0TNHFffxoSQPQtpCUIYfrOOwPyodmhm0Zjnq
         WBzDbX8rC/H1V7Qh2++JG//FH3ReGt5tL7JZT6l3JI+HnYQM7G/+TgAHsbK1nRcjs4jL
         Dmug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cPQhcvSXT6egN+N1e3u7wYQObezpFHmNxgtDrTs1hBM=;
        fh=AyjWKDkNMBIJoONvjP7O51zkUGYiIVJY4tjs4ZvDreQ=;
        b=hrnibhmYroDJXobbivC7q2Ddi5nooJiy4k3b1ALIrB4u4FFb1Kdtx7TRdhDvYqPdbO
         d7fzfGGJBEWuJmULAguR81OH7SMiqhWlwsCOTwZ1wRMsRQPK4t/3vJeU5F9QWwA5Qu3I
         pDqZDGvanzF753S/kff321aG2SuGb/wFDz4LhU6yEPnTy/CVjrWkfuRs+4aWQyjSpS5C
         serxbFyBjSqtyaxitkZ3EX+wQHuWUgoOJdgokDWl+w81OjJI0T8BHcActqNSdWpBiG7p
         Y8hquN5P4jGPgvYLamOkHS4R1oRbOOdmT5pVZ0rbkrMcG4fsWkkL0gc/Xpr3RtAszBWS
         uXFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776696394; x=1777301194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPQhcvSXT6egN+N1e3u7wYQObezpFHmNxgtDrTs1hBM=;
        b=eaGmYH3gc4uCgEHZceWTlC22HdbGQSj1aiF3mPEXeehYy7As6IpvPh/m+buTF+xeu4
         zmgch2jUZWMsk3nxLpZ3+iU/mF60IID8geFEytS//RSPGDXhogytINA0af//TZPiJoQD
         zV0bLJg0LGYwmOtJjWEvFQmKAtlRdO7qkWgNFqw+qRntg8igNxNfioa3RpW4Jh71ZCnk
         vs1AOnJi8iAoqM5TLKMX6MzJny09Q26Tya8DPd5EUq4SckKOSUMRW2RwfIWwprQyofgw
         L0rwJmH3KL0BEw2LLjQxWyiDw3zNoG64SbZ46tsgkXAlyGEa+8BGRB0EO7Rn3w1qjhb4
         69Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776696394; x=1777301194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cPQhcvSXT6egN+N1e3u7wYQObezpFHmNxgtDrTs1hBM=;
        b=rC7YFe97g+G2BG1MZfl34rHEUEXxUC6f3Oep+6vwA09O5SKl43+1kwX3j45BYMiZl/
         jDRzWAAXn0/9FIjitTGKwkq9PlJjpvs5SB/35Vfi5CF+RXAWsekvdOo8ZbFONBXRhxYI
         s3JG7YFHplYJ8TnZGIIV6FZdEGV/ke0+ozsZtDjWLSH6xapaYvXCnm5fLQQLh1dlbq3c
         NdIb20VK+6t30QKzlSPg23m9IxVyrZ/fanVlnth+yCGLG3RNMjKoU9t0VymAR2DMChkf
         w0r0EHzFpQyQ0iqYX/pubd9vAdAUN8gnqorFOWIpBuzqxsf+cQQuguOtZSE0PH4ow4Zo
         mLKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/muZtJEvM2ePek+/pZjARp63Hj9/bI6KDr6+tTjAcbPVXlIXeD7hGEzvBKjLioUYFEREcxySMYlac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMvGbEknKP94eo6ftbb04PzoEZQwXUu1qR8A0kuL2HiuqDEwwY
	4RGndzu4lVFRnv4Lq1RfuNsTy25yJRY3hpJOp+yluOYa3wEamNIYwJ0LngPrXkeUJAF+FcdwX1L
	IH1W3DLFLP19bxLC+cNIB5qd2ivuuBMY=
X-Gm-Gg: AeBDieskdFQ8mgLhOuK9gi5XdXNN62fHCHKK65TOcmiaTb+EvL7W10gGuPh84mNnr1J
	KtrDDG1yWmKnZHYRrRmo5/2hVAaVnb8lwPfBzisASjTqvd+Y5wBASoDG9Q8l+zCGmATYYAA+mqc
	DiYrgaUg4YHMeRO01NfGdbp+r4x+d5dFKq6SgoPW7mOIBC8TUDcfonmEVTfcF5hhqF41nhzvisy
	eXmxBzTRyr73drJNEziaG+eDrNYdCF8kB5xuSW0i0Xt4KuVMcNb5HDZZuH0P00YABx+VIcK7gqc
	S7XTX06Jpe/e3cF5pPJr
X-Received: by 2002:a05:690c:60c3:b0:7a2:1f26:3d6a with SMTP id
 00721157ae682-7b9ed00a78dmr144373707b3.45.1776696394202; Mon, 20 Apr 2026
 07:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419010537.116002-1-m32285159@gmail.com> <aeYwHbngIdVRLqpQ@stanley.mountain>
In-Reply-To: <aeYwHbngIdVRLqpQ@stanley.mountain>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 20 Apr 2026 09:46:23 -0500
X-Gm-Features: AQROBzA0xJkbWZmvpOGZIWGSTMw19a221ansEaiCLBs9MzdY2pEQUIoezdA9dBU
Message-ID: <CAKqfh0HoDHex6-ngXkEY+cm0JJ_XoBUFEC7BD55nuwCwA8wfNQ@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: adc: ad7816: replace sprintf with sysfs_emit
To: Dan Carpenter <error27@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 8:54=E2=80=AFAM Dan Carpenter <error27@gmail.com> w=
rote:
>
> This says that changing to sysfs_emit() will increase the stability of
> the driver, but actually that's not true.

Sorry. Like I've said in previous emails to you, I'm still figuring it
all out. When I made this patch, I was under the impression that since
sysfs_emit() improved security by preventing overflow errors, that it
would inherently improve stability as well. Thanks for pointing out my
error.
