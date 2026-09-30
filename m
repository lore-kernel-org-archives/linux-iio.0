Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11F4250BF2;
	Wed, 30 Sep 2026 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769070; cv=none; b=gD0dVd+oooBt0fPGRvYG6g2g7cnnF/7z3hdf0+k699XcjRAN15n2ciz8MamlnaM7A8MMUjT0senXdFDIQw9tPha4xRnMv3MRDnu2ZWq1yzhJyWUlYJE9vJyTkCUnH3Yl28k5iwkSRs0UWtwmOxfFV8EJfaosNSKMBwB6S9y36/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769070; c=relaxed/simple;
	bh=i3A+ERtcx9/fZVaoEhgBjizXrbq5j+MDE5ctLw0E3J8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=qv/TXS4IgmQtFTAzlKB1+XqV3H48Af3Pv/AAzqn6Q0wLCBbFQSsPBlZT+EekJI/r33zlxHUsMIE3zO49w/+MK6maYRyJULdfdrp+WHhtYq6sg4FSJxVlVw9V4jaFwZkHq1lFzqCBwSybvtkcih6e19GBFMczrS8YsmfHOeVNTc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WA2PNLSe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WA2PNLSe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAE61F000FF;
	Wed, 30 Sep 2026 11:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790769069;
	bh=+2L/j0UmtmlgicWKF3pKKFfJhg3f2KT7a0/tCyUvw88=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=WA2PNLSeJN+zUWtGyYIYBn9/srWYwf2KebG4+9TBFBO4fq9LJ6x9OnegiE+wMyoC3
	 0cntmq4Htsz8i5lBI66T/Ctu0tGEDWHibnGO4T597Mr/m/anLKZi7T8do8jBgvi+mn
	 U6XNXlydQvwGsI3ITd1PKL0bh26wDB/bgxhfDKZo+fHhNVwGhG59FCHr7hg+b9MF05
	 Snag8WZaJfVOlG5atbFC8KL57PZomve6eHQdBB6/UHQGViTricOAvsLkXqgioxgB6G
	 NDEOvPiYYLDNZ5Mu2x19MlJWMM9IPVWhHTIqhRcUZlxMmINTOJVCRgvCIjPtp9Av6/
	 Q5iNtFLmuORQA==
Date: Wed, 30 Sep 2026 06:51:07 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux@analog.com, Michael.Hennerich@analog.com, andy@kernel.org, 
 linux-kernel@vger.kernel.org, corbet@lwn.net, krzk+dt@kernel.org, 
 skhan@linuxfoundation.org, conor+dt@kernel.org, jic23@kernel.org, 
 linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
 marcelo.schmitt1@gmail.com, devicetree@vger.kernel.org
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
In-Reply-To: <12e5af9d96f6c5e800ad860d3cfa6ac8006a22e2.1790719425.git.marcelo.schmitt@analog.com>
References: <cover.1790719424.git.marcelo.schmitt@analog.com>
 <12e5af9d96f6c5e800ad860d3cfa6ac8006a22e2.1790719425.git.marcelo.schmitt@analog.com>
Message-Id: <179076815229.2155168.1075572390665450691.robh@kernel.org>
Subject: Re: [PATCH v3 08/13] dt-bindings: iio: adc: adi,ad4134: Document
 SPI connection mode


On Tue, 29 Sep 2026 19:44:22 -0300, Marcelo Schmitt wrote:
> Document how AD4134 chips are connected to the host SPI controller
> according to different wiring configurations.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v2 -> v3:
> - Adjusted spi-rx-bus-width constraints.
> 
> Unfortunately, I missed SPI connection mode properties when introducing AD4134
> dt-doc and the device driver defaulted to a no-CS configuration. Due to that,
> conventional 4-wire mode can't be made default without leading to a regression.
> Still, updating the SPI mode default to 4-wire is a sensible thing to do later
> on if acceptable.
> 
>  .../bindings/iio/adc/adi,ad4134.yaml          | 51 ++++++++++++++++---
>  1 file changed, 44 insertions(+), 7 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml:174:24: [warning] too few spaces after comma (commas)
./Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml:180:24: [warning] too few spaces after comma (commas)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/12e5af9d96f6c5e800ad860d3cfa6ac8006a22e2.1790719425.git.marcelo.schmitt@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

