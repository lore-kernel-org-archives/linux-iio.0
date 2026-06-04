Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30064305064
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567621; cv=none; b=sBivrewNZeC+DWuLJItCit5dcY+1hP+zcdYV4L0VdAiIS8+H4hOX9D40wGb+wKijinS9shCuKpCI5oxloUme02WdGLooqtRwu0futoeEIVvhDjgFqT4OjNiyb4rIfX3++B4eyJQnIOAK0Q50t3pfzq+fc5HuU91yEkK7xtOxcSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567621; c=relaxed/simple;
	bh=aWQNwrGhLrvNTQcedUnw5Zv25r/4ZU4XEGrfG6DmwE8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0/amiNvoTIY/QbTkebzFeyQARV2USvbWHahdeFMIZh2kxF5m9dwfX16+pmCNwjino8tLkz2D4rv8nHmy3jLc/UQ5jFoOPBJA/kRLd6ukEh+8HtadlmVS7x/Juo07nlPDs1fgmckOLwaEk7FF9fTQsEmIgdrTRcNVC7fGpQIP3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lf02ons9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lf02ons9"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b4a8e28bso4509245e9.1
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 03:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780567619; x=1781172419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SNSiTxO5U+OGmSsX5QsPHvILMfiW6g2hJB0TI+2zqrs=;
        b=lf02ons9EPlxYHI8acFUzS9EKkvjAwyd7l9jN69qEXMAUVpyPxuiiR1NFZEmULEqQh
         afc/eNmeeULukc7MiGLpKM7BjbYnGOiQygoa4hzCxB46POrftHMuq0Z9rIV9MU5nFhiA
         1YzPDXqw2/tWz+WmpkyBmNqMvtnuntxwEyEFW/HtokTu1pFdGutddJoY7yTnlV5d4aEf
         ePE0fO0adgpjngIJZqVgmaYrr01yjj+BParMG9q5DIy0X0dQyK5SXP0pvFo2WSYaaQ0p
         gI7YeHGv3yVROA+w6oP7cTC0wlU9Z46d6OGHr9L0ZqDbk0rqLqx8zDQ2ji7NuZ0xxe0P
         4oCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780567619; x=1781172419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNSiTxO5U+OGmSsX5QsPHvILMfiW6g2hJB0TI+2zqrs=;
        b=V+YqGP5v8pKxCNUViZFmMcWSnpt4eXuJF61pyyGs7vyPHazL0CS3VbAIgtJcRAp7uQ
         opk8eV15YQ239AfA8axLqKsDYh9vpQ3+bOpWstqF/Shlwx1XZi8tuuyA+YHwoNnJnrV4
         pVOPLHnAX5KUC6nACx8LyapID1ML5s6amIP16CRZtjXsB+ln/omdjI6cBCcL/A1/eoXf
         N0Q3E1g7mus8Lfspf12iBpP0U2FAXaTWlkb44ZjucBBHXLL7CJjba7FLgFoodk9+ToI0
         IJLHKsr45TBUpSkkvMQAbdshmVvQMDrkgQS7dsHYMWH8xviBoXaOJ3JkiqNUftdV7Eec
         ITOg==
X-Forwarded-Encrypted: i=1; AFNElJ8NTnTkfB43ih7KDMqkdBbZhyTHAae3iLHO4hJ2+hjY170CPHMoDlPCOiFeo3mdMyssoBGX5YyHd/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzu6RfqPAbClaNbHK48wXHxbqMvrEqS2Dj0bRwIYS657+DXieg
	uic6mUDf5Er1hEVeAip6+M1ZGM31q5a+W8+VNbPcK0ShcDQJessOVMWE
X-Gm-Gg: Acq92OH6jv+LapsmmLqsft4XFE14Cvi2hwAhzRs+6oxrHWldSwyo3bjxzOqg/Sm/DkE
	168FVS9RbQzE8t2quyrrIXwLQ4VvJLw7RPURMiz00XL0Y+S4cNHKBoAzSlkW76I6oxeQxPH7BG1
	4eF7TP/iYIOBnksc1Ntm7VuT7z65wok7bMGCcSBJa8eM0sKgCxT2jGhe8nqBJFsnlvUrB8aBg6S
	lZ4ZltaIlkcyJDJ3Zx5xeoDGkTt74otstOblO9vM/lgCNd+kFy6lFQHL4RwCPfklEwt1IqX9rQg
	b/pqinzmd1bmx+tacsPFtp3fb01ee5SL/mnzs0L+Cq3dLAO7I5vKUcoYaFw41Lh9y7vdAOiZ1qp
	4QMLbrHRenQXnAp1fTfBnEFLWy68/adzvpEFgMBxtkb3dvxklMgh2t13r+HYefn/oT4dt12Tz+z
	hhU2fkDKNobYQv5n4wiQPpLZI3iH3QSnsStBaJL7OtAYtQTkXchpZ39/7GgOXg75Afpbtn0bZCi
	R4gteN4X2YXKrio0mMsDpT2cylJNIicWxG/nZypHhjFWuMnFfsDTYK+OzuR
X-Received: by 2002:a05:600c:4695:b0:490:bd1d:472a with SMTP id 5b1f17b1804b1-490bd1d4865mr44724635e9.15.1780567618417;
        Thu, 04 Jun 2026 03:06:58 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39eb04sm62966765e9.6.2026.06.04.03.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 03:06:57 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Thu, 4 Jun 2026 11:06:55 +0100
To: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux@analog.com
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v16 03/14] lib: vsprintf: use _parse_integer() instead of
 _parse_integer_limit()
Message-ID: <a5nlyycxfhwpzczlmud3gjh5qxlugwkow4dyqhtgtjrzjf5q5x@mnmcic2da75r>
References: <20260604-adf41513-iio-driver-v16-0-1a7d09143bc2@analog.com>
 <20260604-adf41513-iio-driver-v16-3-1a7d09143bc2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-adf41513-iio-driver-v16-3-1a7d09143bc2@analog.com>

On 26/06/04 10:58AM, Rodrigo Alencar via B4 Relay wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Use _parse_integer() that allows optional arguments to be explicitly
> initialised.

...

> diff --git a/lib/kstrtox.h b/lib/kstrtox.h
> index 00cf3255bdd2..ff84fe434a00 100644
> --- a/lib/kstrtox.h
> +++ b/lib/kstrtox.h
> @@ -12,6 +12,9 @@ unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned lon
>  #define _parse_integer0(s, base, res, ...)						\
>  	_parse_integer_limit(s, base, res, INT_MAX)

removed the semicolon here...

>  
> +#define _parse_integer1(s, base, res, max_chars, ...)					\
> +	_parse_integer_limit(s, base, res, max_chars)

and here, as per sashiko's feedback:
https://sashiko.dev/#/patchset/20260602203706.103449-1-andriy.shevchenko%40linux.intel.com?part=1
https://sashiko.dev/#/patchset/20260602203706.103449-1-andriy.shevchenko%40linux.intel.com?part=2

> +
>  #define _parse_integer(s, base, res, ...)						\
>  	CONCATENATE(_parse_integer, COUNT_ARGS(__VA_ARGS__))(s, base, res, __VA_ARGS__)

-- 
Kind regards,

Rodrigo Alencar
