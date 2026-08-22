Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4BF171B1;
	Sat, 22 Aug 2026 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787422755; cv=none; b=OgvlvqGDlNZDBRBMoVPgue+f8V35aZXy5ivg6yZCksueWaD4NIPB1fJo8tl/DBHOglMTlv9QuMjnbblCb48cQKPuX/4VBgaFMkMY+7G58f5DEaQ/tQ1bmdomtv/yYpcEx+U2ZdfsSgIG7dPvlE0+lBWiJARyb0Cdv7wTPUYT6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787422755; c=relaxed/simple;
	bh=IEYgSlGBnDDYz7I78VepGc27Kxxw+G4uS+TnoU7hQZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KD/U5vO0wjYc/IEmbWNFj7Kl27hD+Iu0lfvOGqVL3X9Ds03Uae4ODnP7y0Oc64eKilR/3bYBRCsmwYrgKf1IR1+wFlU9zAYMq4RKW9PPo1bdFS7mBWMg0zRXyLWIp8EgGxzoS3TPXuxGV1QG2zoTvAlF8/YEuu40FdMOej1sVTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B8BEFVfk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B8BEFVfk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=5NyI3Iu7oOAbcFVPtEns5aDFxu7HjafPsajI1mxsec4=; b=B8BEFVfk8PSXpae7Ctxu11gf96
	48DXWLJUIqVjGZU5cCONrFEGxLfKyTXi52XqjIdp75zc2SwAo2DCRRuJK46XUis6+2ERruwtIIJGC
	rKuT6Wj+owXZyILfO/VonTMCP+BQDYrzNjIZBPUbxeuxAHQHMR1GZUWFxoNplbUGuWaVeKmB+UNAu
	C4kXXmtPk6ABiLg6AlhFFUcT1/ANuSWuQZXgubVgURVcq+pkvnn2iksIIqwQQEq9m9uHzOeBIJ//R
	cy1gaKpA0lv30WcMA4B374Mz8KlHTCmwWwt0WkYP3WvODxzECqhNQfJQXoYJYL95IfU7LjpR0o/Ox
	xGIzMgJg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxqJC-0000000EiHs-1a6u;
	Sat, 22 Aug 2026 18:19:10 +0000
Message-ID: <1c0ea889-3a06-4691-a759-0cff624ccc92@infradead.org>
Date: Sat, 22 Aug 2026 11:19:09 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: iio: Correct ADXL380 filter descriptions
To: David Lechner <dlechner@baylibre.com>,
 Karl Mehltretter <kmehltretter@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260822073653.54545-1-kmehltretter@gmail.com>
 <a1eb791e-64b5-4602-8b5f-afe1ac15b7db@infradead.org>
 <32545533-b792-41a9-91e0-5353112cbb62@baylibre.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <32545533-b792-41a9-91e0-5353112cbb62@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/22/26 11:07 AM, David Lechner wrote:
> On 8/22/26 12:00 PM, Randy Dunlap wrote:
>> Hi,
>>
>> On 8/22/26 12:36 AM, Karl Mehltretter wrote:
>>> The high-pass attributes were described as low-pass filters and vice
>>> versa. Correct all four descriptions.
>>>
>>> Fixes: b6a097a9af00 ("docs: iio: add documentation for adxl380 driver")
>>> Assisted-by: Codex:gpt-5.6-sol
>>> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
>>> ---
>>>  Documentation/iio/adxl380.rst | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/iio/adxl380.rst b/Documentation/iio/adxl380.rst
>>> index 654d4c0e84a19..a1c249dc2e51c 100644
>>> --- a/Documentation/iio/adxl380.rst
>>> +++ b/Documentation/iio/adxl380.rst
>>> @@ -39,13 +39,13 @@ specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
>>>  +---------------------------------------------------+----------------------------------------------------------+
>>>  | in_accel_scale                                    | Scale for the accelerometer channels.                    |
>>>  +---------------------------------------------------+----------------------------------------------------------+
>>> -| in_accel_filter_high_pass_3db_frequency           | Low pass filter bandwidth.                               |
>>> +| in_accel_filter_high_pass_3db_frequency           | High pass filter bandwidth.                              |
>>>  +---------------------------------------------------+----------------------------------------------------------+
>>> -| in_accel_filter_high_pass_3db_frequency_available | Available low pass filter bandwidth configurations.      |
>>> +| in_accel_filter_high_pass_3db_frequency_available | Available high pass filter bandwidth configurations.     |
>>>  +---------------------------------------------------+----------------------------------------------------------+
>>> -| in_accel_filter_low_pass_3db_frequency            | High pass filter bandwidth.                              |
>>> +| in_accel_filter_low_pass_3db_frequency            | Low pass filter bandwidth.                               |
>>>  +---------------------------------------------------+----------------------------------------------------------+
>>> -| in_accel_filter_low_pass_3db_frequency_available  | Available high pass filter bandwidth configurations.     |
>>> +| in_accel_filter_low_pass_3db_frequency_available  | Available low pass filter bandwidth configurations.      |
>>>  +---------------------------------------------------+----------------------------------------------------------+
>>>  | in_accel_x_calibbias                              | Calibration offset for the X-axis accelerometer channel. |
>>>  +---------------------------------------------------+----------------------------------------------------------+
>>
>> These changes LGTM. Thanks.
>>
>> Although I am a bit confused. When I look at the adxl380 driver,
>> I don't see any of these device attributes.
>> The attributes with these names are in other drivers/iio/accel/
>> drivers: bma180.c, mma8452.c, and sca3000.c
>> Can someone try to explain this, please?
>> thanks.
>>
> 
> The attributes come from:
> 
> 	.info_mask_shared_by_type =					\
> 		BIT(IIO_CHAN_INFO_SCALE) |				\
> 		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |	\
> 		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),	\
> 	.info_mask_shared_by_type_available =				\
> 		BIT(IIO_CHAN_INFO_SCALE) |				\
> 		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |	\
> 		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),	\
> 
> in adxl380.c

Thanks, David.

for the patch:
Acked-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
