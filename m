Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631BF43C7DF
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790758248; cv=none; b=k3mIrE7qGm57teydfFd4oaXs2QBbrIKcfFrfQiJ0u+XsDCMFc7pJKLie6HvVDZ9smtp2IYRjlb+/ES5lQ6ntQPJPJP1lg7JXv3XjFbrwDETCHjMRvLc9O5tSikfwKOSB+QjwuZ9Lko43IwP1NkNMXCMh/QNZpeMbOFI4vNf/dFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790758248; c=relaxed/simple;
	bh=mxzqvlri9Ibwbqo3RK2wB3BTMPpW+o/FKFXqTM7hluI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p27kwkh+HQckWILqMtgXm1nltSn0e2TwyUI9KbVgM2lNM5Ey62GubFj5m3S3HAeRqBXCxI9P7fxFsAtGIdRzWZWkmI8ZWmkXIrEQ1czO4j67rgabEsc7rKqhjF+isUQIhXAqs3XMN8RQoHkz9bOFTclvzV0Z8+xffp60534m1Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gq+Hkz3b; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gq+Hkz3b"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso53132695e9.1
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 01:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790758245; x=1791363045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=syerpKjnrG/V4/mGWnapKjB8nHZ5GCsdjKXFguWOck0=;
        b=Gq+Hkz3bHqE55uR4fG4B1XrJWAUOfWCcSJJbTGm8KzpRzJD6EGieHgT9FsvUdLrGOW
         e82zoDjtpK4xnSyUtV9Vhi5aXc/hIXV+X1XpU/ocu8QJUscaLESnrRnBA7V3wFCHijE+
         qxoBO1qeWorsqbiUhzilETTEzKEWrHkQFbR9lflE7MUA4XFC2a6vYnal1r7agDZD99Py
         kVvlB0p+hMfKIHVZtsWApaiHO7b9LzmfQZsPfzZneSuSf3LOizSEkVLw9ElYpLfPkCkK
         fQARbcR+uPqPVxe0arhcg3eljNyGdmdoRsVNQP81gR7lk+D7t3J1SmusN7WSCrnV1Hiz
         adDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790758245; x=1791363045;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=syerpKjnrG/V4/mGWnapKjB8nHZ5GCsdjKXFguWOck0=;
        b=gic5PE4yvNl4zNss0d43G4XkI9wkwWtlRH1BbjoJ0YsxbwYD4W1Uz+VJQ6RR0BJQYj
         XRFhdLErlMLXdWhknD+8ZqNqJum+TO1H5RFPZSURLQkWpBSmc8j04LcJcqYW8EZkG+bZ
         pWZtyimWdtAl02taTpin8LlOJp6XROwVhnan1n01P0BpRiDbTPJ2ymx5xD5Piq0PEQ0b
         gs+aYMy+ioDAz6gUR5xPncanubRDiNnNfvJov0sFYUQcCY1H/TaNc5YYZlw19HdaKsxm
         8lAd7JQC6lPXt6Ryoms2ZNH64pKG8c1BvmW5VFL7TJzbKtZ9RHCmafep9Eu3jzJeUb15
         PGkg==
X-Gm-Message-State: AFuF++nO5P6Va0JEwkbBM3oeKyWAX1FzvnZC+xT6GSNBVBjAa6m71E+S
	6GPo7rMbxQAnVEavdWsLic03y7mGgaXBVfPUoLLR3MmlCTXC0VyUnRwe
X-Gm-Gg: AYBFou26isnzxbQ0on28iXMOVc+aOaLEBx0ZTUVau/JGB/0ZfrYBtMSarcABy0fJ0E4
	ZUdIsRv/aa4LnB3Wtr/uDWuZedxgEUTS+KSqghmjavI3MBJhMXjdN1NADNSDwcDIQjOEULaM3Pf
	UjMCv1IEATOvHYBaUS+INQpG2ZlY73rdCR7lNV2XMJRy02RcxT+dZBbI2zV2EuXWMFppjYMYZYx
	xWHftaiVeEK4jq5yLtipVO0tiOrqMqXhb7DvyO+Tbn2sw6vg6++rNNPszS+EgsOMXRAg6wvJ9NO
	JdzLYD/H2Uonan7ZWSaXwBLIgHBFoMxEsir6nhpzlNXTEQBbz6ryeWwJ71j5lh/HiuJLwth4fao
	4wUVT/SV4xxgdabRDfYyKDBirBkoOXRDvkVMjraJJ/HuajJ7j00f9VzoMY++foPe5R6mOcB+a5L
	TgYq/0TtGLi0K/IqGtRzl7co0ASv/Blewklw6g1KN7GFWzzF011AFouZ54wymv5apCRop10Lthg
	Z/Zf1hKYuRT+UZcqIVSiGXUM7PFZOSKBqvUVMVYTcrQF9YwBHp2YcRjI2lbdTIOm81tptByTlu3
	gE2o8v3Y2Pzy6BEpZdaahDMON9rpnhg38mg/UKVfGOz0Ucp2i4tYpfIYFgbOIZMFMn+f03SNwhn
	+aAKcs2Hk+6YgPh1oe1S/oKGinXgpnK3EYV5MfvkUq6PMTN0fXX4B6z2Nz2nfekTEIWnL3y/+8q
	b55IXnGxJ0JOA5SeQ=
X-Received: by 2002:a05:600c:4e56:b0:49e:8377:c880 with SMTP id 5b1f17b1804b1-4a01b00ef27mr11371415e9.33.1790758244505;
        Wed, 30 Sep 2026 01:50:44 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01751613dsm36189785e9.3.2026.09.30.01.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:50:44 -0700 (PDT)
Date: Wed, 30 Sep 2026 10:50:41 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>, <jic23@kernel.org>,
 <nuno.sa@analog.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <Michael.Hennerich@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v3 02/13] iio: adc: ad4134: Sign extend sample data
Message-ID: <20260930105041.0000303e@gmail.com>
In-Reply-To: <a57b3a24401b3101aa10b69173e5edbde326e741.1790719424.git.marcelo.schmitt@analog.com>
References: <cover.1790719424.git.marcelo.schmitt@analog.com>
	<a57b3a24401b3101aa10b69173e5edbde326e741.1790719424.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 19:42:29 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Sign extend ADC sample data for correct delivery of negative ADC input
> difference.
> 
> Fixes: e0bc6d7e2584 ("iio: adc: Initial support for AD4134")
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
