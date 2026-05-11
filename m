Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD1B3DDDAB
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502555; cv=none; b=Dc+rLX63Al+jHOXOfYLomkwW2UT0GaXEXYQouB/YydMqHsyAuDlNmClhfDfR5BN1kajGIciqn6CZxuEZSLZSodraDN3TYGPVmXK7oUC+Takea+Bj6S3HjBlfs1ZhGKFd5UaivZwTP/u8AiRroF57tTRDwPBigblB07EGnXQ8JWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502555; c=relaxed/simple;
	bh=k48BkzRng8yeSZHxzuPJjNAgQF1o0orrztKWc9YG+NI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=krTecUG2p9vH+LKXyDzdiO9aUvRBb59YWIvzyGzipgmEg6IcioNpXSGVfmuOw9HZaxwC5Hu8eG2CLpNhFgy5u42xCkEb7IVqePZbtX1oOupG62fn0OXbNpwi7CPLEkMdC2/agzpX090AnGEdNti4tGcSjRgos8swWIy8A2ZtKTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5AkJzWo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5AkJzWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6517C2BCB0;
	Mon, 11 May 2026 12:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778502555;
	bh=k48BkzRng8yeSZHxzuPJjNAgQF1o0orrztKWc9YG+NI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D5AkJzWoJEhqqjlEBhVUb4Lo/ummz2ETnxVCitsmQod1so1VcA+XmGmYtsH6BRwgo
	 5201vgRemjKt79K5cE1l9AGyhyFFkNG+WQyEqKoadMcnd6ywKn88UXRHH0gwnDqaE2
	 X8cKrv5mR0tDRVjBYH2nmymkQ41K3wZvc+U0VC71PDZWSE25vHCg9RiOuQvtjo+NRC
	 CfF89OnPsheetIZBi2mmdnrMeu01L/WHZaPT2NGJy5DFq+MJ3ivt/LJiAgROC2keQk
	 UkcgKE8+7QwblEZdEXWFWlZj3HFm32nYvgajqPSsGzY0O9k44vXUgmOYoz8lEsGx8w
	 PIQgCGHJEfjmQ==
Date: Mon, 11 May 2026 13:29:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC 4/4] MAINTAINERS: add myself as APDS9999 maintainer
Message-ID: <20260511132908.6aea342e@jic23-huawei>
In-Reply-To: <dced0d8107c8f046a80128ec0fba85b764ef1848.1778491503.git.azpijr@gmail.com>
References: <cover.1778491503.git.azpijr@gmail.com>
	<dced0d8107c8f046a80128ec0fba85b764ef1848.1778491503.git.azpijr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 12:14:52 +0200
"Jose A. Perez de Azpillaga" <azpijr@gmail.com> wrote:

> Add maintainer entry for the APDS9999 driver.
> 
> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1aa9c989973f..cdb703f37f06 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4302,6 +4302,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
>  F:	drivers/iio/light/apds9306.c
>  
> +BROADCOM APDS9999 AMBIENT LIGHT SENSOR DRIVER
> +M:	Jose A. Perez de Azpillaga <azpijr@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
> +F:	drivers/iio/light/apds9999.c
Build this up as part of the earlier patches.

So add the initial entry in the dt-binding patch (if that's a separate
file) then add th driver in the follow on patch.

There is no advantage in having it separate and it annoys some tooling
that checks for valid coverage for each file added on a patch by
patch basis.

> +
>  AVIA HX711 ANALOG DIGITAL CONVERTER IIO DRIVER
>  M:	Andreas Klinger <ak@it-klinger.de>
>  L:	linux-iio@vger.kernel.org

