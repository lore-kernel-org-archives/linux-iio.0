Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EB23A63EF
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696037; cv=none; b=lYYUAqan4xWLzQHzWddv9/L7zN0iqOivq+jXy33HEUktw/DHNpIMd19A8Vujsy+RQ2l5l+Fc+QgM3BFGlZ14Dl/CRsvBgyPdYgakskdiSS9AW1U/2qF0ARmLLNHxFq3aKmOxbjK/7bgAVQoMutUiEGT2L1kOprzF8cDycMVBChI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696037; c=relaxed/simple;
	bh=ZFL+7Djcj0/DP230M4MM8TLXMhv1ojlFJLVRfsFJCjQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=MBIgBgDhr9lOpxhHoRHa9fPnsdLxvq58qZAlawmQMzszv0SLAIFU0E+rtCaSPsreWChY6rw8xJwzNA2sxMH+Ol1arXl0hkxhKbMv9GzxCybgBmo8eVm4R9VXCvOt+79jikV+TjnoF2Ad1RyNz8cdHE6c8LJFb/5jaDBKv1T0GO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eedpueA2; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eedpueA2"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3660b84347dso4727757a91.1
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 11:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778696036; x=1779300836; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDI47/lyDeh2jyjuo/TfFuD9uBo+IMd4UEtvl0ZGglY=;
        b=eedpueA2CWtWZMuxpJG0eksFio0ZJxvbHSFP3b1e359kf4OyomE6hx1QSPlgNCKdo3
         yp85SlAHUhSM23t6itdgi9BdxnT8RBeVu8gArFR0aTXFs84RKuWHhgkhY2Qgr4ILVyMC
         YPiyWl6lNk9uS4vh0QNExu2U1cWNwZZoYCbiY/jdrqPWzoMLCdlK7OJqQUSbKdWYTc6M
         hesmwbSHC05d6RVjCkso+iP4uKStZmIuWGbPiGbdIBP1bIEj+S0nGvd1bDpcEuLeiMoK
         me0AMG1jQHARXRSg9uopfxUpi460E49il8K9qA+WAtPaWqroNSpqmRwzpdeziIEw2jKE
         9EBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778696036; x=1779300836;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QDI47/lyDeh2jyjuo/TfFuD9uBo+IMd4UEtvl0ZGglY=;
        b=LwYRtmTXeI3nK843lQKjYcOM8ec5CEAM6e0VVhX30KKV0z/0qDJKiLVokUBr7r1cnb
         MmtGhHXTipxOXCiDPQ+kAqq2/u6IrbmM193Tzh8C6D0iPAqN46/rVtgOxom7IRPgBkfk
         PszMh3KdTcyvELvpWl2vUgNzB0dKoAXWYACw6ruuSoFQ/j7LX/LDokklHitCRPc7L+1Y
         OI4rEc9eVMGfXxTaMwlWQW7Ow9Mq1qBKBBzW3A1R7eDWWtuhZp9OqAAaYuqW0Lc5eny1
         emoekD6x4HhemLjqTLULKg7g7lNDJydwPEgfKHQfsLmiUQles7eVeHWI92k1hLX2Vqzc
         Qa1A==
X-Forwarded-Encrypted: i=1; AFNElJ8KiAdhIUdFaMIkkeo+8VV2hxn/gA8WWl3nIIq4jEi+b4Cc4fsC5fcPaW625GGDcOyGv+Aey5KD6Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSQUNIR150+3GcVSeMtOhEwW/XNdP4XXbppn7lUbZsNUg87MBG
	HWxMhkah1PCWwtYcxFhxaSEPV2udMz1TEWUrGfSo3dlkXTPnYMkaKofk
X-Gm-Gg: Acq92OGSd1w0qIjs1F3MtPHf8E/T1oJUAyluWw8Oc1nBVy4UuDmTehMYVE5oQnk4L/F
	9MxUg4EE2fu/tMGCmYNLmTndAZmTys7+s2rsgWMK34ZkBnUTNrErZ/HPyf7TBCeHBZLccwJ7I2n
	qqSRvWvz5m/Y60CDII7K4VfwmjCvu7PABqO//la3e3WnFYf32JhqqOsX3iolfG7R2oZcxHd/Gm4
	xk3CJp/p+/W3cxlb5YN1mfdxfgD8KClL71Dq/pwIBs5F+TxEQpuPHIXsS/RjAc1RjiWq64ePR6O
	3WqGjFltr/Ot7Pagp/2abIAlssBnjMgo1fMwHn5kQ9BthhNHbg2RT6yd6GxccVSQadJNxZ576QZ
	cTAnYWKNYiKHaM/1fo/PVc7a1Yz6aANJG6EIwGezUjzcas38zkXSzMszgLONrNYmK3zCGmCqk2z
	EK5oEN0g9roOEZjKrTWrz7jUoM3aZmOwHhQQ==
X-Received: by 2002:a17:90b:28cf:b0:366:7dbd:cd50 with SMTP id 98e67ed59e1d1-368f40a3a66mr5027615a91.27.1778696035612;
        Wed, 13 May 2026 11:13:55 -0700 (PDT)
Received: from localhost ([203.99.159.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3692accfe37sm15072a91.14.2026.05.13.11.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 11:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 May 2026 07:13:41 +1300
Message-Id: <DIHR47ZGCUOK.2CNX05W0I8F6F@gmail.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v2 2/4] iio: light: veml6030: fix channel type when
 pushing events
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Rishi Gupta"
 <gupt21@gmail.com>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Matti Vaittinen" <mazziesaccount@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-4-g02324e9d9cab
References: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
 <20260513-veml6031x00-v2-2-4703ca661a1d@gmail.com>
 <agS5Xu8ORtEwuwOB@ashevche-desk.local>
In-Reply-To: <agS5Xu8ORtEwuwOB@ashevche-desk.local>

On Thu May 14, 2026 at 6:48 AM +13, Andy Shevchenko wrote:
> On Wed, May 13, 2026 at 05:49:42PM +1300, Javier Carrasco wrote:
>> The events are registered for IIO_LIGHT and not for IIO_INTENSITY.
>> Use the correct channel type.
>
>> This bug was introduced in the first version of the driver.
>
> Unneeded detail, if it's a bug, use Fixes tag.
>



>> When at it, fix minor checkpatch code style warning (alignment).
>
> ...
>
>> -	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_INTENSITY,
>> -					0, IIO_EV_TYPE_THRESH, evtdir),
>> -					iio_get_time_ns(indio_dev));
>> +	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
>> +						       0,
>> +						       IIO_EV_TYPE_THRESH,
>> +						       evtdir),
>> +			iio_get_time_ns(indio_dev));
>
> AFAICS the indentation is still broken. Why not doing like this:
>
> 	iio_push_event(indio_dev,
> 		       IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0, IIO_EV_TYPE_THRESH, evtdir),
> 		       iio_get_time_ns(indio_dev));

Hi Andy,

Thank you for your feedback. According to checkpatch.pl, both variants
are fine. Mine takes into account the indentation within
IIO_UNMOD_EVENT_CODE(), and yours only accounts for the indentation for
the arguments of iio_push_event(). Moreover, your suggestion goes beyond
80 characters and mine does not, so I would prefer sticking to mine if
possible. As I said, it passes checkpatch --strict without warnings
in both cases.

I will send a new version adding the Fixes tag and removing the comment.

Best regards,
Javier
