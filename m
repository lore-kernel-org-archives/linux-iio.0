Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082D92FD1D0;
	Mon, 20 Apr 2026 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776694141; cv=none; b=kRVWBN9SLXkOTNnubbfmG6mXpwa8J/lJ06pfsjQTaMIANNvPiQ3Z1+pPiwrXMPWCsR4GrGSGDPD5/NSkILBzbIqdaqSp+F0BjaIJlBWxHTid44KUu3OraWziyBM6Ftq3PxYjMFSZUdt9/VUFC50OPxaApg2eAIF/5U9bHuGCzYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776694141; c=relaxed/simple;
	bh=7AQGntyamDukw6L1++iVmxHHJ+1bq3SywAnLJXWCCh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JP/AvfVIpTPFT7UAtg42eomYoi5aQcfw+7YVDy7/u4E7pFow63YmQ0ifE+rJvZg87muOk00Zzlu9Wl2KSJPg3+vuFlp/qFWD54wUVZVOKSiGtabICzkzABpJ2NCU3D2qvvVUowTF8MkVs1lnfd430MRQ5F1nWza9C7EQmxgqLDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMPsRUjo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMPsRUjo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC13C19425;
	Mon, 20 Apr 2026 14:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776694140;
	bh=7AQGntyamDukw6L1++iVmxHHJ+1bq3SywAnLJXWCCh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LMPsRUjourZ3xixfCf+nkeeIcokivV4iuouW1vpEM7PR6jzwoKUU8n0A9QY4Huap4
	 l/wlrFUwqalEChdzpmUuR7ugLSzcQmMWNzC6dbSHNGS2HPjV4lzMYP/hCNQVjv55bR
	 xxChwA/p3xxhYcy62HpQI1UyZOFD17PnCGLeOLsS7UDGtdkQD5bw+Bg2MqYoeOFH6q
	 nNi7h3VYxV5IHNZrH68C62h8vvbEhrScGjP9pRZOzGm3qgvgS1tAcCgGCX1GNNCRip
	 +QEi2/1lKMgLge0W6dlaUxtUwFbNZFjOv9uN5f0B8kISaPChC5l0Bn8fh4WRI+zrPk
	 XPgR+7nefo1jg==
Date: Mon, 20 Apr 2026 16:08:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hardik Phalet <hardik.phalet@pm.me>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, andy@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, dlechner@baylibre.com, 
	krzk+dt@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, me@brighamcampbell.com, nuno.sa@analog.com, robh@kernel.org, 
	skhan@linuxfoundation.org, Hardik Phalet <hardik.phalet@gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: vendor-prefixes: Add QST Corporation
Message-ID: <20260420-kind-rampant-macaw-bf1aa6@quoll>
References: <20260420-qmc5883p-driver-v3-0-da1e97088f8b@pm.me>
 <20260420-qmc5883p-driver-v3-1-da1e97088f8b@pm.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260420-qmc5883p-driver-v3-1-da1e97088f8b@pm.me>

On Sun, Apr 19, 2026 at 10:32:20PM +0000, Hardik Phalet wrote:
> Add the vendor prefix 'qstcorp' for QST Corporation, a manufacturer of

(and here goes few-word explanation why you have chosen qstcorp or just
the link to the website)

> MEMS sensors.
> 
> Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

