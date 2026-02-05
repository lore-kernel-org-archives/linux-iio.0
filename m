Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BE330594E
	for <linux-iio@vger.kernel.org>; Thu,  5 Feb 2026 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770315153; cv=none; b=FNn7AcJ69dzeFOQfbS3QYKANjaRjqGYJSew3OccyH9gutjLsp+/s82EzLJKvyj1ulTaHywVNdF37TVOOr9k6gqbNmmvV6yZZc7Eh5k0+pxdsirCYS0dUnALkSMxQREsjNXcLLtun06wZzZab0FQzRcDqISt5jjkY2/Vu2q1Dok0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770315153; c=relaxed/simple;
	bh=XXS3QVcIUaUSfcQ9ULhT3Ej7GXnyl+nRy5BEyXYzciI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlYX9sz4TqJMuJ573rIT6kCk13lMMdCsVpZgPUJJdRyI/kIXET3E02bz3HOweuV23z/wLaUH0fOHI4ynVk5GqQyB9qD+Exle9Ikk+x/Jc8r5fFvXdeDqHYIllNqKVwF5R5Lrm4tZ2wQ5IUeAxASjot243TJurtQ0JXKWuJUzaP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBCEQ+f4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBCEQ+f4"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4801bc32725so11044995e9.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Feb 2026 10:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770315151; x=1770919951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xR39UmjmxyNbJqgJNfJ53SYTqnUt7hECaIRgM57CWoo=;
        b=bBCEQ+f4emlZgmjefzuynVqaIUfooaWip8Phg0hCvBbeQ3glnlLNHavZW0pFVT4Fk+
         56cGnQrjPWYd8Gm+oGcNT4xQTYdv7X73UCpED2YCZZbmMaq6tsUf2hMAQeBtex9b5btX
         t37YWwivMAlFRJro3AIhFYHKbKakOz5oEi4pXfIkLzhGrbfa2ZR17dhwBwbzZxhVxufH
         pwst+yHpRd0ggi3aDc/EI1nA7I92cT9ik0iQt9RjF2Xln1R8fTex7TRmflwmeNsoeCp4
         iY2AHn8cybQ9u2yjNHQ5F0EzoDlKiOzh9EUenXb03qjyNBYpEmNo0mXfMJaGZXovpiJy
         /i9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770315151; x=1770919951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xR39UmjmxyNbJqgJNfJ53SYTqnUt7hECaIRgM57CWoo=;
        b=Sv0d3mIield1xypKj7WNOPXlwwPIxbU6cqlvmd8WIMdebvi2FourAXfDF7IOwZXWym
         ZLxiXXzdo6TnSOpUkxTRm34w8NyHWIn0TcQDl+1xrRuGRR+Jm+bIHqnPhL0BTbTos0JW
         CLNQDu0zx+7NnGAT2y4gCF/FpkDt9aRF1KNvtqXzxJ1HrMHg0UIFFrJcn5Cv2MFXceS1
         dImRRjHap/3vmvrBqUBzeR5t/9dhTcqLuUEZwl8acqOdP3mURCag21DXo4Env9+ofrkN
         d/oJBVSHaiQyswuGDqgnnYNtw3BpfV2BwSFrVCvBH1kVB3GehVrudzzLtNBkiYdDDBvp
         zSiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0ceXu7LlC3Jz2TlwWnlvkb/rE7ZgUZ1pBAOk9/O70ih4JVnSqYPs7lg2kDAR7uOSZCRtZStYaE8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrffN8wSm3VYGgUdI6Z6QbRm96nTkoEINawLsJOisEym8xD3Ua
	VuF5SR2P24SfZuYHFynzTaKi55kkIgFdZlA/e7mJ4ley9ibj13C5tZ6T
X-Gm-Gg: AZuq6aJh/miaSt586ZMaMteiWFvgZrRHOe5sa13gQAICk+9w+t5Eq/uZERYKRawigbf
	jaqxbGP1u/11QY2tJemmeIfi1/4iwWkgphOFapl/hCfJ6HKDiMFwrr4UIt6eLUUr3aZ7EjxW3Oi
	2F2uOm+bbWErnRX7CyXbnh1zHB12osWIlXImJWCbA0+uFbslJDMqSO944WrBYa50x0qeZDHBjBV
	LfYDLtmkXtIIEutWYUmD8xawb+UzLZK/r6jxoFH5xCXOIcPdj68Bx9SanhyMekDHPixNWKSvy5v
	vBG5ogCbDGsxxaQM+txSHxpGlWQt4uaMmm3t6tBhNNHM2eukZ6b+BeVgSrX9zMrfzc29UwggOwv
	MZAxpUFK+igo8BLlJINJpdONdRJjF/2zy/fzn2/Eof4bbk/HaZfHgTdC/IfO+1y0KosnQAZ+I4i
	D/+QDgdFBEJYKTMGqy62e3JxqVAEGQ83hEA/gLwBwW/NcsvEYF1twgqyW9BTzU+K+FBryN7lfw1
	dyg
X-Received: by 2002:a05:600c:8116:b0:480:1c10:5633 with SMTP id 5b1f17b1804b1-4832021c74cmr3672795e9.26.1770315150969;
        Thu, 05 Feb 2026 10:12:30 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d57009sm63665465e9.14.2026.02.05.10.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 10:12:29 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Thu, 5 Feb 2026 18:12:23 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 4/9] iio: amplifiers: ad8366: drop reset_gpio from
 private struct
Message-ID: <rp62czb4n3ag64cgluwsodubnqxecod3cuu2agyedqed2vwi3j@qs3e7xhf5ksk>
References: <20260203-iio-ad8366-update-v3-0-5d5636b5181a@analog.com>
 <20260203-iio-ad8366-update-v3-4-5d5636b5181a@analog.com>
 <aYKnIjBS5OT0MxuY@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYKnIjBS5OT0MxuY@smile.fi.intel.com>

On 26/02/04 03:55AM, Andy Shevchenko wrote:
> On Tue, Feb 03, 2026 at 11:24:10AM +0000, Rodrigo Alencar via B4 Relay wrote:
> 
> > Remove reset_gpio from the device state struct and turn it
> > into a local variable, as it is not being used anywhere else.
> 
> Why not switching to reset-gpio driver to begin with?

No particular reason, consuming it as gpio was already there!
Is this a suggestion/recommendation or a mandatory thing for
now on?

looked over some examples, some are not updating dt-bindings with resets,
others don't have Kconfig requiring POWER_RESET or POWER_RESET_GPIO config.
Those things are necessary, right?
 
-- 
Kind regards,

Rodrigo Alencar
