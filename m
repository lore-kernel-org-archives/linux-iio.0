Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD4B39184A;
	Mon, 28 Sep 2026 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620872; cv=none; b=QiyGJDHixB3X/CaL44tczT+b0/3ZJ+BR9ft0+JIizPIj92d2TGc/wcrj6A2dOifmGrNmyddzLM2w9TpXtHxfi/EBzpFppX93LlvMmZTzWseFwbTxrVTNwCh47gsNbK5ZJa+TKCP6FT9ISkAkXeo5iDfn5N+LTwrjMc6Uz+mVPxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620872; c=relaxed/simple;
	bh=khi2ITJeN2KoWx5lecul1hskKkXusaFeFWDoDUKqGVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzD80C2AOXcSZV0VM8gbjDqjrsoG+RviaUZJ2J9085bcgpWZQXziFI/vZ2gH/weSeE2mTiefT/9UFMDU4Z4E2gG+OD3nrgRpiRprCAwRDKBAXKio8M/gljvB5ohd/jWoSYrgYw5n63gu/jz0+Fv92O4KdwrYvzug6649c1VzuQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRS7y6U9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRS7y6U9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D151F000FF;
	Mon, 28 Sep 2026 18:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620871;
	bh=SAh1NwP43VKbxUqk0z6TTc+aDWRF/R+GD4qM+zj8kZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GRS7y6U9xGlUvl/h0asTO1C4WeVyQGCX3rBvCOxXiMSRLjc1FbTC843Ad3jnvXA1A
	 dmL7qvYoJaQtoVFVS1QeJK/AElcmKMbGK+hVj7e2A53tIjFQoNXCJgu9KIZu5s4duA
	 65sr1ac/k1WQZEALU8dElPPrOBxflxQVV9uiiTu+3RVZztNB3xlBGvySFerK1opJz1
	 ENUSr+TpzAyLEyu7wijo6tu8U08J6nuj6wR/B1Zlf1qnIYN5EqOo9ISxxcizaPYQ4D
	 fjgWYQdoK4L338RbcUwBpbFlkKQHpUtNoYziUJ1if0aQuTUSdEfQldjz58pIQxwe8k
	 PrqTwWF0e2C9w==
Date: Mon, 28 Sep 2026 13:41:07 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>,
	David Lechner <dlechner@baylibre.com>, linux-doc@vger.kernel.org,
	Salih Erim <salih.erim@amd.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-kernel@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>, linux@analog.com,
	devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v2 3/6] dt-bindings: iio: adc: adi,ade9000: add
 adi,ade9430 compatible
Message-ID: <179062086738.249779.5213209601368987485.robh@kernel.org>
References: <20260918073537.1572-1-antoniu.miclaus@analog.com>
 <20260918073537.1572-4-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918073537.1572-4-antoniu.miclaus@analog.com>


On Fri, 18 Sep 2026 10:35:32 +0300, Antoniu Miclaus wrote:
> The ADE9430 is a polyphase energy metering device from the same family as
> the ADE9000. It is register-compatible with the ADE9000 but does not
> provide the on-chip dip/swell detection, and it has no on-chip digital
> integrator (it relies on an external analog integrator for Rogowski coil
> current sensors).
> 
> Add the new compatible. No spi-max-frequency constraint is needed as the
> ADE9430 supports the same 20 MHz maximum SPI clock as the ADE9000.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> Changes in v2:
> - no changes.
> 
>  .../bindings/iio/adc/adi,ade9000.yaml         | 22 +++++++++++--------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

