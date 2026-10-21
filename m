Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792608146;
	b=dxqkJ0FcmYjgF6DtSBlBx+jsgFj8m/APIdUK2qNlSPAe/V1J6pkrOxQWAuLn1k5j9o15
	 da8YeLKdVH3CS7jTet3PPDfMxKErsEvk6a+kyb4I/GMDRVHLRTuOQ44JJ3R2jBsMwibW9
	 oKD2Rfd2p9fn71FcnUvPlOqeq5xMow8a4RYMJeZgtQtUwZsCla2mCKQcpFLqDbe6U5vrc
	 mhzfaiV8CzBXWCnPAjBclPqjzrM3v0AMKL2zmnzf/GpB7R7Pi9Jxq0bY83BEcN//R/qNS
	 3edTumjCzyQ2cbZ3Q90CiWNKGpqo8Z4YqqZQmfbNSgrjJ4FhDBxOoSql9GbDiJEXU4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608146;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SJBXnCQJmXKfHRqXv0OES81MaO/XzIb/4ZDkwzt1z98=;
	b=x/QqM/QXJL7aZRHwKaPqU8MMRogoElNw96su8Kmd6cWHslfzeHZoMDY7uuUinotWvwnR
	 I/R7DWRZq/EOlju4dOULl5ewG/2Z4qRDEflm7eVL21WWKSZ9JGPYj7YfrMuYhFNp2N1hr
	 dlinWyXMngzMg/PEjnkF2vH3MYTWio0SXhcGTp9biP9apufBM8bSJZ84Mz3uDYVBSQ/b+
	 3RfjIdN6EJspavBJ7JlRlmrfH5SBV37CPyLD1dQRc8xDWj7CWEZYYtaBMVFkWWZkLkheI
	 NpF2LinsbVhwCQlXbVVwj0uGcOaS24VviTN2j0C7fWpKQhTVqCbBKMpa8anvCc3u8IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IRf6zhza;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CD2606A319;
	Wed, 21 Oct 2026 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IRf6zhza
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531141F000C1;
	Wed, 21 Oct 2026 18:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792608145;
	bh=SJBXnCQJmXKfHRqXv0OES81MaO/XzIb/4ZDkwzt1z98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IRf6zhzaBqHO3dtATHN8jDUEiKza6xOoSdneJiKwDzuEuhFxajEV3K0M+KttkC7VY
	 P2Vs6sO9IcS7YzgjiJGIN4l5JZvZlmuNsEFy+ISkbTJAaQGfzqh3OAz+6ZO74m+LbX
	 +6o6YKwsgTwlwNfow8W4UdS2SX17JEvXItBRldJ9rgZOlTXj+FESFez9zDS4FMbvGI
	 8Pdf75sOhbLA7QAyniXUJOn3JJNnKur6QLzsfevlumdhbxpurTgocu1YN69CaFGAtz
	 zvq2KNTgxvzJjrDgsNf8sbZt+xVvTQKJcoxBgBHGqaa/26Fr+cQfysA9dNnD5kFkIy
	 5ZHBxLPdSMAcg==
Date: Wed, 21 Oct 2026 19:42:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: =?UTF-8?B?5Zue6KaGOg==?= [PATCH v3 0/3] iio: adc: aspeed: Fix
 SCU lookup for multi-SCU AST2700
Message-ID: <20261021194216.034f348d@jic23-hlaptop>
In-Reply-To: <OSQPR06MB7252FB0EB1DCD1069E11CEF18B662@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20261005-ast27xx-adc-upstream-v3-0-ef25552d3a59@aspeedtech.com>
	<20261018235624.1971e7ff@jic23-hlaptop>
	<OSQPR06MB7252FB0EB1DCD1069E11CEF18B662@OSQPR06MB7252.apcprd06.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 01:51:53 +0000
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> > > The ADC's reference-voltage trimming data lives in a SCU register. The
> > > driver has always located that SCU with a global, name-based
> > > device-tree search, which works as long as a platform only has a
> > > single node named "syscon". AST2700 splits its SCU into two
> > > instances, syscon0 and syscon1, that share that same node name and
> > > differ only by label and unit address, so the lookup always resolves
> > > to syscon0 even when the ADC's trimming data lives in syscon1.  
> 
> > For now I've applied 1 and 2 to the testing branch of iio.git.
> > Whilst it is a fix, there is little point in rushing it unless
> > patch 3 also goes and that one isn't tagged as a fix..  
> 
> > If you want me to move it over to the fixes-togreg branch and
> > get it in asap, then reply to this to say so.  
> 
> Patches 1 and 2 only add the mechanism; they don't change behaviour on
> AST2700 by themselves. The driver falls back to the old global
> by-name syscon lookup whenever the new "aspeed,trim-syscon" property
> is absent, and patch 3 is what actually sets that property on
> AST2700's dts. Without patch 3, 1 and 2 land but AST2700 keeps reading
> the wrong SCU exactly as before.
> 
> So yes, please move 1 and 2 to fixes-togreg, and I'd like patch 3 to
> go with them. I'll resend it on its own with a Fixes tag pointing at
> the commit that added these ADC nodes, since it's the piece that
> makes the fix actually take effect on hardware.
> 
Done and marked those two patches for stable. 



> Thanks
> Billy Tsai
