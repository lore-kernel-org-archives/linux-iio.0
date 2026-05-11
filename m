Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D087365A19
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498060; cv=pass; b=SIMfMA36/RfJjGAZmdMdPLgDuI3Cx5Q2ELDxgJcQygFNtteNeM7isyw+Qi9tC74/VE9tpdlwlWO7pxPuZF1Upu3apziWBMuNGl4nSWfRRnRBHWyPlDcGpct+LpHt/nBKu+/4yeU2/A0gjtEzuroP+mQ5nePAI25kg4l7sJgpT5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498060; c=relaxed/simple;
	bh=NlohqleAJFGziHLqFn7Q4KRH3OGwrrf0HNgzmgPn9Cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6g/Ugc5aRW4Rb0t2DGdFp+1ftW+yA4CyPVQZ4zx6ozCOfPUwJvQDVNd0GKkcpxJPIAi1DE9EchUWIaS72yJgKlSMewEjiWPdTqfOxMMzPvQur1Gugxc9frw5CUrXJMCA8nYCboboiCewVxNKOGx5tuV3iY2qeoYrg7LKKxwd/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=notq4Yq5; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="notq4Yq5"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488d2079582so44850205e9.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 04:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778498058; cv=none;
        d=google.com; s=arc-20240605;
        b=eNrs+v5q6d7MbP+6e/DKdu6HuCzUt8jJzZjPeYK2lEtWKc1SiBzLSdXKLqjYF58nXI
         3Nv1++U4E6g0lYVCO+9LQs97RY1pMRm/BkVwb79hvPiaSgMoUN0adhEtFJzYWisCiw3S
         Gxin8uhyMHVy15kVkOzeNf8CKp7PcMvMG9c+JM5ilxIRsWj6KDyOSH0kUUNLHag4udn5
         cylDiXu3XPIbfZPrJnOeDLmFYPWDjSmCH5fAltxPDONEKkY6a+CuobH63EDGPBLrB3om
         t6pIRHK6aWvGXl+iWStwa+REgSv85HSYZN0TD5Mofh5Vt0Ly73N2HJTCBl0P1jO9w2By
         p1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dY02oOJR18DmMEyqxPhAErPEGR1Jbl+Nm5QU/9r67OE=;
        fh=jwogG4cTDeGqVvpsIDzEuVRIBAs/uFvFWPGuQ7zIf1s=;
        b=SynXIsDAjnOd4rd3UR64lWqOqvdIzYw2VjyT7rFRzaPuB9tdml6TiV1r0FMqnsfMnI
         zY/HDguJfaScGTfiVsDmyyMh3tAWikIsLGOhyBsgk5HpAviH0ND8OSRXeOzj/VtzIt7/
         nIt2T9AKOP0l+u98PJkpFAnBO539fb0qDouGdXPykQhq02Twmy5z/dg25EiqFRtHDgWT
         lf3K35lN5GjaGV+k+Gl1TtRJhTcoDkd7Cuop5v6EK0pR9LZIZ6/N4pwNDbn8CUHsPj1B
         4v7oSoI5jvkjqHk0IH1E0Oj4KT52id65qRkBLzWwhtlI/pY7zeS8Ca62DmjYFBmaz0Sf
         QeCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778498058; x=1779102858; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dY02oOJR18DmMEyqxPhAErPEGR1Jbl+Nm5QU/9r67OE=;
        b=notq4Yq5Cblt8qfDwnSEgkoGdqoBOZMJTSR/uDhLEQm3AKowoLcaTYZ+9PJDMczNdu
         905vJc+qifFf6tNTFjqW1EbXRfX1MnOnO5lQjjIkGiBEsCxDjc7ZyMwtI381dSUIuVoo
         NC4b3bCe+FuvQSzmJe9luIf3UYg3cN4wkS6zmRQfuCk3gMSjohN8NPyjZtsbQYeWmzA3
         AwvsBpVtn7xsSToVTAw4dBvhSHFBpe/iN9Rs9e/cSZEjRoXDwtfCNeZwwxh7VrdFHWE4
         gpCXt+T1ViwHbzGSvS6vqT909JMg9X7qNjrimZiQ8aAmnaVUf/7eH6UfQMIC9XTrJx5c
         TiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778498058; x=1779102858;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dY02oOJR18DmMEyqxPhAErPEGR1Jbl+Nm5QU/9r67OE=;
        b=fNKcssyw4LTqMtJ0WhzGKL6bry8YTzq0+xPHwQYewneJy6hH65YpzRlIgvFh2oM33w
         KSJpCJmPmfyjvPyOA1rXYccUtaiWloS2KvDUIfMVIuHKG0Qtvl/BWz5BPyXn7ZIvmffS
         m+FPKej+ms/WCxfqN0JPIKP02ULEW2i6jLvw8d5tuvLdjGmReTyqrGnDXWYIGGm8RZ6X
         3i1cB1y/2lNQmxQ8H9pPiMyl7YuUxMmMrMnhfYQc1W3UXRp1DbmbkSoa8aTh1D/Mlh60
         Tt1IFT2IjXZ7OGyedKfzUSmwLAE6RretsZxtxwni5vs52usyDuzsi3IhBX5poU1ntl9B
         utyA==
X-Forwarded-Encrypted: i=1; AFNElJ9TD8988/1TNCtsLE5Fr+hrFuG6g68+YKCmTSeusXtlXASHsZ4umJXjKmS3FLoVue4NEgAeQlCUuOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFenER+IfAzXUEoyaZKt+lIrAE5GqiQ/Rlp/g13bKHAahFs8rM
	q9IAtaJ1W12+Ys52TFggLH2SnzZTDf8n32a/o5YrxtjnE7N/z/htGNrjdwKJMPmOgZ5zi+F7zzC
	pzmGNVrifqd7EzV9Df+P4jaI1XW2Z3HM=
X-Gm-Gg: Acq92OFxrlJx3Pcj1Op8wEK6dbGpGo5n9YqvxJdg+0vj83og5kEIq1DXBq+VVUpMgO8
	KAuwNQXsSSmBKof1+XDhrSr+5IJqn2cUVXjuw6ebDrHwr7dqhajWZfkZWvZAItGbKLQILI4g+bN
	xyvae4qgzDYtq4xazM/sBteobln6YPGdXQ/GaBzWSDBj3aHVCqTCJ0ropU7r7zl6A43vx0KolRL
	9C9kz1BLkOlUcHDgsxW1wl3HWo4DjFdVVesdfVgOkzy6fwNNWmPXxjkWgd8BTkwPxGIkx2WXqFl
	JJcwSQ+AQHccc4qBo9lx8qePcEGP6oaTx8GJZtYh0BW/7RhyRs+Pf4WotXB4ViT6HdCeZEF7cL5
	dYzAjuJ1PaE9Vt2T+5eDGR94eOtx6qtDR0ZFNGQbgB0Ko1qtr6n3i8JQGHQE7/hX40qKab8bCwh
	USkWcv0YyS3zMoW2Y8
X-Received: by 2002:a05:600c:3b17:b0:489:e696:836f with SMTP id
 5b1f17b1804b1-48e51e15718mr350885765e9.10.1778498057623; Mon, 11 May 2026
 04:14:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com>
 <20260511-opt3001-cleanup-v1-6-f7879dc3455c@gmail.com> <agG5aPwGcxm2IrxA@ashevche-desk.local>
In-Reply-To: <agG5aPwGcxm2IrxA@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 11 May 2026 13:14:05 +0200
X-Gm-Features: AVHnY4IRgrGK5HmIZhHqif9JF8_LK5wNPQbldTccBmX0nZITKU0rgfdAVym3bnY
Message-ID: <CALoEA-zRt-DfBH1Tx+SFqpbvcQvoAxkMcrpdTp62XTxshZTTyg@mail.gmail.com>
Subject: Re: [PATCH 6/7] iio: light: opt3001: remove unnecessary comments
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 13:11, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, May 11, 2026 at 12:04:11PM +0200, Joshua Crofts via B4 Relay wrote:
>
> > Remove unnecessary comments as code is self explanatory.
>
> I won't touch the first two. They might still help to easy navigate in the code
> for anybody who reads it in the first time.
>
> ...
>
> > -     { } /* Terminating Entry */
> > +     { }
>
> Only this one makes sense to me, but since it's just comment, I would dare to
> kill 'em all in each of the subfolders of IIO in a single patch (id est one
> patch for all in iio/adc, one for iio/dac, and so on).
>

Fair, I'll drop this patch and do a wider refactoring.

-- 
Kind regards

CJD
