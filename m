Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4EA2248A5
	for <linux-iio@vger.kernel.org>; Tue,  6 Oct 2026 06:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791269038; cv=none; b=LOO1Oah1+GFF0/OPrcm3TFmXwxBcAbB/LJcXeY527PYMmU3iBm8QpYjf+5voOsuU98MPZbRA6J1M8kBksKTxx4BNS+LpM0PKIYqTxDBmRm9itSiKHwYhynytuuUuXokxV9rYV7pSsjBjPpzKNROP9l7n9LfFR5rzoncbkeW8ffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791269038; c=relaxed/simple;
	bh=J41VmjD4EFgYfzl/7VgyVDca9LLRoFkhtnzas6rTGds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pFvBsfKhoBmm3ujNHOMek0Ab/MgYu5U7OoNFhqOOUGj0P5roZFnHjbeAXby1UOV0nrxE+KHEYuHe/QyXbySk5AM66NvZ1qPdMu8g5wONIZ94DkTwYwK8OCgdb5ys3D0xejnOIPSdplrnfmKJ6YinrqfsL2Gf3PeoYk68S/lHPGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djiHs3Z5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djiHs3Z5"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so3974615e9.0
        for <linux-iio@vger.kernel.org>; Mon, 05 Oct 2026 23:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791269035; x=1791873835; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dCBQ9OSiuHfTq4KBApOUdi5q97pueuXHIVTklJDANJE=;
        b=djiHs3Z5Y7QvwNVYxBx9grq1YFmkW2qIfiEqe50mCx7F4WfZmCvSrf8T5Dd8MfqBOU
         oN0xqYux6Z0Nc90aFiX0De/gdt0jY/sECK/MfJoLcV6ABk1MCN7h3KyNu/mrPSi3W/Vw
         9ebOk/3sHG+zT+CNE1rPu40/icnkT0S0L/XSlRYuSDlJSM3+3svaSqpntFKAK0DhmaGY
         T3XePomQHZKDZjjsklUDZZhyxu5gLjZtw6ZZu2vkBvDmmVFapbg5XEImTxqRs8+a12KV
         TrAEMwUZNxZopN6XAhWhDB3Cw2c3kJvU+zDDdeuzJEcdm7/y9e76Y3dvvvQgMD8UMe3X
         k8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791269035; x=1791873835;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dCBQ9OSiuHfTq4KBApOUdi5q97pueuXHIVTklJDANJE=;
        b=NsYP+k2cMN6UpKrStXIOCcl4W9os0nyjKvtPV5vv34YyRi/YTc4X4Yweth4WrAlZBs
         eS6QYD6WXW+VnRLwYTetjp286jSLnYyYgMIQuBYWUNHhLvqbzCxCMo8Tmkq1wRJ+yhTQ
         b3mmtLK4tNA1oLXlOesGokzcqgvlRxCbbBic65NvA/6y85VgNHPyJTM0s2jngPIdGPv9
         f0qhbNuyLK3wUSYBLQg3rqim1vNPONTJ7uKLPeczd26B95+qZY45bDn+Vg3rgNpfC6b/
         vl+N16MVCYEw2cjl08mLr8g74Y0AFthxOFL83VcY6Ue42I3q+zqq1mIU46usaeWiQ60N
         Lb3A==
X-Forwarded-Encrypted: i=1; AKwUvBwDY3l2R938u/zyptZXyGullz2VcqAhsqhEsDPMAxg27aaui9hIG8AiI7nwonVLn5aeXzFoS0br3iE=@vger.kernel.org
X-Gm-Message-State: AFuF++ldk0ZINbBqXc3g+lbbF8Z9+SRpKqjVi0MMlGjflk1emeiaYFDK
	YgMspIowA1Ffrz6AyCOKMGVlneuDDc4BXNqHgJLrgRpb2hNLIrtHOfTi
X-Gm-Gg: AYBFou0nfp3cIfGoRlfAyhIQAPY7ChullnQWelTLrCG+oDnj+CbTQ2nGyI+HEP5bnp+
	laGDnf5gZtfqWq1KR8O/MRQ+sxaa6ySrOz0CtbVsRIwA47ZX1OMsul8vdg5o7rKOzWh0cVookEz
	9jlmivIPwdq9bOg1M1+qXs8XBYnd7fA/UR+rb+mu6+ENdDvq6ZFDKjQFlErnqhWzw0mnSl6V/Ec
	WtyZRaR+PUXqKaAMdfQLGud8P/Sl1um5ISBvrfkPj6AhOxlPicln9QKUv9pSGEYGgcEB0+oyz88
	wsAdfsPdhTEUllcU8hiR+5sVD27rw9JJc3qRT5p1OxzMHPcvHlIU8jazo8SCci/lN/o0XIq5oKd
	BoYZBhRb1npIByB+l5LuAcKlTY9j7nrEvHwtMB87kqZ0ytVbIVXynmDcC8CQuZ2ZYii6Y0YJblB
	8phkfUwWyU3e2Ll4OTf/sG9d/jGm3ErAwKUC9CIZe0vLqx+c6hEIHWogjBIo1voo7SzIturNYPk
	c7hNgbHkYNCmCLOulXHNzN3NvABi+Xn37KUNu7Y76cSVzBeEDnfmBRgPZoEUU/OhTHjUgfTgbLb
	BDa0H6PiZ9ViRXKhATIGbStgfMaTux1AvO+bqyD4MBIYebsQSG0Y4tx/PkWKRnLNtja8gx+9SLZ
	ihxHBUXBs34tq1CnZ3pN8peDWJ1ggcYMKknN8jzVDfSOvJZv6WGuW3J0BaXA8jPdau0JynVHnJi
	rakn00
X-Received: by 2002:a05:600c:3c8d:b0:49f:cbf3:551c with SMTP id 5b1f17b1804b1-4a17b53dd1dmr8467765e9.12.1791269034997;
        Mon, 05 Oct 2026 23:43:54 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03feed16bsm327658955e9.4.2026.10.05.23.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 23:43:54 -0700 (PDT)
Date: Tue, 6 Oct 2026 08:43:52 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Leonard Crestez <cdleonard@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: Return an error when the trigger has no
 free irq
Message-ID: <20261006084352.00006689@gmail.com>
In-Reply-To: <20261006034147.2370-1-kmehltretter@gmail.com>
References: <20261006034147.2370-1-kmehltretter@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Oct 2026 05:41:47 +0200
Karl Mehltretter <kmehltretter@gmail.com> wrote:

> iio_trigger_attach_poll_func() prints an error when all
> CONFIG_IIO_CONSUMERS_PER_TRIGGER irqs of the trigger are in use, but
> returns 0. The buffer of the extra consumer is enabled without a poll
> function.
> 
> Disabling that buffer calls clear_bit() with a negative bit number and
> drops a module reference for the second time. On arm and arm64 the
> clear_bit() goes about 512 MB past the pool bitmap. That is an oops if
> the address is not mapped, and a bit cleared in unrelated memory if it
> is.
> 
> Return the error from iio_trigger_get_irq().
> 
> Fixes: 995438233579 ("iio: Fix error handling in iio_trigger_attach_poll_func")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---

A 10 year old bug. Nice find!

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
