Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E17D36828D;
	Tue,  2 Jun 2026 02:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780369131; cv=none; b=U5GvmlgE4ZoRwS8HqmLLEeBKmpBCe4p7s8mHzG4wCLp+kAzO7I9bccd8b++nSpU82NpasiJgEugcLGeXGsfIARu/9s+stR7JbwuNmCRRIE3YuGlzZLbdjaKJ7oY9BNlgIm5tUeThF4K/V3n52LpA3lMJWjMplIEqN11Ne7Eryeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780369131; c=relaxed/simple;
	bh=UNMkoy3z15TroakKSzBmQOpIHp5A2mzHqvr2w0eOtDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQjkNcK4SKIJePqGyK5lW4lIR9+SoQKENN7GWRNfquuodfAYKPhJAJpu4S6tkiyb0BWYTMssjiEGdV9o+IOyLRvWoGHrsjE63nlzLvq6MmeQb4x18oVn3amT61PXE+qe4hyBeQNS4lVaidE/4fxuZ3T0fDdkzO1GAkteboV61SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tfB7ZBKR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tfB7ZBKR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=wl/6s07fOIxt1sNU5e5pf7Qzlm0rqHckHAAOOhcPFd0=; b=tfB7ZBKRWIw2MR/XjoZpw8+NnL
	Ccgk3KNXqi89uNhLI5bX9W4KlA7s5rp6F+ck5/s2BSry0Stk/idT23k7MRcNZY62dKcSuV3EiMvrD
	0HQUg02Es2m6e3ONtqc5OOqKgeHhiM1jszQeBDaWdPlYT03i/o50h5tEQ/VF8Xs0T5vuTFQVr71Wg
	Q8s7StbqIeXcE/9WiLDJVY7dnGf+0zaH0769wBew8Rbo5Ip2xy4bdPZ6Ltt/QVm3rmvpuInacso4W
	SU8sgzw/S+/cujPdCIADUzxH23v34/g1MUgWKYA6rHVyqDQEYHWwVVPiNLMtpwQaelDTZmzgVGyL7
	wM6TVCUQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFL6-0000000CCc9-2wwn;
	Tue, 02 Jun 2026 02:58:48 +0000
Message-ID: <e8e385e0-8ffa-4401-b676-f4c6d28f559a@infradead.org>
Date: Mon, 1 Jun 2026 19:58:47 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 12/12] Documentation: ABI: testing: add common ABI
 file for iio/frequency
To: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260531-adf41513-iio-driver-v15-0-da09adf1c0dd@analog.com>
 <20260531-adf41513-iio-driver-v15-12-da09adf1c0dd@analog.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260531-adf41513-iio-driver-v15-12-da09adf1c0dd@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/31/26 1:30 AM, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add ABI documentation file for PLL/DDS devices with frequency_resolution
> sysfs entry attribute used by both ADF4350 and ADF41513.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-frequency         | 11 +++++++++++
>  Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350 | 10 ----------
>  2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency b/Documentation/ABI/testing/sysfs-bus-iio-frequency
> new file mode 100644
> index 000000000000..5af31b5b3a19
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency
> @@ -0,0 +1,11 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_resolution
> +KernelVersion:	3.4.0
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Stores channel Y frequency resolution/channel spacing in Hz for PLL
> +		devices. The given value directly influences the operating mode when
> +		fractional-N synthesis is required, as it derives values for
> +		configurable modulus parameters used in the calculation of the output
> +		frequency. It is assumed that the algorithm that is used to compute
> +		the various dividers, is able to generate proper values for multiples

Unneeded comma                      ^
although you can find many varying opinions on the internet.
I agree with https://www.grammarly.com/blog/punctuation-capitalization/comma/

> +		of channel spacing.
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
> index 1254457a726e..76987a119feb 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
> @@ -1,13 +1,3 @@
> -What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_resolution
> -KernelVersion:	3.4.0
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Stores channel Y frequency resolution/channel spacing in Hz.
> -		The value given directly influences the MODULUS used by
> -		the fractional-N PLL. It is assumed that the algorithm
> -		that is used to compute the various dividers, is able to
> -		generate proper values for multiples of channel spacing.
> -
>  What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_refin_frequency
>  KernelVersion:	3.4.0
>  Contact:	linux-iio@vger.kernel.org
> 

Tested-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
