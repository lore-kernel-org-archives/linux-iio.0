Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616450;
	b=qMxphBAUNZhVcyDIy2d48L8Y3ZKaPRFu+MhGlsWjPhivJ10J6IXGD1jhUKFZ2yfOM8oJ
	 0P67u1rXTf96VvNL/EaOE+JGLd+mVgASqpaE8/OXYX1oIuisSxFEduKNf/6mm2zMKbJ7c
	 jaFlYtusIR/dkgihUzyQOMEvs6hRME+3SmOMs11Om2ZkQbvxQ0qlXNryzx4QKTvvHE/LD
	 +tE3CteRv3kDI1AcmLDRHIuQg0tS+PjWwyf6k7AQ3aGlQcx4j6aUUJQrXyC8GZHICLdGS
	 o7VbyVno7SHOD331nMENPr+pSFKFlLwZWFJS3X22NBOT4b7z3xpR909KQ4O0IkwPeWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616450;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QOTynnEdZ2Qvk7iiRKTKD7BwFl1KZcI80W8gzwB1ql8=;
	b=fC/UXZPWuHAPek8W3/v+7jjxfJqoVlZPU/GWv1FnGfYNHEzL+5YS9I7frpdTxFMc4an3
	 TWermvolnNuF1m1K4QzSMnyYXHukpwHjfVA+X3LR9jacoPupV/DAW/SajteJ8V4Sq6pfN
	 yvmDCcrP+K5NQcNtzcyZvCVpss3ycVP5a7vnCRRNmvOHP6B4giJ3GPmpXGhifKkNTmHx4
	 k3QrjcYJ3rPpLZBCXml36TLd3dDlmVXafwgI90drSLpFww+ioQbKUKag7rNA3OD6uNGAo
	 4kUTdvbwDyQ26Xv5/sUXCqjjp3folSr9+NNMW2qmW6W7JJm7qjIUQaJVPl/5D567MAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lYetf1cE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E998606A326;
	Mon,  2 Nov 2026 10:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lYetf1cE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B831F000C1;
	Mon,  2 Nov 2026 10:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793616449;
	bh=QOTynnEdZ2Qvk7iiRKTKD7BwFl1KZcI80W8gzwB1ql8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lYetf1cEHmfG6nwRTCPYf2lnJ/RBinsmH4Y8o+y3t2jed8bATCjnV5p1XlkYtEj+2
	 7g1X3bAe6qZ3dE41ijNlsu33FdVd4hIoICeTZ8h5QZC+dueojJZDOnUKbIvMstfzLO
	 X6tu5UJzBtxA/Q+Tiizx2mculD3KLj5zNH211J/xGJo2YxzOVXHkt77pl+opbmGzPs
	 KW6Xylxop8/F8ZlljEeGr70fHjfjiwuqd7p4OkfGdGSw5ieDFk1NG4tbOB78jGPfKJ
	 yk6/WpmTO14F4J1eZ0bmGLP1cJPKfVe1JQbex1dtLOrib0Q8Lv4jA1qHSyTuzL6sc3
	 P4gpH33oKikPw==
Date: Mon, 2 Nov 2026 11:47:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vidhu Sarwal <vidhu.linux@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: proximity: Add Benewake TF-Luna
Message-ID: <20261102-ludicrous-eminent-beluga-b04e31@quoll>
References: <20261031-tf-luna-v2-0-ce403579bb8a@gmail.com>
 <20261031-tf-luna-v2-2-ce403579bb8a@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261031-tf-luna-v2-2-ce403579bb8a@gmail.com>

On Sat, Oct 31, 2026 at 12:23:29AM +0530, Vidhu Sarwal wrote:
> Add binding for the Benewake TF-Luna, a single point ToF
> LiDAR distance sensor with a range of 0.2 m to 8 m.
> 
> The sensor talks either UART or I2C, selected by the level of pin 5 at
> power-up. This binding covers both interfaces. Pin 6 is a data ready
> output and is described as an interrupt.
> 
> Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
> ---

What is the base of it? I tried two linux-next and 7 different mainline
tags (v6.18 and newer - up to current mainline).

All fail.

b4 diff '20261031-tf-luna-v2-2-ce403579bb8a@gmail.com'
Using cached copy of the lookup
---
Analyzing 19 messages in the thread
Preparing fake-am for v1: dt-bindings: vendor-prefixes: Add Benewake
ERROR: Could not fake-am version v1
---
Could not create fake-am range for lower series v1

Best regards,
Krzysztof

