Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217D12F39C2;
	Thu, 23 Jul 2026 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823781; cv=none; b=UwwTR+73KivihJABv0oZNSd8FPhSOSheITcm4hRFAdk0fI2+AVoRNcZpNOxhosvLPdvIoH/k1ik2B4Z/tmwS6HPOyFRMHrWNe1J69/9RVeUKmTOeKOUQMnrh7hElRWjs+R2vSchmNag3c73p8HHl5sK6vH3p3jIQFCZDrwHvR60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823781; c=relaxed/simple;
	bh=Z5ri1e7p0GBMcGQRKmcWT/Ohx1/Nc4ixnJm6BsQJtYo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=sZnc2shhToDGT6nq/ZO3NGCdBTZgVfGk2OalzxP4p+zLBWyLfN4d4ZGXEDzlTUQA7t8qulUQk0PRWspXSIbZOge2yxJAdOyx48RhnKjxtb/39VYK/V5a+ZTrWVWKvkamcT2cyCubiSJBNYZprr1WJx+dXZdl82GcncDEJ8+wXCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BT+JG3zK; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BT+JG3zK"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7F4131A118D;
	Thu, 23 Jul 2026 16:22:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4FB0D6038D;
	Thu, 23 Jul 2026 16:22:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 162FC11C111F8;
	Thu, 23 Jul 2026 18:22:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784823773; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=P9FjUcSgxHdEsXMburt0XM1gJPAJd7G58Z7kpvKR4BA=;
	b=BT+JG3zKFc9b2QG4EFyMoTUIsGOTnYiKwfSWNhqsITpOPdBro9YvKAUZPqptOifCf2IOKV
	rczJfSkuIbN9v2oB6s/ROmZHMWzKXQPOY3ld9saf0SNKVllzkp1ZZjdvN6a7qlM8V0+j1E
	ZCd67EY2vLwamdsqCxxR+icVDdULNu5iX/2IhpBTQVaDDbi7ExCAyA1RSB/bR/8CgIEq5B
	3fqQKol1rl4z0cfvRwoSh7TlJ30VesZ8EtrAoThhRuCbRC3iJTTvl3YComTRguzwE4EXmh
	x/97kBvpa8VoWrLvAryDpetdUpc4HB+VgiDpxVmv81J3gzFqhx53HUCNZrbVwg==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jul 2026 18:22:47 +0200
Message-Id: <DK637ZCIRBUN.2YESFM7RFP8PM@bootlin.com>
Subject: Re: [PATCH v7 9/9] gpio: realtek: Add driver for Realtek DHC
 RTD1625 SoC
Cc: <dlechner@baylibre.com>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <cy.huang@realtek.com>,
 <james.tai@realtek.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Yu-Chun Lin" <eleanor.lin@realtek.com>, <linusw@kernel.org>,
 <andriy.shevchenko@intel.com>, <mwalle@kernel.org>, <brgl@kernel.org>,
 <tychang@realtek.com>, <wbg@kernel.org>, <nuno.sa@analog.com>,
 <Michael.Hennerich@analog.com>, <jic23@kernel.org>, <andy@kernel.org>,
 <u.kleine-koenig@baylibre.com>, <dakr@kernel.org>, <bhelgaas@google.com>,
 <o-takashi@sakamocchi.jp>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260723034237.2501507-1-eleanor.lin@realtek.com>
 <20260723034237.2501507-10-eleanor.lin@realtek.com>
In-Reply-To: <20260723034237.2501507-10-eleanor.lin@realtek.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Jul 23, 2026 at 5:42 AM CEST, Yu-Chun Lin wrote:

Hi,

> From: Tzuyi Chang <tychang@realtek.com>
> +static void rtd1625_gpio_irq_handle(struct irq_desc *desc)
> +{
> +	unsigned int (*get_reg_offset)(struct rtd1625_gpio *gpio, unsigned int =
offset);
> +	struct rtd1625_gpio *data =3D irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> +	unsigned int irq =3D irq_desc_get_irq(desc);
> +	struct irq_domain *domain =3D data->domain;
> +	unsigned int reg_offset, i, j, val;
> +	irq_hw_number_t hwirq;
> +	unsigned long status;
> +	u32 irq_type;
> +
> +	if (irq =3D=3D data->irqs[RTD1625_IRQ_ASSERT])
> +		get_reg_offset =3D &rtd1625_gpio_gpa_offset;
> +	else if (irq =3D=3D data->irqs[RTD1625_IRQ_DEASSERT])
> +		get_reg_offset =3D &rtd1625_gpio_gpda_offset;
> +	else if (irq =3D=3D data->irqs[RTD1625_IRQ_LEVEL])
> +		get_reg_offset =3D &rtd1625_gpio_level_offset;
> +	else
> +		return;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	for (i =3D 0; i < data->info->num_gpios; i +=3D 32) {
> +		reg_offset =3D get_reg_offset(data, i);
> +		regmap_read(data->regmap, reg_offset, &val);
> +
> +		status =3D val;

Can the regmap_read() fail here? We are not checking its return, so
maybe status will contain garbage?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

