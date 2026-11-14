Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794699672;
	b=Vh8gRQh2AiYyJRir1ymjZ59yure0wBDXCCkGwGryQyX1Zy3KaWDFHIb7mHjKCKSty9ba
	 hWucHWjo4Q6aNyAzNi3N0ja0mbEzZnUSfyxyb7xBJIAYKiPuawqwV7c+7SMfqujeVCNQT
	 lQO+lytV4IGyAXFwUfJVRKWC8KT8/DrTqwAno0W5nsaPr+Bx8Zasvzl1eTK/aZUPsVmTz
	 fiFtVS7ADluusLzdQFPk+nC/HNeAiR69DvrPEtCyguNa2GpeM9+z/k/ATqlchxGih53Z9
	 1/Kn+wyGvW4Fj40zDEv5B8Qo2TgVmbFCtroCvr/1XnpVwdaWr4z7C7e88q3yqHISY5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794699672;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7jIg84RYZgIQMkeAqHqr537eDa1BlrYALqloBqR+ZMk=;
	b=ewUKP7Ym/PctcscQ/LpyypQjzwrOZf5UXPD/DhzeowVxh2mtR73L7vgtGZ2mWxod3ei1
	 79C3FevF90I0Joedk/95HZ678NCiNr4hI72GGE4gjARTAZIaqCwoa4X9xre41PDazA41J
	 LwAAKdZmjL1AGDIrQEyxkZ4BWCnAnWcSPU9O02IHlREnxQFpoY5R6z+07nlT3xJLiwadQ
	 OwAq9i6S2A/d+pbd5C/OMNP/31Acz8VcxPCII76Uw+YKMaL6s/B4lqdgnIT61oWZUlBCA
	 waAYrtKtQvXVzVn4PuapoSu8ZIf16PHSkY3+5y7GpIAWjHf9XuJqlHP1NKCYMC2/h8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="j1impk/S";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD35606A323;
	Sat, 14 Nov 2026 23:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1impk/S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EE91F000C4;
	Sat, 14 Nov 2026 23:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794699672;
	bh=7jIg84RYZgIQMkeAqHqr537eDa1BlrYALqloBqR+ZMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=j1impk/SgSHpSoJEjSBbK66+ND0z3mHggjZB4Wf/li3eCXLYH+79CYiA//6xNgLCV
	 iKHukdtL95uRmva8I+iRHEjXSfKCq0UgcbXwiS2D1pepYCXkuFtUUquPts3d1CnaVq
	 wq8WKMmrjB8uerF60SzRtYkrmpH6dtj7PIUHA5aRmMxA+eiNDaU+JXPkFYGJtTzrOm
	 Avu/zQcuYXuSBoBBfy9fheXNnJU1W0HpDKc2t8s0riFhuVsn4t8r1OudKvsWO6hzx9
	 uAEz5Ir83pDNB6x+0AJu/EL1vqa2VBS92GUdnxBAPxZ2KNl93Fe7I3cP1Qe4YeKkfY
	 z5j+/44jxqo7A==
Date: Sat, 14 Nov 2026 23:41:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Arka Mondal <arka@arkamondal.net>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Robert Eshleman <bobbyeshleman@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: max44009: Report the integration
 time via read_avail()
Message-ID: <20261114234106.3b7b0f0b@jic23-hlaptop>
In-Reply-To: <avJVHXMynrrMiSzK@ashevche-desk.local>
References: <20261109050738.93424-1-arka@arkamondal.net>
	<20261109050738.93424-3-arka@arkamondal.net>
	<avJVHXMynrrMiSzK@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Nov 2026 01:19:57 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Nov 09, 2026 at 02:07:38PM +0900, Arka Mondal wrote:
> > The integration times the light channel accepts are listed by a custom
> > attribute named illuminance_integration_time_available. That name has
> > no in_ prefix, so it is registered at the device level instead of
> > beside in_illuminance_integration_time, and userspace looking for
> > in_illuminance_integration_time_available finds nothing.
> > 
> > Report the list through read_avail() and drop the custom attribute.  
> 
> Will break it user space?

Yes, but given no standard tools would have looked for that naming
we should be able to get away with it without anyone noticing.

Given it's an optional attribute I'm guessing everything just assumed
it wasn't provided.

Always the risk of a custom board script of course that might cause
us to have to carry the old broken ABI.

Arka, you should clearly state thee concerns in the patch description
to answer questions like the one Andy raised.

Thanks

Jonathan

> 
> > All eight values are a whole number of microseconds, so they go in as
> > IIO_VAL_INT_PLUS_MICRO pairs with nothing rounded. The values do not
> > change; the core prints them with six decimals, so the attribute reads
> > 0.800000 down to 0.006250 instead of 0.8 down to 0.00625. read_raw()
> > still reports the time itself as IIO_VAL_INT_PLUS_NANO.  
> 
> ...
> 
> > +static const int max44009_int_time_avail[] = {
> > +	0, 800000,
> > +	0, 400000,
> > +	0, 200000,
> > +	0, 100000,
> > +	0, 50000,
> > +	0, 25000,
> > +	0, 12500,
> > +	0, 6250,
> > +};  
> 
> Make it 2d array.
> 

