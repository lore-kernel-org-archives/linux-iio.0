Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C3621E087
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 03:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773026454; cv=pass; b=HTn6b0QkEjdNYBlQVAaOzwU9EEYoAIws2Gumu/zXbaVvIu+M7gvR7YqLnNrxdvFbp/hgb9zUmrxuREb/FGzkJ+FuVRmluRHR3RdGnykQyL1CmgTtsX5azjqV5IgwE80O6TCsJ4rLzSdS1/g+cpy44RVhQD5siPT7kAWFUMS0fOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773026454; c=relaxed/simple;
	bh=jmepwnPwmCRptJBrNSf+z3HMSRLi6Qd2VMhSXKzkGQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syhc+CORM7a3NQ3bUeG3/Pqq43ucV1ACPle83g3MhHGUrZr9BVj1ah97mbeiiv3RNCGr7dx7g+7+tmcuTZalNP5FG1/Jb40SAXAqtluyP0pbrkewSBFCEcyDlI1NwTh0PjZVe0kzv+LCFb8c+yQhn0tL1rAaRB6y7A5/a+UHcTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUr0yfS6; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUr0yfS6"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79827d28fc4so101969527b3.1
        for <linux-iio@vger.kernel.org>; Sun, 08 Mar 2026 20:20:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773026453; cv=none;
        d=google.com; s=arc-20240605;
        b=ktgLAcAfwhGDojFdDu9FEGhkWwt2BNt8r6zrRuddPNvU7v8HifpX4U2MEmV+qOlDhM
         9VznFZaD9f+JJjcM2RYERAeYdp24m33eexq3eedbawXUI/uzgBbkiESYE3E77h41ggQM
         AgNNOYCy3o/nQUJLnWWyUBzIM7PlfgQ9K2ubjb872UJbmkZ6ZuuttUbHCSXudrEaio7B
         XL8hWyoRymV5933MgAKgxwre7KFGKLi3hsAnfeQ7d41nzlcWXAIytjrDQ2plMyuSbJ1e
         fNHxJbfnC1ojHqfhuqb0Ge8UR5892U4xHSTZchNu/GzRCAFpv8IhCGTyAkUdI9arF65N
         lIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jmepwnPwmCRptJBrNSf+z3HMSRLi6Qd2VMhSXKzkGQM=;
        fh=I7yDPU0tM45L9B6DKMEToQemQjoEa2+gHBtGc6KLfiI=;
        b=Le/NTOeQJFS63u3G7zsILPfiFDqbU1JA1o6se9IbbtWD84NDCfVPCwKbrmjMaq8Z74
         Njf7qVzsmA0EIvHPNvI/6BaM6yhrQhigfV3FvE/h0+nYXzNBaXsf7bw6IR2LYlJwwJ32
         TRy6uSaUbB8kaboXx+Vn0LHLTd1zckeqLOyqPN6yWzIq8lSrnyTJBJ6jFmLlsn+NG0jd
         dOBkbADKQ65EG9VA6Wmq1X66UBvkrlKLwULZN/hSXKELbQpLS5j8jtaHHoGwYGORUY4L
         LLunJ86CBea0Q511MH5EjrQCOnVdKPtad0yTI0k8I0wjg/BrgJDKmDZjG5BzeW6QZ2+N
         z/gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773026453; x=1773631253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jmepwnPwmCRptJBrNSf+z3HMSRLi6Qd2VMhSXKzkGQM=;
        b=HUr0yfS6pgIBKElMlR0Iyn+QDT2YnZFtUGhEfeW2S6LNkO7QVb2tWnGKnHkOKUhRPA
         l7ypGji2Tkn0Sui4d80Z4BjmNlxHSLNVDvCffRflGoonnBpkMNlu8Ztht2Po1M9FPhvX
         J7vhmmsoiEhNHih3y7AMpNd7SMNnzsdgPeH3Vgb8B1tR5EPdllruVa98Ws0xqab8xKHe
         z0Yor0+746ngkWLGSIid30YnISTqsZtW6dbtDmaTqEmFx7YFu6fUoXUVU7ktkpdDs3Mj
         odD99hE/rh/UmEOwPlUtDjf6JYQIejuFfww+qfedSdZZEmDHWcRExdrxrZUwHuOx0whX
         V0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773026453; x=1773631253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmepwnPwmCRptJBrNSf+z3HMSRLi6Qd2VMhSXKzkGQM=;
        b=cIs+6PScmBy/Gy07G7heK905vnNZXiYLcUZovR4C8VXBqc6IL88ebUCsOW9lK+TWTz
         tqtlwGHpx0qk71uev2Yg/KjtrLNhtfXGntn+z/uRyai5Yb3wfdrKwlgZFl+n5aENAhRr
         7vl3sOvtbYBAD9f6AtL1wHPSjY8e3mTjoysmQkchdB4ad2GOQvQgVKvNon2hMsFBoxTs
         OfQWRYDe7Phvmb3boZrzhoMXsXQBNND4jSGmICXzkYyv6HzVsEO4THxNqer/YDEQQexu
         Q9xk4cN7ECMziCrK3NV2l+4RWYx0qpZvpOSaww+RYevcAWV8ylMrwWIlYKpWvmAs6k+N
         qY+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpXl5PuB6BnawVluXr45En/csiL15m7YfcIyGnvtAAKdzENQrJuw9omNNodowmDStN5KOlbrxQkCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJiyHU92xBO6NOtDLSieXftflCWKvMhmv+a+AqbGVt6kNM1E0S
	7tQhseUs3LWfjPlGVrxj2f6JzAJkONIjXjgTuK70O2B+ut/JF+Y5kpMoxn9Xho0hPHffj/Pcl7O
	/VcddGtaggH99eXUOuwUbAI/OcKyzxwqYjHAegJ7PxA==
X-Gm-Gg: ATEYQzzqT/O4jV8rmFtACvb7FxUUEMFevZ43koxtN27hMWFquBSLHO2t7g31Z2SXrVX
	9Kd45b0CZrm5HYnzvGo14w1aM3WCkUEvgMvNAzOEyh3/wYC7zrvmddM5rVVRYfpzJ1oUWYU3Kib
	6dutO6wM87htku3WWUI3Sb/2qVWisMn2mBo/4udSzIVjZGHbuLJG9+RHE8oQjTlESfy9Q+8qJUg
	MJGrqTacIejSciCvDZ4BkxiUvgTdz4Iuy4BjcRfrvFlWMG9OlGClZMBYnppaGsqJC1GKaemPNyf
	u/tkyspo3PUu8NhLlXuP95vYVQ==
X-Received: by 2002:a05:690c:f08:b0:798:2723:ab40 with SMTP id
 00721157ae682-798dd6a2ce7mr94945207b3.22.1773026452706; Sun, 08 Mar 2026
 20:20:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305021550.120614-1-chenchunyang0908@gmail.com>
 <20260305124302.129637-1-chenchunyang0908@gmail.com> <20260307131849.609fafe4@jic23-huawei>
In-Reply-To: <20260307131849.609fafe4@jic23-huawei>
From: Chunyang Chen <chenchunyang0908@gmail.com>
Date: Mon, 9 Mar 2026 11:20:07 +0800
X-Gm-Features: AaiRm51Xgsk_Eb1s1YuyZAhWTsSQK49MQGGGBK7qsCdSrs6xFuZd6nkEqQPuces
Message-ID: <CA+TCOg_G031-Szg8=rvadK21mF7yAGv_-pAnXoeAZ1nGw95diA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ti-ads1018: fix type overflow for data rate
To: Jonathan Cameron <jic23@kernel.org>
Cc: kuurtb@gmail.com, andriy.shevchenko@intel.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan, Andy, Kurt,

Thanks for the review and for applying this patch to iio/fixes-togreg!
Also, thanks Jonathan for fixing up the patch name in the Fixes tag.

Best regards,
Chunyang Chen
