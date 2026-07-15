Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E2F335067;
	Wed, 15 Jul 2026 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123614; cv=none; b=BTjiQniVNPiEtlD+SiFOC7t9vuA4Ki3yR0XzSigTpN2qPHU2wIHYCrDq0kIIyHYSIRjIufgoYGWTpFYh+uMCx3W3Xxq4WDSxEZUr5kBc0juJv0S7JHe0KdHf/QGrZ+3CqoNWG9MEFD+fXwSh6D7fSwRbPrBfPaiZJWaRLSr3TYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123614; c=relaxed/simple;
	bh=Qq/dzFMFE2FEfrNHkPUWZfteiUt8pZSXepAUZe21VFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yimi6oxEjE6yKSOdaBemz7Tl5d7x4gq1NaLgdmGPZZbJ7WoJKWwb8cLCLiAvFrJClkVoj0B8nCjf2qLVSqSjBMcynhxEiaKESbEUEIWfx046gH8xGJRG9Pd6B/a45YRVrMH67SZqCsJiCIo/rvUZuej1O1B2BeOQGhuYHVSDwTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=dLesiPSm; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="dLesiPSm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784123608; x=1784382808;
	bh=ItzpmHqYLBu/dDqjAXr+pTfP3C0U/ZyTE8V/7zIjs1A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=dLesiPSmlO5PhlvZ5d8MxX9CR6AGIXJHEXbv6zTnnSsmAfqL+0zMsa4H3VALrYG5+
	 mM07gY6tkQY47zJAo4aAhARDxjBcMvF1gzeG3P9IkZurPkoKXvU3EjGkDXWqR2KOCC
	 vT8f0sd4iRgpJoqxeJo4fiKqzCfOK3LkcmjHUWxwL297DDTvU41IaTkTnkx6r/jvPm
	 90SKkj8LBFo+uZq+QrlidyJmbIGPo+RbfLWFoRWiQNbqMr+OjQ4nEJDZUxTkVTvTIC
	 sczmBuhmg/iXwB3DE7RrzDyzYGRV6+Y/ZxU0j8323cs2euz9IRJjre3ELR3RBmELQz
	 YFbEOvFMARewA==
X-Pm-Submission-Id: 4h0d1L4L1Gz2Sd4K
From: Esben Haabendal <esben@geanix.com>
To: Nuno =?utf-8?Q?S=C3=A1?= <noname.nuno@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>,  "David Lechner"
 <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
  "Andy Shevchenko"
 <andy@kernel.org>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Nikita Travkin" <nikita@trvn.ru>,  "Maslov Dmitry"
 <maslovdmitry@seeed.cc>,  <linux-iio@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] iio: light: ltr501: Power down chip if request
 irq fails
In-Reply-To: <7yhbsguvuodmgpmhb6dgnuxfede4x6x3ducrifymcmqlb5vl4u@rgrjqovq2ife>
	("Nuno =?utf-8?Q?S=C3=A1=22's?= message of "Wed, 15 Jul 2026 15:01:32
 +0200")
References: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
	<20260715-liteon-ltr329-v2-4-d18af55edab5@geanix.com>
	<YNVq2JyJ5AetAiMbwvpiwKO3WN2vtf-sdCy966IwnP92DxD3jwbHgUB_oTX0cWTJIEcSaY9IVHKeTgfbV3upFQ==@protonmail.internalid>
	<7yhbsguvuodmgpmhb6dgnuxfede4x6x3ducrifymcmqlb5vl4u@rgrjqovq2ife>
Date: Wed, 15 Jul 2026 15:53:26 +0200
Message-ID: <87cxwomka1.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nuno S=C3=A1 <noname.nuno@gmail.com> writes:

> On Wed, Jul 15, 2026 at 02:27:26PM +0200, Esben Haabendal wrote:
>> In case request irq failed, we were leaving the chip powered instead of
>> powering it down again.
>>
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>>  drivers/iio/light/ltr501.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
>> index 379e57ac5f5b..9d4de798e5ab 100644
>> --- a/drivers/iio/light/ltr501.c
>> +++ b/drivers/iio/light/ltr501.c
>> @@ -1571,7 +1571,7 @@ static int ltr501_probe(struct i2c_client *client)
>>  		if (ret) {
>>  			dev_err(&client->dev, "request irq (%d) failed\n",
>>  				client->irq);
>> -			return ret;
>> +			goto powerdown_on_error;
>
> This looks like a fix so we should have a Fixes: tag. And being it a fix
> it should be the first patch in the series (can come after bindings
> though). Reason is for backports.

Added for next version.

/Esben
