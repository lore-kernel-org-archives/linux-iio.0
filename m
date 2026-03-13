Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EE836E48F;
	Fri, 13 Mar 2026 07:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773388552; cv=none; b=YTT+QLL4aZaX8iMedeFuF3YLjWbuUKwO06C3ypXG4mU1kfjqcyctwrlP5bzDN9sh+S22IWLayeynx4cH9k6uhAIpHyW8QjIfaDYaU6hxf+o2Jgub5xpcora9s9Hg7nNw4sAIQUwFq7219nCasXzF76kckTgotPCGaNAYY5JbiyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773388552; c=relaxed/simple;
	bh=KH4qpNK2ZlWZ0iVnembqD8Iy0VhYFNCwrOqD1T0F5x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoKRcga1wbW1vpycUv+QnK+tZHjZfq23x5ByQXRgSX1TTAaetW77LzuAUpQ+if2IIrY0TGk0O3HllB/FeMwwByDhdXM32LPACXlgkvvDCj55DXWjGxMVnKmRIKEvz1RELDzUVqLqtgQdRLn7aMhsROOmLjaKFgH9ILw2fOBNIsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gF2GWG1l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gF2GWG1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1156BC19421;
	Fri, 13 Mar 2026 07:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773388551;
	bh=KH4qpNK2ZlWZ0iVnembqD8Iy0VhYFNCwrOqD1T0F5x8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gF2GWG1lfXR61aXAlm7bMFp5CeruIOYZIyywgIiv32LNvBSsU29a4yBzDvPX6f5mZ
	 xND7lVQ9nPCLktTPfin0uc64XmVnXnrzAMLLnvtkaGRst0nUtkD2+mb2i5tzb4TyPG
	 xLC9hAX2ogE9krudnkDEQOlFHi9zMdioz2w80iwd/J2mCnbdKs0K4/5WwPP5G0t7lP
	 c7Qmhg34wFBzI10zNe6BWrRU5B3Yp3nzzLTUNN0Le+hpE8gv9rB+NjshH2pueJv1U+
	 A7EsRVyXYbjBZodR/EG/E33NobucXb1uG0jjt5gp0ClDFBojATe8JWffAlr67geI8G
	 8djnAknmhIxiw==
Date: Fri, 13 Mar 2026 08:55:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Siratul Islam <email@sirat.me>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: proximity: add ST VL53L1X ToF
 sensor
Message-ID: <20260313-voracious-interesting-carp-064fc2@quoll>
References: <20260312183721.40482-1-email@sirat.me>
 <20260312183721.40482-2-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260312183721.40482-2-email@sirat.me>

On Fri, Mar 13, 2026 at 12:37:17AM +0600, Siratul Islam wrote:
> Add device tree binding documentation for the STMicroelectronics
> VL53L1X Time-of-Flight ranging sensor connected via I2C.
> 
> Signed-off-by: Siratul Islam <email@sirat.me>
> ---
>  .../devicetree/bindings/iio/proximity/st,vl53l0x.yaml      | 7 +++++--
>  MAINTAINERS                                                | 6 ++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

