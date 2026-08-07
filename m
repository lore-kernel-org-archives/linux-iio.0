Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCD3469850
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 07:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786089220; cv=none; b=TKzfiLrmixCrYR3ErOcFXoq/j1Dtf3JGC6PqBm1fVXvSXf/smNkWl3U/h5yPsssTsVxavJQdTs4kbCnUHAdfPurIHeZd7Cf6a8StDhx/vF/cqv0TD0mYxzna0iSgDInqnvJCCS7WHGkujU7CXszSSXo/7G+2FCCQxOlciyabrsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786089220; c=relaxed/simple;
	bh=QLP/i4NRRMnx80Z/b7Z4XlZVAbVGaYzmvDz7f2/8Rxk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X5O/5MrD6hjgiUhOxq5eve+WoJ1wHOtDNLhwUx/gfZEyrL0zBytIzThUezNDvkgMelFLPnDEb+guBgg6DwPgsa+vbW6sD/JTGPhu9bRoBJNHzyPHUFbjM9ix+mBCGNsntx4dEi7XdhkFjY+0AxKopaOzYWcYvIE3S38bWD8TsI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=CFp45qV7; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="CFp45qV7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1786089194; x=1786348394;
	bh=utG1OblDnBhYPxHr5DHQ0s7aMRcaT6XmCcSoPGXZogg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=CFp45qV7J82guxbviH8PZmAU39WQjx3DG1Xd6Z7mbaabdONa4U83fgeCeXXv8k8KG
	 tDvO8PtMzdQW77qFWu7XJLW+wp2Srpo/qemZgtkAb1MsVAeI1BHWwjnVKTdmaxUeRj
	 v1pT+mIH7s5aL8Bo43KJ/+l65NjbTNczivE8/AFasZZIJdBZWNW+uQwL8pgofn90du
	 8ED8f7x9u0VVjk4Fmy4hy+8aAll9HhhBMggnVGV3t8lqiSn4uB0UXXtGYFJXTUrIRX
	 G5cxwvZTcBmOLJe6MPe7jcvz/sxD4ieAPxwaN8j/KKN22ObG83WZ0QN9/5ZIh85G07
	 xs2AyZLaTvLGw==
X-Pm-Submission-Id: 4hGbx40NMQz2Scpf
From: Esben Haabendal <esben@geanix.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>,  "David Lechner"
 <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
  "Andy Shevchenko"
 <andy@kernel.org>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Nikita Travkin" <nikita@trvn.ru>,  "Maslov Dmitry"
 <maslovdmitry@seeed.cc>,  "Kuppuswamy Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,
  <linux-iio@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/6] iio: light: ltr501: Add ltr329 driver support
In-Reply-To: <anT-9vI9jD8V0Q0_@ashevche-desk.local> (Andy Shevchenko's message
	of "Fri, 07 Aug 2026 00:39:02 +0300")
References: <20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com>
	<20260804-liteon-ltr329-v3-5-c6b768c7c745@geanix.com>
	<GosXsaKWx6E9mVl9UgD6Bm-yOPFZHzktTL8zxE7yEucs3KmgSRhnP5q1undPbc8-rr0hYUCiTQBFM36MfhR8sQ==@protonmail.internalid>
	<anT-9vI9jD8V0Q0_@ashevche-desk.local>
Date: Fri, 07 Aug 2026 09:53:11 +0200
Message-ID: <87ik5mxt7c.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Andy Shevchenko" <andriy.shevchenko@intel.com> writes:

> On Tue, Aug 04, 2026 at 07:02:16PM +0200, Esben Haabendal wrote:
>> This adds support for the LTR-329ALS-01 chip, which is similar to
>> LTR-303ALS-01, except for interrupt, which LTR-329ALS-01 chip does not
>> have.
>
> ...
>
>>  	if (client->irq > 0) {
>> +		if (!ltr501_has_irq_support(data->chip_info)) {
>> +			dev_err(&client->dev, "chip does not support irq\n");
>> +			ret = -EINVAL;
>
> Can this be
>
> 			ret = dev_err_probe(-EINVAL);

Sure can, if that is the preferred style. But it will probably still be
two lines due to line width considerations.

And personally, as it would not take advantage of the -EPROBE_DEFER
logic of dev_err_probe(), I find the dev_err() style more clear.

>> +			goto powerdown_on_error;
>> +		}

/Esben
