Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C716B33A9E2
	for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2026 06:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368647; cv=none; b=s6lBsn5KIdS0McdgGqfc4Xk7OmsilBPucsszdMa6z8dz7dh/eIp3pIVCnmbzFyysPZKSqDCn2VcYVkfMb+v314dj/iE8MrOeb9KuBa4tXKcBlF1SzI+GFDbfsJOcf7Eph5AyfFhqWz0IKKv/74DP0sxUE1j26xviSnEJQ2se6fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368647; c=relaxed/simple;
	bh=aIpbLlwdmbcTnwkTSzFZLDJCnVOvqN3X5lMPhJCFO8M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B2zTprWwnje45XyU9zAjqTZuCblebpcpN75PvV8T7F7YuauDFf+LZOzs6p8a1780ETqIr3tRZl//j/18IfBu7lp9ECaI3cv/JcjLrRtYXTg8JR+Vnw3OQhsh6HDog7ZFP8yxCRhaUCh3bkcVC2GZxU0cIHHlxiIds5NhkzGTFKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=SlZ1nkVh; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="SlZ1nkVh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1789368636; x=1789627836;
	bh=voOVQn4SEWZAEsyGJZ/P1FdKKOEHwrdxFVFyvFaooXE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SlZ1nkVhLUA5+qYF6nnoBg02O4uVlBtVHzbE6Ypu3TH9edKjL4TJXWSM/9pSCQM8q
	 kWKcEHxYKuZNFS7P8ZDRjTft9RFJplwfWpsZpRLTg9lZghHoKmR1XwkcBmmrk72YGm
	 T1UMeAzxzjwI1cQzQ1Qjvvn5Ko+XAtOdqeviP/0bZ7VByeIQIv9gx3SLTYNVN4MuUC
	 8AT9p4+qJtKXuZhkHrYqMkDxgeSdhYzFKOZnZJPeOl1zynks/owCtWqtcGwaeUe6PP
	 hF0+M+XHluebLD1MZ3PRrx1JG/p3J60+/TPfLapB21FrXGzpKeYP7ZcBNVKnzAbpQ2
	 HsFHOyyeXx3Bw==
X-Pm-Submission-Id: 4hjwlF3sd9z1DF6l
From: Esben Haabendal <esben@geanix.com>
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>,  "Rob Herring"
 <robh@kernel.org>,  "Krzysztof Kozlowski" <krzk+dt@kernel.org>,  "Conor
 Dooley" <conor+dt@kernel.org>,  "Martin Kepplinger" <martink@posteo.de>,
  "Sean Nyekjaer" <sean@geanix.com>,  "David Lechner"
 <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
  "Andy Shevchenko"
 <andy@kernel.org>,  "Martin Kepplinger"
 <martin.kepplinger@theobroma-systems.com>,  "Christoph Muellner"
 <christoph.muellner@theobroma-systems.com>,  <linux-iio@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 6/9] iio: accel: mma8452: Add comment block for
 struct mma8452_data
In-Reply-To: <20260914001514.3a33ce55@jic23-hlaptop>
References: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
	<20260907-mma8452-open-drain-v8-6-c17407e22118@geanix.com>
	<9JAXlYhUmV0zxVuB-Ckxjm3ncsCELASr3bemodiWlAbhyXvdWJqEHVY2wBgIuYWLlGxR-6MNWrZ8O17oMdynCg==@protonmail.internalid>
	<20260914001514.3a33ce55@jic23-hlaptop>
Date: Mon, 14 Sep 2026 08:50:32 +0200
Message-ID: <8733vcqqbr.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jonathan Cameron" <jic23@kernel.org> writes:

> On Mon, 07 Sep 2026 16:51:01 +0200
> Esben Haabendal <esben@geanix.com> wrote:
>
>> The struct mma8452_data is central for this driver, and it makes sense to
>> have a description of the fields in it to make it easier to work with the
>> driver.
>>
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>>  drivers/iio/accel/mma8452.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>> index c6af68d2a297..2c1b97b77bc1 100644
>> --- a/drivers/iio/accel/mma8452.c
>> +++ b/drivers/iio/accel/mma8452.c
>> @@ -104,6 +104,22 @@
>>
>>  #define MMA8452_AUTO_SUSPEND_DELAY_MS		2000
>>
>> +/**
>> + * struct mma8452_data - IIO device private data structure
>> + * @client:			the I2C client object
>> + * @lock:			mutex for synchronziation of register
>> + *				read-modify-write and holding chip in STANDBY
>> + *				mode while writing to registers
>> + * @orientation:		mounting matrix, flipped axis etc
>> + * @chip_info:			chip specific data
>> + * @vdd_reg:			reference to VDD regulator
>> + * @vddio_reg:			reference to VDDIO regulator
>
> These don't exist any more.  Sanjay did a conversion to bulk regulators
> that I picked up a few weeks back. Please rebase for v9 on top
> of the togreg branch of iio.git.

Already done and queued up to be sent :)

> Seems that sashiko figured out enough to base this on a more recent
> tree than you have.

/Esben
