Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FA41548C
	for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 20:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771186006; cv=none; b=qiFSGyFcpsOHt2ll7fAiBMsC0tiAsTCbjB0qIRsqNDQU6uRr5AHyzMlFaNNnROonVSMPbhO2R7a2IvvdQR20tRRODOu0Mpn/xkHdBbA4hor1taKVeqwSxbF/6rZVVxlHMk/S//SeXxPR8pzD6zivNUgm4XFJlAt4ij6W0G1sXy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771186006; c=relaxed/simple;
	bh=fYY2Hcini0IYTBnNIV2OVtiPJDT1BxddgIIfefj/oz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+XixGQUd4yFMI5KwOxQ0VSt1TfEi67AmikDLpQTNDL9Oi4GMliQ76T2ck/ocfISUnQVs9mPa4+nSIIXGqS0MrV+xkucPUmNWmtSuCMr2Xm5rA84gTL2QpRw/2rYkzd7+Cbk/DtJvzxE7PbnRvCNPyIjtV6QQGRwNW3y1bw5q8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euIf5QAa; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euIf5QAa"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79088484065so20458157b3.1
        for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 12:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771186004; x=1771790804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ew684kZBC5j6NJc+gT69tQd+JtTITX1IRPbP6jdn/Y=;
        b=euIf5QAalD3NPiKAZWjzzPxTfCuOLSyQPRo1GquCnLZfFPwyiOC0UQiQ5BVyI2ZiGR
         ZHR2zdf78z6XoJZThdm2uIol4BdPcul42WloxH6zpmVCqaodxkX+jlx8M+x7DkH4VGEY
         /Ldxuug0KVeNUiawuf3xTVnEInuiR95aplU/2vulcj1GkD2K1Dw27hmxtRf3huW/PEIG
         GNWTjLUvuXt7uL3E/E3qmxpOiyeQfOGps7eJlk+T3ZUxDjdOzWqwtMjGg8ryJrOuucSf
         TzGP/WhT2LLssGh9nUa5JqFhw+kA3miYxFub0VUAN3yrt17pdIcXA6idoZB00nJkJgbL
         9jkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771186004; x=1771790804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ew684kZBC5j6NJc+gT69tQd+JtTITX1IRPbP6jdn/Y=;
        b=sIC9u8QGIQltYyz3YM8FUgubgdXDZEg3uqwQPJE/ZnXnetMqA2jLUlqd6N9aHc2ebQ
         rPMON1bwQxT5JiaRv0QEjocxtFIqHKCTr1g48B+WPaNUgbZuopr7zV5WgZSeMhBcbmhC
         CZbfbr+2SrVYOFF46GDlpwCvS6lc3zcmVGWaU/TW2VKEOOl9giuOSAjWbabWym2VnLSF
         LPZAt0XYeiJeejeNnygGYJOTM5QdV4B00dXB9uV54Yd1rJl50nraow0m+pn0V2euG5aT
         R1+KhLbAnkMGBTSkqpqPjcPgfUOnt26hBoeFefrPl02nW7qzk5IT1aS1au5oWHTSBCCi
         JMjw==
X-Forwarded-Encrypted: i=1; AJvYcCUeJ8Akgd6gnLZtutNsVAlkXMlxolyCEp+xUK9PPv2AEgK/aBWlN3p9we00gOjamxxWuC9WKBwIZyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+c4QyTZiwILxIwJtjrjkooU7hgOlFAKJcvkgj9cdYeFQV8bG8
	ucQA6S7+vyp0Xn2lLhQT7G/sbJGtUIBILfyOnAlKTE48kiJTPdGgtYSN+I9slQ==
X-Gm-Gg: AZuq6aKqBREE4eentOww8Rf0GueYH5pAMMpxAaIZum2ULpP4/SLy3wq6pdvLL8MzBFn
	56zdFGGAHVsa8KR3by5yNt9/VFIlcY85BPwd2QHpnIV6oX+2tu1unNB6gyE9adZXOHwl1ibelKV
	kp4Kk3ONVkucr999cUdE0nVQkQ4PNMy22XCCRZHAtWICJCVJH/CBo3Y0FhzrHL1QKKP5AsW5Dyo
	y4HvhthmAtA83MO4tILhTXtLmBjD+SLgaMchY3YZKaIl/xvnJHC9lYC8Qdb+AymrXOqaqSOawIV
	7Sx6MN1xdTUPzF5nBWgBEbpUQkOpopU19U/7NUok8Sx1+yRSTikRrKKuX5cSCnODQCIlLrevDNg
	GCAm00OimaxDpZ1Bf/lsSfl2oBqXu/gvTeBdXpmZWhrtw8D0G1h8hlq/0T1CxxlI8vYbTCRRIli
	DZ96cuNiBudPwdQeuH5UPL
X-Received: by 2002:a05:690c:9990:b0:78f:a615:2724 with SMTP id 00721157ae682-797a0cca0cdmr147309467b3.48.1771186003955;
        Sun, 15 Feb 2026 12:06:43 -0800 (PST)
Received: from crusty-box ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c16f0e0sm93475407b3.5.2026.02.15.12.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 12:06:43 -0800 (PST)
From: Erikas Bitovtas <xerikasxx@gmail.com>
To: jic23@kernel.org
Cc: andy@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	krzk+dt@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	phone-devel@vger.kernel.org,
	pmeerw@pmeerw.net,
	robh@kernel.org,
	xerikasxx@gmail.com,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 2/2] iio: light: vcnl4000: add support for Capella CM36686 and CM36672P
Date: Sun, 15 Feb 2026 22:06:28 +0200
Message-ID: <20260215200628.53841-1-xerikasxx@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260215193114.2a1010a8@jic23-huawei>
References: <20260215193114.2a1010a8@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2/15/26 9:31 PM, Jonathan Cameron wrote:
> On Sun, 15 Feb 2026 19:28:56 +0200
> Erikas Bitovtas <xerikasxx@gmail.com> wrote:
> 
>> On 2/14/26 8:09 PM, Jonathan Cameron wrote:
>>>> ---
>>>>  drivers/iio/light/vcnl4000.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 40 insertions(+)
>>>>
>>>> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
>>>> index a36c23813679..1f8f4e4586f4 100644
>>>> --- a/drivers/iio/light/vcnl4000.c
>>>> +++ b/drivers/iio/light/vcnl4000.c
>>>> @@ -185,6 +185,7 @@ static const int vcnl4040_ps_oversampling_ratio[] = {1, 2, 4, 8};
>>>>  #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
>>>>  
>>>>  enum vcnl4000_device_ids {
>>>> +	CM36672P,
>>>>  	VCNL4000,
>>>>  	VCNL4010,
>>>>  	VCNL4040,
>>>> @@ -235,6 +236,8 @@ struct vcnl4000_chip_spec {
>>>>  };
>>>>  
>>>>  static const struct i2c_device_id vcnl4000_id[] = {
>>>> +	{ "cm36672p", CM36672P },
>>>> +	{ "cm36686", VCNL4040 },
>>>>  	{ "vcnl4000", VCNL4000 },
>>>>  	{ "vcnl4010", VCNL4010 },
>>>>  	{ "vcnl4020", VCNL4010 },
>>>> @@ -1842,6 +1845,22 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
>>>>  	}
>>>>  };  
>>>
>>> ...
>>>   
>>>>  	[VCNL4000] = {
>>>>  		.prod = "VCNL4000",
>>>>  		.init = vcnl4000_init,
>>>> @@ -2033,6 +2065,14 @@ static int vcnl4000_probe(struct i2c_client *client)
>>>>  }
>>>>  
>>>>  static const struct of_device_id vcnl_4000_of_match[] = {
>>>> +	{
>>>> +		.compatible = "capella,cm36672p",
>>>> +		.data = (void *)CM36672P,
>>>> +	},
>>>> +	{
>>>> +		.compatible = "capella,cm36686",
>>>> +		.data = (void *)VCNL4040,  
>>>
>>> Is this necessary? I 'think' if you drop it we'll match instead
>>> on the vcnl4040 fallback and then the access to the data will be
>>> through the stripped name only bit of the compatible (first entry, not
>>> the fallback so cm36686 in this case). So you do need the cm36686
>>> entry in the i2c_device_id table above. Probably better to keep
>>> this here to avoid having to reason this out - but perhaps a
>>> comment to that affect would be useful (assuming you verify my
>>> reasoning).
>>>  
>> After I removed the entry for "capella,cm36686", I received the "Unable
>> to handle kernel NULL pointer dereference" error in dmesg. And at least
>> stk3310 driver includes a compatible entry both for the device (stk3013)
>> and for the fallback (stk3310). So my assumption is that this entry is
>> needed.
>> I could include a comment explaining that cm36686 is fully compatible
>> with vcnl4040, however, if that is necessary.
> 
> Thanks for checking.
> 
> What did you get as the backtrace?  I'm hoping it'll explain what I'm
> misunderstanding!  The hacks around using the wrong table for compatible
> matches have tripped me up before.
> 
> Jonathan
> 

I am attaching a link to the dmesg. There were quite a lot of lines in
the stack trace and I am not sure what is the right way to post logs in
the mailing list.

https://pastebin.com/QgeTdNEP

