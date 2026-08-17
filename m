Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B8640DFD7
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 12:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968630; cv=none; b=U05Z8U3O/Plm4pRTFVPls7DMEttxcS2/6jeXazlcNmpxWz3jYTjNIm8ZXMK0vC24D7rddCcypTxnQqIkmZ7GEO434AecuctW+Q047+yVIhNAhnv3RHIQ8F8tYuyWCdHzE+fh3vnSqVkNDb+ie1WwmV7HAct6G9bhwnw0BPaCBLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968630; c=relaxed/simple;
	bh=jMP9MThjemeYakXj/pzFSuQjW7TmSmOZN8BM7kKu6WA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lv3JmJk/bqBhghxRo8z/EC8FpycXMC1GyhJEdfb0+xUNddj98P3AMdQ5xhUTjsIEMchFJbvuaj8ntYYJ4ZqMeWBCQaFVz+kghufNd1m7PY4x6A7Dd+bpvBups030E4Gp2EO1lKs+dIiv2pRVFO/9xNq4FmOt/varrtIq9hwjkIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqMAGMtt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqMAGMtt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D5A1F0155C
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 12:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786968628;
	bh=jMP9MThjemeYakXj/pzFSuQjW7TmSmOZN8BM7kKu6WA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PqMAGMttp3ylLBu+Kavzaz64O5zE3DG5VJWmhtEfhvdJmWkY3ibyNnQpxMj+esoCk
	 uLiX40JJvPyBx9j+M2xffXN80RKt0BFHVM/SoF+KhKfduquByjsHw8jh9thN8/t8AB
	 3Q6BxKoFX3N8Kb/7K0ip7OUWb76Fs2F4eohEOtIpdLkO7wqsCZST8eP4s/yVNUcVmN
	 mEBK5KSjK86YYlL6lnJeKjCMmV8/n2b3FrNcZHvUAJEf1zvxXUH6gvSWlOT3nqCkxU
	 KYTDRWgSLAnzNEZAChta0j26I3fuoB0wGZg+vYyBWl6Q0LkKAVpPjIwUcoJXl5nnul
	 SV3OFXU5ijCtQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b2a22c52c1so2856625e87.3
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 05:10:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpNQq3tBqpyVazJg7i/bQ6RtuVeYMqfudcp0795GBfJalhhogrxl+NMH2QmRMkkXm1GfF+hJPM5Lt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycV7BzWAgB861OoQazX7y6Lg96vColbITsmfP2WTc9HzGhS/Co
	emkciNRfP+8CQ0/h8vFvj3S7HC9nRQJB0tDGhqKhFheY1ALabs+hP+fKHhBb2Qb7m0mBiETLMmx
	Lwb30A1pth3O+afaNRDX4/suvNoJqgHI=
X-Received: by 2002:a05:6512:a34d:b0:5b4:475f:c322 with SMTP id
 2adb3069b0e04-5b45913fe58mr2462718e87.43.1786968626410; Mon, 17 Aug 2026
 05:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816060648.4030-1-farbere@amazon.com> <20260816060648.4030-2-farbere@amazon.com>
 <aoFgF2E4p4DqYLGG@monoceros>
In-Reply-To: <aoFgF2E4p4DqYLGG@monoceros>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 14:10:13 +0200
X-Gmail-Original-Message-ID: <CAD++jLk+MMH=-ifdSs=Vm4G9RO5-yVs8NLUb4AE1wYH5FQrmjg@mail.gmail.com>
X-Gm-Features: AcwNN1U-dnnBMYmPJIsmbHOzFmj95rCcwG-Rxxba2eA8HCClSSdawz-FswV3dYE
Message-ID: <CAD++jLk+MMH=-ifdSs=Vm4G9RO5-yVs8NLUb4AE1wYH5FQrmjg@mail.gmail.com>
Subject: Re: [PATCH v5 01/13] notifier: add device-managed registration APIs
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Eliav Farber <farbere@amazon.com>, rafael@kernel.org, tony.luck@intel.com, 
	bp@alien8.de, guohanjun@huawei.com, mchehab@kernel.org, 
	xueshuai@linux.alibaba.com, lenb@kernel.org, 
	laurent.pinchart@ideasonboard.com, brgl@kernel.org, orsonzhai@gmail.com, 
	baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	dmitry.torokhov@gmail.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	W_Armin@gmx.de, fabio.m.de.francesco@linux.intel.com, kaihengf@nvidia.com, 
	ankita@nvidia.com, leitao@debian.org, pedro.pbg@usp.br, paulmck@kernel.org, 
	frederic@kernel.org, kees@kernel.org, saket.dumbre@intel.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 9:04=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@ker=
nel.org> wrote:

> I suggested to add "Must be called in process context." to the kdoc for
> devm_atomic_notifier_chain_register() as this is a relevant difference
> to atomic_notifier_chain_register() and create an immutable branch for
> it as a base for subsystems to apply their follow-up patches. I'd wait
> till Wednesday for concerns and review tags to tickle in.

I think this is a good approach, but we are in the merge window,
don't you wanna wait for v7.3-rc1 and create the immutable branch
based on that?

(But Bartosz will be the one pulling the immutable branch...)

Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
