Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4623A4523
	for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774005399; cv=none; b=Mx+UmOIpSf8OWcS/dURrjcjqK1y1JSgcgG2BxSzgo7ydf0x5JqMxhEfKh318qLRVxLxWmWrTy4w6XVW75KxTOyTDuEfgeX6NfV7wt21V367Vd/op0p0Z0IeEtT1zLvQGMKAbhL0DMK2M0HFj3eTw6QWuXjKwT9NFCKwlXweff00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774005399; c=relaxed/simple;
	bh=MYuFIo5PKIOTB/+RPLOxw/oWCfZXFKo2lpXW4JtUSoA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvSrfKJ7tkHJpR7Vyqfy73k/hwKcDZkbS30I1nql8k3cfk3ifkR33cgFmeiAlD14L5LdfvbBwyQhu3HCY2HH0QZT/Mg227JC7UTPuTOzOdZDq+dwvYbXrgnkv2vIbWWqNzW+CwdnTdW3g8TTZUJfnh34OSKCoUkyXaZn0T8Pm48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPQp4JxT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPQp4JxT"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so14437085e9.1
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 04:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774005396; x=1774610196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UU7k8y/47EnkOnpuLl67VB38/rE2A9EJgbrmAlOoe7w=;
        b=gPQp4JxTTiPDZ6X0T2sgvUUEj8pXY45paXdH8gkXVdFkQ5Qv9VEMKdbk1YueSxYWCW
         5ox2ygd8IPXdzlDmNvkW+iAMNziIZV1hKujUFj/fd9VMR4JYjjp03dzosdVyO3E0S6cR
         H1dGKzQL9+W5SXXXoXZtke0sF6V+jpK6bU0ep9UdrMru1qJu2IGRRK/t3JqX9yAQd5eS
         ej0Hn/YT/VjuD/IjdYbTW5VC+PGhbGJiHQfmPOZlW3O2PtXhQoAlj4BcJ+SKeugTyhnv
         voKg/rk0TCZ7Cw6WTrOrtYdxSuWVPSAm8VhYeerfbWa4TWx1V475YiP9c6npZ+uIFYzh
         kC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774005396; x=1774610196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UU7k8y/47EnkOnpuLl67VB38/rE2A9EJgbrmAlOoe7w=;
        b=TNyWYBEXXj219bK3BDzpJ6hqGk9/gtU6tdYqbWQUi2yhXtEMflkRLvmasc+0ui9Fbb
         I1h+0+27aoJOQHsLZalXPJ3nlNgGXa4LoKKzdMf6ro1ROLgnx1W+r6MhyzZxjzq3YOuL
         Qw7uLflvgWcertkPqMU7xLYWdtOVSb+WHhaPUlnme8GenROwn0OzanPXgZdfNc6IrHxG
         X59Dk5Z6OyUKEhTDiLMRPFc9MR3e9PncA6uvqSw6J0pllBsCi9H960HQa6j0ULq8h32N
         64KnbIKey/FGaVkTP+rn7HaXjY09hU7z/1yxVh4DcvTUazZHv6+XNjCgtrH6U8KuEqx/
         5MVw==
X-Forwarded-Encrypted: i=1; AJvYcCUlqBkD9hyy8bIXccihssdWUaU/a0Wm6RLhXFkHLTb/Ok1zx+uKF6N4asKvk/t6J5qln1nZjyZhBRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWuHjIf6nGQ/GhwKYp0rKnMmasWcwJHle7TTxasNebvH840bCk
	gnPPumqBAyr9PM9boJx/l6u9m3hn3K94LkLmDmIXvthdYolo0Ew1IVMl
X-Gm-Gg: ATEYQzxNLoc2rj3V+D8eLovMNjT0sPRCpu5K0q/wdIz/UiLXI/D6v/UmyQ+/jMfYSGZ
	JeiR3sdApMh2QmxylcjN3P2BFTnBgyP+zkUQbe7v+BLNdwKzaASoBJH/WbReF7AAvxPbVn8zF7Q
	ttnnPekUPt9Ab3u9M1uFovlk1F9aKKtRIXkhG0Zo5M5+gegkQSkO1uCMluajFOllGj8Lsic1At5
	0/wjrFXSGWytj/YPNTGkVJrK3N8+zLmMQVxczdXbhildV8RKokw+rpa9fgxw3NFE7R7JN79iabS
	rowW9atMzUV3CdoQE1Fd2f7x48boVbrkRgR6vzklKjyz5b/KVPnVGi0tqLaINVC/T7kak66X9Ag
	LtqZ7HhI/F9EtKq+uAvR05P5IOYzSE2MH91ARtBwXbBDRg4unApqo0ohBhXN9DcWdWJF042Jc88
	xWvrHSAyMXK3PrZ8/P40HdQ4cV7h2gmBtcMdrgq/kiGnO3VrI5ZaoLsManYPrlB9yeHGTOmAdXs
	6GIjcYyOlRmEsOW3pRbfBO2dzMnQ7uxFVgs/O7k47bdTblOMSn0U8b969S2iw==
X-Received: by 2002:a05:600c:8b61:b0:485:3471:cffb with SMTP id 5b1f17b1804b1-486fedd8164mr37626435e9.15.1774005395763;
        Fri, 20 Mar 2026 04:16:35 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b647036e0sm5667505f8f.21.2026.03.20.04.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 04:16:34 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Fri, 20 Mar 2026 11:16:32 +0000
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v8 02/10] lib: kstrtox: add kstrntoull() helper
Message-ID: <rygken7oujyoupeanrdnl7r7smesa7js6sn3jsafbajc4sm3jh@adeslfqwwf3x>
References: <20260303-adf41513-iio-driver-v8-0-8dd2417cc465@analog.com>
 <20260303-adf41513-iio-driver-v8-2-8dd2417cc465@analog.com>
 <aabm23jCikXs1l6F@ashevche-desk.local>
 <qcloiwjlbehs4yyuttvrt46monh7isef4d5nzuwlaby6uxfael@j3trvc5jwosy>
 <4mtdzxfj656sjr66npabfvrr7yd7q26l2unhsihjtniz4ossfj@g3qnzonoary6>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4mtdzxfj656sjr66npabfvrr7yd7q26l2unhsihjtniz4ossfj@g3qnzonoary6>

On 26/03/04 10:02AM, Rodrigo Alencar wrote:
> On 26/03/03 02:16PM, Rodrigo Alencar wrote:
> > On 26/03/03 03:49PM, Andy Shevchenko wrote:
> > > On Tue, Mar 03, 2026 at 01:27:07PM +0000, Rodrigo Alencar via B4 Relay wrote:
> > > 
> > > > Add kstrntoull() function, which converts a string to an ULL with a max
> > > > character limit. The function is an alternative integer parsing function
> > > > that does not require a null-terminated string. It becomes a better option
> > > 
> > > null -->  NUL
> > > 
> > > > over simple_strtoull() or kstrtoull() when parsing integers from a buffer
> > > > with custom delimiters without having to create temporary copies.
> > > > The function is consumed inside the implementation _kstrtoull(),
> > > > promoting reuse.
> > > 
> > > But this will not properly convert 0000000000000000000000000000000000000000100,
> > > for example, if the max_chars say set to 20.
> > 
> > Why would I want that? truncation will happen in the case and the value will
> > be zero. max_chars can be zet to INT_MAX/SIZE_MAX if you want to get 100.
> > 
> > > Also kstrto*() have a common idea behind to consume the only \n and allowed
> > > digits. This (naming) doesn't fit into the kstrto*() category.
> > 
> > mmm ok, but include/linux/kstrtox.h is the right place for this? how about just
> > strntoull()? I feel like a safe_ prefix does not make much sense if it is
> > only to differentiate from simple_strto*(), which should have been safe at
> > the first place.
> 
> Also kstrntoull() does not really match kstrto*(), as the 'n' is often used
> to indicate a stop condition on amount of characters, which would not need
> to require any termination character at all.
> The 'k' prefix was add to 'strntoull', mostly because the function is being
> added to the include/linux/kstrtox.h file. Other names I could think off:
> - bounded_strtoull()
> - bstrtoull() - 'b' for bounded
> - bstrntoull()
> - strtoull_bounded()
> - strtoull_limit()
> - safe_strntoull() - emphasizes overflow safety over simple_strtoull()
> 
> Extras considerations:
> - Single-letter prefixes (bstrntoull, lstrntoull, etc.) are too cryptic
> for a public API
> - safe_ prefix is subjective and doesn't describe the actual behavior
> 
> kstrntoull() is still my first candidate, other than that it would be
> bounded_strtoull().

Hi Andy,

could you provide more feedback here? Thanks!

-- 
Kind regards,

Rodrigo Alencar
