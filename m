Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA1F3D3D05
	for <linux-iio@vger.kernel.org>; Tue,  3 Mar 2026 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547390; cv=none; b=SUKF2qdZwIKefmywyx/LgNV1RZ/reQ/N7WxEucdBFDu5++iI0d9MaeqyNE2dr149rD96igQICJ4jqLli6SEFO3hsTkHuLt0CFLiIgxO+et3Qb4+Ndq6DMjaiIZdRGv9hY3vXqdC773Ikz4N1jK6eYfnkYoEEwBYndQci03cxHAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547390; c=relaxed/simple;
	bh=O3wxBlM5A9IROKIfrvTr5CqxizEqTm2V+XA0/tPb8jo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRG6Wbh0oJz1srPqvHXg6hUKhE/bxaOJv/pZYMTRY/6KSJ1krjsvKfRd6l9kR4N0ijOzDSOyyJMSuDScS2s35UHvmsJ/k5BncomDn3h/Y3KlpD4c/T3GNzp9u3lxqRKttyldcZVwJZWtR9WQ41wghLyP8F+O/5fOPmJcejfqOWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jruDCTK9; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jruDCTK9"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-89a07f66f4eso13957186d6.1
        for <linux-iio@vger.kernel.org>; Tue, 03 Mar 2026 06:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772547388; x=1773152188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SN5gEyJ3CvnwwkSktZKIQYQ3lN+9NI4Pr7f8HGw+b+o=;
        b=jruDCTK9psKhqIPBaHVzjUYt817UWNLRW3uWnQBih5DaWHVTy/vkdmLZAavMLbCaZu
         emPzWCT/BUQ9IczRzgDAo2nNwv/TGfm8BpYdnTEYpFOORESRqAED7PD39XvBv1G/1PMu
         v6s3v/rJbicx0op9m+wQwPaByvo3azmW64RguH6McdKJx7KLUfu6efO+kbJvwUucKbZy
         +2WRLbJpe9K9sbhKkFmgx0lpwx0ZlXqyo8Wk7ObsazhNh3IWTMigegIuJWf/u6VQGo2i
         9W3nbYZfREQ/Gxr6Sf/jwIMWXrfX7uri3rXsVejjQ+56dHwJ1CTh2r98Q40YjeEdAJl8
         MIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772547388; x=1773152188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SN5gEyJ3CvnwwkSktZKIQYQ3lN+9NI4Pr7f8HGw+b+o=;
        b=wMOuuqyga2TIwwBa9bqjS/vSV5uxI3oGaznjotfm1KUhH6EraU75RdRv/NQdYdUm/P
         ZomVeIo7deQJtWPo2U0XBz2qL5BqEM3ryfZWbFIrrnaS44GQxSA/Lcc4SZdKhOoRH66y
         tA8alFkw+3UzBZogFTQr0vvNoNOjtGNUqWUpbrSPCbSLY1bxYNVYr/5OlI67DPDtQGGs
         eDXeokV2mQnhD8r3An+FiddQdaW59sTSlL5RnL83U3PYL8KZfshqqmYyS8rk+FaOHtxt
         G2z86OgmHQIaNGN+IdD0cmaqAwJ0CMjHK6CfRinYojpPBJwDdNUrUKDJjYfE2bR9iymg
         VNQA==
X-Forwarded-Encrypted: i=1; AJvYcCWzTP3Udf2Eesenc9Os3eGOoJSKQp94zhf4TH8qcEoteySRGQcoHi0a3Ly7ag/nbLR2Dz23KoW7TSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD1Wad7y8mySRJ9NAS7+J0RgMH5N6xsVHe+d7nhRtdo1hSoPo/
	g/Yq4Ho4x9xLAAVfF8XHIVglpTlKqRNnlC+4iXhGXfpr6QnQbbG92aRo
X-Gm-Gg: ATEYQzyHIWBKA7O3gf5TtzsQ7Ez8D2xLRC6x59hvQ0r2BoYI1tMXP9qfyqVyhb9BC7Q
	HCcJH6+0muV7sUUhOZOrXeaz2jJDZ931HrTI8qoRSIyBnmUROlcN6Z1lbVON6HuSI+pRAeT5GFP
	KsPffXbsA1qh/nQwP1PpbxB+gIoOXyNzRAe6zsM67Zz2AbJtZMIzs1kc65u2jgDOD+POgCGoUG7
	RnBDKx8onoomMcCACNWYpBKEu3/l/EHnoJxARWVt7GJpdAW8iYgLMP1fdMu514ewW19q9mIC0fv
	5uPwBHXHx/AO2ZPJ6R72JXxOujUlE0Z86D4Y4WqY8EazAA7k59zOBS+3ppU5JLb/g222Gh2zPs8
	ZdBxDX9shJz1ViF/haAWKA29eisASbt2AC0CAkNaa2WtOriahOlBXXMkkPChFFRgMcTVYz9QRUx
	0KINdCYpBsgB0t4dnHyxHPcQwFbEnk3TcNUNX8daHDrCTE2SQL6SGlMxpWdv6x/bDUx3ZIqFBHR
	7H/MfoEebCDgCmpM7A3KiTb0sj7b2AUi1kX+DIrAXQrq+YBS7U=
X-Received: by 2002:a05:622a:1445:b0:506:6ec8:835 with SMTP id d75a77b69052e-507529bb500mr199466901cf.54.1772547387868;
        Tue, 03 Mar 2026 06:16:27 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744ab3d7csm129120271cf.20.2026.03.03.06.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 06:16:26 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 3 Mar 2026 14:16:19 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v8 02/10] lib: kstrtox: add kstrntoull() helper
Message-ID: <qcloiwjlbehs4yyuttvrt46monh7isef4d5nzuwlaby6uxfael@j3trvc5jwosy>
References: <20260303-adf41513-iio-driver-v8-0-8dd2417cc465@analog.com>
 <20260303-adf41513-iio-driver-v8-2-8dd2417cc465@analog.com>
 <aabm23jCikXs1l6F@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aabm23jCikXs1l6F@ashevche-desk.local>

On 26/03/03 03:49PM, Andy Shevchenko wrote:
> On Tue, Mar 03, 2026 at 01:27:07PM +0000, Rodrigo Alencar via B4 Relay wrote:
> 
> > Add kstrntoull() function, which converts a string to an ULL with a max
> > character limit. The function is an alternative integer parsing function
> > that does not require a null-terminated string. It becomes a better option
> 
> null -->  NUL
> 
> > over simple_strtoull() or kstrtoull() when parsing integers from a buffer
> > with custom delimiters without having to create temporary copies.
> > The function is consumed inside the implementation _kstrtoull(),
> > promoting reuse.
> 
> But this will not properly convert 0000000000000000000000000000000000000000100,
> for example, if the max_chars say set to 20.

Why would I want that? truncation will happen in the case and the value will
be zero. max_chars can be zet to INT_MAX/SIZE_MAX if you want to get 100.

> Also kstrto*() have a common idea behind to consume the only \n and allowed
> digits. This (naming) doesn't fit into the kstrto*() category.

mmm ok, but include/linux/kstrtox.h is the right place for this? how about just
strntoull()? I feel like a safe_ prefix does not make much sense if it is
only to differentiate from simple_strto*(), which should have been safe at
the first place.

-- 
Kind regards,

Rodrigo Alencar
