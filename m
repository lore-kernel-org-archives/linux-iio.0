Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795517753;
	b=bzFkvU6f1R5WfSwnHSinN+qBuG8Zg1Kg0pHNPLwl269PeRYpRcVyCJgtTr0syiyLPL/l
	 zPKSc6xcrZeaME3DmsMd9M0/W2sz0/RNxwwoQ4RsqYMlUVagzmCpssghtHhZfv25FrfAm
	 6Ep0Ik+EtZu+a0HYNeD38puAQQka5nmlfg3QObulb+nfi2Pi2TWvWbzrZmo/VxBvL7GE3
	 bqakDztZy0RS5O6EVrueI/B308t1eLFLVHFzFEQ6/R2AhL5rCl0Z9xPkLNQXAv0A49Kco
	 YKWj5PK3r0PwXg+JCEn9CNRF6zkW69IPKtx9+uZmwxqm5EDxINqobns/6fsb7gk9RjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795517753;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=F9m33HuBvYVdhQqa5lYR9CQe3oyxXgSAYLzRzQYmGJs=;
	b=ej0nQDXehASSQGUaWyJRTPSR9OoJMttmqxAWHX+fakYb1yzYtJBuxc4w8NXglj/Zg0oN
	 Thqbtr/Hh2dqoBcoWnThBWfo25wEgf9pOfcAlWQlvNJqm9aCsr5PyM3a1AFCvXtHWrmw8
	 5/cTxletnXN8DtNxZ+Zip4YK8EhkCt56OzTJ+DlARMZJzeEkuwcv99LQ8xae3GZ14ZSyO
	 FTa7W/qTerEkX1lao8/ZJgQAWak+rhyBjds8Ud9BpBvSLZp+SdmEfUvaBTr6T3G7ONyX7
	 4Q1nBvEgQFaKY+FwUMDzNilR9S+Xh0EzArZoHC0EL/IWG8teo/+XA95aDV/3RNsOG1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KX+MFRC/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4981F606A327;
	Tue, 24 Nov 2026 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KX+MFRC/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44631F000D8;
	Tue, 24 Nov 2026 10:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795517752;
	bh=F9m33HuBvYVdhQqa5lYR9CQe3oyxXgSAYLzRzQYmGJs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KX+MFRC/0+65PpE31zgBan2zyXYDmomjuiKFnD9zK5wndDpok4rE6EARXBWGDuFkc
	 k9/JQkSRBfzv1mWko/oSQ0URacrL93VYnamBCCRDBKpBfMdmbOPsgWCazRYcn1Mj3K
	 F8LGcuqRXe759tz+FjQ+qGl0+wgKeVTCuTHuWMfejdGx0LA1hPN8mk73otldTL7Puw
	 fus9dS/rWKLS8UCs9G6YakTTQcRyHhGpRCiIOLs/nKpk7AIg46UEoZwmVfnsEUG6TN
	 VLSvPA+mZD07eQdWJfMu0tDJdY8pg8gXXkFMXEXjiizWAvoScitAnpJ22gha1P+uBu
	 asAreJKKD+eSw==
Message-ID: <508193e9-0157-4ff6-8276-760463ec5e60@kernel.org>
Date: Tue, 24 Nov 2026 11:55:49 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/1] iio: core: Split debugfs routines
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rupesh Majhi <zoone.rupert@gmail.com>
References: <20261124094502.557175-1-andriy.shevchenko@linux.intel.com>
 <09328c36-a32f-488b-a2c9-76fab784d259@kernel.org>
 <awVq-mE1H2g01yS4@ashevche-desk.local> <awVsI5KfsvEruJYG@ashevche-desk.local>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <awVsI5KfsvEruJYG@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24-Nov-26 11:51, Andy Shevchenko wrote:
> On Tue, Nov 24, 2026 at 12:46:22PM +0200, Andy Shevchenko wrote:
>> On Tue, Nov 24, 2026 at 11:17:01AM +0100, Joshua Crofts wrote:
>> > On 24-Nov-26 10:44, Andy Shevchenko wrote:
> 
> ...
> 
>> > > +#if defined(CONFIG_DEBUG_FS)
>> > 
>> > Veeery small nit, but why not #ifdef CONFIG_DEBUG_FS? It's not
>> > as if you're checking for multiple defines.
>> 
>> Or even IS_ENABLED()?  Let me check if we have a precedent in IIO, I will use
>> then the same or most used style.
> 
> FWIW, iio core uses exactly this form for DEBUG_FS test, so for the consistency
> I leave it as it, and if required we can fix this later.
> 
> $ git grep -n '^#if.*DEBUG' -- drivers/iio/ include/linux/iio/
> drivers/iio/gyro/adis16136.c:66:#ifdef CONFIG_DEBUG_FS
> drivers/iio/humidity/dht11.c:87:#ifdef CONFIG_DYNAMIC_DEBUG
> drivers/iio/humidity/dht11.c:235:#ifdef CONFIG_DYNAMIC_DEBUG
> drivers/iio/iio_core.h:19:#if defined(CONFIG_DEBUG_FS)
> drivers/iio/imu/adis.c:227:#ifdef CONFIG_DEBUG_FS
> include/linux/iio/iio-opaque.h:73:#if defined(CONFIG_DEBUG_FS)
> include/linux/iio/iio.h:1010:#if defined(CONFIG_DEBUG_FS)
> include/linux/iio/imu/adis.h:573:#ifdef CONFIG_DEBUG_FS

Fair enough. It's just a style preference I guess, hence the very small nit.

-- 
Kind regards,
Joshua Crofts
