Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00B244AB6B;
	Wed, 12 Aug 2026 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541054; cv=none; b=PWPawOWTk+Jvhy+uNqs0t22V/exAeOxthrtQ8yIDR73xE2IETdqrNJKKD0+ncFw0+gaL5Wb9l+BQyKkxaa4Pv3awn/Z+jK3NIxDy57kpymaOBvYip3M9xF/+y/ZTKVNQlJ1fLvKptbMnTJldaQ5ydWfTnVW4RkatNJJp5LcEpNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541054; c=relaxed/simple;
	bh=6frKGGNfyAD3lmWfAXmuA4VsOsvrfq5Luxz3FyGL0oU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H28kIUtFSV/iRrR0oCtbjGwMvUmsos6hZEKXyrcJZMXXHVpsxLNa0Kw1mpynUa7FwgoGONXd5qzGbeZ+xeVDw1YVHnhYEfP8T1h5bfzhNWj9t6i2iQ9GEvsZKUbYTVOUGyS1ZrORJVyIIuPVf3f5sVWoYK7DU1s/tbbK6WOo2c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=b8OIUvhr; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="b8OIUvhr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786541039; x=1786800239;
	bh=GLgpn1lIikK+O2Pf/PKbUZup881T01Sd9U6XRa+j6fc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=b8OIUvhr8PV8Ujx9/RZgMR+NkD31/hp7nq4wEpecKp86lZUwNuBI5IOkJExKWrptb
	 fNO3GhAB696X9ZSB+jU4T1h4vPFJ8UMG7XGTuITJZjmBQR87klTTqRquJpj0IgvNUh
	 nMXE2yOnbsKQvyKIQuIOl9asjTDocs+tA/rXmBnRxn5C6DiGqDPAOc0sUord2vc7a9
	 EXv3rktY9w7uQ3CbquwnGpxkRe1YkkdMasj2sTtHZXdFrz1cbvTztceHh1NLBsneq8
	 Fn/OJ1ePuh3v+1Z+WEXzjhNs3dZ6mJ584obB343koyHBRme7Wz9sP04ZLyqZNCMVme
	 L8TCn5FXTblLA==
X-Pm-Submission-Id: 4hKq2N1q4Fz1DFFM
From: Esben Haabendal <esben@geanix.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>,  "Lars-Peter Clausen"
 <lars@metafoo.de>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Martin Kepplinger" <martink@posteo.de>,  "Sean Nyekjaer"
 <sean@geanix.com>,  "David Lechner" <dlechner@baylibre.com>,  Nuno
 =?utf-8?Q?S=C3=A1?=
 <nuno.sa@analog.com>,  "Andy Shevchenko" <andy@kernel.org>,  "Martin
 Kepplinger" <martin.kepplinger@theobroma-systems.com>,
  <linux-iio@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] iio: accel: mma8452: Only apply trigger type
 when not set by firmware
In-Reply-To: <anorldy1yxtBMygX@ashevche-desk.local> (Andy Shevchenko's message
	of "Mon, 10 Aug 2026 22:50:45 +0300")
References: <20260805-mma8452-open-drain-v3-0-6149f406a409@geanix.com>
	<20260805-mma8452-open-drain-v3-3-6149f406a409@geanix.com>
	<aPqJA0Caam5vMQjSIsmhw4DMbvohMtv2X58YnuaEYfa2EI9mSbcZrlBipJaq10v1WsnTzrEWi8DDPN2IeQ-iAA==@protonmail.internalid>
	<anorldy1yxtBMygX@ashevche-desk.local>
Date: Wed, 12 Aug 2026 15:23:55 +0200
Message-ID: <87se4jwjys.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Andy Shevchenko" <andriy.shevchenko@intel.com> writes:

> On Wed, Aug 05, 2026 at 09:21:37AM +0200, Esben Haabendal wrote:
>> Instead of unconditionally overriding the trigger type, it is better to
>> only apply a default when no trigger type is set by firmware. This should
>> be reasonably backward compatible, and should only potentially cause
>> problems if systems exist where firmware specifies an incorrect trigger
>> type. With a bit of luck, there are no such systems.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> ...
>
>>  	if (client->irq) {
>> +		unsigned long irq_flags;
>> +
>> +		irq_flags = irq_get_trigger_type(client->irq);
>> +		if (irq_flags == IRQ_TYPE_NONE)
>> +			irq_flags = IRQF_TRIGGER_LOW;
>
> I would even add info message or so that FW lacks of the proper IRQ type.
> But it's up to you, most of the code that I saw and does something similar
> does not print anything in this case.

I agree. That seems like a nice improvement. I will add that for v4.

>> +		irq_flags |= IRQF_ONESHOT;
>>  		ret = request_threaded_irq(client->irq, NULL, mma8452_interrupt,
>> -					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>> -					   client->name, indio_dev);
>> +					   irq_flags, client->name, indio_dev);

/Esben
