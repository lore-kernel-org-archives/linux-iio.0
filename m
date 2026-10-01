Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38483BFAE7
	for <linux-iio@vger.kernel.org>; Thu,  1 Oct 2026 07:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790839110; cv=none; b=pc50CSk37C0hKc1OMIQe2AhHNNEg4l20SrYC1ZzFpl/DIMfNU1B7yJBDhloqikGvFnjrPMB/Acl/Rb1QCMygPgYZhh63JKQyyk3IOFiy/sEqkq2qkAZCQNNll+hvt3w+coKE30GJbqThx8nIg6JhDvkkx94AA+GDsEcprRT8iKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790839110; c=relaxed/simple;
	bh=AVqk6eIbFK8uDoowGzu8wB740SP5bVkVCUg8XnZAsHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIYSSOLUHQTu+DJk7g+5yHyN3phQz4bwQlLuN3gUMYRKgOKs8nRvBDdYRDzoXju8BLVXQqIpNWDvNHYSawsQwgVqhSH9l44I2pBZPxwbvxVHwwO6MYyrcVIYRYCac59QMJiWzp34qWch2zzPQglVnEd8tMEFOxAdBni2VB72j2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmJR3dDg; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmJR3dDg"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a00d8bec5aso17021065e9.2
        for <linux-iio@vger.kernel.org>; Thu, 01 Oct 2026 00:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790839107; x=1791443907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y+YWX6gQgZo8y4R4a+T3medFXiXOGcAYD9z8MlqiloU=;
        b=mmJR3dDgiVXM+hdlk7vychW5uyiGr8cv70PVc7kNi8Lfx0ZHmU5g4NIPNW0SliuWAc
         y0Rf/6JNs2gprTZE3or6R0IBnXwDhYs2hsxOA6RZJu5U6R1/U4Bj15/uYWGsn0ILCSrE
         IrZA1t1H0i9yNyRNrExFTCFk5BVMqWS9mXmqdEomfQ+2tkVITkd4zlADEGIbiSl0/bg8
         BZlzSLX7UG6IDwlNjQP+AD05ErVg3Fgb9tBN3XBcRPZuMZ+JB1sUy57IhoClwTEdCzBF
         kd5AuxUpBJmOEsCjcs7mxy9hcNVEBwldm+QdzKDtEwzrMIP9YkI7O4V0HgBu5VJPOMLB
         /FDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790839107; x=1791443907;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y+YWX6gQgZo8y4R4a+T3medFXiXOGcAYD9z8MlqiloU=;
        b=RXCEwXTQSSltNc2kEb4ApJpQw5opzpD3d/JYqe4vNFu7CvEINN/gwNVRvjiQwXzlDn
         6unJLEsBauAoyF7RNk7gc1SeJCXl+sKOw5ShgFDYhlbqe8LoWJ2NwpVhEUndzJpDZXx+
         c+Pc+3FMEnHN0SW4lQH8snlIHV4U1csGIk333HXIZ4X2/Te1+30/D4ZAhR4KD1lg6uaN
         jeCF5wIppfXw7lwg72EyAo6+0IOYAEbD+0Ur7RIhfIFA4RVR+raq1KkZwGkl+u49EauA
         Zs/Yu4blWn04hA6tViFNzcABg88k4vKgEDYzAFRCWV3cqD0x8XUHAhToejhSDCLn7eSG
         Mc6A==
X-Forwarded-Encrypted: i=1; AKwUvByE7eiI6KGCu/8NeJMvQ1qNRNJ+LCFXR7FXz27ltI761UVLHKFgfxlmrPV1mmgxxX3CKHnBEug7uE0=@vger.kernel.org
X-Gm-Message-State: AFuF++m/hA/Q2poTJsGs0x+IkyqW1dyBk0fLgsL5llN3O2Cxr8/2EnZH
	5iQfBSDtNEE6TDFuC7ISGX1BfUZaekOQiPiGI79wxbvYOmJGV+TJ21R/3lK37SbE
X-Gm-Gg: AYBFou08P/MSOOCgnfShpUhy+OEP+97wRzynBRDm+Jrlz+ePBbKT5tC5B8jZx5Gv75O
	m2QrumpIYNo4/z/CIeIZ40N1tWDygPbFalFAYLSmi9kNW8lUmo4nBx+ZIcDr2cfZDAZC5x1UMzs
	H+h3o1+e6K0JiyTkNcK5J0PUw2mYYHCddfmk88XqGScJwvmuFJ08MWGFLiKNRi/4LhozvbfzEdP
	+3CdWD/tNjVBzNyhYh3R23o/ey3RxU8+9Gdz757e/MxGSCYeLEXAHTn//SXcy/aPn99V/zYgolY
	4TXsXZoU7Ni/hadCI0Ua4gmvUOnknehGg4JMVNJwkFGPk9KEAe18KlOPLF4zCQY97reqQPDflXF
	KUUNwCiRaC6SYHb771Wr4nPjG7VfGRwn7xZ6hLBtGLelDurbn5MrGfp8nCv8pOovNwnW6jqGO3+
	FQGhOiSFrtykyAXmMnxL9SAD1202DM4MvSYOqPc5Hq1uWtN1QJmG8bnsaQfJZ4ajlP71X+xpkPW
	RRTuHswdTPennLLnX7CxCGzIz8s8JQ7Z7YGA/MUKfLIb6fMDl9r2havXTpgpmEZwGcS1L13sMJ2
	CqUYkmZJZPMI2bIDHr4RLA9qbY/nej0pZlac7bn/Lhu/derahWkYeBb+IjktGUBa+TUcZQR9txq
	hxrJ5tu28LMidJtoJj6Wg8KW2QVhq2qf1yYWnucLXneYNTdCYA5/EcfU/sfo3Ay2g3Wlhrn8huf
	BNCf5f
X-Received: by 2002:a05:600c:c162:b0:49e:7a00:b9a5 with SMTP id 5b1f17b1804b1-4a01ad907efmr63944185e9.4.1790839106608;
        Thu, 01 Oct 2026 00:18:26 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a023ecef86sm8562995e9.3.2026.10.01.00.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 00:18:26 -0700 (PDT)
Date: Thu, 1 Oct 2026 09:18:27 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Joel Stanley" <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, "Ryan Chen" <ryan_chen@aspeedtech.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] iio: adc: aspeed: Fix SCU lookup for multi-SCU
 AST2700
Message-ID: <20261001091827.00001410@gmail.com>
In-Reply-To: <20261001-ast27xx-adc-upstream-v1-0-5ace57533418@aspeedtech.com>
References: <20261001-ast27xx-adc-upstream-v1-0-5ace57533418@aspeedtech.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Oct 2026 11:28:43 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> The ADC's reference-voltage trimming data lives in a SCU register. The
> driver has always located that SCU with a global, name-based
> device-tree search, which works as long as a platform only has a
> single node named "syscon". AST2700 splits its SCU into two
> instances, syscon0 and syscon1, that share that same node name and
> differ only by label and unit address, so the lookup always resolves
> to syscon0 even when the ADC's trimming data lives in syscon1.
> 
> This series adds an explicit "syscon" phandle property so multi-SCU
> platforms can point the ADC at the right SCU, keeps the existing
> global lookup as a fallback for single-SCU platforms and already
> deployed device trees, and wires the new property up on AST2700.
> 
> Patch summary:
> 1. dt-bindings: iio: adc: Add syscon property for multi-SCU SoCs
> 2. iio: adc: aspeed: Use syscon phandle for trimming data when available
> 3. arm64: dts: aspeed: Add syscon phandle to AST2700 ADC nodes
> 
> Assisted-by: Claude:claude-sonnet-5

All Assisted-by tags in your series should be changed to "Assisted-by: LLM"

> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
> Billy Tsai (3):
>       dt-bindings: iio: adc: Add syscon property for multi-SCU SoCs
>       iio: adc: aspeed: Use syscon phandle for trimming data when available
>       arm64: dts: aspeed: Add syscon phandle to AST2700 ADC nodes
> 
>  .../bindings/iio/adc/aspeed,ast2600-adc.yaml       | 28 ++++++++++++++++++++++
>  arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi     |  2 ++
>  drivers/iio/adc/aspeed_adc.c                       | 20 +++++++++++-----
>  3 files changed, 44 insertions(+), 6 deletions(-)
> ---
> base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
> change-id: 20261001-ast27xx-adc-upstream-34b3d9e8e27b
> 
> Best regards,



-- 
Kind regards,
Joshua Crofts
