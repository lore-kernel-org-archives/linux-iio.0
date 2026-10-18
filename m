Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAA2395AE9;
	Sun, 18 Oct 2026 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.31.26.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792334514; cv=none; b=VTHqzJiXewdSvCcx7Fqcd2qqyESe+ES6pkReM8/Zyak5BjK2o6Gm8cxFCkZd+4d9VHHxwJdaALNZLNBNQZO3ZwaftwFSgDAWFoePf+h0Oq4cPnyzlTAgmNr96ycJA6DG+75Esx/qu+xNoM8dKJeTjXXRmA3tXnAJaWzjbES2AEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792334514; c=relaxed/simple;
	bh=I8YIf9ANv7QI9uSBcR+pF8moTHqSyO/0vMnlBczzJpE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WwhASvNdxi5ObdLfTFbjUR05aG/RkrEMIdeuDcXqVgESiC6zAkIv1F8dTbkCfRWstdsb63+1Noq4nqHm+KNZwNyInH9KnTk+WXMeAYxGLo2zocd7C54D2puUpT9zKIOJPy7r578NYBpZDFcMLk3pCS2Z1nAeAX08+e93ZshkSF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com; spf=pass smtp.mailfrom=rudorff.com; arc=none smtp.client-ip=193.31.26.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [IPV6:2a02:3102:b60c:d00:92f6:52ff:0:bd0] (dynamic-2a02-3102-b60c-0d00-92f6-52ff-0000-0bd0.310.pool.telefonica.de [IPv6:2a02:3102:b60c:d00:92f6:52ff:0:bd0])
	by rudorff.com (Postfix) with ESMTPSA id 1BD87402D1;
	Sun, 18 Oct 2026 16:41:49 +0200 (CEST)
Message-ID: <d06d51cf-a53d-4bef-881e-cdcb4925a316@rudorff.com>
Date: Sun, 18 Oct 2026 16:41:48 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "chr[]" <chris@rudorff.com>
Subject: Re: [PATCH v2 2/3] iio: light: gp2ap002: add led power supply
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20261017-iio-light-gp2ap002-v2-0-d6879767a446@rudorff.com>
 <20261017-iio-light-gp2ap002-v2-2-d6879767a446@rudorff.com>
 <20261017190006.224b73e7@jic23-hlaptop>
Content-Language: en-US, de-DE
In-Reply-To: <20261017190006.224b73e7@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

In preparation of v3:

Am 17.10.26 um 20:00 schrieb Jonathan Cameron:
> On Sat, 17 Oct 2026 19:27:42 +0200
> Christoph Rudorff <chris@rudorff.com> wrote:
> 
>>   	/* VIO should be between 1.65V and VDD */
>> -	ret = regulator_get_voltage(gp2ap002->vdd);
>> +	ret = regulator_get_voltage(gp2ap002->supplies[SUPPLY_VDD].consumer);
> 
> Ah. I'd failed to register the voltages were being manually set (generally
> we leave that to firmware in more modern drivers).
> That rather reduces the advantage in using bulk regulators.  Probably
> still just about worth doing.
>

Yes, this is why I didn't made it in v1.

> 
>>   	if (ret < 0) {
>>   		dev_err(dev, "failed to get VDD voltage\n");
>>   		return ret;
>>   	}
>> -	ret = regulator_set_voltage(gp2ap002->vio, 1650000, ret);
>> +	ret = regulator_set_voltage(gp2ap002->supplies[SUPPLY_VIO].consumer, 1650000, ret);
>>   	if (ret) {
>>   		dev_err(dev, "failed to set VIO voltage\n");
>>   		return ret;
>>   	}
>> +	/* LED voltage 2.4V .. 3.6V according to datasheet */
>> +	/* We need to check this, as dummy or fixed controllers trigger an error. */
> I'd make that a multiline comment and say what 'this' is.
> 	/*
> 	 * LED voltage 2.4V .. 3.6V according to datasheet
> 	 * We need to check control is supported, as controlling dummy or fixed
> 	 * controllers results in an error.
> 	 */
> 
> Do you actually need to control this for your board?  I'm not that
> keen to replicate the controlling of voltages if we don't have
> to.  We can't drop existing code as maybe a board is relying on it
> but we can avoid adding new examples!
> 

So we don't want to drop all the set_voltage code in general.
My board does not need that at all, all voltages are already set
to valid values in DT, ... I hope ... I check downstream ...

So I skip the "example" for set_voltage(vled)?!

And thanks for the advice to pretty up the code!

chr[]

>> @@ -632,9 +650,8 @@ static void gp2ap002_remove(struct i2c_client 
*client)>>   	pm_runtime_get_sync(dev);
>>   	pm_runtime_put_noidle(dev);
>>   	pm_runtime_disable(dev);
>> +	regulator_bulk_disable(NUM_SUPPLIES, gp2ap002->supplies);
> 
> Why at that point in sequence?  You are turning the power off
> before removing the userspace interfaces which seems unlikely to
> be race free. More generally it is no longer reverse of probe
> order. If that is necessary for some reason I'd expect a comment
> to say why.
>

Sorry, just a stupid mistake.

>>   	iio_device_unregister(indio_dev);
>> -	regulator_disable(gp2ap002->vio);
>> -	regulator_disable(gp2ap002->vdd);
>>   }
> 
> 

