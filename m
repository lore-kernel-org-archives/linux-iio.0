Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.31.26.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876168;
	b=kNoJYAxi8F2VnmM2bF5B7HQuYIAqYuNvQBkXzUyppvtbwXdZtXuFnXtXhWUa9r64Hq01
	 /Y32MtRfcChkEgYUTY4m4r2fQF8dEN2ABiAs8rmDOwwwmu3M6r91vnHMGhZ8kJ+VkZzE7
	 a8jFl9y89eTWKWrsCOZ0YhXbeinC4GHH2ocTfd70nFDiFiXMjDHb7RVGSKQ847O1oXhzb
	 RzduXNoeczKNFNJyQ9OkBcNux5RH0roHYRiI8sCj8ZWPoNzTgsUZLe6PSSyh4yZPXksIk
	 vpDksy1Q/s3eEo6zoIkqoimAmNhQxz7N+vm/xMZJa4hAwMjT1n5/8FO+qO8ousEpwGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876168;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=r1Z6oKjUEthpj1h9QnDMmoAieaLmf3njhdsaYkuo8fU=;
	b=W9na9Zfj+ZCFNL3PaVJIvqTIc1byQ+pcRpG+MRDQTD2nvnAfvN+VrukQsJ+XRzFNzIIe
	 Yb4wMu2wuhGiCNzeMUWvBRRPyfA3qEPFKltb4c09FkIbHtIBVtNn9+erlGm9jCKKWxRH8
	 tlZS9j865qWBzoMFZ9dMsYuEFRtO4E/IUxjtt/A8KXZs6mXv6y4wlCVN3bjt3pKiialzm
	 h1PmDMIaM30y/o2zXYR6jqOtLyOvg6e7T0h/d8L/PlquqipR8460AGrYbm7aU65pASUoB
	 w/zMv0OkawwjQP4bRCYttRFPxjt9sWBAHX7fD1xvg37WedjzSGAQdvyMABQl02UTb7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rudorff.com;
	spf=pass smtp.mailfrom=rudorff.com;
	arc=none smtp.remote-ip=193.31.26.27
Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2FC606D824;
	Thu,  5 Nov 2026 10:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B2FC606D824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [192.168.35.184] (dynamic-002-211-221-196.2.211.pool.telefonica.de [2.211.221.196])
	by rudorff.com (Postfix) with ESMTPSA id 2F293406C6;
	Thu,  5 Nov 2026 11:56:03 +0100 (CET)
Message-ID: <ed75d869-c51a-457e-9cb3-6250029d4ec7@rudorff.com>
Date: Thu, 5 Nov 2026 11:56:02 +0100
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
Subject: Re: [PATCH v4 2/3] iio: light: gp2ap002: add led power supply
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20261104-iio-light-gp2ap002-v4-0-fa1cbaad2ce5@rudorff.com>
 <20261104-iio-light-gp2ap002-v4-2-fa1cbaad2ce5@rudorff.com>
 <autr3DH6UZLY_ys4@ashevche-desk.local>
Content-Language: en-US, de-DE
From: "chr[]" <chris@rudorff.com>
In-Reply-To: <autr3DH6UZLY_ys4@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andy,

Am 04.11.26 um 18:31 schrieb Andy Shevchenko:
> Missing '---' cutter line which makes this patch invalid and it may not be
> applied (your SoB should be a tag and it should be last in the chain; you may
> conduct an experiment, take the message ID of this email, run on a clean Linux
> kernel Git repository something like `b4 am -s $MSG_ID; git am ...` followed by
> `git log`, you will see the issue).

Sorry. I ran checkpatch.pl and b4 check and they missed my mess ...

>>   	int num_chan;
>>   	const char *compat;
>>   	u8 val;
>> -	int ret;
>> +	int ret, vdd_volt;
> 
> Don't mix semantically different variables on the same line.
> Try to keep reversed xmas tree order.

So like this:
	...
	const char *compat;
	int vdd_volt;
	u8 val;
	int ret;


>>   	if (ret) {
>> -		dev_err(dev, "failed to sett VDD voltage\n");
>> +		dev_err(dev, "failed to set VDD voltage\n");
>>   		return ret;
> 
> Unrelated change.

Yes, but I'd still like to fix it. Ok, if I mention it in the changelog?
Or shall I drop this?

regards,

chris

