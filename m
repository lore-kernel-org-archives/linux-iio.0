Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2C1352FB3;
	Sat,  7 Feb 2026 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770477039; cv=none; b=qP/NxiJaaIwuG5am7cQZKn8yP+VlGH1WigR0u9c4SFzUmTU7aAa8mfn9WblOWbcVCuDLMbGzFHYLCtwumcRSUt2nxdoPpGP6U50PflIKE5yUFN7Xc1A99RARSIuKxl6g1XG1uMA50SauKXcdT8Jdh5p1PeoG+xVRXy7g7akSwAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770477039; c=relaxed/simple;
	bh=Lbwz7v8aqFEz7lEDbTz154u4OmPzXanUkEqdifXAjoU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/T8UdNq7WdEQnFnYMVFv8z2TbBgQ2eoirIvgUbmzt7xK4bIiXStegcCxoL9hIzF6oNcbfdfd3V5RcSd12DAJxsUHBwHr8gunFiwHDIKKaDDNM31lXkDERuntTPuD0yjuoNSf3OvwbLkqCQk9vRBcXvRsTxzwW08WWt5Ap6gOhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0Gvs5cR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0Gvs5cR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34961C19423;
	Sat,  7 Feb 2026 15:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770477039;
	bh=Lbwz7v8aqFEz7lEDbTz154u4OmPzXanUkEqdifXAjoU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S0Gvs5cR2cdhhFc91ZwQ8hVEQZle/NxvNfRprFsBA11bnFc6cQnrK6ck5PYhwuybP
	 Gu1e/D21i0GG5gtE2Tj4BUWHf/9nuqgGhNWK0rn0nC49sjKBRiUOvVcyfip3zjFfkZ
	 2RyenyPCFwkh4fhIMAfEQdQwZDaWCcKWMlgMZYwuaHaUmE06x7sQm87RBZuXWKYSak
	 k0PD39jN4Ylx/C6/WZB6MY6PVz0eRYaaToBRCEuoB7+jq7npyGGNAUFLqDbltq3T8I
	 tuQWoUmcLKEoM1vhXi9vJvnTUUAcvWkHsPx4V9JyiIJtF2rOd4Bl4npai29vQ36G9P
	 F/YaJCYGao9HQ==
Date: Sat, 7 Feb 2026 15:10:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: iio: adc: adi,ad4080: add support for
 AD4085
Message-ID: <20260207151028.1c4e110b@jic23-huawei>
In-Reply-To: <20260207-hypnotic-passionate-crocodile-e5be30@quoll>
References: <cover.1770382796.git.antoniu.miclaus@analog.com>
	<e1ef83150eea89864d4bad8d9b43e60503fc5f14.1770382796.git.antoniu.miclaus@analog.com>
	<20260207-hypnotic-passionate-crocodile-e5be30@quoll>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Feb 2026 11:52:57 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Fri, Feb 06, 2026 at 03:08:22PM +0200, Antoniu Miclaus wrote:
> > Add device tree binding support for the AD4085 16-bit SAR ADC.
> > Add adi,ad4085 to the compatible enum.
> > 
> > A fallback compatible string to adi,ad4080 is not appropriate as the
> > AD4085 has a different LVDS CNV clock count maximum (8 vs 7), requiring
> > different driver configuration.
> > 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 1 +  
> 
> Squash the patches. You just added one line, but commit msg is 5 lines.
> Exactly copied from previous commit.

Squashing the driver changes as well into a single patch with all 3
new devices added seems sensible alongside squashing the DT.

The changes are all very similar across the 3 patches.

Jonathan

> 
> Best regards,
> Krzysztof
> 
> 

