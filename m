Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524AF320CA9
	for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771583648; cv=pass; b=cLr0BNW1jf3P14FtfVvVuTsomKZDBaKYLMj0guM6HAfLWCa8yeqpPuxDWVHSn7tAfu76wCKJ2NMPAOdOpoxFJIiqW3h7SAzVTsSiQkPOX6rgHTgurr7a2oMTa2u73Sb1v0mIlaf0CNmw0HQDFYnXNoA1V7BRr6hmyD5Vfh8GtKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771583648; c=relaxed/simple;
	bh=aIBxCjbNEvU/9BlmrPzfmRH5ttDeLxBNaihWTJd3IfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIhfNdbcP/bhYOtmeyjgY5KK3xaRGzAEgoFoQFyqX8uHrsnnS2BYNw0Vu7GllzJrLYJPHlrYMUxQ0Y22E1k+Ko3MKeh3bFo3kUf3eMs4LnrNej27ieNBDEWkHdXnf5vmqxQo2N6kMIt7QfDY50ySpm5a1a0yn16qCo2dCZogRd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzgcw3dY; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzgcw3dY"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65baa72399fso2563995a12.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 02:34:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771583645; cv=none;
        d=google.com; s=arc-20240605;
        b=kc957mHM12GVciCIOxEnjHVvMwC8a8scWF2C2IPJcqjsqfw2ID42HEacyqbbPx36Hl
         +w2IIFGRT9Irkif1xgFUoDJHM2KRTtLUApYUxZktiLQ8H0HgeOl3GHvRx/Z7DS3JVmup
         u7fxkuOwdj94yUVRf8BepmIBVLlECdcVhuK6m8Bo0z/Mo8YYku2CCVYEvK+uEdN6jfdf
         ugoHKfmUO8486Ue+40GPVcoESbCzBcOgnir/1aiMs2RXsNf0ngWFU94uBU8ItM8slWpq
         tLVzdlYVQCVF7uLXVoCJKfANk+Z9pe1y6tKxbwccfdi01+SYlY3oVbplLjwWFIMALdvm
         Ga3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aIBxCjbNEvU/9BlmrPzfmRH5ttDeLxBNaihWTJd3IfA=;
        fh=0gLzE/xe24lWSfMUvohSCwIRN0oRJw5DNMxu0doIbbw=;
        b=QpN0oiWv8f0SddKkyAOqHqiL1NZbI6QcFaLz0CkRmx8cehIXJDduQbpea6SXtxqomt
         P/w1jz9A2dVmlA5i3/r3Ide5PrC3g3XZQa4KpqzYy/th6a3/+w/XAEFozr84NpJQ7ExW
         QhwjgtmoL95z+a388YsEaKth+4qDj6Wl4JAwn9Bm0T7pYK2LaP9epVGr328a1LUYD6Kj
         zYDLJ+50OJrp8tAGQJeW6/mNzZwDnA3aw7J2QXsoGDYoWLp47vsiKL3o7ZssUU7W/N6g
         DiGRmIE8plnjuVy5nSeA7Juqs8a3zDNhe6wsXlzNlZeMNJ8YQKbAmiwpCL9XFezho8sG
         hdAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771583645; x=1772188445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIBxCjbNEvU/9BlmrPzfmRH5ttDeLxBNaihWTJd3IfA=;
        b=hzgcw3dYqx+J/YdENou8gjNcynDJqCliI2yAAydn/U0RlGDBG9P0fLiLCkYx9v7AX+
         UYoNKIVh9WXjDIe6JdYJTfufzJxpmGppOmvgLhGrTfQMKY/kr9xbgw/KnZSqyoRYJFKH
         gi1vHOONEv95gUBNnMzJlnGDhpqZlTfZY9sOBKcN+NIyDfo1lbzapDvw2h49fDpr8KBm
         MG26jRLhRNUHZNwX0Nuz8RB4EFwRued/bxsTQR3VEB9DwkgSumL4AAY1GyISLTUHcQys
         tvAt0ZKMAJi0AX5l+lk3/a6qZwS6SMKOhIu+nNzg+HUCdiFOR1K4lkEUu7Cfmhkwlwh6
         qpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771583645; x=1772188445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aIBxCjbNEvU/9BlmrPzfmRH5ttDeLxBNaihWTJd3IfA=;
        b=rbKH2Oh/BpkDwCllfh+3rUK2OcJ+goO0Xo8W7JDqY+F6f0BzcWJB/ykiqVbcVscaIK
         Bp9qW5o24Up94HU+n+ls5xbG/mSBxccCZ7QnjzV4gkdw9ZNkaTAKHgcooihfAwKKeC1N
         u2oz6WuqT05smyV2odxpPVrQnOQJPIq8RAL6H6g1rlENpcnihZWE2/GoBvSo7q+4LAjj
         HC4j0MuNRPWI2+rchvzv/9YLdEV37zhLsZIaY0HvhC6DG6e1SKOy+eWb9xHgEZ6uIw/B
         ouf417YpGx2JgAsdhI/oYHWc9MaIK3dG2ML2yU8PG0Yy8xlUekLsJTVqpgBdWIe34ZGt
         xqUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfbnIg0BqqDz/slNOnzQtLTHhNzlFNcDSFN4nAL+MBWw6VXzU7ZFSA9/zeDYNw+Kb1/HGbBhEQHkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnLqIagP5NlcH6jhMlJCyT787ekIUyFRBNzwRARme+u1JPy7tp
	agk12f3gW70uKiHgiQdKus/tBi9tngYoplqVwmUAbLZvWRVgos2HP9qY6DJyxpa6Ewy6RZ0itFn
	zmNkNh0QIkCpfmeVJMm+6SSp4eNE5PwA=
X-Gm-Gg: AZuq6aJjh5HGlEUgTdY1s616hzPk7zCfweErMQiOXSc++IQ8LhySmGZmxar4pCA4U9b
	Pm8QDNnb02Kec+ZTqzxJ4sKNEVEK4rIvQBkevblEzNrKk6ny019k11whLrCQyFq66t9z+dPp6X1
	1Hv31fGn6byWP1dll2SsM33VR4UPQCk3/WIH2v1GyMHbcpOJolsR4HaXDR3GgkOgvkTRjN6Zr6s
	Gh6SODt5KVlXgRX6nS6XfzS8MDyryHB5S/Z/mdrsGm+3EbHmt8aXKL0IqZRGSBFqQ9eGzROUwSL
	NeEStg83mHbjKWlGnyuzMW0ssqI1hxXf2uKfA3oHadJ/JhQtryog0i6sElDST6BkEna2jSu9npB
	Qj4itEyU=
X-Received: by 2002:a17:906:dc8c:b0:b7a:18ba:a63 with SMTP id
 a640c23a62f3a-b8fc3a3a05amr1038281866b.19.1771583645167; Fri, 20 Feb 2026
 02:34:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219143936.2276366-1-andriy.shevchenko@linux.intel.com> <c59c19d923d369eac2a0a46405e13e41836591c2.camel@gmail.com>
In-Reply-To: <c59c19d923d369eac2a0a46405e13e41836591c2.camel@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 20 Feb 2026 12:33:28 +0200
X-Gm-Features: AaiRm53B_9owAyBR-f28XDM2J6hjuEWQ-yg2OKGno4jj5g-Lmors125ZoJ6HZMk
Message-ID: <CAHp75VcpuxP=3cGuVrJoSuirQ3vPNR9LLWkf5CyaGcghJ2hzag@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] iio: adc: ad7191: Don't check for specific errors
 when parsing properties
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Alisa-Dariana Roman <alisadariana@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Alisa-Dariana Roman <alisa.roman@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 12:04=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
> On Thu, 2026-02-19 at 15:39 +0100, Andy Shevchenko wrote:
> > Instead of checking for the specific error codes (that can be considere=
d
> > a layering violation to some extent) check for the property existence f=
irst
> > and then either parse it, or apply a default value.
>
> Not really sure how I feel about this one. Checking for specific errors i=
s a very common
> pattern and this change just makes it we check for the property presence =
twice. That said,
> this makes it more "future proof" (though I find it very unlikely for ret=
 value o change).

I already have an answer to this:
https://lore.kernel.org/r/aZcenabXYsOdBu84@smile.fi.intel.com

> Anyways, even if we choose to go down this route, I don't see much benefi=
t in starting
> converting the drivers with the pattern below (which should be a consider=
able number).

There is not a big number of them, so I prefer to have common patterns
without exact error code checks.

--=20
With Best Regards,
Andy Shevchenko
