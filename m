Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EAC42048;
	Sat, 25 Jul 2026 22:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785017767; cv=none; b=nUwmeVBJLKmZ6Objnbwy7CaLhQkoWDpuhrrpivQg5nhZuiLVL9QSIfdBuMdoWr84FjoWypvDAuuV5QS1LOn2UfEPjoyeQEKAw55xNvKXjGY6tGWMxbAhZPj17oWRzQscYehlIRlbOPyfMIPqlKif8XY2c4vyuZNLFJtDdeJZ0Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785017767; c=relaxed/simple;
	bh=bQyjKZ7gpY+DVg7XBLRNMeRTCAu69E2bYAxHP5tBIok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMDmyQQgKBFQYobYAMVvqt4qtQ6QGOQvCiVoT4Q+fRPnNXzaWPYdYK49IkViKids9FsxYWqZq9ow0FCJ/0BM1n9AUCvFgVMxTO7JrKJt6ym2qjrZ0h6pYFHm6fBC/0ZfgaQDTc+Lfvip1lx11XBWNOKsu+zps/diDo53/HRkjzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCY7fywO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCY7fywO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692621F00A3A;
	Sat, 25 Jul 2026 22:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785017766;
	bh=5ZKAddQE+9s6nkQA3GBq4kjWWjNkeT4NOUnjROL36M4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gCY7fywOoZqGJVLJZkjB40Eoj5zYto1TS0/JvO0DlDCIhTRzksbpP+YklvcbX9hUK
	 4vCaH+F5CgRif0jXVyQVKrw+wTsoBvW4NIQ7vESqZeHDij0W2Hgd438fKOpRJUtAEi
	 0NE9JFINMnCvGHv5Jos9c0GbDzX0hqtgW7PXmXaO+uriH4GSugcIqpNre9qnIUneec
	 j4KY4uioWtQlaLpQehqg3A2fnA1+GfMej9o+Uh5D/jXoDCeSrDn7pRVbq4aKTGwhL6
	 AbaH/thWCnGuvzpDhrXVgm+tMk0ZtZQiGHEh+32WCN2VskbBvdUXS4pQpIDBAisHzf
	 AuXnZAArfQXaw==
Date: Sat, 25 Jul 2026 23:15:53 +0100
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
Subject: Re: [PATCH v9 07/17] iio: test: add kunit tests for channel prefix
 naming generation
Message-ID: <20260725231553.6be8b2eb@jic23-huawei>
In-Reply-To: <20260722-ad9910-iio-driver-v9-7-459d1df5ac56@analog.com>
References: <20260722-ad9910-iio-driver-v9-0-459d1df5ac56@analog.com>
	<20260722-ad9910-iio-driver-v9-7-459d1df5ac56@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 16:50:16 +0100
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
https://sashiko.dev/#/patchset/20260722-ad9910-iio-driver-v9-0-459d1df5ac56%40analog.com

Calls out missing MODULE_LICENSE()

If nothing else comes up I'll take the SPDX tag as expressing your preferences
and add the missing macro.  Please do shout if you'd prefer something else!

Please check the reset of sashiko though.  I'm not sure on the firmware
related ones (new I think?) and have to much of a backlog to go digging
today.

I might comment on some of the others as I take a fresh look

Jonathan



> diff --git a/drivers/iio/test/iio-test-channel-prefix.c b/drivers/iio/test/iio-test-channel-prefix.c
> new file mode 100644
> index 000000000000..d049e4222c40
> --- /dev/null
> +++ b/drivers/iio/test/iio-test-channel-prefix.c
> @@ -0,0 +1,304 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Unit tests for IIO channel prefix generation.
> + */

...

> +MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
> 

