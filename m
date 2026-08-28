Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6824A19CD0A;
	Fri, 28 Aug 2026 06:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787898584; cv=none; b=UfU9D7rDrhCfdvP9d7Ta5txvOaljlT/lNRwe4/ejwRN1Ggn7/iMI5Sbm5onPOnzrCU+DLswVHueXtf0FUSLf+LTXvZ5jMY8IUf3xMDQ2xiopAYlbYpIga+Z5Xl7ey7uDnQcPTI6f66lLVFHJ0BX0gTk/GpJS/zRCcB8m1BJVjY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787898584; c=relaxed/simple;
	bh=p/lam6beXF9NEb011PkJ3Hnm/hG7y91uny9lzu8lsDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UUQ+ZGKBmQq9JA6mTjzM1PZnAHCuMcJpo1Ikxg83oTCUfinH4QCUXTP/0G+p84SNkgr1zo2Rd5RIVuQb4S+SF7RkD3UeUbTbn7Qz7nYIObwv6dcgK5O5aVu9VI5PwBtlN+4xKnuQ9bkTs6DZapyc19v5v+Cb5SntApYiywQcUdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ze1c2MUA; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ze1c2MUA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787898573; x=1788157773;
	bh=lEtX1Yhb7j1CGhPByWl7XUi0pduY0cmPFFbTecpZ0cg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ze1c2MUA/AeDoENRlEb4WP/uRfK4CFtfHsGhxTEs1UVczLvKdT4H4Fm98XW1TAQqk
	 c0ZwnWqmnIUA04QqoMnyzwFfrZVpEfcP0uMqo3evZy9ZTvNpIYaKQlinXyL5wRfP+W
	 lNX6IqHy5kw3/doSW00L4kjCW7VFGrxUDOjrLhfRrFx7R6ghJsuUFZB+cG0u9n8BfO
	 wSHuWE15pGbcTXhIaMuTZMWVWEuZWXHprFGFsM9/gm3jnxsu07xF6gsVdYRVfD7ZMj
	 Uyxw2//eNCJBdplVVY5Dena/wz9Wag3rySiXbHc1tSGoUKjZQbBlhxv1ZRLiAjUiGp
	 dxXaJL1+rELsw==
X-Pm-Submission-Id: 4hWT4q3n4Nz1DDXG
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
Date: Fri, 28 Aug 2026 08:29:30 +0200
Message-ID: <87y0dqycz9.fsf@geanix.com>
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
>
> mma8452_read() can be interrupted by the PM auto-suspend worker, which puts
> the device in STANDBY and disables regulators while mma8452_drdy() is actively
> polling over I2C. This can lead to I/O timeouts or errors.
>
> Additionally, concurrent sysfs writes to event configurations invoke
> mma8452_change_config(), which puts the hardware into STANDBY to modify
> registers. The Standby transition flushes the hardware FIFO. If this occurs
> between the mma8452_drdy() check and the i2c_smbus_read_i2c_block_data() in
> mma8452_read(), the block read will fetch flushed or stale data.

I have been working on fixes to these problems, and all the other issues
concerning runtime PM and state and read-modify-write synchronization. I
will post a patch series with the work once this series is merged.

/Esben
