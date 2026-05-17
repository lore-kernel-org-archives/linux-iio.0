Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC22A271A9A;
	Sun, 17 May 2026 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779026205; cv=none; b=ofiIUZx7+Ks6Z6Dr+38jSz2mrbeeCMPCVL462UBeXchpNud5vzpaoagNZ+j9Dlj6x1E7ODY34/Tn3JfxFtOKvFa5oa6QJ+XW9uuZqnHHWEVYD86kveX+7DAoXHnNFpsJol/OTUm2BO8NyrldDhJ4vMVSqggF6ZzOAmijgRYBThc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779026205; c=relaxed/simple;
	bh=9pw5JTw6G97xFjOedb4spNmJ+2MxCNoMr3BAaGSuHGk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yq8mFGc1tPsOoRhzFiiI4yswN+N6UhJBA6EJlU2boZ8jb3teT5kF7H7yZI67FY6Gmh2lWQsCuh3xwc1FYBtWefo3VKn1GMVscg0dOqp2JH14uJhaqcjpjAvtDHk0gaGySg3mxhMvKvQwbE54bUGBSQOgdGuNQ6rlHuj9giabKJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YetHbIw2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YetHbIw2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C4FC2BCB8;
	Sun, 17 May 2026 13:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779026205;
	bh=9pw5JTw6G97xFjOedb4spNmJ+2MxCNoMr3BAaGSuHGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YetHbIw2TZhwvnv4I30ebE86nX1o/J6p0V03Zwx38nteCW1PAbjzSsI2npzSXn2Gf
	 PCHHEubLFfL4TC0mZDGfuCeUklNut6C5JnR14nnmG94wJa7qZiADOcmhlqskLth3SG
	 r3oDLRUp6ck326ZsQafYcccnO3fL0w9LSnPKiD6/fhmftqHAb3GPh+ZiwVqHAie9QH
	 +1oKWjbDfZlh4fDbpKGL0nbbHZGL5iP3Bm8DbPgi/5GPYMYZCAL4CwZjD61vMCD0A7
	 JKrHd//3AyRfSjjtGcPy4Nxo/nIOvk6NCsfCediv0KFX/BKOmvAolS0j5v2ODL/v93
	 /uI+DjxsS7TMw==
Date: Sun, 17 May 2026 14:56:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v13 07/12] iio: test: iio-test-format: add test case for
 decimal format
Message-ID: <20260517145632.0cfa0d55@jic23-huawei>
In-Reply-To: <20260517-adf41513-iio-driver-v13-7-bb6e134a360f@analog.com>
References: <20260517-adf41513-iio-driver-v13-0-bb6e134a360f@analog.com>
	<20260517-adf41513-iio-driver-v13-7-bb6e134a360f@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 10:14:02 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add iio_test_iio_format_value_decimal_64() kunit test case for decimal
> value formatting, exploring different scales types. Also, the same
> iio_val_s64_array_populate() macro used to populate local array is used in
> iio_test_iio_format_value_integer_64().
Sashiko calls out that this needs an update. Doesn't seem to use iio_val_s64_array_populate()

No other comment. Context left so anyone reading this can check for themselves
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/test/iio-test-format.c | 97 +++++++++++++++++++++++++++++---------
>  1 file changed, 75 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/test/iio-test-format.c b/drivers/iio/test/iio-test-format.c
> index 872dd8582003..1920dee3bfb0 100644
> --- a/drivers/iio/test/iio-test-format.c
> +++ b/drivers/iio/test/iio-test-format.c
> @@ -200,56 +200,108 @@ static void iio_test_iio_format_value_multiple(struct kunit *test)
>  static void iio_test_iio_format_value_integer_64(struct kunit *test)
>  {
>  	int values[2];
> -	s64 value;
>  	char *buf;
>  	int ret;
>  
>  	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
>  
> -	value = 24;
> -	values[0] = lower_32_bits(value);
> -	values[1] = upper_32_bits(value);
> +	iio_val_s64_to_s32s(24, values);
>  	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
>  	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "24\n");
>  
> -	value = -24;
> -	values[0] = lower_32_bits(value);
> -	values[1] = upper_32_bits(value);
> +	iio_val_s64_to_s32s(-24, values);
>  	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
>  	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-24\n");
>  
> -	value = 0;
> -	values[0] = lower_32_bits(value);
> -	values[1] = upper_32_bits(value);
> +	iio_val_s64_to_s32s(0, values);
>  	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
>  	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0\n");
>  
> -	value = UINT_MAX;
> -	values[0] = lower_32_bits(value);
> -	values[1] = upper_32_bits(value);
> +	iio_val_s64_to_s32s(UINT_MAX, values);
>  	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
>  	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "4294967295\n");
>  
> -	value = -((s64)UINT_MAX);
> -	values[0] = lower_32_bits(value);
> -	values[1] = upper_32_bits(value);
> +	iio_val_s64_to_s32s(-((s64)UINT_MAX), values);
>  	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
>  	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-4294967295\n");
>  
> -	value = LLONG_MAX;
> -	values[0] = lower_32_bits(value);
> -	values[1] = upper_32_bits(value);
> +	iio_val_s64_to_s32s(LLONG_MAX, values);
>  	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
>  	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9223372036854775807\n");
>  
> -	value = LLONG_MIN;
> -	values[0] = lower_32_bits(value);
> -	values[1] = upper_32_bits(value);
> +	iio_val_s64_to_s32s(LLONG_MIN, values);
>  	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
>  	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-9223372036854775808\n");
>  }
>  
> +static void iio_test_iio_format_value_decimal_64(struct kunit *test)
> +{
> +	int values[2];
> +	char *buf;
> +	int ret;
> +
> +	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
> +
> +	/* DECIMAL64_MILLI: positive >= 1, value 1.234 */
> +	iio_val_s64_to_s32s(1234, values);
> +	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MILLI, ARRAY_SIZE(values), values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.234\n");
> +
> +	/* DECIMAL64_MICRO: positive >= 1, value 3.141592 */
> +	iio_val_s64_to_s32s(3141592, values);
> +	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MICRO, ARRAY_SIZE(values), values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "3.141592\n");
> +
> +	/* DECIMAL64_MILLI: positive < 1, value 0.042 */
> +	iio_val_s64_to_s32s(42, values);
> +	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MILLI, ARRAY_SIZE(values), values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.042\n");
> +
> +	/* DECIMAL64_MILLI: negative <= -1, value -1.234 */
> +	iio_val_s64_to_s32s(-1234, values);
> +	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MILLI, ARRAY_SIZE(values), values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1.234\n");
> +
> +	/* DECIMAL64_MILLI: negative > -1, value -0.123 */
> +	iio_val_s64_to_s32s(-123, values);
> +	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MILLI, ARRAY_SIZE(values), values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.123\n");
> +
> +	/* DECIMAL64_MILLI: zero */
> +	iio_val_s64_to_s32s(0, values);
> +	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MILLI, ARRAY_SIZE(values), values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000\n");
> +
> +	/* DECIMAL64_NANO: value 1.000000001 */
> +	iio_val_s64_to_s32s(1000000001, values);
> +	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_NANO, ARRAY_SIZE(values), values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.000000001\n");
> +
> +	/* DECIMAL64_MICRO: large value using upper 32 bits */
> +	iio_val_s64_to_s32s(5000000000000042LL, values);
> +	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MICRO, ARRAY_SIZE(values), values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "5000000000.000042\n");
> +
> +	/* limits */
> +	iio_val_s64_to_s32s(LLONG_MAX, values);
> +	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_PICO, ARRAY_SIZE(values), values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9223372.036854775807\n");
> +	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_NANO, ARRAY_SIZE(values), values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9223372036.854775807\n");
> +	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MICRO, ARRAY_SIZE(values), values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9223372036854.775807\n");
> +
> +	iio_val_s64_to_s32s(LLONG_MIN, values);
> +	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_PICO, ARRAY_SIZE(values), values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-9223372.036854775808\n");
> +	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_NANO, ARRAY_SIZE(values), values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-9223372036.854775808\n");
> +	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MICRO, ARRAY_SIZE(values), values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-9223372036854.775808\n");
> +}
> +
>  static struct kunit_case iio_format_test_cases[] = {
>  		KUNIT_CASE(iio_test_iio_format_value_integer),
>  		KUNIT_CASE(iio_test_iio_format_value_fixedpoint),
> @@ -257,6 +309,7 @@ static struct kunit_case iio_format_test_cases[] = {
>  		KUNIT_CASE(iio_test_iio_format_value_fractional_log2),
>  		KUNIT_CASE(iio_test_iio_format_value_multiple),
>  		KUNIT_CASE(iio_test_iio_format_value_integer_64),
> +		KUNIT_CASE(iio_test_iio_format_value_decimal_64),
>  		{ }
>  };
>  
> 

