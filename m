Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD3336A017;
	Sun, 12 Apr 2026 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775989669; cv=none; b=j3VHTPQfk2HvbLzwVIT3+tEV7AOUc+G7d3te9b7FUuhrpwUlS185FmkHDrj4pFGSPu1LUQyc2j9P+NMUkmfm0lsdT9WOQmJTBbzlgFlDitKWjNMZxshChZFcvPFBp24M18V6qtnTqbfgcuLcAvRFuIBuniu14S7NRlnpN6jHOwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775989669; c=relaxed/simple;
	bh=Fb+iy214nkBZD/1vILBaqdJySM/dYbp0frvJlHa34L4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6MnVuTsNHepPqeSMzgsljYB1j3w7NPEmX2zECC2wl2vCkBiLw8exd1e0t9EfeHvSFK5kDeGpfOW1r1679gdVoSLCmUHrhPrX1KA9bNnCmqDq9ur/0VGEq269yRyAw9zVojteAl7XhYOnCdGN1neVpKHu1vtKu5EoTXBpGLfW8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=i3CQsK/3; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="i3CQsK/3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1775989659; x=1776248859;
	bh=Hu+JhgDjG1Koq0uyesSd7HAVzlx/gHPQZ6qjs/BH2FM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=i3CQsK/3qliVBQ6WqeIzkkN8ZO1eCWprtlVgFESJRDqf1jlJX2uXB2EYskAY0eGVV
	 hYzUswQBMJrgcGEEWppeUhLcck3rhsKliPy8ldd3Ko+VHQ9dw6TDlAYZxB4T1GCbyp
	 DdM0Dk92xqHHi21KMIEg8CSpzY8vUTs+KJoU08EAky5X536rEAn0IwsOA5cVl3Xzuo
	 9KVMfs+beA/uKZPqq7265dP3lAIYLR713vwT0b/SldDFYXux8jktnW6BdRS26i6d5h
	 +L6q+L/U97WW6TXibhyM/U9ysYgAM+xOJRHhG+kdly5C47t4f58v2aKsOdnqeFkzay
	 gceygUkvgoC3g==
Date: Sun, 12 Apr 2026 10:27:36 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Hardik Phalet <hardik.phalet@pm.me>
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Brigham Campbell <me@brighamcampbell.com>, Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 0/4] Add QST QMC5883P magnetometer driver
Message-ID: <DHR3SE5ACRQ9.2T8T819298YGI@pm.me>
In-Reply-To: <adh-PKgh5C0-iAah@ashevche-desk.local>
References: <20260409210639.3197576-1-hardik.phalet@pm.me> <adh-PKgh5C0-iAah@ashevche-desk.local>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: 7304b4ee7f4f79eaf61bf7339cd13047c651db7b
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Apr 10, 2026 at 10:06 AM IST, Andy Shevchenko wrote:
> On Thu, Apr 09, 2026 at 09:07:11PM +0000, Hardik Phalet wrote:
>> Verification steps performed:
>>   - Chip ID register (0x00) reads back 0x80 on probe, confirming the
>>     correct device is present
>>   - All three axes (in_magn_x_raw, in_magn_y_raw, in_magn_z_raw) return
>>     non-zero, stable values when the board is held still and change
>>     appropriately when the board is rotated
>>   - in_magn_x_scale (and Y, Z) returns the expected fractional value for
>>     the default =C2=B18 G range (1/37500000)
>>   - in_magn_sampling_frequency / _available, in_magn_oversampling_ratio =
/
>>     _available, and downsampling_ratio / downsampling_ratio_available al=
l
>>     read and write correctly; the chip responds without error to each
>>     valid setting
>>   - Runtime PM: after 2 s of inactivity the device enters suspend mode
>>     (MODE =3D 0x00 confirmed via i2cdump); the next sysfs read correctly
>>     resumes the device and returns valid data
>>   - System suspend/resume (echo mem > /sys/power/state) leaves the
>>     driver in a consistent state; readings remain valid after resume
>>   - dt_binding_check passes for patch 2/4
>>   - Kernel builds cleanly with W=3D1 and no new warnings
>
> This driver is rather huge. There are mistakes you made in the process, t=
hough:
> - never send a new version for such a code (amount and complexity) earlie=
r than
> a week; give others a chance to review
Noted, Andy. I will take care of it from now on.

> - do not put driver to staging, why?
There are some functionality missing. But it has since been made clear
to me that that is not a valid reason. I will move to `drivers/iio`
in the next patch series.

> - the investigation is rather poor about existence of the driver =
=E2=80=94 make sure
> there is no compatible (by register layout) driver in IIO or even outside=
 it
> (for ADCs it might appear as HWMON [drivers/hwmon] or INPUT [drivers/inpu=
t]
>  in some cases)
I will dig a bit deeper into this. But I could not find any thing
realted to the device I am working on (qmc5883p).=20

There is a device hmc5843_core.c that already handles HMC5883L. But the
register layout is different, field ranges, gain encoding etc. are
different and I think warrants a separate driver. Other than that I
could not find something related to device I am working on.=20

I will carefully go through HWMON and INPUT too, but do you have a
strategy to help me find somehting similar? It will be very useful.
Would `grep`-ing for 5883 and QST be a right starting point?

>
> --
> With Best Regards,
> Andy Shevchenko

Thank you for the review Andy, I appreciate your time!

Regards,
Hardik

-=20


