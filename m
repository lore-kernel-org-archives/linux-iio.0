Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC49C42A165;
	Mon,  7 Sep 2026 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767952; cv=none; b=kbVe7TJZWy25tZ4/7AJEiTuOZTv0GQ6QbuunrGkbcLMEybpQPit6AT2ybFrLKEdLYelz2qj6552Ut87I9WiEFdb7FZSmcryZS26mf0QR38xQS1SLbhAMLMwo6QXfYHkowuoyMAIxOxSB1d/0uqToeyiFUKD5G9G7wAZxmnIjh8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767952; c=relaxed/simple;
	bh=GLS6PKzzcflMVySOPIMoYRwtAQD5Ist9obp72BjN+BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvbq0rDUWYqxI1scGMqcw4IgTKHv3Xn1AO3rGcWmt3P7qm6yX8mabwSMO41rire/77u15j+HfHvy4vuy7wt6kUALpNmbxqZwJ13StDjJ/RMfCxocQt+xyXzAW9IYq87cGWkdQahhSm5oibClX2m4CvHZq/mP9hFjywa84tPfkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXybQg6I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXybQg6I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3411F1F00A3A;
	Mon,  7 Sep 2026 07:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788767950;
	bh=T7DxIBisqzWc38K3SpNkKOaaqQSRKHlATBlb+R77ZIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iXybQg6IMzK4JX+13CZy6wsVGJ6EZW6VN32wjaYW53N/1P7ulYPKghQYyn/dyDhoe
	 8Y1bWa2yOeYVUHReP27SRHfX/OIRNvCkUWRcNtU/ft3R56Y3117E+c3ju2BcA9gW59
	 KY+VswYkyGHZoXM28i9TTpTR5C16ufYsnP7/X2iR9AnThdldDoE6hG7+Og4kCT7gPX
	 vTNTbzSqkb/d35+3AiUYmI/rgtgV5O30a6o1s9os18RZDaBFkj5wwaY3mrIPuyRLfV
	 iEOUBr8yVCA75lI10+iTRlrVLF234O1pX74jXf1m7JgRDETDoIPq/i9CfaBgZEsqqD
	 gzQqmfshLQUWw==
Date: Mon, 7 Sep 2026 09:59:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Flaviu Nistor <flaviu.nistor@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: ti,ads1015: Add label
 property
Message-ID: <20260907-brawny-amorphous-marmot-342fed@quoll>
References: <20260902172230.5234-1-flaviu.nistor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902172230.5234-1-flaviu.nistor@gmail.com>

On Wed, Sep 02, 2026 at 08:22:29PM +0300, Flaviu Nistor wrote:
> Add support for an optional label property per channel similar to other adc
> chips. This allows assigning distinct names for each channel which can
> match the schematic signal name.
> 
> Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

