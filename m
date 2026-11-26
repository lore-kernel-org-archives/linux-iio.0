Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795689701;
	b=r7LJtw+6bTisbzIEL3rP58tL5OjzyNn4Pp58F2kIijC/I1XXmDel3Z/VW335NG4AcOJm
	 SXgnlDoqYtbL48HMVvxBNIUAG4+/fBdRaSBomzvfSy072ciPwDQYWcwnHnMsJtp5PPVFh
	 oSuZ6VgDfYLBPDhvb4aG95E8nei9Hh27UPkt9beO2pPELT9cIpCKMHHXV3lZjeYDfxB7H
	 gyiyJyOgyR/6dxa4Vg18nJgg8YC3tsMgw3ZD2lWuRWDaAcwmonBhXK01/ZtMaqA4jecg6
	 CqIO14iN/KZETrq1rNuasaLPwWH2oO+GPnidFIoL6KPwjUPXztegeslWezeJTk17vIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689701;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qHZYBKCPMzqdBBV8HOs1ABXCs4q0hVVl6yoO7rIYbYM=;
	b=05o00yJiDd4gnXKFto2bSevGLEkYOqYssNLvNzKYj4wb7k0SDwWJbIFrX1GyDvlcvwHo
	 kvsGkh34QjUV1E+cATm5TNddcEVy7MajO+yz+XUFM8wPbmzGKgwco+ukKOSPARRgTaQNJ
	 ZxZP2tqqTjA/VFt9oNuHHRJnm/XG5dMhUzIdzU7ORGA3/ItTjxn0rS9kEjPJ/QAyhc+no
	 9U1WGlnNg2q0uZ3Sjrd2d+U0tlKRGw5tDTztRwsezX7M295c779woxz56gMXRuEGwsGfn
	 biSQgPGKPmy/Qh9N0j9ji7wCLgQsvbyyhI3DlDVSjWpDOu+1FntrkuV9MzLMy6fPiuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q7OVTia1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317DC606A321;
	Thu, 26 Nov 2026 10:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q7OVTia1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4349F1F000C4;
	Thu, 26 Nov 2026 10:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795689700;
	bh=qHZYBKCPMzqdBBV8HOs1ABXCs4q0hVVl6yoO7rIYbYM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Q7OVTia1QPBPF/YhXu4Bu3pl2sg768gbURLAOTFTOEUwybZUlX35LUHjeecXgUxEW
	 SA7QwwpMnB3AHvZvicpmpNfASlr+6ECzRrq6T15Q0IxsMeTg8zB5gChSvJsv0aFbPL
	 eQ85RwDDqfL/sPYVv2L+Z2cu3g83JOvgucMx1vNR2ZKbJv+/HQSzR+rCMcUoFYWcpG
	 0VJtJ4p4VYJkn1bWUVYngLZZ3pekPvNppjzf8bFTIPoaxMi59RoxxSBC1lSIaysApv
	 QmAFf6CXZDq6LNA2FUrNVwf7pcgggWHUvCQv7IRo0Rzp76bW4XLOyQshnWGuKSCMsO
	 oHX5B+OrFVGXQ==
Message-ID: <4957809f-b890-4143-8273-bc7447ff4b8c@kernel.org>
Date: Thu, 26 Nov 2026 11:41:35 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] iio: adc: ad7887: fix on-chip reference enable logic
To: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux@analog.com, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
References: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
 <20261125-iio-adi-legacy-platdata-v1-1-54e4c8830b57@analog.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261125-iio-adi-legacy-platdata-v1-1-54e4c8830b57@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25-Nov-26 11:19, Nuno Sá wrote:
> The REF bit in the control register disables the on-chip 2.5 V
> reference when set. Before commit 5483b8d5015b ("iio: adc: ad7887:
> invert/rework external ref logic"), the driver set it when an external
> reference was used. That commit replaced the use_onchip_ref platform
> data flag with the presence of the vref regulator, but kept the
> condition as is. As a result, the bit is now set when there is no
> external reference, so the on-chip reference gets disabled exactly
> when the driver relies on it, and is left enabled when an external
> reference is supplied.
> 
> Only disable the on-chip reference when a vref regulator is present.
> 
Brilliant :) A stable tag is probably needed.

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts

