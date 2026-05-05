Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109FA27B34E
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 00:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777940764; cv=none; b=o+J7+nhEVxgrwzbkyeAD6y3VaTIMmIj1mQ0bM0Xyv4aW+YbSby0Rz5wwKlGbhPoZqWfGNm58WDBb9A+9qeAxChC+k9hKKq+IMy36C0+U7ezvOzyAioPBIKLsrHe6Yi/iWafXxo5HwWImW5AUbwvOLvdaE0boDSH9PIBdYobZAR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777940764; c=relaxed/simple;
	bh=X115XF/LafrmdkHmbl4MoI4m0/kJFbRUnh/JSEI0EkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbIhPejZgw0r1IwjLZvae1Ob7rA2ojUO6YTNkP3iOMz05zhWRLs79ZJmY8ybkcAXCOJbrneENSVL/9XR6Rrj5Xtggwt3ntr4Wf1oWxXW1OziRNfsUHDKZTX+OvRF0ORiCDtFT6DPeqWLPiR2B9RZHsVYliVawKftKQ0wXgTXJqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=km7aIOwv; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="km7aIOwv"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ef84d016d9so6845147eec.0
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 17:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777940762; x=1778545562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eykFpQgFUZeLAatgtqrYUzE0cfRpZQld9KUP5h9cwA8=;
        b=km7aIOwvRJimuODyh8v8ZmY8xSZxrYE41COs/OoPIOi45iHzd0PLl9zAsmynqGob0b
         JB4L6vX13g2ZtEeaKw8G5OIexWorBWgpniOEW25i3rEbj2+zkV13Dx2M66XNaX0fephf
         I95P2pFjXZe74pIkzz1HJZX3EPtqJ2bPWrTIX7ev1XocqyYWAP/1LrLXZL2i8CDymDZn
         hfr9EOx3iGfthaxcNRcBYgtOXXsbSPZl0dMnOlAGjmTGLRcXe4uVu8XbcUYT7up4aE3I
         WHe3y9zYhG0ZwiR3ZVu4jVuWpokAwUAvZNRc3/8XDYCrtADPFb9AtSAeqe8VH+MJUuOC
         YJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777940762; x=1778545562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eykFpQgFUZeLAatgtqrYUzE0cfRpZQld9KUP5h9cwA8=;
        b=WbVVhQts6BimGJKOblRyvrv+DB6uPxNDyZvblUVHqIL5iWoclCHoZ01ypkO1pYYtK0
         050axPYhI8zUM9j1Cb6IcgpNxBMIT8zDWyKZYqCz05JrCkNmPzdY7jde69AFWZcUarHG
         yhoyumy2kLM9pIAtZ7IE8HwrX3Pmu0eAaKrRvWWpOiE0Chw2ZQ7mTNj8/BsJVH45cTFI
         4kqeDnNp+aY0z8/LVdmyfFHzs10BEUAQbmRzzMXEHz92S3uCdYgnBtWNrDKiIY8pbgjg
         9qRz2KzdGynN3YXyr4jf6MMZsijKgJenGCoLwgr1SLBh/2H7pvZOwJ5Uj324UW8VrAoL
         0uKw==
X-Forwarded-Encrypted: i=1; AFNElJ+2lBMH1RTgf3A0u5kT0uABvfW9kBfdZkDesA3DFuEXB65Yusv3PfLvuGec7f6VnTDo59zF5tH+3Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyefrG32RE6uyHII2y5IdUFXlBuLTzkCJIA9YPnmECxik4hGIIu
	niHEu9cRmtBGVoRV0WBcQ9FdtYrtoCPqR9DrEsGT30H1DkequLnDFNIZ
X-Gm-Gg: AeBDiet/5kHhTpc84U3eItLlQcwitYgg7sKyI32eptpJehHIUyYJ0EC43hn+iSwM9Ae
	rvxcLx8wjLAgGA7AEhROSehPQPCGaXYNgIqGHZ/2gBmjvdZgdoJpT4bTwhMEQGzjK00B/sD/UIF
	+ebHPIu/+ey6biCgd2es6C1TapyqWGClkWF/vENX6qs3DHNhV9FIB43eQv8NNlqVSwreLUBKZkq
	jyjZd8kQlAKJrRjPVfL2XdPkb5zqc8xZ70GK5wvolIitSyfD1jtij7PM5YNYNQCB/zGNt/wX9Ei
	VzzEHoPXDlRDyfHktIih9TnuPdMQi94rkZkC7LPLNMyrUigStODMoF96Kcq0y9Z56PuO1W/nlxB
	0lJ2RSGhAPGIswasELerANgjXvZmr8cZYoj8nqAry9MbQ522k/8YWDOoLSzXb8qT364VUkPFN5l
	/xNFx8VHesXf3lzddlB1cXRsMn6Fmfe0Ys0YGKOaFs/oFdf/Sv8hU841vhGAzFb0aERGLIQ+raK
	YU+FlT/llAnlA==
X-Received: by 2002:a05:7300:a18a:b0:2c5:60d0:701e with SMTP id 5a478bee46e88-2efb79cc45amr5796129eec.3.1777940761972;
        Mon, 04 May 2026 17:26:01 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5b87:9b19:32e2:2981])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3c05dc28sm17470773eec.30.2026.05.04.17.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 17:26:01 -0700 (PDT)
Date: Mon, 4 May 2026 17:25:58 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/4] ti-ads7950: fix gpio handling and facelift
Message-ID: <afk48YT55Y89Gq0J@google.com>
References: <20260405-ti-ads7950-facelift-v5-0-1f980ed3cf9e@gmail.com>
 <20260412193856.1300770b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412193856.1300770b@jic23-huawei>

On Sun, Apr 12, 2026 at 07:38:56PM +0100, Jonathan Cameron wrote:
> On Sun, 05 Apr 2026 21:39:22 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > The original reason for this series is to make sure ti_ads7950_get()
> > returns result in range [0, 1] or a negative error code to comply with
> > gpiolib requirement.
> > 
> > During review David noticed the fact that the function also clobbers
> > gpio state. Fixing that lead to adding cleanups using guard() and devm.
> > 
> Applied to the testing branch of iio.git. I'll rebase that on rc1 once available.
> 
> Thanks for persisting with this. Indeed a nice facelift ;)

Jonathan, is there anything else you need me to do?

Thanks.

-- 
Dmitry
