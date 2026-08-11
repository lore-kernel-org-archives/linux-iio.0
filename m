Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A81D4C6D
	for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786439245; cv=none; b=GLTeqNjkw3TQqFYbjfUqT3xdXcnyayAgHWlwixXYIS5Ue41rY2a4AKiMyWB964LL6hFN5z+Trx4u7rPt/B43E3wXbx2HRAACWWs5UtDXfLpjj0C1Wc6zPCY8Jz08YsmfqzGUAHHKKqF5ER2bq1wPbPp3mAh3Fu6zIJoU7/bIqzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786439245; c=relaxed/simple;
	bh=BTLKkU8arl/fK5bpHq+54TpKRz2P/FqM2x5VUyx4ZKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYqYPnTZgLEgzc157hRaxppJ+97jwCkJp+8l9TAVk16FBZgqMRSu7R3CBFezvUJqfAI2Oxs8vvkLtI1Z1T/ZEk/uBPvV/3q1FKuKGzFB/HkRbt2xFuYufThtlHIEyB2l1jHOLjmX3v67b6tPtbOwkJNsooTF0BuQIXAuS45MLQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ex6DLh6l; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex6DLh6l"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b015532f7bso2691573e87.0
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 02:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786439242; x=1787044042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2wuAmmghVfEkaqiloDgJ0FmX5H4XIqPuqzW8qg7FyYc=;
        b=Ex6DLh6lsXeem3WumCXIbLdlwfxSLqVyjrEZN+JLGwiXkrUf9ZgehFYisOl6ssYl5W
         VTBZCC7nfKH1kU9lyfaAczLWAg0aJ+vJtr5dG8gwrFckGVmp9QdZ0WIYTK8dCpbGUSU2
         /ZT5wel0MaWeQoq6gOagtknHNEn6zGNpJ8ZoWWA2YaAaaxys9/Zz97y8XXLdfAr+R41j
         OdpZFaWupvQPtCG/Efa6awz19s7ccjMLMjhW+gvGHpZXnz1yd1JkrlZKsR6V6U/izQjd
         CNeqHcPCxsmbBVTa72Xe2sG/yypPG6fZFuqSKezaNn9WFnjwPxUhVFZBJSUYh0Sxa0F9
         LxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786439242; x=1787044042;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2wuAmmghVfEkaqiloDgJ0FmX5H4XIqPuqzW8qg7FyYc=;
        b=i5UU9c6UZuNdOLmETrPycukE52QiCfd5xUyh77+ZQdOLTZxsCBztV17cwEYn3KQ0gf
         ocwqHACkWbmYiCHkcABJGt2DimAj4Yy6dSVSSCJQ3XnZzfob849TwIMvlQpt6fdj9OiH
         kkNZa+Tsif9TBt1RaU4bgvAKzDGuu2MUH3uJJIAu+2/AIlgVy0N/x2ZRADF7ahcZ+tcU
         n4UQFQYUqDfbqNx4Ic8KNyhEJONxq/eLkLi1Y1Tr69cQVwdOoZed81qJKoFZ9IqgMTGK
         cymmYPmTxiGdaUzeeWM/9BExQLn1EU+QCmLlvyJsPfNl0CXcP72nE84GVtQeS6WnVEsv
         +AXg==
X-Forwarded-Encrypted: i=1; AHgh+RrRvHqf55wjf+S26iME6/R1CZXTrQ5z3sDfmjHufdTm6e5dWL27JYLIlYkIKOpa0ZDcY45UdfDD8ng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6iEb3DH5YizAGgzxq81t31ZMQAbSMsZTWMLGoR6UX4uAi6Pb+
	VimwzwuJvWFiK/HAHbbf9Amq8+aB62cV3xUGgIWpxtiH/myG85L25VT9PAiEIv9hSME=
X-Gm-Gg: AR+sD10acCm3RAE9mmbLsowTDquwdHn4oDheoOtdLDhu1VFz3oojjdhn6KZ67vgvD33
	YFYEvYuC/Vcc/x1qjdshUjjyqpbhpo5P9Lrje0iyE+VInsjIB3zCAbmV/wpO7Hf1Vk/alTxPyVW
	yhfb+uIWj6NEBLPQ+WgE6FU6W3i9V3Dx48ScmlnhdRjyPHf1MvX5nt3MF3sj83gPHyRsCcpTzoD
	38+RpImmj00As+fuIpWxr+CQO5kPO+vyrAt9DEHJJ3u/DvN0p4W11PDiW/11anOVRExTCAB1gd3
	o1U4kUOHGTvuWeOYKergKIWjFtYBPUn4WsvXAl9J7F2icT7Mh1o+usk7Tm8GNIIt5ihWlNu9i9N
	X8JULn0SLluY4EZ/7ee18IRCPTeQwtTh4KFMlJeTFuwhiGwHpe1bc+qRKsoHYPtiu7Bu1BwmLwT
	6zzmP60fRqdNLW6nKMI5Gyv2+hkwfDmGrrGPNpdmZri0DeekSsbKPNlBbjsBZu0VCS/fVbJJEVF
	07bP3tVmnNmjvjjPBZeujJvunVydvq4wraEclTgUasOaw==
X-Received: by 2002:a05:6512:acb:b0:5b2:f426:9c67 with SMTP id 2adb3069b0e04-5b44860c5fcmr336192e87.19.1786439242236;
        Tue, 11 Aug 2026 02:07:22 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b448724b0esm162868e87.47.2026.08.11.02.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 02:07:21 -0700 (PDT)
Message-ID: <fb027ba2-abf2-4e09-8189-3dcd368bb06d@gmail.com>
Date: Tue, 11 Aug 2026 12:07:20 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] iio: light: rohm-bu27034: Fix infinite delay on
 error
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Matti Vaittinen <matti.vaittinen@linux.dev>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>,
 =?UTF-8?Q?Topi_Sonkaj=C3=A4rvi?= <sonkajarvi@hotmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
 <2601f407f145ea77733280fd1e2370dcdb4b69e2.1786347811.git.mazziesaccount@gmail.com>
 <anov33hvjioArKpw@ashevche-desk.local>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <anov33hvjioArKpw@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/08/2026 23:09, Andy Shevchenko wrote:
> On Mon, Aug 10, 2026 at 10:54:04AM +0300, Matti Vaittinen wrote:
> 
>> When reading an integration-time fails, the code will use error code to
>> compute the sleep time.
>>
>> Fix this by using the smallest integration time as a default if
>> reading fails.
> 
> ...
> 
>> +#define BU27034_INT_TIME_MIN 55000
> 
> #define BU27034_INT_TIME_US_MIN (55 * USEC_PER_MSEC)

Yes. That looks better, thanks.

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
