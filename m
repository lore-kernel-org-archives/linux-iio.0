Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1DD34E74D
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842889; cv=pass; b=GFAc/oLAiGOGlU3Yo6Q9FnUVsPT1BN5xP+7h5sQvkW/D+UF7OyFExB6q0i4F/Wl2K+iGlsUwefAMaPtwQ5SeCOFofuv9dyRSrYpdSyxki5mFEUPfKg2Fg26Gu6HUiF+TKSozNkwNn4e9EoLcUp+ksnsNw/CWoJP+PqtZDipHBfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842889; c=relaxed/simple;
	bh=c+7mrFBaJC57oBSCLhfStS/HZndzkkBQmbQSX+RP2jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZce0P1Wibd14RzjU73SLBtQ7uFe9FnX0nJ4Q9OVimE0NtRvZa/8BQ6KS/DYAmiYdHG4Y+e3YnQr4tMSqdQvV0NnJbPc1v+6p3kHyo2neOwzWjeCtGrDhQMFPF7MeXWxm85SvQp96Zu28WmaQOQaU/NS7tUV+1+RDZ2cvwwINp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LW3vbsRK; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW3vbsRK"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8f97c626aaso576949466b.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 02:34:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771842886; cv=none;
        d=google.com; s=arc-20240605;
        b=bnZ6JLykC3UG8LM5a2dRESwvMJo1wyVnRKMijfGi+Hwk3x9jbhc0Xj/Y9wnLvmz3ty
         XNde82tGr08BbTEUdWptlWTZt03oSGXjH6HZ8VA5HDrCO/6wWy7tXaqIGNPAWvIZ0Pma
         +au9b6Aa51HuL6srdIFVzqAEnMMngfO7OmzN6wPtd9zzPy5ZXf2p+Bjtj/wtmQplFLdN
         N4P2yO6lunz5s6slY+vKPbxsO5ZzVzySeZNzrS2LtWtbFNuFV3AkqEUmnD4xN+dXuF0g
         XZENKUIbFEeaEsB0Gs0KI7k6RCNldphYqbrtPhz7tm3BmpxrzI+1VpYgYXNVQKuM0hzB
         Bbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c+7mrFBaJC57oBSCLhfStS/HZndzkkBQmbQSX+RP2jA=;
        fh=6SQbLUTUJDnr/SqNANrKrOYMSeTOnHlsXwuBi99FQwY=;
        b=Fk+JogwjflJT7YU1cqsibVIA7NKWTnn4yWSIAt/Ma5nKzxf6aB5NwCMNx9I0UetZH8
         8jUzOj5MGTG6p3Csch4/79JH8Ay8QNxXxaPYHTeJaNRGul0fXdu9rQz2EfYKkdYmXz0c
         l1ysYALzG5pqJRJgLH5NcVV0+UBWvqtBLw8UpxNAMBnyBGjEzlaY7BFpzBxN7MrhZBbc
         S1+8Q1K1uZd3iJRrU02YckeS8SR4KtHrIi0Gk4VA+ZGL0XAX6xkpt6XxIN679h8HARZk
         QuO5Fpyiuq/K7PaGZu+ZTn/n6G69bhSuW2dHna3JdT4nZ92XPkNXhf8Z+KS3js9zUl0m
         WVjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771842886; x=1772447686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+7mrFBaJC57oBSCLhfStS/HZndzkkBQmbQSX+RP2jA=;
        b=LW3vbsRKKx7lQjZA1nx6jpK+rfmj+RyI3qwN20U39MqhjzDOi2z2NNEmudcbXstdBj
         tlLLrjQrUKUdN3qE+gPGpJ7bqeGz2DjmBWWD+diZkSbD6U1NAnToXs3ur4wcm71eSmeM
         ZEBrJmBvBVpg1ryNk5Bc7kz4X7UiHhgOHNb2kYtxfeu9mOnyoGPfxMdZXcdMzwlwqOSD
         KbQUVzdxTC6nH2xAXdyaphmuV3Bp7W/0dM6dqHK9iqzVQ5pi+C6vb9CVofEoPrNZJ70g
         DEZNeje3qezv9eGhzp5uKS4lm2Yd7a9EmLxV52yZY2gi2B9KJScTsmoIEbf0QjgZZ81X
         EkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771842886; x=1772447686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c+7mrFBaJC57oBSCLhfStS/HZndzkkBQmbQSX+RP2jA=;
        b=mo8v2+c5D77SyXgrDhL/HU7/OrsTwZhUS6la99cy98lGnbZBu/Yswarqjg17ovCzhJ
         l/1DZOFvBssiDnSwahy97qcut7EQWYR71EAl7Aii6R3TP5aye+0JMkJDCK9/6HFWNDa1
         o59DAFhlP/SH0jjqA17AacSSJQO7WtPjXqJ6K8vW7P1HfFrj8AAFRK5qrDvKJJ/byyf4
         W5ptqExzihFQVuTg5zc6G4dX1vtHb7QTOeNBCnrZZ+JYHJooyNQOhhKdDi6Pz5GktYkt
         4Er6Wn+lr/V8UKCelgSqc41mSl7xpGKxydbyX8CMg/nQu4h860pT3K1o5pdQO/hVKiDd
         jBxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4DXMv/xVWnnXBP6xwwQkIFgMLRfKFZZQBuOnO5TptyUvprcxQCuEIMun0AFYA4H80giZDCDLlg9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJY4hFWfjsNtiKl9+/+b85LPh+1RgzxbuAoUPqID/9PnQgxzC/
	1W4XnBduWfwRVzuylnE6idOsCB6B1oDkwxCEO0J6SvaqW865flpyHG228VlcCuPPWquTxLc6rfR
	SmVLMqzYTMDFLVLgRtJkPhqvw9Q04GtY=
X-Gm-Gg: AZuq6aJMhhF8xesAWmsD4iT2dqyvOjv///RScMSEkBfsQbz/xT9glEX1ryR5XJYR+Lt
	wz+Ooa0Eed+ep9SwJL7rnIxd0/xI9gKGLRu907FVOVBrKCmzjk2HhIHIlbJYReX8E1GJoXYGwqM
	svcyUc16zsg8V2ABQFRKT1RldjbwiZFhK7q+rYM6rw8tz1O43Z+C1fJs2HWTtAx7wQ6NW1mATEU
	Ant23oRpBUm+HBUbHmP1C5RLZoupvQa+EPJ/NSKY5zJw/vOX/YQplYKv/qQQhbJS/neZOEJ+LcW
	9r6eoUUZU9JBIDHfwteCxjdB+jGhb6BeTAspBZc+DjrWIucB2jUqc7KzojvL/O/KVx0j1Kb9dJT
	7jcfo5Q4=
X-Received: by 2002:a17:907:3d4f:b0:b8f:aa38:70bc with SMTP id
 a640c23a62f3a-b9081b3e5d4mr521423866b.38.1771842885593; Mon, 23 Feb 2026
 02:34:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223101440.4872-1-antoniu.miclaus@analog.com>
In-Reply-To: <20260223101440.4872-1-antoniu.miclaus@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 23 Feb 2026 12:34:08 +0200
X-Gm-Features: AaiRm531YEFN-uCCs0tY8_PsLDlaYZpXDPZCv9NNW1q9cljSNvW_Il5xJTzXHUA
Message-ID: <CAHp75Vci3N+2iH1UZwnWb-pe9EYGq=Q0NA-fTuAf4sOMv6db9A@mail.gmail.com>
Subject: Re: [PATCH v2] iio: addac: ad74413r: simplify timeout return
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 12:15=E2=80=AFPM Antoniu Miclaus
<antoniu.miclaus@analog.com> wrote:
>
> Return -ETIMEDOUT directly instead of assigning it to an intermediate
> variable first.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
