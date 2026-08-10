Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCA8361DA6
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 06:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786342687; cv=none; b=MUyQxzWLrahuXHGE2fEsONEnJXuNPsmQyK2LPNU9sL8bYMaQTjpXwP8iGDplFHR+ETjICGYczAOsrZSiKFAy7Qq/DMG14zRq0GQYvg3Pn7ZP2YmLAc072MIzpKsIThXPAl9LKZt8Pv5+P00l1S7yCu4yeVjI0tAg0J/i13OO5gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786342687; c=relaxed/simple;
	bh=9osL+0Lzlaq4MwslUDkJwqbqFxdV/Wle54/5Is8Kxcc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r9PUjNVoafN0xMB2ZbC9xRd+at+Ix6s9iveAu6z2Zgv1tBXifQn3IR1lqcz/DvzX+DVZLfYM5Roi0Fypst15s4CZCgPXF5b1GiJnt2XzG1SFfXjlOXS1kIuJaWQMzZAgg6lwX8N8pzo46cDxPstJ6HJ0u5XYzlNvbSIcWEshhUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Vjxmbo/5; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Vjxmbo/5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786342683; x=1786601883;
	bh=bXWUSqPfLAGfXFCfH+iuWSsT1t2MsXegK58zMWhTIKs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Vjxmbo/5Fxim+1/638GC6xD/3mzpmt1SnSBw7oTm0Sj6AmAqQHCdRo+dG/JwEqtrW
	 zHuFudmx/y7fpgD9+O/4y2aLd54BBzJx5y5DpAEjNH9cQX+gc2eZ1gTy/J74AEpx1q
	 9pqCpegjsgPjKGWqIf9WRFCzro2KDqyxdbhs5ficwytvvfHSRKdIudnB+pdCk9xCnI
	 Nki/KbhfNs6cV65xmL5k49CQYyen6D5g4pJKKkpZOpOOfa4lzC8xnayYRiQ7mNyhhk
	 t7L6xixGofpZmy4INFZA7a9Sbye+ZnL6SQDkifnqDDnQQA4uvYVcWUGqGPFnnTmsEh
	 Xre+FdPMPPgyg==
X-Pm-Submission-Id: 4hJPgr1cs6z2ScqZ
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
In-Reply-To: <anePOQh3F2cWds1o@ashevche-desk.local> (Andy Shevchenko's message
	of "Sat, 08 Aug 2026 23:19:05 +0300")
References: <20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com>
	<20260804-liteon-ltr329-v3-5-c6b768c7c745@geanix.com>
	<GosXsaKWx6E9mVl9UgD6Bm-yOPFZHzktTL8zxE7yEucs3KmgSRhnP5q1undPbc8-rr0hYUCiTQBFM36MfhR8sQ==@protonmail.internalid>
	<anT-9vI9jD8V0Q0_@ashevche-desk.local> <87ik5mxt7c.fsf@geanix.com>
	<2EAbkFcJCd5EAeN7hLIi_m9hxYKm2mptWKfatiYy5DLWypCXg9HTLvUD1z4HeAs3yj7KB5E10XWYePEkGaE8OQ==@protonmail.internalid>
	<anePOQh3F2cWds1o@ashevche-desk.local>
Date: Mon, 10 Aug 2026 08:17:59 +0200
Message-ID: <875x1ixzvs.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Andy Shevchenko" <andriy.shevchenko@intel.com> writes:

> On Fri, Aug 07, 2026 at 09:53:11AM +0200, Esben Haabendal wrote:
>> "Andy Shevchenko" <andriy.shevchenko@intel.com> writes:
>> > On Tue, Aug 04, 2026 at 07:02:16PM +0200, Esben Haabendal wrote:
>
> ...
>
>> >>  	if (client->irq > 0) {
>> >> +		if (!ltr501_has_irq_support(data->chip_info)) {
>> >> +			dev_err(&client->dev, "chip does not support irq\n");
>> >> +			ret = -EINVAL;
>> >
>> > Can this be
>> >
>> > 			ret = dev_err_probe(-EINVAL);
>>
>> Sure can, if that is the preferred style. But it will probably still be
>> two lines due to line width considerations.
>
> Even older kernels' checkpatch won't complain on that long line (as ending by
> a sting literal). But it's up to you.
>
>> And personally, as it would not take advantage of the -EPROBE_DEFER
>> logic of dev_err_probe(), I find the dev_err() style more clear.
>
> The point is to use the unified template for the probe error messages (that's
> why you may find a patch against dev_err_probe() documentation that allows this
> kind of use).

Ah, I missed that comment. Thanks.

I will update the patch.

>> >> +			goto powerdown_on_error;
>> >> +		}

/Esben
