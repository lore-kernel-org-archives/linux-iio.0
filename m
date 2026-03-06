Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A760934403A
	for <linux-iio@vger.kernel.org>; Fri,  6 Mar 2026 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772832250; cv=pass; b=VBkgr6gz9vutf/niGYQU6hBfLXZdrZ+0bb59V4Z/wEfqsgvnkBx0zojCsUEg5FwiSX0NNCjveqZm2c7X4KF+Cp19MJjOrDP4JLWREYbyuCEonIrgpqYLX2AnhizZzP8aF09xU1TF3/yG245BxAp8+7JY0zjSgs/QZCeS6tSlFbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772832250; c=relaxed/simple;
	bh=v6ip/y5lihMfADzAqRBKgHGPe4MuFKsEQzB0Cx1z4cE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pc54lIUy27MQbDQQ9yjiXvYriMXUTmSdbco4jG1/4N5KXXXP4++xzwLfFIkXu7slSKeFMW0D7yaC1d8fyeyOZF0eQgSN+fIhq4BSWjTOduUljT5mwZPJivOXQ1aq8FtIdn1uNNjHn0T9uOcmPOLYjgxpccQ7LoTtcLR78FlZpHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkPHCOkd; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkPHCOkd"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6615c461d3fso3351139a12.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Mar 2026 13:24:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772832247; cv=none;
        d=google.com; s=arc-20240605;
        b=acFElXWZEczOsFUwtfijthpSH5PpeDH+yAlltFfxk2gCRkTZ/VOfRkmhQ3xOcranSN
         C01SqIWDvyPst4ct3sZfcJXjCkGs5S6CyHGFby4Bc5R7zW0Vgos9UOr3bRET0Q3M1m/3
         QGezCP+Pk48Zu/yxdBCrLa4UmT0Quf1L4SD/ue8nEkzJR0IjD91lw2Phj0NttBrR+1eY
         EK6+coeYMgPZ+G9enq399UJqqiye9J5xlNiQ8gCzZqQp6vcAORRn+Qi6wXQqxOCTlMQ1
         KGb2uyabKdAqNJ99TF8jSE2u8aEkxCVd80DwlJCNeph4doAbAFzBCImy/i91cw4nUISR
         yJcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=125HaQC4wDDDDocLzk5/bPNL7VZajdoNRkLJC79CTfE=;
        fh=xngDlmv+g/Va4fnkepf6IAuvHEcC+MFyrSYGauZt4ko=;
        b=iZoCp6fyiQP0Es5D82HGlWcuqRlZJ9ESwI1oSn6g6p8RDYbU3h/GSZPxfjo3xIVL68
         SkHKNfOg8ly/5OKJsS2CCZAWagnRb1Yyo1kVNVpmKC9ptGkFmdYUbYETiKpNZT9kMyJK
         j7x/fDjPUM01c55uLstVFsWRyrKSggd3yOB1Oq58U6qoG9Z38bNJfWly2YJvs9ppLubX
         2FBwhgEuRNqJJjj5X4WqsTvN/TPxbobEqUNcwOenLU66fFJjYeARkMA0X9XytgV0Qim/
         WXebGKPQ+j4lmkpOar/CpTJKnJpTFdnsM3lUStnuO7aGdB8+HifF5bYp0OvnFPpJIn+y
         9Oww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772832247; x=1773437047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=125HaQC4wDDDDocLzk5/bPNL7VZajdoNRkLJC79CTfE=;
        b=SkPHCOkda1jJsczf+ot4/tLBgUIK0oVaw/VMpc++P0DPtBj/BzVQInYfkiL64ipqD2
         xUFD6Gt5XiiqLaqdNSQrcP/+0Uqgm4F5bMqjrS1ovGmwiHS8e6gekzxipdFAhvUtxnta
         8fbAYFgC7AORex9vMu/UXNHlk0k2lxODMV4uG9TUOngMkIJKrWb+9s53CqfvYQ6ujjE2
         0CRwPVKKfANPBZMxL9sYiVWcCBv8F6mo6zsXDD3qmrEZ5xZ+5O/2FhClssF8IEQzUyG3
         ZMu0XQPBfU0PFrB1AayeI8fSNJhHruvtVNtbtIuSvlwZm6sy6y7Y4mcTIj1J+TqnNenG
         EGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772832247; x=1773437047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=125HaQC4wDDDDocLzk5/bPNL7VZajdoNRkLJC79CTfE=;
        b=Ljyl1XMjJu3r6ZU5L1cOkFCaH3yox7gDV0QBtBjyT15uqmvjXqtc+w7tBH9J2kcC5p
         Ym76lQ7q4dzNKpzxrb1Ig+pO/w7kEAbSmsevyf/55u3Z9LzRR99fbELNzYxYR4lmR4vq
         OY/UeyrqCAzWzADjiRQOHJ5OLpXLNYvAVWX9E7xNTrCN0B6xW9dNeuPMRwoMxrlw6mEx
         eFXWR4iIgF5LNS7q0fQt2K/gWww8FMVZ3FzYd3RsoJUO6JG0NvyS/1TnA/L8jeEonvuJ
         gDJRTDE0WHkSIwyWvOEUma3x3BNVKHbGNIEyHKAO7q950qJ0akVVapjjWBGRYVZw/bMh
         XOFw==
X-Forwarded-Encrypted: i=1; AJvYcCWLhbHPCANR3F7qPR3bWgdyrS9zh98zjIDrgg1eE3VkXZlcMvgY3dyRhUNcfa0dvYwePoZpzVJySOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+zD+zphogKp0rU/UfFy4wMYvIXOQ4Txrl5SSlETFc9WgvXaCW
	H/3NEOVssHp9i3x8qQ8eyrJN60OEfkMCNV7ooHdR/nEJ1TdllTmzB+NKAV8tM11lPFW9Vw+Jjuy
	JaXJKvagLwYs+lBw0mES4yAxw24l704Y=
X-Gm-Gg: ATEYQzyRvfJuXbtAVOJXBDlafrFaxPVQ5wlrj/0cy/T4Rf0RaPSTg0o03qMOPYrN61/
	iDxXhAbZBaPpLnUicewt+lzPZIZvJztTkOavxGlzNzS1AzY7RuLNqzkLkXs84ABLhREqrGsq/X6
	jIetAjyOjr2E7g82Gu4CKDFDZh9mfRpiVUlOlzspFv+4/9W0sjUbsw4voDhBhtWmoGUzD8VzMJ3
	AIyCC2IQ5f8/ww+/0kG8s3F9zCO5UaOJGprC3KuBPzGONAXR/nGgmI2XiQHtc1FJ4tAAVl38SfA
	0vm2PdAiK9B/K1JA3UdtAyED2Fd1X5FTeXUXYNzKfvfKJHs/KMS9H9gCVPQV/UGT9MzygQ==
X-Received: by 2002:a05:6402:51ce:b0:660:ce49:f6b3 with SMTP id
 4fb4d7f45d1cf-6619d52e969mr1862489a12.30.1772832246745; Fri, 06 Mar 2026
 13:24:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306202650.61865-1-rajveer.chaudhari.linux@gmail.com> <aatDSpZW54mLxjkF@ashevche-desk.local>
In-Reply-To: <aatDSpZW54mLxjkF@ashevche-desk.local>
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Date: Sat, 7 Mar 2026 02:53:55 +0530
X-Gm-Features: AaiRm51CMH491-fS3fFvvqX4Pv4ifG20_8LGDJnszHOfDlSDG1O06G1wmGnOG4A
Message-ID: <CANS1UbjTGRF+f52PkZLmDDXVatuXrfez+ca65aR7W1e+jQ6g3A@mail.gmail.com>
Subject: Re: [PATCH] iio: convert to guard(mutex)
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	puranjay@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review Andy.

Those files have been dropped in v2 of this series which was just sent.
The v2 focuses only on the ADXL accelerometer drivers where the
conversion also simplifies the error handling.

With Best Regards,
Rajveer Chaudhari

On Sat, Mar 7, 2026 at 2:42=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Sat, Mar 07, 2026 at 01:56:50AM +0530, Rajveer Chaudhari wrote:
> > Replace manual mutex_lock/mutex_unlock pairs with guard(mutex)
> > in several IIO drivers. This ensures the mutex is released on
> > every return path, preventing missed unlocks on error paths.
>
> ...
>
> >  #include <linux/kmod.h>
> >  #include <linux/list.h>
> >  #include <linux/slab.h>
> > +#include <linux/cleanup.h>
>
> Move it to the better place to keep more lines ordered.
>
> >  #include <linux/kmod.h>
> >  #include <linux/list.h>
> >  #include <linux/slab.h>
> > +#include <linux/cleanup.h>
>
> Ditto.,
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
