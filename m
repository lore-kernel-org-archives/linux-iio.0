Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C31B3644C5
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118327; cv=none; b=KtRYbGt+veONgrozMjq48s5Z8E+PFENILM5ujJh0cl7aSr4cKlIgdLVJuX4Rhoy60Db4ryO4Uqm2U5uURk6INiM298CCx8/EYWghgLxNu4Su15wZznxxMo2ZGGRAAo1gDnAw14BaxA5BP10aUa9HA5rhdBUO7osLaaF5qDBsC0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118327; c=relaxed/simple;
	bh=/1JCIT7JbkusWM8jBca7pwdiuxeWCU2zSoxU4rAoFeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bgyy5OIlBq6l0vInr9wPeaVvRNfB/n1XuvhRmg8NUfXD10BEOh3p46yc07IhfCgHuHNxIBWEjNB/8mRhU3tLjYeQsLEKaz3IIdXGZwcKZmYEeArA81jmdYHd6lSc6Ub2caiKHKCaohHmrzPAAjgt607gskKnHmwCtCgRTlk/U4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=BaxY1uPV; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="BaxY1uPV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784118323; x=1784377523;
	bh=N9BgjdLpyBUrjx79keV+lQLR9W0VyIb22/dfHemNCn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BaxY1uPVG4B3O//Vmhq4WJUS31jbCGjiB2xowPAPE8jTdUjEDA2rjDXW+NvRE7zt1
	 Jyg3BEry7xdLQxJGKBK7GLIzInjAY8MkSILHptselIGKh3Hja5dEbxCcxUkNRPTVCs
	 WYFybGpQSZUE3JcDZoI3Y9F4VGe4/+t3v9iDXZkJ6G8n/Q1TZKw19fclTqMx2WND25
	 efUasinx5bz03X64v+A2pPXgcUIPTRohmgeLy5uoNpRZOVeIG23mYsudzncYa5yIhC
	 2I1S2Amt+hFmiXmqfotQ/ve9E3A6MaPjqPP1HfZvrNjQU2cte/w28rEVpremTis4/k
	 UKKOQudykbIaA==
X-Pm-Submission-Id: 4h0b3h1GxDz2ScqH
From: Esben Haabendal <esben@geanix.com>
To: "Joshua Crofts" <joshua.crofts1@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>,  "David Lechner"
 <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
  "Andy Shevchenko"
 <andy@kernel.org>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Nikita Travkin" <nikita@trvn.ru>,  "Maslov Dmitry"
 <maslovdmitry@seeed.cc>,  <linux-iio@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: light: ltr501: Add ltr329 driver support
In-Reply-To: <20260715110046.00001aa8@gmail.com> (Joshua Crofts's message of
	"Wed, 15 Jul 2026 11:00:46 +0200")
References: <20260715-liteon-ltr329-v1-0-31f027051594@geanix.com>
	<20260715-liteon-ltr329-v1-3-31f027051594@geanix.com>
	<4cMgwAFPJkUt759lA15Qqqxi3-vUgf5w6GlGkVubDu_IElhPOsDlIBsxCMlbSiQzapJVNQKOzYN7kip6WIuP_Q==@protonmail.internalid>
	<20260715110046.00001aa8@gmail.com>
Date: Wed, 15 Jul 2026 14:25:19 +0200
Message-ID: <877bmwo2xc.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Joshua Crofts" <joshua.crofts1@gmail.com> writes:

> On Wed, 15 Jul 2026 10:23:50 +0200
> Esben Haabendal <esben@geanix.com> wrote:
>> @@ -1257,6 +1269,18 @@ static const struct ltr501_chip_info ltr501_chip_info_tbl[] = {
>>  		.channels = ltr301_channels,
>>  		.no_channels = ARRAY_SIZE(ltr301_channels),
>>  	},
>> +	[ltr329] = {
>> +		.partid = 0x0A,
>> +		.als_gain = ltr559_als_gain_tbl,
>> +		.als_gain_tbl_size = ARRAY_SIZE(ltr559_als_gain_tbl),
>
> While you're at it, add `#include <linux/array_size.h>`

Will do.

>> +		.als_mode_active = BIT(0),
>> +		.als_gain_mask = BIT(2) | BIT(3) | BIT(4),
>> +		.als_gain_shift = 2,
>> +		.info = &ltr301_info_no_irq,
>> +		.info_no_irq = &ltr301_info_no_irq,
>> +		.channels = ltr301_channels,
>> +		.no_channels = ARRAY_SIZE(ltr301_channels),
>> +	},
>>  };
>>
>>  static int ltr501_write_contr(struct ltr501_data *data, u8 als_val, u8 ps_val)
>> @@ -1531,6 +1555,11 @@ static int ltr501_probe(struct i2c_client *client)
>>  		return ret;
>>
>>  	if (client->irq > 0) {
>> +		if (!ltr501_has_irq_support(data->chip_info)) {
>> +			dev_err(&client->dev, "chip does not support irq\n");
>> +			return -EINVAL;
>
> Shouldn't this jump to the powerdown_on_error label instead of returning?

Yes.

And I will add a similar change for the devm_request_threaded_irq()
error handling where I think we should do that as well.

/Esben
