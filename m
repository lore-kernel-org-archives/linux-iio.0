Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795179216;
	b=aVqp3/NolyHb4yXPkPRthigDycHyQvzXUr/K268Du/sTmV4gjwmU3o2Krlf/W4iOsGFU
	 RCR2AGQA+rixPLk0DitSij33afZ6iFp9u5UFAzYphvTaKXOIMGRHSqqeJGEtiOed2P9Bl
	 IuRNsrTtbdkW9Gu3o9mke3+cimzMlEnDdcWCoj7lIEkwBjCRsQnygZ7APkFxSWr8UBYGE
	 ts7l00zj2HV9MTWUO28rmDluplr8KPB9XNvNqw3GnKgjD1CVPDPoddOFz//WG9DylaVx1
	 yPKLxkLmfSXUiW8VS74MdemiH7+whiXWyQDw9aQFdW0cbHdlMis+NFD+o7Ozo7ZgKgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795179216;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Reply-To:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=hqAp3aogFicWpFXmWI6PTjNQ7PiDIl2sevW1eEL/NdU=;
	b=ee1RsuVlp6cVatXlBpAceP/nVShSzgkXkwNkK/gM8FBtVgtDNNIlmy9nx+p2Hj19cDPK
	 N1mojmcLNHjtV8AKK+o/k7rg9ceULkOFP/FyFcwVrPlmtuMW5f5K1lIDm1dU2HSiB3x9J
	 VEuWS8RK3lfROoMwwu/L3jY9nS3YZ6ORjYhGQC4fuUQqMotR+3yqgVaSPTCSnVhSji6q+
	 jsvyevtNx4Wpf4ymd8/AZSu04Eetbc0Zd289WuK0ATnCg9Bdz6Zldbd7EX99vR9U5i5zV
	 iPwT68hRVNcUZ8du78uGrXukAqiFnID+kWEkq+D05CqbhxnSzd7T99PQhs3Yj1XvUFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=g9CzoL72;
	arc=none smtp.remote-ip=95.215.58.52
Received: from mta1.migadu.com (out-52.mta1.migadu.com [95.215.58.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66EB60A2601
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 12:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C66EB60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=g9CzoL72
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bPIA0sNfCRcFRI1GyKLxje7bW0QtBZXlMKzBREPclIM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795179214; v=1; x=1795784014;
 b=g9CzoL72GL87X07ZDpf/309ifaOyhUVbKxZAgv4A4U1ytuHs2Xk9gA5mWlkxAaGP4OnauL6Y
 ef2n2zB4RxRiDK4b5AoXPG+3n6Uglik3OU11BmzulTS48ZusJ/uLWw1+S2SSDrS0uMTC6/BwaLf
 6dCBEAcdI5n7FWYb/iuTI3dA=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 78a15bc928d8e3f7;
	Fri, 20 Nov 2026 12:53:34 +0000
X-Mizu-Trace-ID: 78a15bc928d8e3f7
X-Migadu-Flow: FLOW_OUT
Message-ID: <d2d8049d-7adc-4cfb-8e56-3af55c0abe8f@linux.dev>
Date: Fri, 20 Nov 2026 14:53:32 +0200
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: mazziesaccount@gmail.com
Subject: Re: [PATCH v2 3/3] iio: adc: rohm-bd79112: Support ROHM BD79111
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 Jonathan Cameron <jic23@kernel.org>, open list <linux-iio@vger.kernel.org>
References: <cover.1795176984.git.mazziesaccount@gmail.com>
 <4be17e339f768da93db2f42abd3cc5a21fea01ad.1795176984.git.mazziesaccount@gmail.com>
 <sashiko-outbox-225147@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <matti.vaittinen@linux.dev>
In-Reply-To: <sashiko-outbox-225147@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/11/2026 14:34, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Low] iio: adc: rohm-bd79112: double semicolon in bd79112_probe()
> - [Low] iio: adc: rohm-bd79112: unused BD79112_MAX_NUM_CHANNELS macro
> --
> 
> commit d2b6757018d5ccee4c939ad0350d93a29d26239d
> Author: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> iio: adc: rohm-bd79112: Support ROHM BD79111
> 
> This commit adds support for the 16-channel ROHM BD79111 SAR ADC and GPIO
> device to the rohm-bd79112 driver.
> 
>> diff --git a/drivers/iio/adc/rohm-bd79112.c b/drivers/iio/adc/rohm-bd79112.c
>> index 04084e88984a5..8bbb86098ff5a 100644
>> --- a/drivers/iio/adc/rohm-bd79112.c
>> +++ b/drivers/iio/adc/rohm-bd79112.c
> 
> [ ... ]
> 
>> @@ -431,8 +458,17 @@ static const char * const bd79112_chan_names[] = {
>>   	"AGIO12B", "AGIO13B", "AGIO14B", "AGIO15B",	/* 28 - 31 */
>>   };
>>   
>> +static const struct bd7911x_chip_data bd79111_chip_data = {
>> +	.name = "bd79111",
>> +	.chan_names = bd79111_chan_names,
>> +	.num_max_channels = 16,
>> +	.init_disable_gpios = bd79111_disable_gpios,
>> +};
>> +
>>   static const struct bd7911x_chip_data bd79112_chip_data = {
>> +	.name = "bd79112",
>>   	.chan_names = bd79112_chan_names,
>> +	.num_max_channels = 32,
>>   	.init_disable_gpios = bd79112_disable_gpios,
>>   };
> 
> [Severity: Low]
> This isn't a bug, but replacing the remaining uses of
> BD79112_MAX_NUM_CHANNELS in bd79112_probe() with
> data->cd->num_max_channels leaves the BD79112_MAX_NUM_CHANNELS macro
> unused.
> 
> [ ... ]
> 
>> @@ -509,7 +545,7 @@ static int bd79112_probe(struct spi_device *spi)
>>   		cs[i].datasheet_name = data->cd->chan_names[cs[i].channel];
>>   
>>   	iio_dev->info = &bd79112_info;
>> -	iio_dev->name = "bd79112";
>> +	iio_dev->name = data->cd->name;;
>>   	iio_dev->modes = INDIO_DIRECT_MODE;
> 
> [Severity: Low]
> This isn't a bug, but there is a double semicolon at the end of this
> assignment.
> 

Both of the Sashiko's findings seem correct. However, I wonder why it 
picked the device-tree folks and dropped IIO people? This particular 
patch didn't have binding changes but driver changes. (Well I added 
Jonathan + IIO-list here)

Yours,
   -- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
