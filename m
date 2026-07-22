Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2742353A8B;
	Wed, 22 Jul 2026 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741768; cv=none; b=NMw8248yCQC37aBqHIiAw+hINtW4sfg11ta0njLZ0F2Apda01J0X/pQBBluBhqREzwyCemaiQwvanwFx/qfO797EfDtZnum1en2IWSvR6SeLi6RNkEs12/tJQeguveMW27VRUsGJy++bKUET3H1tK7EenO/8DsbNHieitjYbMhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741768; c=relaxed/simple;
	bh=3kMzy4W+cNN5fRQOTeJoCzSw1/JA7ND2l4Vc82/k7PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOIVVQnMhYzPedIh9WsN/1EJ9X8XQFllrIpK7aSkpIg08v/SzdXt6o6piMsymzk3u8IckqMJGNqTjOuYnfI+YsAc3qK/HxBr4abA38JGNSR0/lTHFLsAQu33YT1SLO3c8b8HedA6LNuMJhR0vYAQSLTy542eoeHz+zqMFdLEpQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doR4H6FQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doR4H6FQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EF11F000E9;
	Wed, 22 Jul 2026 17:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784741767;
	bh=Qe+2F5TgF6lW0T5HrBn2Ux7uOwUwaxddkorFmlJDiKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=doR4H6FQV9tG8CzaZqTFdQoNxNnQEppCjlt/TnLncQcgsoDgEz5H6Tf/QRo2jnZVZ
	 UkkLlcMkE0qy5yemHBKeqU7tZI/PIfPqsFqnCYnOCxrsuqIC6nX6IFc5dMjCU1KEyo
	 86A+JEi2v4rsizVRVOuJ/spR5hhK09xAnDT7dM7tJy27CRRfX5Gp5LHfsgUK+L42Yt
	 U7THor6P9MuM/+nW+UFnYow80VapCs88VLV8i7LeYBMZuxDZg/A48QRpSHuXNr5myN
	 7dwthN90b7Bq7aSuiIBV9ci0BOdZJKx10Xv17RkzvfyT6efHELgip0m+gn2fG0/9C3
	 5h/7Zkgxb9Gqw==
Date: Wed, 22 Jul 2026 12:36:04 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: Martin Kepplinger <martink@posteo.de>,
	David Lechner <dlechner@baylibre.com>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Sean Nyekjaer <sean@geanix.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: accel: mma8452: Add
 drive-open-drain
Message-ID: <178474176330.1241075.16719101832526695138.robh@kernel.org>
References: <20260715-mma8452-open-drain-v2-0-95be9f5f4795@geanix.com>
 <20260715-mma8452-open-drain-v2-1-95be9f5f4795@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715-mma8452-open-drain-v2-1-95be9f5f4795@geanix.com>


On Wed, 15 Jul 2026 14:33:27 +0200, Esben Haabendal wrote:
> Add new boolean to configure selected interrupt pin to open drain instead
> of the default push-pull mode.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

