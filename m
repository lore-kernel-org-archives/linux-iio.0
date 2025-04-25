Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851711E0DD8;
	Fri, 25 Apr 2025 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745611775; cv=none; b=hJMffaGAFfY9pBwHQDwEiIoZGGSwhiwiSRQLWo+h2G3If1VnjuMwpBrdCMYCBXzzc1EAp29AScgqapf4Gy7vpbgNHnHKmQZ73djbiGCG+2+9fXG4q89E4hIZLEDi/Bdi9SW1zMNXx+Q/EdcYX+PmA72PvG284ycOBjEQH3kr4os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745611775; c=relaxed/simple;
	bh=ySrLAYIQJRMIZ+m0Q849n6uQJXMiBEnqo7ZlD++mBJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=me99jrb+BOkyGlKv1zPolgt5/dctZ0aWlpwGaB/u/YzLTw2ZD1laDKxO9bnZW0JQj52MjKFkkm1zKkqoqRDv2umK0ZkVSjpH3r9xNFVx6pmSoCCKIv4DxD/V+3Bi8SgmftIJ5IBrvFOQj9IPz2IXU/QrBZHJSvHr0H1g0EEJZ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQfPO+AN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQfPO+AN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADB1C4CEE4;
	Fri, 25 Apr 2025 20:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745611775;
	bh=ySrLAYIQJRMIZ+m0Q849n6uQJXMiBEnqo7ZlD++mBJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQfPO+ANkws+wGQwdfOaROc5gdzH6uUkX/nmVSCY8D1hzGxPvTirJ10/JadyvWBmb
	 H24MbzYB1ssktxu+bMOnN/GIqaRzfQIJKWDSs5IFbJOGtAA5SmyGw6g1s6gzogumIB
	 Q+klXhDm7vonlLwu+ifRUscRnVDBMF4G55m6tmMHI+lG+HurGRDGfUcfww2lRwKdpz
	 hUDXGwOKmhN9XSXEueqSJEAvyUUaEfh5M7Ja38+ouHMUimlW8w2gYgYwB4P1Qlr7W6
	 KeR+L3cYFfA0EU0wpRswvSKJ7Y8NRvwZbUKk/UXi2ttOhhJrfFuyyGB+Qc3XPYxyWc
	 CXPajDSzaL8HA==
Date: Fri, 25 Apr 2025 15:09:33 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, jic23@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: ad7293: add vrefin support
Message-ID: <174561177303.2929516.5316963183743885226.robh@kernel.org>
References: <20250422085529.4407-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422085529.4407-1-antoniu.miclaus@analog.com>


On Tue, 22 Apr 2025 11:55:28 +0300, Antoniu Miclaus wrote:
> Add support for vrefin supply responsible for providing external
> reference to the SAR ADC within the part.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

