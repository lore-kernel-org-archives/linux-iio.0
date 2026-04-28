Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D04F33D506
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393447; cv=pass; b=b8U0VT4uFRoN2phTPkpdFsEyMegTM6K3udMPolatfdQafph+57QKMYOo7On7JsSDNXW2nJaNU8w2ablFPKW6EK5vOEHyWaSVA8YjJbvrZMWAkfoKBE6YUPnFyvPhC569dSF0RkAiL0FxyLp7T2qH+EUOh8QKFuR8zPUv74Ld+rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393447; c=relaxed/simple;
	bh=agmqjoiv+inZkE1FGHnn+FfQv2SfcGhQZIuYNoIHu5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XeGZd8BxbOntt/WqJSMdCHPyDe3o/4tb2dqLiyfl7fZvn0Z1L7k8nA1t0nQ6TCihiPZ6KKQpe3Yn0y7t14hRekFYTjNKzAUQqs0WxT7/MTDkq2WbpKct3Jt3bGl0oqbZUjxgxowCD99h5cOcDkGR17uZ3pVPfw9GYfn7McrMOOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktIt4hli; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktIt4hli"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d74086e5bso10988508f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 09:24:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777393442; cv=none;
        d=google.com; s=arc-20240605;
        b=EcD829ydwiPCr0wFz59/EaVOrQERw7axgWDrWGjEkduEAbunceB1bO2c0n76jwGHc+
         tnmBJUNRf2uy4weqaW16Mn/CHR1LiQW5XOOOJ74wjs8Mc+p9UDrTDJPz2iwpECdQ5xmH
         dPB1fT2Nt+o9AwC+ms8okooFvVV1G/e8wIRvNuEzPO+3JzKwSDEcOxH5tBgczApKaWaW
         zy+sxtPAUFfQlIlsxuGxys58Mm51E3/e041tlQ+bxalFeNlgvvN8tPKA3eyevybmChv1
         +9B/aWbch+w/wxq4vMdZxCnALYzTYX1L9WH+VHpReYGEZC48Sf4Z3a6JUCJBk+R63XTq
         6eQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=U7QmyAe5IIAzJQAydpuTwReIemXQfSKFwwG4rea7mwo=;
        fh=arScDUq7UGQKvrkx0OMay5Y5tsp+mD5ElQWV1wCqqPA=;
        b=QNa1gRZtTJ5wM44LzdWF8cfb7a/qjv1Jmt176ivGNr7uV0pLo24TKgFgvX9ACOD6B0
         XHzibVz8hXfDTADDf4mtwVHhTji8+VDdcs4HswxygYMmVk1cqRM4uMsl2IP0zPFp+E8u
         T9n3zv/L9Is6Wc6/O+CkipHvQkaGmFcMwAsGWKIHua0/ABp6TBK3FDc+fPURe36xgAff
         fZygUELnF/xDLTQaXGflKmmNB3ig0HHh4p0MPmZWXpjULr0MfMSQzMyZEFo9kYkA6RcS
         1DKZ4UXmHY7iOrwx0hjbAlMTZv3D03X1XwmibzQaI/d9Va/nezMCk5Rnpt3jI8PapzbO
         7mJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777393442; x=1777998242; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U7QmyAe5IIAzJQAydpuTwReIemXQfSKFwwG4rea7mwo=;
        b=ktIt4hliSZWR/Hj9mrUQ4LMzNgYFkYVtroeJ/Kh1crL5GTzDGIU/OdqKUfpIdJyDa0
         rNQRGmdRdTVH5kcX4IuQVz6e1hmODKT86lsHQYWLfwcUOq2rSL8JsJlb2rA7hXwarHlz
         akKy1LsCGrreZ+byjjPfjUiqVx5UNQNcppRMfMRXzZepbAj9/ZHo5OXqRZ6cXcQFHPFP
         ujUrbrbKHBTfreNKr52rIqobhYPPBIkdTKUolYghLHn/jC7CLeJZ1v8mz1UVGxz/SS+w
         q34+2GEnCKBX5tAnlkQGdUMlLtM5p6KQKp9HS0sOOLR7V7QtnxWIF9B4zUiez+/D+1HU
         kWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777393442; x=1777998242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7QmyAe5IIAzJQAydpuTwReIemXQfSKFwwG4rea7mwo=;
        b=Ub3AJ3uYiU8nLob7tbZ8MEV1VUB/eNJgOJdiU96VdK91Ix77/90ssoXZ8525RGQFfN
         gjcG1MoIsisy6wjfoAWfbXCOa46UtDxlvrqQREhQC7S9TcHyNA5wF+rJySzfMaiubNyZ
         uhpO5aV6qbDMe9NPE8CIm9bLjK6nv46bQLvMYS1JqfE8PqBJYAjGQwLonCBlW2FTVRoQ
         cnCbNoQ6nXUiSD5kDjXIHUZLIAzQhI0JbTkvfXpoMjl+s5B1tQMC/NvGh+pJB1FrMVhM
         0bGqWJny7deM73qR3be4+BqvJQd4e2BXop/TibJ0D0PcDHaeUvXpCUfb8xIr3Y0SlR4N
         zGlg==
X-Forwarded-Encrypted: i=1; AFNElJ9RepFkNsmTtD1HDc/40VrOBFbhaY1+bmL+JtPJO1qZ6SwfibtYFPgYrDb+Inml6nYmL2EaqLTZEQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9xRBJWLbO/Ts1cQ9DCAygJLXzXQLIiaGFNPpxb4+AGPCeqXhr
	zQQXY9t6W42cviiMBj9an8gJTY1nnWhNjzZAx1p3nMs1HRMscIXxDgKgEh3Z7+ychQ4samfW/qz
	qjOWdT9ulgbaajOyH+AMxNS+Ike8oouU=
X-Gm-Gg: AeBDievRdsZXoUYzTPggy3utBJeURbFR7kf1t5bIjC6FZfUxnNsRefwiUnjLWL1kQwI
	uy1qOEXW9aBGJj1m5YHKlIuDn6LbL6yaH6WWs6Twto4NuqV8KyMCz7wPiDzLPdA1ja5o9R0LKVC
	epRgnOgLnRma8/jUE8tUs7hFK+AgU6CizFBBBs/r8SZU0/7avitSKS+DdtXdZxWEQpbXC/ylIhW
	go7+ahgaZwYWVR8y5Pv6fff2LY+lVjQyp6k+mfwpVthOYEdHMi5i5QAFMsqZU6Jh2v7SvZJbQ61
	+FCleJMRX0sUNjuCx7hpQCwOGC1XhhAxvXFtSg9VF0jJINywY6+8jfXcjo9HRPjthw/j6gFjZQC
	/b5aLibbp9DNTeO5RxshddDNoUozuZVuo+/w/dBHj3zfPjhF0B7huX55mzzc31r0mdmLvlyjQO8
	7yFRPgzH0yVVvU0FXDI7NJqd3VhJfL1qohKT2pb99X34lbuiiF4w==
X-Received: by 2002:a05:6000:26c7:b0:43d:1c59:2dc with SMTP id
 ffacd0b85a97d-446496d5762mr7437653f8f.28.1777393442237; Tue, 28 Apr 2026
 09:24:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
 <CALoEA-wCTEUA44ST5eg1EyHQTEop=wHn12NGddyqzPMa+EUZ1g@mail.gmail.com>
 <afBbylL3Ygt9GEYy@ashevche-desk.local> <CALoEA-zLo1Neb=6xqwRyNcgsWBdpXPQox3mvJo9pEXs-Y0h__w@mail.gmail.com>
 <20260428171626.1fc178d5@jic23-huawei>
In-Reply-To: <20260428171626.1fc178d5@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 28 Apr 2026 18:23:50 +0200
X-Gm-Features: AVHnY4K7QzhjnqhmhucEDFW6tar-qDDt-TYnliMNbFhAAWZEN3wRqAr2tdGbkb0
Message-ID: <CALoEA-wfF9d5JOgQnWebxVHvSTpp-a7E3VXMUv_cZVJaAfFHRw@mail.gmail.com>
Subject: Re: [PATCH v0 00/14] iio: magnetometer: ak8975: Additional changes to
 the driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Apr 2026 at 18:16, Jonathan Cameron <jic23@kernel.org> wrote:
> Yes.  You are 'handling' the patches, so need to add your sign off.

Thanks for the clarification.

-- 
Kind regards

CJD
