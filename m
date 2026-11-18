Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795038712;
	b=lhEcyzGipyTcDnOnS8ZKsItUqBeyKEWiQO9HCqx6j6Vi0W4aWpmE24KfmaHAj1/7bt2y
	 KB0JgR7wEu0ulqXelzW760svE7lcgEnRf98AFu1RR4WK/sTOLMpHjydyAJQLduNoniULH
	 HkPbvp4gCmGOl4+1RQIHzxyLAGxkOIoiiGQ7hHhqXO5NibnL9X11cI5PBpaBS5TQOWSr9
	 xkU4avpzas2AqsmdXwiliJ8+lMOYoanAzKH5oDkp1LL+wIX5xqNNLwtyIGt7mZrwkcVXj
	 rxn8iA0jehwKWkcwv2ZnKOZQgefRtt/iJWKA/84iJxGLcZjkNzfbtMD4JWjP5hEENoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038712;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rvE6rq5sOnP8SXR/s3Rz5NZJQ0oCtKnvfp4hDVDsKYE=;
	b=X8JuyMNM+newCvOcBQH8wFrxh862dor3fYwl7mp8Y4+Cn/PVOjPgMNU5XXjgrSJhKD1I
	 sTbRG2vpd5VkIVvaJhkz74+3BM1oCvw89oGFlh4nP3tDpeDri2l9w1vbETsNYewidy9Jl
	 gPOH47aKeW7EtR2PT7enpOfFUUh/zvGnwZNbXKXX7CpalFcMZbIFqSPtCMi/24Ot7A01F
	 G6E/n1pwvG+XxccwixoXcu6X8Dr+wqdcv0M3gX8tasj46qvjTDaIB+oR29uHHLPWzWYB0
	 a0mVUMoeWD5oBtu44IzqjcCOK2k2iW57tRYNYK40CESB4JGrKkZ/95RtD3jEBQqGFAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ejm1WQUf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C74606A31C;
	Wed, 18 Nov 2026 21:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ejm1WQUf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F291F000C4;
	Wed, 18 Nov 2026 21:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795038712;
	bh=rvE6rq5sOnP8SXR/s3Rz5NZJQ0oCtKnvfp4hDVDsKYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ejm1WQUfifQ88eirtG6eRgm1/oeom0Xu4GnaKZOojLY7DlwCPXjr29Y0/9qdAc4Lw
	 952wAsTzKJIRa8N9fnOQ024wy3lYPHLuRvf/zmJIXfCuxubCnXkG0dCc7Vh6u4+ifC
	 4s8bGNeSUT5q1GCheWyUxW2Gmj2zQx1+SVKGvXCY07TT5tuVoh9VwrV/dEcRcnFt1+
	 qOvjVQb1zEfusu7ZoSYlX9yMFK9uyJsVt8W5sB7NB8a9cANZW5Nivg9tpN2SNWgGx7
	 DvaekMK6iUV0c3p2RkHxk2VG84k1ELw9ZUqisLsC56eP60J3UjbV/AIUijfIo5oN2a
	 9vgF8rNP6/nsA==
Date: Wed, 18 Nov 2026 21:51:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Roman
 Vivchar <rva333@protonmail.com>, Luca Leonardo Scorcia
 <l.scorcia@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 0/2] iio: adc: add mt6397 PMIC AUXADC support
Message-ID: <20261118215144.301c2467@jic23-hlaptop>
In-Reply-To: <4c64aa52-2b75-427e-8f26-c2ef7fc5b822@gmail.com>
References: <20261025-rbrue-suez-upstreaming-mt6397-auxadc-v5-0-5c3c7a5a1851@gmail.com>
	<89c8cadb-0ccb-4aac-9b95-89f355beb24a@collabora.com>
	<60eeaaf9-57db-4ca7-b4f5-bdec111dcdbb@collabora.com>
	<4c64aa52-2b75-427e-8f26-c2ef7fc5b822@gmail.com>
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

On Tue, 17 Nov 2026 11:35:20 -0600
Ryan Brue <ryanbrue.dev@gmail.com> wrote:

> Hi Angelo,
> 
> On 11/17/26 5:02 AM, AngeloGioacchino Del Regno wrote:
> > I reiterate - I couldn't pick the series because, of course, that one 
> > depends
> > on the binding being merged, otherwise the header won't be there and 
> > the build
> > fails.
> >
> > So I can't pick the DTS until the next cycle (granted that this series 
> > lands).
> >
> > Cheers,
> > Angelo   
> 
> Thanks for the reviews, and for picking the binding and keypad patches.
> 
> The AUXADC series has already landed. Jonathan applied it to iio togreg 
> on 11-02 (the binding with the header is 8f809aa84698), and it's in 
> next-20261116, so it will be in 7.5-rc1 along with your tree.
> 
> The board only uses the header once, for MT6397_AUXADC_BAT_TEMP (1). If 
> it helps, I can send a v3 of the board patch that uses the plain channel 
> number and drops the include - it builds on your v7.4-next/dts64, with 
> only the binding warnings you mentioned until the trees meet. I would 
> then switch it to the macro after 7.5-rc1.
> 
> Just let me know if that sounds reasonable :)
That's indeed a common solution to cases where a binding header
is involved. So I'd do this - then chase with a patch next cycle
to use the define.

J
> 
> Best Regards,
> Ryan Brue
> 

