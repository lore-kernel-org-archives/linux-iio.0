Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F3735A388;
	Thu, 12 Mar 2026 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327233; cv=none; b=TiYAvqcyMXwue+frw6WqeFhqPkocVjxbzAVLyV6/tbB0Ficdjo4iBFFQJA0N4xmuivUjhmM6YZN1W+pprlZmBrP/rAz4cscmCwfH4CvF2o9MU3EkNOMjnBUnzvIq6BCYyD9JM+H9QcBnXyKy2dhE52Lbqd2KGIxHwpz0gNHWBmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327233; c=relaxed/simple;
	bh=a+0NgNiBPdGWvGkpJGCBnK3f7HMy2z3wKRoqNykBc1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FH2MRmVEUMgsIEQDT/aWfAtBZKJFjJVFVdDsjZqu6HfaDjliT1gr+YiC80oV82mx2CiiQ98xesVXd0CJ5/9OJREShzARcFXG4He6m7UzDQPDC4RzSDIlRPwaSeV3F1jMES27dX/u3Nhy00kNMOITGLcDhpjfqgd5sX1HoZIAT3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmUBQkdo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmUBQkdo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1215C4CEF7;
	Thu, 12 Mar 2026 14:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327233;
	bh=a+0NgNiBPdGWvGkpJGCBnK3f7HMy2z3wKRoqNykBc1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GmUBQkdonTn079OrtqO9yRywcBaKuFinwxbV6CjvPk1KoNVv9zvl6tbMGQ4Yg6UcI
	 ZdCy/j+SWHmucBYxsUKegzpkMCKGT6Q5GsXB1wIgboBCzsSlac9RHJaJDlnxIbVBjM
	 IC6ZO77g6aGQ6r95DpA1Ox+x8dCnegWcc39kZS/vO6V/oLtx2BxhKwKso5cgjwgjWe
	 /zWKe7Oun85f0frQcYpmJfWb13ogqnoeEod38o27u+fbnOALwPQ9NDIB8tQJ72TH7x
	 gLSBKBBm+v2QuX5wsydTWJSJgBBPamNerT/xkg3h0tLAVtOlPHChsbvddepNFQ1O2U
	 Etk5KENRYuyhw==
Date: Thu, 12 Mar 2026 09:53:52 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v5 3/4] dt-bindings: iio: adc: ad4080: add AD4880 support
Message-ID: <177332723145.3116508.9028407876726520215.robh@kernel.org>
References: <20260305113756.47243-1-antoniu.miclaus@analog.com>
 <20260305113756.47243-4-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305113756.47243-4-antoniu.miclaus@analog.com>


On Thu, 05 Mar 2026 13:37:29 +0200, Antoniu Miclaus wrote:
> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC
> with integrated fully differential amplifiers (FDA).
> 
> The AD4880 has two independent ADC channels, each with its own SPI
> configuration interface. This requires:
> - Two entries in reg property for primary and secondary channel
>   chip selects
> - Two io-backends entries for the two data channels
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> Changes in v5:
>   - No changes
> 
>  .../bindings/iio/adc/adi,ad4080.yaml          | 53 ++++++++++++++++++-
>  1 file changed, 51 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

