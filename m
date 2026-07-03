Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB30375F83;
	Fri,  3 Jul 2026 11:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076957; cv=none; b=W92MX6EP3hQpE8HqHuPkOVDYRDJdMrZ+83KaeJuPk74kOwDuBoSyv4j5Y+iL47fn5N2GuYjvyTH0dZ6FQxK3Er4KOoY0RXHHgD24hzSi4fKJyOY7PzSALL0MNXd2JUDyzDs0GGz4c5vPdOr/Jxqnw81gX986gnu+PgETg9tTfiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076957; c=relaxed/simple;
	bh=J4lbIewbp//OWqVawc0kwzLxFyB+WGnSs2Zv7Dy6SeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYrR2dC1jCUYmfziCLau4qDgRAqixlXz+JZWM/CR8QbaV8Ftu4VzXi2QoGxOxtUTXQZeCYj9rnwrY5ecPnfAQyTl8Ou8wwOpHrEmKVRL1flHZ2EOMfByi3u2QKEW9/pthLb9sDCIuG19T0kh9j+S9c710kmMg3Y1BoVZFR7dvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LM3BmMC7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LM3BmMC7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96BA1F000E9;
	Fri,  3 Jul 2026 11:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783076955;
	bh=tuWJc8imFqb5FUwYOIHT8S1/CiCKvV///7YUxzwmiDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LM3BmMC7MgYSpIzMfpzB+fFYNAhMe9wIo1o0OJLC1Kel2K2ZP/+VYxOAC9ivUroRz
	 e4JPeoPiFFfqZ1qhYtgHkZfsdaJh8zcFkZV/66zPWGhUzxzaFzlF4vJpkPovVJSOtI
	 lwj3dqu+64Kj8tRzc145Qxd72W41qMMdgRzcTAa273NCEWWlyJtiJvPgXzbS3Dgy7H
	 MoZ72HwHtFSy9sa/vMxx7hgMY28svlczu2j7TqHWvEhRlnhjNiIsYAZQu4yNqsXE4d
	 nuCScM8ZI10umNXmDNle0KarbBqoXiOd0UIayfbNh22N3Bes3fi6oQgXyA+zQkFa33
	 pLJ/aYI5MisIg==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wfblh-00000000jBK-1vKA;
	Fri, 03 Jul 2026 13:09:13 +0200
Date: Fri, 3 Jul 2026 13:09:13 +0200
From: Johan Hovold <johan@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 09/14] mfd: lm3533: Add support for VIN power supply
Message-ID: <akeYWRF-wIlrHTF5@hovoldconsulting.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-10-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617080031.99156-10-clamor95@gmail.com>

On Wed, Jun 17, 2026 at 11:00:26AM +0300, Svyatoslav Ryhel wrote:
> Add support for 2.7V-5.5V VIN power supply.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
 
> -static void lm3533_enable(struct lm3533 *lm3533)
> +static int lm3533_enable(struct lm3533 *lm3533)
>  {
> +	int ret;
> +
> +	ret = regulator_enable(lm3533->vin_supply);
> +	if (ret) {
> +		dev_err(lm3533->dev, "failed to enable vin power supply\n");
> +		return ret;
> +	}
> +

No delay needed?

>  	gpiod_set_value(lm3533->hwen, 1);
> +
> +	return 0;
>  }

Johan
