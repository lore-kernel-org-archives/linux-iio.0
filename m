Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E67639FCA7
	for <linux-iio@vger.kernel.org>; Wed,  4 Mar 2026 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772618556; cv=none; b=MWlo9nno0wZFUSmK8lLh22zIBE5J2tMK8lLlJAkWIinFiyqVyQDITW4tS3PO+Swo0YnLywt3zhcbTroAN9Z2pPfy0YEPmKxPW6jyfdUC0JbmlRdfViaUv0EXHqN9GbmkRvYVW3YKZu6KYRkdw2tjHnlyvmRUTYBQXd0sUcjNND8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772618556; c=relaxed/simple;
	bh=qhAVk9CexrUYHYaDVmDxrpyIR12B9xt6IA/j3lGJkZ0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cY9BqtevzuUavixETK7dQhKIwzwbGb/22R9F9KN49jIFqYMIXkGJqG8FctiAh738lVYLpDRiGl25GD8f/zVPDnjuZBnN31LiFS/GstSEUxoyI+g0Wt/8/BW0HiIMV8to6IQRfbflc9pPU1tMKueTpaldIRGrdH5NRZLiycXpqE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWL0FiaJ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWL0FiaJ"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so3715708a91.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2026 02:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772618555; x=1773223355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dvlbpdH9GKnriElYMJPIHm8iAfnXNmYF7p+RxMZw/3I=;
        b=IWL0FiaJIRdzAycFBnwCwwWOC5Dp9YEbqLq7QI0C2+doWzSu+SdFnr+f8KlTM47vfY
         PuvFlsGxYO6OkGxCHSVhXC7nO2uRQp3GJ65HC/DCcqAvDKZeFxIxBK2FrLCkiBTnbk6s
         DlUNd7RPddfkC0tBWF6d+0L0Krbw6Qg/XGnOMB+YmhI+aVaVexv0Y/HAsO4HkzKQJ+vf
         63L0Xfpfr5FvJt131MoC28yEs+9LYuo+MxZDHd/qLjtCnK3EZZ9pKjeNVQZ0S6Pj+cDW
         9Su8KPDS2VwmpS35fSEq2myoi6CXbOJvoeUlUKk+KI8dpWVPZx6jcrNCxXMZ9BK+pozK
         J/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772618555; x=1773223355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvlbpdH9GKnriElYMJPIHm8iAfnXNmYF7p+RxMZw/3I=;
        b=mT0UGYh6vfSPSJblZ73+DXXcVvk3RUXJna9YTNajQM/3E3HjT2zn272nnZXUkAlzSM
         t3fwzBsbP419fIqvZnwaWOSFemcsqgC3OIgH+alJkjLMdIbM+tAaU191T/KejNRF2AID
         jS7X6x37uYsZDgohRbW3TMjX0t0z0HLcImnDwu2qk3/TUH3GE6Wu524Iqx3mQjzJE6BI
         FSIKJlTMrcjszDXRiEubV8zF9L+AopvcBMoXvacAPTlINU5+b6xJuhkh+xVdAxFR5ELP
         LaInaVN8+l2jTr9llVtDVnll++D5Cl3evQutUsWdtkNABct2UI0anyWMQ5w6RBhv2yeQ
         ae2A==
X-Forwarded-Encrypted: i=1; AJvYcCXMingZeiP0Lc1kA/HP90PWoOWL6qxQZSZR99/IZIwK5GQmeW+PauES9+dQw2YJQGfvtCx1gbJkR5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPs+ju+VSiQS2EH2WjxN7izqHq1T3hJfzsvXPBnlcU093SP732
	ZGoO1RYIjnwmxqxQVvWikSjollY5ic354mk1tPcyHxp47l+yxt6iiNfC
X-Gm-Gg: ATEYQzz/fSGnkZ15kFL2q5vsf7y6gEikaFQzmjmOpLI0dGSXT/WEVG+A4Rsswo1j4ML
	s7bH2ovq7pQbiUfZjtYDs9B9nxGAKNYeiSMadvkjXi8O3P4RiN+CSZPazt4+gSx2uzHaR0mT9UX
	BMoOmlh1C/vkPSikCDPera6VNvAjkQXq/d8S/jYo76UQ2gMoWCaRZphr8iNEDBqA5rcdLCPCOvB
	PbZ7da6Ve76bjf3KM7+c9VJ95oLE4Og7bQ95Mtg6qrMyrIErcSk7qNT2w7MzuG6npI8DP9zbl+A
	7xNuz2X0BOTodvDq7G4Z3KIOk9aUCfW0cuacR3kltT4anol7S5ZD+coVb8zWjWMRQWxa0oDSG0o
	p6ai9mGFjSZwX1f1w/kPZlHvl0lw41/1LpzUJDUXDTquKD8fsD7yEZ1tFolEmHCE8eJFMjzSOM0
	cFnZ+U78SiRFaE2RUq2eYKnEXMVwCr2c3nfaKYdgqMmC0/AZWTJFXZuU+TODYkKcWtXPrbuNWoK
	l9H6RYyR79+Ii1t2FYIt7bR9TkNoUDI+D11/JS6BfKt1CaRqNA=
X-Received: by 2002:a17:90b:3f86:b0:356:2fc5:30d9 with SMTP id 98e67ed59e1d1-359a69ca6aemr1551111a91.10.1772618554674;
        Wed, 04 Mar 2026 02:02:34 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c39d530sm4611978a91.10.2026.03.04.02.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 02:02:34 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 4 Mar 2026 10:02:16 +0000
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
Message-ID: <4mtdzxfj656sjr66npabfvrr7yd7q26l2unhsihjtniz4ossfj@g3qnzonoary6>
References: <20260303-adf41513-iio-driver-v8-0-8dd2417cc465@analog.com>
 <20260303-adf41513-iio-driver-v8-2-8dd2417cc465@analog.com>
 <aabm23jCikXs1l6F@ashevche-desk.local>
 <qcloiwjlbehs4yyuttvrt46monh7isef4d5nzuwlaby6uxfael@j3trvc5jwosy>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qcloiwjlbehs4yyuttvrt46monh7isef4d5nzuwlaby6uxfael@j3trvc5jwosy>

On 26/03/03 02:16PM, Rodrigo Alencar wrote:
> On 26/03/03 03:49PM, Andy Shevchenko wrote:
> > On Tue, Mar 03, 2026 at 01:27:07PM +0000, Rodrigo Alencar via B4 Relay wrote:
> > 
> > > Add kstrntoull() function, which converts a string to an ULL with a max
> > > character limit. The function is an alternative integer parsing function
> > > that does not require a null-terminated string. It becomes a better option
> > 
> > null -->  NUL
> > 
> > > over simple_strtoull() or kstrtoull() when parsing integers from a buffer
> > > with custom delimiters without having to create temporary copies.
> > > The function is consumed inside the implementation _kstrtoull(),
> > > promoting reuse.
> > 
> > But this will not properly convert 0000000000000000000000000000000000000000100,
> > for example, if the max_chars say set to 20.
> 
> Why would I want that? truncation will happen in the case and the value will
> be zero. max_chars can be zet to INT_MAX/SIZE_MAX if you want to get 100.
> 
> > Also kstrto*() have a common idea behind to consume the only \n and allowed
> > digits. This (naming) doesn't fit into the kstrto*() category.
> 
> mmm ok, but include/linux/kstrtox.h is the right place for this? how about just
> strntoull()? I feel like a safe_ prefix does not make much sense if it is
> only to differentiate from simple_strto*(), which should have been safe at
> the first place.

Also kstrntoull() does not really match kstrto*(), as the 'n' is often used
to indicate a stop condition on amount of characters, which would not need
to require any termination character at all.
The 'k' prefix was add to 'strntoull', mostly because the function is being
added to the include/linux/kstrtox.h file. Other names I could think off:
- bounded_strtoull()
- bstrtoull() - 'b' for bounded
- bstrntoull()
- strtoull_bounded()
- strtoull_limit()
- safe_strntoull() - emphasizes overflow safety over simple_strtoull()

Extras considerations:
- Single-letter prefixes (bstrntoull, lstrntoull, etc.) are too cryptic
for a public API
- safe_ prefix is subjective and doesn't describe the actual behavior

kstrntoull() is still my first candidate, other than that it would be
bounded_strtoull().

-- 
Kind regards,

Rodrigo Alencar
