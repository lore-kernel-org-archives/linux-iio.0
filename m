Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5871A3A9633
	for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774008526; cv=none; b=hXs3n3Q9j2u/aR1op12UlAyKAp0f5M6mQ1CchDNUD9dRviMHZyWQEMK0V1OHmJ6Uu5Bbhq8VP9F4bX9Gk77sbpmBntufd6jC7Ipw3xS/lb/oJ3uwzD3y3DBnQAwxrO35Lfqgjuuh0N48fSPPDK4jTPeihV2GhrJOUyJIzCWhfaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774008526; c=relaxed/simple;
	bh=sTci/8J2E+epYvecHi5mLJYOgrVmwPgaF51deVVEfT4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5L2/scjieYV45ldjvbCid09WUh6/lP9WADKMPrhllwEDrr2SAOFr+2y1CGSGrEiNJ57N/7H0O+EGgkGUeYGF6bpJi1BxMK0zRpoWasnFP0OzYCCKCr6VBZ6nRihnsezxwCE1bF1ej1hvvt7X4jWatSbq7AwGG9wwaBpJj3bk0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuJihI8x; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuJihI8x"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so5069615e9.3
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 05:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774008524; x=1774613324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Gvss4kcUZITGQy/ngnNiEgdp54uhtse3hTZBF+Kteg=;
        b=YuJihI8xQKNwIw7QKDEWgHzRv3tYleDRqb3Fkc4FBbMWfx1MfGVz5FnLbEMJdGkNOc
         eMX14PmWOeVapcWiA/4GXjnzhG0S69dg7wNgSQart8Th3lty36qDejCWvVR/6bstzHAJ
         z/lVd/T4OYho15dYGVTRbWinN4kbLr58VJejbtR4FSjzZVXvgNdOUdGHnno/HGCcmKzS
         OCS6NPhYIODadqSec/o/BZ6mhJPFP3zqIhP2N/Bjx58nakhvw5PNSmQGEnCkyiHy0UKs
         6XNQYQpioUpdMCTEHOI3vn6METtUVxLrWWQuPcsW1l2arF54tgYhqvrP+GYSnXQmP9ZW
         sngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774008524; x=1774613324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Gvss4kcUZITGQy/ngnNiEgdp54uhtse3hTZBF+Kteg=;
        b=Q+QMkYq3QfijZeVf16BEtAyGidKHb8WqTCEP1++wItZXKkS6cvVfAakaZpbIhAe4h3
         5EkwSr8O9NCJoxlaZ/aGhb4BLQVAmcqUWYD2n2d+sPMl2rMgAPtWHicYJUFfgxiIFZXG
         aVR9ZL8OexMEaM+zyZ7JPHuU3Ah9MExboEVoaMRShNylLJNwdPZLvBnNk8zfPQTY3/nu
         RO5ZzID2nYqjIlSpDkssik4TcRO3uqF2AtWbnZ81/TTEywQmWf5J5taMicWojuUVh05N
         2p8V67je6xe1WdNROrvgBWlU3NsnvWxp2SbpI/KBqMtk80C/XV540lAKnwQssVhQQDZd
         MqlA==
X-Forwarded-Encrypted: i=1; AJvYcCV56x3ZTKOHBaYxt3RnLgKhUxP1PjizYiezHDfqUYe1DCV/oOA6HiF/hL5iYpZhc6u57pGtV767Osk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSQEE3s/CBxTy4zq4Wf3RihJ1GPKu+QfZk/fdGs0JRHyg4J0CW
	6VPhIMK3O/+7dxoXGKse1DcDRz96qfS8yRP/LOhZrKHsPx/0AvCH3Jus
X-Gm-Gg: ATEYQzw7gb/c8QaPbuPeosKaT1q/u3icYMMts2FNQ2AaA1ugO0BKVqUdivysr1tK7S/
	gIrFwPlbT/t8xiXUE+MbedtWd59bJe0Mksp+RIOEmeppVvBvkMt2PmpMjbPQqex+Cko+rsZxKpW
	0yOfznDwOnJ80L5DNPDJzFgqUp8YIGIwgzYb9I5Vy29bza++XJRodMqfP6bbG41L722qfCY59sK
	OwXDMIeub2lqyvoUxX+4voC0ihCcckukJzmrzqwUpA4wVT6QzzJYG/CWU/jWtnX1+qtMMt0q6z3
	dwc5voKaXPFQ3qI1v6Dn+eFNXC2spaG38WuJOd8jQ+7Xptc+qEADowqq/yDJ2Iz42oTBwYkdEjZ
	PKRrL46cvUZ1Cuuz9YzojPBWC3OtJgcEdLB4bIArILme5X3waoEVjGcAyVbzQHBwCy61+lHOYJ4
	K373bEF+fEWuPGmBsM0zPiORN5WFXzjl70iyHb8OBIyK0EogbHFih5VjmmKZePQyZvz3Y5WwLJU
	l4vyH+IvZQzKi1xRKBCyIwy/ZYGsoshkkrqriQmIw/L+Ac70c0=
X-Received: by 2002:a05:600c:4ecd:b0:486:fc61:541f with SMTP id 5b1f17b1804b1-486fee2e5b4mr40216655e9.29.1774008523188;
        Fri, 20 Mar 2026 05:08:43 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe889652sm22927885e9.2.2026.03.20.05.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 05:08:42 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Fri, 20 Mar 2026 12:08:41 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v8 02/10] lib: kstrtox: add kstrntoull() helper
Message-ID: <ixvzb5mni2lhz733f4fvvzhozmpezkx5s2q7sash3wv3u2g7ov@pgs6pve6kxrq>
References: <20260303-adf41513-iio-driver-v8-0-8dd2417cc465@analog.com>
 <20260303-adf41513-iio-driver-v8-2-8dd2417cc465@analog.com>
 <aabm23jCikXs1l6F@ashevche-desk.local>
 <qcloiwjlbehs4yyuttvrt46monh7isef4d5nzuwlaby6uxfael@j3trvc5jwosy>
 <4mtdzxfj656sjr66npabfvrr7yd7q26l2unhsihjtniz4ossfj@g3qnzonoary6>
 <rygken7oujyoupeanrdnl7r7smesa7js6sn3jsafbajc4sm3jh@adeslfqwwf3x>
 <ab00clb7LL-bmJWe@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab00clb7LL-bmJWe@ashevche-desk.local>

On 26/03/20 01:50PM, Andy Shevchenko wrote:
> On Fri, Mar 20, 2026 at 11:16:32AM +0000, Rodrigo Alencar wrote:
> > On 26/03/04 10:02AM, Rodrigo Alencar wrote:
> > > On 26/03/03 02:16PM, Rodrigo Alencar wrote:
> > > > On 26/03/03 03:49PM, Andy Shevchenko wrote:
> > > > > On Tue, Mar 03, 2026 at 01:27:07PM +0000, Rodrigo Alencar via B4 Relay wrote:
> > > > > 
> > > > > > Add kstrntoull() function, which converts a string to an ULL with a max
> > > > > > character limit. The function is an alternative integer parsing function
> > > > > > that does not require a null-terminated string. It becomes a better option
> > > > > 
> > > > > null -->  NUL
> > > > > 
> > > > > > over simple_strtoull() or kstrtoull() when parsing integers from a buffer
> > > > > > with custom delimiters without having to create temporary copies.
> > > > > > The function is consumed inside the implementation _kstrtoull(),
> > > > > > promoting reuse.
> > > > > 
> > > > > But this will not properly convert 0000000000000000000000000000000000000000100,
> > > > > for example, if the max_chars say set to 20.
> > > > 
> > > > Why would I want that? truncation will happen in the case and the value will
> > > > be zero. max_chars can be zet to INT_MAX/SIZE_MAX if you want to get 100.
> > > > 
> > > > > Also kstrto*() have a common idea behind to consume the only \n and allowed
> > > > > digits. This (naming) doesn't fit into the kstrto*() category.
> > > > 
> > > > mmm ok, but include/linux/kstrtox.h is the right place for this? how about just
> > > > strntoull()? I feel like a safe_ prefix does not make much sense if it is
> > > > only to differentiate from simple_strto*(), which should have been safe at
> > > > the first place.
> > > 
> > > Also kstrntoull() does not really match kstrto*(), as the 'n' is often used
> > > to indicate a stop condition on amount of characters, which would not need
> > > to require any termination character at all.
> > > The 'k' prefix was add to 'strntoull', mostly because the function is being
> > > added to the include/linux/kstrtox.h file. Other names I could think off:
> > > - bounded_strtoull()
> > > - bstrtoull() - 'b' for bounded
> > > - bstrntoull()
> > > - strtoull_bounded()
> > > - strtoull_limit()
> > > - safe_strntoull() - emphasizes overflow safety over simple_strtoull()
> > > 
> > > Extras considerations:
> > > - Single-letter prefixes (bstrntoull, lstrntoull, etc.) are too cryptic
> > > for a public API
> > > - safe_ prefix is subjective and doesn't describe the actual behavior
> > > 
> > > kstrntoull() is still my first candidate, other than that it would be
> > > bounded_strtoull().
> > 
> > could you provide more feedback here? Thanks!
> 
> I don't know what new I can add here.
> 
> My suggestion was (and still is) to have something in *_strtoull() family
> with additional checks added, but no limitations on the input string (i.e.
> no max_chars).  If you look at the printf() code the max_chars was added
> solely for scanf() and has no use otherwise (yes, I know about and aware
> of initramfs case).

but is it include/linux/kstrtox.h the right place for this?
*_strtoull familly... then can we just expose simple_strntoull(), which is
private to lib/vsprintf.c, by changing its prototype to expose a error return?
In my case the limitation on the input string is useful for the truncation of
decimal places when parsing the fixed point value. It would avoid a 64-bit
division.

-- 
Kind regards,

Rodrigo Alencar
