Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D43372EC4;
	Mon, 20 Apr 2026 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776694240; cv=none; b=R1/VFlMFgDDUg1sf3ydgvK6h/9qDB+hMNi+hjp2/41miYL6zTBYNP2K56xTZ/LJfribo7xUxyU3iIRkFhEJ17VPfiKJVg1DBNWQcIPWF/pejyMCATJDxKcPfrEy3KHME/QSzuDeLELa/gZKURhwB0RMzhFpauXFsZDtO+uIAdhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776694240; c=relaxed/simple;
	bh=CUB0YAFx7TfVG6NwSkBPCT10OAI1REGEY1MFAcilWAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkRNnW5ZaVq6hmslC0+ZMR/viQ+FXCCB+r8to7BeGTPcluzjbBhiFfoDTWBU6ouyB6ul9tKGgoJPyANdEyMmG75A+nIhH8tADDgc2VbqIXvlW25LWXBJzF62LlqusGRTd4zsno1FGeCHiFN6JZ8ovhnmL20BsJwVygG4WOXjSDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buLzg0OZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buLzg0OZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60969C19425;
	Mon, 20 Apr 2026 14:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776694240;
	bh=CUB0YAFx7TfVG6NwSkBPCT10OAI1REGEY1MFAcilWAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=buLzg0OZarXeJq52mO2d95EVSCVyu0YqaNpdaqCndcV4DGQJbgNQo6+HGPQ/5iTPV
	 Z4xSSgDsTDDIpbnkEfnc2GOlVpVcqBvlmCgp/A+ramvaU7MITagkJ/z+nKn+A6Z+Mp
	 03cIwByaHaC88WqojdG9PSuCCYewaI8kfKtjX/SLBt+35qdO1z6aHpvphE3apVKqlV
	 jJdrDooyPRFTayFy49lEAh4zU42nSeLjH+LtRi7WPwPbxmrRnG06icwLnpzxQEZudC
	 KT3hXTkjyamDrRagSYPXHQIPw6vezeOigX3mcMM3iuJ+ARbFfEts3sVVwb3dCiAD0w
	 zcZ1WJtcMhCMQ==
Date: Mon, 20 Apr 2026 16:10:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hardik Phalet <hardik.phalet@pm.me>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, andy@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, dlechner@baylibre.com, 
	krzk+dt@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, me@brighamcampbell.com, nuno.sa@analog.com, robh@kernel.org, 
	skhan@linuxfoundation.org, Hardik Phalet <hardik.phalet@gmail.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: iio: magnetometer: QSTCORP QMC5883P
Message-ID: <20260420-meticulous-emu-from-avalon-05fbfd@quoll>
References: <20260420-qmc5883p-driver-v3-0-da1e97088f8b@pm.me>
 <20260420-qmc5883p-driver-v3-2-da1e97088f8b@pm.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260420-qmc5883p-driver-v3-2-da1e97088f8b@pm.me>

On Sun, Apr 19, 2026 at 10:32:32PM +0000, Hardik Phalet wrote:
> Add the device tree binding document for the QST QMC5883P, a 3-axis
> anisotropic magneto-resistive (AMR) sensor with a 16-bit ADC that
> communicates over I2C.
> 
> Add a MAINTAINERS entry for the QSTCORP QMC5883P devicetree binding.
> 
> Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
> ---
>  .../iio/magnetometer/qstcorp,qmc5883p.yaml         | 48 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 +++
>  2 files changed, 54 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

<form letter>
This is an automated instruction, just in case, because many review
tags are being ignored. If you know the process, just skip it entirely
(please do not feel offended by me posting it here - no bad intentions
intended, no patronizing, I just want to avoid wasted efforts). If you
do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here ('b4 trailers -u ...').
However, there's no need to repost patches *only* to add the tags. The
upstream maintainer will do that for tags received on the version they
apply.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/process/submitting-patches.rst#L591
</form letter>

Best regards,
Krzysztof

