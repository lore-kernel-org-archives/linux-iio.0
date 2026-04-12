Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch [79.135.106.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0CF1A6824
	for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775987865; cv=none; b=gtU3jRd+bf28PYIjky4RMAZRbaPGv2qWJ3f9Eu1oPhGcbqjmkhotEIBcKlVdqJj1FUUgZY/qUN6ilZ3dhwIgaNOYNxSqdMEBIiXs7hwbbOimJRUrYrltElygeiYA36baraQIq6Cih4D3ViPP5Irl5gYxeXZKE5NL3TqfkSkUYdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775987865; c=relaxed/simple;
	bh=Nd5KnTyclI6vIVZacPOcTiXqJVdoEfttW6bRj8jEAsQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGm43MxDFT8wv1MBfSwCk8zFGd01Mk+MMUEjbV8Gxvjv3sqwyGNmYAhyFVlRWYQBzwKev4V04digzOAHieOWFEH/zr1d8PzGHggJACWw9s43JN45Wl2QnyXQqOMLeXGvYkU4JvvDQwZ23qG6//q/Xh0oNln2RoRwzTtoBEOXv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=PRtpWUEO; arc=none smtp.client-ip=79.135.106.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="PRtpWUEO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1775987862; x=1776247062;
	bh=m62pQ6MlRJbuDHfWnQYCUS683UQ4OtZk6TfL949rG7U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PRtpWUEOYwcN+mAs4enZjgiZZB959OHhQzQ9zp6xIQlXpbVPaT/UX/NjE7qt9LTjW
	 egPrk5ArDXhce4Y54vQJsFyvsgcBeRZFcw3pGoqXuUZMHL2slQcNSFHusao0omjvNN
	 nvFXZEUk1NuT9Akw4CH/EhjeJoBWRiU4Jtme8OCGf/orDP9fNi9ZA/PmCtbY/561RZ
	 uOGs9IkqxmXkgExSx8oDO6nKNlNeVWM7lKHv2wqYJSYrI4apqxa8u5bm301hyUyQLU
	 mWB0Uiivu/6n3zVTYVBUSTfPfSWH1NykACt8/Q1jZ2h8K7mECMAo1blXJV0VNFN9e9
	 p72DhZNT1efZg==
Date: Sun, 12 Apr 2026 09:57:36 +0000
To: David Lechner <dlechner@baylibre.com>, Hardik Phalet <hardik.phalet@pm.me>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: Jonathan Cameron <jic23@kernel.org>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Brigham Campbell <me@brighamcampbell.com>, Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 4/4] MAINTAINERS: Add entry for QST QMC5883P magnetometer driver
Message-ID: <DHR35EXKX62B.JXCVL4O1Z55U@pm.me>
In-Reply-To: <0fd8a01c-0ca9-4caf-946b-5e0e756e4cab@baylibre.com>
References: <20260409210639.3197576-1-hardik.phalet@pm.me> <20260409210639.3197576-5-hardik.phalet@pm.me> <0fd8a01c-0ca9-4caf-946b-5e0e756e4cab@baylibre.com>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: 19cadfc419b259b7a96812175002a7921ce6e2f0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat Apr 11, 2026 at 1:02 AM IST, David Lechner wrote:
> On 4/9/26 4:07 PM, Hardik Phalet wrote:
>> Add a MAINTAINERS entry for the QST QMC5883P staging IIO driver,
>> covering the driver source and its device tree binding.
>>
>> Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
>> ---
>>  MAINTAINERS | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a92290fffa16..d0b9bfceb283 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20274,6 +20274,13 @@ F:=09Documentation/networking/device_drivers/et=
hernet/freescale/dpaa2/overview.rst
>>  F:=09drivers/bus/fsl-mc/
>>  F:=09include/uapi/linux/fsl_mc.h
>>
>> +QST QMC5883P MAGNETOMETER DRIVER
>> +M:=09Hardik Phalet <hardik.phalet@pm.me>
>> +L:=09linux-iio@vger.kernel.org
>> +S:=09Maintained
>> +F:=09Documentation/devicetree/bindings/iio/magnetometer/qst,qmc5883p.ya=
ml
>> +F:=09drivers/staging/iio/magnetometer/
>> +
>>  QT1010 MEDIA DRIVER
>>  L:=09linux-media@vger.kernel.org
>>  S:=09Orphan
>
> This should be split up and added in the patches that actually
> add the F: files. Most of it will go with the dt-bingings patch
> and the one line added later with the driver.

Makes sense, David. Will do in the next patch series.

Regards,
Hardik

