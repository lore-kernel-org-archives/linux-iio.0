Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F132C313283
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780404053; cv=none; b=knVfs6cv5FPMLX7OveRDr7unt+lV5FLTjNjUE349T8FKQuWVNUeZsKo0g6f/7cOF35WZDAVY3YTP19q3p7iKCGQMGeUOB6mpYFB1BFtos0bE7dsvOO4/b6bX/joD6kL5Sbp8DpO94sqWaOVlqquv/RiCcvLicZAdt1hLLzwck+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780404053; c=relaxed/simple;
	bh=lVzbY7ZQf4ZHAgWFWTG/ATbgM/HylQrcyBz+MPl+tvs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=aBjzE9Pymp1D3YbHYb9CSYGP3eA2Q6oVA1VWghpEtSf5mkUPLXTEKIVeisp9rE3O8aUktHoq/DGmRAF4ILjyxwnKHaAJuSgu7BozW32cn7rPCaebwrceNYf4WGkEtdgUdsELl2AYlesT+2RozXZDmFLVn9s1eigrxKxtw4M1C/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/bT/NPL; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/bT/NPL"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49050bfe053so82725945e9.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 05:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780404050; x=1781008850; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FC/oGgXfgkM39LoHP/4Q+MJLr6VB9M/zzchAiEgk6p4=;
        b=N/bT/NPLUQyZi+np95fDIj+5bXx9Uv7+Au/LhN3pE/xq5Bj8MVB7yzqOyYRALuRFWB
         MVyw2qaAZiXespPUwXu0odgPs/iyuwcCewRhHXITyAh6BpncNr4Yv9d5YMcRcSpiNNrg
         y6SRVMYMq3C4mbgoyaEAYR+9MVEbxjMbUUomTZ9lTO7Jsf+q4UILlB/yz3wWAfYcbSIi
         4BIoftv6JMD+jhX1ZyGuzUPr9IUDtNxRcJGTb1MVguuSWALkLdBX7vx7dIGaf5ZbGi/t
         YY5rwNVroWsJ6pqaaewkWzXdlbZOZWF5DymIzVfLwqrfelShlQEf/LU4K/novsIAZfsu
         ir1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780404050; x=1781008850;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FC/oGgXfgkM39LoHP/4Q+MJLr6VB9M/zzchAiEgk6p4=;
        b=FqdVMHiR19coSRRXpRShmSvD8Ll/um9U16sdUwgNNXpnQ/IrTTGpXARt5W14E8lwv6
         jhlACUXsm/BRfMIfUbTzke8g6zYjsn+DmXijgjHyr2WjmoIYdcRBFDuuCJsxQg2EIT1T
         R568X06jJAEhypCEHhOtq+SBjdSxbobbVrBG76wJnzvG4Sz/e7czEsgXqdgt9wsxql0w
         YXrHkr4+VMF28M0Lvd0Dm7iEWtegJ/Yh5mmlp4xyCHt5A2NEDRXacEIiPM76ENm7FauP
         y0Jq92TV2RavfRBskzg9b9U60hantrh3HlWWGGSgo/b6Xe9rqKw4iSmEnE2a9+oQ+fMm
         GZ8g==
X-Forwarded-Encrypted: i=1; AFNElJ+Lh6ZS9qRgdCoOp4az2pRYyjywMyhagJ3aWQE9dvmE54HU5MH3/aZjfRPxiwxODrXTFCcGQJn0sPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ypmw94GAYgTX4MT1yNQTQdWnSVHXJiQ6to/kLvPP7svZ6Olf
	KuchTaKzCF02VtivftBMOwaOaomNIYuz5XtsnXaZVbOKFbs1+M0adHqm
X-Gm-Gg: Acq92OE8I6W0AkuXRvOc7M871H63/fxWLfX5JgDIMUtViwDamVlABCOfQFEhuCzQJZH
	v9MlH4Z7wtWwZJetGLTPXHjTgrqKw8azMJwgG36LDWYLixYZOpy0B6e30sqFSEe0FzGrN7RLqYr
	yx0Uiceghg4RczaR+baZrzwzUqQ+k0+FIlUluCmDfeh/kXCIyeABBKptRRgh23mNxnihcikBT+x
	+VTRjCQR+tnhaC3/ni5zlzvDWTp3MQWGhiXp//untT66VJ1hj4mdR+Mu6vj/49ugxirkdrnFD9A
	CJsreMa38kvl4myFWpMjVe4BxMcJ4SCdaDt88K4k4fKj/wTFj/3DZQnXOUcnzvmIdz52LfG7gbs
	0hHpekcssk3Q9r2fT1vmt3vRw97VhtTn5WkBe6H8dk+2ULpmebIq+i5eb3fs4jOuhXNkBlgpDru
	9p5hhOhhvwEAj3ecCHixAQkP+aWSKPCYzK5FRoVgzsjrHm4B0=
X-Received: by 2002:a05:600c:a11:b0:490:b0f1:c27e with SMTP id 5b1f17b1804b1-490b0f1ce6dmr64690285e9.24.1780404050209;
        Tue, 02 Jun 2026 05:40:50 -0700 (PDT)
Received: from localhost ([2001:4bb8:152:df59:3b69:56ea:a39b:adb4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490af60e03esm59078855e9.2.2026.06.02.05.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 05:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Jun 2026 14:40:47 +0200
Message-Id: <DIYKK894ZZW5.26RO6S0GL2201@gmail.com>
Subject: Re: [PATCH v4 2/4] iio: light: add support for veml6031x00 ALS
 series
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Rishi Gupta"
 <gupt21@gmail.com>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Matti Vaittinen" <mazziesaccount@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Jonathan Cameron" <jic23@kernel.org>, "Javier Carrasco"
 <javier.carrasco.cruz@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.21.0-143-g2f3a2e260c09
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
 <20260531-veml6031x00-v4-2-e64f7fdce38d@gmail.com>
 <ah6p-f2RCW8VcuDR@ashevche-desk.local>
 <DIYI40YK6CSX.2P4017PHVJHCT@gmail.com>
 <20260602133806.53590943@jic23-huawei>
In-Reply-To: <20260602133806.53590943@jic23-huawei>

On Tue Jun 2, 2026 at 2:38 PM CEST, Jonathan Cameron wrote:
>> >> +/*
>> >> + * The gain selector encodes (PD_D4 << 2) | GAIN to identify each ga=
in setting.
>> >> + * Gains are multiplied by 8 to work with integers. The values in th=
e iio-gts
>> >> + * tables don't need corrections because the maximum value of the sc=
ale refers
>> >> + * to GAIN =3D x1, and the rest of the values are obtained from the =
resulting
>> >> + * linear function.
>> >> + * TODO: add support for MILLI_GAIN_X165 and MILLI_GAIN_X660
>> >> + */
>> >> +#define VEML6031X00_SEL_MILLI_GAIN_X125  0x07
>> >> +#define VEML6031X00_SEL_MILLI_GAIN_X250  0x04
>> >> +#define VEML6031X00_SEL_MILLI_GAIN_X500  0x03
>> >> +#define VEML6031X00_SEL_MILLI_GAIN_X1000 0x00
>> >> +#define VEML6031X00_SEL_MILLI_GAIN_X2000 0x01
>> >
>> > Not sure if these one-time use definitions improve or not the readabil=
ity
>> > of the code. Up to Jonathan.
>> >
>>
>> I prefer these definitions, and a similar pattern is used in multiple
>> drivers in IIO, but I have no strong feelings about it.
>
> Looking again at this, what do the numbers in the defines actually mean?
> Seems a bit odd to have the base gain of 1 being called X125.
> Maybe a comment on that would be useful.  I don't mind either way
> on defines for this but if that number is useful to have I'd rather
> have a define than a comment on each line.
>

I thought that MILLI_GAIN was already documenting what x125 is: 0.125 =3D
125 milli. More than the base gain of 1, it is the lowest gain you can
configure.

>>
>> >> +static const struct iio_gain_sel_pair veml6031x00_gain_sel[] =3D {
>> >> +	GAIN_SCALE_GAIN(1, VEML6031X00_SEL_MILLI_GAIN_X125),
>> >> +	GAIN_SCALE_GAIN(2, VEML6031X00_SEL_MILLI_GAIN_X250),
>> >> +	GAIN_SCALE_GAIN(4, VEML6031X00_SEL_MILLI_GAIN_X500),
>> >> +	GAIN_SCALE_GAIN(8, VEML6031X00_SEL_MILLI_GAIN_X1000),
>> >> +	GAIN_SCALE_GAIN(16, VEML6031X00_SEL_MILLI_GAIN_X2000),
>> >> +};
>> >
>> > ...


