Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793292770;
	b=f60osgZDX+2hrAYi45OxKG7SpN/mkHLtdaQAYPoXesPQtagWMTdQvvrtwnJDNaCp1xOl
	 bPyxALxGWo1wmrt/SJkhShO/1jc318OlLWokxYfbgZcYI991G3bNdtZJNfRJ9/BoXGLtR
	 kdzPStn9YB6PUQ9UE81Qbzk07/L6Bfyv5FV6BxfCXPNNCfep0YASfNKtUtkNzMfnYysIw
	 AQM6k39x8oqt/0uBRwa5VLSwmD7axb5C2K7eQ2GRApokP62wY0FwR29wPFIFScLFRNS+h
	 8QtxVpX7ip4VMOln2jjFMKnT8ppbIeROKPxdsRTNMlVhzkbhbQU77E0UTdbx32FzMbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=J3eBP1FSZq6Mi86jA3nq1zI2uuyjuit66TFokw0sSgU=;
	b=IkB7T0APu8NUz46HnvPd+hUHgXp5lhseAnnQnQMsThEpXSNBtexLr/7sur8ZSTd92B9o
	 hcdhR3WfMI5QuqYw+t9M+NavFL+MJqUgbXJ3/x2QTtmdWL3rDt1cbeGEymexWGEXajpzr
	 pZVXbNktJU1CM7AGCiUzzxN9ZUuP+4Xv7Tb64MlKFMBB2y2XEiyR3mirqMLNGGTexoL3T
	 JzSNB/nJduSzE/GSalFM5+9NQWyz5qzmdweS5WFAoR/q4+Zlik7/dZNIzkv+b2lV5idZ1
	 P4VRis3ytVXFdSnQ5eGu0h0DVDI84OAgJby4IaGcGnJXjxvI1Oxx0WrGUzi0G6ODb1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P5oO0kw8;
	arc=fail smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EAA606A31C
	for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 16:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3EAA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P5oO0kw8
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c49df71182dso135914766b.2
        for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 09:52:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793292768; cv=none;
        d=google.com; s=arc-20260327;
        b=QvDOYzLK8kWsUlc0EmvpDbGHrLl0oUE+qj5Mzft0JtMd0IyqCxrdY8ivDuOmf52Ims
         rMgYMpKJLpvoEqGDLMzj9KXWAGBj4xAdBRw0dRnIvOMdGMANFYncQqgzdNwQZVDoKuYD
         WK8a9sq/hIIGlIInhcAzYlxhuaNfJ5KD1cLG32bJXvV9Xfe8X6bmgJY+cq6z0uLc0XzO
         /micm59yeWnMoK28QEfnb63xDGIew7srGe0Ot6pP1in55shijge7wmN7r7hl/RY7n/QL
         +F0mHdrbX90iOk53Nf6tro7B3DgGF1h65ikRkRGlwzNUZ+5yd/slSnO6PG7jvTBgltcw
         Mo5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=J3eBP1FSZq6Mi86jA3nq1zI2uuyjuit66TFokw0sSgU=;
        fh=UzNMk5uWOHRggJ9FsZbdBH97OsXtUpDF6JV/CgLGu0Q=;
        b=l3U/MwvT2oe9xtmuQTIIF1meFTA2HWTbI5lOk+EX82yKFC4pijHhfGO87dDrNt58sw
         lmJpDnIDNHkFcR5AMAgjnC7F95l5E2SjoKXNFkDiq16iU1RrSRdI85bH5Fnn7A7qSSVH
         J9S2iKDYXAJ0RKpjivj96gXoZC2lLdoOxzHlDvnDq2PWSqTDXlqqxlijxWIJ+VeCO9PW
         NELbXd+jUjNdKSBQGnLpNc8OECYDosLqjVshmPLsrF4S0cyQqU82VE/IIVA0dV9dfzjo
         MvG3sI9tEoH/RvXxTOxDhGuZXOUj1qMA4bxPtqjlf90VU48qq7kevmKm8N7YLP5l0nPu
         lrwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793292768; x=1793897568; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J3eBP1FSZq6Mi86jA3nq1zI2uuyjuit66TFokw0sSgU=;
        b=P5oO0kw8dmFfrErB6UXJxwaH/5rKe0IGwxP8JMcShJKUNiRynZmPmO9wodLtW+GgEn
         4qYC8+ytkp0IuTFDrBQS/Z25E8pmNiQpsVH1N3nh0RZYGStKF5qu8r9LESprQ26PHS6f
         G9mTFL6eNdxnjEyuBJP3leMyKAA/eI4S+0RiRBbLHp5601JqKn3GQYC81k8v8ud9FmTe
         +fE2I/YfbuPHqVBIVjBiwt7iX0AVQRCsWyW4g9iDu0b5pzd/rta79EoS7TcoVuff6mNf
         8KEsK2LLNKLveJ6mObhPJOgtMF2tI2aYN2ubLHhA8DXBBlfyaGVogRp+ixCrcg/Fkg7j
         oEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793292768; x=1793897568;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J3eBP1FSZq6Mi86jA3nq1zI2uuyjuit66TFokw0sSgU=;
        b=Mv+tEK91hwIh9el+WEo88Scn1vQMyIapnZvGsM4SgCT6pHZff+uGM3peAizwCTA3wG
         O8jk7yZCH8WTwfXLi8QKscGRFq0SMg1rE+XadDVJV6xBjAsvO3aKgzeRkWgYSBcD6LBQ
         wvR+F3dwHTlJ0anNArO0ux98EUiD8mgy5ViP7Jkm4fzQnyFiN4hsrr5paMngNAkqGYxT
         PhtKw12uO7MjFDvrqsJXgfFEXoVfvJ1pIVUDfH/u/BTT0lEdmJ928bh0uKxbn3Ybe3n7
         RHTNI5rZP1WJVGLB1vgNCn5Z0a+oFxhFxJJupli0kKARbu63/MwvzBujhwURkK2CGC/Z
         lirw==
X-Forwarded-Encrypted: i=1; AKwUvBwik/4q6vGo+YZazHnODycHIS0Dcxbi8ETfDRTToRpBjrU+ZO9lJaZDGbPo/HnouzBMnpqS+heixJU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWYFnl3VMf8hlmNAtu7l3VIJvOh4U+Dcf8PxeFDAffB11BI2Qb
	dubZFphfh2f2rO3m/fWJw2uO+AQaaIJr6e1GyriNzF6oPqLRQI+BYiB0Bgu2oLWMwt2k6/+5atQ
	vHwhC6W0kzq5Ftk0DCSH+8JDnuVZZVB0=
X-Gm-Gg: AYBFou3+WryiLnH70CA97zLoxll02qR+QO71NQy1wP057qPRPuuF2QjTd8jf5P1gBvx
	PjIOq3Ug75WkoMEd6K5pAr4pbdiRnkGR0abwa2F7Av7GPHsd1z5rPCbBv3uFBfB9ouJhGSVRXQM
	DcgxqZx5+twot6voBJPw0++JUJabz+lCohg43DqvTo/q16AJayULl5nzYpZN47tzcEZDO5ZLdKx
	wvZWMtXDtLsmUe4orYb1m8xpOVkm2Q1avN9zl6we4qHPz0vZAvV7lD2Y9AJBsYQEQ6mnpktVXGg
	0+Rc+rNleRufbafBws2ar+XQn99OcFD0ddxgT61b182u/OvavSQgoqRWDbHC6DtL+0e0i8BjVU8
	G/5HdqGh31it2+AOWoFGah3xlkxOj4Ztqi7dTfS2ctSDXp+d78FQB2KqwzQI5q9Ibf+nZBFw=
X-Received: by 2002:a17:906:ef03:b0:c40:9b75:84af with SMTP id
 a640c23a62f3a-c49bdec825emr498179366b.8.1793292767994; Thu, 29 Oct 2026
 09:52:47 -0700 (PDT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260831151235.64076-1-notmissinge@gmail.com> <20260831232157.27037a5e@systembl0wer>
 <20260904042215.0e21cf29@jic23-huawei> <0d584595-4479-4116-a52b-710e01f20bb3@gmail.com>
In-Reply-To: <0d584595-4479-4116-a52b-710e01f20bb3@gmail.com>
From: Not More <notmissinge@gmail.com>
Date: Thu, 29 Oct 2026 22:22:36 +0530
X-Gm-Features: AclHuK8tyP171zmJPVN2na5ixJzhMFpz0rZQDV0kr5elFfSLJ5pzv9c0LxVy1pY
Message-ID: <CANU2TT4Ycx9Qjc0pY0s6xmENkdZSRhkOofs0sonWzPxnJCnpPg@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: add SGP41 driver
To: Lukasz Kulga <lukasz.kulga@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>, 
	linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	Andreas Klinger <ak@it-klinger.de>
Content-Type: text/plain; charset="UTF-8"

Re: SGP41 support
Reply to:
>Hi Akshat,
>
>I'd like to pick up SGP41 support, taking the approach Jonathan
>suggested above and extending the sgp40 driver rather than adding
>a separate one. I have SGP40 and SGP41 boards on the way for
>testing.
>
>Unless you already have a v2 close to ready, I plan to post a
>series in the next few weeks and will Cc you on it. Your review
>and testing would be very welcome.
>
>Thanks,
>Lukasz Kulga

Hi Lukasz,

Thanks for reaching out.
I have a v2 nearly ready (binding as a trivial-devices entry with
vdd-supply, plus a separate driver). Hardware testing on my SGP41
board is still remaining, so I expect to post it within the next 2
weeks.

I kept it separate because SGP41 has different commands, CRC-protected
two-word results, a NOx channel and a 10 s conditioning phase that
sgp40 lacks. I'll explain this in the cover letter as Jonathan asked,
and I'm happy to rework it as an sgp40 extension if he prefers.

I'll Cc you on v2. Testing on your boards would be very welcome.

Thanks,
Akshat

On Wed, 28 Oct 2026 at 18:43, Lukasz Kulga <lukasz.kulga@gmail.com> wrote:
>
> On 9/4/26 05:22, Jonathan Cameron wrote:
> > Whilst it should be a separate patch, the route here to use
> > trivial-devices might make sense.  Only thing that might be
> > worth documenting would be vdd-supply.
> >
> > I'm would be looking for description in the cover letter of how this
> > is different from, and not suited to extension of another drive
> > such as the sgp40 (obviously there are more channels on one than
> > the other so it isn't trivial!)
> >
> > Jonathan
>
> Hi Akshat,
>
> I'd like to pick up SGP41 support, taking the approach Jonathan
> suggested above and extending the sgp40 driver rather than adding
> a separate one. I have SGP40 and SGP41 boards on the way for
> testing.
>
> Unless you already have a v2 close to ready, I plan to post a
> series in the next few weeks and will Cc you on it. Your review
> and testing would be very welcome.
>
> Thanks,
> Lukasz Kulga
