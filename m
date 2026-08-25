Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF99472536;
	Tue, 25 Aug 2026 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787666804; cv=none; b=Zr01nX4nopTmU3U8WgHVnCQ+uyKpNywl3j0F8YooQ5grwWCtGrNCw3dOf/3ziUT9FmIrzFM1iGI/fkKrEm1fkorI4TLhTD76nLfD5Y9Dn9MdsFeXI/99JFwwN6Yq329X5/vV4xeTWHQYiVi0DNXIYyZrDV+5hBLVz+RJVS8Rdhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787666804; c=relaxed/simple;
	bh=llIRgW8lssJoZ1hfTQVgPcev9enwEVrNP654+rDsX5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JATW0/a6+Rj5ua+MGTh+1ss0047lJqnQwun7dhFyynIoUTZfXS6FO+auUsooWdu2dQbbpGANZSrT54WeW8VLhKpCQ4cxzaq5Db7pCyDrOt4nzWOo9SJHZIChYYEogua22xVVdzQEiT0vyhLwuIYko/7kltWSng1D5x1SVBCTA8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=sAPJDjGl; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="sAPJDjGl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787666795; x=1787925995;
	bh=QlTHPnu67ifR9TI0uL5aQfa0ravENtMsauZqM5BDC44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=sAPJDjGljNTHFZCI9E8LHc2OqbJvEwR6Ii72KTDpfTWlw4VEftCfm3vjcBjbdR+ba
	 56Nho+B33/P4ttSu0zbRQdjdbi3ODT+n+LGeNCRYK5rHpL4bAo8gVEq7H5mFAXoYsW
	 ZYeXec48k7W8phpXzTVxt4v8ubdXg4IixKs8yg11HE9GJLTWdcykW3WTOZIZ72Q3XW
	 yHWbwAjx7cwyj64FbSiYEJkrUG7798OO3aT6Dcd61Yo9HeQyiqW3eyZCqoUrtykRuv
	 ZWvk2hFUPo+VfyiOfNMpgvJvhkBQVWGGEDRxrWuaMDurbmcuw7f37nokxB8jpiNFSP
	 6ic6UYxZYJqYw==
X-Pm-Submission-Id: 4hTqMY3LHPz1DF6y
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
 <martin.kepplinger@theobroma-systems.com>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 7/9] iio: accel: mma8452: Drop unneeded lock acquire
 on read
In-Reply-To: <20260825154449.00002f6f@gmail.com> (Joshua Crofts's message of
	"Tue, 25 Aug 2026 15:44:49 +0200")
References: <20260825-mma8452-open-drain-v6-0-9b252804ee80@geanix.com>
	<20260825-mma8452-open-drain-v6-7-9b252804ee80@geanix.com>
	<UFc9cC1VeohKw6lxQ8uulsfj9wJ_OqGUgGPTUnTX-zssKZ97aEC0Xi9nsAxv-tcf2DP5e85ElFZ8wPgxwG8l3g==@protonmail.internalid>
	<20260825121704.00004ed3@gmail.com> <87y0dumiga.fsf@geanix.com>
	<2m3zXurwen7GRVSaBnDu6bY31Gn7dFzO2UEoU4bRNxCGCR86DTyGq-CMmmeEh-U7AcCWC6eBjjFbZSGNltSwWg==@protonmail.internalid>
	<20260825154449.00002f6f@gmail.com>
Date: Tue, 25 Aug 2026 16:06:32 +0200
Message-ID: <87pkz6mh07.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Joshua Crofts" <joshua.crofts1@gmail.com> writes:

> On Tue, 25 Aug 2026 15:35:17 +0200
> Esben Haabendal <esben@geanix.com> wrote:
>
>> "Joshua Crofts" <joshua.crofts1@gmail.com> writes:
>>
>> > On Tue, 25 Aug 2026 10:27:45 +0200
>> > Esben Haabendal <esben@geanix.com> wrote:
>> >
>> >> There is no need to acquire data->lock when calling mma8452_read(), and
>> >> dropping that makes it less likely to end up in an AB-BA deadlock
>> >> situation.
>> >>
>> >> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> >> ---
>> >>  drivers/iio/accel/mma8452.c | 2 --
>> >>  1 file changed, 2 deletions(-)
>> >>
>> >> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>> >> index 7ef1a9a91c31..9ae2c3e60576 100644
>> >> --- a/drivers/iio/accel/mma8452.c
>> >> +++ b/drivers/iio/accel/mma8452.c
>> >> @@ -504,9 +504,7 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
>> >>  		if (!iio_device_claim_direct(indio_dev))
>> >>  			return -EBUSY;
>> >>
>> >> -		mutex_lock(&data->lock);
>> >>  		ret = mma8452_read(data, buffer);
>> >> -		mutex_unlock(&data->lock);
>> >>  		iio_device_release_direct(indio_dev);
>> >>  		if (ret < 0)
>> >>  			return ret;
>> >>
>> >
>> > Sashiko has something to say and I tend to agree at the moment:
>> >
>> > Could removing this lock expose mma8452_read() to race conditions with PM
>> > auto-suspend and event configuration?
>>
>> Yes. I tend to agree as well.
>>
>> > mma8452_read() can be interrupted by the PM auto-suspend worker, which puts
>> > the device in STANDBY and disables regulators while mma8452_drdy() is actively
>> > polling over I2C. This can lead to I/O timeouts or errors.
>>
>> Yes, and causing pain for other I2C devices on same bus :(
>>
>> > Additionally, concurrent sysfs writes to event configurations invoke
>> > mma8452_change_config(), which puts the hardware into STANDBY to modify
>> > registers. The Standby transition flushes the hardware FIFO. If this occurs
>> > between the mma8452_drdy() check and the i2c_smbus_read_i2c_block_data() in
>> > mma8452_read(), the block read will fetch flushed or stale data.
>>
>> Argh. Yet another level of trouble.
>>
>> Maybe we should extend the use of data->lock instead. Holding it
>> 1. whenever doing read-modify-write actions
>> 2. while holding the device in standby mode for changing registers
>> 3. while doing suspend/resume
>>
>> I was just adding support for a open-drain mode irq sharing you know.
>> While sashiko-bot definitely is catching lots of valid problems, and
>> fixing them is a good thing, this is starting to feel like I opened
>> Pandoras box by touching this driver :D
>>
>> I will try to wrap up a patch with the above described extended usage of
>> data->lock, but hope we can find a way to get the irq sharing and open
>> drain mode support merged, without necessarily having to fixing all and every
>> possible existing bugs as a pre-condition, but maybe delay some work to
>> later work.
>>
>
> If they're pre-existing conditions then it's not required to fix those in the
> same patch series, you can come back to it another time or someone else can fix
> those.

Great. I have created a local mma8452-next branch where I will continue
the work on some of these issues.

> Nevertheless this is an issue that will be caused directly by this patch if
> applied. If your only goal is to add support for open-drain irq sharing, you
> can probably just drop this for the time being and just focus on that.

I will drop this particular patch for this series, and work on a proper
fix for all these race conditions in my mma8452-next branch.

/Esben
