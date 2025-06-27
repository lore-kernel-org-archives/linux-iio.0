Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D0122CBF9;
	Fri, 27 Jun 2025 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751060012; cv=none; b=Mdd3ToCzSmY1YCjmnb69AozG0cnca2WwKq0vFnlqc2IcK6dkS3Y8GARtiG0jUq/RV7qDrs1WozXhyM0FBDc9IWVqJEes5WWTpyyTS7TMmK6UgNPwoT7p0up0ZKUSSu/f6m4B0bJGuP8/9zqYtTTmhFugOD03WrciZkWx3EqXlJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751060012; c=relaxed/simple;
	bh=vyY1Kd5OUBJc97l8JCKcVQzjxkPjwMl4qd1YNIXtXrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kggk2pWtp/0645TGj2fi81o/XzwWLvLT1Wj0Xpft47TbEG/ZULIhBEvDAdnPuimfYvRmgQvXfDH9tyL/lsxtzd5ID/O3KuD9vosVf2dYebZBEqVNacUXkJDwYPd5KhofrrHzL3i42zayyGMcAPzDhFsCJdj4TDRWHWg4+7lsC2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GY31+U2U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GY31+U2U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731D7C4CEE3;
	Fri, 27 Jun 2025 21:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751060010;
	bh=vyY1Kd5OUBJc97l8JCKcVQzjxkPjwMl4qd1YNIXtXrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GY31+U2Up6DSuFAyMyCXciFelgNHeiFOfu3fFcykOxMm+/tQKtm/zoJAzmhPriZM4
	 +ywCeNtAByQQcrLbmknsU+oQ4LWwCr9nDpCD+EURTY864Dv91cJaez8aNhOfHh0cXt
	 ouMMzuOxHMqPXBDL649v/o+JBVFuAWzC0JGGsKEcb1nJRYjH2YkVa9ag975wnKGqtw
	 2L82Rqoxcgz1dG9tjl311wO7ShvZqSQIqW5Fghj/I4vEAaM0oDdA8nFpmW40QFO4Nd
	 QrtWtPtPyEDp6H+76Bn97IPeprzYTDGbxsp53XgI2R+KGeqU/lUDwuQQFnD0+Vcq7L
	 mjNJWhaEfAc1g==
Date: Fri, 27 Jun 2025 16:33:29 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ad4851: add spi-3wire
Message-ID: <175106000949.179484.16704763216983853791.robh@kernel.org>
References: <20250626104024.8645-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626104024.8645-1-antoniu.miclaus@analog.com>


On Thu, 26 Jun 2025 13:40:23 +0300, Antoniu Miclaus wrote:
> Add devicetree support for spi 3-wire configuration.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

