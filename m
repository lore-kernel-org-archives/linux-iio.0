Received: from h4.cmg2.smtp.forpsi.com (h4.cmg2.smtp.forpsi.com [185.129.138.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A808137188F
	for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.129.138.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773589754; cv=none; b=GZMuKY6xWdXmzVq1z/NeLkhP67AABAnsRcaRf53bT2Ggvu9ugRArt7N/wy6GFq3vtnMH3Yywq7q3hZG1l4WEcJ7nDfIBwb7sdLIowqKDgMZiFEGZHl/3rshBjwNoNmy2/pUS/n5Ki4/OVW3ivO+BcTQ9jl4wOiv4sXr5URanaqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773589754; c=relaxed/simple;
	bh=DS5fAJmSagGV5I3a2r7KGz9rr3MADHGT4Pr+YJcGV2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTV6whyduWXlmqXFQCcy8bSdGvvKbjlIm9uoCX0wjyeoA7ReVnhpfadnSfvkeImOX8s3i19X5smgVDtJJikPNaJlwNAtzU+anvetj7H1YABnR4aeQ+2xZheqCvbNM0wkMW7ocr6gWWhYWR2fSRAvzUw67IglMhRXJSjaVBJQAyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu; spf=none smtp.mailfrom=skyrain.eu; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=p9vYhCQo; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=p9vYhCQo; arc=none smtp.client-ip=185.129.138.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=skyrain.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="p9vYhCQo";
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="p9vYhCQo"
Received: from [192.168.10.89] ([178.143.46.35])
	by cmgsmtp with ESMTPSA
	id 1nV1wgw61Ua1j1nV1wfpoD; Sun, 15 Mar 2026 16:35:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1773588929; bh=+LSRwNflTqHENGZ3zOh6zVSGkXZUbJ8F/8kZ9iOM9Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=p9vYhCQontIRpE36eT2o5w2jTFMZpKc8RPj5+2QSBB3tgkuaURCmie3ZHF7fREBse
	 5ZHlC9r9NHv2qo/et4hspQpLta1YaFziIygen+LDw2C1p0yzcUDZAA2zpbIZfeKanZ
	 JTRrj12sEoT+sp9DEiCjtm1YfNM3745nCnaHwFKLQHvA0y0igUFIU67318Ln7mw4wp
	 EJbM105yb7w7myF37oZTzxW/qGfRn5tEIq7Hm+r5U1DAJSNomcAAQ2Lr2QHFJhGt5g
	 AeoHV66kTvwHzCShpb4AU5NI6uf3KfCXmP2PkDUr5qsq1JAxoV4+946714x5HCUYKL
	 jfwmJXHfJJUPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1773588929; bh=+LSRwNflTqHENGZ3zOh6zVSGkXZUbJ8F/8kZ9iOM9Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=p9vYhCQontIRpE36eT2o5w2jTFMZpKc8RPj5+2QSBB3tgkuaURCmie3ZHF7fREBse
	 5ZHlC9r9NHv2qo/et4hspQpLta1YaFziIygen+LDw2C1p0yzcUDZAA2zpbIZfeKanZ
	 JTRrj12sEoT+sp9DEiCjtm1YfNM3745nCnaHwFKLQHvA0y0igUFIU67318Ln7mw4wp
	 EJbM105yb7w7myF37oZTzxW/qGfRn5tEIq7Hm+r5U1DAJSNomcAAQ2Lr2QHFJhGt5g
	 AeoHV66kTvwHzCShpb4AU5NI6uf3KfCXmP2PkDUr5qsq1JAxoV4+946714x5HCUYKL
	 jfwmJXHfJJUPw==
Message-ID: <25c766b7-d66a-4638-9995-b5936ca87b7a@skyrain.eu>
Date: Sun, 15 Mar 2026 16:35:27 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: accel: fix ADXL355 temperature signature value
To: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, puranjay@kernel.org,
 jonathan.cameron@huawei.com
References: <20260313092413.35912-1-andy@skyrain.eu>
 <a2e56b5c-ef76-4a6a-9ffc-e8fe259a7153@baylibre.com>
Content-Language: en-US
From: Andrej Valek <andrej.v@skyrain.eu>
In-Reply-To: <a2e56b5c-ef76-4a6a-9ffc-e8fe259a7153@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCnshegdq9iX5FRQ69XFplU+pqev1sxF4PDE/HUNtXGNSf1CwZHSFkjbID8irn3Zq3pgVEpZVmCp0i41ajysk1rMJYGTYdTix1QLZgnHJv7DCm43+b1Q
 6J4T2V618/SSoajzJ1jgDzxeCyFTtD5dpbETKgrzzcWGLeYMbd+qpiOm+w/Rw2EzdRbFqKuw+7rhMbK9JRAMRip0U/MdbTR7W3DDfUgzeekuQQrdOHiYdW7T
 9wt5KceSqUtBpi06MASurA6kzVX1vm1Uan2mFqqv92ibuyohRVOsB/md3hPfEpifUIvfmmOY35YtIyE5PBQg9698MfaL/kdLiOw2C4Es0wRus/zzyFkddLDc
 29lSTH+03QU4Tyn+AqEbBzCR+SEZSw==

Ah, I see, I described it wrongly.

On 14.03.2026 21:22, David Lechner wrote:
> On 3/13/26 4:24 AM, Andrej Valek wrote:
>> From: "Valek Andrej <andrej.v@skyrain.eu>"
>>
>> Temperature was wrongly represented as 12-bit signature, confirmed by DS.
> signature == signed integer?
Correct, temperature is wrongly represented as signed 12-bit number, 
while it has to be unsigned.
>
> DS == datasheet?
Yes
>
>> Even if the temperature is negative, the value in the register stays
>> unsigned.
> And IIO_CHAN_INFO_OFFSET will be negative.
Not sure what do you mean by this. I can only say, that output type was 
"be:s12/16>>0" and should be "be:u12/16>>0". So when some upper layer 
wanted to represent the number it "overflowed", while the bits have been 
masked.
>
>> Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
>> ---
>>   drivers/iio/accel/adxl355_core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
>> index 1c1d64d5cbcb2..8f90c58f41008 100644
>> --- a/drivers/iio/accel/adxl355_core.c
>> +++ b/drivers/iio/accel/adxl355_core.c
>> @@ -745,7 +745,7 @@ static const struct iio_chan_spec adxl355_channels[] = {
>>   				      BIT(IIO_CHAN_INFO_OFFSET),
>>   		.scan_index = 3,
>>   		.scan_type = {
>> -			.sign = 's',
>> +			.sign = 'u',
>>   			.realbits = 12,
>>   			.storagebits = 16,
>>   			.endianness = IIO_BE,
>
>
Conclusion = Should I send a new version with "fixed" description?

BR,
Andy
