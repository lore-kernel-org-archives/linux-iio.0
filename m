Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050FE3CF05D
	for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 22:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787869514; cv=pass; b=WyxV2dpgGKrPZ+l861KRuQvuTSMcJkX2yBY5VB2vBJBGgJEZuHHOITMKiLO+vEYDq/TgdkDNllZSHad+rE9VtLb4H4f6cJ//jbsTPpbIYk0pUxI7nvtRZM+3YI4b5Dpkq6ehi4zl4YNaEaSLupzUtMy/2T1SesnzkqXqinBMppY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787869514; c=relaxed/simple;
	bh=/E1qm0j3abWKQXo6pZVeXLBEXmyK9cxZP8Mn4Y8KCu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tO+XFaG6BplhsOok77htASEEa/4RCTf1raECkP6NO81orQGwS1Q5I4IlyT73mhDgY+ls9kxf9AO4+9xcFLAZ/NH5x+2a3vVXVpC7eO47a2ut/FCEe0CgNkzmSZ7SpyhYfBhQ0LlaEeVRlkvAUqkpGx4ipHWXiM70BX2Kli0ufaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rlg/BSlY; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rlg/BSlY"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4518ad44e83so508878fac.0
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 15:25:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787869504; cv=none;
        d=google.com; s=arc-20260327;
        b=W1J70sSAYmMWw6fmT3ISlJ26fON8iPXnfe5ImCGv6mfLR6F6fCzN/ZdzhyIX3YCTTj
         HjkVr6EzE60++rA4UgIeonEn9rNWpgLrodgyuEG5FzndW38vvxzZVH1PvgBLcQK81SbS
         l8Zg9odpCYlriOk6VyzwWa1/u/nNlfzRQuu9w2eOImSsuBGFCQjfnmcVwtUqMPNZMlpQ
         l3gS/7PlufNU72kCwzzFHvB7lTyF0g0KMqMNgAEKy1s82dYKh1haXJ/Ob1j82xJJF/zB
         MfB3yfp/FRmZStpk0imAHfIvWCe9M4PTeH+zsb51KvRAKOTuoCyd4lufRZ/KXLrWo8k/
         BgNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u8HPimuwgbeLD9+T7JiRFwzxuWXrmdfq6VOgvHXgXYU=;
        fh=IQIyD20VTglCxAvp01ks5VZaMiV3wdyHwRLzqh3Rmas=;
        b=S+SswfOzzdA5ie8UEZUnKdxCgG3REW5NQe8y+g6CmYPpu2T1T4y3ZGqJxPeLwrb6g0
         Pj0B2HwjKtTJU+HlGA5dt3OxXzWvc4WGr6JOcVQRdeERnk1mxngH4w3bDSKfl+GnqGI2
         ktLxO7bryirGOIVsa7mjJM1LIwAvzIHo2+ottnSTdJ8qWtnylpKLna1y68AURS+3NEXp
         W0xqCPBMAtFDb/A0J5syoqv2hfM7sFUYWCCpDlCa2oXRwn43tdju7CCwXc3IlY80EOLU
         D1B8D9Xy7JUpoeGokmd0MWUVJIQBJebkw8VSudwF2I++y9setzT03na0JsgBslcgblAJ
         4Uxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787869504; x=1788474304; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u8HPimuwgbeLD9+T7JiRFwzxuWXrmdfq6VOgvHXgXYU=;
        b=Rlg/BSlY/gpTlLV7z2nbfF+KLA2KWCj5YHmSGCZSjOxwxTyh5HF827bvPva0z3RfGy
         sVqLCwYDr8gLFOZy2pUzGUNNKlm5tmG5DpHrZH3RAMRbhGSoG3eidZrGrQgpCjVbvcqN
         Dj5b9rmiEbGFH/Qnsc0vlb89j7xwtUrQf1KuIjSqFjg3VFMMOiHpW5y6f/no7nYwRmjE
         q3d5Pc69UjGMNoW6iBFYtzZCK08SgqFhW6lVU9ygLoFDec4uNC0s8+KMm9iX9TA75nKZ
         oZaB4qhEedfMwPcwsrf2b4upCBZeek3ePgKCT2hXqXwTxjU88fW32SRdPm1hC57Snm6H
         YtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787869504; x=1788474304;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u8HPimuwgbeLD9+T7JiRFwzxuWXrmdfq6VOgvHXgXYU=;
        b=rJFBc2yFEjH8LByGm3pOEA20GfQkVgzDOqbeemyDV9LOmrvIgjBKyRMH7rCnrAaBLg
         K4RwOvD3Bj8a55C6No42/mA+puRR9RYn/B5QgnAkIR+Qh1fIpvhYIlORqSbFqFuXS1JQ
         2MpMIrqaGbKYHd0Xy0sZw8cMLf9SKzW0VYVIWxbPTxAm7E3QEDRSCAmy58nM9t49t3e8
         lBO/QuegY0ZD10B5nrwCL2rBKu2Q1YqhcY9R5kw3zQpzIdvtRsoCBO8Z/NypsbPBbPIm
         76G+iRAmDqrvxUQIvitXWT2h03ZoyyqVmVpr/lLyK65q9fCfyRX18ERSiSnvodMwSsgx
         6KMA==
X-Forwarded-Encrypted: i=1; AHgh+RoswTfB8cNnyvLtIqkKVVYxnFKmSHg6Dhp+rD5utz7SVpjo6DznSjYbGhpYF9IpqlGaiADPJSNTcj8=@vger.kernel.org
X-Gm-Message-State: AFuF++npTD8xr66j3KrDAw8MPW+HGCZTwBDsGLE0Bu5dYVNzhKgmvFdj
	+32rctgwpgKKXTzKRG2nw5cVNcpA8+MdJaJfo0H0oouomBxhv0SONIJXAEWcW8AlAf9o+do6GXk
	OfR9+wJgFw4UUhQ5FDIemwDgSwFh4KYk=
X-Gm-Gg: AR+sD1092bZfwkubJc/RMl5ZFYN6MWHd0OetzC3TXjIJeIw8o4YF7crNglYRsKjIEb0
	iEjlpGSbpTq/pV8jNgcA43p67jljehs45mih53eO4kwp2Sap/qulvK9SZgyA4w9scoEgPvCWchl
	IQFCBw+C90zCGIWsEEZvAnkSu3jlk4HTz5cEuzvhSgYjFW+ju86vRZG5xWc7OuWqa4VZGViMNRv
	1jboOvpB35ZLxIBqcDwWmTui9SxcHqTQN+aVrAlUBS2hiV3n4DMSjJ3FYi+TqFwd2CaoFJWP+sv
	dAN0q+uco9ewbLRNHWwesXB/ND3XM8J8y6J+XyzWZpdUxvyEbbvb75Zv1J+MOl88oAhtK8guar5
	bYRpZagiTeSc=
X-Received: by 2002:a05:6808:c1e8:b0:4b3:3e1:4999 with SMTP id
 5614622812f47-4b398434703mr2911222b6e.15.1787869503851; Thu, 27 Aug 2026
 15:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826213140.37437-1-rishab.madhugiri@gmail.com> <ao_cCHTp9kKfOV-U@ashevche-desk.local>
In-Reply-To: <ao_cCHTp9kKfOV-U@ashevche-desk.local>
From: Rishab M <rishab.madhugiri@gmail.com>
Date: Thu, 27 Aug 2026 15:24:52 -0700
X-Gm-Features: AcwNN1V1VmnOS3aWyFnmKIS-D0GyiW-IwL_nYHb8pdkGVa2FiKvsmCJoIXlfs5w
Message-ID: <CANc32tPtHyJdg-PJa0iZHcqX4WDtMFikZFD+4aO96B1+zmf0_Q@mail.gmail.com>
Subject: Re: [PATCH v2] iio: core: Replace BUG() with WARN_ON_ONCE() and error return
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback.  I totally understand the perspective on code chur=
n
versus making tree wide cleanups, and I will let Jonathan make the final ca=
ll
on whether this is suitable.  I've also noted the wrapping width feedback f=
or
commit messages in the future.

Best,
Rishab

On Wed, Aug 26, 2026 at 11:41=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Aug 26, 2026 at 09:31:40PM +0000, Rishab Madhugiri wrote:
> > As documented in Documentation/process/deprecated.rst, the
> > use of BUG() and BUG_ON() should be avoided as they could
> > cause a complete system crash, preventing further debugging.
>
> Right, but deprecation doesn't mean the _old_ existing code must be immed=
iately
> changed. I leave it to Jonathan, but I see no value in this change except
> the unneeded churn. If we ever want to drop BUG(), it should be done tree=
 wide.
> Hence no tag given.
>
> > In iio_get_time_ns() and current_timestamp_clock_show(), the
> > clock type is already validated against supported clock
> > types prior to these calls, making the default switch
> > branches expected to be unreachable. Replace these with
> > WARN_ON_ONCE(1) followed by an error return to avoid a
> > crash and to log the highly unexpected condition.
>
> There is like 10+ character space on each line, the commit message should=
n't
> be that condensed.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
