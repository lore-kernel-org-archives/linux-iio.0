Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E642BD01B
	for <linux-iio@vger.kernel.org>; Sun,  3 May 2026 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777820835; cv=none; b=LAmrQRYlc2hF0RaZFPKVlPMOxVK8ADCNbuouA/UfS8Cw6BiIDC04V4X5Zj22kYKhC8zcCuJSVW8m2RjO7xlAyE6+DgMRtiVNsDBpc9qm2hahf6+f/zLa2BbIp/aBt0vK45nFpxnEjsy91eAKbp5vkdvl7e+1VpfbK2DUhRvk7Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777820835; c=relaxed/simple;
	bh=J28qUt42U2ywe8Qh758ft7/XmQc3VZ3WZ01C48q0Ejo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=l0ckBYeb1I45zJ75BBGo/ISPZWQwZcIxlMm1M72WnO0FaeP6vb93nByRIt3S+MGCQgeuDl/qfrnhmcru9IqhZmvhfl01M229YZNPjOCvfl1hdLjn7D/KugvJMYjP95HZLZshEFa5RA/5yi3D8dsizmsdYrph+wwsf4xQY/hlvy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdXlPos7; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdXlPos7"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6949f3eeaf6so1782079eaf.0
        for <linux-iio@vger.kernel.org>; Sun, 03 May 2026 08:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777820833; x=1778425633; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJ32wrJad+vJgf55WvDC0i5Fcg2nT0atoJX8MKvBu0s=;
        b=OdXlPos7ZFUj81fTq3fGaV8WxCutX8JtZbstiAz46nJV4xDe/84zV43ZrGIN0sQNH5
         TD16bmoNqhZEqNEhFSrIwIBJL0JrUT1VrPFCsHhfFizfzWfp0abhC9vafgAaEHyXnZfa
         KUZjqO547wIimratCT+Puq3kUnhd7ol0lpvlZmmzsRaIVvZtUlKo+X4CHh0PmXE6tIwr
         SlT2Ad63sm8WrmQDeiL3ux+AN75eFl+xrQWC1uzZsgVGp2KtCQXIiVGSnbrAKBVuQfaj
         gVP9SlEazrffkIElGwBvqIxi/ZlyRYHblacNOYt7i06VEJYBI066JbVTqF//N7zuCLi2
         SpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777820833; x=1778425633;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJ32wrJad+vJgf55WvDC0i5Fcg2nT0atoJX8MKvBu0s=;
        b=PMhum09DjUxgcpTtAlVsxMWQODiGx/t+TROo8x9KErl5UyHn9jqFNxIQ/hfQ5VSF6t
         tTDgrRxIubLubcO2kFCFZdKWIuqqKwj5AIJUZxFbWxzKky6dTv5w//YhseFJK9eBj5D1
         ExEy8r/zVXrjlqgTSJt7Ka8/6Clb4Rf9mDTIKpTjOTp8N8TBGIaXZqUti2yHI+/4iarh
         6h2zGGII2LntsAd5FOD1xjopcIu4Y9oDZf0uwJyOcmNwOBfrjVbmqsibEGtz+o4l40ak
         M0BUg3LxrWjm7gdU+3WYG7CJkf+HK4dapKs1SeYF/4yGTgp6k20YHxOjZomcPAstt/bP
         LsIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8mPii/zwsati995juQ197n7WB32tcVCkjr3GiAY6NuTSbVQlCutbnmGmhQyFnOOQJwJE7zI1AjyHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX/kgvbv8McaYyoMdH83ZcLhJm1t1UC0WBx+NaJut8F3TyUDZl
	MyvJCHbB1fT4ULSyv9XAHrEoBOwmxDeY9znIzECGlyTBPAf8JU2aBlc2
X-Gm-Gg: AeBDietl9LYYQHluVMDtuokIGJSDaI02pH4gCyZrilW43AfQ+JhDGm6aGymBFFPJwNh
	LWfb6/NlRsnHEz0oD4YjvgTOntc2FtqPxI+tcjfHVr0VhAp8EPuFgOcWltN+f75k5ULXT+1zcuT
	ytyK+sa8lgYeFFxDYP3ATcEZD9tStPF5HEk4N02O0iSxz9+gl98yV3icAsmubHm/zoObGTF0CHx
	9YuCfLGhQgYXdhuzP0fT4+o7+1Rl8Lhb5wniKFVfro8AAw0P9ZsT/Jpo4KVIA000htNVx7wJGfu
	0jYWJKifkM1NrbelVodysY62gzeWVCi90EOHtF8K6OEww3NvI9dAlq6OqDvXhWa2gEL4U+ztYp4
	hMtke94RhIFTXRkx131tfnxEUBOkEMOVO2geGxh8xHVwK20bwa2CCrp8ruQZH3DDwhqgG2S7FQV
	EY96kiuKAjwDmfJMJd2Cp35lRpErgOLQ0cKiqw8PrVzYyrueQ5RPPwA+6plYBW
X-Received: by 2002:a05:6820:1352:b0:696:1b32:f14 with SMTP id 006d021491bc7-69696ba2752mr2762840eaf.14.1777820832679;
        Sun, 03 May 2026 08:07:12 -0700 (PDT)
Received: from localhost (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69689440f5asm4758594eaf.1.2026.05.03.08.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2026 08:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 03 May 2026 10:07:11 -0500
Message-Id: <DI94VYXA009L.2BNJPUI3KZHF1@gmail.com>
Cc: "Angus Gardner" <angusg778@gmail.com>, <linux-iio@vger.kernel.org>,
 <linux-staging@lists.linux.dev>, <gregkh@linuxfoundation.org>,
 <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] staging: iio: ad9834: fix probe error handling and
 comment typo
From: "Maxwell Doose" <m32285159@gmail.com>
To: "Joshua Crofts" <joshua.crofts1@gmail.com>, "Maxwell Doose"
 <m32285159@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260502021815.3953423-1-angusg778@gmail.com>
 <DI8GD8RZU94B.Q3VZJO6EIP3N@gmail.com>
 <CALoEA-xEv9T4tv5fOYEh8ts=3rGOQMsW1ZrHVBbK8TVPuFvGFA@mail.gmail.com>
In-Reply-To: <CALoEA-xEv9T4tv5fOYEh8ts=3rGOQMsW1ZrHVBbK8TVPuFvGFA@mail.gmail.com>

On Sun May 3, 2026 at 3:53 AM CDT, Joshua Crofts wrote:
> On Sat, 2 May 2026 at 21:54, Maxwell Doose <m32285159@gmail.com> wrote:
>>
>> Hi Angus,
>>
>> On Fri May 1, 2026 at 9:18 PM CDT, Angus Gardner <angusg778@gmail.com> w=
rote:
>> > Use dev_err_probe() for the master clock error path instead of open-co=
ding
>> > dev_err() + PTR_ERR(), consistent with the avdd regulator error path a=
bove
>> > it and with the equivalent driver ad9832.c.
>
> I found another dev_err() call in the same function, maybe change this on=
e also?
> https://elixir.bootlin.com/linux/v7.0.1/source/drivers/staging/iio/freque=
ncy/ad9834.c#L452
>

Shoot, I seem to have missed that in my review. Nice catch.

>
>> > Simplify the -ENOMEM return after devm_iio_device_alloc() to a direct
>> > return rather than bouncing through a local variable.
>> >
>> > Fix a copy-paste typo in two comments that referred to 'AD9843' instea=
d
>> > of the correct chip name 'AD9834'.
>> >
>> > Signed-off-by: Angus Gardner <angusg778@gmail.com>
>> > ---
>> >  drivers/staging/iio/frequency/ad9834.c | 17 +++++++----------
>> >  1 file changed, 7 insertions(+), 10 deletions(-)
>> >
>>
>> Patch itself looks good but maybe rephrase subject to say "Use probe
>> error handling and fix comment typo" instead? "Fix" seems a bit generic
>> for my tastes, and we're not really fixing anything anyways.
>>
>> I'm not the final authority on naming so its at the discretion of
>> either Andy or Jonathan, and maybe Greg. So either way,
>> Reviewed-by: Maxwell Doose <m32285159@gmail.com>
>
> You're mixing different logical changes into one patch, therefore it's
> harder to review and harder to keep track of the changes after merging
> (e.g. running git blame). Instead, you should have a series (named
> something like "ad9834: driver cleanup") and three patches under it:
> 1. simplify -ENOMEM errno return
> 2. use dev_err_probe()
> 3. fix typos in comments
>

Of course this is undeniable but I think the other changes are so
miniscule that it wouldn't matter as much, but that's just my personal
opinion. Angus, you should probably split this into a patch series.

Either way, I still stand by my reviewed-by, at least based on technical
correctness, but make sure you at least add the missing dev_err_probe()
call that Joshua wanted Angus :)

best regards,
maxwell

