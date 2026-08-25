Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390E630B509;
	Tue, 25 Aug 2026 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787655633; cv=none; b=PgX47swX3o9VJOnEnn4gJkoAcCEQCN7hWb10PxNltSf+kH5VswJzBsUYVXdfwTQyrrewQZJhWaMDpJ14xwZ+A/Hc21vEa/vjclrNQ1ZkKXV9JxwYR3PFyOWSc+CIjIOFV/w2A5++njA4IFTFYgQqmf9TpgybKgMiwXuAHmpH//g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787655633; c=relaxed/simple;
	bh=hlQaic0F0CxMkHX0OwjEl1Bx+fB1Q/isL2/ynDVBG14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c7/pzLMm8RXFn5wfa4o/wWIpXhSZDPniLqvScaJADuPxx8A0G/WhgB038sNX46aZcaTT9gJEetAdvmVYwxxIdXz7y2BM2qcBtK22g1HaqfZmcRoDyp7Ss8OuhnZm0CERK5md3LfGvIjJwZr4yNdWy2377lf9prHCBUb2INoBNj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=L8bibeUi; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="L8bibeUi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787655624; x=1787914824;
	bh=el0ckJyITQBcyMzLRk7pDSGAYgyQePG9Nu8b8f3Hh54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=L8bibeUicnFFoDCPHx8kwWFRlY/pG6kDuqTvEXdB37ZJiZI4x6KW9TC7DBaax+LVi
	 pSsWW+wCMfWftkbz4E0TgzVB7sWl9sw+fF9jhGSmhQ9L8SQt1r6nqcyAaiNisXG8Mk
	 jw9xjbbrKTH9DZctHwtQF3o/wXmXmzfjc26amaS/VWUph0ce3D5702J7XWyu9wZEns
	 DArRD/AGutSPrzdBwfVyW0C6y6gVHNlEJvD9C0H5hOCPHPDWV1itBv5+Uba7BMeI/M
	 hIrDuaWvxcH5rV9lWeZsCgzG/jh5p+tvgKBlM3+cL15km6IDbirRWpcnXsEbTwbMGG
	 TMe124eunRXWQ==
X-Pm-Submission-Id: 4hTlDk67C3z1DDXK
From: Esben Haabendal <esben@geanix.com>
To: "Joshua Crofts" <joshua.crofts1@gmail.com>
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
Subject: Re: [PATCH v6 9/9] iio: accel: mma8452: Use proper error code when
 missing device model
In-Reply-To: <20260825122301.0000531e@gmail.com> (Joshua Crofts's message of
	"Tue, 25 Aug 2026 12:23:01 +0200")
References: <20260825-mma8452-open-drain-v6-0-9b252804ee80@geanix.com>
	<20260825-mma8452-open-drain-v6-9-9b252804ee80@geanix.com>
	<HmXmDujS0IYQxlEIiTAGIiTIpioZlDO_L3bIBEBj8FWdbzyRSs2EnMSbymREOsD07x_zeOkYuPGdpgRl5Wewog==@protonmail.internalid>
	<20260825122301.0000531e@gmail.com>
Date: Tue, 25 Aug 2026 13:00:21 +0200
Message-ID: <87fr02o46y.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Joshua Crofts" <joshua.crofts1@gmail.com> writes:

> On Tue, 25 Aug 2026 10:27:47 +0200
> Esben Haabendal <esben@geanix.com> wrote:
>
>> The device is there, but we don't have data describing how to use it.
>
> A bit of a weird commit message IMO,

:)

> I'd do
>
> Switch -ENODEV error on i2c_get_match_data() failure to -ENODATA to
> satisfy the IIO coding style. (but this is only my opinion).

Sounds good to me. I will update for next version, if needed. But feel
free to make the change when merging.

/Esben

> (We recently had a few conversations about -ENODEV vs. -ENODATA and
> while there are a lot of uses of -ENODEV in IIO they should be replaced
> with -ENODATA when checking *_get_match_data() results).
>
>>
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>>  drivers/iio/accel/mma8452.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>> index 4a1eb196589a..42e3371cdb1d 100644
>> --- a/drivers/iio/accel/mma8452.c
>> +++ b/drivers/iio/accel/mma8452.c
>> @@ -1595,7 +1595,7 @@ static int mma8452_probe(struct i2c_client *client)
>>
>>  	data->chip_info = i2c_get_match_data(client);
>>  	if (!data->chip_info)
>> -		return dev_err_probe(dev, -ENODEV, "unknown device model\n");
>> +		return dev_err_probe(dev, -ENODATA, "unknown device model\n");
>>
>>  	ret = iio_read_mount_matrix(dev, &data->orientation);
>>  	if (ret)
>>
>
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
>
> --
> Kind regards,
> Joshua Crofts
