Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50913B5310
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787905229; cv=pass; b=AseOQktNrykQdggg34RmBxSEU8tezhrbmykFzcoTvJLpy/sKkC1FmlkYHUWFpDbu9r6B/R7YrTUaS1Bk/MMwFslr6sC1Uk/um0a/ckTgjIpAbYLy+sLsuO94BkMjNGdRUeYUWh52sx1CCxIIRcNVx2rrSgMiqDDUOdm8KpnLpHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787905229; c=relaxed/simple;
	bh=0k16NvqGLpEZuwKFNrchs/B0fFA7CkRTfrBlgsWVXpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/Eo4FWqYrkPxc3WpgptZdrdX4eGd+01iNPHP6RNkeZqp4n5L7h2QU/b79aiBHUb5O3Dx+HkGfc0b7DEkHLZiEGCo7pWfbIoY56iDx2AZXqKkqBQbZsh3/RSf+vWm42FZ+iS3ySKP7AmNYYrvEVxy4tu2x/k4tP+nIFCJvrQwXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzmcyZ3P; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzmcyZ3P"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c20ce3c118aso139463266b.0
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 01:20:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787905226; cv=none;
        d=google.com; s=arc-20260327;
        b=sY+Y92BZmDO9UBgvHkq1YW+Vh1N8UVal5EvsOOx+qmMJLXJ4h99yXZDrcDRTQU3N9y
         Wjs5iOAm2mdRLbHwKMT3TJTnQV1BHpixLIztrKaY3sVl/q6QxjTQ8q7znTfx+XE0vZCk
         DGT9KCt/XIl/ejSSsphCRgtC4ndPcTT99jjgAr0LpB1c8VrSZQQBjMvP7x6yaB2Ev5L5
         q8EdSgANSIns8fRc7nqoDTCm+G/5eXAwO4JI1/IK/V26joaLaIdsXwiOaU1EfMRUJ+1n
         mLPwUvmCVsKDi5Y8Dt6DL24TnQXaK4vA6spEcwKRyfQ32QirNvYGmtQMylw+c4ZYU7rc
         S1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0k16NvqGLpEZuwKFNrchs/B0fFA7CkRTfrBlgsWVXpE=;
        fh=hGZlkon1lNEv7Q1bPSiC7yo/8RnOZI16qrXlu6tVxWc=;
        b=nXALHkmH0Zmh2ghv8p54AYkKc4yMD5BeBkw2samOP6YeMjEMIbgc02DhDl+0kKtXLp
         gwvgcMoQlGpYcvQWuu4aGlyzVgktHtMwoREH4H8vKQtiIDxx0trlBOPq5ZrWA9aKyK7+
         Zx/Fcd3nPK5hfibKMLVmBBhV+pdOlOm+y2bRVqTcKSDgpUQ6Tna22EpIlraMq8LDVoHf
         d4Dqo9e0B+RslXGT/8fkH4+9CcuIScjc95NGE2FfNGOPeGUKaDPlkZlA3tIbGS3AYV4E
         mHmVaRtu78jFmGQPQFMROb0vUezGwWXr6KpVxexD8mTjMQlclDq7H6zG3Q8Igbz4lJz7
         h5mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787905226; x=1788510026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0k16NvqGLpEZuwKFNrchs/B0fFA7CkRTfrBlgsWVXpE=;
        b=TzmcyZ3PMHnMOggBiaeFsOAlYM5lI9hnGnRmqqparAPzIBiOBxB8NtPg4CvbpQUkwu
         8a6Jv0YpmGCVENqH0HJ9BV6tGSCWfB/Y5C7qAAV4ZSxO2M3P3PdnmbraaVIVCMgeh/7f
         n++C1/YCZ9O13MM6eItW2aoLmLWGYjPrQB/Ut/D6vp2eoo7zO8wW6xtCb7ky929tdSwD
         y4EVq4UBQEi4GxO5G+3vOXqoj1tdCyVYKA578Y/VhtM2f6VefBggs/Z3duGNDqJAt73o
         7SvbTR6kqtvbrEegskq3AOC2xCfht/lShgABMR1bR74zqMUSGH+kG4jFuyZbGutFP58b
         T8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787905226; x=1788510026;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0k16NvqGLpEZuwKFNrchs/B0fFA7CkRTfrBlgsWVXpE=;
        b=ixTdy/wvAzl02GS7B1RhvMpW8InQvvauXdOSVw/CLAjXxdNznV8m+su3T/BAG1dAcu
         Wkbz6Rp8mvXCQsk2mxfrgkreWlQ37k8ezEkhoKrm1H8910la4U38Rwlt8XHxxccfPN2i
         tbAS//xVoJxqDf/1DskMFdILZsWOVUGG046N7kVOeW7QTYyxFJ48itPo1NAZbrW5UM6i
         IilQLEY4CHJIBOEyrfziZfzDWlRw1NRjl9Zfy3+/CYhnAMj1QEaWcffNGBIX2yGsV0jl
         DpFYMoInxLUqDXzjysqnkC02PDuQdcX1Kjd8T5xrrfe2NgM4hl+6u4MsquGHAALPzxdl
         XFTQ==
X-Forwarded-Encrypted: i=1; AHgh+RpLBEHe7C52cbFYab/V15hpyGZGcxxKzDNc1Obh7QeKXX0YTgXoe/MvLD+4a+sCPySHCd3EklwHSVk=@vger.kernel.org
X-Gm-Message-State: AFuF++nuTZhJoWOZtOGBdQdkHhcXzegfXmAjZxEl7iIuVehCNNx09A+I
	nxIor6gSskRLCweVlLxdvdzUJ6E/A1RyY+QCct8k6tlx1ntVLCBxFqP7d5UhMELBg11T2ljusfi
	Me1kM9DpxF1XwA5QOsPX4dt31cjxpoA4=
X-Gm-Gg: AR+sD10HbwPw3rYfUMscZOHc8BAhNeMu7eeNByLM8rYQPupnkJJiZ1SjA2HJsg8/u0u
	H+A31N3jcdS9vU1HqlgTxPnJyv9WZ47jE9JzQS+xZ+hGSpGSEtpSfdxscwssj5AGLIXFQf1vHpN
	9jxMlEBcznH/84wdjG7R3x6PCQgLtYrSmPn39Lpfilx0Uh6xClQzL5ihcietD8IpVvFht883QQh
	n/DP/DCr/ocJ8tyqRlzL8flu3xYS+RU8dw37bgfM6X2I7nUxEKBXSSHAV0Mo1QtY8LmudbkMUb/
	4XJ5ppBdP1Ej8+87PiKvAf/AyXINvn1xWwe12w94IAw/k4QiDcXj4lINJXOO/TxT9HYJfC67UjV
	0wiibebT1+qsm4fLb2bjLu7BiVJyv7c40121m+yoEgeu2BdHK4bLeSl0ftAfiA79AC5i9UyB5IS
	OneQvX6DbL198oZ2Nou7/NvjH6xi9vFg==
X-Received: by 2002:a17:907:97c2:b0:c12:3cbf:9f6d with SMTP id
 a640c23a62f3a-c2553438ad5mr349187966b.1.1787905225763; Fri, 28 Aug 2026
 01:20:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <apFDQhk9TUoLnEZt@gmail.com>
In-Reply-To: <apFDQhk9TUoLnEZt@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 28 Aug 2026 11:19:46 +0300
X-Gm-Features: AcwNN1WCy68cjgOouN7IuXcolh-9Cy6oFOkAh1sFEBI3mJFOpc2cfdjaVoJZHws
Message-ID: <CAHp75Vd=0pPVFRrMOiioaCnZS11=nKNe9op7J0xeuafOzqV5=A@mail.gmail.com>
Subject: Re: [PATCH v3] iio: light: ltr390: Remove stale TODOs
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Anshul Dalal <anshulusr@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 11:14=E2=80=AFAM Chang Yu <marcus.yu.56@gmail.com> =
wrote:
>
> Remove stale TODOs from ltr390.c. All features have already been
> implemented by Abhash Jha<abhashkumarjha123@gmail.com>'s patches:
>
> [1] Configurable gain and resolution
> [2] Suspend/resume support
> [3] Support for reading the ALS
> [4] Interrupt support
>
> Link: https://git.kernel.org/torvalds/c/13fad2607dad [1]
> Link: https://git.kernel.org/torvalds/c/288ce72fb5fc [2]
> Link: https://git.kernel.org/torvalds/c/14e0d914a855 [3]
> Link: https://git.kernel.org/torvalds/c/7ca4b8957066 [4]
>

Link is the official tag, no blank line is supposed to be here. But no
need to resend anymore, for this patch I hope Jonathan will make a
necessary tweak whilst applying.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
