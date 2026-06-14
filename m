Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A25303A35;
	Sun, 14 Jun 2026 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781459965; cv=none; b=PFrN5JsJFTyJWIQ2rEBT7+DDI3b02kfFMOlLjeMGyvexrUG6XAz/IwOaL9/AgNVvlFsbbeMhHOaUFnjhuV8CZVeHBrpNJ/7ZfEKJCPZa1EfgnpOdEWgSdqe/vvJftnE+T/abP5ukEb/T87GyC/Y2spNMXr0h3JTkU0icyOnTNPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781459965; c=relaxed/simple;
	bh=9RgBVtRmSO4+p71xu+1pGxV9mKVas2tvVlXuHY6Uv6o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Egw8czki3TNTEg0MRFXiX8vSwUvull6CzYgR66hi3pa7yj76923d8oN+Mbl6QgDUT0lhbyJtVEP+bFpZ5fTvN/4lgUnDNfxP9b3gk6BDZ2b58N0zVu4mxTrhf0xKOAuTZzIF+o78CUKoaPNMlnVzGFsS5qbdI7X5S9w/h+Wd/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxMSveGr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxMSveGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65631F000E9;
	Sun, 14 Jun 2026 17:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781459963;
	bh=v5lcDAqHXrJihCxk1fGEUdfaBsoj6/WVjF6AF/NVySg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VxMSveGrKC83JWbx5f88cjqQpli2V266ebEvXRC0z9wBOGH888+ehafpVIgjMJjEn
	 ch3QeqfTpBRei3U6Q4EqqQYhZEajZV3V/XcrVtI6enAcKcsd8cExcw1nrobjJbc8Lc
	 YgLlUHOtOBbLBtKboSkNWvTA3hiGfimaxsIdWvLlnwLkEyR7IOSkRIOL2t0CHJASFi
	 OwDQ2o/7XgBn3xic7sEBx2fwUme8R9RrdZ83fnb7ZkaxgmGaHSH6wPRRAoQVrXOVOT
	 MQcgDsDjEqFXvDRyOnpoUSp9DGg4V91xpNVkAY5X5WbAWUoyQwa7N6XZdQb+XAMSkr
	 ve7VO/yKSC8HA==
Date: Sun, 14 Jun 2026 18:59:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v4 2/6] Documentation: iio: add Open Sensor Fusion
 driver overview
Message-ID: <20260614185914.6c14d376@jic23-huawei>
In-Reply-To: <20260607234343.22109-3-kimjinseob88@gmail.com>
References: <20260607234343.22109-1-kimjinseob88@gmail.com>
	<20260607234343.22109-3-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Jun 2026 08:43:39 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Add a short driver-facing overview.
> 
> Leave full protocol details to project docs.
> 
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
Same issue on needing this series to be against a suitable
tree, not on top of your previous version.

> ---
>  Documentation/iio/index.rst                   |   1 +
>  .../iio/open-sensor-fusion-protocol-v0.rst    | 308 ------------------
>  Documentation/iio/open-sensor-fusion.rst      |  62 ++++
>  MAINTAINERS                                   |   3 +-
>  4 files changed, 64 insertions(+), 310 deletions(-)
>  delete mode 100644 Documentation/iio/open-sensor-fusion-protocol-v0.rst
>  create mode 100644 Documentation/iio/open-sensor-fusion.rst
> 
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e227b9aff..2ddefc42d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20015,7 +20015,7 @@ OPEN SENSOR FUSION IIO DRIVER
>  M:	Jinseob Kim <kimjinseob88@gmail.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
> -F:	Documentation/iio/open-sensor-fusion-protocol-v0.rst
> +F:	Documentation/iio/open-sensor-fusion.rst
>  F:	drivers/iio/opensensorfusion/Kconfig
>  F:	drivers/iio/opensensorfusion/Makefile
>  F:	drivers/iio/opensensorfusion/osf_core.*
> @@ -20024,7 +20024,6 @@ F:	drivers/iio/opensensorfusion/osf_protocol.*
>  F:	drivers/iio/opensensorfusion/osf_serdev.c
>  F:	drivers/iio/opensensorfusion/osf_stream.*
>  
> -
Check your series for things like this right before sending (we all make 
mistakes like this when building up series!)  It clearly belongs in the
previous patch.

>  OPENCOMPUTE PTP CLOCK DRIVER
>  M:	Vadim Fedorenko <vadim.fedorenko@linux.dev>
>  L:	netdev@vger.kernel.org

