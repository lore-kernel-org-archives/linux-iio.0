Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3B93F6C59
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784840988; cv=none; b=P4B2pGqIa+VKWsxxBy+Elaaxzybi1eEVB0fVBVzCi+rYQY/tHwPFnsZZNVRW4dYNMQCdgS5LgPyDZZFd8OuY9m1/of2CcDsN8CdeE96BZcBlYLCSSlGsHZiBd3AXqIqECP9CtDN95p69igPgBTRFqGLfYzb2viRPSL+aahSePD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784840988; c=relaxed/simple;
	bh=4J5N0YZV1iz30YOO1gIgcHIQ6SOp8Ckaq7AMkA0T4PI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFmeXuuRRJLQ2Me73CUTh+tlH7FYdM1jOGiu2E7L/TIbOZlDgO3RzCqmeC4VTakhgFF5jGPk+qb/p+AwctiuTDwJyanAfjKdGeE4wngQ5mrYDP00fDg0+1Y4QPyiPalbXVYsglcQNjUYV5MPvXR9ytbl6KmwnQHm9/IGpecbrt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzxVQI7U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzxVQI7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5501F01559
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 21:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784840983;
	bh=4J5N0YZV1iz30YOO1gIgcHIQ6SOp8Ckaq7AMkA0T4PI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SzxVQI7UCBLBCrISBQBE8xxgFPi4ed+v8qaJuSayLta2hQO776kFTPdIs+uzEJJ7y
	 nFASBpUINOwrNIqw+OZuLuK4gHHG4jShBlJvsz7+TpNesDDItOSuT78QqKOCetCcmS
	 FoGampk5VE3uV6UsOyAbY+er12rOHinm3MYQ5Ws0LskhuO9VDby/MfXIgQw62RvDFP
	 TR2yYD0ovD/OEYBb6XCBJnGzIU5DTWG3M56fsNRSFU5vlvfsDv38ar5WMBmwuU31nQ
	 o19Vb9uIV5GMq8q7Nwk9n4zAzzz2blbBdHX5JWWQzKPKW3jaIZ6zn4HY6V6JlqrPTM
	 zVUW669SvJ+4g==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aec201b582so1111021e87.1
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 14:09:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpc0+bjbxSLkzry+O9EXpAPWZzEof3x8cD2gsjThpwSH/0WQ0RBIyT5iECTWDkbIlidSSyAshv3BL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVXA1LibVAQP4n3ZyB+lbLHLPY7qN6CfiOWBxBgpizfDbrZcVE
	bHP2Uz2YxA5La3HgIIiTgNnj7iG0a+l7rINWsFpj+gXzWJbk99O2AlLDTftHh48NjYEZu5Ks/9+
	rYJA7MYTBNYvZn8vidm8k2drMeQQNfJw=
X-Received: by 2002:ac2:5dc9:0:b0:5ae:bb52:b09d with SMTP id
 2adb3069b0e04-5b2b2f79145mr647594e87.52.1784840982582; Thu, 23 Jul 2026
 14:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723034237.2501507-1-eleanor.lin@realtek.com> <20260723034237.2501507-2-eleanor.lin@realtek.com>
In-Reply-To: <20260723034237.2501507-2-eleanor.lin@realtek.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 23 Jul 2026 23:09:29 +0200
X-Gmail-Original-Message-ID: <CAD++jLmQT46c322ok_0mQ+RP414kT=Qj-sERiWUmcpLHLD_abg@mail.gmail.com>
X-Gm-Features: AUfX_mz01SGpVJmxsXcMwwqmSBs7gpLdKFAKXFcbcmIUyM-ozHTxM5lFVLt6VDg
Message-ID: <CAD++jLmQT46c322ok_0mQ+RP414kT=Qj-sERiWUmcpLHLD_abg@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] Revert "gpio: realtek: Add driver for Realtek DHC
 RTD1625 SoC"
To: Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: andriy.shevchenko@intel.com, mwalle@kernel.org, brgl@kernel.org, 
	tychang@realtek.com, wbg@kernel.org, mathieu.dubois-briand@bootlin.com, 
	nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org, 
	andy@kernel.org, u.kleine-koenig@baylibre.com, dakr@kernel.org, 
	bhelgaas@google.com, o-takashi@sakamocchi.jp, dlechner@baylibre.com, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux@analog.com, 
	linux-iio@vger.kernel.org, cy.huang@realtek.com, james.tai@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 5:43=E2=80=AFAM Yu-Chun Lin <eleanor.lin@realtek.co=
m> wrote:

> This reverts commit a57e27c43b0315ee86c6896510d69be5257e093e.
>
> The driver will be rewritten to use the gpio-regmap infrastructure
> once Andy Shevchenko's patches for gpio-regmap are applied.
>
> Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>

Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
