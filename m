Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3E43DCDA3;
	Tue, 21 Apr 2026 19:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776798915; cv=none; b=EGTZNODfKfPsxDhAfIVAaANRi04yRahKs9xoLd7hn09M7JGlyiEraevHDeNiMnA6M0bn0HM6mDnon/JsNW3wGkYIaGnEjwubZ0lp0yX/+49LU2YmBWyq3OPH3h91TqBBz0x9DtD/VyIhglsM0mPDVDfUvs0QtkN9hqVbZXG8SG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776798915; c=relaxed/simple;
	bh=fIhETlJj9u5OB60N9Hq378KMRgvVMWTcv3LagXEEXk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdWWILbzmnfVn2xaNS5Txgc+5xYyVgRQVDOmUFjwDIgk5A8DTth659dQYkqNYyAE8Crxp9YT+D4j5mshYO1qBk9fib3OuFdXVlXYIJjysQE8ZnpfAoyDP2e5GXRzh+jAfrO2bbA+puObKrrH4uatKOMXi98Izb7LzccwpbCwjHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoToz50z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoToz50z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16883C2BCB0;
	Tue, 21 Apr 2026 19:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776798915;
	bh=fIhETlJj9u5OB60N9Hq378KMRgvVMWTcv3LagXEEXk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UoToz50zrS8gx0z1uRKzF0pvwB0VhwZE3Vx6JmSbr4FbI+nE04XkOnIOM/uWFprWS
	 hxcGowbISWTvGKs5+rBdXX5nbyN1wWl87lVaPTvdVXf0i5+nwJWa389iUXZL4mkK/b
	 hXXSXKu6HRNGk4H4BoJVp9gzIqQky99jX9vp34Lqca7DZQf5490QhK43esVJlrcxZ0
	 9ehZ0YTjkPjhK0mm89iAfBNKq6hx/ImC3sVh2f9dxUCIiSf0uufr1iIxnWVwu3upl+
	 yoognUtrok5HnvWrullrVNr6otQ/iEUWRZKWaefbbpnT+e6VOHKwsf0AKndfldvpIb
	 tv2BqyhI9e0Ag==
Date: Tue, 21 Apr 2026 14:15:12 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vishwas Rajashekar <vishwas.dev@vrajashkr.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>, luca@lucaweiss.eu,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: iio: gyroscope: add mount-matrix for
 bmg160
Message-ID: <177679891223.1501964.17524095253166764039.robh@kernel.org>
References: <20260418-bmg160-mount-matrix-dt-binding-v3-1-ce8020ecbf9a@vrajashkr.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260418-bmg160-mount-matrix-dt-binding-v3-1-ce8020ecbf9a@vrajashkr.com>


On Sat, 18 Apr 2026 00:11:09 +0530, Vishwas Rajashekar wrote:
> The mount-matrix property supplies a 3x3 matrix that is used
> to transform the values from the gyroscope to get vector
> values that are relative to the way the sensor has been mounted
> on the device. When the property is not specified, the identity
> matrix is used.
> 
> This change adds mount-matrix as an optional property to the
> dt-bindings for the bmg160 gyroscope.
> 
> Signed-off-by: Vishwas Rajashekar <vishwas.dev@vrajashkr.com>
> ---
> The bmg160 driver reads an optional mount-matrix using
> "iio_read_mount_matrix" in "bmg160_core_probe" and stores
> this orientation data in "struct bmg160_data". As the "mount-matrix"
> property is used by the driver, this change proposes to add it to
> the corresponding dt-bindings.
> ---
> Changes in v3:
> - Addressed review feedback: updated the commit message to indicate
>   relevance to hardware and remove references to the Linux driver.
> - Link to v2: https://patch.msgid.link/20260416-bmg160-mount-matrix-dt-binding-v2-1-e66cf5cff8e8@vrajashkr.com
> 
> Changes in v2:
> - Addressed review feedback: add mount-matrix example for bmg160
> - Link to v1: https://patch.msgid.link/20260415-bmg160-mount-matrix-dt-binding-v1-1-0e2c85964ee6@vrajashkr.com
> 
> To: Jonathan Cameron <jic23@kernel.org>
> To: David Lechner <dlechner@baylibre.com>
> To: Nuno Sá <nuno.sa@analog.com>
> To: Andy Shevchenko <andy@kernel.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: "H. Nikolaus Schaller" <hns@goldelico.com>
> Cc: linux-iio@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

