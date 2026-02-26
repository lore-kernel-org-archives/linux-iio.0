Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915593A0B33;
	Thu, 26 Feb 2026 22:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772144714; cv=none; b=HG/PdiveHhSlGX74cCPm8Jin8sb1/9HekFnz7VPJpFLuJ3+R7/Maqr2LAZdcHsAy4JAK1ntzB0fyDW+r0mBHcdH3bzNP3FyvVR2+1aQ/ZZWFhO49qFq/U618QiPJW3/l5wIvgaSqFJvpm0sPwY5FBMzSrv1mvdv40NVT4V/93gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772144714; c=relaxed/simple;
	bh=d6SOwQClggxD8BIlaBxx7xkKZfld648hKXyRqzof2Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONAEuyqqsCEFKEvF6FLFQ2h4RUug1j6tBE1X3NVE4xvXGBBAYhymwQcuyj8h3dRbO2anjI/0SjaABa1F8TuD8SXIp43srUmmQNyjuxywcd7GcjpT8AxFovyoAsXN1ostipY2mg/GNvfTYsWpr8M1vut2MIVQAhUK7foMKMXuk6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cmV5NlO+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cmV5NlO+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=B8m6Kx6tizY8toHrfGq5EdiNNQWUFLh1xOh9fGszzjc=; b=cmV5NlO+LSK0KGNRVirgLKEN4S
	Syi5tTyYPWTKcTlVDEmHveNMPGZuuuqmdp751aSOEOeP554ETKe6vUcs0se5omb8ayiDih/jOaq52
	TQJZrtVBz9rMXZKtg/zByhaDVigmq76jd4paogIVG+kDWxL1eZJIDd7PEXm1Gk76zCbRX38AN3osl
	dwZ9gx3xp4BToJURCZQu4dHcflW59NjhO1DOPdDktbXVTDplT/egWeTPv6ZSXIZAazmZlAyJNcAnq
	Ev9qCIy3o0bm7CiaRtq81mvqf6GX1VaNm3466/R9TXNdCzwY3rKz2KI5EIOsclMQpHWrapIjaG7gq
	9TmyxkFQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvjnE-00000007JQ1-2WHy;
	Thu, 26 Feb 2026 22:25:12 +0000
Message-ID: <fc1eddb4-b01f-49a4-808c-9a58b2b63ad8@infradead.org>
Date: Thu, 26 Feb 2026 14:25:12 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: tsl2772: fix all kernel-doc warnings
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org
References: <20260226051258.555019-1-rdunlap@infradead.org>
 <aZ_-pVTbTUkByPIJ@smile.fi.intel.com>
 <7f61d93a-37df-44fc-ab47-b0e5ff70259a@infradead.org>
 <aaCtJE4tvVZDn1zz@smile.fi.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aaCtJE4tvVZDn1zz@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andy,

On 2/26/26 12:29 PM, Andy Shevchenko wrote:
> On Thu, Feb 26, 2026 at 11:14:05AM -0800, Randy Dunlap wrote:
>> On 2/26/26 12:04 AM, Andy Shevchenko wrote:
>>> On Wed, Feb 25, 2026 at 09:12:57PM -0800, Randy Dunlap wrote:
>>>> Use the correct kernel-doc notation for struct members to eliminate
>>>> kernel-doc warnings:
>>>>
>>>> Warning: include/linux/platform_data/tsl2772.h:88 struct member
>>>>  'prox_diode' not described in 'tsl2772_settings'
>>>> Warning: include/linux/platform_data/tsl2772.h:88 struct member
>>>>  'prox_power' not described in 'tsl2772_settings'
>>>
>>> Hmm... I do not see any of the user of this header file.
>>> Have you checked if these values are even used?
>>> Perhaps we can simply kill all this?

AFAICT all macros and structs and struct members from that header file are used
in tsl2772.c.

>> They are used in drivers/iio/light/tsl2772.c.
> 
> It's the same driver. So it's *not* a user of the platform data.
> 
> Under 'kill' I meant the following:
> - inline the content of the file to the c-file

Would that be "violating" this commit?
commit 436d42c61c3e
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Fri Aug 24 15:22:12 2012 +0200

    ARM: samsung: move platform_data definitions
    
    Platform data for device drivers should be defined in
    include/linux/platform_data/*.h, not in the architecture
    and platform specific directories.

> - recheck the c-file for the unused fields and drop them for good

All used AFAICT.

> Alternatively converting c-file to use device properties instead
> of platform data.

That's your area, I guess.

> We have done many times in the past such transformations in other
> drivers.
> 
>>> But if Jonathan wants to take this as a quick fix to make less
>>> warnings appear effective immediately I'm fine with the change
>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
thanks.
-- 
~Randy

