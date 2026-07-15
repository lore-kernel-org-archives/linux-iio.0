Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEA73195FD
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123756; cv=none; b=lAGxHGk17FzruhbYkrIfzudRZ/hozjyyD886z9BZ2yKspWvVR2FDw5laWCJA4k+xBeenTlCGGwB6xoY/D1Wuqp+pk9fJqhSS1aGjPMOeDeV/fSy+cpNL0zcQKBUr2FdHfLGdFcv1AxDE3+Xxls4p0RJpl3dCNXXOgXYv75Frku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123756; c=relaxed/simple;
	bh=x1kF+h+M2Ehkve0RXxk9kbNstC2ODtPVH7Imo6k4qaU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V7TboY2xt2/W+XWC+fyQI5vwxQ51QerY5S9xds05xt2j47mVAuLYapR2vdvultnMCMF55+RmHq0V8YI+VGOJZTte2733rA68Fryg3xiygR6WoFut15W+9OQqlZ6mEIfFUlrVTXVf5+v+BP0II1pWBQtxzenz7sNTIQdmjMyJ/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=isRmLWZa; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="isRmLWZa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784123751; x=1784382951;
	bh=kqaSUgrmxHJLervNjojPX8XF1IMPj0/QDVmJ+8NJrco=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=isRmLWZaB8DXFHnmWTvQEN4YRkYCFFm90Cb7XxDf1mKyaiqr9cJ+Ebm8DiGYBdda+
	 Ae+xCRzOJ6biGwLJe2DrNNZqgVwalbs3yzVRfJYVvTuZDj/i1/re+rbNdID8kgQvOi
	 IpmfgOO81CUFwqo6ivil7dsnBv8XQFEuPodDzFYnFTThp6BB9ly6EJ8od0fJ9xTVxs
	 9pz7f5YKoAUJ6VQren8VBZHickB6lb2aCwM2mss6MGebhgbkOWfc59gRBymwjobN9f
	 tGqGIJo1ih8nuHNiEpVjxSIQ56/YmFIUSF+5RvhaMGCqIoPV3cjfiVwsVIkSwTEtva
	 6oe5HiaJiviyg==
X-Pm-Submission-Id: 4h0d4473fFz2ScX7
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
Subject: Re: [PATCH v2 3/4] iio: light: ltr501: Add ltr329 driver support
In-Reply-To: <20260715145324.000005c6@gmail.com> (Joshua Crofts's message of
	"Wed, 15 Jul 2026 14:53:24 +0200")
References: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
	<20260715-liteon-ltr329-v2-3-d18af55edab5@geanix.com>
	<tsVvSFcobT5NwJPHCbN4M8cwEznnquSJ6o4W-MpVcf7z5q_RwC6XI-NNBTwrQnEBed-Stn56TW1e4iSdtzN54Q==@protonmail.internalid>
	<20260715145324.000005c6@gmail.com>
Date: Wed, 15 Jul 2026 15:55:48 +0200
Message-ID: <878q7cmk63.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Joshua Crofts" <joshua.crofts1@gmail.com> writes:

> On Wed, 15 Jul 2026 14:27:25 +0200
> Esben Haabendal <esben@geanix.com> wrote:
>
>> This adds support for the LTR-329ALS-01 chip, which is similar to
>> LTR-303ALS-01, except for interrupt, which LTR-329ALS-01 chip does not
>> have.
>>
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>>  drivers/iio/light/ltr501.c | 33 +++++++++++++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>
>> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
>> index 7d045be78c6d..379e57ac5f5b 100644
>> --- a/drivers/iio/light/ltr501.c
>> +++ b/drivers/iio/light/ltr501.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/delay.h>
>>  #include <linux/regmap.h>
>>  #include <linux/regulator/consumer.h>
>> +#include <linux/array_size.h> // for ARRAY_SIZE
>
> Just a small nit, even though the list isn't exactly ordered, please
> try to add the new include approximately where it would be if ordered,
> i.e. array_size.h goes to the top. Additionally, you don't need to add
> a comment.

So alphabetically sorted? And even before linux/module.h?

Comment is going away...

> Everything else seems fine otherwise.

/Esben
