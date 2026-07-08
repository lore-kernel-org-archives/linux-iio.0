Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F23E3AFCE3;
	Wed,  8 Jul 2026 06:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492019; cv=none; b=R6WeCgx8cM0LN40+8Y1uZPLYGHcyJ5td3MMnz/lnnreT5vcxzRmlvfy2cYZ4aTCbgJ62T8pZz1vqmTPf0E3rkQT3j9h8YAgF/SnJiAFqGx5WTi2cYV94Pay4BUtyW0B1TyXoHrNE62lmQzv4rp0N2w8oSU/VZLrgKFocuiVDlus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492019; c=relaxed/simple;
	bh=g1bIRNb2Vgs58B+cR0vd9mmO4+hWlIE3qlYnoTXWekg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=My5pS48OCSzQoIzs8wBMr8rGWzjg16GgJx1W4fYy7Ah/M3c0fNpZi1Oi8+lqqUk9Y5xoqZe7zkorRRjp9bY+7U1AtSZvSOEO6cLWEiPDjDMIjGLUoz/jQdTTwWPItj60nsPEeYiAaOidiF6Xw0pztXsh0nrPd/MwGdLoA4HF/zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4mszy6/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4mszy6/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EB31F000E9;
	Wed,  8 Jul 2026 06:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492017;
	bh=XUX5fNGb9p/sKnXZvoH0YUFq5YvSZDAWFlItMh23DxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b4mszy6/LGLX0yRC8mBdvdhwe2RoWLljOryuDDpsfSMh3fs6sareUNkslRxIyRpBX
	 eMFUvFxYj8RmqPP9JG9BoaB4xxAHG6my2GOF2b7UPgCE8eHaROt89q+dsrbu8uQqWK
	 qpimjkp/Ov6/TN4XccjfzOu13BRiCy+gCIxhRyB9bSfaQC54zqJ/ELKZ9+0NdjCu80
	 0udTWS5XfOE+5kljc9runueRbC1Jri/LU5ZkiEv2HeSMj68ZOug0pgiMG5jwT6bmID
	 U51/S2Lobok2RD/znqfp4AAl+ChWr+fdcWvVPH20K1KiBr6FotFcLEeD+KQDnwOo6i
	 bod0Nv87aV24w==
Date: Wed, 8 Jul 2026 08:26:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux@analog.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] dt-bindings: iio: health: add adi,max86150
Message-ID: <20260708-relaxed-loud-seriema-ab11e6@quoll>
References: <20260707104234.1957104-2-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260707104234.1957104-2-shofiqtest@gmail.com>

On Tue, Jul 07, 2026 at 01:42:33PM +0300, Md Shofiqul Islam wrote:
> Add Device Tree binding schema for the Analog Devices MAX86150
> integrated ECG and PPG biosensor.
> 
> The device exposes two PPG channels (Red LED and IR LED) and one ECG
> channel over I2C, with a 32-entry hardware FIFO and an active-low
> interrupt.
> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
>  .../bindings/iio/health/adi,max86150.yaml     | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
>

I don't get where is the user of this... but you posted several
patchsets, several versions, so mayybe this is just some old posting. It
popped up in my Patchwork review queue, so no clue really. Dropping
this.

Best regards,
Krzysztof

