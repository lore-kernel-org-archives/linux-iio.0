Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A6D245020;
	Sat,  5 Sep 2026 01:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788571914; cv=none; b=g/zjO5qBjFdb0CZeuGRcrUZXVRLB4x3yrPU3nVtrM8PhK1w9sY/IIxLqQRwvWw9KoGyvgHloGy795dF69NiVLV3XhTQOqYKfQO5baFCL0HcACVYJNwoJ9ncHmC5d5qYRly4aPmqI0V4D2PJPi1kGbVi3uqt94bGOA8gtGk0hdxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788571914; c=relaxed/simple;
	bh=dQ+iMzGQujr1wMp3y+oQef4ll45dw99ZPy0bdSro3j8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KAVQens3zlLVbxOvnlY6FN4OjNXmJjTwtcSoLrDJrnuDcYUo4hsQyRlYX5qrKeLlk+gBUkYCnIjqpIm4jANWJ73kJMO2NrxWq+pXz4Lgloz5dEhMzk1mb9zzGW91AB8NONw297nTbY/i+sRWyOK7wNEE6kAO2lmwCXueQoDutcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvPyPeXb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvPyPeXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C419F1F00A3D;
	Sat,  5 Sep 2026 01:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788571912;
	bh=1dIzkHmMftwvydeIU/+1JhlMCWhKPntxvGcUwLCu+H4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TvPyPeXb6ybBZRSdkj2vGuE+IY/eGSMyy1mal7oC09tb35q1uXD7ls7QV0yH6q6wi
	 IEz5/RmCfKNJzRYZzEVOdScGlnNT2CylvwaBKIqSopyPpFs5x+C7Ebg7NeSsgdQtzr
	 IywzsLmRnAOlPM8gHLwIROIfSQdjE+bBGOFn2HPaw1rLzjsS0UIvAvCrSwov5tvG9w
	 Vuj/3Zb1zCtqTmYPX+v0Du59YnHuSXXaxlRhRkyJVqGTnBrWWYalcfJt9hJdqbVVBI
	 6uzbD8lVkfciK3b+gOsLTfrOZIPFOdMWUgxesK7i22vcgJh0H9r+/6f0JtdT81twZr
	 0cUlSkwws1V4Q==
Date: Sat, 5 Sep 2026 02:31:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Maxwell Doose <maxwell@maxwelld.cc>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Li Youhong <dayou5941@163.com>, Li Youhong
 <liyouhong@kylinos.cn>, Brendan Higgins <brendan.higgins@linux.dev>, David
 Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 2/2] iio: flow: slf3s: add KUnit tests for the PM
 regulator balance
Message-ID: <20260905023147.006d181c@jic23-huawei>
In-Reply-To: <20260904-iio-slf3s-pm-regulator-kunit-v1-2-5ea61e6d6db2@gmail.com>
References: <20260904-iio-slf3s-pm-regulator-kunit-v1-0-5ea61e6d6db2@gmail.com>
	<20260904-iio-slf3s-pm-regulator-kunit-v1-2-5ea61e6d6db2@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 04 Sep 2026 21:24:26 +0200
Wadim Mueller <wafgo01@gmail.com> wrote:

> Bind the driver to an emulated SLF3S on a fake I2C adapter, back it with
> a regulator whose enable and disable callbacks are counted, and check
> that the two stay paired across suspend and resume - including the cycles
> in which the sensor NACKs a command or the supply refuses to come up.
> 
> The suspend/resume helpers reproduce the PM core's rule that a resume
> callback only runs after a suspend callback that returned 0, so that the
> tests cannot construct an ordering the core never produces.  One of the
> tests relies on it: it cycles the device ten times with rotating failure
> injection and asserts that the driver's enable count never climbs above
> one.
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>

Interesting approach to testing the flows.
I'm not sure we want to carry this level of testing for a driver in the
tree. Would like to hear the views of others on this.

There is some really nice stuff in here.  Makes me wonder if we should
build a specific test device + driver that would hit all the widest possible
set of corner cases that aren't device specific.  The one slightly unusual
thing for this device is the error on telling to stop when it is already stopped.

A couple of things I noted whilst taking a first look.
I'll want to take some time when I'm a lot more awake than I am today
to look at this closely.

Thanks!

Jonathan

> diff --git a/drivers/iio/flow/slf3s-kunit.c b/drivers/iio/flow/slf3s-kunit.c
> new file mode 100644
> index 000000000000..d5e2db855838
> --- /dev/null
> +++ b/drivers/iio/flow/slf3s-kunit.c
> @@ -0,0 +1,734 @@


> +
> +static void slf3s_fake_put_word(struct slf3s_fake *f, u8 *dst, u16 val)
> +{
> +	dst[0] = val >> 8;
> +	dst[1] = val & 0xff;

Use a put_unaligned_be16() for this.

> +	dst[2] = crc8(f->crc_table, dst, 2, SLF3S_TEST_CRC8_INIT);
> +}
> +static int slf3s_test_init(struct kunit *test)
> +{
> +	struct regulator_consumer_supply *supply;
> +	struct regulator_init_data *init_data;
> +	struct i2c_board_info info = { };
> +	struct regulator_config config = { };
> +	struct slf3s_test_ctx *ctx;
> +	struct device *parent;
> +	char *consumer;
> +	int ret;
> +
> +	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, ctx);
> +	test->priv = ctx;
> +
> +	/* Actions run in reverse, so destroy after the unbind takes the locks. */
> +	mutex_init(&ctx->fake.lock);
> +	ret = kunit_add_action_or_reset(test, slf3s_test_destroy_mutex,
> +					&ctx->fake.lock);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	mutex_init(&ctx->reg.lock);
> +	ret = kunit_add_action_or_reset(test, slf3s_test_destroy_mutex,
> +					&ctx->reg.lock);
> +	KUNIT_ASSERT_EQ(test, ret, 0);

Given those are deep in the emulation which is not what we are testing, do
we need to bother with the mutex destroy calls?  That is only there
for some debugging of locks that isn't relevant here I think.

> +
> +	crc8_populate_msb(ctx->fake.crc_table, SLF3S_TEST_CRC8_POLY);
> +	ctx->fake.state = SLF3S_FAKE_OFF;
