Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795317295;
	b=zHQV7RGzMOms2jWhe+lMtdhizLlQPnIQb5BFa7YufWt1FvnC11fF4am+PRGAkpCxjrxE
	 cPiuSuMzRRd9cR7ZSLQkas9VHr12dn6kDAMu1frdLGENst3xT09vnNa3g6Pdu8x1sCI4D
	 1bDxUNNsMIxjgbwQ9kUnjT7aQ8CO7IuXvzwzGB/EVuehDPV9RpXZZxkOnnZcrzeG+B1TA
	 /DBniFyetu8OmeTEITrYNykBvUSo/J+ygPcaRT74NATYSlJrX69kQMwtq7SEyHy0STbzR
	 1dz/cMt+r65FjNxYnqikEZ7lnezpIykPxrN9U5elJybqtl1s332RrCM0rOIlhbP9/pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795317295;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9W0NNmAIC85pBbgvVkKJlHSnGqyeu1JrSOvZCsAnKGg=;
	b=CgkRcga09BPlLfvihz/+d8pUO4UaBuHc6wUSqNPrm3gjJ+AI54Y9qrdGtreZJdmv5z5h
	 nd1leC80J6xTt2vSvQAOmgJ+prx7l4/oj4Cii539x9GgjhyFsDdzpGKLF8bWSb+TwsuLd
	 FdL53ovHJkEyPnb1rDFMCHiJ/UvdXKTd7HN1QjN+hzc5JNgI7KOW5yLYB95pvmMDIJo65
	 skGuc3kd4WEGV2TPNpcDwqc3taT2qNbl1GTCUE7jklH1w8ggd0NsXt4FYwj60zReC4pEv
	 KrBqLTzrRIXEHMM2JRjq97egj9D9wHXBauhbnhe5M0KRBTdD+3bOqk5vzocb+W250KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dN8+zKwu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E2C606A320;
	Sun, 22 Nov 2026 03:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dN8+zKwu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE74E1F000C4;
	Sun, 22 Nov 2026 03:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795317295;
	bh=9W0NNmAIC85pBbgvVkKJlHSnGqyeu1JrSOvZCsAnKGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dN8+zKwu7/BYTP4nrX6ScAMHOdJlFMgr9nWJKYd9ydhQ6Lqg4UZoniBM6qGvVbcuD
	 /9cnRjfMMs69PRUYpkAbodi3fUVnLWJkvJaykLVLTfd2XFaLdHjZD7DK0E7+u2Iwkh
	 tQ92R4LX7/mzfWhGLjrRPZwpjfcGVZD+PmsMiPEbgIgS9g6S8GeMTfKnpSjv9GJlEm
	 LYJsXrr0dXvbhDKxwHfCTNpigQSt9KD7GRcPREvOyxH0q+AtHoHmRCRx9Ft14HE0ed
	 RNZOBZfATnz35IPsZ9xlH2Rp8CiichG/Bqdk4NBvLvqCwOePnf3VjxR2Gxd4wzIkqL
	 4QkOPJIoXYt+w==
Date: Sun, 22 Nov 2026 03:14:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Beguin <liambeguin@gmail.com>, linux@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof
 Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2] dt-bindings: iio: adc: lltc,ltc2497: Make
 vref-supply optional for LTC2305/LTC2309
Message-ID: <20261122031448.153e0f16@jic23-hlaptop>
In-Reply-To: <20261117-ltc2497-vref-optional-v2-1-62e9d1ac7400@gmail.com>
References: <20261117-ltc2497-vref-optional-v2-1-62e9d1ac7400@gmail.com>
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

On Tue, 17 Nov 2026 14:04:38 +0800
Kyle Hsieh <kylehsieh1995@gmail.com> wrote:

> The LTC2305 and LTC2309 have an internal 4.096V reference, so their REF
> pin does not need to be driven by an external supply. The LTC2493,
> LTC2497 and LTC2499 have no internal reference and require one.
> 
> Only require vref-supply for the LTC2493, LTC2497 and LTC2499, so boards
> using the internal reference can be described without a dummy regulator.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
Applied to the testing branch of iio.git.

Thanks,

Jonathan
