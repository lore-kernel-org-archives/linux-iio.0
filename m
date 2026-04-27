Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C702318EE1
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777272188; cv=pass; b=BykHUHHMvimj2rAqU+7zwFEi0bUHsNO392cIMDxfH4EsQQg1szDCG6tm91UertSc+mzKw6J4LCjKoEptZX6uUc8DSauJjIHgREHQyGbLgxWRsqkCi7sqqbCyrUqY+arC5Wf8JGM0tb9s6YyDUyvhxqZkwN5FVkkk3NhAQyFUOZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777272188; c=relaxed/simple;
	bh=4fl5qT/RJMXlMb21lfMu541/K7OnZdJbAcIran83fDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIynro++wMaoNQJMOOdbY/HcQQzL4ckeoqnFN04eG8SqijlDqFbB4+4I55EriUGH12dtq2v8YIpYIsZwygR2lEOPNggKm7gX99FG1CpGEAbCKlCPj7PulUqsO6NOBd6nEKxVNdeb3+704V118RxPpazeRAYgFTEjNCEQV/D0CY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkARNf4/; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkARNf4/"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso79819795e9.0
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 23:43:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777272185; cv=none;
        d=google.com; s=arc-20240605;
        b=aDfLQ3QOfpLMYZ87C5u/gGbEh6pgUR7xr/qtjxIJq426UTLMf/rPa1CZFeael0k1Aw
         XrnaSuopIZpRUVC9+Y6d0CX/fuV59RSAb/4aJvDxlCUg5tNBmQAvs+EKT1eyw3Dih/hW
         bJ80p1jo8f6yChLIKGIiTVo8/XyfPVUkCR07X+eKYX8mlRxHuao/MzeG24Pw4zKMYabj
         o+SpdGF17Syc8Q9f6hyL8FRkaL/eM/i+oX3b6MfGMfL4rX6Sae42+rJrAjUeo3CTux9H
         ZQGroqb7hkcznSFFHwIFbFhuxJO5lzx3RL1lMjm9rszIDxZuXb/NZcoHx/qrDKSPzcxh
         6QSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WcOsr9RfEk0bJ62aLAVriU179vnNVwV4fppmi9KtUbI=;
        fh=k+H8HsG+H5Mz36zVzcVv6kVeJqGTgVch0aEJb9wJIeE=;
        b=S6dtWbQCoAWeLmn74Myg+IveXcWp//TNnvyEoDrDWm8DgEdeZpydf6b3avWC+L9N01
         VrB8QYE9K8nsfp63ncu4Uzc9xhs9KGBgBoDOrXzx0flYUWToYq9hWmzf5VfEePgNe9++
         9R0z2gok4OQPxvpiakWfTT2p4KD5y7PUn8x4xxFWcAEl6Kg2ivNBYCwLiyASJ+sYFMj3
         Zo4aui8tzVCQEwAoDV5TIjZGsagXs3UsOK/M9ACjVoJViYh9SBa+8P6mxtiRoQ+vYxC5
         NfzNOtdFIJNsd+F6U61aFO26vWxlQAKNbrT3PQzhylNFZ1UKHG0JLUiC5+rWAfi1+/ES
         DJyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777272185; x=1777876985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WcOsr9RfEk0bJ62aLAVriU179vnNVwV4fppmi9KtUbI=;
        b=kkARNf4/kZQOwzV9xcdh5kKqn7ZC4YqV8tx3tgFhEicFiwPXHc3POiMPRu6cuH5REk
         TGnLiRYu8BSlyp6PVplGsMUFpwwCgQjIidPaqZcz0PMiBYWW8ZX4Kfud/X8Md2csatGF
         Y860nnbK1LmHurPTr6AW4KqkDqMlKCo2sIDL9Ex5MjXB6JX9rStuVYNID5XH8pG3YSSH
         6GKIO0WZmO3yEj2OhoUWamVWXFcQUltR3Q2vk3139tr44kl9liW+KVYxBzwrRHvC/A0F
         CXMJTdBIvNYrmzZVwdHuxENEj1U0R1+A+q1FpULOFxotxMhfNX7CVFw8D703lOMNvyIW
         ETFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777272185; x=1777876985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcOsr9RfEk0bJ62aLAVriU179vnNVwV4fppmi9KtUbI=;
        b=MT7a+5hNHNvxZskwkiRW+aTGKC01hWo29hpqesoGCu0BnE+Z+WXTIuTi8S/4kLqq6t
         6RSiNoz7/K6Gx6orOms6015JxT8nAdgZN+sJIzkQ2eeYxsg2ztnR1R4AGupeI1mRUdoi
         EWcBGw/8l2lqDteW5YP0Mvo/8idJFihuJYlET5KrO/b+6E1XFXbZbwgYyrkzUtiIVRpt
         TXoin6ljYW2lxEYU4CYNj5wS0OwM+DDetA8fwek34unBDgnp+E8XZQMUjVOACve5raaG
         NLpNNCPxixMU3nascit6CKd5EdkcYEuRa5fb9W97XKBeLSBybDIHpYHHr9o+WpQwZwJX
         Tkvw==
X-Forwarded-Encrypted: i=1; AFNElJ+8QvOevwlnNpjGgRJy1u58gfUf282IaXKmaqjH0GUDfhtr2kO5T6U1opdvOgRY3CNKUCvuzkPRN9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIKZx+e9npTedhtd1ehoEhAGvG4VXoMFith0H3OK0LdzRgU4MY
	mS0kdDBqTO1Jo2H3H+8C0m073mp/TeCJud9Yy+ENsG6bjypw/UBVLQERzOYj8WFIlcjVMHLMSKy
	1uG0KSP8Zb1kX8oPzOBJeEMPwMajTpOE=
X-Gm-Gg: AeBDieuAAZkrdhPfpYOvE8CSDH+s8iujErFzVaqwRmRLbsW4ooiI+TJhpuYq/uSeGj+
	f5G4FSOATWxl6MNuEMobhhhXEi4gg8zvj5g5Ll6FWjMGEH8J1/gF8MGOtnhYYoC0F/DjDCk9FtK
	LIvh6JHTEA10WMRyZFWJHae4EAXrraGbNjEDMNycNVG3xQesw2XrOX2Pe/n91qjchiajV/TaiJf
	rxXkcJyrkgrtMSz5c227nBVr/M3f/uWanR58BVqRqf0EN4t7xc+PwLoVPWTgoketckVWx5c0ZjU
	HVTbIVXDd79zQ8L1kBNJvpZeTw0ba1KC95vBpKI0O0PZlcqzdSalcVQUD7fR1Kvv2AOeygvDoYk
	qaDKuOEGFyAtmga/jJNxypxisnGY53aoqvsN+aUd1T1bOuQSm0mUXcqx+t4iQMxfSeZSw9o5o4q
	XLZwgAMtKv/KcKKxTU
X-Received: by 2002:a05:600d:8454:b0:48a:5970:2003 with SMTP id
 5b1f17b1804b1-48a59702216mr227888515e9.3.1777272184448; Sun, 26 Apr 2026
 23:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260426211834.3318306-1-caiomorais@usp.br> <20260426211834.3318306-2-caiomorais@usp.br>
In-Reply-To: <20260426211834.3318306-2-caiomorais@usp.br>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 27 Apr 2026 08:42:55 +0200
X-Gm-Features: AVHnY4Kz9mzYmXtl_F23_Et-h-RH1SZ5HdIzGYse74P0wBY1rMYM11t_BGRAWAo
Message-ID: <CALoEA-zz-2cG7SJr1iKNQ0H81TVMXLQh3omkxJc9YRW673Kqqw@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: adc: xilinx-xadc: remove unnecessary includes
 and add missing ones
To: Caio Morais <caiomorais@usp.br>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org, 
	michal.simek@amd.com, nuno.sa@analog.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Apr 2026 at 23:20, Caio Morais <caiomorais@usp.br> wrote:
>
> From: Caio Morais <caiomorais@usp.br>
>
> Signed-off-by: Caio Morais <caiomorais@usp.br>
> ---

You're missing the commit message body. While it's understandable
what changes you've done in this patch, it's good to expand the idea
further (what you did, how you did it, why you did it). This goes for all
of the patches in your series.

> +#include <linux/bitmap.h>
> +#include <linux/errno.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
> -#include <linux/kernel.h>
>
>  #include "xilinx-xadc.h"
>
> --
> 2.54.0
>
>
