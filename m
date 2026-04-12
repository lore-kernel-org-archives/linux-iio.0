Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66156319852
	for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775988329; cv=none; b=Z1ak1oum500y6JXX8E0KtbxX86oDjp2XcSfEdvYyIOljyKvBcADB6JU8ck17chTV2uVGl2K157xXI/IGGubEF6dAfOWpvl7yeC9jBSXIhS9JKMdWGPvawx7FEmu9y0bVk6jPxEvLMMZly+G6/pItWedpOe/Bof2EfJxp5aATl24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775988329; c=relaxed/simple;
	bh=Ro2s/DMoOSY/diz7ztskdLsgT8ew6ri0RnDa+U4SOEg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfX8ULU+FtMyqsZTDLw8nGj8mpuk5hzRgynEHyG2jQ+6PXkeEHz8bKkRR2CGZaTzpehwudtMEzs5auxqm+WswXjiHLrDkNSj4X7sL3RsMeCV0DQhCCU2gKDksqmPrr7liPNDq7RhlcPfIsZ8mg3MQPpq1ggghZCYWbAfRnFM5AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=WmxN1zdb; arc=none smtp.client-ip=185.70.43.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="WmxN1zdb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1775988320; x=1776247520;
	bh=6Tx4vVjdh5D09eYTtMxiFd+EQ6vkk9v/jTtyqYbyAPY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WmxN1zdbHIFdTzig64vEEmOjFcUtwIWaArLyd/dgm3dbA30j4Q8TSg2EeEptyCUfb
	 weKjUJFedmoIVWLbIWKNp1Km0JkkMoxAbjWr0RQ830FP7wJggSNX7tspe3A9gvsaj+
	 +w0dQWj3mA1kX8uiuWVS2gBlHWcOELTVxvILZwDqd/SSzdvOyjzQCRCnt2DYe00fs3
	 upjuPVkyKM7VNwY3BQx1BKPpexG2bbNBTCceuNUxo5u3kFIgGwLklT3DxwokgmRl/H
	 oodhtB9PNy072EUle1sNOs3vinF28810hYpVczEFKHQ2/Ri63wWsKtqPbN5TEsmwoM
	 a9LUCSRSvxybQ==
Date: Sun, 12 Apr 2026 10:05:15 +0000
To: David Lechner <dlechner@baylibre.com>, Hardik Phalet <hardik.phalet@pm.me>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: Jonathan Cameron <jic23@kernel.org>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Brigham Campbell <me@brighamcampbell.com>, Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 0/4] Add QST QMC5883P magnetometer driver
Message-ID: <DHR3B98LQ4I5.3R5K7W1J1EJC3@pm.me>
In-Reply-To: <ac8912f2-3bee-483f-91f1-72c5346792c6@baylibre.com>
References: <20260409210639.3197576-1-hardik.phalet@pm.me> <ac8912f2-3bee-483f-91f1-72c5346792c6@baylibre.com>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: 7c9b77c591f5f02e0a9d71b2e0405bbeb18ac855
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat Apr 11, 2026 at 12:56 AM IST, David Lechner wrote:
> On 4/9/26 4:07 PM, Hardik Phalet wrote:
>
> For a series this be, please wait at least a week for more feedback
> before submitting the next revision.
>
Noted.=20

>> This series adds initial Linux support for the QST QMC5883P, a 3-axis
>> anisotropic magneto-resistive (AMR) magnetometer with a 16-bit ADC that
>> communicates over I2C. To my knowledge there is no existing upstream
>> driver for this device.
>>
>> The driver supports:
>>   - Raw magnetic field readings on X, Y, and Z axes
>>   - Four selectable full-scale ranges (=C2=B12 G, =C2=B18 G, =C2=B112 G,=
 =C2=B130 G)
>>   - Configurable output data rate (10, 50, 100, 200 Hz)
>>   - Configurable oversampling ratio (1, 2, 4, 8)
>>   - Configurable downsampling ratio (1, 2, 4, 8) via a custom sysfs
>
> What is the difference between oversampling and downsampling? I think
> we have used some filter attribute for downsampling/decimation in some
> other drivers so maybe that could be a good fit?
>
I mentioned my problem with it in my reply to your review for the third
patch in the series. Meanwhile, I will also have a look at how other
drivers are handling it.

>>     attribute
>>   - Runtime PM with a 2 s autosuspend delay
>>   - System suspend/resume via pm_runtime_force_suspend/resume
>>
>> Regmap with an rbtree cache is used throughout. CTRL_1 and CTRL_2
>> bit fields are accessed via regmap_field to avoid read-modify-write
>> races. The STATUS register is marked precious so regmap never reads
>> it speculatively and clears the DRDY/OVFL bits unexpectedly.
>>
>> The init sequence on probe is: soft reset =E2=86=92 wait 1 ms =E2=86=
=92 deassert
>> reset =E2=86=92 configure SET/RESET control =E2=86=92 apply default ODR/=
OSR/DSR/RNG
>> =E2=86=92 enter normal mode. This ordering was determined empirically on
>> hardware to produce reliable, non-zero axis readings.
>>
>> The driver is placed under drivers/staging/iio/magnetometer/ with a
>> TODO file tracking the remaining work before it can graduate:
>>   - Triggered buffer support (iio_triggered_buffer_setup)
>>   - DRDY interrupt support
>>   - Self-test implementation
>
> These are not reasons to have the driver in staging. It is fine
> to have a driver that doesn't implement all functionality. We should
> be able to add those features without breaking anything.
Noted.

Regards,
Hardik

