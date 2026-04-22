Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3323EB7F1
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864441; cv=pass; b=L5nwVBFlxbqDmwJia4sADztOHr3Qw7ZbDr5v8ShjLg61F3knnC41M9Zy9tq76pJxLLwqTmS/o2nTQJnGaemEr8BijoI2g+XbD9/mgMvjXB+byGbtq2CXSz4DUrk2T2H2AaS0RniSnsc+uldfehtRxDhsMKJ9N2w8UhUAlEGoxjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864441; c=relaxed/simple;
	bh=nyhnbShwnjgJmpIUNoi2xlZ24z2ZIEb716uK6JFmCr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVVDKD0bTlwvHeC9sS+PFuWhMf9Ww+sVB8/8hpfUXnX+lL5JYCI7ynFCCYaq+kQzMrRkkTUwK9W+HFoV+OsAt4vCbLClrRmn+GC86ogj7K00h1stBZpGojKFcXFsoDFZbeNZsPnfPgpPkEo/hl7DXzrx9Tz4JlVlPfRhDgkeErY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EG2TVqVm; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EG2TVqVm"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so89465635e9.2
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 06:27:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776864439; cv=none;
        d=google.com; s=arc-20240605;
        b=hmWnmFxiCb7l1xYdpFSpEwjiolkfuApZIUhrICkntQmMdfxkuI2ljZoWsFqaBHlImg
         vNDfU7ERaRh0VxWT/PwMkNA0Xx4NUcgETdbZtU8gNhtQq4G2KTTo7d8DvXPW4ad7GdW8
         B1+Trm1YQ2QEISggSEKz+w090P90xh3poaOsJA5mCjjV3Ra+Sa2xJHFgxQmv4wNPkkc8
         oIDqHAC8070jEt/5fzC9BSZE6C6dOtpCm/4ymfv1efZb+DHgBDoBijYqrkwZYWeVkcgw
         d5O4yaPF5l9nJp12Lz/DOXbzMICG5Y8CVfIPPf86TyRg4LtnIxNdZq7HE3YPzghyO6xu
         lbFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qaLQ4z3YbIhMe03JaJHoYI4M783VJJ16HoQcQScsDAg=;
        fh=fpIk5mulnrRLzDUR+5zrRN6MnmDBMRWF3455PQ/gxbk=;
        b=BzL2oRXdXqVfatP/W4gAvQDXFYkcJ6nsznntoGk47MlpQhqYVhSm4YvfJDEytmAtS/
         Gr/GVoBVx4/m03mVcw96td7uusT0HAOGCkYlYfxMR4FN9qUwqRi46kRQbJw40YV/oNte
         OkM+pHTglel4ImmnTTUeSquTzHW0DEc7NCd3y8eU5j+ZCFSJRBtCqur0qGzS0r4iJHYj
         d/zmOQ9hJFXhNyAvGQwwpk6lxS9ilOWasCkXT+TyWKJ/F737JiVVTBAWeQAiok9+/SyV
         UYuxd2RCsXjAoRL8B2yc9l3UsYR0LT89LbqzUyvY+kMS/WgtpnIRHROOy6DeIU/2OFKk
         tJPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776864439; x=1777469239; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qaLQ4z3YbIhMe03JaJHoYI4M783VJJ16HoQcQScsDAg=;
        b=EG2TVqVm62wNfusEnOv0p8DLRFsKInJqsfaB5paSemEStQLEvjG4/P6vTa6j1d18U9
         mg62tUDRUqkummhDsPjKG2/cIGIF8/w543CVI39/XjwhelLBJ4COJ8ARcHITeNwyGX2M
         +FesUNqg0AKhbwoK1nRBPM04mNJCiU/efMV2jUOGYqfggpqeBHBbnPCdPAlD3xfi+KlI
         PUkw7neCL9JmmYfzxu4KB8namKz0RYDckNewE+xz6hBolHODYd0uZv2jxW9015QMHGAp
         BEyCWcov1oiI4gjlGB+P4ZFO4Zq+tVc4N9pgTTDs0wg3GUWZcOvcpbyoXqUEtuX1BtBQ
         i1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776864439; x=1777469239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaLQ4z3YbIhMe03JaJHoYI4M783VJJ16HoQcQScsDAg=;
        b=iJDL5a9w42xmOHXGYc6B73q6Oj9f6IxGAllFDFeef1DakpmLpzS3I01eSwn/v7Fnkc
         wBDwEoJ4Ha/RBv0cI9kjERBwUl1vU3IiK56UDxx4c3J+Wp1zp65q9PmR4pL/lajF7+qV
         P6dAHLwKM2McI12YcoBcE1gBdi1a4EF0ETjZaCJKDxr6wO7pVzbcIS74RqLDHo96x8aT
         hqJgP4siD/SryFFztd48hslndjmrSJJCnKNk7wlkxCQpZj6Q6Q5fcqrCuTHB6s0qMAF1
         UG4XH0TPmY32YGl9tGOsMEFDQTjjEb4W3VnxM5AdeDd7RX0iMthtZQXlra1xUHCldzZe
         KCDQ==
X-Forwarded-Encrypted: i=1; AFNElJ8NDOA3yANn6CA8l1Bd7UV5LDmUuhFpWdWCyG1LCpyWkQtp5worpDp/ZRuO7qVg5CdMu9nhBYrubxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI2R9EiqD22KDTHyFfu/Njo+wE7mtlvtSWmjVg6RaLCn52+bhm
	c/JA/BlHnTm5Gjewcm5nm9PRfCHPthldPlIQp/4DExA1wV48DKXieJN5ITXw/eE3Z9dDkCRxTaX
	42ihUWW9e9pLNZ5gxSHkB4jxJLOWgj+A=
X-Gm-Gg: AeBDieuqWxr7x3qfG3wRp3Kt2629GwWBLNyy1sz53Rbk63YL/JeEdBMOp7wxMNO/b8L
	kcHgzYq9JJoBtdBHpXn1/tPananHhECu7R5xfzxphV/5zq7/e1ErEvFMuGGHVAwvTg8yNPch2k7
	L8CZsttFJYi7+TiihmErSs9eH6eMJan4UcQm9/eha9w/lZRSMG9UOlgjkQJJxGIrgQUT1iRVTzU
	HP8bsQdEKPhh29UR9+RBe4kNpiDan3XF9uSHPdxHabbrYDTfrw0ExUb21vHqHaq62Cw+c3iKoQp
	qdALPp5wovznW4CH2AcgvtSxofuUqrM5lAURBGNbJcHJj80S6dNhU+M0PI5Ylkf1dDc7BHsFizc
	YG60yqRkg8uwz7igVz2A2TiGa56QsmsarNiOsJROBblOvwTxB6+Wx6uzyUJFwOXDbDSh5ONjF+S
	OvhZrlRG5E7SowE0x5
X-Received: by 2002:a05:600c:350e:b0:488:a82f:bb95 with SMTP id
 5b1f17b1804b1-488fb7861c0mr331999065e9.29.1776864438525; Wed, 22 Apr 2026
 06:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422112207.1313-1-joshua.crofts1@gmail.com>
 <20260422112207.1313-6-joshua.crofts1@gmail.com> <aejJjusTGt1Dv0WR@ashevche-desk.local>
In-Reply-To: <aejJjusTGt1Dv0WR@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 22 Apr 2026 15:27:07 +0200
X-Gm-Features: AQROBzDiScAeD-9sWjBRhtSlIw1kPC_lcWkiy1Y8JTglK897Jh9M5ze3RQXoYP0
Message-ID: <CALoEA-wm6Jez_GZf7vC2FrT7kufpCWXHi=bdtN3g41pYUTbvjQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] iio: magnetometer: ak8975: fix wrong errno on return
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Apr 2026 at 15:13, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> The idea is to drop messages because this is well established error code
> and we have a POSIX message being associated with that (meaning all libc
> implementations should follow). That said, it's not described by the error
> code, it can simply be retrieved from libc *based on the error code*.
>
> Can you rephrase that?

Sure, I know that these are just regular errno.h codes, I could've elaborated
a bit more in the commit message.

> You also want to align the code in
> https://elixir.bootlin.com/linux/v7.0/source/drivers/iio/magnetometer/ak8975.c#L700
>
> The all three wait_conv...*() are called by the same user in a single
> if-else-if chain.
>
> There are two definitions:
>
> #define ETIME           62      /* Timer expired */
> #define ETIMEDOUT       110     /* Connection timed out */
>
> For IO the first one makes no sense.

That is odd, it definitely should be -ETIMEDOUT.

> The driver says
>
> `       /* Wait for the conversion to complete. */
>
> which implies the IO with the device, and "Connection timed out" maybe not
> the clearest form of it but better than "Timer expired" which rather misleading.

This driver has more issues than I expected...

-- 
Kind regards

CJD
