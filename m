Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC4C279DB6;
	Wed, 12 Aug 2026 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786499738; cv=none; b=GDUfFEWs09v1LIOs4BkwJ4rP8OC2hNu8rkcu0nhqPbeNdo8xzvacVrqN8TlpOpGResTT5kQcxvMZ+MgVP3bzrWMXS9ya2wwSrTcIo+ReHUbDhpWSFBleeLv+Hr0c9gl20qf9eqiAKF/5VMu1PBA21EUQszh3gsy9f76q171pv/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786499738; c=relaxed/simple;
	bh=YLdE1Y7UmMJc2P+VbDpV7v3wTD+CzZApOj8qHLCtwQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLyeQBqgd8y9omUpC00uJ2X/3NkLgf8TW1m6VIO+upJy6ArXcIbrT96EfC9/2LDeu5+cKgMXqkKt9XVMaaos3vmAqK820TcLbifTZmHbdmWtYtZGcgvX+hs3nzb6jTSJOeEniDNN61O32gtr9GUdxyDdznLIOGZH4VtliasqBT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7xuyAQr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7xuyAQr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46521F000E9;
	Wed, 12 Aug 2026 01:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786499737;
	bh=x0S067+FfSCbhPygxg5nqoEq05cMxZYgf+AOxmGrS2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d7xuyAQrxPJ+Uavu6V+gtBmSOrE7qs1DcTcJGM1U1wPGleoNtIG3cwD6SiuAhzBs0
	 KLP+t8HFCia92s/BEDo24LdtlGLgUR7oyILj+7QjtwtBz5t1fdi4yhFbG+I/je9UYa
	 ncgqbRxvL9t/GOB8C0kZgF4o8d1NFZO8u6wcjekAFaLAn0as6xOo0Oac8FFyfJE29E
	 pJ2SyCG2neFALfRCVCNFErszxPzu2KALX7c1e0oDSFRAv86fWYKbf5sIW5qNKt6qUV
	 MmZ3sD2OgQCV+1yg4uH3hfq3nbULy7t90sQY7XlIPmERVK0nrMK0tAWdk2RBpmKNcW
	 KGP2gnjtaYvlQ==
Date: Tue, 11 Aug 2026 20:55:36 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>, linux@analog.com
Subject: Re: [PATCH 1/2] dt-bindings: iio: accel: adi,adxl367: add
 interrupt-names
Message-ID: <178649973599.507127.18202495545970018896.robh@kernel.org>
References: <20260805115952.33894-1-antoniu.miclaus@analog.com>
 <20260805115952.33894-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805115952.33894-2-antoniu.miclaus@analog.com>


On Wed, 05 Aug 2026 14:59:51 +0300, Antoniu Miclaus wrote:
> The ADXL367 has two independent interrupt output pins, INT1 and INT2,
> either of which may be wired to the host. Allow the interrupt line that
> is connected to be described by adding an optional interrupt-names
> property accepting "INT1" and/or "INT2", and permit a second interrupt
> entry. interrupt-names is kept optional so existing device trees that
> only specify a bare interrupts property remain valid.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../devicetree/bindings/iio/accel/adi,adxl367.yaml    | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

