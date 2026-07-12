Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E033A1DB;
	Sun, 12 Jul 2026 01:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783818577; cv=none; b=IsuCVgLnhq2iFkVrsTyWXn6zBh887cK6LjaYIRwVzzMEb81Ofgq7W4mwaW3kNCvpiJUh/Xcj1Dy6632hsXvVpo3I8433q2oC7Mb1Xr0SfdzOv2H7dzzmWgIega7jRQDUbBktNmph/9T8akz95OTHqnjVigdZR/uebKKkTepoY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783818577; c=relaxed/simple;
	bh=zgsq7ksmLXMwnjGSc3Zg05Gom7z3jnDTOWKdYBntalE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZt0xT7WlcdSLimWifzt4gcldJSPFvblRjL6xQt8esBB8x3cAiGNizKkJGxuad+hPWV6/fvocY523Gm8DnAyliDUlMjEyMisNg7ReMkfuoEb7MftLbDFHzqUBS34OhvFZopGVyAvQFfYMi4B1KxeAbBP+pRPU+gVWP13Rv668hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AR0zp0IW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AR0zp0IW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26311F000E9;
	Sun, 12 Jul 2026 01:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783818575;
	bh=a4NR1xDscBDlZ0GApbTFdU7gV1iwXoXipjI63baH680=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AR0zp0IWwJWR07kN+I6zMpqx37y24TI/B7OjRfDZ2G/Wfvc4O5aMNJ15p8vWaIUXN
	 umgNnX9MRKqhySn6o0YAukec2GacuEGc6iXv501rIwCMnX9ZWLSvJdoEeDxpFcyO9A
	 5k1eCAmV4Kj0uDX9kiAs1MvMNzDqEuzGrvi7VHRN9+bddEuSpHIvkggerVbowoTWxI
	 0YrjUGMJiW2fqj3huPQEq4vuzYySSGzPALMEJchn4MqqIjipJweVHlaeA1CVI3WIGq
	 aT7PGxtGGTvTc5p2CPfj1n3uVd1TjlP8LUaHGH+6jtLShV9WWEZ3q7si+rGrxLmA0h
	 sIj5dkRRkAbTA==
Date: Sun, 12 Jul 2026 02:09:28 +0100
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
Subject: Re: [PATCH v7 07/17] iio: test: add kunit tests for channel prefix
 naming generation
Message-ID: <20260712020928.2c8d1667@jic23-huawei>
In-Reply-To: <20260707-ad9910-iio-driver-v7-7-a4ec30f63700@analog.com>
References: <20260707-ad9910-iio-driver-v7-0-a4ec30f63700@analog.com>
	<20260707-ad9910-iio-driver-v7-7-a4ec30f63700@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 07 Jul 2026 15:04:28 +0100
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
> Because __iio_chan_prefix_emit() is static, the test translation unit
> is pulled into industrialio-core.c.

Isn't there some magic route cases like this that makes it non static
only when self tests are enabled? 
Claude tells me to look at include/kunit/visibility.h


Very nice.  A couple of really small additions requested inline.
I might well have missed where you exercised the corners requested though!
+ I'll need an Ack from Lars for that maintainers entry. I'll guess that
Lars won't give one as not very active at the moment in this area.

Jonathan

> 
> Also, an entry is created under MAINTAINERS dedicated to tests for IIO
> core helpers.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  MAINTAINERS                                |   8 +
>  drivers/iio/industrialio-core.c            |   4 +
>  drivers/iio/test/Kconfig                   |  14 ++
>  drivers/iio/test/iio-test-channel-prefix.c | 246 +++++++++++++++++++++++++++++
>  4 files changed, 272 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b1ec46c5919..57ffc0dcfdb6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12634,6 +12634,14 @@ F:	include/dt-bindings/iio/
>  F:	include/linux/iio/
>  F:	tools/iio/
>  
> +IIO CORE KUNIT TESTS
> +M:	Lars-Peter Clausen <lars@metafoo.de>

I'd need an Ack from Lars for this entry.   If we don't get one are you
fine looking after this without Lars listed?  

> +M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/test/iio-test-channel-prefix.c
> +F:	drivers/iio/test/iio-test-format.c
> +
>  IIO UNIT CONVERTER
>  M:	Peter Rosin <peda@lysator.liu.se>
>  L:	linux-iio@vger.kernel.org
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index ecc69adf61de..78a3c27d17a1 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -2232,6 +2232,10 @@ EXPORT_SYMBOL_GPL(iio_device_get_current_mode);
>  subsys_initcall(iio_init);
>  module_exit(iio_exit);
>  
> +#if IS_ENABLED(CONFIG_IIO_CHANNEL_PREFIX_KUNIT_TEST)
> +#include "test/iio-test-channel-prefix.c"
> +#endif

> +
>  MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
>  MODULE_DESCRIPTION("Industrial I/O core");
>  MODULE_LICENSE("GPL");

> diff --git a/drivers/iio/test/iio-test-channel-prefix.c b/drivers/iio/test/iio-test-channel-prefix.c
> new file mode 100644
> index 000000000000..e6f2739331f2
> --- /dev/null
> +++ b/drivers/iio/test/iio-test-channel-prefix.c

> +
> +static void iio_test_prefix_shared_by_all(struct kunit *test)
> +{
> +	const struct iio_chan_spec chan = {
> +		.type = IIO_VOLTAGE,

I'd throw some stuff that won't be used in here.  Maybe even have
two different ones where we ignore things and then end up with the
same answer?  Same for the other ones where fields are ignored.

Obviously it is a bit of a dead chicken test (wave it around
and if still dead, all good :) so only really illustrates that
typically there is more stuff there that gets ignored.


> +	};
> +	char *buf = iio_test_prefix_alloc(test);
> +	ssize_t ret;
> +
> +	ret = __iio_chan_prefix_emit(NULL, &chan, IIO_SHARED_BY_ALL,
> +				     buf, PREFIX_BUF_SIZE);
> +	EXPECT_PREFIX(test, buf, ret, "");
> +}

> +static void iio_test_prefix_separate_modified(struct kunit *test)
> +{
> +	const struct iio_chan_spec chan = {
> +		.type = IIO_ACCEL,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_X,
> +	};
> +	char *buf = iio_test_prefix_alloc(test);
> +	ssize_t ret;
> +
> +	ret = __iio_chan_prefix_emit(NULL, &chan, IIO_SEPARATE,
> +				     buf, PREFIX_BUF_SIZE);
> +	EXPECT_PREFIX(test, buf, ret, "in_accel_x");

I think it is worth one indexed + modified test

> +}
> +
> +static void iio_test_prefix_separate_extend_name(struct kunit *test)
> +{
> +	const struct iio_chan_spec chan = {
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.channel = 2,
> +		.extend_name = "supply",
> +	};
> +	char *buf = iio_test_prefix_alloc(test);
> +	ssize_t ret;
> +
> +	ret = __iio_chan_prefix_emit(NULL, &chan, IIO_SEPARATE,
> +				     buf, PREFIX_BUF_SIZE);
> +	EXPECT_PREFIX(test, buf, ret, "in_voltage2_supply");
> +}
> +
> +static void iio_test_prefix_output_separate(struct kunit *test)
> +{
> +	const struct iio_chan_spec chan = {
> +		.type = IIO_VOLTAGE,
> +		.output = 1,
> +		.indexed = 1,
> +		.channel = 0,
> +	};
> +	char *buf = iio_test_prefix_alloc(test);
> +	ssize_t ret;
> +
> +	ret = __iio_chan_prefix_emit(NULL, &chan, IIO_SEPARATE,
> +				     buf, PREFIX_BUF_SIZE);
> +	EXPECT_PREFIX(test, buf, ret, "out_voltage0");
> +}
