Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EC9358360
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780245898; cv=pass; b=i6m6tmRDmZvjxH/fGrAwS+o1/p0g0eCqfS/Gt4w5aBw7vkICj6H8abCOqZQu7np3IR8BVcXpKq/tX7ffdMaqBe7Gwcv1rrg0bZdCJnJCL05HUz0bkNRkGyrrxf3UbE1iXR2fJHdLp0fKiyG4NQ5M8KDZBHMuGPm180q4c71PnoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780245898; c=relaxed/simple;
	bh=H2mgKNQkYp6H7DYMqrTNMf/m1vMJdc3rUBfTgqvc6ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olI7TFRFXoNNAQuF9mmm8ZE7J8zkkG4aFbi2W8DrQZ/GI8Drrkrc7+6Kvq3zmmz9qHuevZ9vNIrodhWL8vEtidF9KW/lSplJDmfSXex7i3iba8yKlzRMFI/H6iqZ8eWQ4RMRIxAO/6z8dphUB3eegh4EIXomhKxo53jbYN4rpPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NulEGFFQ; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NulEGFFQ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45eedcdaeaaso2194090f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 09:44:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780245896; cv=none;
        d=google.com; s=arc-20240605;
        b=fyDvEmr/+1+0Zj+4huZkijzkM1FzcA6nAIwNruOJ+pEZFLX3kho562eLkAx9nA5VQ9
         WyItceOet3BejfypXBRyR5OesYwhPdkFKL8kOQKyMMqvXBJuvp2xN13IkxUzAP0cX4Ey
         c8vPoB03LXQCqW/Ci8SALy7Ci2wDE79lUNpZqrJzJcXrlFm0Nr1uubj4JMzDelbHMPvV
         Z86WTD65kVe0HG0d9b9EoOpd3L6dPbN9XPLtDsVgNSbozHaG4sefnYN/7iO6cKtP7PUr
         dZOqT+8GW/yW/T0RQbKxWqpwhOZVT62Qvz6F+wPBpAk2ow8Nc9b5BqmMmSb9tggh9exr
         xEow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fiYVeZKekUGFPbINGFuEkdQrx/jvxw/Pnx8Ccn+WmcI=;
        fh=KvoITawfjDptkuyrWOaA8bZlCc4mlNIJZqC9slyEOjg=;
        b=R2ZsxoZ2YwcAmtYLvwCaYTE4i4alX/vtD2Cd4w7DGjbQQ3neA75jUZDkLep4qCtSfm
         Xat5oTGlgLfMF4p+nrKymvFJ59p6etqVWYELykJVquR/0MfVrIFd0gBYTUSOn/e66Fr3
         IfO03gdQSpyJNqXWfc7mU2Nn4DSKK/QHqXUlhKWeRX29bzKxcSD4Z09GDNdGoIjujntw
         ThTkv1cmSC49FBG6K164VgZ2wimizhZj+BJ9fOkDDMasrAC/71PD3/UJz14R4Tv3Z9S3
         MsbTiNxVZ2S7ZvDk5iIlHIJQ+HIS6oFySRHBVTPUNknjxLpUXei18iNgJIr83ZkkruqF
         7Qyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780245896; x=1780850696; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fiYVeZKekUGFPbINGFuEkdQrx/jvxw/Pnx8Ccn+WmcI=;
        b=NulEGFFQo4cWDsMAY3xD3lmPzAWjky8zZMpJhb5k6ptQFMjaZEobOlsXr/q6zze2J5
         V7SUDAeMVOfgq+niuWHFEVyJk7xyoxdeKP9zT2naGnfB48BqXmMnzkipAbQL1x7zdD8n
         E3tGpRVaDW2gpZ3ReLXcAzE2g4CNol19F4M/TP6QrIi3xOyngasGpgGR55GU69nxRMSa
         X0x2sBiIJUGgOrvTPMyKfXhjmFnNkpMRYFKDjEodqs6IuiVvsJQgOaw5eG3nBqD8YXBk
         i0e5QciFE/4ARKfW5eQlBzxCsx9JzODjOhafVE3C5y716SBhV76Df2EJCdAFXeQEuMBS
         VZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780245896; x=1780850696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiYVeZKekUGFPbINGFuEkdQrx/jvxw/Pnx8Ccn+WmcI=;
        b=ihFgpLKat6fVuuHztdPxfACqZBpBFqKc0AV4zRMvz3rpEHBUHKGKI92zHyahRa9y2b
         gFQfCEtMw7YNvOo5fxA/MnCiQK2Ov87kMmmFJuB5ezS6M2uO/SF0PgAf7NhjfAavIxSH
         umMcMgd3iPMlK+9ezob3gU4qK+Vgubhu/1xKRrb8KeoIGqsjnm3BhIoHsWVdgJzc1uQE
         ldaxsFcDQA+VWQRioDF1nHHOyo1zyg0/Amqwk9uxnARp+GBHeno+oi8drUwL7cyuC3z3
         cqrxdMcGW0zyN4vkLNWGqMq8KlemigDAi+UfJxedzRDwaM3mUtmy4pcLWZHGJ4qohj5O
         NGGA==
X-Forwarded-Encrypted: i=1; AFNElJ/gHSA3SCBQ2VCHFjqV5ORy2zd6UsoOycSbXhBDHHO/NpaHfFeorCqc2zPDnzYKldig2YebOLg9KZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZs/TXBKNHZkcbjf88tBxrErGmMg/D2TrzVxlzE2yqoN51rytt
	sLMfevpW2bSUYGssJe43y0wZN4snYYDGpDCt3kENUw98cVRMtsPdOYtrVjMXpzP1KhtC3BZbtcV
	Bit7hf51YrLPdZdZBv8wfeZc+BEPcYq8=
X-Gm-Gg: Acq92OG/bCtRHYTJRus4dKWS2DfCTGsNYcF2F6otZs+hQi9TLo+e+CE8Ap/eKJd0mtK
	BFk3ECqMGDFfp1iYJ/tfW3U7iOamAQBECXFgi5x3m49LOtU+tdf/yfeoNAUtsv18IrfJO6JM3Zr
	ZZcb3sc2sv34BDmFgDqZ8Wlb/seRaJVdYCAX37K6+38Z0X9JdKABRbOmWdqycWfRU8mS4kPfi//
	Y0yBrw0e4hpXGHxeSwV2Z8eNTC0JDXCOgmz4ISFxsiNZep3ZDBA8jdNzgjuQXpUNdgvUFHVIHOb
	hZOZm59Afkyf/gNOjjwzAGYAbVNPyeDTPLtKQnBY22xK+m62/0m6feVLwVEKo6KksvbqMcWruqo
	fZPAIQ48ZOeGCcs8dKxMg/aoOZ+4z5hc2png2dFUOs3cjmimI/+/XTrxzB/+c7VY6MWmSvUhRGX
	OSeh4C5DxFd/YhwBuy94Eo3xCAQKEx+sg4qrbZx9y9pF2EPfwFEA==
X-Received: by 2002:a5d:4a81:0:b0:44a:be4:d0e4 with SMTP id
 ffacd0b85a97d-45ef6b536d3mr11131308f8f.25.1780245895408; Sun, 31 May 2026
 09:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530-veml3328-v3-0-dd562eaee8d9@gmail.com>
 <20260530-veml3328-v3-2-dd562eaee8d9@gmail.com> <20260531101940.037d1d7a@jic23-huawei>
In-Reply-To: <20260531101940.037d1d7a@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 31 May 2026 18:44:43 +0200
X-Gm-Features: AVHnY4It0Vl6KYs_5qHaqiLySvxocVoP8lEfpKfo13Ax6I3NesJva7qOhi0JhCQ
Message-ID: <CALoEA-yEA5KcvXqZCCg76qFAgyNq8BQ5+gop442mju-9PiKaxg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: light: veml3328: add support for new device
To: Jonathan Cameron <jic23@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 31 May 2026 at 11:19, Jonathan Cameron <jic23@kernel.org> wrote:
> > +     pm_runtime_set_active(dev);
> > +     pm_runtime_set_autosuspend_delay(dev, 2000);
> > +     pm_runtime_use_autosuspend(dev);
>
> As per other thread check this results in power down.
> If it doesn't, try moving autosupend calls after devm_pm_runtime_enable()
> and see if that is enough.  Otherwise, you can either manipulate the counters
> or I think just call pm_runtime_idle() to force it off immediately.

Just to confirm, I've tested this on the actual hardware and it did autosuspend
after probe, so I'm going to say that Sashiko is a bit off for once.

-- 
Kind regards

CJD
