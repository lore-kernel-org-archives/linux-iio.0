Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFCD1FE44A
	for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774250465; cv=pass; b=Blv6rVERyDpCpsHPkXfYiUGEMRnIohf/CbsqFtUG7i2xoHsFvsIYFx8R6hTeyYrXn3TWOYJpN5ormoSSRYq0gg9dGFHbWW/dS+0oM+oWf9AYa7RSCBgT5LFkSAkc7HJRt0uH6/Vo0x1elhxUThEx/YJYN725x7Y8JIBCYOCpjVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774250465; c=relaxed/simple;
	bh=lZtkzW+LCKK5osevww6Bmr6rbqgnerwwuGVSr7gDIQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXqUtkrrx6cMEq/SYXq7sJlMnzIC7T/DAmQm7UsoadZPsDOHep8LEuaiHcFbH0EQYrah6Q9SDAocArUe7j+og0X4O8M5QvdJhHvDf0zvxkGke3nOW5V0uK8stZC/yGtFV3PoqSIqX0Ficp9px+OFQusUAAPHmOmRnXLrkdjf7nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hY9AqJy7; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY9AqJy7"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64eb0b66c60so347156d50.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 00:21:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774250463; cv=none;
        d=google.com; s=arc-20240605;
        b=TZC7UZR8rIYk5kFQ+HZ7mUdqV2dRzQZtO5EZFM2rgRw0QzsuEFWgK7tVVzkwL8Ps4X
         iWnrXAwEjFx9exFJBE2viXawaQcaIXfbMRPd1r+MoqSzC57yyiffljFaQutS8W6mz+j5
         PLtxqGc5/E80M/OXVFhlUfP1Yb1k52rGKxrWsXg/xfqtu0cXIyEMWfl0E8LABQ71Sfrj
         3bV6WmZio96SHQN84eNLzivIyBfRsGqkZzhlyy7qoU0Sf1YnwtTFkh3C+d1HxQDINx80
         dIhGokLmMxxSkoky0Dy/doWxnbpEkhWVT9WdMRBIbSZhroVevCpe/sSoTIvwjtnSGsyK
         gJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lZtkzW+LCKK5osevww6Bmr6rbqgnerwwuGVSr7gDIQc=;
        fh=1ZsvYH+lWcH+53u+RzOQjkRTUURG7r6NFTdh9OZgD7k=;
        b=aIMfZNF7x/lMc4zK1CKgjGX0Yk63yhc5tH/mA2v9THAJ1kuYiAtnyWQlteMj4ZEnXP
         Qpr7KtYgjzuBaEfDnSG5ng+tQbHPk0U6lsZ3Qi7csJ7+D9UeeSddKboGOp8hO/FLqaXM
         yuZ3oqORSNPoivoJPduBbna50I/ENe5NamU53CCrZ3V7hpTx1Ow7UgjQCK+/Lwh0fs2v
         jhUEVKUxIG6OvPqddmcIZ2HR5hm21EJcT+NwSONd0m4rU2DyinK2kz4mT1YrpKLROeYk
         chFiIabLRwLkpOwRwSPzayaqMaJ+6knfMiW7z7maSULO+5llFKoQrPrnFTOz6MoflEtY
         KIZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774250463; x=1774855263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZtkzW+LCKK5osevww6Bmr6rbqgnerwwuGVSr7gDIQc=;
        b=hY9AqJy7McZSNFGxrVKd2WwrMtXoWfkPwU1mecCPSER7lOTbNLQ/g12b/4gH/dJG6q
         S0dJuWNcHMejNo3jP24xT16BfvY1/s7Hhpcq6X/STnqaQedjArQD1yC9jK5+PPdD3ZWG
         dX15sNHCGrehXDDfXBlNk4oZqcmh0qyFQBoBs4R3LxZ8XQT96aSk+GYOp34R76bGAvUZ
         1QeHM/ePWTxf4C+NfiEPknwXv7xulr5ALyGqefvrko3YukK7YcafRJ6Nrs7tG+r8OBxm
         kRKVaYGBzmNnEMT+/D9X264HC33z8ja5G4IXV/3y4Vg3SDAY4fvztYVdFb1tTW/M+LlZ
         HC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774250463; x=1774855263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lZtkzW+LCKK5osevww6Bmr6rbqgnerwwuGVSr7gDIQc=;
        b=BKcSm5sF4+zJ1OSdzTVSGVKT0AIKJf7EJLfn1+WCohVz2QT0vH+5hQpgsuYWP3knJE
         8RhHBQYxx0Yyw0VA/KQisQikZTdV+tuBytkS8WUEi8TUW9AYWyxeL2jNsu2Hie8jbI9E
         +W7dMryXDPCh1xi5z5Q1RZkLpWFnJog+hrHvFZ5ecKVUxytjcktjAp08Y90KiHbM40IC
         FV/i/aS8S6S6phHNOwo0wGACAqOaibMHVMVGcukexkVtAsfCdirodhxNqXgz/ZvAXZDC
         pyKkn6+el10HDEQGwT1qVAnyxFwEzh7sAmT5pdvZmFBNteFVt7Vf0pOjAWZPY59mBFHp
         r2fA==
X-Forwarded-Encrypted: i=1; AJvYcCWDaF9oldV+EePh2nMAxOQL4RGtJvJ5YIsr9EQVok8cZS7hjYiM1GZiDkpecf581palR9rXUXDxxTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1eHNXDpJGHrLKG/yxzJryguACoc7QbiIsgwY/nBR4QkL+rPSX
	RIhuQgbbPRAlknNiM9NE1cIj2nGN2BzZnLx5RZKaFDJ+CJMMGFr8xFRaRAUEluCpgj6f/uZYhp+
	mE6gCTyFHwCn6c9T6yrmVTNwgpPQkep4=
X-Gm-Gg: ATEYQzzK3Gg/UBTQZdFtxFhOYAJxAN8BFtvvc9vxzq3tOyvGcoDllJlIrF5Lqvrqv2Q
	sk1Q9cAsTIYQn1Q9nhP7M4cc49D7qE1dB0so6kEsV+PqErZw81elDTp8LpBWh2iSaguMbatx2Na
	ZWeYGq+pogRDzsZ3lTVmn+G/UA3kwQe/c1UArjdYYBfgmIdTOz36tDCpbOIgyYZVoQzA2mRs6qH
	3iZEVRJVlF5BgYVdNoVI9eae7HGDPFun2PwCjZQo1QWTnr31mLP4OPPoCbcRTruOwMb+w3AoIqJ
	j4oKa7WA126WXHpjZVLJih3jh2FwNrVo1wH8K6q79Wq3s3BO3USnHKKRcwSGgU8ZCKb00fBsSbI
	lmn/3hALYlFkSgqqX/zkPKg==
X-Received: by 2002:a05:690c:9c0e:b0:79a:3f62:ba0c with SMTP id
 00721157ae682-79a90bf3ee5mr89648147b3.5.1774250462726; Mon, 23 Mar 2026
 00:21:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314111250.223788-4-giorgitchankvetadze1997@gmail.com>
 <abfVKws8hF4bUbv5@ashevche-desk.local> <20260321210833.7268a3b1@jic23-huawei>
In-Reply-To: <20260321210833.7268a3b1@jic23-huawei>
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Date: Mon, 23 Mar 2026 11:20:51 +0400
X-Gm-Features: AaiRm50ySSwbKDnewMbMm2NEzQOkdIpF7MwNgPFXBuTHzTt_d8xzw9hditQjDyE
Message-ID: <CAE7dp2qUM3Sza1endobT44VqAdwoBFqXb77MAfaFK1h8tJkOGQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad_sigma_delta: Format block comments
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, antoniu.miclaus@analog.com, 
	lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 1:08=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> Anyhow, applied as is without confirmation of Andy's question one
> way or the other.
>
> Thanks,
>
> Jonathan
>
> p.s. I'm favouring clearing patches this weekend even if not
> necessarily perfect.

Thanks Jonathan, and thanks Andy for the review.

I haven=E2=80=99t done a full sweep across iio/adc yet; this was a local fi=
x.
Given how broad this kind of cleanup can get(fixing formatting in
multi line comments in the entire iio/adc directory), I assumed it
would be preferred to keep the scope limited rather than risk missing
cases in a larger series.


Regards,
Giorgi
