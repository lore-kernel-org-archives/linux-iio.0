Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE384418E4;
	Tue, 30 Jun 2026 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834095; cv=none; b=ll79/H4sBS1a8j1JHXdw1104UT0Z+JslymxcHl93UtLu5175+nZy9TRw1JndASXQpn2XHvvvVkuK+IVtqgdZykzjlSOMwPMkASBPB5sqKpEcLHgJ3sitp2+L9RLg31iasRB1bx8vG2EklzG7bwOBHYOK8nauVacgAhKnsWiWheE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834095; c=relaxed/simple;
	bh=aVGRPjuk/iK4RNQVgoxtgzO5uLJkDZS0Aog/yrkx6iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ4jwBl/7+P30nvSLz9DOo90/P3eH4dlvmIAfN5D74+CaeDF26Yi5cE3fRWFyLtUCiAdhh7FdltHU8+QcrKo65WlTFCbknMjJKP9fUOa5fGFeD3pebmhQ2oMFw0PWSpvnsxt+OYQvJGxhG/uPrDr4eQoLbobO16mSSqD1/fnld0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/MTnmFF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/MTnmFF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90C31F000E9;
	Tue, 30 Jun 2026 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782834093;
	bh=ZSV7fPEAWQ3Pvr7rxMlaVkucoLzZ2elwKVH75MXNu+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O/MTnmFFcV6HsHhb+dzTDFi+mEjVInznMKVXf1FqhbJLJhACpbXUZC5VREyhAN1JK
	 ivnfNOADDBCdsp+Z9E64uXAh4r0oX6vjUBLgl6Uhfd9K0rF5j8BZhwbLYiO+49K9Gl
	 6LnnzeSBTdGYgbO+mXhK3HRG/nssssTNyDIpdWWihBG6sbBdH1SznjN12x/qp09QZP
	 zLoZzPZYJ87xb9Oq0i+KVMwbRi+/0zodmVTmgEO381yLwmObD3NVEQhwjSfqBPZvmH
	 xcb7VYo2CAaXcAwZu2rhESMxgG4wilywfFD5IfUBc9omQ8x5o6dkyjQhTOju1fqX+L
	 CZjGKi0pHhijA==
Date: Tue, 30 Jun 2026 10:41:33 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: linux-iio@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: temperature: Add STS30
 devicetree bindings
Message-ID: <178283409248.3688066.13200644563494383989.robh@kernel.org>
References: <20260621004626.66629-1-m32285159@gmail.com>
 <20260621004626.66629-2-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621004626.66629-2-m32285159@gmail.com>


On Sat, 20 Jun 2026 19:46:23 -0500, Maxwell Doose wrote:
> Add the devicetree bindings for the STS30 family of temperature sensors.
> The STS30 family of sensors includes the STS30, STS31, and STS35.
> 
> All devices in the STS30 family share the same commands, timings, etc.
> The only difference between them is their measurement accuracy and
> tolerance.
> 
> Additionally add MAINTAINERS entry for the driver.
> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
> Changes since v1:
> - Squashed parts of the MAINTAINERS commit into this commit.
> - Added ALERT pin as an interrupt and in the examples.
> 
>  .../iio/temperature/sensirion,sts30.yaml      | 55 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/sensirion,sts30.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

