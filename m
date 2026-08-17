Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198EA3FD12A
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786967864; cv=none; b=ey5haYs/nJLTqCwnhEjSpBVq8nvynrMgCYeNZVBIAwmGFoigKzYvUjXvmEj1HweqVbkVc8hCBrTFtXJyh7HSg6I+L4XKZulZBIJGNZRcX8SNSvuryymT945M4h8ju/OvlYOGvK49APOCP5XYB3NGod0EgFvdTQ/He8QE7En/HZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786967864; c=relaxed/simple;
	bh=Ek6p3nHWJzIWB6mcb067TcsBbgSfwEaFoEFVAre8DAs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=phPtOfOx+DGple/ydvl6dLFU8fiRw0s6chBPkfFHMFNDyzlyabo4oQIRkyAZLDpP/532EbLw0tGCj69Jf1hxZFFhIrhovkRlryW6gf2azAIlt80XB0xMvwhQK/rceg63j33zMFy5HjodXjv25pnQPII4oC+qcqI6gnmGbojro6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=mTE+a6Ii; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="mTE+a6Ii"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786967859; x=1787227059;
	bh=ODya+Y+AGK2+nAfOrXSVae8nPCcCmn2ucJxG3HkcA68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=mTE+a6IidtwEC7t5kjO6FwyuG24OrTAUr+++kxjAo79vK8asHzLK6kxE/OxU5w1Vc
	 AFaJmrKTOEEmTUMgwQB3+wJbBFmnZm8xvYkgRlWqnimTxmfed0gPAGgG2cck2vYHLH
	 ykmYjJupPeTbwRsFtwASmuy56mvmJ/pV1zCyufYo88WAzKGkCsHtsnGeRsLeyWy7Nl
	 ASeOUHQIrs8fln7RF9xYoW3cvQ8/ylTqJXkY0sdIvbG7UNiHkW7EH0PO9wDG77eg7Z
	 3/jwjywfL2c5rNuRmzp6QUcrDyihXs27gk1eaT0Z5V7UKstADX/wLs/T1HzWyVQMwx
	 a64SN9EscaZHA==
X-Pm-Submission-Id: 4hNrtQ6WpRz1DDLk
From: Esben Haabendal <esben@geanix.com>
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: "Rob Herring" <robh@kernel.org>,  "David Lechner"
 <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
  "Andy Shevchenko"
 <andy@kernel.org>,  "Krzysztof Kozlowski" <krzk+dt@kernel.org>,  "Conor
 Dooley" <conor+dt@kernel.org>,  "Nikita Travkin" <nikita@trvn.ru>,
  "Maslov Dmitry" <maslovdmitry@seeed.cc>,  "Kuppuswamy Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,  "Thomas Gleixner"
 <tglx@kernel.org>,  "Pan Chuang" <panchuang@vivo.com>,  "Yangtao Li"
 <frank.li@vivo.com>,  <linux-iio@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v4 3/7] dt-bindings: iio: light: ltr501: Add ltr329
 compatible
In-Reply-To: <20260815043403.07f9cc58@jic23-huawei> (Jonathan Cameron's
	message of "Sat, 15 Aug 2026 04:34:03 +0100")
References: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
	<20260810-liteon-ltr329-v4-3-8bd3dfd15280@geanix.com>
	<20260810155006.GA1815611-robh@kernel.org>
	<tpb0KaOIsxWHbx0VIdiP5udap2Qu9DAIOdN6iBaAbpWnGqMfGOgZwRQQlJOddirF99RdD6n1FVMxlSKmrRJW8lLo7pqKKAXwN9MUBT9DKAU=@geanix.com>
	<XeCYlALgHXbzL0UzP7ZhcC4MRGGmwC0X9sYvmf87CaI3Ujj-CG9DObxsJlzi5t0QjFVTG3Xh9AdLudKIWOU53oaKaa1FJeyV4ECORK325Vw=@geanix.com>
	<ZJ3NpsW1RGazflGZ3h1vfWAmBGOte2XEZh1c1blNdzHMcjwNWCtV1vVwI2H4EehOgIrywz0qC5Wrf8wUgMyHoQ==@protonmail.internalid>
	<20260815043403.07f9cc58@jic23-huawei>
Date: Mon, 17 Aug 2026 13:57:34 +0200
Message-ID: <877blpklht.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jonathan Cameron" <jic23@kernel.org> writes:

> On Fri, 14 Aug 2026 12:39:45 +0000
> Esben Haabendal <esben@geanix.com> wrote:
>
>> On Friday, August 14th, 2026 at 08:18, Esben Haabendal <esben@geanix.com> wrote:
>>
>> > On Monday, August 10th, 2026 at 17:50, Rob Herring <robh@kernel.org> wrote:
>> >
>> > > On Mon, Aug 10, 2026 at 09:11:13AM +0200, Esben Haabendal wrote:
>> > > > LTR-329ALS-01 is an ambient light sensor similar to LTR-303ALS-01, but
>> > > > without interrupt support.
>> > > >
>> > > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> > > > Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> > > > Signed-off-by: Esben Haabendal <esben@geanix.com>
>> > > > ---
>> > > >  Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
>> > > >  1 file changed, 1 insertion(+)
>> > >
>> > > sashiko issue should be addressed.
>> >
>> > What about the suggestion about adding `proximity-near-level: false` to the condition. I am thinking something like this is more correct
>> >
>> > properties:
>> >   proximity-near-level: false
>> >
>> > allOf:
>> >   - if:
>> >       properties:
>> >         compatible:
>> >           contains:
>> >             enum:
>> >               - liteon,ltr501
>> >               - liteon,ltr559
>> >     then:
>> >       properties:
>> >         proximity-near-level: true
>> >
>> > As it is only valid for those two chips, and it seems more logical to do a white-list than the opposite.
>>
>> I hope it is okay to do this change in a follow-up series to this one, so we can get it merged sooner rather than later.
>
> Whilst this looks to be in a good state to merge, timing is such that
> it is next cycle material anyway at this point unfortunately.
> So if you don't mind tidying this up as part of your series, I'd
> definitely prefer that.

I will try to do that then.

I will be away in the next 7-8 days, so will not have a good way to
actually test any additional changes requested in that period.

/Esben
