Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8770B39A07F
	for <linux-iio@vger.kernel.org>; Wed,  8 Apr 2026 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635385; cv=none; b=uOMg6OzH1Ed/nrLITO8XEYeTUS/GI5ZCQxiqgHPdoyzebCpVwTul7JMnnlJ8ovoYWVSs3eEKrBAc/tm55KIqpslU0EJgO8YxC0o3oyejvcS+pfekYJQQxtHrk7TT1pl8oMZF5DJhDq78OK1z+Tr3DIQ4eyhyPz2AbYQ+Z1mhInM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635385; c=relaxed/simple;
	bh=q3m6wCafPPHnDhGN/jVfGwXg9ud8SIGXMM4cDcDzTb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gv5AVsIXAVi1yZLTkw/VZlyE93IBe9MfcIfChjGLD/XHuE/t2F7qb6cLiDE55Y7hhBbjU4xWFgP6jEJe7rU4zdjM4k+GcLcQ7KHQOmTEMYQ+KejKCxwqt1Dz6MBTK+nmxjMeLmEK3oMROhzmCV5WXp3X+XJ+nYfEtkkIrfykcr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmXigSd7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmXigSd7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AF2C2BCB5
	for <linux-iio@vger.kernel.org>; Wed,  8 Apr 2026 08:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775635385;
	bh=q3m6wCafPPHnDhGN/jVfGwXg9ud8SIGXMM4cDcDzTb4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OmXigSd7dUjgYicAwaScNhN259Z7kjeTittgYtUSTjZUy8G+MSfxFsS5cOIA2WZwf
	 K7qW3zB6NxEYhY0BJJjvc/OKDsC2nfRZGP2t38wXsk4yDHsW2tOzTakg+uBElctxM5
	 U/W3SOKavtDuyoLb0zhgmsfBvVo10IzqtI+w+rrQ8kQgfMHSomAdW0pc3KZBPG+Xjy
	 ssAaEkbpmP8G9+FiPHDSDfQjM3yjEDE6DtZL/puKc2isV919jJsKpedzhXvqlaBBCR
	 9a8s+HUBw0BzW/DbmqySbLNDruNWiWtRDKlJGslm9eSQbZ13+gazDnuW3ysc1A87Eg
	 8xzpwviJPsHHg==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7991db3dc98so64826737b3.0
        for <linux-iio@vger.kernel.org>; Wed, 08 Apr 2026 01:03:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXR4gC6FtS4x6rn0XGKfBRd5r8d+IQrLPa4lYIcNrXnZYOzIHF7A1R5ns33+wJ4T74G/yR+M/KXMxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/rYgXp3qekwUgLd/gUclMfginBlH7LkN0/3XZdtYkYrmnep+R
	2+in4ZJ2dm1VZ+lXxY3ZtPWDlR4mRfl6+Prp69dKU0DBhmvkWKwMxnJEgCFZcZZw2Pb9eDfdNCh
	jXDUO6VPv56B3Mu+cPk/6oNFRxK2y1vA=
X-Received: by 2002:a05:690c:6e84:b0:79a:1f7e:fca7 with SMTP id
 00721157ae682-7a4d2ff2407mr203983157b3.12.1775635384512; Wed, 08 Apr 2026
 01:03:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405-ti-ads7950-facelift-v5-0-1f980ed3cf9e@gmail.com>
In-Reply-To: <20260405-ti-ads7950-facelift-v5-0-1f980ed3cf9e@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 8 Apr 2026 10:02:53 +0200
X-Gmail-Original-Message-ID: <CAD++jLmCGH1aOyprFpXEpo5G3pyDbGaxw+V1GyJjc89kx9kqQQ@mail.gmail.com>
X-Gm-Features: AQROBzAP4gjmXq6GtnmeMKyxAcxNOuzOxwPpSgs8d0UzMVk7Bb90YznRPcjpNSM
Message-ID: <CAD++jLmCGH1aOyprFpXEpo5G3pyDbGaxw+V1GyJjc89kx9kqQQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] ti-ads7950: fix gpio handling and facelift
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 6:39=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> The original reason for this series is to make sure ti_ads7950_get()
> returns result in range [0, 1] or a negative error code to comply with
> gpiolib requirement.

This looks awesome. Thanks for all attention to detail and elegance.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
