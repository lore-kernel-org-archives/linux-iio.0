Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABEE3C5552
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777645203; cv=pass; b=G+FtGqyZhJgi+mkkd5CPw/iCj5i0ZCCFLtS4lagztJ9v3j7iP8gzPbEzJ3GLvoIt5B4k+Ps33OQxEKMMYK/eYAu8k4ve7UkyS5Eb8OpN4Khi4ccHLKMhfaXzG981gsZo+1QGUzvnD/HSvdunqyuMKiAVzP5ANRp3eZ1+TNtccNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777645203; c=relaxed/simple;
	bh=Ek+/OV28ScU730APC3VsSNkJIXwWmvnk4uiab/tZIrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZoVl7y1p5t0posDl8Aywp/e2V4eKUvUSVyMmYJJZbduk8rbf0IZ60raYhceAO2LNJwSWNybFK9lPS6WcfefgQmSHssWDI1LEKL8IX+PtAT0sNBTI8wEXxO1VEwUtQv7EWZ2XVpXf7SPHoCi5KXMfhVVaDl2aMep1JCxrQifCpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jo6/0UcV; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo6/0UcV"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d64313c39so1395171f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 07:20:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777645200; cv=none;
        d=google.com; s=arc-20240605;
        b=D1TbkoTFUD9JRgerRMmkLfG8CLy5Hc2mJi6hmfCT2Gtd/8w7PPXXvgt5WxnUiUNIuP
         Zbo48WDvsCFROlzux0jeWvhPGTklgERh4cNs5a5SSh6OdB33m009CJyJeW4kaBsGxrcg
         3fqzAloZVWrEehu/IrtQJowhgrs1qviR6+zTpme+WAN55w1atzDhwViiIuXmDVD4KqrA
         B/j6B7GYvijPAdGhvgGmzpzfo9KGrDEBlQvNNnWYuNdQE2MC3A1ezVEJDeIGvF7mry0V
         W3A7Fe+XDDFY5Tq0+MHN8ct59cHKAp6tZhzgBjP1V3DSELQ2m8uekBMEAZaXzWJF5ugn
         fQow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ek+/OV28ScU730APC3VsSNkJIXwWmvnk4uiab/tZIrg=;
        fh=lGjBxoX0WqWA9DPEgjYHGwKR+fNDqWRJyTzfmdhBR6A=;
        b=O5SzIzifGDQizs7SQDAmDXUn7guIP3BUAUQbQd3IRVrlfhefTCoJuFJiI5f9tFvRjC
         kzq57UYTn0m6fAJIRPVndn+T9KjUujM0vBjfXTL/EJRt4Ra0YUrApGw9WOLds/XE1tIZ
         x4R9bMiXexj9BwgUGxVy5WdddzWH9QXG77q3DIULFyvBlrImkkKc895fAFsZvVtI3wDp
         BO31BV5nQXVa5fIHyrSISX3p3CDA8fq/fWldlAhu+HnnGhGbz1YHpzVX+r7vkMBc2e/q
         /Mn11tkdQcQRgvppgB+SliDk4uuVO/Y1tLeA1jPDDiFhBZ8CdrmQGvPqrDE49GspOgfQ
         7kcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777645200; x=1778250000; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ek+/OV28ScU730APC3VsSNkJIXwWmvnk4uiab/tZIrg=;
        b=jo6/0UcVHofE1V8ingo4LH415NN2GMXtx2LvJsPAEypPy8kdaJk3vXtBERUgffPTNU
         slSIWFE6JUiv4HTu8rA5QuN3o7CGSOdUXmxZwNqAGYzMf7MXgu0529L4qjQZSk/IMVjN
         ny4sJroCUMBO2G/pb2B96XuNvcUbrMSASnC1BuyArEokwVVb7FpBR3/wmzPqS+RLwoEc
         S5drP3y1yF+L0q5/mwzSjAy9WUp/6k+b7Cq8RVgwtzzR1bmmb4coVvhDV0m9zT+uXtRK
         PGHoVdxw4on3cEx4WWF9sTejUNgvHp+UrJ5+oieEd+19p/supIlLNFR1XIdCzdOgc+45
         lHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777645200; x=1778250000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ek+/OV28ScU730APC3VsSNkJIXwWmvnk4uiab/tZIrg=;
        b=YgHHFpBeMCkLUlmgChN2cTbioMbuj5/u99Pm19D6UDllO2pUsmEXFv6E/4lemonfbu
         cIiJVh2TeIZdm8MYHK7Lsila9XAkgdAqDjSsLgaoUuvPSia1yUu+Tc2FpGC9fTqK1Fa5
         2zMB6TsIRtMiS0fgO8XpXXn+GmOyV3yEMcjklSYTt3oTiozBhXSK7GQOcXOsVk5wd7K0
         iR9F1HEOWZ5g6PaK7P/pvEuMnBK9zgyYgFVDK9VclCWBGyj7FBBsWslwC3pGuDwBBgXc
         a4uFKovEKt9L+g/6E71O72agNypgB7GHyk7qbJimjlXmYfFLnmio7aVjNi7oO3yTp7xb
         bj9g==
X-Forwarded-Encrypted: i=1; AFNElJ84/OP4lNhNd5uZd5TdoSgLq4DhyOZKj+0rlTLB+92KS59qdSKv5aig1ACZYqAkGHKv0kV6bc9osMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdXl3XhL5IQqDZUtEWpfxdZmiXj8l8Z6I+XdLU+iFqMlKCEKwJ
	COxKl/Rwij8vF49vLQpdfhgeatGrwj3g6yGcz1riviNOwWD4eoSouyu8elmn8Qo9OrfJOx+MOcP
	uKHYudk1UzV/VGBpbuv3f1FuvDXsy2oQ=
X-Gm-Gg: AeBDieu8pk8pHW2Pz1llVj0Adqm5yKYdOg2dfzdcQmOGbDzZ2X9kCfKUvqjacpHESx0
	mt5Su8ELSnTguLoDkJj2BtmcnHcZ8qdZq97eDQPeY3ziSi9TXdMR4/BnuFHjXKH70QkVrJxepjQ
	nVBmryx9i8XRrW1yZaKO9eKLsPaMHovgx8WDufxn2nNCdD4qjBg8jPnikkJMMWarK2RzVP832kH
	Qu6r0JA29c13uYDxD9yNgLVqP/ObezV9LNN2LnJjdwEcy+9YBl8VjMNvF4Ehu2O+D6Y+0xoQGSf
	4+MQlbUVaEt6RLj56ceQlLl8ayzDyofLQ9lO2rBWtr8+mtxqQ2106HWWVukuxeK9LTWjl9Jwco6
	jx2gwBVgW3Fkzb+RjYcX+yW+40XKTNzlScCbm4hsBPAvHpX5I85PAiYB2Izcxg4hIVbp8pqo99n
	vwTbEO9ROBo0E9Um/uZ9XsPj0UP88sfBIGTvhBuweuionL4GOaMw==
X-Received: by 2002:a05:6000:288b:b0:43c:f90b:5668 with SMTP id
 ffacd0b85a97d-4493ec61b51mr12584574f8f.23.1777645200127; Fri, 01 May 2026
 07:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430-iio-buf-v2-1-84c2231dea5e@gmail.com>
In-Reply-To: <20260430-iio-buf-v2-1-84c2231dea5e@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 1 May 2026 16:19:48 +0200
X-Gm-Features: AVHnY4IwqNSCqrFxEgdJyrpa0s3sIZ1Gx-2SLpPFl93NyKqX-VqDof7a4MKVSgo
Message-ID: <CALoEA-zC9je3xsq0+dqG5b-EiVM1DiKbgAT8JvtALsNwLpp=ZQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: buffer: hw-consumer: fix use-after-free in error path
To: Felix Gu <ustc.gu@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Arnaud Pouliquen <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Apr 2026 at 15:29, Felix Gu <ustc.gu@gmail.com> wrote:
>
> In the err_put_buffers cleanup path of iio_hw_consumer_alloc(), the code
> was using list_for_each_entry() to iterate through buffers while calling
> iio_buffer_put() which can free the current buffer if refcount drops to 0.
> The list_for_each_entry() loop macro then evaluates buf->head.next to
> continue iteration, accessing the freed buffer.
>
> Fix this by using list_for_each_entry_safe().
>
> Fixes: 48b66f8f936f ("iio: Add hardware consumer buffer support")
> Reported-by: sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260427-iio_buf-v1-1-2bbdac844647%40gmail.com

FYI, Sashiko reported 2 additional regressions (neither introduced by
your patches), one of them critical. Maybe another patch would be good?

https://sashiko.dev/#/patchset/20260430-iio-buf-v2-1-84c2231dea5e%40gmail.com?part=1

--
Kind regards

CJD
