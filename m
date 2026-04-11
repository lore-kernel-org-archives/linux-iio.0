Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C0D341ADD
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775909696; cv=none; b=IGOZk0h+a5ugJEPZOxFYwtGTQ3l4ypEgzugWv5gbmL0j/CXle3PV2UF95v4q62MasO9GafZkStG9LrooEt8BwlmlHa+f60sUhtfEXuye5DdnhrhA68R6bsd7ekL0KjtQlYflYMUIyRmJnRo8mFt192Y9x8lpJQB2t3/BNqiLzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775909696; c=relaxed/simple;
	bh=2InDKLRqh0DuggcRtnhrHBDrAqUvpvrz41sgY2+D8GE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cD6at0XmAkmmLranfb0PlhKPGTBZ/oKq7T76mm5ewIEKNc41l8r1zCc3bybjQzbpDmpgNqhOvfh64XUQYu5j77b/XE7lcbVz/tyTYrEhf1whogA17264PXIka834XhDn+NJb/nya7N0Add1XYun1Y9mkFHkj0amNT0QsgpdAeBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1rhG9Jr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1rhG9Jr"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a29e6110so32508215e9.3
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 05:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775909694; x=1776514494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3MIy4wgZvvmccJEQOMTQ0bwn2OnPjm1qEMF1v7R22c=;
        b=m1rhG9JrVaqJnG4qHoVcIhNbkbUg7DPHdBfxJ0NC2uoXEwfWLXO9lyyy9A4yFRjZhw
         OTYQ+VhmDYm9MyiVSr+RJF53APslyYnHn1tSxNJUm/9wuPTxVZFWytDzSNTaXWmBxEFK
         itb5VSG0HO1UgMJZo3FH0HzamEtSlgGKCVjlLvZTJe2fDWRezZELSa1rcwPylOOdqIWb
         0AM6PBMb+xM4gMQqjUdP8StV1oxElTJBeADU1LuTEBQEttApQYuku4DUUlRNufkqbS4o
         g7AqEdpFjq0Ua8QHuFg4ggVXGLLD5BlP9KqPxLoKKBVkFHBHFkRrnyHsSKGTHkd7jdcD
         /Vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775909694; x=1776514494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a3MIy4wgZvvmccJEQOMTQ0bwn2OnPjm1qEMF1v7R22c=;
        b=TUlbesMxZkS1qH7LM1p6Ajb0T/NoxCGc43IH6tc5Eohmq91PhMF6at3UZ0iqB0KSug
         O4lJwqPtb8v+8GtG5mWNv1739okn3Lv/MHYKc5D9HHe+6RvDx6ipTaxFmKjX8MqG/U9n
         /4vUQc1o/6eg0y6AupMHM7Taqh/rqX7FfTABZ5PAMrI6R0Z8u4FJluaVojiKu/dlPNUL
         Z9oTiYPiXrcpf0mp0dJpOy5LXLwsyTmbi9sgoA5yDEvAQxXeM1n0i8r7nQlsM+ima+gJ
         KUg6GP6yurRkFW8l25tNSlsDyiuRWRGZVPeFBDcYsgxxP0Xfa1rpdSIAlQq4gDauJL8W
         s7pA==
X-Forwarded-Encrypted: i=1; AJvYcCVy1T+CwNWqibnrwgmeduosyza8fGK3xvOrAmAKICaIrt3QVaufMCXYg1O6gmBGk3Xc1z+sAabTYAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+hNyuI8Pfp/p/uySD7QdkzvMhDwVTZvryYlKqsI65ki8NMs5H
	pQLjYGK4C6f+bmt8UhvG/EJ2cgR5cwmpPuj34vLmZQLVGQEocpGIRn+T
X-Gm-Gg: AeBDieu8zVqT5uSxnRQaNx1bgEWHQwn24SHitX7Zr2eVcdLjQs6NwJazqMPid/9+I/0
	hdpq97JrNNxnuYY0IV7fIzMhhv3WPqIjORFhY7U3VUKlVnmuUjS8lfF9xw8cDSA9o0l2SW04Odm
	15kvL/1PCGzez4KHXXeg7Is74YHIpuY7mOXGg3rIcbGW4vLU2373HDYeXoHI2J2bOxHlpbcFQak
	JzQW2I9mDmyP7U4BwMzfdeBjgv98uPL92NorvMYAxFdze1WyjrqgoRu081dhyglklRNyD7lxB3b
	u1QiGf3wJYjhvE0ZuvdQ7OkTNgwLQUWT/EOh0UZRdLOL8bRUL9MAtj2LWgsNlcnkl5ZQFfvzru4
	HngAVpVZqYTbvQyzC704A+H988UVGE6t0bmiV41BiOX4Duwjn/2G5JXV3SQNL09bsGMebPgOW0K
	HtcNEEUhoNEbXHdou2cBZLu1gx8nFOxXp7m+nJFQBdUJN37HYC5ooIh27rweWq/T/W
X-Received: by 2002:a05:600c:1507:b0:485:3a27:a961 with SMTP id 5b1f17b1804b1-488d7f23b18mr45963215e9.0.1775909693681;
        Sat, 11 Apr 2026 05:14:53 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5df260bsm46167175e9.13.2026.04.11.05.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 05:14:53 -0700 (PDT)
Date: Sat, 11 Apr 2026 13:14:51 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Piyush Patle <piyushpatle228@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, Alexandru-Catalin Ionita
 <alexandru-catalin.ionita@nxp.com>, Felix Gu <ustc.gu@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: nxp-sar-adc: use field_get() for EOC bit
 check
Message-ID: <20260411131451.1e8af16d@pumpkin>
In-Reply-To: <c885c62c-f0d0-4dae-87d2-e6fb7257cafc@baylibre.com>
References: <20260410211329.185147-1-piyushpatle228@gmail.com>
	<c885c62c-f0d0-4dae-87d2-e6fb7257cafc@baylibre.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Apr 2026 16:26:05 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/10/26 4:13 PM, Piyush Patle wrote:
> > The driver uses FIELD_GET() for constant-mask fields but falls back
> > to a raw bit test for the per-channel EOC bit, as the mask depends
> > on the runtime channel index. A TODO notes that this should switch
> > to field_get() when available.  
> 
> Could drop this first paragraph, it is a bit redundant.
> 
> > 
> > Use field_get() here now that runtime-mask support exists, and drop  
> 
> We like for commit messages to start with the verb like this, so
> this would be ideal for the first paragraph of the commit message.
> 
> > the obsolete TODO. Since NXP_SAR_ADC_EOC_CH(c) is BIT(c), the
> > resulting !-test is semantically identical.
> > 
> > No functional change.
> > 
> > Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> > ---  
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 
> 
> And if you are interested in doing more like this, search the IIO
> subsystem for __ffs. If it is used with << or >> then there is a
> good chance it could be replaced with field_get() or field_prep().
> 
> 

And likely make the code larger and slower :-)
At least run the bloat-o-meter.

	David
