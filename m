Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E00B22FE11;
	Sat, 14 Feb 2026 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771105764; cv=none; b=KijjZNLg12b90BFeCZqyAPRgBIrOluXFRxEbUY5u9aNKikmw4i2l4namFysmnJY1KPGDOmOG6Ztaz0HxN4QqIa9zk8l4GxLzWzaj0tbGwqqmhQV7RynOS/xtWVv47V3eoLGLE2gtjQUsA/AgUS3ct/tP+i4hQK/GJ7VH4Sq/0Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771105764; c=relaxed/simple;
	bh=vj05nLtQb7DrjERJOyo3kRE/GUvlOdE47Hus2HioXtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tsVvMPjIlU0s0JATzyyRGjeVuzcmdEkqnhM4wsmjdIHwmy4UaHqXrqTrHjGpxkg0wZdwKoZP3RJsEhlonDMU02yMeGcnp2YFibQfy+hq5h6j8AvonwrfFbmQWE1MCpIaHX1AjZKVgZtc9c5vvNL+Qw1A//48PtrOXjGgVvJbkec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XY6X4pdA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XY6X4pdA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=i7A2tZ9yUt1THaiXwiZeIYfWekSAu4mB39tfmge43xo=; b=XY6X4pdAmyz/1k+orPz1Ywsxf8
	zJpyzIGRjlDx0XAUlNTiY8/qB2xSIJC9dYIqyfq/7dPcla8+18b4gA5SZMhu5EncNh0hP1B3TxfRk
	C+6sQPXMXuA4D7e8braMbB2ol4ai7tvLk9w52yhY2ZjXqfpbGI4eBR/I4NgsGbxAXXbwt/PgSB3cg
	NdCqOZw19Ffn7wd51X62HTL7FlQWcuoQYLTbkWYcjNLAf8WyFsPGbaRMIqIJBRvnqBJB2nWyMRBmN
	kp246nl2L7eLSz3nIvJgQc/tGN7VLALtec/JZyWkZGp8tXpN4WSwvWKjoinLXNN5wrc/+DkgWbEyY
	OlCiVt5g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrNVn-00000004yDs-2vLL;
	Sat, 14 Feb 2026 21:49:11 +0000
Message-ID: <3bcbd428-2314-4b01-b846-2ab2572d9d5d@infradead.org>
Date: Sat, 14 Feb 2026 13:49:10 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] iio: accel: adxl345: Implement event scaling for
 ABI compliance
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 David Lechner <dlechner@baylibre.com>
Cc: Taha Ed-Dafili <0rayn.dev@gmail.com>, jic23@kernel.org,
 skhan@linuxfoundation.org,
 linux-kernel-mentees-archive@lists.linuxfoundation.org, nuno.sa@analog.com,
 andy@kernel.org, corbet@lwn.net, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260208150515.14798-1-0rayn.dev@gmail.com>
 <20260208150515.14798-4-0rayn.dev@gmail.com>
 <af774bb9-817d-4d88-9fe3-54468949ea54@baylibre.com>
 <aZC9Xurq1KcVHuMT@smile.fi.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aZC9Xurq1KcVHuMT@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/14/26 10:22 AM, Andy Shevchenko wrote:
> On Sat, Feb 14, 2026 at 11:02:22AM -0600, David Lechner wrote:
>> On 2/8/26 9:05 AM, Taha Ed-Dafili wrote:
>>> The ADXL345 uses a fixed threshold resolution of 62.5 mg/LSB for
>>> event-related registers. Previously, the driver reported raw
>>> values without a scale factor.
>>>
>>> Implement IIO_EV_INFO_SCALE for all event types to provide the
>>> conversion factor (0.612915 m/s^2) as required by the IIO ABI.
> 
> ...
> 
>>> -			BIT(IIO_EV_INFO_ENABLE) |
>>> +			BIT(IIO_EV_INFO_ENABLE)	|
> 
> What's the difference here?

Space replaced by Tab just before the ending '|' character.
An undesirable change.

> 
>>> +			BIT(IIO_EV_INFO_SCALE)	|
>>>  			BIT(IIO_EV_INFO_VALUE),
>>
>> Would be nice to be consistent and put scale after value as the ones
>> at the end.
> 
> Would it be better other way around to avoid unneeded churn with touching
> the last line?
> 

-- 
~Randy
