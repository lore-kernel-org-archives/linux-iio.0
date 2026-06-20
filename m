Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44281372EF7
	for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 07:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781938850; cv=none; b=oCyPpBN8H4OzznvyFd3e6OVCesdsaf6YJU3vjNxTLU8jPCUw6cg4L3ZY+2L4Kio+Qs3UbBcxWgpalGg5AkAfvNFjskvVND+WTVwViaxOXKsXcCLNEc+6xFladOrQezt/62rc1B+qj6Sj25uAKbdq4cNZzDXvCNfGNYZjAJF+M/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781938850; c=relaxed/simple;
	bh=djuARFPUgpWQ+2QCx6otv9OxDbelpVEruhktlJ/lOSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/m/GqcNOhlAjLWRv0J8ghnJuyNXdILyAYqOSewyXgSLPJ9muLIbf5aSqVKV1qdJumXAN/NUiTUORXW5RY/NNnYiN/PRVJX4KALqP6GWAF99Fzj3j6zqy+LzwbinbG5rv5sMGUvIH4+ywQtpZeCrj1ibHhIxZTDRxHNwiBXjJss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWdA0U1a; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWdA0U1a"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490c1915793so21692655e9.2
        for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 00:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781938848; x=1782543648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDqfvOGsdlB3BZC/2DeF2hYu+XrbBaFGRVONyocXsLE=;
        b=TWdA0U1aaD0jRPkRO8qDS2FSqs/DJLxUG5dgo6DgRInykQ+RjYt2tqhCin3KJS+qVn
         PrriwTtnd3x9u1VnTK+TjYaBPQ3SAsaje0RuzkNoGcy1q0r0Rg4jCa0kbMTznKF/I5Gr
         857GTqOWuoYGk1WKZUbxPPqCSJnkxrAiJqrXG8X7Rg/cZzG6oEakYlXADtrHGD4t2ZxA
         5YMoXZCKcII3V4va+b5SFj5QxYHUpdqiL9rJSpZ3Ec2ZaRHp2SiVroBDbVwXrhg59Z6t
         GBysaeXCmGWW0s5kfwvavq2kuBG8OXmKJ85saPrSD7LTv8uMJXSrvik/VHMJ8Pd+Uwmi
         A0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781938848; x=1782543648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gDqfvOGsdlB3BZC/2DeF2hYu+XrbBaFGRVONyocXsLE=;
        b=E+D24SL6+4XJ0NeH0WvkoY0f+2iM3ZYQCWTH+3FmSYRKzCunRRrZMKgEs1RQktKQCE
         zeY42Vs4VjFmZ+DSwrSt+NJWcN+1niswtkA7XPND+12ZiUzoH7hqpVa7xvoXevb074bf
         Tup11YDL1DuL4i77bKttYl+pj/fyd79IDZpWDX4CDOdY3+InHQeq1A1sglDL5cNOpJqA
         jq2DSCiDBNqLtcFmVybIn2VPdRR4QYiaDAJu/Pove5bpqYH/LUBhScyDFgVZcWw/elUl
         dzYLKI2tzl2qE5lvu9/vvQ5ePnU85RK2Hi2KIbsB0jnrdpIXY1m6LLxqmEQLrwGQ0o0h
         BVpA==
X-Forwarded-Encrypted: i=1; AFNElJ8HR1HOjiq5Du6SafpWiVjjVGBf7VIq+6wxhSzE4srfwIRQH48Fj6ZK1kcOdOieRftkBHxiGbVxyLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Vwh6kB5ILu7xgVBNRS2rb/zWdw5W8Hs+XJpcDIM5gV8xnyhr
	GUiN7vc8EJJUdTfJOYj3X2CF7r8Fe8wj2bWmu6c7zaQZfS2yYzo87E1b
X-Gm-Gg: AfdE7clw+LJDVqhKGxjcG3h9dX/x3kzGwGOXq6iL/c8gSGvxCCWshVG42fhhlaV2LVW
	NY2jizOBK0Xdw/imbNQrh4Eg4BY4K9uv2wNsRDzherRyTw2/GTCHC58yo2zYAK38q9NNKrnsn6h
	Dbwgu/16TX83TOFO8B36WRcyPptlyHnbYSmmoDYOzTGdT2Yo8Bnv7oe5gNXGagncPrxT+nb7ASM
	UtgELfA1hVHcxJVtPe5VEykM7wJQRpiNj4QCZ9mEDOqLw4akrUhnRQMxyS4DZfPMtjwlIFLZvYX
	4s6Q38j972qA8CpBPighDVRcDNdPDaVMGjwr9cgwCJ9weKefXuqEfZ14h/Xc7m6R16hLiFIX3Yf
	dDvSraYFs5wM/abfKYEJOA1vKf03OtcVNr5+7FEbNrC/oT4gnIRSjjgM+dC28u52MfJNVhDLdoW
	MWZe/5pMqqUkhahFVJHpcAV20PtWCZMj8Pie9z4figJLp4aSop3zpcBqXmkF3/UyYo4ZCGwmroM
	Pp0SGOEUhPlzknzTQ0KCku90XokBzM6MbL+CP7jC0/evG0wdFxC52E+2UgzmVlgw58eu0lLXVNU
	bxcefF1leFaLMlCK
X-Received: by 2002:a05:6000:25f8:b0:461:a1c4:9fa9 with SMTP id ffacd0b85a97d-4656a375912mr7847306f8f.0.1781938847397;
        Sat, 20 Jun 2026 00:00:47 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c57afasm5582025f8f.29.2026.06.20.00.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 00:00:47 -0700 (PDT)
Date: Sat, 20 Jun 2026 09:00:45 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [RFC PATCH 3/3] MAINTAINERS: Add entry for Sensirion STS30
 driver
Message-ID: <20260620090045.5c84eb28@systembl0wer>
In-Reply-To: <20260620044010.1082621-4-m32285159@gmail.com>
References: <20260620044010.1082621-1-m32285159@gmail.com>
	<20260620044010.1082621-4-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jun 2026 23:40:07 -0500
Maxwell Doose <m32285159@gmail.com> wrote:  
> +SENSIRION STS30 TEMPERATURE SENSOR DRIVER
> +M:	Maxwell Doose <m32285159@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/temperature/sensirion,sts30.yaml

Fold the above changes into your dt-bindings patch.

> +F:	drivers/iio/temperature/sts30.c

This change then goes into the driver code patch. If you're
adding new files, ensure that your patch also adds a mention
to said file to MAINTAINERS (IIRC b4 actually checks for this
when you run prep --check).

-- 
Kind regards

CJD
