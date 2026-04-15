Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6AD30C615
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776244068; cv=pass; b=IdyyImibQpZfTvGgTbjuUap7t3QeU6r4bwSngpFiAfrlZFNoGRpjGO85XK4H67A2yeQ2kgJnuQroAY2pIxU/4grXkw+7sUa+PVDqm2VIVhpv0FqSTeW6oXFCPCiQEwXeKzoh503E4NlN5QRox82KnuopMaJZB/CMbAalH0DIIjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776244068; c=relaxed/simple;
	bh=151BP8vcsa0+zX8pYKwIkR/HCezO88QMGHgZ7tI6xqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tL7gcpsA88IIx+B/cSckbO96HdRQSDQV6mNjIZlefLGcwgbJpkTAQ1QZ04rgc3eu2eoDUTHT8UgoLF2PbP55Joy+7dLJ22ye5nuFyWxh2skdC58rqLRnzOhVrgLGVA0vCfvl6imDK9injeArKxKczCXCAX5Bf9fe09YUHAf06io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXpMOCyf; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXpMOCyf"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cf7683a28so4423250f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 02:07:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776244066; cv=none;
        d=google.com; s=arc-20240605;
        b=D7u2t/dyjWlhk5v7qLE6+HAqJ+RUMxgoFSnyJccxdw9WDPyQ7maLPgP34O1+JpGbMq
         oEAY6cQW6bB7z37puVEGsh5Fs7/4w2hN6PNuFqmT1SNIrNZfYYB+EUxNey/7iJFnrEv1
         f8y8E9UCWKMcMUAQ9ZD2OL/KSR/Xk6jus1buvIP4H7hUkq6DswnV7Mn3s3M+hnk1Clx3
         v1WqvP7HZwT4c5K46Ya2LUtmEKxZvffnMIFq10XYk4AZdCA6opYDh7EppCI2j5KstBCD
         0JffRqnQJNX71Sy7WrVN0kADdmvrndoZoR51TSiJBDpeSxpvk07UPCA7fK9Qzis10ojT
         /X+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Gj/EOd1gHxCjf+KoyC3qDsih2SCIEDANiIgeEbfv7wM=;
        fh=gCP4jtUxGvfmZDIIId1EGWy5QayTmhD8mlo5OnfWCXw=;
        b=LzNSzjhpYMVIvhUSzlm0LdkkaCH5uODHR1D24gsvgK6UbdPkSVZ/qoO3hctYuDCMsd
         I1sVMjwgcd6FjuZjIZJs79QHGCJyt5nfd3kNlKa5/1mg+Ff+OKDCO1g+vQrNCVc9999S
         +MltJ+Dd8d2xmTxGpC+jyhP5/g0vGSSD5c6PM1P3gVlvkh49UwWbDAFZN/KQO76ROQSC
         6VBg0GgnsG3a3ceTFWPSyi3gyFUvZvU9SKPT+f3xmFgTI9khlWbK8FTtCyqVq4iDCT5L
         2RSslA1WG9XgQp3DzQ85znkrpp/VXEUmwx9lprDOG+334QpK8nb7adW6PEg4lYVxSdcY
         Qm9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776244066; x=1776848866; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gj/EOd1gHxCjf+KoyC3qDsih2SCIEDANiIgeEbfv7wM=;
        b=hXpMOCyfLjVNI5OMsOFvcqW6fWbCBhQSxDE51Gy/KIcjRRYX0oy6j1/J3tHd5f/xzT
         8yQgXSAi7v/Lx759CmzPgbXiD5MwWHCsFWtUARYk83w5n/jGz9qBrWSXjI0JKt6nnQKq
         uNvC1YdbZldKh7h2k9eVWy6/dLIB/pN1jpK9tTS5hH6PrwRCcwUgtXV+9UCZ04kYqmDP
         z9Ajagy5ZakEpUun1f92VxPV/0cJl23atlv/pCNYa0phFz5s1V/ie+AGxcNC0onQECVW
         3MdvSxH7kWnM7LWdbmfj3tTTSWMY1c7CSwYZYTawoPzR7TFKyl1Ft5XHRUmhzwNT4hol
         lGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776244066; x=1776848866;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj/EOd1gHxCjf+KoyC3qDsih2SCIEDANiIgeEbfv7wM=;
        b=bXUjsvtJnT6T5JgrJsUYyORdEpFfBAHr0Sn3bziajr6pSj8tvWDU94SJj7SDqzXSdW
         yR6gRwOPtGKI5KDdg2kDcrNZXg+qVNwuYgwPkWoSf2NhTRezI67wlmKvmwjzxRI9Vtvm
         FAeejQaSiCzgMmPY7T5+ZqYFDbakQK9SsqARCJ2NWMsaHXzH1fa6H06eh/QUjKkuS6GV
         MYN83HxFhAkWjv2ab7xSJmb3asiVVOLOaefrBuh2z2UgpRzTdnBiIxO2jy185IJBzBgB
         bDFBZyDqddma6rcsCPfQjTwhcyHHH62fOt7ChcfK/m6cgBY2fzUgBsh76YMzsEnV3DBK
         AGZA==
X-Forwarded-Encrypted: i=1; AFNElJ+wJSaOSXfolZtyr8HT2s61mB1rdG5km0+MtzJh8nGGcX5y7mrOjoQ9RfDJxNJ189U2rMD3kFGLTHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxyppJcg0EQ85zdOPbq2LLWbjJYiuh/KNj+a1ZzyZNZ8FjhKA/
	hSaJlD/iGR+rqakyjC9pf2DcE1CIjgsILEiepDpEDP7/N+eDz2j+5tdNSJY19bRViECAGFsAUx+
	JcF1hkSk0gzsCl7NUUYv5SnUtozLWdyE=
X-Gm-Gg: AeBDietVOCG0/YHcfAXgKvY+co3tgz2ne5w7IgutMThzHDv5PtQsWkyh/9iqwxyN/dw
	wx8980zDpQHfyLqO/lTzaB5JEQEE0/bZL03X5qI4mAewAED5kk8wG6K1DC0dWfqiS38YD/93S9V
	fP7xJJeyDMFj2vRY+gpFPHG2BlvJpbFw6b7yQmjcAit8j+9Vter35kBHjpNxYiy4Z3QvJo576Ms
	TI9k+4oazK3Zv31Zly7xpHpfuVOGsPsYV5JVJQ8/ifbNx18wZtRgYq96gYoGX85KVGyGCq9P4+n
	AQgtyJKBDgE0ajeZcIVWf8m6kcZWGNZ/+uZolaWqoH6SM1fvnkX2FB2s5vhn4MJj7GSljvxY7hR
	Q54Fx6QTWo0YyCAZyC9SApYpSG1Z4vsQgnjLkCg7v3CzUTTRuuUm4TKicdOk1tM8PJOgBwGwXNj
	EDW5Txo8qxTWSaYDce
X-Received: by 2002:a05:6000:604:b0:43d:7146:ccca with SMTP id
 ffacd0b85a97d-43d7146cd60mr19898783f8f.45.1776244065455; Wed, 15 Apr 2026
 02:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415080812.1284-1-joshua.crofts1@gmail.com>
 <20260415080812.1284-2-joshua.crofts1@gmail.com> <ad9SzwJDwRNldv_z@ashevche-desk.local>
In-Reply-To: <ad9SzwJDwRNldv_z@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 15 Apr 2026 11:07:44 +0200
X-Gm-Features: AQROBzAtGpOQU3zYl9fz4X__8lkzMR5eIzMfFFvxjajnJbOyIcs_AW6JTDHyi2o
Message-ID: <CALoEA-yceh08wYDpoigc6tXg71j=GqGnpngfkDMUh6_m_5fuJw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] iio: frequency: ad9832: remove kernel.h proxy header.
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Apr 2026 at 10:56, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> > Remove kernel.h proxy header and add bitops.h for
> > better dependency control and code clarity. Also
> > removed slab.h and moved asm header below generic
> > linux headers.
>
> I wonder if we need to elaborate a bit on 'linux' word as usually we refer to
> the project as Linux. Maybe write it as '<linux/*>' (without quotes)?
>
> > Checked with IWYU.
>
> We have a (recently new) tag: Assisted-by or so. Can we use it here?

Thanks for the reviews and patience with my patches. I seem to have finally
learned the workflow. I'll send a v5 addressing the issues above tomorrow.

-- 
Kind regards

CJD
