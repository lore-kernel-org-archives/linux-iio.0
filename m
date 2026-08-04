Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF2C3DDB0A
	for <linux-iio@vger.kernel.org>; Tue,  4 Aug 2026 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853573; cv=none; b=nYo21pdYFIcIqKe7pt5BHYATreh3K0+UzG+8PyJGoTNSe/UMMJbFQOZrZYrSv6DURQILjYjes7x5ASDUxyCEEjj8PyGNObp0FqyioQsMTUmjgqqO53Hr1CBefF6qyD0B0Kjs4N0zyv1/8j6gjtKL4T+9u8+xtyWfg+1ZWhe+gSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853573; c=relaxed/simple;
	bh=67XLaFo/5/VoGNHxtmTccdA6ofDmzGdrHAJ1QHQ03kA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aLsnIZupZx2yG2YEpEeVgNjTH1jcZdoMVG63j9JfevcKNN2sk8kJrCIM3sQ/ZvkuMYWwa/5AoBmsFxFVAP2XxpbF0TWDpJR7NzqOzabLhllHp2Ze/KfZ1s0HoIVMlUBlq26I99sfT5KdXaTCx64p8i8qDX+q9TDDgGsSniGYauI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=UGzLkZBI; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="UGzLkZBI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785853553; x=1786112753;
	bh=Ba/RjtYsmvz37DHViL1O7QBRUqwko+fiAx2FOcnBgvw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=UGzLkZBIbVd9VQyWOPziZ9d7/foF6XckE/dH89jeIjRMAARPmYNp0IQBoZ93dzMLu
	 0DFRXsXVFfx8sSrqXhzjxFF3ws//yUCy0PsOOOikU4lqHab0knifHmUTc/Imf+6uX0
	 Wzc5HXgZO92xNL1fCA3i4xc1EeCLI9Mf8Lya1smOJw28IDjw8NQJ6tR38ZDsxLu1Jz
	 5ChqebTtepGzVBetECvfTTBF3NN/iUr2LaG6PaaNtCtQ18nTVfWJAXqjD1wWYPjg8E
	 fvoM04JEGy2kQAyFD7G3ZOcmdAz5c3HY2df3lRnZP3viFKvHUE8fm8GxxJhpPVr+Op
	 QWi6G46vTA+Nw==
X-Pm-Submission-Id: 4hDwnW3cMyz2Scpm
From: Esben Haabendal <esben@geanix.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: "Jonathan Cameron" <jic23@kernel.org>,  "David Lechner"
 <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
  "Andy Shevchenko"
 <andy@kernel.org>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Nikita Travkin" <nikita@trvn.ru>,  "Maslov Dmitry"
 <maslovdmitry@seeed.cc>,  <linux-iio@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: light: ltr501: Add missing
 ltr303 compatible
In-Reply-To: <dabf891b-8728-4fcf-987e-969ce623616b@kernel.org> (Krzysztof
	Kozlowski's message of "Thu, 16 Jul 2026 10:06:30 +0200")
References: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
	<20260715-liteon-ltr329-v2-1-d18af55edab5@geanix.com>
	<20260716-adaptable-thankful-serval-ecb3cd@quoll>
	<zy7szTf7RKcKwWr42yNSRjQXdyZGTq0xo-sJc64u12fs-40hP2VBxckGWy_OoWqsiH1oztnknlEyqgxRYiakIw==@protonmail.internalid>
	<dabf891b-8728-4fcf-987e-969ce623616b@kernel.org>
Date: Tue, 04 Aug 2026 16:25:50 +0200
Message-ID: <87pkzyaro1.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Krzysztof Kozlowski" <krzk@kernel.org> writes:

> On 16/07/2026 10:05, Krzysztof Kozlowski wrote:
>> On Wed, Jul 15, 2026 at 02:27:23PM +0200, Esben Haabendal wrote:
>>> When support for ltr303 was back in 2021, the bindings documentation was
>>> not updated accordingly.
>>>
>>> Fixes: 7d71d289e1ba ("iio: light: ltr501: Added ltr303 driver support")
>>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>>> ---
>>>  Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>
> Except that compatible goes before liteon,ltr501, not to the end of lists.

I will add a commit that fixes the order first. Looks a bit strange to
place this new entry before liteon,ltr301.

/Esben
