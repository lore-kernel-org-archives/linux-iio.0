Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D393F42882D
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 19:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770234261; cv=none; b=qB2OGlwEYc7I0SbrmCjDqIIOI+MI1A9xqYx6/QSyJl78N9BL1MkLjeb7NaM0kEIFgS0SuL2Hqd5ziv12akekKsvLvWBZvyOh7TQ95QijZ4YucQd02qHvf6VuSek4jkcIzaV4gPMSBnlLOg8AA0Vpug6wcLk34+QEddNGt+9ciow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770234261; c=relaxed/simple;
	bh=FevnFgWkjVy7aenho5GA1NWH3IWtJH/ISCN57ubVBEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMk6KuXNvU4fVvfhywrHZIZ1v+lV8KNnx+L35RcdPoCXIvKKwzrHm/uXnGrRVBj/TmsghDem5inaeLh6e0RjccLrz32zhxQZ3SuSZ63tZ+POubhc8PA+xMRH7vurbUCw7VXkE9fpbveWR88nEnMoje+az7Q2TRS3G3UnSKbw3ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ozYlvdSJ; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ozYlvdSJ"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-66ba1095bdbso112581eaf.2
        for <linux-iio@vger.kernel.org>; Wed, 04 Feb 2026 11:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770234260; x=1770839060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O/r9UjWFPDVT5jfzqXISvym67PkpsI2YugtS7ogVH3c=;
        b=ozYlvdSJvAElgzhZyPoBZuf5dFebl0xQ+808E+FSgsL2ee0KHQtwv/RHfbN5Vp1Xw5
         /vRHk2zOjSlPPxJHbjRtQeFgrCtSowh7Ju/g4JFqx/Mw2fJsbpvWWDhpluKQOtUHwq/s
         V5N+kwVInTShGJsRRpCDiLapIpUMnANdksim5L/S/XUaMhkdjCxDmncCkfP8Jfq6TOhk
         aoStxUFrI33xo53RHwAw1Ou+p2GHVFmcbKLAoI6/YMEx1jLnDPUO/vrYTand9NNtk8ky
         raqwZvdxwt3oye3+7+u8YaWUJOFYQ8RnJwhVk0mCxairJFKhvJtm0LJRf8JLhubt0AAu
         QhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770234260; x=1770839060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/r9UjWFPDVT5jfzqXISvym67PkpsI2YugtS7ogVH3c=;
        b=ckzOMk3AQ4EX9c7ybKUKYQfnmQmxr1qB7OKIrr8di+ZWQWgCc5A1Amel/3Uzch7QEU
         XoNN73/zbFpHy3QYM1Lldt6EyqEQIGgs7SdU++4R4hEPVLQ6i/DC9RpukgFBrAmmOitn
         3FQMz7GjB6wAlsw2hB5Og0MRNOMiLLL4ocQdZUxMh3l+ymChBNMLdbFIlJNbkptoBA7n
         ou4rCV5hIfS078bvy3cxjFZ4O3ihU15fd9Uby5x6wn1nD8VGRaGrHiGcr7L/ghyN3XQf
         3M/9GU82loRJbEA3PDbHk0lJFG1jB7QjJbEavUXojeNX4X79EfQ+rfMxtBB+mR6IaY+j
         v7bA==
X-Gm-Message-State: AOJu0Ywj6UzwXrzEJ6VxSRkp+0NUwTT7GfiARF3d1Rv/jCzsUMZjQGME
	iBOzBjGAosUyFDJpmtDIgEL+1QfZxz38rasvwaC30OOgXfhfQC0kQX1aX13KgIp0Yrs=
X-Gm-Gg: AZuq6aIKh2BpuDSQQt+pnL9rN1x8soKtpjdWGhnIhDfGovtViM7FzHY//kUPqiyYsBS
	6qRQxRYI6rSZKCPg+Pb0XlB/0t6IYEaPqlNkEiBnM0WDuH6hmWfWFPE/JxC6+31oXGV7aw9b3/k
	SLsgRrEMm1UwzYVh+chn0K7nlGuFZFYkbbuQUEH2lMpFGw/I6f7GnO+VeZwnJzVe+jWh7uyDHC/
	sN2bW/m7gsC279vIedbtb8ndeqlHJeuG645dR6uk/BNXm2X0Y4c85nwBWwatEuk/Xyl7liiBmAy
	q9c/iz61L7uXlgg9fWwp36RNSCyhB0/UoWbhTB599hYLZHtbVqKbBOLZhLK/bermkQZkhL0Fv79
	CS8fVTGLrCke/1AGOxMMjqo3zBZ/hm/ZAhowRa4zuJPRIUw8xS/tyQ4+Htl/+A8nmOZDMW4TLlY
	+vLY6+yvncOPEYf0zBcBR72sPxHAxkr6RVIrnetkmEhpstEZ3qsN7cklmYyg==
X-Received: by 2002:a05:6820:1ca3:b0:662:f660:5a1c with SMTP id 006d021491bc7-66a1d40b4a9mr2056633eaf.0.1770234259702;
        Wed, 04 Feb 2026 11:44:19 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:319e:ed90:d5d:7e61? ([2600:8803:e7e4:500:319e:ed90:d5d:7e61])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66a829b449fsm1326246eaf.4.2026.02.04.11.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 11:44:19 -0800 (PST)
Message-ID: <d297fa4d-c8fe-4ec9-91dc-e15125adc711@baylibre.com>
Date: Wed, 4 Feb 2026 13:44:18 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: ABI: fix current_trigger description
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260204180202.515393-1-cosmin-gabriel.tanislav.xa@renesas.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260204180202.515393-1-cosmin-gabriel.tanislav.xa@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/26 12:02 PM, Cosmin Tanislav wrote:
> Triggers exist under /sys/bus/iio/devices/, not under /sys/class/iio.
> /sys/class/iio does not even exist. Use the current path.
> 
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 5f87dcee78f7..4fc9f6bd4281 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1428,7 +1428,7 @@ KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		The name of the trigger source being used, as per string given
> -		in /sys/class/iio/triggerY/name.
> +		in /sys/bus/iio/devices/triggerY/name.

While we are fixing this, the docs refer to it as triggerX rather than
triggerY.

/sys/bus/iio/devices/triggerX is documented, but
/sys/bus/iio/devices/triggerY/name actually seems to be missing. That is
for another patch though.

>  
>  What:		/sys/bus/iio/devices/iio:deviceX/bufferY/length
>  KernelVersion:	5.11

