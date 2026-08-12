Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AC331282F;
	Wed, 12 Aug 2026 06:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786517009; cv=none; b=e1LqXxic2zL9rwZVTy2OUNHEhtb+apORFKB2szQEz8OJza/+CmTWqGER9QLgOo5V8RSgr179YHjjY/FPrnn3KktnUWpjrAG53DxJOfkvo+IoPVgHiHwVv4hSGC/39gbLBZt/zleBbOkAepIrKXi9xyOiVXyYXyPdSurH4TRQBh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786517009; c=relaxed/simple;
	bh=l9kYW2cjifORa7furRmTiAaP9Rqs4SHR94tXkJbx490=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=M5OkF3hKM8Z+ufk8prMDPKKUsrCTaFdcZ5/9SVsxjg2TYzJQkq1CHMYSYh7Zlp2XmNicmpBUMMWq/FqL7Gf1zpyo0utmXAporcw8a04poURixE5oxMHJWxmwM4QDWLYnB8rfFuCt6Iakfg0TBsMWTwNxdHIQE/4JlVwwy7mchJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 81E42141;
	Wed, 12 Aug 2026 08:43:20 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 08:43:20 +0200
Message-Id: <DKMRF7SNHX5L.263MVTD0EZHD3@kernel.org>
Subject: Re: [PATCH v2 5/7] gpio: regmap: Add runtime PM and
 read_output_reg_set support
Cc: <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <jananisunil.dev@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Janani Sunil" <janani.sunil@analog.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Michael Hennerich" <Michael.Hennerich@analog.com>,
 "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, "Andy Shevchenko" <andy@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Olivier Moysan"
 <olivier.moysan@foss.st.com>, "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Linus Walleij" <linusw@kernel.org>, "Bartosz Golaszewski"
 <brgl@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan"
 <skhan@linuxfoundation.org>
X-Mailer: aerc 0.20.0
References: <20260806-ad7768-driver-v2-0-027ac5e2a641@analog.com>
 <20260806-ad7768-driver-v2-5-027ac5e2a641@analog.com>
In-Reply-To: <20260806-ad7768-driver-v2-5-027ac5e2a641@analog.com>

On Thu Aug 6, 2026 at 5:41 PM CEST, Janani Sunil wrote:
> The new pm_dev field in gpio_regmap_config allows a driver to supply a
> device for runtime PM. All operations call pm_runtime_resume_and_get()
> before accessing the regmap and pm_runtime_put_autosuspend() on return.
>
> The new read_output_reg_set flag when set, gpio_regmap_get() checks the
> pin direction first and reads from reg_set_base instead of reg_dat_base
> for output pins. Requires both reg_dat_base and reg_set_base to be
> configured.

As already mentioned. please split it into two patches. Also, could
you add some context where/why this is used/useful?

So, if the direction is output, then you just read back the set
value (instead of the actual line state). Is that correct? Why can't
you read the input buffer in that case? Input buffer deactivated?
(NB. you can never get the real line state in that case, which is
sometimes useful for debugging.)

Anyway, you should be able to achieve the same with the
reg_mask_xlate(), no? Check if the pin is in output mode, then
change the &reg.

-michael
