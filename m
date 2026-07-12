Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77361A6806
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783882049; cv=none; b=LR5uZsaWeWWqVIkAlA2D5IbMRfaYHXZ3/iVAENbtHC37YxhAmQtDXT6g8Pz+dBgTI085nkaPYMyFq14sVa13QrkXbdZRro9Knp8TcaydgLQ9Ie9atvzWNQUTIRRYIm/cpdWmPTICZBfhbUdEp2kt5Fx6j+XwaHXOj+/pGdmpZFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783882049; c=relaxed/simple;
	bh=fQP/YBsySFNtQfxMRYZ4qvY0/T/PIl+HWLBK2pjiP6g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:In-Reply-To:Subject:
	 From:To:References; b=gVMoLvR2XiN3vi/L20mJYxKn0mw1qtmRuueYbyGak7rA6iEYniJt3iU8ks4GaoaWTWxX9WwNJCUKbftKWvqAyHwvmyb4adVQi2F1MwMi0LkKbttburch5Y64QPOUoHTnqpRKntxq/c5vNZxPCKk9U5VWzWxpiwDYZlIJQzZ+ZLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBqmijTC; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBqmijTC"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6a183eb9689so1478697eaf.1
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 11:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783882047; x=1784486847; darn=vger.kernel.org;
        h=references:to:from:subject:in-reply-to:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BEJHMADCZwvGkL9UEpqXcgTpiI9QPLRh5JL2OavKJI8=;
        b=kBqmijTCChnLKQqGg3+9wJ11Wrt99WZGR+Alb0xjdfG49/4PNKN+NP1fEB0HfAUUV6
         jGdT4wlQJkKQyBc1xP2LZtoLF8Y2nxA4Xf5XpWJtnDpGlSBTH+JU77qwOLNn73O95zES
         /jI68CTkEuH8OkYS6+zyFRM+NhWTkumPupQxqjl4RIvkxXzjEQQtECMGDh15rN59mOL/
         34/QWagbMCFJ23ABd0Q+2ZmkI69AvB29lfixbuM4mabeLaa0YvNETzCi/z7oC+ld5ga+
         Ib/ab/LnoLLjfkdPRamITrkfwQNfe64nx860SCSAnTLQgU2VYcpSi/2SwAX+BiTzGz25
         MWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783882047; x=1784486847;
        h=references:to:from:subject:in-reply-to:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BEJHMADCZwvGkL9UEpqXcgTpiI9QPLRh5JL2OavKJI8=;
        b=nY0el/SoTFwH34/6zbm4biKyZzi08YVYO8xprEZ9jO7eAqgZmS/c1CO9FaF/sV8ps8
         MpAykw+5fcYu1A9WUsB8vWk7IYuxAgs1HeqbGB9n9jbTPgmhDd6vxp6w2RnkteFuainj
         wqjALuScTbBI2TyuXwXwHiA+0l+tAif5jD7xS/Ry5vcdH+kZv/guWbZzxYVGpyBpRGR2
         RcJvV2lCneQWf9ssCgX2srP/DNjzzGqCIDMWPy0U+4y/gwwCpmfxVeDGV6jUBeOT6On0
         Li4vAVOIuHS6AmtqBJr/8RBW14+Z6MhTScnjTDjILgR5DiBgeMCLjp/TwHhDhVKd57tk
         RAiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/MDXCZSPVPDGcCyfDMysI0KJ/2uHA4KsSG5f6GMomftXXcdJMTiePtYSo4q4l7mLOOwpSrafJxanc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeuF9Qm2jDHCf+jkmsfG8QIW9QbVW1vvk90m5A3/6SYxtbwQd5
	QzgZkjdzqE9GnsqnjV3PN42emQIFk2LImgdPcgj5GVJuqMy7NRKVEdGImPya9Gw2dJQ=
X-Gm-Gg: AfdE7cnrnzMAwfN+oqRHgaSbdtPk964lQj7YhA2v89wbwgNWvN8huEb4Id7pETmqayT
	5M3oU43ouePqkvz27P5U4OIKnj7JOSsM9XigCtnzXHKOm9d9lLnhqXCv6wfKutNw9/FcYmrcPTd
	UDbrgJQ5UGEtskvDg678p6Fe5A24bTbFg9V4IR0Xo2TSRyPKTRqftVgAkZShhSJJw9vRQcEGKk+
	OygkwH9Y85SfuU0cIIYnKftrbhZEjeqR0LyroIY8BE/XlyKCYNNZLTjlgNBmLJm4QSp+Oy873nH
	bQcKodi6AUrcZiHeSU3SqRa5N5qP6Ge0BHRL6MUqgAyLhtpahg2X5sGehEEto22ASIyXzQcovOq
	LZr70a0zXpCPdu871ns+iOhLzhQ9UpyMDJbzxWSulhTYA3ZbHP320sulzaR8I5JNjtu2UszbEOY
	9L1LUlf9jz5DmIV3eDMxYgifD7XoXifrO+3daPrko=
X-Received: by 2002:a05:6820:f0a:b0:6a3:ce2:3312 with SMTP id 006d021491bc7-6a39a66e3fcmr4088799eaf.21.1783882046770;
        Sun, 12 Jul 2026 11:47:26 -0700 (PDT)
Received: from localhost (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-451916f31d4sm11432098fac.16.2026.07.12.11.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 11:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Jul 2026 13:47:24 -0500
Message-Id: <DJWTEQ1M40J2.2UGCYOWS66B57@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Tomasz Duszynski"
 <tduszyns@gmail.com>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "open list:IIO SUBSYSTEM AND DRIVERS"
 <linux-iio@vger.kernel.org>, "open list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20260712185237.6a60e112@systembl0wer>
Subject: Re: [PATCH] iio: chemical: scd30: remove kernel.h header
From: "Maxwell Doose" <m32285159@gmail.com>
To: "Joshua Crofts" <joshua.crofts1@gmail.com>, "Maxwell Doose"
 <m32285159@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260712164225.358852-1-m32285159@gmail.com>
 <20260712185237.6a60e112@systembl0wer>

On Sun Jul 12, 2026 at 11:52 AM CDT
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Sun, 12 Jul 2026 11:42:25 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
>
>> kernel.h is no longer recommended for usage because it can cause longer
>> build times and pull in transient dependencies. In addition, it's not
>> being used by the SCD30 driver. Remove it.
>>=20
>> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
>> ---
>>  drivers/iio/chemical/scd30_core.c | 1 -
>>  1 file changed, 1 deletion(-)
>>=20
>> diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/sc=
d30_core.c
>> index f85cdd8bd84f..40bbf26a667b 100644
>> --- a/drivers/iio/chemical/scd30_core.c
>> +++ b/drivers/iio/chemical/scd30_core.c
>> @@ -23,7 +23,6 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/irqreturn.h>
>>  #include <linux/jiffies.h>
>> -#include <linux/kernel.h>
>>  #include <linux/module.h>
>>  #include <linux/mutex.h>
>>  #include <linux/regulator/consumer.h>
>
> Since you're doing IWYU stuff, you should also remove errno.h and
> add err.h instead, as the code uses IS_ERR() etc. and err.h includes
> errno.h
>

I tried to set up iwyu-tool to no avail, but I can send a v2 with that.

> Also consider grouping the iio headers and asm headers separately.
> (separate patch though). The include list looks overwhelming!

Indeed it is but we try our best. Good thing is the more we remove
unneeded headers the better it gets.

--=20
best regards,
max

