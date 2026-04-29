Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F81A33263B
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472862; cv=pass; b=MWhhLd/ZeX6NfDh0bxyVklR9Ikma2EUK+7dFjD+LZJvdEJqeQl7l7iJSG7xpfmthaCv90ykzGF0GmhjiOcNlri6ZHptBxV9uyK6RVnlyTxj2LdWEJZ6vYHVdSp/s6p+z+RJTFmOuYQkAjdpg2lYcibtm8u9I6zXyKui0M4P6wEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472862; c=relaxed/simple;
	bh=h1yJCwb0CSTyAqpBkyc5N0PKila1y/t3uXLCsiu7b4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3SUsGk42uZR48DhrFAJnfGoLm8P1waAxWMFgRrtyl5TyYG7WH4LGCtYhPsARTbKALXmU+aRUlhkbuKFSlKfjEeUQtkoNCctIIgl4VAonB4vhdsXmVXVG5eAAf/bUHXbn+99R4s2aBrLdcOOVPdAsUkmeaayDYk01610+0y2AfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLRBaimF; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLRBaimF"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a40d02b58bso10930359e87.3
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 07:27:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777472859; cv=none;
        d=google.com; s=arc-20240605;
        b=E6OOwnyi174rI8v2yHuWwIk1RJPWvyq98hkKVtv4bWItkRwbDnjj6obphwjIt1xdxy
         sHHz2hZ+O3WHz1UYe7HetXmv0t6JK52X/szVxOiVwJa9E9gFN2XhFeDHSFY8jQoebm4j
         jW/IdwvCjPkbH0ZcqVRpxd9Gnwr03jUoH5ogdUzQNrG9+K/cnOogQeiLrE9BaT8KR1od
         BpINA9wP73zFIQus3gm4Z+XNZuo/HwQXThs0pW3VQlGhan2OYD78wl0juR8JDYh2seLb
         XKCXVIqQjm9/47yo+AwB2zxNYfbgQD8AiiyrKhHruJk42Ealy5jBmnLGDqA7K6kAQg1C
         i9FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+b1hS1pCczyUgQxSQt046A354+T/e4vJQk0o+zywVpE=;
        fh=mnV6XRTFqWo7S0JottaaavaYhbXteHqXDHVUMe4vEOY=;
        b=gwzbBo3ZXURB7xiDUeHi2gv9VOMnTPpeLR4Z+SEsmT9rbCX/otdrKTR4qROUD9YVT2
         grANFMqvX3gaDj4XoYIDoAUWcZBAbUoyX24VYUoQrXjRqNeip5JdWeUWBdfpm9YiGuqq
         1wjF6LYTjj6a4PSZZEOW/9oe57XJhmIGorZnFcjlP9MfJl6PlhBg0BHjZzrMWw1Zffn0
         2uWvqpFNXT4590fWMq0EP7t9610MmDhF5mOGLzDVfTA3UARpcBJ5+xLvwJg3Eflz+hAA
         RspiGkYeyQrCdrLd6pxlSmq9sjnWiHmk2CT2TkZ6lAuZ1M/1q5vdcUngaX9NdpqYADUV
         4oyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777472859; x=1778077659; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+b1hS1pCczyUgQxSQt046A354+T/e4vJQk0o+zywVpE=;
        b=cLRBaimFyxxXc/rn9vEnRB6NPefBLWfu26um7+gkahpykV4asiV5EJt3ozgVIAhvkD
         3YalbKmxuqbV2EvDPvxEM1D1lkrd9tF0F5ih6koiyrVBbQhsQKk6ia56APSFUzlCQHgD
         4pH28UFDyipGIHOnl+EYOT0nXw+zo+9aX0HPaRv9agDCCwUjYb26vlS+Fd/dby1xdmA5
         v6q589ayiIRKjHS7kZ+8PXTsiKs9sNsxOwH8g1fx9G9OmzQ5Fdeev9AvTfTNTiDlLGIs
         EihphVgc4yAr0j6c/48CGm20Ii+Hiw2vrBYYqzCDdYmSixLT82fZnntmEYO2ikWQEsRL
         DIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777472859; x=1778077659;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+b1hS1pCczyUgQxSQt046A354+T/e4vJQk0o+zywVpE=;
        b=ZeflUz+DHwPWToQL94/1Qn+kST14sdTaszFRUmYLdCMLhzgh4tmM6ALyLCI8kk1cy5
         6Qe0a0DS2VBGfL6Lwzs77qU2v6gAQdqU9GaN+hJnXdvfLJ+mI1x0Kdq7Z/cFpRCVfqrL
         88vh8CmV48GWPqaedPeDru+pS4Pg/6+Dtxb3DOWEx9vf6j+tTPl9eba5caShbJDdwfZd
         v6bS//NVg/ehxjL8jcXK26YqmZmyDF8ui5K3O3naRGRZ/LOWIQhqvaphjilWQtzYioBl
         jF2Iqefx6W9T4CaV0pZ7MIJLH0Ynrv6vjeLMKJruZ5/rdzB0Jhw2TiFDbBg7m5ICqAWD
         yvaA==
X-Forwarded-Encrypted: i=1; AFNElJ/8spMbdosbtwkS3sQZEytyY+JPQyzXikSKpWJkwNLYQZA1f12nHSFrtOXqCH/5qvt3HJYeeTFBRkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpsTrA9i4aALnaVU4YJm8e5NxoStYs3FuAOWw6AFEuk6eNXclx
	9P2G91obE/PBcgbnPv84005n3A5TeQAQjnu2bSCtybCdGtscJSDDvnof6UNE7MUs8BA2JmP/vgQ
	m8EczjqUKsMYq6RfoL+71RKnqSZqfsy4=
X-Gm-Gg: AeBDiesbP/nSuAmlHzA6Gu+a+k1TBFfSRSIQ5dlKg/lVVetFKK3YbUyUsTzQDTVFgsB
	hUk6DQfYHeyYDYIzD4ds/wYGlqkEGGRoTWpwHSMoYJ4Y8d7EAyDvXcqUDiNPR//8+zc4/zTo2la
	VhYFEfHrFNrUa1kWXwzCRfHjmNBIu3W/25OkP6YLaCblZTHkwBAKw9Evy6WTXRAEvw6DdZvEwn5
	KcCze/mh16Cr2WGt1tIL2riDyXWJC/MtAjj2ZzwAsys79jW8nEt5tgvd4gOMND5KNP6cJRnd9Qd
	FwS04nu433GztQa21t7EF40eMytL+qQmh6zQoLn+JR//KXw9ZLJinpQujC1DCbhgYR53yXpb/+m
	7ifH/Z7G+437P5AYPR/EM6El2P4YBTPX8EpKoGSbium3JWYljjkhR3GenbKf6ovwWy6BdJpBSJW
	fjcywACKdz1z9wou5OyHqOyg7w62I=
X-Received: by 2002:a05:6512:131a:b0:5a4:79e:9669 with SMTP id
 2adb3069b0e04-5a74660ef92mr3089025e87.21.1777472859105; Wed, 29 Apr 2026
 07:27:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
 <20260427201412.3067235-5-andriy.shevchenko@linux.intel.com>
 <20260428172212.1e1bacd9@jic23-huawei> <afDpBGa3N8Dd1L6y@ashevche-desk.local>
 <CALoEA-woV6r=gOfHHXgBG82+FCG6XMBcSy0=6SUiryCS9woh+w@mail.gmail.com> <afIT3Uk3NdMIKlH1@ashevche-desk.local>
In-Reply-To: <afIT3Uk3NdMIKlH1@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 29 Apr 2026 16:27:27 +0200
X-Gm-Features: AVHnY4KNUlc2JpJ_5NBm3Q74SGwPk1d8YZFhnzkd8wKhA9hTgpPShY8nvphAkpw
Message-ID: <CALoEA-zSHLo_KiHVUrg4ZUcwX5dq0J-vDmBoaG0NQSMVsJM6qA@mail.gmail.com>
Subject: Re: [PATCH v0 04/14] iio: magnetometer: ak8975: Inline timeout constants
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Apr 2026 at 16:21, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> > Simple enough, however should I do this as a separate patch or
> > just a fixup into this one?
>
> I am not sure, but since Jonathan doesn't like the numbers be copied and split
> far from each other, I think the fixup sounds better. The commit message needs
> to be amended accordingly.

Okay then, fixup it is. Otherwise I'm thinking of sending the series
Friday to let it
sit long enough.

-- 
Kind regards

CJD
