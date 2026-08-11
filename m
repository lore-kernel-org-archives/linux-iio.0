Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED1A369D7D;
	Tue, 11 Aug 2026 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455184; cv=none; b=CFuseE+rhEwpTI2ZLzxXErozASU6OlUHlAxv6JTGxO27N/2Tx/Ql+sYCKsTTEb6estQJulL/YFr2aUn0smkLUWIKt8q6ikVtsrtfmEqXzKJaE3k1AxhzddgKWtU+yfT/fk0GG0IeobCcErETs0Ie7ykBFkXydJFWrS3iXNbDUmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455184; c=relaxed/simple;
	bh=+EcfwRWRDl2wWqNFUoS+gVqt0L/1oPV74HNMHZna51E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijnmYuadLYvTC+0g7HkGHx6FFTrrJpK4kEpiyvaXJmqpFXWIB4RY0sYl32XiB5dZXewBjYNmKpaQCo1H1Zlpzol1sr80oEdGRgoFDq9+M3if/B94ITBJqWe9yG19mY57z2eXwyq1HOkCUVx6o/F/tx4JUry7Dtqak9bvQXjGoUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgYPdkq0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgYPdkq0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9991F000E9;
	Tue, 11 Aug 2026 13:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786455173;
	bh=IolMNXpKF2tnvzbvC5XM/YIyaKMla9IMjCvono9Jg68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RgYPdkq0lHa8tbhoxw4hFZQWrgdVubBFSo76/VIiz7GFkBhzJhciaX3VVYyda4Tqi
	 sWTpiX5QahS+kIC96+8AUkth9ggBGsGHjsGnOY1ZlOglvZ1WAo3bLaCVA+RBTlu9Ne
	 Uu8LzEcsqk+yu1yz8/+MhPGTPLjDV9pGhxq3lYqEztR/W6v3eyz0o5SiPz4wDOryNL
	 YblT+1CNlxdx4x6dyQVLoIcQFwq8JRHe0EDo5XiWjjwPvXn8/Jdc4qnfJvjim9hlr5
	 AAhfTg7pQHq7H2c4w0oAr3rVLgBDEQwqSgPozqEl3dfuy/MtTgvYW0nIFJnUqFg+wm
	 sKH5o/77KhE5Q==
Date: Tue, 11 Aug 2026 08:32:52 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: linux@analog.com, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-doc@vger.kernel.org,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Jorge Marques <jorge.marques@analog.com>,
	Salih Erim <salih.erim@amd.com>, Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Radu Sabau <radu.sabau@analog.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: adc: adi,ade9000: add
 adi,ade9078 compatible
Message-ID: <178645517212.2041830.15280172934355138378.robh@kernel.org>
References: <20260731082951.1228-1-antoniu.miclaus@analog.com>
 <20260731082951.1228-3-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731082951.1228-3-antoniu.miclaus@analog.com>


On Fri, 31 Jul 2026 11:29:48 +0300, Antoniu Miclaus wrote:
> The ADE9078 is a polyphase energy metering device from the same family as
> the ADE9000. It is register-compatible with the ADE9000 but does not
> provide the on-chip dip/swell detection and is limited to a 10 MHz SPI
> clock.
> 
> Add the new compatible along with a conditional constraint lowering the
> maximum spi-max-frequency for the ADE9078.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> no changes in v2.
>  .../bindings/iio/adc/adi,ade9000.yaml         | 30 ++++++++++++++-----
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

