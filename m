Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7211DFFB
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785745757; cv=none; b=m3eKeAaDVAU/gJtie2LhTMBsRT8ukPoCQF1z/1G3H6oXoTujM8Z4FrGMSuWz6MUwNOUmLLJw+Myp7v9scVxsR4biRDyyxtcylcSZjXKMjKX3OyzQmPfliWgN+YnnkXuxlVgVeXqlz/9UtNJoRlt8rs05chb5Br+uXfWy4uypeDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785745757; c=relaxed/simple;
	bh=Z/y9bxtOoGbkfjhIV9x0o1TeX0FamxcMKPkwaKtP6zo=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=dS2qeQtUhRXvvUD70fZXQv40aFfNW3WQnVNqHv+LE57vbLSmL4oFZq+TgCTjXLOepZ/GxZOyTKTFo/i5kshbulOV3GoVCjOA9hxjECUFkJ5GD6IrotbEN6VHJNzmYrFX2zHvyrwaTDxZ54c7RLszyvfb4jEfC2anU2ImSbfCWu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p3lN4kSz; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p3lN4kSz"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785745743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yReSINz53RALtgsTLYaQBfhtA4c8gjFI8bbYPh7aZ+U=;
	b=p3lN4kSzvQB6qKNF0Nd+o94KqUgK78m0DcS2fKfjsbzeEE2TCKVFOi/tYOMoyirY/eAw+0
	SYYCP7tdQqo+6Q2GSg1iRiWF2MfTu+o7EUpMnFP/WWD3ogEwdqHKju7hKxGAIvOdYVoHfA
	G8AtVnTZ0/RUbMkcadlL5W5aZl5Fp/w=
Date: Mon, 03 Aug 2026 08:28:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Siratul Islam" <siratul.islam@linux.dev>
Message-ID: <a967c89f72bc36226dfd35ceba61dc0d2e632ddc@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v3 2/2] iio: dac: dac8163: Add driver for DAC8163
To: "David Lechner" <dlechner@baylibre.com>, "Lukas Metz"
 <lukas.metz@gmx.net>, "Jonathan Cameron" <jic23@kernel.org>,
 "=?utf-8?B?TnVubyBTw6E=?=" <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <50fee508-db53-46c3-b245-22893023f370@baylibre.com>
References: <20260802-dac8163-work-v3-0-3ecc7bc66d0d@gmx.net>
 <20260802-dac8163-work-v3-2-3ecc7bc66d0d@gmx.net>
 <50fee508-db53-46c3-b245-22893023f370@baylibre.com>
X-Migadu-Flow: FLOW_OUT

August 2, 2026 at 11:19 PM, "David Lechner" <dlechner@baylibre.com> wrote=
:


>=20
>=20On 8/2/26 11:07 AM, Lukas Metz wrote:
...
> >  +#define LDAC_CHANNEL_A_MASK BIT(0)
> >  +#define LDAC_CHANNEL_B_MASK BIT(1)
> >  +#define VREF_MASK BIT(0)
> >  +
> >  +#define DAC8163_INTERNAL_REF_mV 2500
> >  +#define DAC8163_RES_12_BIT 12
> >  +#define DAC8163_RES_14_BIT 14
> >  +#define DAC8163_RES_16_BIT 16
> >=20
>=20Macros that just map to a number that is part of the macro name
> aren't that helpful. We can just use the number directly.
>=20
Each=20of them repeats 4 times. I think typing a number that many times=
=20
is=20more error prone than having a macro.
> >=20
>=20>
>

--
Best regards,
Sirat
