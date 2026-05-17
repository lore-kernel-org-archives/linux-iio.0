Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50C43C13F8
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779037883; cv=pass; b=I3qY0gx+Em+2ugzdVCXswu2S5bSd8JgTA79+XpdRn4nmJb9QLi40J1BDv+yMR9CboTx8Vt2WrIkQ3rjkdl5NYNeD+azNzRmh/rFGOfBNKbrLNrFVLloOTs+6SBwo9U5H5gqOw6JENs3fPgHW97e2nmr2CkzE/ZAhU6BGNNJU+GE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779037883; c=relaxed/simple;
	bh=VcqMAEZLIy6UepcDNfGzxEP6jYWQESkbRSqSUZivUPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9w8eAF+B7RavGPECgnNAI7fgWPKNBxV9oVbEqQASteu4/SAeLUn27LQhGGnMqgqqgSumQqCijlKAR28P0hCt+4IfXynMetkuSBIcmuywqTG1eJFdIDVdTKAan5RLx22amTVZZR10wmhOTBn0grRpKraNGwdXLl9ffQCkOdkUt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxMKUd8r; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxMKUd8r"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44b330c5cc6so1000739f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 10:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779037879; cv=none;
        d=google.com; s=arc-20240605;
        b=MtyKhUuCJLhV4+8r4dfHMjnPFGwyzxVeg4L0HL8PF8WB6D1UD/zkxkDPFTL6s/zjSn
         1myuLx0HLrwmfHUO0HvONuD+naMKsbWxBuOu+mmWS68287EN688WG4C3TM+aAI0/PDgm
         STaiZ5RfkWq88SWpPO2F7cKAbNcIjCPWGn+FSIDTTvdknB/+jsLL5kpI37McukWNLvpZ
         hqlCpQXM22eVBe/uBtMRKOMR7x6ORg6Aekeo+AMIN/ay9ZBlMwRoak24iqcUPEx97EfO
         ak5Pw8jRrYXgUW4k3wbER/wiql2GJZud4M1fFKSMJADgQfvzbWQL1zlyApTmv6qANM+L
         /x9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oOk3mNqwPe7B1Ha1xIvx/x5c0FAW1KnQKPwGG0/kFNQ=;
        fh=+6TQ2pVa62FpOemCiJtl61nyWFETfHeNUygUpd6MdzI=;
        b=HyCGleR676WksDEwrg2vXSxSqb64KEeZvCadI3rkkGLnT6pbXieimKNgzO2itNNAmZ
         A4QCbY5e+ME79Qy0wn2CVGGLYMhq+er7YJL8lW4UJQ2YPxYm40mueh1ebEA7LmblwSnh
         +A9xHqODYjMM0VfXCdxDMJLOw//WGtVIe88MkpYDtyUCCeeoeTKwl/9sNZjcTO7PFeMX
         i+ytEE7Ntq2ewd9g0QQyGlm3MeRPTto9uGVV9TYv1c+IAudEhggMEgV/T9OzMNMQ3VZ/
         yCNZvGXdaTG2ij16l+vWTz4Pvn5NOBnbi+G1Z571HJ3DwZXvprR58PdeeTuVjnViJhye
         eo6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779037879; x=1779642679; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oOk3mNqwPe7B1Ha1xIvx/x5c0FAW1KnQKPwGG0/kFNQ=;
        b=XxMKUd8rmMLu6gWYuWRq1Hj5nRmlz7egqhvLAFdPx//KO6cWwuqOIlW7AeAKfK8NoB
         6B3WgF4K9/uIRakD2lc1OMH8n250R1E8ejLKdLDime433G9YfhetvpnpbygPZJkx6k1Z
         8mdKmk5fIWC8YnOy8fr3GIg/6wRg5MegoZIg9QSOwhuuBJu/0GMIqCExyQEOoJrjgoMA
         aueMT0Uckj32hbCpjYI6nVIcmjeB7bGeXApux7RSC8IxkAEVUc3LOqxfoNrvioDONaqf
         U77DawZ698hWaTmtLmn+fS81IBMYlwgQATP+h10y9l2HmJ0VEfGM2sFdHTgk3CsLWbdv
         uhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779037879; x=1779642679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOk3mNqwPe7B1Ha1xIvx/x5c0FAW1KnQKPwGG0/kFNQ=;
        b=RZJxBFO4ZklM6kjoZ/X7T6/Q3+MIG3t/WxmEf/CWL+SVnzE0Eor/H3EK/CWZaYR8LZ
         uxVXQ6OHlxrNOVHEg9m0tsyMVycoXvEISKVgs0Kmu4Ph81o0s99kLogsWKcbwQ9x8qVz
         3j5pHdCmpzQqgdOA6zYT62NHMkqWta9i+uH8T9pSbEGvF4L321Up15pqAhI6tLvPGWtc
         M2VtjYVx4YWYdVRk0EI32Fn13D563S8eomJKBTBSNWvH00ipicR3zj3SF6zDO8ShXVEY
         vwaZ7nGMCTVm/Dcva1QTz7yhBwbthz/LME+bxNyUbtSc/NYB9SFW0oZIXKbusrr7TvWP
         qBZA==
X-Forwarded-Encrypted: i=1; AFNElJ+Wsvswk8wf0t1DQxGlFv4rXPAahvq2d4DWDlqRM1kN3IViuiFxgPeyOwvHSIpsipLcoJICIhsv9Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNv7hyrUyu3Frdf/4nyE7CaLNRva04HyIUCV512Js3aOcNkDP1
	+3Eq/Ym2pvphuPMJLb1tprzeqG8dmCepppetfl7QKiLa2Kcwsd+fikl0Jz3X/6sREuEm88epr+0
	+nE1yXnK2BKuBLYhLc5XHqiYDzIKrDZs=
X-Gm-Gg: Acq92OHEspAGgf6ymQr+FFdW2eYfqH40/GCqAIw9VD9HS4Ti6ViwOjhttlPeBsW/TbA
	V2lGPFURxXaTEozc+X7RfFXZCJE6cs4LI+JxV2RE9uAPxwuLxbYs2Z1gqLX5PTp5nCiW0m9/OuM
	iCD3nL0Lb/HuDtEidRDWzIuqI/U/Ypcmzne/50c1gWVBi10yIwwk6YjOEycVljQyGf+97I+Mqnd
	Fzi5xCxuD0ggXRKiAKdLhFIoLqjMBzdk2rUz+XynexktLuAXHXOCxD4sevsB/7eno7syaObohEG
	RFoS4tmw9vyKrRLtF+YU88tZzXYP0xAlxYkXMi1X7HNDtpM9PZ/4mop384BFVaKWM1z+Ea9jByP
	ola9W190RmSLzvFHSEL9QyqLCy0h5oqJ4NyEEOUjzQUKwa8D+A/5w7rqowShNdLzQ2Q4IKEZITQ
	szql24lg==
X-Received: by 2002:a5d:5f49:0:b0:441:1e41:19c with SMTP id
 ffacd0b85a97d-45e5c5fd484mr18023529f8f.20.1779037878885; Sun, 17 May 2026
 10:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516-veml3328-v1-0-1d4b663e2fe3@gmail.com>
 <20260516-veml3328-v1-2-1d4b663e2fe3@gmail.com> <20260517143449.6c30b99f@jic23-huawei>
In-Reply-To: <20260517143449.6c30b99f@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 17 May 2026 19:11:06 +0200
X-Gm-Features: AVHnY4LXDVs3MpxIYkHyk_Tn4lGbYKhu0alZrM9Qpom4vtzjFVIC-DUNf0PWHcI
Message-ID: <CALoEA-zpJ2B4W6N-++cBqE6fBLsd08D4j+Rozgpt+1=NBAga0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: light: veml3328: add support for new device
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 May 2026 at 15:34, Jonathan Cameron <jic23@kernel.org> wrote:
> > +static int veml3328_write_raw(struct iio_dev *indio_dev,
> > +                           struct iio_chan_spec const *chan,
> > +                           int val, int val2, long mask)
> > +{
> > +     struct veml3328_data *data = iio_priv(indio_dev);
> > +     struct regmap *regmap = data->regmap;
> > +     int ret;
> > +     int i;
> > +
> > +     guard(mutex)(&data->lock);
> > +
> > +     ret = pm_runtime_resume_and_get(data->dev);
>
> PM_RUNTIME_ACQUIRE_AUTOSUSPEND() will mean you can rely on this
> being auto suspended on exiting scope.  Will allow early returns
> and get rid of your goto that you noted already.

Sorry if this is a silly request, however I can't seem to understand how the
macro mentioned above works... Could someone point me to documentation
on it or a functioning example in a driver? I tried analyzing this
with AI as well
and it keeps going in circles that the macro does not exist :(

-- 
Kind regards

CJD
