Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F32B2309B2
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777989169; cv=none; b=ZNqoHxTMEF83PPfbjO/ZtJrugovaYSAk0CfT6vQl3iH+WWH9+ivZYUKv9XB1IwJeUY2rHj1g2G6SXKCvlGL1uF7KnMxPzLbnhQVs9eEBcLYPDLnpSB7esDVe2b+S67X/4++8v5FA+5GkIQqy09EQbqtoBLgiA/EhG9r5kH1APZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777989169; c=relaxed/simple;
	bh=C2hy8AmKXL/KJH1Vf1F3ndI3PVk9DC95GmYVpAjcfk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NigWNEF1n8HeqWdgymfmVQQsE0g/MY+lxFSTyKqx7iYkIbmOcVWLdRk0XRSCbXG1WE3JjbZfXvW/f+1mxFuIUfhimL6E+XpWHuwT6aJexSrjZBZxcLHPS9d3/p7BRcp/8QyraC/waLq61xYyGAXk0CBKt/6zSJgT2/NDr1rSwAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=oout1TEU; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="oout1TEU"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dca5f64e86so4102100a34.0
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 06:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777989165; x=1778593965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G1ZMwwzXjlRZxMsJSBvJuc44He49YnbDe29ujonS9gk=;
        b=oout1TEUGRS4hHmU9BKBm4qfAJkY/Z/rWE9/4mEgsdKfjGUu/9VtDtD+16AWkxqo7U
         n6ITpJyY2lkF11oZgpQqhX47QlDDlv2X8LpuM6+mrFq2wBSAfWc4+9sdQyC6mU+hCLqP
         i+922ZkBoRrfXUeiVN5M6SxHBfsBJEkRpzX1PL5hzlCeGoBudiG+VtvvOOoYtO89jbPC
         /I9SKADZb8VQ475y60mvevUA015aGZe+Uoh/nsTtA7RDjyZrq7vjIqJDd/DHdVgwoK3T
         H3Cn4VEUUhjCdBvx7s9NmNhQyenVLcgSYp7N8qoHDtpvQkDoMh435S4cP7mMvfeqE94r
         kuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777989165; x=1778593965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1ZMwwzXjlRZxMsJSBvJuc44He49YnbDe29ujonS9gk=;
        b=UsjSOfh+KGVUC+0Nbeg+7HxxwddpPk8SRHIpTugo9aZkZezwjx8ad23BAJsRJoo1mY
         CJ2MPysRJsUeM2Y9vkTB+a6mppTVt2nbMRLKS9GS+6bOwscI6YIXJSX0DIwja6dfRowc
         9i/S/sW/kgviTQuomARrsgiRi1WOPmMgN4wh2pAn0E+m9EcUX0RjQ7MrHRz59XhyI4tX
         sZYhhXK2n2CFLEGoihKTnM3A8lrlo5AJ5A1Cj5cRwrGbI1la7qzi/Eh2fu1mgZthnrQx
         0w/CvNZh5owdF5FCWbsJp+g0QR+6IhQqJd0kwETzXL2BRNDei6u+lcI6xIGl8qf+rgA6
         /ROw==
X-Forwarded-Encrypted: i=1; AFNElJ9+KemA5U75vUT1CbPa0N+Cx5sogAinCpqRM3eyr5LpegfkrUj++Q/T+OGGC017CgWPKut0IJpluTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD3Fpu0nfysbqCCGPXvLGztlhjYutEO+Yh376M0hJdnbYAY1HK
	7Rjc7vFgxvsn+o2zLipGAMKOOUuRdLi0k9IeXwoBQeNp6GSxac7XdbVN5rzSt6mo6S8=
X-Gm-Gg: AeBDieutAVABTRzsk+1alLyK72ubsCFd3qnj4XtVZlDWJqJ1tSlAF7ltSNqQQaQ6v2+
	VbvA4Ugx8mti4D8sao4WKKf0Xvwg6d/edRatWyPGqDA7NIprH113wnjNLepICpXrrE3UDuCzsiW
	ChaRu6Ve2NvEG8yM9WiggghgRsXwI7+6VWcgr7QYghbh0qC3l7XTYoI7j+cBBaI3HqtD/cf90j7
	v0dK3yBQ2/aFKRZI2Q4k493gdAO1FC5/cZBZ0HityZGtVTuxnohlPylJz95L5iIMld37KIlRBT9
	PVIJplMORQyyC696Viu3UoTYlZXRvbVbmo8Hx3xz7aj12Fw+3lPPi6mb1ac84DdfBipdbhmN00C
	e2CRrNWOtz4gqs4HIFrVLp/C1fuoXVv6SXGrQns4eL1MeHq5TCp0RyMM2ntZWHF8AIutS5fE4tX
	kGyYoxyBTgwBbEiYj/UFTxq7U3tJNXLO42DhJ/8/XXY+3G0VBOP1gOO61Y4UmV0sjguBINonJ2R
	CrAtM5syAYF
X-Received: by 2002:a05:6820:a0b:b0:694:8e28:fd87 with SMTP id 006d021491bc7-696979cc6c4mr6641626eaf.8.1777989165317;
        Tue, 05 May 2026 06:52:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1cb4:bc49:2fb2:6eae? ([2600:8803:e7e4:500:1cb4:bc49:2fb2:6eae])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69689440f5asm8034882eaf.1.2026.05.05.06.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 06:52:44 -0700 (PDT)
Message-ID: <946edc28-dbf4-490a-98df-615e1a4f6b21@baylibre.com>
Date: Tue, 5 May 2026 08:52:44 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Replace manual bitfield manipulations with field_get
To: Jonathan Cameron <jic23@kernel.org>,
 Rafael Lopes Santana <santanarl@usp.br>
Cc: nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org
References: <20260501011548.15369-1-santanarl@usp.br>
 <20260505131642.75f3c72a@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260505131642.75f3c72a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/5/26 7:16 AM, Jonathan Cameron wrote:
> On Thu, 30 Apr 2026 22:15:46 -0300
> Rafael Lopes Santana <santanarl@usp.br> wrote:
> 
>> From: Rafael Lopes Santana <santanarl@usp.br>
>>
>> Signed-off-by: Rafael Lopes Santana <santanarl@usp.br>
> Hi Rafael,
> 
> Additional comments inline.
> 
> Given this is packing code that is using shifts in one direction even
> in your new version I'm not seeing a clear advantage to this change.
> 
>> ---
>>  drivers/iio/proximity/aw96103.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
>> index 3472a2c36e44..a8a6ae02438a 100644
>> --- a/drivers/iio/proximity/aw96103.c
>> +++ b/drivers/iio/proximity/aw96103.c
>> @@ -591,7 +591,7 @@ static void aw96103_cfg_update(const struct firmware *fw, void *data)
>>  	}
>>  
>>  	for (i = 0; i < aw96103->max_channels; i++) {
>> -		if ((aw96103->chan_en >> i) & 0x01)
>> +		if ((field_get(BIT(i), aw96103->chan_en)))
>>  			aw96103->channels_arr[i].used = true;
>>  		else
>>  			aw96103->channels_arr[i].used = false;
>> @@ -643,10 +643,10 @@ static irqreturn_t aw96103_irq(int irq, void *data)
>>  		if (!aw96103->channels_arr[i].used)
>>  			continue;
>>  
>> -		curr_status = (((curr_status_val >> (24 + i)) & 0x1)) |
>> -			      (((curr_status_val >> (16 + i)) & 0x1) << 1) |
>> -			      (((curr_status_val >> (8 + i)) & 0x1) << 2) |
>> -			      (((curr_status_val >> i) & 0x1) << 3);
>> +		curr_status = (field_get(BIT(24+i), curr_status_val)) |
> 
> Look at coding style for the kernel. You are missing some white space here.
> 
> I don't like this but if you were to do it for consistency it would be
> 
> 		curr_status = FIELD_PREP(BIT(0), field_get(BIT(24 + i), cur_status_val) |
> 			      FIELD_PREP(BIT(1), field_get(BIT(16 + i), cur_status_val) |
> 			      FIELD_PREP(BIT(2), field_get(BIT(8 + i), cur_status_val) |
> 			      FIELD_PREP(BIT(3), field_get(BIT(i), cur_status_val);

I actually find this much quicker to understand the intention of the code.

> 
> The benefit of that is slightly more than what you have but it's still ugly enough
> I'm not sure it's worth doing.  Note FIELD_PREP() in this direction as the mask is constant
> 
> Given the bit smashing going on here is always going to be ugly I'm not sure
> any of these are better than the original though I'm open to hearing what others
> think of this more complete version.
> 
> 
>> +			      ((field_get(BIT(16+i), curr_status_val)) << 1) |
>> +			      ((field_get(BIT(8+i), curr_status_val)) << 2) |
>> +			      ((field_get(BIT(i), curr_status_val)) << 3);
>>  		if (aw96103->channels_arr[i].old_irq_status == curr_status)
>>  			continue;
>>  
> 

