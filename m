Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA2E233953;
	Sun, 21 Jun 2026 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782052410; cv=none; b=sp3YmDXyCsERyrIqZHWk9/Cy3ZkeVqh9vwgRcv5ADcU1tAPpjObZZIA8HNH3zRZEjHxkcNCcNIkaMaU+LtPy4IjkWiESCcaQXBpN3qgvk0vAc1HPP+SFUKGIZC75KztlLGNKwZoMfG4uR8s8QjdoA0m3AU/mtZOGH1enlxIeYL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782052410; c=relaxed/simple;
	bh=l2Q9VoaHkt4zaSX/YhSMBpOM1m2jLLP3hAZRPgwWq0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUL7HLG9yIu+YDg3qTFWhAxEIwPPe+GJ8VN5rMRcgX6jpBSa6aU+XT+2TmnhKHmUXt8ulMb9NX5YG+b9/KzgU/E5nSOsOz2HQKSDNPEE0GbHx75Hu+dq3HCj8efTuCve6kPpPBkXjPopFinm+O0p3noQ6dWzI9wFzlIWYSSZJMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVa8OhN+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVa8OhN+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5FB1F000E9;
	Sun, 21 Jun 2026 14:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782052409;
	bh=ISQveTthFRMKnHC67eUNMF+ttrHJ4pwOEIMa7RC0l9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nVa8OhN+lAaKLj6dmhaV0mngouPeHePwkxK9BvP6p1jDZ7QOgHV6eIZgstAgUK/OB
	 A+Xy/FZkrp8QDFQupS5mzeFD0l4gdyHHS53sB+R4vahQ/XgqUCXAklfHo5GtZzuzB1
	 vBklZbvkejx9sBX+ZPXzr4BgpdcY0FA6YSl+8+G5td3NP22vVulba+YWOorEuM8QbS
	 2mRb845tIryMG2Kg6nczBAmFluJp6pd5/RiwcytQ/gZGDOAQnuOd6Y4HKPjCReLZ8H
	 R58+Z/uKA9LaCE/FKD5sXXWcgtOEk/LReO/FSItr8aV4X4wyGJztdDIGm19RiJV+q5
	 mYkZ3spWfWd2Q==
Date: Sun, 21 Jun 2026 15:33:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kurt Borja <kuurtb@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Linus
 Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: adc: Add ti-ads1262 driver
Message-ID: <20260621153318.4a723e3b@jic23-huawei>
In-Reply-To: <a994993e-7459-48a2-a8d7-823c1b0c9545@kernel.org>
References: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
	<20260612-ads126x-v1-2-894c788d03ed@gmail.com>
	<20260613-sparkling-naughty-tuna-3e9bf1@quoll>
	<DJ92M0ZMSI2C.2I39LHFRNQS7W@gmail.com>
	<a994993e-7459-48a2-a8d7-823c1b0c9545@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 06:30:28 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 14/06/2026 22:56, Kurt Borja wrote:
> > On Sat Jun 13, 2026 at 1:59 PM -05, Krzysztof Kozlowski wrote:
> > 
> > [...]
> >   
> >> Functions used by probe() should be before probe(), not somewhere in the
> >> middle of the code. IOW, entire probe is together.  
> > 
> > I they all are, it's just that regmap stuff takes a huge chunk. I'll
> > check how to reorganize.
> > 
> > [...]
> >   
> >>> +static const struct of_device_id ads1262_of_match[] = {
> >>> +	{ .compatible = "ti,ads1262" },
> >>> +	{ .compatible = "ti,ads1263" },  
> >>
> >> So devices are fully compatible? Then it should be expressed in the
> >> binding and drop one entry here.  
> > 
> > Not fully compatible as Jonathan said. One is a subset of the other.  
> 
> This is THE meaning of compatible!

This one I'm in agreement with. It is a strict subset, so should be
using a fallback.  If the fallback is used, you just get support of the
stuff in the simpler chip (or if you can override it with a chip ID
you might still 'upgrade' to the more complex driver support).
If you do end up with properties that only apply to 'new' parts of
the more complex chip then they should be verified as part of the
binding (assuming you can do that without the verifier complaining
- I haven't checked!)

The SLF3F discussion is about (to me) less obvious case of not a strict
subset, but rather being detectable parts with different channel related
properties.  In that case the ID match is necessary for anything to work.
Anyhow, that discussion is in a different thread and not really relevant
here.

Jonathan

> 
> 
> Best regards,
> Krzysztof

