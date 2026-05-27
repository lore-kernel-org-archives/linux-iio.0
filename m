Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244A82F8EBA;
	Wed, 27 May 2026 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898713; cv=none; b=U0GMcj+UhnmQUucNTJ8NL8llQ+AuucHlqQVL2IzewFp067P+7Jz8ZFvOrPVagZPxhseX9ZavdWV11rUXR7yHyVZkvJM/S3Jh18HxVnjpKIBV5uJ1Rx0e0WXRGrwaGCb8UgjDteoJ5qwMetsj21CqDfY0T3QAW4fqXPXlFoKCsXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898713; c=relaxed/simple;
	bh=GOK2kY6VfMHVIamePbvR3uXm6epelJf4BmGJo2omfPE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=htpvNr5rMokHapRLUa5tR0OJZjB4of9PvEyOPzlwMfhrG5ribBiymOrrM213ZiPwo9xK+R9qyWQyn1wwtdDtJ9HJdG9muLeaS407JnQ/hELBY44O8CARcd5KzaE8AvZKO+DKtoFvwnum9166etB2Z3g4ke5e3scHf2AgU+Sxrvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrvRHbXN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrvRHbXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2994B1F000E9;
	Wed, 27 May 2026 16:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779898711;
	bh=Pim3r/VEyfUyEfIp19lAX5OWZ6f+pomHvDivhKel1vc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WrvRHbXNHvZcIbUFy6VgEGOlVdt9HlCqOluU+c3b0PgieICnqWDscNCRDs6TCT0UZ
	 7CMCi0FfQ2jAvQZNO9dNmO9eMTz8xsMfch9ZUTZEieY/dxvI3RT6ttQdbHF3hyxneA
	 UF2Wh4C3V6gR2V7lexR0uP8pkp2RE5q1ezBFl46y2xct7wwRpevm7qcNCYmmmISsls
	 p0KuatrYBHISbSbXnMQYkVuoQE3v1iI6r1ripoLk0Yjy30CSi6NNXGLKESwl7w28rU
	 DgPv2dKhtMvdmuogSFjlHUVybjepYGS7ScRu3ae7UVodgkI9UYuxmTpj/M3nocB34V
	 m1E4JzEuVzvPQ==
Date: Wed, 27 May 2026 17:18:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Liviu Stan <liviu.stan@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "Antoniu Miclaus" <antoniu.miclaus@analog.com>, Francesco Lavra
 <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>,
 <devicetree@vger.kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v4 4/9] iio: temperature: ltc2983: Use local device
 pointer consistently
Message-ID: <20260527171820.4cbf10d4@jic23-huawei>
In-Reply-To: <20260525164013.118614-5-liviu.stan@analog.com>
References: <20260525164013.118614-1-liviu.stan@analog.com>
	<20260525164013.118614-5-liviu.stan@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 19:39:31 +0300
Liviu Stan <liviu.stan@analog.com> wrote:

> Some functions define a local 'dev' pointer but still use bare
> '&st->spi->dev' in some code paths, and some don't have it at all.
> Replace bare references with the local pointer for consistency and
> collapse some wrapped lines that now fit within 80 characters.
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Liviu Stan <liviu.stan@analog.com>
Applied to the testing branch of iio.git.

Thanks,

Jonathan
