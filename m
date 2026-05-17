Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch [79.135.106.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070792F7F1D
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779045481; cv=none; b=SzuzjMLmP8MJbQitnEFwPTqTVj/Wo/WSU55n/yNJTVe9wAvbAZ+Wjuc8bftcgpJiE634qzFjR5qj29sYqiA2g+dUoaTZb8vZY23lvuZ9MofCtQ2A6M/1QTcaP5ZOqgRKNilFdNncWb1Z3juGe+Ug2XKjNB+ScTchJtLjMpe9mng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779045481; c=relaxed/simple;
	bh=GOBi/pRWmVL+Veh9IwhLDZRHfmJP1ezRNfavGxJ3mzA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XsfDFPTLMQ/oomULOEJ4AgIekVsGsoHq+TZQu4uDE79Cqf25nR1xmLeNE1w2CVXl8hR5Ox892RbpjrGJPq1dK6x62sC2cgXy0KZAzgI+N346mCKgMcNpr3kQn/H9KZ+ZNjjO30z5/lFARugs4ycI4QyBb0Q9V0HBDLezkWvYUbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=a5OjVGJ2; arc=none smtp.client-ip=79.135.106.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="a5OjVGJ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1779045471; x=1779304671;
	bh=K8NQAnOha8d5JNbdYdd0AJXyY7YRm1TTkyKzdhoGALc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=a5OjVGJ2gfOIinrqLlNmFTz9/VT17fCi70c7K/d1artQVe18Du9SUYOFK+CKMbVZg
	 XStVCZxrXgkYvlZ2KlHibkk9khiyX+3fGsjAyFhIRo3FuAv1s+phABggnef7L8nds1
	 05MzWRkCl+KE0Wt6EyAb4UJ1uvVYWTiCsB16Sn5aS+TmksCHKfR2YOzE6YpQXxbGny
	 pqEHPMR5KnEIEQEIYfhYkfmiRXPVWaGyuqFYGULBHdpPIb3R1IdrtNuge0FJTIjyIv
	 aH7njgAPiz4kr4VCmap3/EqeqUkuk1dceWDiim2lJY5/rxNN3p2SuK45HjNSoa0OeX
	 VhcCOK0N4If0Q==
Date: Sun, 17 May 2026 19:17:44 +0000
To: Jonathan Cameron <jic23@kernel.org>, Hardik Phalet <hardik.phalet@pm.me>
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: gregkh@linuxfoundation.org, andy@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dlechner@baylibre.com, krzk+dt@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, me@brighamcampbell.com, nuno.sa@analog.com, robh@kernel.org, skhan@linuxfoundation.org, Hardik Phalet <hardik.phalet@gmail.com>
Subject: Re: [PATCH v3 0/5] iio: magnetometer: add driver for QST QMC5883P
Message-ID: <DIL6ZC7KKYMN.36KGJXKDRGFB0@pm.me>
In-Reply-To: <20260420144534.0e47c06a@jic23-huawei>
References: <20260420-qmc5883p-driver-v3-0-da1e97088f8b@pm.me> <20260420144534.0e47c06a@jic23-huawei>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: e13c3f58e0d2edfad5428b12adb06f0f421ca919
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Apr 20, 2026 at 7:15 PM IST, Jonathan Cameron wrote:
> On Sun, 19 Apr 2026 22:32:09 +0000
> Hardik Phalet <hardik.phalet@pm.me> wrote:
>
>> This series adds an IIO driver for the QST QMC5883P, a 3-axis
>> anisotropic magneto-resistive (AMR) magnetometer with a 16-bit ADC,
>> communicating over I2C. To my knowledge there is no existing
>> upstream driver for this device (see "Prior-art register-map check"
>> below).
>>
>> The driver supports:
>>   - Raw magnetic field readings on X, Y and Z axes
>>   - Four full-scale ranges (+/-2 G, +/-8 G, +/-12 G, +/-30 G),
>>     selectable via IIO_CHAN_INFO_SCALE
>>   - Four output data rates (10, 50, 100, 200 Hz), selectable via
>>     IIO_CHAN_INFO_SAMP_FREQ
>>   - Four oversampling ratios (1, 2, 4, 8), selectable via
>>     IIO_CHAN_INFO_OVERSAMPLING_RATIO
>
> I'm suspicious about this one based on a very quick read of the datasheet=
.
> Conventional oversampling would involve running the internal sampling
> engine at a multiple of the sampling frequency, and then averaging the
> results.  The datasheet describes this as:
> "Over sample Rate (OSR1) registers are used to control bandwidth of an
>  internal digital filter. Larger OSR value leads to smaller filter bandwi=
dth,
>  less in-band noise and higher power consumption. It could be used to rea=
ch a
>  good balance between noise and power. Four over sample ratios can be sel=
ected,
>  8,4,2 or 1."
>
> That sounds like a boxcar filter to me not oversampling (which would be
> a combination of box car and reducing the output data rate).
>
> If possible, can you enable the data ready output and put a scope on it
> to see if that changes frequency when OSR or OSR2 are modified.
>
> Trickier to do would be looking at the noise levels whilst playing with
> these filters and see if they at least match with standard filter types.
>
> If we can't figure these out, then it may be a case of picking something
> that works well and hard coding that rather than letting userspace
> change things in a fashion that might not match the ABI.

I could not arrange a oscilloscope. So wrote a small standalone tool that d=
rives
the chip directly over /dev/i2c-N (skipping the driver) on a Pi 4 and
characterised all three fields in CTRL_1 with timing + noise measurements.
Summary:

  Field    Bits     Role per measurement
  ODR      [3:2]    output rate, accurate to ~3% of nominal in Normal Mode
  OSR1     [5:4]    low-pass filter (bandwidth control), no rate change
  OSR2     [7:6]    N-sample averaging, no rate change (real oversampling)

1. DRDY interval vs each field (median of 500 samples per setting,
   ms; SCHED_FIFO, pinned CPU):

   vary ODR (OSR1=3D1, OSR2=3D1):
     ODR=3D10 Hz  -> 100.9 ms       ODR=3D100 Hz -> 10.30 ms
     ODR=3D50 Hz  ->  20.5 ms       ODR=3D200 Hz ->  5.14 ms

   vary OSR1 (ODR=3D200 Hz, OSR2=3D1):
     OSR1=3D1 -> 5.142 ms           OSR1=3D4 -> 5.139 ms
     OSR1=3D2 -> 5.143 ms           OSR1=3D8 -> 5.141 ms

   vary OSR2 (ODR=3D200 Hz, OSR1=3D1):
     OSR2=3D1 -> 5.142 ms           OSR2=3D4 -> 5.142 ms
     OSR2=3D2 -> 5.140 ms           OSR2=3D8 -> 5.141 ms

   ODR is the only knob that changes the rate.

2. Per-axis noise stddev (2000 samples, sensor still, ratios vs N=3D1):

   vary OSR1:                   vary OSR2:
     OSR1=3D1 -> 1.000              OSR2=3D1 -> 1.000
     OSR1=3D2 -> 0.723              OSR2=3D2 -> 0.706
     OSR1=3D4 -> 0.544              OSR2=3D4 -> 0.494
     OSR1=3D8 -> 0.416              OSR2=3D8 -> 0.333

   Reference for N-sample averaging (1/sqrt(N)):
     1.000 / 0.707 / 0.500 / 0.354

   OSR2 matches within measurement noise; OSR1 trails the curve,
   which is the expected signature of a bandwidth-limiting filter
   on non-white input noise.

So to my understanding, OSR2 is true oversampling. OSR1 is a filter.

v4 plan, pending your input on (c):

  (a) Add an OSR2 regmap_field and expose it as
      IIO_CHAN_INFO_OVERSAMPLING_RATIO with values {1, 2, 4, 8}.
  (b) Drop the OVERSAMPLING_RATIO mapping on OSR1.
  (c) For OSR1, two options:
        i)  expose as IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY.
            The public datasheet does not give cutoff frequencies,
            so I'd have to either characterise them empirically and
            document them in the driver, or use placeholder values
            derived from the OSR1 setting alone (which feels wrong).
        ii) hard-code OSR1=3D1 in chip_init and not expose it. Loses
            the noise-vs-bandwidth tradeoff but keeps the ABI clean.
      Slight preference for (ii) unless you'd rather see the filter
      knob exposed.
  (d) Keep ODR mapped to IIO_CHAN_INFO_SAMP_FREQ as in v3.

One other finding worth mentioning: the datasheet's setup examples
(sec 7.1, 7.2, 7.3) all write 0x06 to register 0x29 before entering
an active mode, with the comment "Define the sign for X Y and Z axis".
This register is not listed in the documented register map but the
write is required for axes Y and Z to come out with the documented
orientation. v4 will add this write to chip_init().

If you have other measurements you'd like to see before v4, happy to
run them.

>
>>   - Runtime PM with a 2 s autosuspend delay
>>   - System suspend/resume delegated to the runtime callbacks

Best regards,
Hardik

