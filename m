Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8D93FAE15
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786967812; cv=none; b=K6Sjywjs/dKWpLF/xKjbL8mnXDblfI/nAJ+lmrfeKc5HgM+BRxZyIlTITsjd2aLKbqDDIwAX06GuB3Ugho3aoaUf7GSc9DBO2Aoo69i42186/BpZrBi62GsM4MhaR8yxuo9urd/SGdl0RzUQZF4AUvPGLjbb21Y0PbQLPuWsI3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786967812; c=relaxed/simple;
	bh=AcNiNXsubNzSKo85gtLhu9qj/AfKl1uJKor+uNkkrYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HwdZW8WApQNp3rwQtKMb+uj6RCShrlWKJe8ckh5atXp+ucSUod+kdRNZVZVN32d7JT4laFhNSJVgk2SI+mVAuMkK0r/vMnOtw3LdhWzDUDDFm4kWlCVTogQ7fgWo6HUyY8z1LuY7B7fiHjZ240xhnKQVY6LUY/3VCpo0YxbVFZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=zriADBfv; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="zriADBfv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786967801; x=1787227001;
	bh=sez7qMxcIbxM4COhVhdmF4Rm74MzzENRelO/rZukLD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=zriADBfvzxarerE0m4Oialv9s6n6ZdRWf632sbzNeZAnjuNrankF6WLPGeOmEQyr7
	 Mbfa7TWZuOMwakb49kJb2P9sNSjRWwHouCv28iLtwEXXdsCAw9I4JdVqHNOmT8sKlI
	 anOKuvH9AnVdJF1e9z6OXQjydMRGeohvyFAne2rguKecdl9kCuw3mbIItZjJThw+qW
	 2G3YGi5zej7xMQ57XjpQRj3Cke1yfNUsMdtcteOUCqSzSY9mOHFjnd3xPclYhSIwCg
	 dbMDU2I8W+XiH/kJVwldwpikh8Zqi904a+NdjFKKX6qJ/XiGjNPVFJq0++/I1j2hb9
	 qsg9/GoR9qHNA==
X-Pm-Submission-Id: 4hNrsK4yqsz2Scpc
From: Esben Haabendal <esben@geanix.com>
To: "Rob Herring" <robh@kernel.org>
Cc: "Jonathan Cameron" <jic23@kernel.org>,  "David Lechner"
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
In-Reply-To: <20260814175624.GE1981719-robh@kernel.org> (Rob Herring's message
	of "Fri, 14 Aug 2026 12:56:24 -0500")
References: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
	<20260810-liteon-ltr329-v4-3-8bd3dfd15280@geanix.com>
	<20260810155006.GA1815611-robh@kernel.org>
	<tpb0KaOIsxWHbx0VIdiP5udap2Qu9DAIOdN6iBaAbpWnGqMfGOgZwRQQlJOddirF99RdD6n1FVMxlSKmrRJW8lLo7pqKKAXwN9MUBT9DKAU=@geanix.com>
	<QUE-JPGrq7MhaAd4sJGgPBg2A9sOb03Dppyx8WseioI4Mt8uSiBVg3KQZUFfrlDG53DPOQl_VLz7opiWO6rFPA==@protonmail.internalid>
	<20260814175624.GE1981719-robh@kernel.org>
Date: Mon, 17 Aug 2026 13:56:36 +0200
Message-ID: <87bjb1kljf.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Rob Herring" <robh@kernel.org> writes:

> On Fri, Aug 14, 2026 at 06:18:55AM +0000, Esben Haabendal wrote:
>> On Monday, August 10th, 2026 at 17:50, Rob Herring <robh@kernel.org> wrote:
>>
>> > On Mon, Aug 10, 2026 at 09:11:13AM +0200, Esben Haabendal wrote:
>> > > LTR-329ALS-01 is an ambient light sensor similar to LTR-303ALS-01, but
>> > > without interrupt support.
>> > >
>> > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> > > Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> > > Signed-off-by: Esben Haabendal <esben@geanix.com>
>> > > ---
>> > >  Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
>> > >  1 file changed, 1 insertion(+)
>> >
>> > sashiko issue should be addressed.
>>
>> What about the suggestion about adding `proximity-near-level: false` to the condition. I am thinking something like this is more correct
>>
>> properties:
>>   proximity-near-level: false
>>
>> allOf:
>>   - if:
>>       properties:
>>         compatible:
>>           contains:
>>             enum:
>>               - liteon,ltr501
>>               - liteon,ltr559
>>     then:
>>       properties:
>>         proximity-near-level: true
>
> That does not work. The if/then can only add restrictions, not relax
> them. It can do allowed->not-allowed, but not vice-versa as you have.

Ok, I will do it the other way around then.

/Esben
