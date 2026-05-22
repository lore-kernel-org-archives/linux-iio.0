Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2EB3FE364
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779445446; cv=pass; b=g4UydCCTYfBFW/2CR8fbKJ+TT8ffHK7yfvSBCtdaqJw6FjhJP/v+LxJw5JnY1NLaMOJSfc6BB8D5kORagAA5ysGv5ghi0wm6Xe536ZJB29GdpCVuKj5fMNKEXyJmeOikqK5U3yp+OyUCUhjh3hgQmY9L8sglfBZWHWFqNDO9dkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779445446; c=relaxed/simple;
	bh=v5GwrhelJJ/3l5w2rDv3/n4baXipN5VTVL/HS15r4ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYpuydLUhEnf/fS1s4psmkQ6TmOMkko9GIYrWl2Wq1SMq2VQ1cw+6hdBl2X5s3K4i9YT0Hqoce3taqN0BmIzuP9IG7RmMoa1f67A3cWm6aDbm8lHyehMfCILNWBRnwLimSdscZ3m6/+yt0e5ZkFnfE/Qfvr/cFaz1XfAhEg+azc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVjcu9K+; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVjcu9K+"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d734223e4so4742756f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 03:24:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779445443; cv=none;
        d=google.com; s=arc-20240605;
        b=HyN7iy2iQ0Lbo/xm5ajVQvdIizCdm9+VlQ+PvqFbH6CWZTm0fgB8khtx53RJhHjJ99
         /pxiXomILR+zaktZ+iOfhIVE13ZvtRLashLQDkOuUahUgSA2Ecc0jZHfog0KAp0TcEta
         ZeB+P6fu2t+8b63rUiK4qbir2JFl8Glnyc6D6dbu1eJ3bAE2t10Vd1Zl16Kqgoaw1PgP
         ROpcFyC/RMz50euAgyru+IEcERTz9wKPe8sXqId4VBVbZsMMmbt4WFHy5Dw+XKcFBlaZ
         kgyk2j7MZ2Of8JAJAwFstlOt+hYOwmREc59B8b2NK6TdNvTPNr3yv/dfrxnKz5moNcZ3
         c0hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ygbcmNbrdiFRKD+baIo/dQK8ZsOo1LhA+R4J1dUZcB8=;
        fh=lTWyhOvLmUXysuCgm8fajOCf9U9jbThvmlzKRXt/2mg=;
        b=cgNAfFqb5V9TU5QU88Iqad5/xBBtIAE6QhVnrdZuNkkjVuKgCZXhgpoPYWhy3VTK/p
         NrPHEdruyctajSW2Lmap2Yiv0t/KkXfIomNi8lfiNXYfGOM6BP2KA0Duiavz/ofvWsCR
         le97s/4JyXoGop5FmrJyWYfiYXPAlB6QUvXTg3uS2uk0sezxrq5LBtRNV+SSUztVQ9Xz
         7Gm564qhm4kUqgfzgkDZ54Pvkte9E19owWCxuPebTPUqN3qXn0Ere1eR2ZfYtjSQAPUF
         jgVBzXmG1q4NJooWQljjUdbgAZFelXYKww6WtG7kzI6APBmtXJLHwfqJ8bDuhxfHBHAW
         VNUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779445443; x=1780050243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ygbcmNbrdiFRKD+baIo/dQK8ZsOo1LhA+R4J1dUZcB8=;
        b=FVjcu9K+ry7yOmTT0mBpCvku8nlr8OvDdvmo6piGmKF8bxEUEosmsh4o+K+WLPDHkx
         ypqQTJCOVcvEUAmpCfjBZVqYtk+QooG/m6oPinzMgy7i6hccJJojs3J5E89sCp9e3E3s
         p3z2sFLOHfM4EkObHfqgHJc/pU4ieXGjQESRmnGrSDRxM6CN3AXMAyG7Lrj0Da8Ur4DX
         G8O81UfS5ef8KFBkXI0akJF+twNy5tfUnfUeuYkOBkzHY55OzuG1c0CpExkmziSHdFZh
         o8aMfJwcyBw0mGqJsqSuzls4WHzdRaXJ7IqN43C0MgNZksLpZ1us7kwi87eXj8yMAHnO
         Knvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779445443; x=1780050243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygbcmNbrdiFRKD+baIo/dQK8ZsOo1LhA+R4J1dUZcB8=;
        b=b+5pOmskChjwJfaTjBm3y1DTwEFpWid7CLmm8gAfTdbXyMP0aB2qSulW/yjeG+Jkjm
         3M7O0WdRH8wdS/BBTWnFAoR4T5/ErOw2Zltj8uXXywGcMSMd1cCFiYYb88RW9Aq1CoMu
         QVNAm/F1Cu8msE+MM94aODjwWqEyqsGNdkOPMHiUXGfsHviiTlbh2Wy4ONgS7bJgp+ON
         DEIY8cRAYIAF4abiRgyImN7taSh2VGUcHExKi/Eg+eiC0KK2jwWHixBJDnIFSH9QS9eQ
         hcwOXjhmQxx5OeKZ/Zg5t+BfFv0x/ME3X6H727xcuZm1kBKHP5PMFVY5b+lqhYr8Lyfd
         F/OA==
X-Gm-Message-State: AOJu0YzKwVaKaI5rUabI6VbZXmiygvBsjvYaPMdW5czHiQ+QieSBkJIz
	icgOWwiUJjmO7dd9KVsQGsgdS6eDsn3NbTxL4PmhdOzVjh+rxMyS800fD2NIK4bVGMPONanuomb
	HVBymAZ/Zy6w1pri6IHVjey+fxsOLCEFz6C+PvGE=
X-Gm-Gg: Acq92OG8kxO1DjxJ5uLc6+DXV7//d2cGyK5nINXcBkhIUQNDSLkRwx3tAkMKt9dF4t+
	RXmSpi7ffdqO6FER0ZiMv6jMyaennvEcit1dAlHjP+8r3fOkLKRefB2Ch33HrX4BHUGsVmE+50m
	DlUQF2S5G4OKKHmjD9lx1SxuELDA0N+VCOSpYBxQa/a27cW8dyUVA43NawnLlmwg5mMa2BcVGRT
	awKlg6kiQQbpABN1iz1Pbup930yZQh9elmXum+Wanb+ts0JBsjlYUUHok6x27xXI7GrEoKOgURf
	9BYPxy6IFvlXtXgpR/4fwiadfNe1b/iIOAM1qcQVZvhoX8J7enM27INSuB/lj/GK0bKvtXqnwRa
	cpxrtIxjiXzdhOpwFkQxmsSp5szz2Ckt7n24N5k/vToTTlaxzTPFXcidXF0MKTVuq5CG9vt4pYB
	2D1cZ3kA==
X-Received: by 2002:a05:6000:1889:b0:45e:8edc:dacc with SMTP id
 ffacd0b85a97d-45ea31ce398mr10796730f8f.27.1779445442961; Fri, 22 May 2026
 03:24:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <19e4f066d51.4e6bc94b96251.5845269359367162045@zohomail.in>
In-Reply-To: <19e4f066d51.4e6bc94b96251.5845269359367162045@zohomail.in>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 22 May 2026 12:23:52 +0200
X-Gm-Features: AVHnY4LFGVjBSFD60N0_q5EU-1uKbuiei4cZUvjL_emm4YkCeTH4vmGPfWuCtm0
Message-ID: <CALoEA-xYF-1Hf07JDVqbOGNXujLXWR9b7qW14RT9ZPwpmx9cjw@mail.gmail.com>
Subject: Re: [PATCH] iio: trigger: fix memory leak in viio_trigger_alloc()
To: Ashwin Gundarapu <linuxuser509@zohomail.in>
Cc: linux-iio <linux-iio@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 May 2026 at 11:44, Ashwin Gundarapu <linuxuser509@zohomail.in> wrote:
>
> From: Ashwin Gundarapu <linuxuser509@zohomail.in>
> Date: Fri, 22 May 2026 14:34:46 +0530
> Subject: [PATCH] iio: trigger: fix memory leak in viio_trigger_alloc()
>
> Replace direct kfree() with put_device() in the error path after
> device_initialize() has been called.
>
> The direct kfree() bypasses the reference counting mechanism,
> causing memory leak and potential use-after-free.
>
> Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
> ---
>  drivers/iio/industrialio-trigger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 17781c12bc85..9c72e7ae996c 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -598,7 +598,7 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
>  free_descs:
>         irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
>  free_trig:
> -       kfree(trig);
> +       put_device(&trig->dev);
>         return NULL;

IMO calling put_device() on an uninitialized struct device would cause a
panic, as there are multiple goto statements that jump to this section
before the struct is initialized. Additionally (as Sashiko points out), this
patch introduces a double free issue - the IRQs are freed after jumping
to the free_descs label, and then they would be freed again due to
put_device() being called and a subsequently triggered cleanup.

https://sashiko.dev/#/patchset/19e4f066d51.4e6bc94b96251.5845269359367162045%40zohomail.in

-- 
Kind regards

CJD
