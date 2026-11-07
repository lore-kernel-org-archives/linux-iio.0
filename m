Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794016217;
	b=Ruz6jeYm4g1i7K4EEonJt3+VwX+aXeqAY1HY0h/XloX1VLb6C1KmiNqpHb63NLD2gE9K
	 efK9nlvyZYCzaRTRs6SrGo0+sbkSOEMufR73+gsRnSHL2Ou2Nho/ce3wzA9krTi7S+/YT
	 9g+AR6lbpG9Tq4aX/rfjBgrJyKTGZeV1NDmQpflHrGmKnBRJ8hQ6WShJ1oIrhX6CE7OjS
	 IDo8k51ycptAdWeqlPTodAQUpJK+9Mii/1u6ORqpsyz3zuqRkEIuzzk0XB7BuyCZyGSDq
	 dDvQoVgTATyNy8XZQSOB+yeSjiI9vVlH3ZcvhC5XIiew5ppSRIokI/l3Kv6t4LGDJKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794016217;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hXzdvCVDZggNoLvSvFNOZSOUcMJ5fjvLPQUHwBcmzCA=;
	b=k3g2WffBksfhTTHwF/YHUdEUIP0aMUUmomoM427j6QxtX8nFwCGWzceb6eu+YpySUbZR
	 xAF3rtFin1wNvpu/m/Nfmpe9YxPlhzyUICUHnoEqq61DlcJWXS2hbpeaWpeHJimqosBDu
	 rFbijNT4MpAuD6zVomXqeUKzkSAQkRsp8cNjMGMiDZsOSI6HeBzlZNBktt6u9twDxlKyW
	 NU/RKgab5GH/mJCfHTgBRovhRGEFGI50JaWJdcqNJc9XIPxi47frA4wQ5S0n0UIifIGrm
	 9bvR34hyBphmYErgbbccSg5UfLJoXIEqpFpaabOAr77viPHR7oaKZZb3EeXNpCYC70g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IUl+ANK5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97D0606A32C;
	Sat,  7 Nov 2026 01:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IUl+ANK5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173711F008A1;
	Sat,  7 Nov 2026 01:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794016216;
	bh=hXzdvCVDZggNoLvSvFNOZSOUcMJ5fjvLPQUHwBcmzCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IUl+ANK5ORhCcf1cNJj5A1x4oTICrxbsJoKQy6rtvC7Yr0UVmw51BqvvRKOEygDcD
	 mYShh7/FUgaur/Jgf3Tb3dq9wy1jXOyMsAZsIyhVanOETYmsBE0d0zuu8BN1UaTQcp
	 nmJToYqmqNbQdYAG+PntK1f/1MjOuaeuPy//s43YZHISKLJias4fb3DZqHAkadwG1e
	 n0FjEKBzUYJiDY0Fbm0ZHav0MV2jqvNZ3X4A7pmYley3f+ItAnRA+sZLb3Q/CTL7iw
	 xN4oyqzkhaNdC9hVGnxo+/Q5xFATCSVji0uagSsgCjWy7JN9DmCXBOiSMOtgfvHUlw
	 hPvvC/bhySXIA==
Date: Sat, 7 Nov 2026 01:50:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob
 Herring <robh@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>, "Trevor Gamblin"
 <tgamblin@baylibre.com>, Joshua Crofts <crofts@kernel.org>, "Sergiu
 Cuciurean" <sergiu.cuciurean@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/7] iio: adc: ad7625: fix sampling frequency
 handling
Message-ID: <20261107015008.45a94af6@jic23-hlaptop>
In-Reply-To: <20261106160529.876251-4-Nicolae-daniel.Deaconescu@analog.com>
References: <20261106160529.876251-1-Nicolae-daniel.Deaconescu@analog.com>
	<20261106160529.876251-4-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Nov 2026 18:05:15 +0200
Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com> wrote:

> Fix sampling frequency handling issues:
> 
> - Fix issue where writing 0 to sampling_frequency caused a division by
>   zero. Return -EINVAL.
> - Fix issue where a waveform rounded up by the PWM went unreported.
>   pwm_round_waveform_might_sleep() returns 1 in that case and
>   ad7625_set_sampling_freq() passed it on, so the sampling_frequency write
>   returned 1 and the new waveforms were dropped. Return -EINVAL.
> - Fix issue where probe() continued after failing to set the initial
>   sampling frequency. The dev_err_probe() result was not returned, leaving
>   the PWMs unconfigured. Return the error.
> 
> Fixes: b7ffd0fa65e9 ("iio: adc: ad7625: add driver")
> Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
These are all clearly bad.  Are they affecting known boards
out there?  I'm wondering whether to try and take this ahead
of the rest of the series. For now I'm assuming it can wait
as it makes our lives easier by not holding up the rest of the
series.

Jonathan

