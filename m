Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD6D36B933
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784841034; cv=none; b=goHZ/sz1m3+kUKUXQVDjapCIH0pb2HlrkRLQgPHa7mv6OEaZP10rquGMrNSBrXRRrfWRsNOfaVhS8D4qZJovyFfNd8rMsbKSOGoOeYwwMPi5rSFmCv1X8ou+3gqF3ydr3Jz7CHi/OomOLq+cpEGhQfwOoEtHQgimcC20SlKjBOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784841034; c=relaxed/simple;
	bh=KXbU16FBm2dRu9ygVx15bK4oT7VVKMSbbe7CuWGsuSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsWNonrevdEZmHaSEbMZb+Cd4cKv+dTpl08jrG59oaw6YKk5dczZD+nMOm/KxpO0rME+FgCx0yvcdYfqhb3bItGz0wrpoPkIqjBl9gb3Gl810JMDgPWx3gNHY581Yl8W+gRHHmVUy9c2pp/UaawyEW+ew+K2Xim5Wcmdpp8C6AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1qVMP+8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1qVMP+8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7E21F00ADF
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 21:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784841031;
	bh=KXbU16FBm2dRu9ygVx15bK4oT7VVKMSbbe7CuWGsuSs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=U1qVMP+8rrDIjeAet1uQBr04HjAQanTeAdEeHGh/c6LhviDcLCp7ea2PBn7x1jrHD
	 NsNmTzpXvJc9Rc9Kk0p7a52Gx3Ni/MH92zOWhxK4RixfGzVUsUNteILvHkzL8iVanc
	 0eml+v+Fd6z+1xBVnJ7FDtdjc+QwI8JMwToXmDvffvLKp9zOKFCl6T6nO6MynQYtBK
	 Fhc/ZkRmLqaUQ78kW4Ad4vzJgi2KxwJs7iM7qQMEhFB5P+FCD93feiDfmyrGxf3V3N
	 ExotJJRdmDeZ3C8G+0T1eqMliNU/b6HAxa0BYR3HFQZE5k7A9A/+NjkxmmW/rSK31q
	 HDYgN3E9w4l5g==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b2a3166398so1001405e87.3
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 14:10:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpO4Fq+MeGSV1EKRFnvCH4yJjsP21m6AZ1xnWbmpXrkgeQdAdAm2ARVIsM+KVdX//MB9wwubJW8Vq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy3x4HJQ2SoCYJEUtYO2flN4sTicN7mHVvhVtAp9Q3DUAn8H6M
	VZ2E2UMynnJKPuEjkgC32Dj5/KNALWbYakNhH1Pb7Y2MPKx70KGqIrxDJab7AxHa1EAfVdro+OJ
	gFwSdXtJj7qgeJu5wroGjV8U1ybO0qa0=
X-Received: by 2002:a05:6512:48d5:b0:5b0:1ae2:8b7a with SMTP id
 2adb3069b0e04-5b2b2f6d69fmr673253e87.45.1784841029992; Thu, 23 Jul 2026
 14:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723034237.2501507-1-eleanor.lin@realtek.com> <20260723034237.2501507-3-eleanor.lin@realtek.com>
In-Reply-To: <20260723034237.2501507-3-eleanor.lin@realtek.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 23 Jul 2026 23:10:18 +0200
X-Gmail-Original-Message-ID: <CAD++jLmLCkSxhzRULKbA6bHWvZ1mywFN2DyvceNh5EMqgFrUrA@mail.gmail.com>
X-Gm-Features: AUfX_mx6Z__GeF2DePcE71INFybvkthsJJf1trRawWr_luDTUqjhsXNwtOLcTbU
Message-ID: <CAD++jLmLCkSxhzRULKbA6bHWvZ1mywFN2DyvceNh5EMqgFrUrA@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] gpio: regmap: Provide default IRQ resource request
 and release callbacks
To: Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: andriy.shevchenko@intel.com, mwalle@kernel.org, brgl@kernel.org, 
	tychang@realtek.com, wbg@kernel.org, mathieu.dubois-briand@bootlin.com, 
	nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org, 
	andy@kernel.org, u.kleine-koenig@baylibre.com, dakr@kernel.org, 
	bhelgaas@google.com, o-takashi@sakamocchi.jp, dlechner@baylibre.com, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux@analog.com, 
	linux-iio@vger.kernel.org, cy.huang@realtek.com, james.tai@realtek.com, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 5:43=E2=80=AFAM Yu-Chun Lin <eleanor.lin@realtek.co=
m> wrote:

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> When GPIO regmap based driver supplies its own IRQ domain, it might
> still want to keep track of the IRQ requests and releases, in particular
> to prevent a GPIO, which is used and locked as IRQ, to be requested
> via standard ways. Provide default callbacks for such cases and keep
> struct gpio_chip private to GPIO regmap implementation.
>
> Reviewed-by: Michael Walle <mwalle@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
