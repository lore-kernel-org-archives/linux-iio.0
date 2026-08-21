Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A5C30567F;
	Fri, 21 Aug 2026 01:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787274361; cv=none; b=dxbmgeyjIv66FydWJkl6bFeFOtw0fwFniytV92EZ89xjuo0kkK3jXSmgMpC/ZbKthQs4VYsU9L3/nl8cfzLV2IaGvtOLL7v6UDk3Tu9TtFmkBU0uRICE2ZQtmjdAZB3NWSyI0PqIfWmYlbsYlhsG0oOivVPDS35zaojNoYF3EY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787274361; c=relaxed/simple;
	bh=udaryJUcp8UdssJGzhUZGUIih5Ea0c9CzGIQRVHV+qc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxFfLnSTf+jCwUQMaz5kp7J40NmNEl8C3Od5zpU2CDmGutJORj1QLrjP6vuDC23IvMINrFoySXwebw8Z+o2icORJT2NEDaXk5hd+bnZqPKizksH61gItwWF9ShWwxyLX2N3pskyms68zfleWSqH2sh35gQz6v8WADXtW8QmCt4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iriXPoLn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iriXPoLn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727E01F000E9;
	Fri, 21 Aug 2026 01:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787274359;
	bh=qhLLGEoOi7ada+Zo30jFrSFyWDbuv7FW4DzLZkTkVuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iriXPoLnQuYwNjI8VN9Sx9CkTHr4WMQ9p4pbtDlHOBBMOVY15Z1LI+77NdI0K9WXB
	 G4Ar6dc6z5lqdjCW54bewNOE5gEfS7dezsxYbHEZHh0CFnRGrnU9521nNi+8NFuQgy
	 UPQZMuoX+kxwgPTlcT37bQh6E/Ixx20ORPiVNddFD7t9P6r1pDUe6pl+mIjyZRErcK
	 r31ZKg+4JiNYyD7wgNc2ooEkYmgEyAWrs3ZLC3kd0TSJIlpe9oUIL6b84wrr9vpI32
	 NXKcJb+vP68KFuo76mQ8pgg0PvWb217P3j39WWN64uFevScDFq10fyRx+wsrq02JSf
	 8ePk8Gp+bnXvA==
Date: Fri, 21 Aug 2026 02:05:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Brian Masney
 <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: frequency: adf4377: Fully initialize
 clk_init_data and clk_parent_data
Message-ID: <20260821020554.23fa7d19@jic23-huawei>
In-Reply-To: <ae48ed1dc6b1ad9e10cad0d9df28d9fab213f653.1787216909.git.geert+renesas@glider.be>
References: <ae48ed1dc6b1ad9e10cad0d9df28d9fab213f653.1787216909.git.geert+renesas@glider.be>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 11:19:52 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> adf4377_clk_register() fills in init.parent_data, and assumes that
> init.parent_names is NULL.  However, the latter is uninitialized, and
> thus may cause a crash.
> 
> Similarly, adf4377_clk_register() fills in only parent_data.fw_name,
> leaving other members of the clk_parent_data structure uninitialized.
> 
> Make sure all members are fully initialized, to fix such bugs, and to
> avoid future breakage when converting drivers to a different method for
> specifying the parents.
> 
> Fixes: 60e5448ddbec2dc2 ("iio: frequency: adf4377: add clk provider support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
Dropped v1 and picked this up, marking it for stable and tweaking a little
to add spaces { } 
That's an IIO specific style choice.

Thanks

Jonathan

> Compile-tested only.
> 
> v2:
>   - Extract from series "[PATCH treewide 0/5] clk: Make sure
>     clk_init_data is fully initialized (part 1)"
>     (https://lore.kernel.org/cover.1787165329.git.geert+renesas@glider.be),
>   - Fully initialize clk_parent_data too, as pointed out by Sashiko.
> ---
>  drivers/iio/frequency/adf4377.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
> index 4dd19a9aa9943c57..b8c31665857c5201 100644
> --- a/drivers/iio/frequency/adf4377.c
> +++ b/drivers/iio/frequency/adf4377.c
> @@ -988,10 +988,10 @@ static const struct clk_ops adf4377_clk_ops = {
>  
>  static int adf4377_clk_register(struct adf4377_state *st)
>  {
> +	struct clk_parent_data parent_data = {};
>  	struct spi_device *spi = st->spi;
>  	struct device *dev = &spi->dev;
> -	struct clk_init_data init;
> -	struct clk_parent_data parent_data;
> +	struct clk_init_data init = {};
>  	int ret;
>  
>  	if (!device_property_present(dev, "#clock-cells"))

