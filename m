Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB78832B131
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 05:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786945913; cv=none; b=LYZyxKkYXVGE/+hHt8NZUc4/TVHwMTNm1EaFi/jjW5Ux0b6UnntQRS1a631Ji3VPECMMW9hroMohpQ94RuxPkqdU7wcKswIjeLthdMczfPT8WnfdY50FPlmPOo3196wnBZGYR4WiDzW4pRk96bsXUkrhJhEwq2sG1BbGAzjgQ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786945913; c=relaxed/simple;
	bh=3sTakhxLFp3y7eYpZ0tj1IyZHqWP/G2jLPVA6iaS1ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLGmxk7NCARREc0C3FF/JIFC4EGOsur46MaXOeaxzgtqlgsvWOm1M5zh1NNYzzzkKwlR9eLQYeryfY8EM7AUwrFuU3No2af1HkyJdP8FXf0v6ok2CJJ9SuB5im9L+byjwabXhvx3xajloGSDJKX5qDcw/5IWVf5SlzjxJDTapQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0KaK1RI; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0KaK1RI"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeb2bc82ccso3410784e87.2
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2026 22:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786945910; x=1787550710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lULULo2paG56O+MaCK5Ybu4hEzUp5Eji79Gm7iF/Vo4=;
        b=e0KaK1RI06AE7zpibeFaN5hpSScYLZm5TvBuorafGtUb8YIOrhwJoCywSGTtwprKBx
         ZYZOCilvYaPBFCkydM+leuPAE2qIhXCaSJoWlO0Uu9bQZRNU+CVl2GQ7bQ/YFVzHduR+
         wFP+SofyXAlg4z+x1OxOlV9Z7gt0k29pgaQhfgczi8qKmnG23tZjWScidldrrvscXwS3
         2M5vODoLwA36fC8/NJyj/T+zPxceWhV2NIOWCRgdP3/eeUdQR7uLJYNVNsmlvhOIWp/E
         2xKP128kd7Jy7W+iNEjE46KRdCEiuDXBO1IRRFQjhtL64lXma2n5coZiad0H1I4jZ8Xc
         Ov2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786945910; x=1787550710;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lULULo2paG56O+MaCK5Ybu4hEzUp5Eji79Gm7iF/Vo4=;
        b=EfzbGez1v7BKTc6wKyHZAiEdtTa7ES8Ge6wuCIWJ8FQG501O4XLPw3u9x44ZK358xo
         WMGo9qYwpX6Ad9B+rW0m7ot/5j037IT360THsAjwQOuZzcL6x0S+tNm6Q3WmpwrrTGRK
         +ZFIxVyCyCUo5PO4HeJbZDZnRcGUez+EoV+mvJrAg4aBy8xJ4Zd8mzvIEE57s+lmV9cF
         dZWkDoLOIC3yKg7l4b1PhgJIlFbD5lsePht/TQYgtJDPB4M11DqIR6YsRyMFJh+G/5DK
         c1LkrovINjuyA2N9pmz6B2+b4VbdBgUiozveRwyodd2jvDRkxgKSZcRJVr0Y5nPY6/ol
         41ug==
X-Forwarded-Encrypted: i=1; AHgh+Rpj61p6geiN+rKrpZ6p1djeOx9O+mEE0IbEeRjflVwSUL87/xvVO1RymijKXgyBB2YQ/OP1GEMfZa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMpOQv5JLi56Jqg5vdMj7awr5l/ysP3uLNnnBEjRmFBxX+HJ9i
	2j9lNq4vUerXkAaTjIg4mNDnlMAZF7ti4V5n1cuPI/VJQgkXLsIjxu2u
X-Gm-Gg: AR+sD10uls0VxdWUqjZ3m36txrSyjcPw9jD9THZVWyPq8SM/n/gaihUxwz8JBJa5IJD
	JM2/mbd5Z/dVYdXhE8Ie844HdUkB791SEix/m5DgEGrB8cG9pPktojQdodEB/Jdth+5ckGx1/5v
	LJTZC4Bj2xzOKszjntbDDEq4pHDSGWzjznzFVRJjh9YkVtb0yl5PySgpSoaeBwuAM0Tf5vWSmPI
	BU1L8BGq28j4FTJZ/xI3Vnvkc3uoLHfa2ZYFQTifysDzu+ExxhYfaF1/cWPZWoHVeH4y5djrhPV
	ZkbdiMihVjgyIbDVXRkWdeIVMi4SrByOF7V1SVaEYhAVNU6NDsfKxCLJWh6XS2bqMylZ7LqJCWp
	lvpsX/Arw35PyHnKbe395rddZnmM5d57AanFlaMsWEfGrQMK4/RAqyrqeVjEd0oqhwabgkEoPvy
	oYVmX06/y5FUKNcGxvmzpkezq1u6nYX8+O01+ltZHgaigoOUVYh7vJ0Yq0LQ0S3zD5WIq5UHU14
	5RVNyK2PXny9CqG2NR55tCLolG/31jYe3yyzjZ/ehmm
X-Received: by 2002:a05:6512:8050:b0:5ae:bd53:70f6 with SMTP id 2adb3069b0e04-5b45910e0c7mr2408861e87.4.1786945909481;
        Sun, 16 Aug 2026 22:51:49 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b46d00ab29sm89427e87.56.2026.08.16.22.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2026 22:51:47 -0700 (PDT)
Message-ID: <a6ea43ab-964a-4667-924f-50efb86dd73c@gmail.com>
Date: Mon, 17 Aug 2026 08:51:46 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] iio: pressure: rohm-bm1390: Fix AVE_NUM
 initialization
To: Jonathan Cameron <jic23@kernel.org>,
 Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>,
 =?UTF-8?Q?Topi_Sonkaj=C3=A4rvi?= <sonkajarvi@hotmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
 <7784e12793187a75dc10b0e84471f0cefe4d28b9.1786347811.git.mazziesaccount@gmail.com>
 <20260817021252.5ef32a57@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260817021252.5ef32a57@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/08/2026 04:12, Jonathan Cameron wrote:
> On Mon, 10 Aug 2026 10:53:07 +0300
> Matti Vaittinen <matti.vaittinen@linux.dev> wrote:
> 
>> From: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> The BM1390 tries to initialize the AVE_NUM to 110b at the start-up. The
>> field location is not taken into account, and value is written unsifted.
>> This causes the AVE_NUM to be initialized to zero.
>>
>> Use FIELD_PREP() to shift the intended AVE_NUM value to correct field.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
>> ---
>>   drivers/iio/pressure/rohm-bm1390.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
>> index d00d7ed54cb1..29454570f257 100644
>> --- a/drivers/iio/pressure/rohm-bm1390.c
>> +++ b/drivers/iio/pressure/rohm-bm1390.c
>> @@ -479,6 +479,7 @@ static const struct iio_info bm1390_info = {
>>   
>>   static int bm1390_chip_init(struct bm1390_data *data)
>>   {
>> +	u8 regval;
>>   	int ret;
>>   
>>   	ret = regmap_write_bits(data->regmap, BM1390_REG_POWER,
>> @@ -512,8 +513,9 @@ static int bm1390_chip_init(struct bm1390_data *data)
>>   	 * Default to use IIR filter in "middle" mode. Also the AVE_NUM must
>>   	 * be fixed when IIR is in use.
>>   	 */
>> +	regval = FIELD_PREP(BM1390_MASK_AVE_NUM, BM1390_IIR_AVE_NUM);
>>   	ret = regmap_update_bits(data->regmap, BM1390_REG_MODE_CTRL,
>> -				 BM1390_MASK_AVE_NUM, BM1390_IIR_AVE_NUM);
>> +				 BM1390_MASK_AVE_NUM,
> 				 FIELD_PREP(BM1390_MASK_AVE_NUM, BM1390_IIR_AVE_NUM));
> 
> If respining I would drop the local variable and just go a bit long on the line.
> I like the mask to be clearly visible in both parameters and a local variable
> prevents that. Fine if the line is really long, but it's only about 83 chars here.

I am not going to insist - but I will explain my view - which will sound 
like insisting XD

For me it is always a tad harder to read code when function or macro 
"calls" are done inside a parameter list. Hence I like a local variable 
here. I do 100% agree with you that mask (and sometimes raw numbers) 
should be visible in code - and not hidden into variables / defines. 
Still, in this case, the mask is assigned to the variable right above 
the line it gets used. So, I could argue the mask is still pretty 
visible, and FIELD_PREP() is called on it's own line and not inside the 
regmap_update_bits() parameter list - which is more readable for me.

Well, if you feel strongly about the variable - then I can ditch it. 83 
chars is still okay(ish) - even on my "old eyes, big font and 3 
terminals in parallel" -display setup ;)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
