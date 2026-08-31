Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D88471D17
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191003; cv=none; b=qL6N1wx5qzCLNELcg7rayzYbiN1SX5ElBbzfL81WUBEB9zRgEa3Cv+pmzFo4yoRO6h6uMkcCq7FsmIwW1IhkQntNEQpafZU7G/Mnae8Q8DNs5OR/AGeZkQFKAz/QPuN/NlqRQi+Vkm/fOYHJGKL+E6s57E0auVC5A2ryydHAsek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191003; c=relaxed/simple;
	bh=4R02XWZQwQ6u8w6v21gxafSyuzg5q5a+jqxk6zqYGQs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f2tKuWcxRrGXe4QzyTuQWoCH0vwgw5GiLCkiNLKjKH3mIwCGP9sJ/812RqrxNQrRp9KO4vahbaTbxDKGek7GX1ca20Zl+usmxgu5JWUKPvOzCqWage8fRzizWtAEiLhCnFpcw9CEJGd0+QT0rgpLfB65I0k8FrbSntB/+2WKK2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ad7QNECN; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ad7QNECN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788190989; x=1788450189;
	bh=gG1Jee+rqBZyPP8h6yxwduaDcelmPRtHceq5Rf5Lz64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ad7QNECNEIJXZSTLvPX4Cd4P9c1KPRhQC5GklGYbaZf3Gk+LoQm47pRXiOuscFnCO
	 fSfbHYs5W1TimCIxjJ6tPr470txW0gzMJUvdibUDAh6LAM1s3ht5jKMrbjKe/Dn1cB
	 l8glK45f6cGMMVJufgc4ENYkkg/rQQNzedMc9FhAhPKqNFcba2+WgNcKS4fiA05t0z
	 VoxKeNUzPexXTz6vMaevbRJA4vyE8uk9OdjoPonX2fEagqe30Eid31u1D3tyVrG4Y+
	 /m0yITUqjaJYBBY/sPGoc74ww+U8DwfIkUt8hjkkuiq8Qi5w/rqb/BzX2XjnCkTgue
	 ++N3r5F/ZiNTg==
X-Pm-Submission-Id: 4hYYDC0LLKz2ScWg
From: Esben Haabendal <esben@geanix.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>,  "Lars-Peter Clausen"
 <lars@metafoo.de>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Martin Kepplinger" <martink@posteo.de>,  "Sean Nyekjaer"
 <sean@geanix.com>,  "David Lechner" <dlechner@baylibre.com>,  Nuno
 =?utf-8?Q?S=C3=A1?=
 <nuno.sa@analog.com>,  "Andy Shevchenko" <andy@kernel.org>,  "Martin
 Kepplinger" <martin.kepplinger@theobroma-systems.com>,  "Christoph
 Muellner" <christoph.muellner@theobroma-systems.com>,
  <linux-iio@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 4/8] iio: accel: mma8452: Support interrupt sharing
In-Reply-To: <apWIJfGoQLtDV4IB@ashevche-desk.local> (Andy Shevchenko's message
	of "Mon, 31 Aug 2026 16:56:53 +0300")
References: <20260831-mma8452-open-drain-v7-0-22946812c928@geanix.com>
	<20260831-mma8452-open-drain-v7-4-22946812c928@geanix.com>
	<Ncm871ICTmFO0dGlJCPws8DbZwRNawMZGh74FyRieKxOU9C35zNksyV7FWkx97CU50ky9hYms5spg6SF8rATTQ==@protonmail.internalid>
	<apWIJfGoQLtDV4IB@ashevche-desk.local>
Date: Mon, 31 Aug 2026 17:43:06 +0200
Message-ID: <87ik4quwhh.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Andy Shevchenko" <andriy.shevchenko@intel.com> writes:

> On Mon, Aug 31, 2026 at 02:17:07PM +0200, Esben Haabendal wrote:
>> Adding handling of rutnime PM suspension in the interrupt handler allows
>> sharing interrupt with other devices.
>>
>> Keep in mind that the device by default is using push-pull for the irq pin,
>> which might require additional hardware design to allow interrupt sharing.
>>
>> The suspended flag is added together with synchronize_irq() in order to
>> protect against race conditions when doing runtime suspend and device
>> removal. This way we ensure that interrupt handler does not try to access
>> the device while regulators are disabled.
>
> ...
>
>> static int mma8452_runtime_resume(struct device *dev)
>
>>  		return ret;
>>  	}
>>
>> +	WRITE_ONCE(data->suspended, false);
>> +
>>  	ret = mma8452_active(data);
>>  	if (ret < 0)
>>  		goto runtime_resume_failed;
>
>>  	return 0;
>>
>>  runtime_resume_failed:
>> +	WRITE_ONCE(data->suspended, true);
>>  	regulator_disable(data->vddio_reg);
>>  	regulator_disable(data->vdd_reg);
>
> But with this, what's the point in having WRITE_ONCE()? It can be read
> just in the middle as true and be immediately changed afterwards. It
> may be that I am missing something, but I think WRITE_ONCE() should be
> done once in this function.

Yes, there does look like there is still a race condition after adding
this data->suspended flag. An irq handler could just have read
data->suspended, gotten false, and thereafter proceeeded with handling
the irq, and then we write data->suspended=true and the irq handler
would just continue with accessing the device, even though we are now
(if possible) powering down the device.

I did go through all the pre-existing runtime pm and other race
condition issues raised by sashiko-bot during this review, and worked
through it all. The result is a quite a bit larger than what I would
like to add on top of this series. Among other things, it converts the
driver to use regmap for accessing the i2c registers, and after various
fixes the data->suspended flag is removed again.

So I am a bit hesitant to pull all those changes into this series, the
combined series would blow up quite a bit. But if required, I guess I
can do that, although I fear that it will not make reviewing easier to
mix things more than maybe needed.

Could we find a way to merge this series first in some way, or should I
post a new version with all the other fixes added on top?

/Esben
