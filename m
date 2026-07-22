Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E26C282F16;
	Wed, 22 Jul 2026 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726047; cv=none; b=S5Yp8E0DOmhq0T6FMbwj+5iyMNpcDmVPdhwYRk6kIFbEPgNZZ3Q/Cb1Bz7DgUtZWS5j1MW7/6OpestVv6OmNBQh8EZl9SgymqYt+6AsKlS8LENgw12UliWWgrQ76zlahsf37RdvOChUDtqnCaFi8E6SMJoG7dAgfxsVmC6A+3+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726047; c=relaxed/simple;
	bh=8bwj1s58zRyJa2tCDA/9ZgrrTbScTZni2svMRHOPJiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DH/EClpbQfOrCSGqJdl4dDGSJG+DIfjvr8KgDYZ03LhEmcqLvEzTR2XbeKHNa5CNXjHLBEAc/ymGexoTKQVm4FBxm4mCyk4I74Wroxa+xbRF5wkeeeVJ+xOJj8XV7Q3+1fT/cebJDNK06bLPD1n0AEYibjuhPCssQxyNBtfwe8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cibfeOU2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cibfeOU2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2AC1F00A3D;
	Wed, 22 Jul 2026 13:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784726044;
	bh=DdmmWfpX0G/BiAK19e+pNgIzu3V9RSdUngHpa414BTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cibfeOU2bdq3OVRrJx6kcq7qA9Taz1meIenBba/aKPpZtBgA/rucpNNZDnHXaDshr
	 0sUQbvlJtgMtfobrNGpIxM28zqiY69U9p/FbkEL2SJcgIxZ4WA9grZKalHTjgXI2mp
	 vw6sdn+pnfICBdCimGBNuFQ9HH198HKjDjJZQwG3BlHpiVMj//QTUFxO0dAsqXQ9fJ
	 8oyhpdUrkbB0l9uKbFxD67rAN5/Z/kgS7Rjl1FIfcZO0HXdVg9quRyPCTBenuWRzM3
	 4+rHX1RUqU8Xc/rg+lQcVUuYjN9PBy6mTkrd6GD0YF6c1OTs0vmJ5drtXOr1NPDEBz
	 PRuxYRn7oOJiA==
Date: Wed, 22 Jul 2026 08:14:03 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Siratul Islam <siratul.islam@linux.dev>
Cc: devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org, Song Qiang <songqiang1304521@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] iio: update email for Siratul Islam
Message-ID: <178472604213.223954.6496981771222842971.robh@kernel.org>
References: <20260721150314.24545-1-siratul.islam@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721150314.24545-1-siratul.islam@linux.dev>


On Tue, 21 Jul 2026 21:03:08 +0600, Siratul Islam wrote:
> Change personal email to the Linux specific one,
> to have a single and focused point of interaction.
> 
> Signed-off-by: Siratul Islam <siratul.islam@linux.dev>
> ---
>  .mailmap                                                      | 1 +
>  .../devicetree/bindings/iio/proximity/st,vl53l0x.yaml         | 2 +-
>  MAINTAINERS                                                   | 2 +-
>  drivers/iio/proximity/vl53l1x-i2c.c                           | 4 ++--
>  4 files changed, 5 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

