Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5832135C183;
	Sat,  1 Aug 2026 23:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785628520; cv=none; b=l7mxxdscCS1AfOTTSZii2npTpgv2UVJWVS0mjIR6yfbHlbqYotcJaFKYxv++atpAvY66USMc3nhJY3ceoaEzPruXxgkhPIfqfncRYEt59EhPLGcWM/Yf5IO9yRJQz8U8TTcZQG5c03+n9p7ts7tqYYJmjV4GNr/fiVP+3d+f4Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785628520; c=relaxed/simple;
	bh=KRpiL7ukkRLXrrHlWj2Xid/sLeDHdyMHx5Kg32rk9qU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVZHFNaopk4wm9vIaHkL1FtRhoiqT45CaiLzSasFkgPIoPUfeqn4zrD7zAeb36aSpU3Mwms8QEx9zZF9qA5ExJdYbrH7TONgAIs6MrfgELa6sWMlzX3HI5Yc3/vPXjYaUhjkQdnsXjQSW7M6RZ3c6omb8t1tire2hLcbMuLgLBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njrsqnDL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njrsqnDL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC28A1F00AC4;
	Sat,  1 Aug 2026 23:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785628518;
	bh=C/YlJ8wucizeYmLyTqptfph4YeLQo2yHVoCMPddbvQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=njrsqnDL0G1QjhnpK0R00RE9xJtYjTEdAiz7OdPbd0fjz0iXkFG17PlwZ8wOhancy
	 ANpGJ2JcLPoG/fqn0FS5zN4K5rZSCu632h4hu+xixsGs95KvaPcOnWsEN/gZ52AICC
	 DBCjLmwbB2J5VpwUG76auMIOX2/uJZQ25LVTQCn440+7Z8qoxJ8M5p40IaKY9BiNO1
	 dawCYhGc3mAylsDmZe4al81ZrS03Fl3Ut/59nj6FZr5Ld9PvG+dHAjg+GBEUt4b7HY
	 z2YzWlyH0spApcdNuA8V/+xQN/79ZtrflmcFQ4hOuPTfhLw4fqvaN3N37SO6dEEWtG
	 11W3ItRjPrhIQ==
Date: Sun, 2 Aug 2026 00:55:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v10 07/17] iio: test: add kunit tests for channel prefix
 naming generation
Message-ID: <20260802005503.70ec9e25@jic23-huawei>
In-Reply-To: <20260729-ad9910-iio-driver-v10-7-aa1f6167729e@analog.com>
References: <20260729-ad9910-iio-driver-v10-0-aa1f6167729e@analog.com>
	<20260729-ad9910-iio-driver-v10-7-aa1f6167729e@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 09:25:34 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add a KUnit test suite covering __iio_chan_prefix_emit(), the helper
> that builds IIO sysfs attribute name prefixes from an iio_chan_spec.
> The suite groups cases by the enum iio_shared_by mode it exercises:
> 
>   - IIO_SHARED_BY_ALL: produces an empty prefix.
>   - IIO_SHARED_BY_DIR: emits direction only ("in" / "out").
>   - IIO_SHARED_BY_TYPE: emits "<dir>_<type>" and the differential
>     "<dir>_<type>-<type>" variant.
>   - IIO_SEPARATE: covers the full matrix of indexed, differential,
>     modified, output and extend_name combinations, plus the two
>     documented error paths (differential without indexed, differential
>     with modifier).
> 
> A final case exercises the seq_buf overflow path by passing an
> undersized buffer and expects -EOVERFLOW.
> 
> Also, an entry is created under MAINTAINERS dedicated to tests for IIO
> core helpers.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
>   * iio_device_id() - query the unique ID for the device
> diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
> index 4fc17dd0dcd7..7d2c29cc583b 100644
> --- a/drivers/iio/test/Kconfig
> +++ b/drivers/iio/test/Kconfig
> @@ -4,6 +4,20 @@

>  # Keep in alphabetical order
> +config IIO_CHANNEL_PREFIX_KUNIT_TEST
> +	tristate "Test IIO channel prefix" if !KUNIT_ALL_TESTS
> +	depends on KUNIT && IIO
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Build unit tests for __iio_chan_prefix_emit(), the helper that
> +	  builds IIO sysfs attribute name prefixes from an iio_chan_spec.
> +	  The tests are compiled into the IIO core module.

Sashiko picked up on this being stale as now they are built as separate module.
If nothing comes up I'll just delete this line whilst applying.

> +
> +	  For more information on KUnit and unit tests in general, please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> +
>  config IIO_GTS_KUNIT_TEST
>  	tristate "Test IIO gain-time-scale helpers" if !KUNIT_ALL_TESTS
>  	depends on KUNIT
