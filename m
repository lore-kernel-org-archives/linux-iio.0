Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC1B517BBF
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788798514; cv=none; b=Fx286gvt9fstulvfIzNIUvWRohn20NmkGdk6RBUpZ7iAco86mq+9rNgrh/F+c5lD4R8cMzCofNGAqVw787MoQDexB0GNjbNEOk9rpRp0yn5a4FBM4v5dJ7QQdAm3K7jI20T4S7BjD1I8mqirm4yJ/A10hQ61Ln0ugIKDilv020o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788798514; c=relaxed/simple;
	bh=SgykCNQtDc/+Ij6tSBwu7t4+5/GaewaqS/8NPFi2cMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tBzOTX62ObLuw7nn1w00xKs7BLn96wNoUmGAnbhgR/qmHzF6Fqxg8p7B2Ln3eS4NZauK3QdRR8u05qD/SJYsl5DuMWB1dfhcBaKqc2vlDO6DF/lgnPPWpr23UM6UEz4/qpYghrF0t/mFriIrtuPuEMA9KLf43pHbyHorZ+SYW24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Row8ZZm4; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Row8ZZm4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788798507; x=1789057707;
	bh=6OjgMIJj50VZV8va4rj3JqbmUwbnL6ihDuaNaKIdDGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Row8ZZm4EMCgSAPpLNtG1bytykN33OhMyfiluR3nSXDgOrNnkMIqV+yMMgCIwrIyL
	 3AEnk3fh29zlTQZplNgniOovNCdgcya4QMkVcF4NKrIM/V3Dq4G2lTQuw7jRpJKkiF
	 Ogs5Bq6Dry15q/jyYvRW/vVoTP8l1UFEtZhmWSyitVLSLQkqF2+sF4nb4livVDz/ZW
	 DZibD5A0X7PT7kSmct7NVrv4j+JWfQbGOwOkjgJYcsORF576hi6X5674ULD92OP2by
	 z7PydcwUMa6EGu7ht91Mj+oU9VycsicCS8o3nl3TepAdcqGr+zQkPFrqfxRSncRjmj
	 GeMjdeZgMINUw==
X-Pm-Submission-Id: 4hdsvF42Mqz1DF7F
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
Subject: Re: [PATCH v8 6/9] iio: accel: mma8452: Add comment block for
 struct mma8452_data
In-Reply-To: <20260907171452.00004fc8@gmail.com>
References: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
	<20260907-mma8452-open-drain-v8-6-c17407e22118@geanix.com>
	<31YOKVM7iz6GWh9N-mvnk5VHc2P93CchlAdIr-K7hhDqvjulK8wced5UYHkLEn3czBuvn73NN5NdM4YellB4rQ==@protonmail.internalid>
	<20260907171452.00004fc8@gmail.com>
Date: Mon, 07 Sep 2026 18:28:24 +0200
Message-ID: <87ik4h81qv.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Joshua Crofts" <joshua.crofts1@gmail.com> writes:

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
>
> Perhaps add the word sequences after read-modify-write (that
> could be a personal preference though)?

Added for next version.

>> + * @orientation:		mounting matrix, flipped axis etc
>
> Missing period in etc., but that's a small enough nit :)

Also added :)

>> + * @chip_info:			chip specific data
>> + * @vdd_reg:			reference to VDD regulator
>> + * @vddio_reg:			reference to VDDIO regulator
>> + * @buffer:			triggered buffer
>> + * @sleep_val:			time in ms to sleep while waiting for drdy
>> + * @ctrl_reg1:			CTRL_REG1 register shadow value
>> + * @data_cfg:			DATA_CFG register shadow value
>> + * @open_drain:			true for irq pin in open-drain mode
>> + */
>>  struct mma8452_data {
>>  	struct i2c_client *client;
>>  	struct mutex lock;
>>
>
> Either way, with those added in a new version or fixed up
> by Jonathan,
>
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

Thanks.

/Esben
