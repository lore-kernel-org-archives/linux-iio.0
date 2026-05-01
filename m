Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575743CB2D5
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777650458; cv=none; b=siEReOgXVaf/Z2nnDrlecClnrwj/s8ffcz02U+6WkRPbdZUP0WSQgY+QHEij0PlSXJVJRFwlZZfOTZ+xDeaaWqsCeOQo9sFUfc/5Ix6umKW1csaofJm55BcM9ZxEB6DRE+WpdspqDH+7ltzDiyf7V8TUJTA52lvpPI5pxzd3QPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777650458; c=relaxed/simple;
	bh=dBGR5oPl4LoWOunaVjYZCakcMx8qQA1CoWvrOZzKoSs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=t06f8s3I2u55WCwZrqGIHnWtW886gH0qZOHwp3L4bciHUZuuoLUQdR5Nv4x9Zbjs/MjMuHVRep/d3VysCxsiBS5quyDIcWRIaGXogRDkbxgaA7Ocq7TmZnuGcSxCEu7QnhtKVTwvLR2fZUDrIxt6jLcFRivc8BOulwNd85kbHHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELMcQCy6; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELMcQCy6"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65c305f381eso839814d50.3
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 08:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777650455; x=1778255255; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBGR5oPl4LoWOunaVjYZCakcMx8qQA1CoWvrOZzKoSs=;
        b=ELMcQCy6f7L/zKidIkIoxSDUNbqgxOSHA2O41VS9Z/ETcozHdtY4C6Dui6TGnot7mq
         KipSjJfOtbd4KK3ZZ0yc5lzdZh8iOA0VFdq9VJUSv5b7vDo1Muv2FOsdRcYa5BQo3+c3
         kqmN86Tajg/yljkpNaZoTpssqvQxDggtz61mU47gJ2HT8oR++7xhzNJ0ggUEk9xLCVbw
         EHXarEgat9Zf4CMtkJRV8mqymWE0sLeJCNiKCYKO5QIWWhVbiC1JWfG/kw+WoIJypZre
         Y71f0iQX9A82C/W52oDSH54fvyHmUTCvtV6FcSkai9uzPDtM5uQbnoUHQGXf2TsxgQDj
         Ys3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777650455; x=1778255255;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dBGR5oPl4LoWOunaVjYZCakcMx8qQA1CoWvrOZzKoSs=;
        b=TjulM4SLO6KnQt3H1EIYmTjjwifW+7rNsl5NLm4637eCrjO+C0yZ/KcYOL4iHzTmUe
         L1RtE1i02lBsj6Ouefa00xxAStsgYJjjzPWEhqRLvBRrbhHja319vsJ+NCBlnSsJJIX1
         /woj4RpH2yvXfkpQRtl9+zUaRaVO7VTAZmsbR3if35vFczdZFtzxpmLl/myPE9cM9kaM
         2lvnO5HNKwA+7cin2/FR7bpmlgftSY1xBb5YHf1XPnxYmd9umLCN22iq8D4Uf/CH06Rm
         y9VbNkaCI+NVLisBSteqC/XFmwUDq8eDatisXL5di8obIt0Y6NqhWYLRSTIGrwdeNDBh
         AEuA==
X-Forwarded-Encrypted: i=1; AFNElJ+2DiTpNn47wttXA051EB6tos3jLfFteYBO4/V7tEIlA20rHKhW8aHSYEg7c8u+T2VXNhZyAw76Zx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQgPifbmrYBjEK7OxDMCFLS7rLy4GSUkiozEW90CeRPBvuPiP9
	rOR8OYEjt3cKinAg5p6wvtNRO18CGJUEDie0Tbf2uR9uofYaK5l70Dqu
X-Gm-Gg: AeBDievvSRYn9HXe1tsJRrT6zE7ktabgASNoPWt3veWjmtlJiXib1+PAXoEiux8NZaJ
	KqqejUkazVYOZPmh+5VhZzcnSfIU7mMAVnOwMTVtDVPmmFT+Xk1tZ2EfpZcpxmsUc2odAEwefMc
	rKeq6q74r394OwBe9kcpg2PTzqXbPXFvjnEqYEf20HM9L2niwx0R8EAaTsu/9PDsMP4x+/BHyEK
	45PIQSHIt8RH9ByeGIbjncnaeMUM9rddVIt2lP9dIhAtbFYGyXwFSRvb8jVdA9okhiIdayEpHbE
	eKIb/AeOud9UJFfkIO3OwEfLZ8r1euSkVsFJ3lL4pxRKQMrR3h2C7sDN6IK6vSqFoYcUVzkgoUE
	oEogPzS21BkfNGL50QQ8EIEeIegrl9B4YVjpc9ducd6r2QGGNvtXZJ7YdkUADPtTc5zLYYmKRv+
	X5/8103ivb3Cvb/AasTEEs+bR0CKHUzSCL0JoLxqL5vmRSAWc=
X-Received: by 2002:a05:690e:c46:b0:656:fc53:12df with SMTP id 956f58d0204a3-65c18fc1132mr7545311d50.56.1777650454958;
        Fri, 01 May 2026 08:47:34 -0700 (PDT)
Received: from localhost ([208.185.137.148])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c2e1a1700sm1333297d50.6.2026.05.01.08.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 08:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 May 2026 10:47:33 -0500
Message-Id: <DI7GHSFZGAL4.1EFUSTVRKWUBU@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Arnaud Pouliquen" <arnaud.pouliquen@st.com>, "Mark
 Brown" <broonie@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "sashiko" <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2] iio: buffer: hw-consumer: fix use-after-free in
 error path
From: "Maxwell Doose" <m32285159@gmail.com>
To: "Joshua Crofts" <joshua.crofts1@gmail.com>, "Felix Gu"
 <ustc.gu@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260430-iio-buf-v2-1-84c2231dea5e@gmail.com>
 <CALoEA-zC9je3xsq0+dqG5b-EiVM1DiKbgAT8JvtALsNwLpp=ZQ@mail.gmail.com>
In-Reply-To: <CALoEA-zC9je3xsq0+dqG5b-EiVM1DiKbgAT8JvtALsNwLpp=ZQ@mail.gmail.com>

On Fri May 1, 2026 at 9:19 AM CDT, Joshua Crofts wrote:
> On Thu, 30 Apr 2026 at 15:29, Felix Gu <ustc.gu@gmail.com> wrote:
>>
>> In the err_put_buffers cleanup path of iio_hw_consumer_alloc(), the code
>> was using list_for_each_entry() to iterate through buffers while calling
>> iio_buffer_put() which can free the current buffer if refcount drops to =
0.
>> The list_for_each_entry() loop macro then evaluates buf->head.next to
>> continue iteration, accessing the freed buffer.
>>
>> Fix this by using list_for_each_entry_safe().
>>
>> Fixes: 48b66f8f936f ("iio: Add hardware consumer buffer support")
>> Reported-by: sashiko <sashiko-bot@kernel.org>
>> Closes: https://sashiko.dev/#/patchset/20260427-iio_buf-v1-1-2bbdac84464=
7%40gmail.com
>
> FYI, Sashiko reported 2 additional regressions (neither introduced by
> your patches), one of them critical. Maybe another patch would be good?
>
> https://sashiko.dev/#/patchset/20260430-iio-buf-v2-1-84c2231dea5e%40gmail=
.com?part=3D1
>

I think one of the issues raised by sashiko has an active patch:

https://lore.kernel.org/linux-iio/20260427-iio_buf-v1-1-2bbdac844647@gmail.=
com/

and I think they were waiting for Nuno to review it, since they noted
they were on a "wild goose chase". Thus the only issue raised by sashiko
that would still need a patch would be the OOB issue, but I haven't
looked at its explaination thoroughly to see if it's hallucinating.

Anyways this one should still be good to merge.

best regards,
maxwell




> --
> Kind regards
>
> CJD

