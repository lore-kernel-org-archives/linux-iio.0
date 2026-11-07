Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794066027;
	b=YcBVJTMQQgf0WaDGzb7KMjo3mXRDloaY/whBeGkwhuw/nKHdRoYVb211EDJNcJ5CxopQ
	 0/KkhR6nkryJmc2Y5AQcw0S8Rzqxx5b+DFdZrLiucBy+27w9YCbYJpblGmsmcGN1bmq56
	 JULkAwH3UNu/1fiSmcWsx0OHCovFg5wLFcai/3wYTw7NBbab0cShM+03iQ7e+vpF4Tjhc
	 3v39AGweh9Hp2HrnUoPWL3KCzYnOR73Wza9qfVwAgHjqmwvstbA7ruiwH5p3zSHHgsXpA
	 whAl7Vk+1SY+/CxbafNTfA8wSD0Nf4sYGjQvPT+t98zfymjSgkEpJ3XJZsYVFIqlUuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794066027;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=0855Lhy/dON8JVTqKZXNVM88rgbhtEry4bgMTQuUuV0=;
	b=uRON332w14PwyJzGGSzwXWlUy3a226X0rOxW/CORj9qhc9JmgAKr3wBg3SvHTp18M//m
	 +6WR4UxJ2LmmRpwbGCG0gHPgUdLCcX5T7u8WmfyXtFkRAtPiZ6XL4aKgQ8D7xe6bnFJa4
	 fjix/tbvb++F3A+8zt9pahw/uOoblibvd/zMrgwTunC8Z/hmQe6qLX/uwWqlnJOQHnPDU
	 ZsKO9/yv+XEbOf3YKRgENQaP3onHUcNQhsQDeHCY5DBD3PCE4SzHUAZG1roZIcei/Eky1
	 QIGmjq4YFG3kLrxyR46zCq+/JLeY7O3vPTvnCxLFKMtZj331dP6AHSFs90ZTHO1Ii7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c8TI1Sgc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A351B606A326;
	Sat,  7 Nov 2026 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c8TI1Sgc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7221F008A2;
	Sat,  7 Nov 2026 15:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794066027;
	bh=0855Lhy/dON8JVTqKZXNVM88rgbhtEry4bgMTQuUuV0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=c8TI1SgcR2UQaFEN+sXtm92nv3SKKB/Ab3Sw0w0Y2S/n5I01TTrS4jPLmIFgTPvfD
	 2tF3BVTYeSP3uNddy8u1hWpVQZPaenQ+gLf8hgZ424VGuzkp9huPArXCEhHbtcF5rr
	 vKMvKeJmvCre6ffh8fm8E0ZSIR1T433Se6NQ3m52Zsnxswh4l9USGIrRtPXIr/BxL+
	 s3iiY6EMD4vsisXDuXeLlxcMEj1g9fPCLatw1hcyY5kSIpvOfD3BbCUwmg6tTItGfa
	 vibEzB0nAn02i8d8zo5Cs/i1bQN+DnjMfuQ89cVDJA6500JZDyO9RT+IevtOz4J/wX
	 pdK1kZzmUftIg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 7D3DE2AB366B;
	Sat, 07 Nov 2026 15:40:24 +0000 (GMT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 4/9] spi: restrict CS logical values to a contiguous
 sequence
From: Mark Brown <broonie@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux@analog.com, 
 broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, Michael.Hennerich@analog.com, nuno.sa@analog.com, 
 jic23@kernel.org, dlechner@baylibre.com, andriy.shevchenko@intel.com
In-Reply-To: <dd50e45bff4b59ad656f94fffecca28a49f1d2d3.1792435248.git.Jonathan.Santos@analog.com>
References: <cover.1792435248.git.Jonathan.Santos@analog.com>
 <dd50e45bff4b59ad656f94fffecca28a49f1d2d3.1792435248.git.Jonathan.Santos@analog.com>
Date: Sat, 07 Nov 2026 15:40:17 +0000
Message-Id: <179406601716.3424803.6294014265604547763.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=535; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZAf43SC5Wwsv9BlH9bz+p7xqTH/dS8B+Bfqtk7gFLeA=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLeuyUeeZjrqiUyK/LlS0OVF0un/opf/UHAJP8dW5ax+
 WxTzmW1HaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZiIqD7D/5CJi76LTHQ6v2I3
 x+0pZ+czpa27ce5kSt7c7+8lbkvHKT9g+Cv08ZyxsPjDa1e2bitOj7/FoK74T3J7ZOXBmU3fpPi
 uzGMFAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> When a device uses more than one chip select, require the logical CS
> numbers to be consecutive (for example 2, 3, 4). If they aren't,
> __spi_add_device() now fails with -EINVAL and logs which CS breaks
> the sequence.

> Changes in v4:
> * New patch, suggested by Andy. I assume this might have impacts on
>   existing users. Should we make something else to complement this?

Indeed, see ge,achc for imx53-ppd.

> +			dev_err(dev, "cs%d is not consecutive with cs%d\n",

%u.

-- 
Mark Brown <broonie@kernel.org>
