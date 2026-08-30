Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AB32F84F;
	Sun, 30 Aug 2026 23:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788131401; cv=none; b=IzDryKioeKImTSj85ygn2x60Z5446VuYNCfAjbCRfvWwUJP0yL7lPmicEJJC34gNKS1I8cZu/7c1cF3FzytsR/g6gdMfSRZZniu9RWG/cj2qQ8JiM+XD0yybi0rekT1EuAeWtY3Y2brAsDQoLC2F1sh+SyUR7Xx96EzRdoci3Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788131401; c=relaxed/simple;
	bh=o6ncAKp/agJGNkrGUyrWfgbBSyM3bYMPCVhvmW1f0IE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHk9pJgYfxYMpA3Ix92rtBBiIK6seLXy+9ulmb87Czq36Rw81gB/Qg3/8KG8eHAMR3t+Rzp6aSQ6S5ZgG18ML2Nt0F9UiwwMaBkAKXq859t1pLzWzDt0KaY7BR2tkoOiwYPVfd3ktGF6ZX7MuVhHB18wU5iS5oZA/yx+M5RlwI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFCWqDkp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFCWqDkp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324F81F000E9;
	Sun, 30 Aug 2026 23:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788131399;
	bh=Y2+RUgZrSo8A0xYY02q8FLLQK1+w51/yo43MrMap1QE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gFCWqDkp4rRxyow5uYQLVnMzj7/NWCtrD46Jwgfu2O+U5lICzmT4byKo2lp9AmRDy
	 vzxGFUs053BLIvSJdLqjvaeACJBqikYlF3uTTbvMi5nDY19vj4D/MmJOley+670mPB
	 x0mU91vHiKOV98UBdZIiXbacEUK+BDUHfHIkM/O5/hWVbYq7umfzVe9eSZMsdIHEMI
	 p0K9mOOU2DQuNIGt2E6UVGuIv+imuQlzNgqzVn0zSu2LcCXnSWHSmqc3npVRw+VGxX
	 N4emXJYoWich7jIf/sKfKDOx0Hvjs0tllTYrIm/z1jPigefxWNJzqgewL2ToSwmywh
	 WqLVby2cyBuWw==
Date: Mon, 31 Aug 2026 00:09:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, andy@kernel.org, dlechner@baylibre.com,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v6] staging: iio: adc: ad7816: Use modern IIO attribute
 macros
Message-ID: <20260831000954.634dc435@jic23-huawei>
In-Reply-To: <20260827214721.19395-1-mdmahmudulhasan1511@gmail.com>
References: <20260827214721.19395-1-mdmahmudulhasan1511@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 03:47:21 +0600
"Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com> wrote:

> Replace the legacy IIO_DEVICE_ATTR() macros with the modern
> IIO_DEVICE_ATTR_RW() and IIO_DEVICE_ATTR_RO() macros.
> 
> This includes renaming driver-specific callback functions to
> standard <name>_show() and <name>_store() formats.
> 
> Signed-off-by: Md. Mahmudul Hasan Mabud <mdmahmudulhasan1511@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

How did we end up even looking at these?  This is converting attributes
that would most likely go away in any attempt to bring this driver out of staging.
I'd much rather see the major surgery needed than tidying up around the edges.

I'm not particularly keen on any effort being expended in this direction
without substantially more justification. 

So as this stands I'm going to ignore this one.

Jonathan

