Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795719245;
	b=mSTFy0GxrOs7uJHGVhgr6Aoa1KLh68gq242OQ+PKgCP63AkBr6mYUR7dXWlzREOnONO1
	 qlmUTVAyeKrq9DZ3Q+0fFuI5spfWCJDoEt6bRyQ9RaWjnyjpZbt3vy9I7xoYluIsnKiPu
	 P7M0kaynqe1xxuTzbb83Wfna0Q71owWaOFaxQu0LG0I8ddo5iiJdoek8QY7wafJLZ4R2L
	 7tZUK2YgdlzfdYKuUvyN/IDWslP5Mk6rjxOYP5jTIxjyIsInfIzURW5p3I9MrhoJELDhh
	 KK/nIgcygRgNcsECLYVmjJK2MmVMDYRDU9Wbij4fhFH8KhwHUXG4UuVALSXPlTyA50w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795719245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=0LyIfXrFbfgc1KX44tNJALWhMB7M6d1jCLDWVtkGDBo=;
	b=0EYrRcD7x0NM/CL2pirL15AFJmvZIRNqJIVNfpsEjsxfR/W79HWfhh2JeohS7xWhCgKw
	 uU6691uiOdyjoDEoZwG6kI7+ue+E+U3v7lxanlbNsFwEYt4cegce+7hpGqSQrorLHyFeQ
	 GmseL/dGDyUvQoblmelw+W0GhLwIBd31yvtGf0vXtd5gnP6KnyDzYAyct6D5dAxeQYi3X
	 /ca35oyOkoU5mVJ7e5SuRvtMzyzvkS7viFWw8bcOiopEW05bLJWCy95K1rLhm9VJvZwTJ
	 wJuomUfCL/12lrI8+x5eoPsTgj8EKI6gg0ayUQZpSVhzE4ptxRffTRL4LsBTrYJYd6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dxa5bThR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33272606A321
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 18:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33272606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dxa5bThR
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b8b20b2538so8502274a12.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 10:54:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795719243; cv=none;
        d=google.com; s=arc-20260327;
        b=WVxviRsv5knNMukCnL71SrGRVxuLupKFYU7/VCFemdlzUT7NtToSJuEI/PCYNlxju2
         uqOnOmDwHY+m9U3/Umy8mxGKHuS4o1M5m7Byw5lD8ScK//LEMO063C+az+5QIDcYGgPO
         DmW6kW6IgZZRLPWFkMtxuA9RtE+XltRlYeGOJ7UIlwukZVhpeSNkcc14AovaBTxd9zrB
         CRnBPWavkBx+iAbWefn4C+INzWOdZJawBENZD2uGrzsDweV+9mgj3NRkTUnKENXlzFGj
         xYawBkYQ4BFHBAGLG5oAxWBp3nE18Fc4P9bLJvK3sUaapBqDfNc9e4qTQve3Ys9BwMKF
         9r2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=0LyIfXrFbfgc1KX44tNJALWhMB7M6d1jCLDWVtkGDBo=;
        fh=vNsFN02XwCK2OMxpDJmDu8ubfY3gQQqSyxGHbgMrm64=;
        b=DR+8Vac7UkHzIk+PoHYoY4Nnm65Dgo4g5+yvC/SbjRpoDGcUkSgerpxvjUGzomMIpP
         azN6yE3JD7vvkgUSV335OB91LwQr/xdJo7+PCa6/EieZs7UlbLVXWOa32x0QLPLeuP89
         o/a2H5LvXt+kMZfc7/cmmZV4hJst1y76JmDIRXoyttpyKDMzTVle6aQzlTlXvoxkZp48
         pSMgIVgAs3f1ZEOb2PjuvOT+PZLw8mFxqwDfAwDjxU8KntX/CSQcp72wNqKcQJ/TZKMI
         6cYElSEsK0RLYZgFJ/pG1/NRF10OfJSUZj1lwx5euP2mnlcg/0cvDzOin1kuNaolg5lh
         TPQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795719243; x=1796324043; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0LyIfXrFbfgc1KX44tNJALWhMB7M6d1jCLDWVtkGDBo=;
        b=dxa5bThRnGpnsPVshFVVQTnYsg+LGBpwdqFJWu/R15g0S7DNkZbTmDl1Fk5cGQpNWu
         2Egv23Th2dLkf6b3GQmrwpBPSUzBufqUKCIMoJG+3lUa6T7kJg4ltJ046VeTS33JM17K
         tPL9WzkuLMrE6JEfWLkNN0FB3mRwKNPpYaNfIWJDmR5/H8JSVcvL8UlIstztRiF4s+BE
         zC7TDyUjXT4xrLGkRdOG+4blLljIirDEmzEB6wOsRVw9zmsoFURnJXFncjWW7+IMtaql
         tfygs0LNF4LtNdH5ICwWrBfPuR0tKAnnp/v2rg7RoqvM7lRuVgyeWRU0kjSewf24glsH
         lYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795719243; x=1796324043;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0LyIfXrFbfgc1KX44tNJALWhMB7M6d1jCLDWVtkGDBo=;
        b=N66dc2kBnPAVZUCZFzwyZk9ox2Wb58k5XRyzxqRmewMaZX64CyDjJC/hsKdnR+rbZi
         PwkQ0PFu3iX+Q2J5VlAWLNqIVn9gYVx6BM9dEe64tV+J2N1zhcLu6yVgbfQNFaQn4IF4
         Xcdj3wQbCX4yVQYLXkbAdzhhPrKC9xQCAUO3WmsnxnMoDXlhtENLuSJH91A55mjJZCJF
         vgk8iaZYXy1mAnYkcXIrJpCl9z0jIgEEx2T9y5wJTRtAcOp7Y4PSQkQ0jAWkcuXUBZBL
         DguWRplgPZTllDGvFf7cG2xI8AaGkjU3OTAJEVTBzNfrjGYE5G6TqwsZxy4fR+tmL9pW
         MNEw==
X-Gm-Message-State: APuU4Z8Dmy4M1xPuZGrswQLWO7IO+/bDBo9mM9RbHMmybO3ajEc/BEEe
	oX73pIn1Lnvd67mZwvg17FFS1s5It/5TZTzWDbYe3mZNBKGXxme+Q+c2wvQJS69C+EeUg1LjmBu
	5+6hnEcxG2miM+iTZ0uFcoev8FM0/IKIKx2+pt9pv
X-Gm-Gg: AZFdTZf/WHXryA9A1KSCVCiOXqcwaXPLudkD9EMb0kzUwp3Mw9Z8gArEEtf9TQWXFY2
	LcD9Jc4DCB+MJ0bpX/wjtxQ0KcyIqoDiF2r/g9IhXyZ0F2aTdhYpmG0NwOOnib6iKxC92KKB0cc
	C4YqSF/YYHcgenCDBAnpUWI++ZnDHsFyHAvHBM6VxLZvLfYCcs8mkGdJvPepfUw8YPgYvgSH5Fy
	4+SZyvMmDMHYjFnUWPhUrUtjH3emi+Evu/FpNWuO2AWGXUP2bJ20Y0tOiA0GRgNtmYAcYThAmv4
	iFxg0q1KUb61vS3aXdTJSP/g++1ZcqqdtcWrqAkg33IGVQ+sHVKTkA0m04zX8+z0N0/Wp9qVYZ1
	NdC8YYznlaA7zV7UvkYp3k/1G1b/FG2so3DMABlHKLvqZWXK2CbuJ3c3sCdPxMmxokZhS/NQYZ9
	e2CMoCLVWuNlVmh4OHvZb+L73OcA==
X-Received: by 2002:a05:6402:a592:10b0:6b1:da03:d01d with SMTP id
 4fb4d7f45d1cf-6ba37ebfc70mr11887540a12.34.1795719243392; Thu, 26 Nov 2026
 10:54:03 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Mohammed Rayan <mohammedrah1289@gmail.com>
Date: Fri, 27 Nov 2026 00:23:51 +0530
X-Gm-Features: Aa3M54oOKtpbnoTWOrT6rJCDBvjQw2Vd6BHHz_fdWpfLMiBKXmuPVUQWYnSCsS8
Message-ID: <CAECerH2yi45XUYex7f+ReVqO5X04uZXADDf-g5QDKi5DggiQHA@mail.gmail.com>
Subject: [RFC] iio: magnetometer: rm3100: compatibility for the TMRC 0x9e rate
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Song Qiang <songqiang1304521@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

The RM3100 driver advertises 0.015 Hz for TMRC 0x9e, while
Table 5-4 of PNI's breakout-board manual lists approximately
0.15 Hz with a 6.7-second interval. The driver already stores
6700 ms for this setting.

https://www.pnicorp.com/wp-content/uploads/RM3100-Breakout-Board-User-Manual-r07.pdf

I would like to correct the advertised rate and readback to 0.15 Hz.
The register value and timing would stay the same. A direct table
correction would also cause existing writes of 0.015 to fail,
because the setter matches the requested rate exactly.

Would you prefer to keep 0.015 as a write-only compatibility alias
for the same TMRC setting, or have the old value return -EINVAL?

I checked the current IIO branch tips and found the separate TMRC
bounds fix, but no rate correction. I have verified the mapping
from source and have not measured the sensor cadence on hardware.

Thanks,
Rayan
