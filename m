Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168EE39E9C8
	for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789305682; cv=pass; b=FXTZsB7oZL6QT80gM+b2jcd22xbIeLL7yr4Wg8eUUpeP/KJ0znPLd79X6KnkAF9o9smqtAdV3B+JMwaBPtEEO///9UC7j4R53Pne/ym9nDt9MPW0yqaYOmxD5bCd16ycGAMgOxax0yf3IBvqImDEv9khwbeSkGhMDQPqhhSg52U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789305682; c=relaxed/simple;
	bh=qruS9RaFpfludketP5nShhhjtDemkZaJSSVTOVH8K1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8AaDOAkxSl9S2cHycUW2o2QkmYZkckA+V2FzDv6eClhhNaOtRakcI94UXeqeTT5Am0Gk2ZdXLA5f5e7DVr+vLzm9SFOAcLkINtVIp+u9HDUmvRrUWu4aJoA03VfBnwbypz3mVEc9olrfAJcQCcEsGPEmpqPtwP7lU7v744tWjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/oOLWaZ; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/oOLWaZ"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c206dc8adcso320251b6e.0
        for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 06:21:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789305680; cv=none;
        d=google.com; s=arc-20260327;
        b=U3dcDMWu3nLB3M4Tga1HLMGpLPDqMeCzGMv7ktbXmIWKsryLTnAou2Gp+PgMX47NPn
         WZQvfs9ZUH9622Ed4NwU8XjhEO3Fh5D/wr+91fBxTNQ9Iz3lin4b4+YzkWBCvTtZTHBV
         aY1e8lkT/BeaA5XmAd7hxPX/yT7BoLBIfsgXgLZgkRwg317IvhvwUQdwKlzLsRSgZpYS
         eFH3zIRsR4UGpR5dVqgZnucAVDSPKDXgt6kA6MqLTKWrLLIz0emDWQdrfKYPobq8fawp
         JxcKB/8NONeq4wLULnVaEpf/FAxE8LrAaYM0hnnOEzEneqv4y2xx6bUkGsqbHIZ39bYq
         2nxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qruS9RaFpfludketP5nShhhjtDemkZaJSSVTOVH8K1Y=;
        fh=ZfBhLdrVvEa8vSTkrsQGGhLOdAJRYMML/3GiIjpMMFQ=;
        b=rf3Ekzjk3mzAuFxIAJ0Q/i7B92N/lTc12XGpwuSwzAWUrUl2CmQ894IgFRA5cE0WWv
         sVLpAxLS6acpvoOyXBViFND/kygOZJ7LQaP/MjtTI0E+3empfAoW4F5Vb+phCjcLb7ld
         PDKUcPoX47jFkRmyWOh8F5kBCQjONSWOqmjGfAYF+X5CfPS/Z1/KmqZ+jnRwIWMrv+78
         SiHIYTjVKfel95MLyi7deZYUVWah5X2hKf/a0mJVTLzk0DWHYupja888z3NvdjmfvldN
         UAih9WaPKs78c73AGM/UNKfhngxaEmtVXwZK8yGUj9MzZcg5Q2ef/9qN+Op+p4vTng+F
         DzFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789305680; x=1789910480; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qruS9RaFpfludketP5nShhhjtDemkZaJSSVTOVH8K1Y=;
        b=L/oOLWaZX3FJqLPy2f1WZbsAGxZEnBhNcw/6CuLtlXLP37ada+l2+OmpWlgScPZC67
         mDIxpYbH/Xm2cSa8wq9nsVfeYdsqDZVlbm1sAgBWaR8SyYoawIX3Klebytz3a1fIf1MQ
         rp6fykUePvEMVmXgEwTp0n3GWpBwqbihoOJGxJIZaD6KIKvUcuFkUoUzTj7OWl5X2A+k
         smKQ9QQ9ut6bEsCBTpLLHyzhXShOhzWghcEw+3vXROn16qBXBmvPxoWqHOGR5XTnq1sR
         9Pb6Gw5K6QmORhRFPyBd9XzeDFHZjOGGOr9PKZu8I6pGNCFzVjegfU7q22Fz19mS2Dyc
         XDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789305680; x=1789910480;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qruS9RaFpfludketP5nShhhjtDemkZaJSSVTOVH8K1Y=;
        b=QaoI/czrv4+SE1aJHeXHpvXgUX06jdB7do3gBPKJqNcGggec+JLS5BdTnWEsqXBNgu
         eTHB8yxP+ToLt+TbZcPwz0yxF8DMJc9njUUIyXfIkeT3mgVDMHBmMLrgz234hn4q2jgk
         /FcPyH8B4VhR3D5DCsbjur4w6er1A/0r8Ed3Pyp3JscOuF3fHZrX0IQTohzL0HSl9LRh
         Pm4m8NGWbohiLVUWqfnbesbP2A6FB2a7uMd21DcXbRMxtBzZ50RfddFlqCLyNwdx2JQH
         qZzt0thTb6Pw19qK6I5v36QtNmiYsZ6SlFH0W/zKXLRiwsw+aiq2UMp+I5hu9ugPcOi8
         dsDg==
X-Forwarded-Encrypted: i=1; AKwUvBwn356ElxaTlklzioqhCMuxV69yEFxsV2IvBPfw3GmX+DvllMBhdonOByzAwne8UKiPcQ5I3XyLVPU=@vger.kernel.org
X-Gm-Message-State: AFuF++kozaq9vLqWXQxPgGY3UHnBL+H3BZTNrADsrr4bxASzGEFq7qj5
	/NbS9BHdd0jrGU2XyZFwcHcdVBIMjwr7w62vId7qlDnBJSTGyzAH7V2ZsGUXDkAEgzSYXTrgI+k
	6l0NvYgKczE/Z8CU2F519mRIXIUNEfHAdVNxb
X-Gm-Gg: AYBFou1M1KhWNlK+9rWWDPfHBeiGFATXkVIxXdovs5Vqm7Ocde7XqxHnunup+F92Frf
	5DgEdx/XGiUHRF/f3X7VX2lK1p40o22BMa6AFQH4qrs0qMD9+aZVNeczjNJHrVNPQYXjttxPOkr
	moux+K82ClbB0TlOMTzO/JOKlCGZ5Ju26lFTOIDlbrG4thAbLuGEQ+94rIuP2iKJvOQPy/GkwXH
	Xxcy2+rpUlgwf49fMR8Z54uQD7hF8AaxzOBUwpjoOpzGcCFiydDYEZRMUq9eTDbr+WrucjTyZuE
	HQllxArtnUJm7ghR+5uE6CjE3BsdR0EgfHDHQSEJX3VOgUw1dPRWJQ==
X-Received: by 2002:a05:6820:1886:b0:6b7:8396:f3e3 with SMTP id
 006d021491bc7-6c25003a9d1mr3486566eaf.69.1789305679912; Sun, 13 Sep 2026
 06:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912132517.55686-1-abdelnasserhussein11@gmail.com>
 <20260912132517.55686-3-abdelnasserhussein11@gmail.com> <aqZc3LR0s0I2S27b@ashevche-desk.local>
In-Reply-To: <aqZc3LR0s0I2S27b@ashevche-desk.local>
From: nasser <abdelnasserhussein11@gmail.com>
Date: Sun, 13 Sep 2026 16:21:08 +0300
X-Gm-Features: AcwNN1WsbiyGU7uP4XszH5roX0jEFpFRx8lXN2O10Txdr0UEK0yTaOMrsHkr1Cc
Message-ID: <CANpqX3YgFne0HvC4n92R8URm3cC+gdRWsGo4=yRkXkXf1q5d-g@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] staging: iio: adc: ad7816: Serialize SPI read operations
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, gregkh@linuxfoundation.org, nuno.sa@analog.com, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org, 
	linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, joshua.crofts1@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

Thanks for pointing this out

Placing the mutex after the `u8` variables introduces unnecessary
padding/holes. I will move it up in the struct (right after the
pointers) in v7 to ensure a proper memory layout without wasted space.

Thanks for the review

Best regards,
Abdelnasser
