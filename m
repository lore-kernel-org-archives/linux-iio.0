Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE882ED15F
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780400573; cv=none; b=mcpJN1QsrZzUAC2FozIN0gQ/lN/h3mmryZBtnDT21DMFewkhu2Z5+nipmPmVboGui2Z+qSd+vtW3kYbgpirdSAHhaROCMmBrYlZ3kUzxvcML4KLY0hgwU2HuCDCjWMrPGIYJGtzoxX5CKPEGszSCZal578i/3EHLdUdkv/LIrmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780400573; c=relaxed/simple;
	bh=Qqa7quuFUGxOZHeycKFVTiZCmNmQh4Y1IFeUEExbxWQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=CgY/AkmiZSu6ozKtqOqhfvrpKefeow7UDcI21wU0G8OGsxu7YSjFhZYJw+6hBXESo+nN+C1FEqLXEOuNpNo2x705svN1eIMlYgKEUqDuslRF2LVsJvnTLkIDd4z1EKSq7jk+U3r4GQHyHFk+nAUrmsgu6vCoKj9g87EcK/QLzRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXCcF+QJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXCcF+QJ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b09e4cccso7442555e9.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 04:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780400567; x=1781005367; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89aeVXXs2STJVpXGsIdEuOvDZI5VpWNiQnZYewdJlX0=;
        b=FXCcF+QJTa8+LxZOrDua7doGBLx4bPh8i3YVXaaj4SqpPQ450zwWE062Ga+acGJD4J
         wJPix7Oi/HkRqFmU+FZ9L6nOtDZhuctRTngG9630aB9UDKLGCn45qKMrkYj2p/S5gbKz
         2yRTp0Ho/3Ln3EC2qsIMBFJiyjXDPygQVYNbmWpbXARYnHjKiWqvMkwkX5pHoH47Q4xY
         RL7mwFw3SpO51M7J+mWP4cISTFD/H0kjBZYyDDxtca/EVBVxm0Xnux1V2FHTE4QBj2c3
         oFl2l4d7vebacpTD3uMGS/WrVLnzif5MgNBvuwiEEgnD4WgDrheAgZbWJkfv7czi9T+i
         SP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780400567; x=1781005367;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=89aeVXXs2STJVpXGsIdEuOvDZI5VpWNiQnZYewdJlX0=;
        b=n/uT1euXL6cwYEglwIiDT0qRmqrORS62WXpxM3JmsdH9lwk6SpWCywq56Y8OqHicn3
         56+SFSGPG5Q2byk3Q/HAdyj/GA/9KNaPDsDgTJQg/mF4/y2mi/prS4G1MvT5BZkX3/5n
         vJLyB8xyWvAxRMyxnN6urzjzlvFl+Ia2Hd8zNaFmQM8C2aXkOf/ttvG55LhjSeGEbIpy
         RnUeB4cU8y9yD/3UfIPT+Aemm5eMtYDdpojKkyprh0pNPoMZ58hcOkjGlTloZ4KT+plb
         qpJqlguhbJyGwKSxHudjtp6xG+r+itgnr3JXgpLTOl4glKSpSsBWbJSqPU11ntab/Kr7
         Walg==
X-Forwarded-Encrypted: i=1; AFNElJ8mDH565oHRdD92wy3pZqlSvE9TGovGRmY3DweKNqBRx1DSc/rRKxSynpa6j/ByE83IhoSZpvwIoG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqw5bvuY82MhfxzTTZXYeNGnGmd5Q4gc0SEnKrZGAQVm5y+ErR
	Mzk3UGNMxK663/HGCNaPM3RuQBoT94uVslFUsym3mFIZgixMi8obPECD
X-Gm-Gg: Acq92OF4IvAg/M3zMc+XQb5nXD9arEYR1nQqPCvBQJoWO6nNmXgz0DcGreLXVbJDY7e
	ZIQiD4tF+dCrPziZkCkEajPqq/kmZ4URYNkP+liEIPqhOZxV/2IPAtAASVPj7mU00kUo7ePFcxa
	0V04j/djDsS7Xj0tDhRvOwBNCf6zphIvxcFmpIRDjPLWK99rG7E4e8P4lKAW1vzSK/OieXw/9+j
	kE1m5vUZlRXZ57B22M2kkEbN3a112huF7uqZXcIvEYoKMQrpEbSQ7cUMEmuQIFjoAP2YYVf+MaH
	+MULdMx3VhA/HDLOtpmH/7MpOWNwZyEIh/kHVv6TcUvPTIZmsnCvS79H4EkiBNLrtWwWLYuzkPN
	1xATypOiVkKOPA1b6NP2nEKRabq3OQ8zhmFi1OibgBA+NNnKSL25EJEk0wOGxi5/uAsCb3an0XA
	y2fQ97nWZgGF9mtNZHtK/rOojk1YjsBeNH7eKSYcpCZ2Cq2Yc=
X-Received: by 2002:a05:600c:82c3:b0:490:59cc:999f with SMTP id 5b1f17b1804b1-490a2901c21mr286995725e9.4.1780400567217;
        Tue, 02 Jun 2026 04:42:47 -0700 (PDT)
Received: from localhost ([2001:4bb8:152:df59:3b69:56ea:a39b:adb4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35874b7sm33027728f8f.35.2026.06.02.04.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 04:42:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Jun 2026 13:42:44 +0200
Message-Id: <DIYJBS4F362A.2LIDZAKU7GBBU@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Rishi Gupta"
 <gupt21@gmail.com>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Matti Vaittinen" <mazziesaccount@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Javier Carrasco"
 <javier.carrasco.cruz@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v4 2/4] iio: light: add support for veml6031x00 ALS
 series
X-Mailer: aerc 0.21.0-143-g2f3a2e260c09
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
 <20260531-veml6031x00-v4-2-e64f7fdce38d@gmail.com>
 <ah6p-f2RCW8VcuDR@ashevche-desk.local>
 <DIYI40YK6CSX.2P4017PHVJHCT@gmail.com>
 <ah66ljSiIc0ywFC2@ashevche-desk.local>
In-Reply-To: <ah66ljSiIc0ywFC2@ashevche-desk.local>

On Tue Jun 2, 2026 at 1:12 PM CEST, Andy Shevchenko wrote:
> On Tue, Jun 02, 2026 at 12:45:35PM +0200, Javier Carrasco wrote:
>> On Tue Jun 2, 2026 at 12:01 PM CEST, Andy Shevchenko wrote:
>> > On Sun, May 31, 2026 at 09:58:22PM +0200, Javier Carrasco wrote:
>
> ...
>
>> > + array_size.h
>> >
>> >> +#include <linux/bitfield.h>
>> >> +#include <linux/bits.h>
>> >> +#include <linux/i2c.h>
>> >
>> >> +#include <linux/module.h>
>> >> +#include <linux/mod_devicetable.h>
>> >
>> > In C locale it seems wrong order.
>> >
>> >> +#include <linux/mutex.h>
>> >> +#include <linux/pm_runtime.h>
>> >> +#include <linux/regmap.h>
>> >
>> > + types.h
>>
>> Do you know any tool to automate this beyond asking an AI? Manual
>> auditing is not very reliablo and it is not that difficult to miss a
>> header that has been indirectly included. Building with W=3D1 and simila=
r
>> stuff did not help.
>
> `iwyu`, but it needs a custom configuration. Even with that it's quite fa=
r from ideal.
> The custom config had been shared in the linux-iio@ mailing list this yea=
r.
>

Thanks, I'll take a look at it in case it finds some more missing
headers.

>> >> +#include <linux/units.h>
>
> ...
>
>> >> +	/* integration time + 10 % to ensure completion */
>> >
>> > fsleep() adds up to 25%, isn't it enough?
>>
>> The problem is that it adds UP to 25%, but that is not guaranteed. If
>> almost no extra delay is added, it will be below the margin I added,
>> which was necessary when I tested this delay with real hardware.
>
> Noted. Can it_usec be precalculated already to include that 10%?
>

Yes, that is possible. I'll add it to V5.

>> >> +	fsleep(it_usec + (it_usec / 10));
>
> ...
>
>> >> +	pm_runtime_put_autosuspend(dev);
>> >
>> > Hmm... But why? Wouldn't this be problematic with reference count on t=
he failed
>> > devm_iio_device_register() below?
>>
>> I could move this a bit further down after devm_iio_device_register(),
>> but as I replied to a Sashiko complaint, the reference count will never
>> underflow in this configuration.
>
> Please, add a comment elaborating on that, it's not clear at glance.

I will provide the link to the message where I explained this instead of
copying the explanation to keep the discussion in one place. The mail
belongs to the discussion thread for [2/4] (this patch) anyway:

https://lore.kernel.org/all/20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.co=
m/

Best regards,
Javier
