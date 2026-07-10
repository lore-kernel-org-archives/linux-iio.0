Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736722AD3F;
	Fri, 10 Jul 2026 00:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783644384; cv=none; b=PnccmGzn5lcBMzMrzul11FD0kM/YJDmxzI0zn+IvmKa1UJFCUwPXOR98VpVtkhEb5uS3lo1FoPqTkhgFfY6feWozN+kruVNL00eDFnodrEuu8n0G7dea79Snq8HyNg7+eON88IGDKVKlJEnArgkF/Z4S8LhOGze9W/p1wlZU/sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783644384; c=relaxed/simple;
	bh=NcAY33Cz+Y07dZSUoRE4dYMoOX/ODftBQ6ejSLDLCig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQ52rdw32Lshb1ZZ2M3gyXJdhXi7X1UUQXrRiTHMRq7vMVE7J22LY/y2/rZecMBjBesBPULZpUnf6MPyo2wxAMTqkPyoo0aIhEBjGszlZqIksTfYZendhzVjI5JbOv/+pstSuZ0Gbn/R8wBXMErZ3RZdqxe2Ok7u/5/M8WLo2K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n26oLl7f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n26oLl7f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5956F1F000E9;
	Fri, 10 Jul 2026 00:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783644383;
	bh=13E5iFkRhhPo8tsl5s9roEJL6c2uaz4ktKevVkLd3/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n26oLl7fvkRaj9R0WlIMV9CH2IijPq0UbKzEoXjkl6V3zPgfQU6pqoeIgXJWJIKQs
	 R8WnP75NkWglA4FGzr0WfYVH2hQmRxKbEdKD3CY1FE1//vfxrouyUEVHx9LObYbmSC
	 EFSFATVRBr6ADR3Kg447bHV10pnJAftkOJjiBvRkgiYrWn14nWd/vAOlhZKNm3dS1Y
	 qpInly4maBuEpmP37Ax7YP3GdlytUCsn+PlrT4puoIZKiV30efH2I0eAbOfCZlzzrh
	 1pXW2ltxzjOSkgUZFem3MOiJHHWfnhl1uS+eY4I8DAIvgK+TGrFEGWoRZgZiahkg6v
	 QkNLnaFK4UXfA==
Date: Fri, 10 Jul 2026 01:46:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <jananisunil.dev@gmail.com>
Subject: Re: [PATCH 3/6] iio: adc: adi-axi-adc: Add support for CRC
Message-ID: <20260710014617.323acf6e@jic23-huawei>
In-Reply-To: <20260709-ad7768-driver-v1-3-44e1194fd96a@analog.com>
References: <20260709-ad7768-driver-v1-0-44e1194fd96a@analog.com>
	<20260709-ad7768-driver-v1-3-44e1194fd96a@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jul 2026 10:50:14 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Add support for enabling and disabling Cyclic Redundancy Check (CRC)
> processing in the AXI ADC backend. CRC provides data integrity verification
> for high-speed ADC data streams, ensuring reliable data transfer between
> the ADC frontend and backend processing systems.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
The 'other things' I found bit from Sashiko is interesting. Far as I can
tell it is right and [devm_]mutex_init() is missing for lock
in struct adi_axi_adc_state().  

Nuno, looks like it was from:
7ecb8ee5c93b ("iio: adc: adi-axi-adc: support digital interface calibration")

Which indeed adds the lock with a mutex_init()

Jonathan

>  static const struct iio_backend_info adi_axi_adc_generic = {
> 

