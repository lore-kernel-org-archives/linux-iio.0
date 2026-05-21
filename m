Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB09381B17;
	Thu, 21 May 2026 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358745; cv=none; b=U94L3JSjjmCmdsSdhEQQt8SCjw5xeh754xK06CkxahQrqoBpG5AbtTgMzZij63WnMB3r29KaxOS9UBPh42J+S67jolAPckkrpr6ygaC1up5wMa7aYgGhRgTA5h2LpQUcY6Eh8Kqacpvq6XlIacgYY3qvirJE34vqTMyPrXp2yJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358745; c=relaxed/simple;
	bh=NmfypcCVQY8TvonF7tEogI3zi+QqH919yZENe5lXGbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPEC+gTwwohoVouDWb6q0JDm1AjMpEzFCgQs/6O0sLmpuhO8oOwfAuP62ocC+Mm2bBq2JezLzEAOWdwsc2q/VuphOPqMzQ9QE9riU+iuzgBiZxTjRBGEuIatDn7VWgZ+n4tOsmPzZzDNIm3WXOsC/YnLd3IifaznYdwmCmc9638=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXmBYNJ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXmBYNJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153361F00A3C;
	Thu, 21 May 2026 10:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779358744;
	bh=GiXqB4OhpyrdezPBrS/nLermhq5mZzz1erTlv4A7LJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DXmBYNJ6dbNorJpCOOEwwiPok+WtsF/clKyes3WCzJAh+XakJ8z2FJqbBC4MOZQko
	 IH7MCNs4TVLvYWErvAm4SakMVJicdd0T7HIQPPTqjdopOZ3+nshDRbGwS/LxuRwQA7
	 3rUwNUlcTDOKld8GTBNkWBbhYQZPnvrz6HuYNGspgjzx3pUU5XJYoXKyEw8OGKrLQt
	 /TrzW0SnG92Z1YZJuMHUpHh5v0yDYXeJG8c6ApTq3ksvW6r1KfiGZvpjq6Kko5iADn
	 yf4R8uGcwYKaq7BIWIAtc/waaYu+JNjh39qUA3p1w3QKchvbRVYPBwvsul4UibUsxr
	 ijJCTcMz4mAIA==
Date: Thu, 21 May 2026 12:19:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Rishi Gupta <gupt21@gmail.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: veml6030: add veml3328
Message-ID: <20260521-tested-nickel-agouti-bd432f@quoll>
References: <20260520-veml3328-v2-0-a57f0d9e28d4@gmail.com>
 <20260520-veml3328-v2-1-a57f0d9e28d4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260520-veml3328-v2-1-a57f0d9e28d4@gmail.com>

On Wed, May 20, 2026 at 11:15:37PM +0200, Joshua Crofts wrote:
> The Vishay VEML3328 is an RGBCIR light sensor that shares similar
> devicetree properties as other existing VEMLxxxx sensors in the
> kernel.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

