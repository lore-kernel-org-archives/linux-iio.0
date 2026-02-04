Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF3238BF7C
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770234937; cv=none; b=EveGvIu5vsfFmY2QTWfCDTbu4oxMf3DVZs+EtHB31A8DnUzUYNiNst0RPSqLIdouIiaQuEkg9cxQB2miTOzbSn004HwriTbOT35aiBttL4WvDKWMlKbewpM6k5nt3xFT1lRz9S89Xvp+2+PtU8KbkE9lyWDK+rsOyW83T+LB5jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770234937; c=relaxed/simple;
	bh=+OvaGg+cytYtJ00UGjIgcK1m0aXiuGZz7Vw4rD/PiTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGqTnfS76VpD8KNxxU5/OiyemhghU8uTP878MW7UFRp9DI4YDAl1KUTflLK1tHeNfEdSAz4Pi4WJ0gvbOZYLqkHQmq5pXmR13pqibqExRuCJu1YTqUFnf6gualtK/M/yHoWUAPwDJ11hmRfOvEl4/hnew7+zetebZ4WLSUGEASM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sxrVUQlx; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sxrVUQlx"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d148dd3421so82091a34.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Feb 2026 11:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770234935; x=1770839735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yNCzFgwjxVCRltOe40VLUcKAjzjk46WEptzJqFLQRHw=;
        b=sxrVUQlxzx9Tyc5CGbFyglQkMdPVVZW7Hv8Z/fxSvX5EMLsU2QhylUnvvfNg9ps85I
         ANqVoJsDGxnm/At9H2OtWFpMb357rkJuuuhV8vh4ieGYkmDtWPNYxYoIFJRxBCiFmCuw
         M9VMrigWp8YnEpjOKdaqEqUkv06iNsVFcwlpli5Km4wt1yULIh5R5GStPGIWt6mWTAy+
         dML7Qw+hETEfGVmocxBN60Znd3/d1/Vw3SXJm3scpBQVEDayzAoHCGh6ha3ezx3KOpWn
         oxgiPoMd7vh8tetuaH1aE5/H7cY1uJ5UJw2mE/YVSPYNUDdaNsTuq1mUF5LpkfmRw4aW
         XflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770234935; x=1770839735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNCzFgwjxVCRltOe40VLUcKAjzjk46WEptzJqFLQRHw=;
        b=DSJhm41be73yOkHB5jgl3P3ffw/QJophJiq8X8j2kjuKBRlFs2bGS4vaET0HoJpOf0
         2vaodVNl0Za1636/NA/8mOwaC0ohA4YeaiFQsSA9guC4/Cm4fL8y4WejfJms/5mUuSZw
         SUMdQDBUSMvZTY99gkxOmXPEG58bELYbVhcF3DzIiNCiFmQyuvV0V4X3bi8WQTmtudEp
         zaYSeVCzTglNv3XLLfiiFaXAhja0OUtUuFyRY7EnFqTMEIPWRpqU+jF1bfw+pcInTEIH
         iHd32CjS83B5Bq/j1newdOlLq7LIDzUFRRWB6FYH7xLtAhEy85+o9oO067NVpaCa65Kf
         +rcg==
X-Gm-Message-State: AOJu0YzYSZdP+USTmRyZ4gq6izlXv8tIrU8jtjqgCGr68ipKaDkjb4WA
	xnzryim7BPf5ldx0cPFhQO9ZyXbdl6sxpxOYh3G2PPt8cXGYafd6ZZcb7WXyITfvqPs=
X-Gm-Gg: AZuq6aLkB1/5lBZ93O3s8X+CbIlvxLdbMaPPHDjRXBVrMSFteGHj71t6GjdHr8UG3l/
	TgEgW3IdJ3Kvr2xEXzI8iTts1RUUfDc74K4b81VrKPl3v+ErYHwMbSyVf4xM/1MB34toueZ5G63
	SJiDvrlfqrQY6m28XAS5usuTk+b4/EZOBhCkGjV8fjUaJ5O3yIsZ8Z4JZwzfK9QyPoXonXIf/6T
	U/MVV+FMO+OIluJKPPzQoIBRCmvIr3XDhmFuZxwJbmkHCBO0amma7lhJF5osQm0F7rDkQwiD7Hq
	41cfWi+Zc2wAQhqutibuoT4TmfzNonQerm/lzm8NJzwL65I/Mzg9X/OPWT7jipfrsWew0WUKJGY
	hOvDoOssga2+LMQziLlIF/MJZFUSGOrxT2u3Wc5Yd3T5k3VHT+5e4VL5BX8skNVXEIHS4UF5Zjd
	ELJQ5al5vqgDNjJjfQ9AIHpAbsK98qd9J9E0S89nDYkwZJA6ipg+J8zqFUEw==
X-Received: by 2002:a05:6830:8293:b0:7cf:d4b2:d664 with SMTP id 46e09a7af769-7d4489b433dmr2110568a34.4.1770234935466;
        Wed, 04 Feb 2026 11:55:35 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:319e:ed90:d5d:7e61? ([2600:8803:e7e4:500:319e:ed90:d5d:7e61])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d449229fc5sm2133136a34.22.2026.02.04.11.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 11:55:35 -0800 (PST)
Message-ID: <db6c8834-7236-429a-bbf3-27c699f69470@baylibre.com>
Date: Wed, 4 Feb 2026 13:55:33 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: ABI: fix current_trigger description
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260204180202.515393-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <d297fa4d-c8fe-4ec9-91dc-e15125adc711@baylibre.com>
 <TYRPR01MB1561962BEB21FDF013F18FB9B8598A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <TYRPR01MB1561962BEB21FDF013F18FB9B8598A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/26 1:50 PM, Cosmin-Gabriel Tanislav wrote:
>> From: David Lechner <dlechner@baylibre.com>
>> Sent: Wednesday, February 4, 2026 9:44 PM
>>
>> On 2/4/26 12:02 PM, Cosmin Tanislav wrote:
>>> Triggers exist under /sys/bus/iio/devices/, not under /sys/class/iio.
>>> /sys/class/iio does not even exist. Use the current path.
>>>
>>> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
>>> ---
>>>  Documentation/ABI/testing/sysfs-bus-iio | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>>> index 5f87dcee78f7..4fc9f6bd4281 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>>> @@ -1428,7 +1428,7 @@ KernelVersion:	2.6.35
>>>  Contact:	linux-iio@vger.kernel.org
>>>  Description:
>>>  		The name of the trigger source being used, as per string given
>>> -		in /sys/class/iio/triggerY/name.
>>> +		in /sys/bus/iio/devices/triggerY/name.
>>
>> While we are fixing this, the docs refer to it as triggerX rather than
>> triggerY.
>>
> 
> While I do agree that triggerX would match the definition inside
> Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs, I think
> triggerY is the correct name here, because iio:deviceX is used
> right above. If we were to use triggerX, it would leave the
> impression that the X from deviceX and the X from triggerX are the
> same value.
> 
Fair point.
