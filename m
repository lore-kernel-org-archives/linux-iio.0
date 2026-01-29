Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62530309EEA
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769712390; cv=none; b=ire0UFPVfUD7Zv7GTffeN7Gwa4dHcvBW7GtztK4HknnVL8CvtTZFJ/b2iWTN/aDB4aLjw6kmSZa83e9L75MuqQiA6E5m5ZlMAPdjv/LhhO1MxWU5kfd2l1lhITaL6aeguO0Ub1ZtbS+F0/aGAzUxgSfjoE1y9mI/Fywk9i6cKyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769712390; c=relaxed/simple;
	bh=rfH3xNuU0bL3W2q4vgBTHDbKyt6hckIj8vgVnl0A6fI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=go3aFltDU9jliLlhI1JhjGdvAfsnuoyWd2Az/TXIE8quhS4uj6pymBLNUrA1vgPBtNvzXYidwfWyF+hBNqdDNoyvpwXVyPTrlWXtiTdYottXf5wmNLbEhGbsN8NOwR2Q8AF8vOcPAcIZb9HIGyllr2jTGR2rHniDoq6kNb/9/Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZAxmWx/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZAxmWx/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9BCC116D0;
	Thu, 29 Jan 2026 18:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769712390;
	bh=rfH3xNuU0bL3W2q4vgBTHDbKyt6hckIj8vgVnl0A6fI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FZAxmWx/la6FU4721UI+2UXzDR9jeMOp2NKvd0LFABJsfPTKwtay7eLi7BhOUDI36
	 Red2Tan7/LCG8d3Bm9M2tDOSw4Sxsh5NS3LMAsqm2bfZnAWav4GFFA/NNrJ1zHz2mj
	 vKMKqJt/j0Ku+w9fPDnpGabtAYBCdxbPPuWNEW5i/IQ+kUccsP1FXfcb91PAFcydxn
	 dH7OLFsuiT983k70fVadd8AMo0fZv5+VwFgJsI6YJ48sJ4Ea6nonoxvlqKyplucPca
	 3KhZCJENnf43jDJA0oy6tgdMfzuyABM7liXF2FEWr9bHVeKDDwb8TlwlH9KZKiGsnd
	 blbCN4OoJQ0lA==
Date: Thu, 29 Jan 2026 18:46:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: iio: gyroscope: bosch,bmg160: add
 bmx055 gyroscope binding
Message-ID: <20260129184621.749d6450@jic23-huawei>
In-Reply-To: <20260129071105.389493-6-jerrysteve1101@gmail.com>
References: <20260129071105.389493-1-jerrysteve1101@gmail.com>
	<20260129071105.389493-6-jerrysteve1101@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 15:11:01 +0800
Jun Yan <jerrysteve1101@gmail.com> wrote:

> Add the device-tree binding for the bosch BMX055 IMU (gyroscope part).
> 
> Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_datasheet.pdf
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>

Hi Jun,

Is there anything stopping the use of fallback compatibles? 
It seems from the driver that even the chip ID matches.

That is, can we have
compatible = 'bosch,bmx055_gyro', 'bosch,bmg160'.

or something like that (I can't remember exact syntax) so that
if we have a newer DT, it will work on an older kernel?

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> index 3c6fe74af0b8..907fca4e5895 100644
> --- a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> @@ -15,6 +15,7 @@ properties:
>        - bosch,bmg160
>        - bosch,bmi055_gyro
>        - bosch,bmi088_gyro
> +      - bosch,bmx055_gyro
>  
>    reg:
>      maxItems: 1

