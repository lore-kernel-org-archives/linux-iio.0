Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ECC2D5410;
	Thu, 26 Feb 2026 19:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772133251; cv=none; b=YnT2a9mDio8gQsGInZyxaE+k7CBEtCb9t281rs7MeiaZVRgldAjky5PecMCryzToxZHrQt5nkkUD6hqBpymxG7J4kvddIpefEELVqI41tDm9s/ysyz6XDsZvpYVeiSLT54s2zgwiqZdRbH/j3JYaEHcdNfmuxAHnGiA5XYAw9Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772133251; c=relaxed/simple;
	bh=U9P5fchUz0giFAeYYeSOM18lPiIIaD6UiUl6bwHmQwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGzaYdwtde2KAoneaPqRycjgHsfzlwROw2VORysWcc7ZSt9Y8402x3Tas83vPpdfA4yi5EKUUjygpxnq4bdGPhcXr9Gi20laz2820tkMS6K3ePfmV0oMXwCvaTMPtnf9+UV+hAhO3edEIK4QIUSqSz4Qfp02lagxpJGF3EfXYd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KKC+qjr3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KKC+qjr3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=qHRcqVTyUw3p/YbhGSr98hvaR/vpjGBQoRrHKZx6tkY=; b=KKC+qjr3+rCCxkWupR5gizI8ex
	qfGDvDU76m8O56jeLn8PkiYfkTbBzOhioEeJ34AGMOxK4xra30X5pyH/OURbrPfkJsj4goDThbTRU
	sY+/fgDfN41lQ4TtxOzUUKpHgmCO/GpTEd3qHdae+8KYXl4ooND9hcmLycU4k5HxN7OtY+Q9NsTY0
	rrFG8j4D5Tw2eMluLoYDcoGieUWcyMLC9ilp/o1ZUM5zfqavvhMJ78ufGmZNbbKMMekG8h0EvSKCx
	3Kc+8jMM/5WYNSF7dEoOllPpCE9EaMGBU5+G8e3v6uJtmpnYmIEONbmSs2RTqer7ybT5bMhSGYHlQ
	QMVAS/ug==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgoI-000000072N8-3yRs;
	Thu, 26 Feb 2026 19:14:07 +0000
Message-ID: <7f61d93a-37df-44fc-ab47-b0e5ff70259a@infradead.org>
Date: Thu, 26 Feb 2026 11:14:05 -0800
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
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aZ_-pVTbTUkByPIJ@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/26/26 12:04 AM, Andy Shevchenko wrote:
> On Wed, Feb 25, 2026 at 09:12:57PM -0800, Randy Dunlap wrote:
>> Use the correct kernel-doc notation for struct members to eliminate
>> kernel-doc warnings:
>>
>> Warning: include/linux/platform_data/tsl2772.h:88 struct member
>>  'prox_diode' not described in 'tsl2772_settings'
>> Warning: include/linux/platform_data/tsl2772.h:88 struct member
>>  'prox_power' not described in 'tsl2772_settings'
> 
> Hmm... I do not see any of the user of this header file.
> Have you checked if these values are even used?
> Perhaps we can simply kill all this?

They are used in drivers/iio/light/tsl2772.c.

> But if Jonathan wants to take this as a quick fix to make less
> warnings appear effective immediately I'm fine with the change
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Thanks.
-- 
~Randy

