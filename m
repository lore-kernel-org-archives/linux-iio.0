Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AFD2F39C2
	for <linux-iio@vger.kernel.org>; Sat,  4 Jul 2026 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783191482; cv=pass; b=PUAwzyneibx57YsbeqTB3EnAnhWRYF8j4X9eiTJWycxcxgkOHSKZSs1KgDNx2yHTqf1TlZ5td8tzDoA3zed9Dh7wHHHk0xBZxlVVHr7mmYAkNdA4ppRAzJwdfvrI21VHH0gNr1Ei9hxBWaJV79ux60SlNzQieUvCMjUE5MVR0xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783191482; c=relaxed/simple;
	bh=LYzIfE4Od8a0eQSAsCdf+roQTXs95nJAd0VoTdYsd/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtWSvHoQPujJxsV+gDPu4QLd7FSia6Ri6xnWF2XiaZ1HU2t69I6nS3nIPEPeNVZWfUBGbU4vhFAAnucLIUEWAMB0sBxGVl8cHPVVkjrLqRP848Rhn5hCVKCEawJhAP47z66aqnWv6Ffm6F0RZcALaZm+wwdzGSKyypbrgasGJyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcxZg7ix; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcxZg7ix"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c08acccf4a4so189894466b.3
        for <linux-iio@vger.kernel.org>; Sat, 04 Jul 2026 11:58:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783191479; cv=none;
        d=google.com; s=arc-20260327;
        b=oTFAM6+8wsBZioZPF1bkUKxdFIcpHb76vedKzyd9LkX3QqOjKeCxV8izHrM4Fk2+BQ
         Tc0XYsCUirOAt5WL2PDU07t6nFoT2o+1ocX7Fy7IDN4d99kWl0QPtzcMGztlnmGBhyJe
         RzJ8VRuWu9UCkf7rSUERB8g1OUHN0I5O7xPDMAW2z5QpT9VH2/NjGytvEywGRNn6TA5K
         o2oP1Q6e3YGpK6mnmZ3ktZbqyULz20nbtQEpV/41V64VEFKLqGy4HkAlqIC1uaNhhtUR
         21VtPC4GccDIuaMuUW67+lrruHlPy+7uhHpLwKgp0UvsFLK5rRWFyOzl87xlhAeNWWhi
         Rw5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LYzIfE4Od8a0eQSAsCdf+roQTXs95nJAd0VoTdYsd/c=;
        fh=h+U+1UjJy2SJQ8ZNa1xF6nZxAaZC6dtLWVSX33DfG7A=;
        b=NTUkT+A/CM/5mPg5IwuQpyQifU/cuGBTx44jNB2tlKwyq8X93MdDWi4scCISh6a8tP
         AqNSKPbucVQFyFxXkPTSHUg0l4kKs5SGU2M2IOvJ9WDXbDTzjfl3D0NVKJ8CJ6OMgKRK
         spMKaUaHG6CVDdWOMR7wnTeZwZO5zLR41jpywAbWvOBUpz/2r9+gKG0j+d03NqWE8BZD
         mcKfv9dLNY8qcZRPATnWOmKbzaC76XTAw9niaEZyjgdRiOiLi4Ku4Bf1O7b5BPexpBty
         C7H73kw7QNXNAxwEPGsKZAYsr18V/vCFzulwZSu/mEYV7/rR5BCgj9n5VKwkT6+4Wo7e
         u2SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783191479; x=1783796279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYzIfE4Od8a0eQSAsCdf+roQTXs95nJAd0VoTdYsd/c=;
        b=YcxZg7ixjFeumUjwzXoRg3xmS/5k6X1OZiYMd2MJw/A83FUOka8iWWtKjky4DVd0fZ
         C21kNXjaCoXASMA2luoD08uxBwSgEI/JoE/HIec3youtFTgqfG5jyb6ZfQ4KSnGFIpQw
         Hr0K1UIcXDOOHQVpvm50CLajkwqWPw5wgWcn27jEqQ36O2VPX30Uj1Hr1kpJ4shBSLxf
         3R/ItnWQZB/oxHcsf6I8e07le4MIu1/ONA2Y6DJ3ELiZPNLrnbd1I33VcAqeAQhzQzX9
         WsNr63CTY/Qus4WGtM2woBPSyQpK1C55SuayK21+3coq2ziQq0Iy57qMDBrXhcPt5bUA
         DIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783191479; x=1783796279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LYzIfE4Od8a0eQSAsCdf+roQTXs95nJAd0VoTdYsd/c=;
        b=an268KMidUZLJybLN5TEO32RxNukk7WbfJT9LrdDh4+jqcJMEm0QEqiPxKzAlPgrEj
         FV5o1jx1Ip9ypAesHLpyC3rDhAZm6PeXCz63UJedjqPGiyZT5FyQrEWSJXVArlNYWXN2
         vWiV8Iqj7NicsgOwhN7/mt0L7Md5DUjHbYxyoKo96hcNqIFK1h6hc+j9TSo38BOo3NFW
         6jWTgefZpMGYs2ttpah5E5SvGlOcCUS6FJRZwY9VGa3Eg8DhCJ7sU8pZciV0h9bz2Yml
         Cy2Jp5L/tF6Sa/q2TGxfPUOZ5UaVdZCn7DIINkwCbtkt3sGFTL9byFSsxTj5TVVqF95s
         /4wA==
X-Forwarded-Encrypted: i=1; AHgh+RpWoRzydwfzZvMZWmYJZ6ALzvI/m+pgsQzuFweJV6tcr3vDyQKna7VoWKbWbZBqrQDv+/Nw88HmQ3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxtr456ma3AyWYXYic/zkvdgNz7MEYA1uq/Z9ui/9Jm6rskuXd
	wpyA+AT5SUPXUeD7vSv0TmntN1FajsQJwPEf42i3Llga81qtc6NP2G24Vl0lXbWs8dabBnYqTU3
	o5L0IEEhXFTvyhYgscu7jm8jpq3qRNhY=
X-Gm-Gg: AfdE7ck9W204vYgsOj2BdDzlWfV/7DHd7WHwA69l7RpWW97Nz1O2xDweEJ1g8jcAUdO
	OZn4VqJuEAgaPE7kfB9qBi8puuNybwi1wCu5W8TXjcu/2e36HHypvYaPEKd8hf1PeUsco4KqU5F
	O0GLHT7J0PukG/DyAUqCEzFRXD3gQhig8PpUPgyRwpb/fWnGF2d15ANxBMruPG/9tpTbSSmFouL
	8Ls097KHjnOTql44C8KjdnBpPt6ezNW0fvJkh/dJKU6pQOdmFgmWWDqRfkKisrGFFeyxkyFXItc
	csNwlEJNd4PO4E8pswlSU3PLco0PgLs+V6MVnulX2FiVcedSG6e5Tbnhat1j8LjYhAh157i36gf
	f+koQ08tF9G5agGBD0x1FieFx3hYsLwmtobh2t+Govl6npfei4w1eCec//A==
X-Received: by 2002:a17:907:944a:b0:c12:8cbe:b8b6 with SMTP id
 a640c23a62f3a-c12e695d44dmr124122966b.22.1783191479112; Sat, 04 Jul 2026
 11:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620174708.111470-1-prashantrahul23@gmail.com>
 <20260620174708.111470-5-prashantrahul23@gmail.com> <20260623203636.69a7429a@jic23-huawei>
 <DJH77MBX1U37.1JJ1Z6UGLF0LT@gmail.com> <aju-_HSz6jNkR_NM@ashevche-desk.local>
 <20260625120952.471ec21a@jic23-huawei> <aj01H48IHTyhn4ZR@ashevche-desk.local>
 <20260703013907.57b0f114@jic23-huawei> <DJPWN45EI416.1GR6QTDHBU6SC@gmail.com>
 <akk8QD1iQHk1Cvvv@ashevche-desk.local> <DJPYQ4ZG88L4.2LP2ZAMYER2UF@gmail.com>
In-Reply-To: <DJPYQ4ZG88L4.2LP2ZAMYER2UF@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 4 Jul 2026 21:57:22 +0300
X-Gm-Features: AVVi8CfZ5qdhHYEvr7Uzg81VPz4nA78A2BIE5AhyUpWeZZGm76HAefpQJYtLYek
Message-ID: <CAHp75VcV81NJMmhujABVMcS5FYLCcrL-C4ZnHCZsc+wnF_eJxg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] iio: adc: ti-adc161s626: log buffer setup failure
 in probe
To: Prashant Rahul <prashantrahul23@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 4, 2026 at 8:28=E2=80=AFPM Prashant Rahul <prashantrahul23@gmai=
l.com> wrote:
>
> On Sat Jul 4, 2026 at 10:30 PM IST, Andy Shevchenko wrote:
> > On Sat, Jul 04, 2026 at 09:20:46PM +0530, Prashant Rahul wrote:
> >> On Fri Jul 3, 2026 at 6:09 AM IST, Jonathan Cameron wrote:
> >> > For now I've picked up the two straight conversions to dev_err_probe=
()
> >> > because I'm keen to (slowly) stop using dev_err() in probe functions=
.
> >>
> >> I can look for places where dev_err() is used and can be replaced with
> >> dev_err_probe() in other probe functions, then create a new patch
> >> series for it. Without adding new logs or removing any existing ones, =
of course.
> >> Shouldn't take a lot of time, what do you think?
> >
> > In some cases it would make an additional churn. Each driver may requir=
e
> > a unique set of the cleanups and refactoring patches. Better to do some=
thing
> > that you have HW to test on.
>
> Makes sense.
>
> > I also removed some people from the Cc list. Why did you add them?
>
> I am a little confused here. I only added people to the CC list who were
> already present in the CC list of the original email. Am I missing
> something?

Which original email? You sent the original patch with unrelated
people in the Cc list. get_maintainer.pl doesn't mention them in
relation to the patched driver.


--=20
With Best Regards,
Andy Shevchenko
