Received: from mail-4398.protonmail.ch (mail-4398.protonmail.ch [185.70.43.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55E546AA9D
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786712196; cv=none; b=I98vqHZCxCPjUDMnh3tR/J15/d9fbOxysiqzzQ85EcT7xA6RzrAr53UryNReMqtz38l/rdApcenI1Qj8WOT2a6SD+XiwdPrGX9tclZ/j4HcagdE+JvsrjKo7X2CDOVXrVGaxjd69NUMuDoBu6tSi6Io6oISvj8lqa3PZrVg8e2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786712196; c=relaxed/simple;
	bh=WSRREvS77F8CTlZ3F1chw0hcNf3sf3rptyvu++DhCAk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugOXfVDFTY+NUWIvi8C0BmVxUa9mWulkvDkvptweSGtCMI4Gm6ERFhQQ7CW5VMHvxx1MXNq98mKiQPolV1B+fhQkGqmR5E2pc+WqoJtvVXJ9HbDZR7k8mQ5FuUn8+S6LXUKFq00n4SiKr9UgCi8AusWjW8/IrPw1Uri5CgdGE80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=iqsu5PIX; arc=none smtp.client-ip=185.70.43.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="iqsu5PIX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786712185; x=1786971385;
	bh=2Yf07LYHfLo9b1soRxLWPss80HtzZP9OsEKgJi4u6YI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iqsu5PIXxYucDcdnUZpT3c1MvVq+4HF0DnVa8w5bgTgCT2aEX8y1tBG/OdgpxtOjH
	 6ps/xEVBhCacwye5jxhzpn5rMLjACwdrYiBZDpNB/Nh0qYaESFc8n5bRLrNC5ENJpO
	 72iwz0w5miocQalTnkI4sM7GkDUlxQsogrV7XgmhcUF62PE91DvwcuCrb1kpWCkunP
	 vT4MioHgWS3Hk64q3+skaVXvGeV86um5fwVthaWZeOfKpgq0XESWz/r5fexO3H9FrO
	 j4TnaU1vIJOuF76+BnFiM9QBpWfHVMRPLoxpy1NFpc7ZSZHtkrH/KsaZRJmdDZjZ4e
	 Cz4xlFIXttM/w==
Date: Fri, 14 Aug 2026 12:56:19 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>
From: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Martin Kepplinger <martin.kepplinger@theobroma-systems.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] iio: accel: mma8452: Reuse existing dev pointer in mma8452_probe()
Message-ID: <h99ZMXhP-lwjnTgFu2cQm4w_DEW3RLw6D7nm6i30ZQxQYEVIDLiX0M8H5JuI40dFf_mowoDMKWdMf0qqfhLUVyUNXLpyqQLsEJ8KcRRJixU=@geanix.com>
In-Reply-To: <an7MwteTa-b5x_mE@ashevche-desk.local>
References: <20260812-mma8452-open-drain-v4-0-bfca15d02b59@geanix.com> <20260812-mma8452-open-drain-v4-6-bfca15d02b59@geanix.com> <an7MwteTa-b5x_mE@ashevche-desk.local>
Feedback-ID: 133791852:user:proton
X-Pm-Message-ID: 773d4168a6386b9d16720c25a8e8c9811eb323a9
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, August 14th, 2026 at 10:07, Andy Shevchenko <andriy.shevchenko@i=
ntel.com> wrote:

> On Wed, Aug 12, 2026 at 04:30:37PM +0200, Esben Haabendal wrote:
> > In commit 32a5c04d4575 ("iio: accel: mma8452: Use dev_err_probe()") the
> > struct device * pointer was assigned to local variable dev, so we can j=
ust
> > as well reuse that throughout the function for sligthly more readable c=
ode.
>=20
> ...
>=20
> > -=09=09return dev_err_probe(&client->dev, -ENODEV,
> > +=09=09return dev_err_probe(dev, -ENODEV,
> >  =09=09=09=09     "unknown device model\n");
>=20
> =09=09return dev_err_probe(dev, -ENODEV, "unknown device model\n");
>=20
> Now a single line.

Added for v5.

/Esben
