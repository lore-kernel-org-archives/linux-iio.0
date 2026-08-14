Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B06B3E075C
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691273; cv=none; b=ElQnMoqOMnwyCDHaJn9Q/rCngr8HHB6B6I160oI5VcKPzjm+vpvVlyK82IdHECo8je4td1bvdZ2gb8LRCWZBVNHKetuTtjX+09xRWy0CyL8Vw5JXDkITUHDS3rAodXtu/ZVVLHcO4X0EHY577xljsrSUjH3roXxLnWtttJKyepw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691273; c=relaxed/simple;
	bh=f6CmMWijGsHe15z5qznB0gE26Z01y8zcvOoaRGn9bk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PbFEFMQ8yi/MmpJoBvDtpG5p9YE/pgyAU/nXFZqcx0OwXvW5Ecsx/VuTlMKJROGzeQXScl7+eAYZCWnAmRt8YoVUObtu2adKs5tIiO/sNzzgWEAFtv6R04lMpKKxpcqt7+75omUGtIumoAAIqTgf/GWvIVxNU1hQltj+lHNW/cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPqz7i6S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPqz7i6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94631F00ADF
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 07:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786691271;
	bh=f6CmMWijGsHe15z5qznB0gE26Z01y8zcvOoaRGn9bk0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SPqz7i6SIbV0clmYONQJ57ES/0mFDpCMNjaKeqlQNL1dazFKgXul2eRaHFsNrSMlC
	 E2xefUMurqYgvjNB26B2ZO38gMUiL3Zdub2Vtuj0CjVzff8ysNT6EvBA4xfAdJe+U4
	 m5xG6+3orXw3zMeWEPDFbKoYCCoikJjulkQ8hIPPSG1zcR4HbWYb9W1/yYkzKT5TMN
	 WaCHtBxDFOoSSoM4S0rDbwvESJrmYqAnUKo2U91aM6ceTQwsYmi07BN/6XUe/PrOSv
	 FQv8anc7r3uu6UAzEzwcOjfIHBfXs0pM+u/8GbFB1wWwHQS65dMjIRL1K+XT5GNCCH
	 yjH638Yy6uhbA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b2a3166398so696305e87.3
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 00:07:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqUOpvGcaZZPolx6UDzvNxVYolWnSXVHCDHip0tMe+Xg7gkiSDRiSojlr+czoi3LYwh9QsPR3QLygE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM8yhMJiiS3nF5+RaoJOYQoJt45svPH2Rr++1s9bCePU3EWcji
	faxEJyrEw7z0ctYi00VAApxtoyv+1MHyrW8Q2ETUFcq0L9DeT++3S9M0MYvk2ax6d0S55s2qfqe
	STyHlxxc55WCnKNEqESH2rCkhQgOOF9I=
X-Received: by 2002:ac2:4c50:0:b0:5b2:a6e6:8d83 with SMTP id
 2adb3069b0e04-5b45916c878mr571026e87.23.1786691270612; Fri, 14 Aug 2026
 00:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com> <20260813-ad7768-driver-v3-12-cb554399ad26@analog.com>
In-Reply-To: <20260813-ad7768-driver-v3-12-cb554399ad26@analog.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 14 Aug 2026 09:07:35 +0200
X-Gmail-Original-Message-ID: <CAD++jLnz8vcK06AfvbipscDDBvbUPA+bcXc+kDE1ZV7eozDviw@mail.gmail.com>
X-Gm-Features: AcwNN1UTDcDtxZ3Y793tIOH5s58hI_BjN29iCZCUfXKdr-ZoWTYxol2qFk8yM8o
Message-ID: <CAD++jLnz8vcK06AfvbipscDDBvbUPA+bcXc+kDE1ZV7eozDviw@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] gpio: regmap: Add optional runtime PM support
To: Janani Sunil <janani.sunil@analog.com>, Bartosz Golaszewski <brgl@kernel.org>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Michael Walle <mwalle@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, 
	jananisunil.dev@gmail.com, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 3:58=E2=80=AFPM Janani Sunil <janani.sunil@analog.c=
om> wrote:

> Some gpio-regmap consumers share their regmap with a parent device that
> may be runtime suspended. GPIO register accesses must resume that device
> first.
>
> Add an optional pm_dev field and acquire it before register translation
> or access. Release it using runtime autosuspend after each operation.
> Keep the device active across the complete direction-output sequence and
> propagate failure when setting the initial output value.
>
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

I like it.
Reviewed-by: Linus Walleij <linusw@kernel.org>

This also looks like it could be merged orthogonally to the GPIO
tree though I see there are runtime dependencies. What about
Bartosz queue the two GPIO patches on an immutable branch
for Jonathan to pick?

Yours,
Linus Walleij
