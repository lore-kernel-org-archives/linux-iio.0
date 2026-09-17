Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176AC3B42C0;
	Thu, 17 Sep 2026 06:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789626292; cv=none; b=pDhVfYXquwcVxybckaM+/L5/uVSO5c6JlHNaYPbpXVAlsJAzi31Oux3l4tfjrZJlnqexrCcNMUBeijvLtrSkt+9bRyIItWssyTy/Bw4m2I4LFWmFKBiXovYek2u510PEPzfnGO0WX7y/57VpS91tSv4os05cZlSte2vj3fN8yeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789626292; c=relaxed/simple;
	bh=rnJOIiNTcdbASSkEuhTpF8A1YSK0nv3UCrd+KByTuhQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f20k7ngaG5C18wWQoOhF496uAHdg7ViyA/OgtJPRhYuNXzXW3F3kViw8m4JqjPM5HrA0+H+17fAZaJ1lAzaNsNmWu4/3NgCYyF1uqG6xR7Elq5+JTKsPzjfD2SVcihbKoUYD5DWaGU62U1YlFHgG+8FBJ1Tzp0MuX4EDhEMn5AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=rn/ZrrgS; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="rn/ZrrgS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1789626284; x=1789885484;
	bh=TA6rlXyicXZfTTHClBxkqFgtYRL1l+vtdpQgmLVwMGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=rn/ZrrgSSIExsU9ZgAdwG6yolw/s2LXHZUHF2mUWlphzHYutwhNubTUZg45iVdC+v
	 VOtFkfwQMll90wLolFnkO9sJfG3UlYHVtYg+V7QU04Qn9BBPSVp+9qTms7ZwJjJJPi
	 5ny5hurjyLw7UcCd4uOw2kn0wNUdqkHTCmQBChi5/eNcfy8JWSNjBMJyDFiD6HatkV
	 zkBk1GNeCtS5mHfbZrgDEj+JvjqlEvasNegPYzOJ+7g+4XXNVoe1f6Xnfk2JYv/Bw/
	 rh02FUsdBUSPRJqJvJbmDKpOMR7M7hXxGioZdifxQMp9zC77czok/coL9dmVatuNfJ
	 1Q5B9p3uDXLqg==
X-Pm-Submission-Id: 4hlm220bDBz2ScPL
From: Esben Haabendal <esben@geanix.com>
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: "Martin Kepplinger" <martink@posteo.de>,  "Lars-Peter Clausen"
 <lars@metafoo.de>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Sean Nyekjaer" <sean@geanix.com>,  "David Lechner"
 <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
  "Andy Shevchenko"
 <andy@kernel.org>,  "Martin Kepplinger"
 <martin.kepplinger@theobroma-systems.com>,  "Christoph Muellner"
 <christoph.muellner@theobroma-systems.com>,  <linux-iio@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 9/9] iio: accel: mma8452: Support interrupt sharing
In-Reply-To: <20260917034607.2674781e@jic23-hlaptop>
References: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
	<20260907-mma8452-open-drain-v8-9-c17407e22118@geanix.com>
	<_9NG2PCqwv-AxkrhQVOkPVIgvYD4-t2CFH5W5HVBmr35w9xmX9v9FIraB1OPE8Ssbd_pjQqM-bq3DEAtRl78Sg==@protonmail.internalid>
	<20260914002203.5ca07dd0@jic23-hlaptop> <87y0d4pal0.fsf@geanix.com>
	<C6aGTWK07IZGyMQVOFXCAuZody8OsqRS5uG0Kd88ikhzwZ4SDBhHmsku0KivRAa0i6oyuYBvLiau1uFJKwa5Mg==@protonmail.internalid>
	<20260917034607.2674781e@jic23-hlaptop>
Date: Thu, 17 Sep 2026 08:24:41 +0200
Message-ID: <871pas8keu.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jonathan Cameron" <jic23@kernel.org> writes:

>> >> +	if (pm_status == 0)
>> >> +		return IRQ_NONE; /* device is powered down */
>> >
>> >> @@ -1784,29 +1796,62 @@ static void mma8452_remove(struct i2c_client *client)
>> >>  #ifdef CONFIG_PM
>> >>  static int mma8452_runtime_suspend(struct device *dev)
>> >>  {
>> >> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>> >> +	struct i2c_client *client = to_i2c_client(dev);
>> >> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>> >>  	struct mma8452_data *data = iio_priv(indio_dev);
>> >>  	int ret;
>> >>
>> >> -	scoped_guard(mutex, &data->lock)
>> >> -		ret = mma8452_standby(data);
>> >> +	guard(mutex)(&data->lock);
>> > Mixing guards...
>>
>> Yes, I know. Resolving that turned out to be a bit more painful than I
>> thought. I do have that resolved in the next series I keep on talking
>> about. But distilling that as a separate patch for adding to this series
>> turned out to be impossible, as it relies on some of the other work,
>> like refactoring of the ACTIVE/STANDBY state handling (synchronization),
>> and most importantly, the switch to using regmap caching to properly
>> handle restoring of register values on resume.
>>
>> I am therefore hoping that we can find some way to agree on things here,
>> and then properly resolve it in the next series...
>
> Ok. It is fine for now.  Perhaps add a comment along the lines of
> /* Must be first action in scope that needs to be undone on error */
>
> And hopefully it won't be around long enough for anyone to copy it
> into more code!

Ok. I got a bit trigger happy, so v9 is now sent with a proposed
(temporary) fix for it it instead. If that meets resistance, I will
consider falling back to adding the comment you proposed above.

/Esben
