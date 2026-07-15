Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCA02BE026;
	Wed, 15 Jul 2026 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122362; cv=none; b=SKUTEWJT80++U/yCtQLqHttt03Op9HZr6ORKBCCWsYMO+k2lijbyc5yka59D/yeXr4zxMQkf2R/mp/YPuDwzgrUTURyE2l23kzkVyv/Mwl3TGZEMnZKA7ovx3UmaUEx6XwI7bYhMAnSIeMu/uHOXZWvVrPjD1q3PA38UzZk7bvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122362; c=relaxed/simple;
	bh=W8CO2KxXvI9NYWsBJxzXoHxL1JMJwIwl/nfFG3GfYRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t/s9QCLMZbxneAczaw0oCqznV+Acwf2GEEzEPHFOT56V6CLdIu1ayfRmbDvkxn/MwZwrbae1bshZgBXCNy9wIEEa7b0DeW5cV+TQADgRUgsetFU9QexzgXYuSe3O8AY6Z4i/tPNC5V2rpO4bnJ1x5iutu2u7cZuN7D7Q1AyaIgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=THXCv1Pq; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="THXCv1Pq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784122357; x=1784381557;
	bh=cZMyF7lKN/fVrjH0IISFT/Q0aua/g9KR2me/3HTTkB4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=THXCv1PqP+wN0+z4mzJVbKT6lJkjEvhgEyDnfOabCVL4SdBUBgKZDz255A1rm6mq6
	 iO4pHK99JY59bQ2GSPt/LS8GgWHbubd1KaDfEOWTyVHy/uVR1BqTjTliyi2tLJU/vw
	 /30rdvj5jeJEfHPjOE8azfbh581qsqC1lreEmQrAvFl2fVelBLQ9TGlaPjQj9sisPF
	 DNxWoHbYT67XycUFKdIEqL6Q7VqXBjp3SduvjO2kXsYRJu0qQLwtQgLZQVXMmUGQsD
	 yFD3kSA6OA3IRNiHux6avVRP8DFMifc4iRFHWkVhPsV44P09HU7nE52K4idP9NqAaF
	 dXCuPVGz5KgxA==
X-Pm-Submission-Id: 4h0cYC2N19z1DDXd
From: Esben Haabendal <esben@geanix.com>
To: "Joshua Crofts" <joshua.crofts1@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>,  "David Lechner"
 <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
  "Andy Shevchenko"
 <andy@kernel.org>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Nikita Travkin" <nikita@trvn.ru>,  <linux-iio@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] iio: light: ltr501: Power down chip if request
 irq fails
In-Reply-To: <20260715145944.00001de5@gmail.com> (Joshua Crofts's message of
	"Wed, 15 Jul 2026 14:59:44 +0200")
References: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
	<20260715-liteon-ltr329-v2-4-d18af55edab5@geanix.com>
	<6-wUX5EiSYvh9vD_ssjPFzgUU5Zufzt16ne6vtLlfMmSVNXcH0PfzmPA-0l9gRPnGufaUTd4coEpWEknDRlbqA==@protonmail.internalid>
	<20260715145944.00001de5@gmail.com>
Date: Wed, 15 Jul 2026 15:32:30 +0200
Message-ID: <87tsq0ml8x.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Joshua Crofts" <joshua.crofts1@gmail.com> writes:

> On Wed, 15 Jul 2026 14:27:26 +0200
> Esben Haabendal <esben@geanix.com> wrote:
>
>> In case request irq failed, we were leaving the chip powered instead of
>
> devm_request_threaded_irq(), please mention functions and structs by their
> full name to prevent ambiguity.

Ok.

>> powering it down again.
>
> + a very short explanation of what you did, 1 sentence

I will do what I can.

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
>
> While you're at it, you can remove the dev_err() call as devm_request_threaded_irq
> already calls dev_err_probe on failure, creating duplicate messages.

Consider it done.

>
>> -			return ret;
>> +			goto powerdown_on_error;
>>  		}
>>  	} else {
>>  		indio_dev->info = data->chip_info->info_no_irq;
>>
>
> --

/Esben
