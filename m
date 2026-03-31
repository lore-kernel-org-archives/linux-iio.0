Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B7F4279FC;
	Tue, 31 Mar 2026 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971900; cv=none; b=Vffe6a1/q87XQ/JPNYf31fQztW/eKmMOGEG3n6liqxp796dR4dlQoDI+5W17rbxmp4SqU0dc3Mo1q2WyrLntjiZ1SzoX01HODYfhX+dKxfSTsLvzD6VuwlB/h26GplVX8ivfBKETQAtrkVwBF/qu8jLec4dlUXyoHnF3IRiASTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971900; c=relaxed/simple;
	bh=FiNEmNEzrZ7ozJFVzk2VmR/MdqowJduct7y7aj/MKYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVJFJlqqm9D91p03JQhRejgJzl3zrsg7VQzw/6WWoFDwqUgX2FQz5iEvZJSopcRuSw9EopyXRA15audp3lFSuAgNuxa/Az+8MlhqEtyv0wyx96muTzXYIgmapUVrMkDeQ/E9GDAKAIliBWAqjdMBMyAJ2xj+VJWdWGDpViHC0lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e057ASwd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e057ASwd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C60FC19424;
	Tue, 31 Mar 2026 15:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774971900;
	bh=FiNEmNEzrZ7ozJFVzk2VmR/MdqowJduct7y7aj/MKYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e057ASwdDSEhHSJCqc11Gd2O99y9SBSVFSA+QA+wVrXo8X+NXmI+i8En+wfoLBmcq
	 Cbv7RWGAySvGrvqLId9I+UuNMskmyaQslBvx6LalHRQ3EmIVh5IgZHWoi+yzgg+/QL
	 usAhdtfQoV5NZEjktS+h7k0cTf1bbvqw3l0lk4ZSb2YOXxH4sQYBshPLtEfH69D43T
	 iaoou8aFbONaKBNy2iynrx7TYLqUmGDOaQjEu3N3ot8cpbz91Yu9ygeGErQOb70REs
	 X1Jbp4GIyQFHX9C4NLkv6L/YcDA6aWyVG/CDOGhBe5vGB1DV/SvMORFdF5ElMB00OT
	 U0Zysbqf9/9gA==
Date: Tue, 31 Mar 2026 10:44:57 -0500
From: Rob Herring <robh@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/3] dt-bindings: iio: adc: ad4080: add AD4880 support
Message-ID: <20260331154457.GA1295274-robh@kernel.org>
References: <20260328114050.46848-1-antoniu.miclaus@analog.com>
 <20260328114050.46848-3-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260328114050.46848-3-antoniu.miclaus@analog.com>

On Sat, Mar 28, 2026 at 01:40:49PM +0200, Antoniu Miclaus wrote:
> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC
> with integrated fully differential amplifiers (FDA).
> 
> The AD4880 has two independent ADC channels, each with its own SPI
> configuration interface. This requires:
> - Two entries in reg property for primary and secondary channel
>   chip selects
> - Two io-backends entries for the two data channels
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> Changes in v8:
>   - No changes

Missing Conor's ack.
