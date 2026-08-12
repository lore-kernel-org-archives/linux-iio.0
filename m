Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E33B44D035
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542022; cv=none; b=eG/6dxVSRylSRXRV9Gl8OGJE5dMNV8c7J8Z+IDXuEY6EPzJnohedHJ6orH8u1Ic4FiY8vEHRBZM5o57zvyKPeI9OGOM6yZ7DaYSR2yALmj08JgGemx7RaUE4877H6dSrN+y31IYF3a+SScmlB6/9+x3we3UBjTS4FADyeGlN2WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542022; c=relaxed/simple;
	bh=Yp2oRgRlHLK5S6oFnlyMQg7hEjEr5DC8Y6ykHGauOQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWp56YUDLD9Sn6qZA13RlwQfQArWN3zF8hnCfSFSIMBdmocaTczMJk2q5jtDc1hIuWsryT2UirQb8E0I6DUdiKvbG/plethfQiueMH/ixiv/FsvUPRxPv+ng4wU3vsLemZIbxatfts+1KFG9AHPbrd7ql7xEXtQa56IOxcXK5hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=KuYoRDzE; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="KuYoRDzE"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-448b69cfc6dso1069794fac.3
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 06:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786542017; x=1787146817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3m/mAJLnKMaOtoiImwSaVIw0nteRIaUTkKOvX93AqPM=;
        b=KuYoRDzEwL4PLALIl5YDeM+Ss0GYokunxQqXZlzOz6dGYO3Fy1YgftesXLbaMqjZ2g
         kZmWap+0y/mjsGUlq+JP3iJiFxdjwXHYqZTFovc+Z1clywebjWCs/zB3IG/S32ro6qmw
         LEb3/1ieoLnuz7H9tbF0FjJMDgKbtb1CWUQz+jXOLuGEVgETKeedrlczKQTtU/Z6+0KQ
         Z/3g7/qirYN8G1DGnEqgDCEUigohrfD0p6SmRWR/j71trki9+iMm8RTpPAiH65M1yRz/
         YnBmt0dvMbAqEBWfq+qpbxYc/LD7a7wUuRj89w7y0SSjK0upk3tJVypAWE2/GcDDzgyA
         8zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786542017; x=1787146817;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3m/mAJLnKMaOtoiImwSaVIw0nteRIaUTkKOvX93AqPM=;
        b=bRhJy7A46WVygDy3eE7cqRI0M2qyEuej97oUdsFRWuuSjYj+IwnJ66I7vDB0ktGrmb
         yRhaWRjNjJycO4l//zL7q+4TcVytd9D/VlqTrIqBJL73QUAkWqpXf/i2SPzmvCv+fjfm
         IBgeIRNyY2PIDwfSZBrllDRle/nA3vNC2BZywEBDLUQucNE6cA5tmlkVNOxM9hOnMSoO
         8sjK+OkQQyi62XjNWdEI7duo7bT0Tvx0BNjvSlmjB+xflZTAWx6OBhIZoR19EJNBvx2y
         HDf8Db+W6FQujmQAOXDCXvhDMYI8cfjkdXCJm7sS9ddew2bDQdH8SwDH4JR4oh3WT2qZ
         vTSQ==
X-Forwarded-Encrypted: i=1; AHgh+RrNx3xFwfjD9MR+p88bGeLYGCE2CT7braVJs/yyJthK1a6OA7OP6rCTsW/ekIU+2kjWIG5sdpNfpio=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJEVsxU6QumiPyay3LoIimZS1JIyd6ks8Oudn+ywOKqUXOpJ5w
	enQEFSX8Tq++NZaRmZT790jfJMuZOizzVs+/mmZ+sFQE9Gc/K+H2lFqk2XkDyGkVDh0=
X-Gm-Gg: AR+sD10RhWExN4iY/U3tjspb2EI/IrU0YxpzPaE4bzme3xnoLk13Yvbno2kkE0ANf3a
	GTwakFYsUHiEVb0lIPsI5Im5oRWEP6GdfOlRMYr00STGh5FbsBpGFy+fziD0KzbvzrqXBOgVP0V
	0Yj+BwVIax2g3JTMgEGYK4AoT1krlaIXQbf/r2kuCphO/6dc3mtcvnAifaFwX94sLTfcfxYOmxw
	jVBST05OKG7o5jDukdDzhgIrH/D8UHW++MR7WtRXEbC/7ii2oqEiLPGufIqteel7LgxsQn8FXM9
	9qnzXGWAMX5xRETSjzu+7KxP1lB3iQPauXWfxsMGD6+kn6JLsa4T2Loidhm1bNWuGesKVZmCNnn
	VPBSs9J6p/RgCSDTY7K/2HOmml1W/xtsR/giDYLRNqOJ7gdMG8DeNcpLNmWdwx+PUdD1PtFdHAR
	s6MvJ3hGpgpV/9NGqIZCUwpiUJBrvjk+1olVYCzagX9if1/gjNA/+wBGHoa5PuRq3ujL5SBsWOg
	WFfyoSKqbRDEw45gYXuj6U0RJyQe0Op7ud8a/E=
X-Received: by 2002:a05:6870:c267:b0:456:4c3f:7e03 with SMTP id 586e51a60fabf-45e3ea95283mr4055401fac.18.1786542017417;
        Wed, 12 Aug 2026 06:40:17 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:76d8:83ff:449f:8518? ([2600:8803:e7e4:500:76d8:83ff:449f:8518])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45e35173939sm1812914fac.8.2026.08.12.06.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 06:40:16 -0700 (PDT)
Message-ID: <a30efc8e-22a4-4573-93c7-e1a4689d3a3b@baylibre.com>
Date: Wed, 12 Aug 2026 08:40:16 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] iio: adc: add the ti-ads1262 driver
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
 <20260807-ads126x-v3-2-f89925d72792@gmail.com>
 <ad95afb4-e667-4290-8878-fdd7067f20fe@baylibre.com>
 <DKK9QWYHOBOT.2VD8XMZTE65H4@gmail.com>
 <7a42a318-780d-4bd0-baf1-55d030b39233@baylibre.com>
 <DKMECOTJYOZE.3AEGK7RWPH7FW@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DKMECOTJYOZE.3AEGK7RWPH7FW@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/26 3:28 PM, Kurt Borja wrote:
> On Mon Aug 10, 2026 at 11:42 AM -05, David Lechner wrote:
>> On 8/9/26 3:26 AM, Kurt Borja wrote:
>>> On Sat Aug 8, 2026 at 1:39 PM -05, David Lechner wrote:
>>>> On 8/7/26 10:58 PM, Kurt Borja wrote:
>>>>> Add the ti-ads1262 driver with initial support for the primary ADC
>>>>> (ADC1). The ADS1263 auxiliary ADC (ADC2) is handled by a separate driver
>>>>> and interoperability considerations were taken into account.
>>>>
>>
>> ...
>>
>>>>> +static int ads1262_dev_reset(struct ads1262 *st)
>>>>> +{
>>>>> +	int ret;
>>>>> +
>>>>> +	if (st->reset_gpiod) {
>>>>> +		ret = gpiod_set_value_cansleep(st->reset_gpiod, 1);
>>>>> +		if (ret)
>>>>> +			return ret;
>>>>> +
>>>>> +		/*
>>>>> +		 * The RESET pulse timing requirement is 4 clock cycles, at the
>>>>> +		 * minimum clock rate this is 4 microseconds.
>>>>> +		 */
>>>>> +		fsleep(4);
>>>>
>>>> How long do we have to hold reset before the chip powers down?
>>>
>>> For power down 65536 clk cycles. Less than that is simple reset.
>>
>> How long is 65536 clk cycles in microseconds at the fasted clock rate?
>> Hopefully won't accidentally shut down the chip here even if fsleep()
>> goes significantly longer than requested.
> 
> That would be 8192 microseconds. Do you think there is a risk we end up
> turning off the device?
> 
Linux is not a realtime system, so yes technically it is possible. It
would probably be hard to do in practice though. So hopefully not
something we have to worry about.

If it did get put to sleep here, how does it get turned back on?
