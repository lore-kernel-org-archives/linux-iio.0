Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1EB492531
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.137.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784136091; cv=none; b=eVXozCKJkxU/E2QqufAvIy0sSZuLSNlL997mB0Ot0UJH00wwhRMfkp6n85DxKqrvLJAXhfn/dvufRX02GYYsJxRabsXx1EjoJsAeEml/X2p5cSZ6krrw2yzoEmKeiIzfaT+VmBsbWEBKP7K5LXzCGbl4GqquSMMnWHVu03bSRO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784136091; c=relaxed/simple;
	bh=GLvaeG4veOXqe6ZdJOsE8hk00btEH4C6yUcBqh3bE0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MG4LxBNBlSZyeE1W4RFZhThyxZPnWgBt4lUGhaDLqnrQv8n+N0IM3zdkYFKd0My4jTJ+YnrcLNx6fqIOrdhoPEPtJoD6yqP5wVMh+H72DfhiFtuPwR6FZBSbdRZTl/baz69kURa+K+MZh9R9vx+E9My5zwXdBhkGhA6souX8vGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de; spf=pass smtp.mailfrom=metafoo.de; dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b=PTZ15Ts5; arc=none smtp.client-ip=78.46.137.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metafoo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="PTZ15Ts5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
	s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=jgu7OUbTpWk2vo8VGq3aHXiwKtuZrxSw3HuodMI+Cuo=; b=PTZ15Ts5LNGNBDHcDqDkh+OEzi
	AvF8mVOgC4OBJhRZJzxfIScmJie/vZ3wxRafcXpjxUE+5uXkF5ADoaqlNlvBOfERNipVfyklDju5l
	PBdPjTYGswfxKnMoV5hw/WK4RM167YBdrIsZ3hiLfvwV2yjuqzyoxjklhd1jMWn+dhlFh6Q2/o03L
	MIo7WPo3xmmdb64Jur94abGEs+mpPePdA30NFbksVO2V5PO1MrwgxnWIeBCpBFuP906fBK6W4ZXs4
	3TuLDT4w1x06OPstDi5SG0JmWcHwXD6je8g3nh+hCB3Q3a7VFy73crKz+ZAUcqmAF+LURMHkz8yev
	gIMvwn/g==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <lars@metafoo.de>)
	id 1wk3IQ-000290-1N;
	Wed, 15 Jul 2026 19:21:22 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <lars@metafoo.de>)
	id 1wk3IQ-000JZY-1K;
	Wed, 15 Jul 2026 19:21:22 +0200
Message-ID: <9a25d60e-8c95-47c1-9004-0f7a2b5d5fa5@metafoo.de>
Date: Wed, 15 Jul 2026 10:21:19 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iio: buffer: Make IIO DMA fence release RCU-safe
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>
References: <20260715154245.3814378-1-lars@metafoo.de>
 <20260715154245.3814378-3-lars@metafoo.de>
 <aleyq2J6tVWYA6pC@ashevche-desk.local>
Content-Language: en-US
From: Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <aleyq2J6tVWYA6pC@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28061/Wed Jul 15 08:25:10 2026)

On 7/15/26 9:17 AM, Andy Shevchenko wrote:
> On Wed, Jul 15, 2026 at 08:42:45AM -0700, Lars-Peter Clausen wrote:
>> The `dma_fence` documentation states that if a custom release
>> implementation is provided, the `dma_fence` object must be freed in an
>> RCU-safe way. The current `iio_dma_fence` implementation uses `kfree()`,
>> which might result in a use-after-free.
>>
>> Remove the custom `release` implementation. This makes the DMA fence core
>> fall back to `dma_fence_free()`, which calls `kfree_rcu()` on the fence.
>> This requires that the fence be the first member of `struct iio_dma_fence`.
>>
>> Using the default release method for extended DMA fence structures is a
>> common pattern.
> ...
>
>> +	/*
>> +	 * Must remain the first member so the default release callback can pass
>> +	 * the fence directly to dma_fence_free().
>> +	 */
>>   	struct dma_fence base;
> TBH, I don't like this trick. container_of() is there for a reason. Even if
> it's the first member in the structure. Can we simply switch to RCU version?
> Would it require big changes?
>
>> -static void iio_buffer_dma_fence_release(struct dma_fence *fence)
>> -{
>> -	struct iio_dma_fence *iio_fence =
>> -		container_of(fence, struct iio_dma_fence, base);
>> -
>> -	kfree(iio_fence);
> So, we can't use dma_fence_free() here, because without above guarantee it will
> get a wrong address. Maybe (maybe!) as a quick fix this is fine, but in long
> term can we also have a refactoring patch that drops above comment at the end?

I also think the container_of version is cleaner, but I checked all the 
other implementations and 18 out of the 20 dma_fence implementations use 
this same schema of just letting the default release handle it even when 
embedding the struct, so it seems to be the consensus that this is the 
way to go.

