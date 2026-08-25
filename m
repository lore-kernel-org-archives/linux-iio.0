Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F990483824;
	Tue, 25 Aug 2026 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664928; cv=none; b=PqP3juNesIjgYXxm+NZWGtVNridCDmgYZFK30zao7GM3dT7sDPUC0jbOk60FaXnsUV5n/sn87E78zvdUbskr2q+yGVvqp2JEd0+EgXrSZHdVxPgp0UNDnLgfz/VXCEnhezSXCOB2MD1uWbC16Lj95TycwRoqlB+ApreVbat2Ey8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664928; c=relaxed/simple;
	bh=RmKE3E4oGb27PW1XWDC6KrPVZvMH56dk0BN1FPRAGBM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WvUdfsYVWESIYH5jMD3OdlKOUbYA4MoyGGQbGIVsLSPthmP4PeatP/sRNdpijIHLlDa1j3i95ZUhN6J3r/RID/iLVxQjkJg6gkCOiQ3RyzT7gmUiT9uZ8J8MgQJWgXmpOUSn8UKG7f122RgB55NYFS/T8irEs3JysiliNUZ8eKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=HaIciQI8; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="HaIciQI8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787664919; x=1787924119;
	bh=t8gCPOns6Lt7Voi7K4oqpWNumhq592+gFx77TstZ3Pw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=HaIciQI8Eyr6zkc5rS0o87DDQVDbVM8Sz/PqmiAKxyg3LdgoHieIhfetxNcSy/q/a
	 W5KL7Jd3y/MTcjrSIJKR+wcwonO/yxnJVyYVmiKeo1Aaj5iIoox1zBEMaq612BH9pi
	 YNEKxHPv6ONkm9SDq1wXBZ08pWdd5kVo/KGvHLeSCDlu3Vm5B1PvLo5E+b6oGcsJM/
	 SaSI1QralpBZHrlVFdfjJl4Miih82z2kP2iXHioDfDgtPO+1SISiFacJQsAuR9MGST
	 mMldTDE9YM9itOS5xnTbjx82LcDUUbcrAkkDDhZrNj1SPPDSq/ms5x4RGSDBrxe9Ck
	 Y4TxaW68l7ofw==
X-Pm-Submission-Id: 4hTpgV38jGz1DFFp
From: Esben Haabendal <esben@geanix.com>
To: "Joshua Crofts" <joshua.crofts1@gmail.com>
Cc: <linux-iio@vger.kernel.org>,  <devicetree@vger.kernel.org>,  "Jonathan
 Cameron" <jic23@kernel.org>,  "Lars-Peter Clausen" <lars@metafoo.de>,
  "Rob Herring" <robh@kernel.org>,  "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,  "Martin
 Kepplinger" <martink@posteo.de>,  "Sean Nyekjaer" <sean@geanix.com>,
  "David Lechner" <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?=
 <nuno.sa@analog.com>,
  "Andy Shevchenko" <andy@kernel.org>,  "Martin Kepplinger"
 <martin.kepplinger@theobroma-systems.com>,  "Christoph Muellner"
 <christoph.muellner@theobroma-systems.com>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 7/9] iio: accel: mma8452: Drop unneeded lock acquire
 on read
In-Reply-To: <20260825121704.00004ed3@gmail.com> (Joshua Crofts's message of
	"Tue, 25 Aug 2026 12:17:04 +0200")
References: <20260825-mma8452-open-drain-v6-0-9b252804ee80@geanix.com>
	<20260825-mma8452-open-drain-v6-7-9b252804ee80@geanix.com>
	<UFc9cC1VeohKw6lxQ8uulsfj9wJ_OqGUgGPTUnTX-zssKZ97aEC0Xi9nsAxv-tcf2DP5e85ElFZ8wPgxwG8l3g==@protonmail.internalid>
	<20260825121704.00004ed3@gmail.com>
Date: Tue, 25 Aug 2026 15:35:17 +0200
Message-ID: <87y0dumiga.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Joshua Crofts" <joshua.crofts1@gmail.com> writes:

> On Tue, 25 Aug 2026 10:27:45 +0200
> Esben Haabendal <esben@geanix.com> wrote:
>
>> There is no need to acquire data->lock when calling mma8452_read(), and
>> dropping that makes it less likely to end up in an AB-BA deadlock
>> situation.
>>
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>>  drivers/iio/accel/mma8452.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>> index 7ef1a9a91c31..9ae2c3e60576 100644
>> --- a/drivers/iio/accel/mma8452.c
>> +++ b/drivers/iio/accel/mma8452.c
>> @@ -504,9 +504,7 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
>>  		if (!iio_device_claim_direct(indio_dev))
>>  			return -EBUSY;
>>
>> -		mutex_lock(&data->lock);
>>  		ret = mma8452_read(data, buffer);
>> -		mutex_unlock(&data->lock);
>>  		iio_device_release_direct(indio_dev);
>>  		if (ret < 0)
>>  			return ret;
>>
>
> Sashiko has something to say and I tend to agree at the moment:
>
> Could removing this lock expose mma8452_read() to race conditions with PM
> auto-suspend and event configuration?

Yes. I tend to agree as well.

> mma8452_read() can be interrupted by the PM auto-suspend worker, which puts
> the device in STANDBY and disables regulators while mma8452_drdy() is actively
> polling over I2C. This can lead to I/O timeouts or errors.

Yes, and causing pain for other I2C devices on same bus :(

> Additionally, concurrent sysfs writes to event configurations invoke
> mma8452_change_config(), which puts the hardware into STANDBY to modify
> registers. The Standby transition flushes the hardware FIFO. If this occurs
> between the mma8452_drdy() check and the i2c_smbus_read_i2c_block_data() in
> mma8452_read(), the block read will fetch flushed or stale data.

Argh. Yet another level of trouble.

Maybe we should extend the use of data->lock instead. Holding it
1. whenever doing read-modify-write actions
2. while holding the device in standby mode for changing registers
3. while doing suspend/resume

I was just adding support for a open-drain mode irq sharing you know.
While sashiko-bot definitely is catching lots of valid problems, and
fixing them is a good thing, this is starting to feel like I opened
Pandoras box by touching this driver :D

I will try to wrap up a patch with the above described extended usage of
data->lock, but hope we can find a way to get the irq sharing and open
drain mode support merged, without necessarily having to fixing all and every
possible existing bugs as a pre-condition, but maybe delay some work to
later work.

/Esben
