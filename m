Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9563A1A3C;
	Wed, 29 Jul 2026 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785347649; cv=none; b=mTl17jL7tHJo+2ClXPKf7aAN+6H9grg7SgKMkpalksuYwwQXLOF1o1dQLzfQddXJwQ9axM+QWYzfKrm9KkGYbDlK0TFfLPx5sGd8kklTVtO/RA4zv/zATOgYXkrmVRM0aSsfZAAjO90/QudiFjiwk0rJmPOe+G0H64E8yKbaCLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785347649; c=relaxed/simple;
	bh=Q0pdWhMBat3jwyJ8KqHtLbg7jtiLNwyC7rPs1rQwt2s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RXElrgKicbpDjEPCR/wLm+jgKoZ9H5IHg8oun2TO8B2ZQ6/i2wZPFaX9qS7OtvHgcLgfowZXgSzF2acibVj0m8PsX7ORgg9Mfl4Qm8vlpl81i5F6hUXryUpikLWQvZnVQFqhnyfnQqvWSAMTGVo9BI4l6PUut2XRfgzXBkjaPV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=T6ta3zzD; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="T6ta3zzD"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id CCCA984B54;
	Wed, 29 Jul 2026 19:53:59 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9LAyUqDgZ9C9; Wed, 29 Jul 2026 19:53:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1785347639; bh=Q0pdWhMBat3jwyJ8KqHtLbg7jtiLNwyC7rPs1rQwt2s=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=T6ta3zzDE1JmiFBn/Gya87FZ/bfiCNfgO0tA7xlQRX2vxDE8jm+eWaQP86NxPb0aw
	 jjV0bxYerzE5EvxZkZd6mJJ530oG3D7NLV2iN4S8uKjzYyvTNBRLfSJYGEZ3QHHqxv
	 Vay/S1/Zpru1dLhLtTK7u37aiI/KULukdV0oGgR+eHtmQkH6DJi8ww4R9Aocc9nrHM
	 Jevdh0mwt698tkrOpk9mcQKT8/zSlyiwlkcpAbal8N4Sg/HJE6kFYJ+xsciYbd9CRa
	 ktT5KUmO1BBfCKDoRNSOieONsxmlitOIyWg+QDIMi61AI7EUOrWfgEnmUNVnugyGCh
	 w8HEP+zvadkhA==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 23:23:45 +0530
Message-Id: <DKB8WW9AK4KQ.2A9KVJWD5ORFT@disroot.org>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Peter Griffin" <peter.griffin@linaro.org>, "Alim
 Akhtar" <alim.akhtar@samsung.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: proximity: add driver for Sharp GP2AP070S
 proximity sensor
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Joshua Crofts" <joshua.crofts1@gmail.com>, "Kaustabh Chakraborty"
 <kauschluss@disroot.org>
References: <20260723-gp2ap070s-v1-0-b8ca3a4c10dd@disroot.org>
 <20260723-gp2ap070s-v1-2-b8ca3a4c10dd@disroot.org>
 <20260723234439.06411731@systembl0wer>
In-Reply-To: <20260723234439.06411731@systembl0wer>

On 2026-07-23 23:44 +02:00, Joshua Crofts wrote:
> On Thu, 23 Jul 2026 22:58:34 +0530
> Kaustabh Chakraborty <kauschluss@disroot.org> wrote:
>
>> The GP2AP070S is a proximity sensor designed and manufactured by Sharp
>> Corporation. This sensor is used in mobile devices, including, but not
>> limited to - the Samsung Galaxy J6.
>>=20
>> The driver has been adopted from Samsung's downstream kernel
>> implementation [1]. Due to the lack of public documentation about the
>> schematics of this device. The downstream driver acts as the secondary
>> source of information. Driver clarity has also been improved with the
>> help of the GP2AP* drivers in iio/light.
>>=20
>> Link: https://github.com/Exynos7870/android_kernel_samsung_universal7870=
/blob/lineage-16.0/drivers/sensors/gp2ap070s.c [1]
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> ---

[...]

>> =20
>> +config GP2AP070S
>> +	tristate "Sharp GP2AP070S proximity sensor"
>> +	select REGMAP_I2C
>> +	depends on I2C
>
> A very small nit (and probably a personal opinion), but "depends on" shou=
ld
> go before "select"

I happen to agree with this one. However most (but not all) entries
follow select -> depends on though. In any case I'll change it.

>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * IIO driver for Sharp GP2AP070S proximity sensor.
>> + *
>> + * Copyright (C) 2026 Kaustabh Chakraborty <kauschluss@disroot.org>
>> + */
>> +
>> +#include <linux/i2c.h>
>> +#include <linux/iio/events.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/types.h>
>
> Please add iio/* includes after the generic linux/* headers. Ensure
> that there is a blank line between the two groups.
>
> Additionally, you're also missing <asm/byteorder.h>, array_size.h, err.h,
> types.h and delay.h.

By the way, is there any tooling to satisfactorily point out the
shortfalls with includes? Or is it just intuition and experience?

>> +	ret =3D devm_request_threaded_irq(dev, client->irq, NULL,
>> +					gp2ap070s_irq_handler, IRQF_ONESHOT,
>> +					"gp2ap070s-irq", indio_dev);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to request IRQ");
>
> Just return ret instead, dev_err_probe() is called automatically on failu=
re.

Are you sure about that? I happen to call dev_err_probe() on all other
places and other drivers (as of late) as well (other than -ENOMEM).
