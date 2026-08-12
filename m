Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9571743BDC1;
	Wed, 12 Aug 2026 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539124; cv=none; b=bA5pZagLAjE7M3nXtChquteUt5lNxwMl0loAbZVtkTC1O8/2K883glgseMf7sGAe7I5wj5CC5XKmeD3gCpETl1Ie+FDDb4OOpyVOveSo59rQY9TrssvpOo84+lh1HB5eKIP/BBurdhC7UJ42oZG/iXBzOyqhmE3rz+Ri2zE1siQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539124; c=relaxed/simple;
	bh=GOd+T5kcO67epWictF5/E6o242qexc+4aoNyG7lkKDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WOsf8q8f2FI1M2mu+gtUmel6wmq1uIqmwrmqtN1zDAlCypMkWEPWJ4c/yh+SnXVa8tEiYquVZVmRHABD6ZWDvLqqxGgwr6tA+JCOF7bj3ndUR9pecMwzRZTWOmmn4u5Ai5sF64wvYRoJMvKzKQzEVqT5UjxM5evLNIWLQL9Knx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=meKc2caL; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="meKc2caL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786539111; x=1786798311;
	bh=kxtLFCykVROU/YI4bg47bV1oa/SHit+gxofRMN/KoBk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=meKc2caLhbR1aHbk3NF3VsqKCD37Ba+y2b0Q19TO0zLqA96N9rrsPdOpoTCZYSqNr
	 +AIoh/dgF15czLkh95McCSzjhBLYBfSLHVpYKZUby4cB1KNdesA0yTPW/CIc/m6BZt
	 69X7K4J2RXf+AOHNXIYKjV42+qZStY9mZO7lHZHLUaFy6vYmGH7TaAzmyAR3uMefdf
	 X3hOpwgltW4UhTABGmpDCsLT6ih+3KA2X9jXRg6ArlZWeEjTC219s7Z3swIZfIa6Q3
	 jG3YkrZBTHxO4L1h/EZAqEUYqFzm8Qa0LZlTmXWYLyaIdIusXPC+6dTXdetRLke2ul
	 +Uavun6E+ZAFQ==
X-Pm-Submission-Id: 4hKpKK0cspz1DFFG
From: Esben Haabendal <esben@geanix.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>,  "David Lechner"
 <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
  "Andy Shevchenko"
 <andy@kernel.org>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Nikita Travkin" <nikita@trvn.ru>,  "Maslov Dmitry"
 <maslovdmitry@seeed.cc>,  "Kuppuswamy Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,  "Thomas Gleixner"
 <tglx@kernel.org>,  "Pan Chuang" <panchuang@vivo.com>,  "Yangtao Li"
 <frank.li@vivo.com>,  <linux-iio@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 6/7] iio: light: ltr501: Add ltr329 driver support
In-Reply-To: <anotEG6n8AXLXcTg@ashevche-desk.local> (Andy Shevchenko's message
	of "Mon, 10 Aug 2026 22:57:04 +0300")
References: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
	<20260810-liteon-ltr329-v4-6-8bd3dfd15280@geanix.com>
	<VuI3nJTNsCtv6BTTN1ifPljPH5UMvSlPe0caa7nGtOVoojV02_uGuvFBs1HXneueB61q_c3Nml5ixt2rvkU9mg==@protonmail.internalid>
	<anotEG6n8AXLXcTg@ashevche-desk.local>
Date: Wed, 12 Aug 2026 14:51:48 +0200
Message-ID: <87wltvwlgb.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Andy Shevchenko" <andriy.shevchenko@intel.com> writes:

> On Mon, Aug 10, 2026 at 09:11:16AM +0200, Esben Haabendal wrote:
>> This adds support for the LTR-329ALS-01 chip, which is similar to
>> LTR-303ALS-01, except for interrupt, which LTR-329ALS-01 chip does not
>> have.
>
> ...
>
>> static int ltr501_probe(struct i2c_client *client)
>
>>  	if (client->irq > 0) {
>> +		if (!ltr501_has_irq_support(data->chip_info)) {
>> +			ret = dev_err_probe(&client->dev, -EINVAL,
>> +					    "chip does not support irq\n");
>> +			goto powerdown_on_error;
>> +		}
>
> Why making it fatal?

Good point. Probably a bit too harsh. A warning should be fine.

And with the addition of dt schema validation of this, on the odd chance
that people validates their devicetree, they will be told about this
problem already there.

> Perhaps
>
> 	if (!ltr501_has_irq_support(data->chip_info) && client->irq > 0) {
> 		client->irq = 0;
> 		dev_warn(chip doesn't support IRQ);
> 	}

Added for v5.

/Esben
