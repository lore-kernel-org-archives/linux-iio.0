Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B361F91F6
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 04:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781498584; cv=none; b=PKpcYp/2KQaoMVVYsOYRzRha4TmnM1doorWQwmBFUJDOJyMnnU85lxpK7Zwx46zGcuHXbbz2AwS4vRQHFLNjQPc7DCDcYwPH9avqYdzPsuMWVra+sGcaIAHTG69gNJsXyxrmLyGE/awTGw1FtxP1xALMa6YTpa6PGnph4efK6cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781498584; c=relaxed/simple;
	bh=FdzmA9cNqe8kCysYCqcBOJeAapnnHealTPUZxbjYDTU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=nVxE0HwrnTbZLe+jN0J1QuC1MTQdwQ/idqPVCBJ9J6E7NPnNKjXBhS6jxTCOnLs6dHdCfZk5fdf3HK7+R+/Lxc9IYf+spKq0OZMs8owN6pPZpmPWP5FHjUl7gVdHYWitq7FBdbbzwHpi4bn/Nq4wARhS9HlALAWDVL3Yf2EF8XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyLEMwkG; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyLEMwkG"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-96358d0a024so1969755241.3
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 21:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781498582; x=1782103382; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/0zATgZkedxxJFW8wtHE/FC+bydOMretvCllv2EasY=;
        b=AyLEMwkGNYVTjVg7PGXKEDWRALnxpwuukJRK0nT1NR0c8NHtaCRy3RGNmrUAicTn+Q
         oPVEwbHXpGxfbXbSELUIpWEkCd7V3WejIWP10A3pAyva+osPq3AHLEA4OgTtrbs0dwdH
         ay28MVzNH+qMr8aEpV94zsHUlWd65vowhEEB2Lot6i/C0KxBNldW3juBuVdQw/dzBr7T
         J1NGIF3UK+wPLZMQ5ORXRrO7YMUL5bcT1xVMIajXOx1rqnVKrflNddfs8iM5i6QWvnhO
         bQ7wWXQqK5lXULbKGgmpvRQmoq+Yf4dWH9SiUywmpIW7OiVR0F8mno3w2jHVrK7dPjXn
         28mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781498582; x=1782103382;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/0zATgZkedxxJFW8wtHE/FC+bydOMretvCllv2EasY=;
        b=YWrxK3JV0uEtLi5EhVnMsZEMCCLoIKHk5lW/fZCbFR4JaoXvd6bMqP046knEAwwy4N
         /3oP4pAvK/NrVMJQvXCRdQNMu3smqYE6Ih0FLFrJVxOVAdq8OWbZBq/+0Og7f8u35FLA
         PPahdwq7kXyKwJUhfay79XB24JakdurLW7lsQ8aSfwJj/aBNPMwwf5eAKf7IdXiZfCHt
         nPF0wSfcSSV8ne+czgCTkLlmsV1+7bR1TP9O9AkKU/HnXGOTc/xHQkRH0OcrfDyxI+tx
         L6ZDCsXtrm0W8oI/ht3g2reYXiyObNa1jwZEpxWZjCPDHurAXwusvJQ4XVSC5X4l4hQh
         /KFw==
X-Forwarded-Encrypted: i=1; AFNElJ9okBa5fxshipXCT09QRcAKZbaz2znbzs2pLhcI8CHKG22j8WRuJfhePkl6XYZmhQgHkiLhKwRfDdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfmp/0y3QtingmZEaql2vwX2b0r7OQ9cbJ4pMsLH+8/l5WliA8
	YwhHYHf0rW3Ieu08ecjD4CQQHDxcKzN+ichlve8N3X56gQ6bqvrEy0ws
X-Gm-Gg: Acq92OGUcdr8mSaZmf/p/t6CdzvMINewNatXDpeM7RtKYEKlIlwmCjX6dyecAvOmQSz
	dxqpd3CppWewNr/qXyHfigvvUCsbCk6+/GSsq9cIuhmwRaqBCs4bUvtWyl9Z+tlpqmAISWchTXa
	J40xSW0gvYQM5sfFEQq0udSq8bCPIl5FhdmdLnctfi5+pRU4cakKfh9VbuWe8SfvKW+jc6L39jT
	Ypo8rByfihsOYvwamMz2/C3W8NGoKKC6q1/x8fKF9AQZLQWSvhqFzbfGirHYnv55ra1sKc6BtfR
	SGmquiv1WWTRJkxFi7FajN/6ytbY9sPjisBEyazRqZSLhRFm0JMLtUOp6GfqlJaZeIykdsxslhL
	mn60YZNJjmtYqXroKHVU4hQoDDyWAReg/CsS3v00PK2eqarrN7PbtDOR9Od0WynYoysrhjYCVw4
	2lNZ5GAKSWYUUBPw==
X-Received: by 2002:a05:6102:80a0:b0:634:eb91:695 with SMTP id ada2fe7eead31-71f5e0fa7f2mr4814652137.5.1781498582422;
        Sun, 14 Jun 2026 21:43:02 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-720847c15a5sm1934151137.3.2026.06.14.21.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 21:43:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Jun 2026 23:42:55 -0500
Message-Id: <DJ9CJF4J1UT7.T2SOQM49NL56@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Jonathan Cameron"
 <jic23@kernel.org>
Cc: "Kurt Borja" <kuurtb@gmail.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Linus Walleij" <linusw@kernel.org>, "Bartosz
 Golaszewski" <brgl@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 2/5] iio: adc: Add ti-ads1262 driver
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
 <20260612-ads126x-v1-2-894c788d03ed@gmail.com>
 <20260613-sparkling-naughty-tuna-3e9bf1@quoll>
 <20260614143918.35503c5a@jic23-huawei>
 <08a9a68a-f0f3-45eb-b018-43007a0acfdf@kernel.org>
In-Reply-To: <08a9a68a-f0f3-45eb-b018-43007a0acfdf@kernel.org>

On Sun Jun 14, 2026 at 11:33 PM -05, Krzysztof Kozlowski wrote:
> On 14/06/2026 15:39, Jonathan Cameron wrote:
>>=20
>>>> +
>>>> +DEFINE_RUNTIME_DEV_PM_OPS(ads1262_runtime_pm, ads1262_runtime_suspend=
,
>>>> +			  ads1262_runtime_resume, NULL);
>>>> +
>>>> +static const struct of_device_id ads1262_of_match[] =3D {
>>>> +	{ .compatible =3D "ti,ads1262" },
>>>> +	{ .compatible =3D "ti,ads1263" }, =20
>>>
>>> So devices are fully compatible? Then it should be expressed in the
>>> binding and drop one entry here.
>>=20
>> They aren't. It's relying on one of them having a subnode that spins up =
an
>
> I don't  see anything in the this patch that would be using the other
> compatible, so driver looks like handling it fully compatible.
>
>
>
>> auxdev for the hardware block they don't share.  A fallback would be fin=
e
>
> Patch #5 adding auxdev still does it uncoditionally, thus driver
> clearly treats them as 100% compatible.
>
> Or I missed piece of code - please point me where is any incompatible
> behavior coded.

You're right, Jonathan mentioned the same thing. This was the only check
when creating the auxiliary device.

	node =3D device_get_named_child_node(dev, "adc");
	if (!node)
		return 0;

But I should definitely check if chip is actually ads1263. I just
assumed user would know better, but I'm dropping the subnode anyway so
I'll check the model.

>
>
>
> Best regards,
> Krzysztof

--=20
Thanks,
 ~ Kurt
