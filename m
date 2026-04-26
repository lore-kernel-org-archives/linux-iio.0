Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BCE2882B6;
	Sun, 26 Apr 2026 11:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777201310; cv=none; b=UTpLzoi2OTLk9ZVElbNIjv/O983Riq6Ml9UkJc1W70rW8mRkxIAGANZjbumywwcuFijX7itgxz49ZTZ1ZgrPL5p6VwIMuI6WvTFQJkfYkYLADSMe3IRtUR8C395nAFj7IV2vGDL7xmKC7BQIOceUHQqJY0xZpJHD/pwXhklI0i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777201310; c=relaxed/simple;
	bh=5mbT5zxJLttGO9IREsSuDDnHGoOb579Xt7g8NCSKqGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpwkakXqQcM6VWwrWWxvzsZdapsDn8jWZuoWojhC0ydXoG/TJB70bp3RLlPBVPaDb8ZT5+CBmGLFa8psztgl9jeJHBjEbLHn1N+wjaSpjtgmrKJTWEK3sPs2ucGmZQWO7EEq22+o3khbx+CGHsy04DZyR6TSaNbtJkyCjabxes0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8tXNY3f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8tXNY3f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF72C2BCAF;
	Sun, 26 Apr 2026 11:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777201310;
	bh=5mbT5zxJLttGO9IREsSuDDnHGoOb579Xt7g8NCSKqGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J8tXNY3fYHJBBvA/VMVCTzeMAlg7/Q4PdaCuLa6ffOydAiPMmjIjDOCMhBgmkgf3/
	 8++bCPFlnU+9jUVXXVNnqoNKlmTqQ8tq2VCDZSJLmaMeM/1OHnfqv89h0CmerKAQht
	 Y6V3Th9yK9j3cymhdrd79fea6t7TidchIGtVTh4VEwpHWewzsBibbyOSoCznVzkpSQ
	 hp0i/m0GnWu3ccbfc46PsT1riC6PQIgHE663KFulWy7Kzz8y96fgWd+yLGXWS1BlRb
	 OfmSGXsX+ZjFQJoI6dI1DUwg7v//qEb63h3J1AcjckZl2nyOwTo2kyT9/5Qmt6FqHe
	 g8PWJIcnUVn/A==
Date: Sun, 26 Apr 2026 12:01:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v3 1/9] dt-bindings: iio: frequency: add ad9910
Message-ID: <20260426120139.3fb8f3da@jic23-huawei>
In-Reply-To: <20260417-ad9910-iio-driver-v3-1-29b93712a228@analog.com>
References: <20260417-ad9910-iio-driver-v3-0-29b93712a228@analog.com>
	<20260417-ad9910-iio-driver-v3-1-29b93712a228@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 09:17:30 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> DT-bindings for AD9910, a 1 GSPS DDS with 14-bit DAC. It includes
> configurations for clocks, DAC current, reset and basic GPIO control.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  .../bindings/iio/frequency/adi,ad9910.yaml         | 189 +++++++++++++++++++++
>  MAINTAINERS                                        |   7 +
>  2 files changed, 196 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
> new file mode 100644
> index 000000000000..61e879bca5c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml

...

> +
> +  reset-gpios:
> +    description:
> +      GPIOs controlling the Main Device reset.
> +
> +  io-reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO controlling the I/O_RESET pin.
> +
> +  powerdown-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO controlling the EXT_PWR_DWN pin.
> +
> +  update-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO controlling the I/O_UPDATE pin.
> +
> +  profile-gpios:
> +    minItems: 3
> +    maxItems: 3
> +    description:
> +      GPIOs controlling the PROFILE[2:0] pins for profile selection.
> +
> +  sync-err-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO used to read SYNC_SMP_ERR pin status.
Looking at the datasheet there are a few other things that might want to be here.

pll-lock for example might be wired to a gpio to allow a check that lock has
occurred.  Maybe sync-samp-err as well though possibly that one wants to be an
interrupt?

