Received: from ilama.link.melty.land (mail.melty.land [45.77.175.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA6B4414
	for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.77.175.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776007846; cv=none; b=NAtC1ZSqoubQMjXBg8rpBTawyhieXPL+zTvImxERtDX5h3Rj6MXTM3ktZglr4eHDKrQn/DfwceGhOexAsGEgT3UIqUyWuIgWPXAPxB0XxRWxNmyUQ8RREK1z+XSBXM+EEnHn01Z3EBjjYrLuwH/cJIYS57G3iGbBpLBmitIsjNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776007846; c=relaxed/simple;
	bh=z0b1vBEozkvPEh8Tv1N5JGqQQRoXrdLmfKDFZ65ZucQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=PZaxaJ9cakELXGbOZCho2E6OCLsaMH+1FWscqT8sFXMNSE3pC1BEjWWNIaLwA7SZj7dijNl9T+ZJ0Gv1/DNXoZE3vSDTp3Blb8s3eAq6mpDXwjt+ylP3oiLzQuptxSGGZJqzDVTa5Aq/2nfuKIL1q9VPSSB65byp40JgMio6uUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chuang.cz; spf=pass smtp.mailfrom=chuang.cz; dkim=pass (1024-bit key) header.d=chuang.cz header.i=@chuang.cz header.b=U2ZUkJYz; arc=none smtp.client-ip=45.77.175.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chuang.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chuang.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chuang.cz header.i=@chuang.cz header.b="U2ZUkJYz"
Received: from [192.168.174.5] (hawthorn.chuang [192.168.174.5])
	by ilama.link.melty.land (Postfix) with ESMTPSA id D6C01A83F69;
	Sun, 12 Apr 2026 23:22:01 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=chuang.cz; s=default;
	t=1776007322; bh=z0b1vBEozkvPEh8Tv1N5JGqQQRoXrdLmfKDFZ65ZucQ=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To;
	b=U2ZUkJYzpVvYbubnmLMPMUHNPUJifOz0Q2Aqp7hgfzASNzkvoez3tkK3m5mnaMksw
	 zlUT1iSqVloVqDapeDMMkZiqSGp9oXx0b4X95Tmv20qUrM5CABtckgAHC0dqTnQAcZ
	 98owRlQlk3jY7nak0zR8dd+abisaJKZqzB1siF5g=
Message-ID: <ef14ecd8-b35d-495c-a4e1-b6ae9d81e7a7@chuang.cz>
Date: Sun, 12 Apr 2026 23:21:59 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: adc: ina2xx: add INA236 support
To: Rob Herring <robh@kernel.org>
References: <20260315182304.613783-1-git@chuang.cz>
 <20260408155520.GA2256298-robh@kernel.org>
Content-Language: en-US
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
From: Chuang Zhu <git@chuang.cz>
In-Reply-To: <20260408155520.GA2256298-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/26 23:55, Rob Herring wrote:
>> @@ -1082,6 +1117,10 @@ static const struct of_device_id ina2xx_of_match[] = {
>>   		.compatible = "ti,ina231",
>>   		.data = (void *)ina226
>>   	},
>> +	{
>> +		.compatible = "ti,ina236",
> 
> This is not documented. Please add/extend a binding for it.

There is only a devicetree/bindings/hwmon/ti,ina2xx.yaml, but I only 
added support for IIO (no HWMON). Should I extend the existing binding 
regardless?

Thanks,
Chuang

> Rob

