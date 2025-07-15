Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9B32528F7
	for <linux-iio@vger.kernel.org>; Tue, 15 Jul 2025 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594434; cv=none; b=LnSwH91+4rLg+r6vO8z7InvU8SqsnSDGWT1AXJzbRYzkOPON+2csQXJBbSAxL1gtC6UeqCZ9kUgwpQBL792oWYmAiBAkYZy+0p6orvVYf6yp2EEZhqCdeMVK9aYl9zvmt2rKklAlrnKJRxD7ao65yLuRXUha4bBbyiIw6Wg0KBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594434; c=relaxed/simple;
	bh=vi8S8ruRTzetJaP8Ue9rb3bWnQc963nj7RGuYulfYp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLPKqFtOLE+8WsbUlxdxqpchv//AlL4f30xFW+lJgpx5E6wlaZJOiJfrKWj3bTJopqndM+IAb8U2tWM1ITIP2oeO1oeYcueJboQGlMzjJ7o9BtFui77jf9dqKJNAEUClRdX2xYD8CtR5RSY4aYxqq7kTjhScVIj7g8uV0mlGq3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vmykJ1kj; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vmykJ1kj"
Message-ID: <80ed9b12-ba0a-4d1a-bd54-122218edc8a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752594430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LiyMJqsKhGS3GFgkxGf+pcdN8gMjr5AqwKeJZu1dOaQ=;
	b=vmykJ1kj50u6RklubpTnVIJqmft4MIoX3So+wK0Ivm1/XhsfiYwE1c6Coli692WKQwCDGv
	jlhlf1AW9iBIC904eZpc0JT1oluiVs8NZLnUJLISFWhbjA/42kTl3PpoJFfycPzGLeQDL7
	PvXHGggrfrWfGdai5cmn/WT3LywO0VI=
Date: Tue, 15 Jul 2025 11:47:07 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/7] iio: Add in-kernel API for events
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-4-sean.anderson@linux.dev>
 <aHYPYZgq17ogdEgC@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <aHYPYZgq17ogdEgC@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/15/25 04:20, Andy Shevchenko wrote:
> On Mon, Jul 14, 2025 at 09:20:19PM -0400, Sean Anderson wrote:
>> Add an API to notify consumers about events. Events still need to be
>> enabled using the iio_read_event/iio_write_event functions. Of course,
>> userspace can also manipulate the enabled events. I don't think this is
>> too much of an issue, since userspace can also manipulate the event
>> thresholds. But enabling events may cause existing programs to be
>> surprised when they get something unexpected. Maybe we should set the
>> interface as busy when there are any in-kernel listeners?
> 
> ...
> 
>>  #include <linux/wait.h>
> 
> While at it...
> 
> + blank line here...
> 
>> +#include <linux/iio/consumer.h>
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/iio-opaque.h>
> 
> ...and here?
> 
>>  #include "iio_core.h"
> 
> ...
> 
>> +	struct iio_event_data ev = {
>> +		.id = ev_code,
>> +		.timestamp = timestamp,
>> +	};
> 
> ...
> 
>>  	/* Does anyone care? */
>>  	if (iio_event_enabled(ev_int)) {
>> -
>> -		ev.id = ev_code;
>> -		ev.timestamp = timestamp;
>> -
>>  		copied = kfifo_put(&ev_int->det_events, ev);
>>  		if (copied != 0)
>>  			wake_up_poll(&ev_int->wait, EPOLLIN);
> 
> Looks like this refactoring can be done before main change.

I think it is clearer to keep this in the same patch as the
functionality that uses it.

> ...
> 
>> +	WARN_ON(atomic_notifier_chain_unregister(&ev_int->notifier, block));
> 
> Is bug.h already included?

I assume so. No build errors.

--Sean

