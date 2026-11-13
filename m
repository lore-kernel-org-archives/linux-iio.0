Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794534834;
	b=bLLMxXDtukp9qxw/EvevosRA7tDTRujdKHwuC20sv7lQvTsTZciGhujGGu8AFsP8csnC
	 wieQx+Tt5eISLR51zwroCiHnsixNEkK0x4GjH46LIreb8QFwMe7fz87dABom56sTKyTaD
	 91+7ZWgQZjcGEtw9VN0kVPz5HRvIgHuhLr+gBTQgcb2AZ+ykOzv44+QsF8+VOButbX7gd
	 vM+pei25ch18cWcuXccSpWslBh6WpMjKrEjTDjspT5FYb00jfmr6tVbTIN4lVLK+k5Vki
	 EEq1s1C2/VIEpAx03UkSm4vq3pxuQ1NeIXpfgCW1KPCrGW3Ck6Po/iSjnc5Pskl/JPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794534834;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DJGW9+6zznTnsyPYZZe/qVXufV83u2YocM25E6tMsGc=;
	b=4sQ2yGHnaUrxKXcLS928kzVhkzImJiolSa4C81zajld557v7Y4Fb3pvg9/i/LbtZGSMW
	 l61DI+nD3ecbnt5BNjqAXULnhz60e4Apbn2BODXEuwpj/IsxBwlfIgcBSQKbE+z0n2qxG
	 WnQIzNgsxU4umoTDNfYEkvt/6tgAJzX+ZgcikVk8igNI3b6O5/ZdlJCXAqv1DGUw8xCpW
	 0GA7/YWPMLYhUFbr6bCJuOtl07uUKhWNbq420kQN6NNrIhU4g6vNae0GTMA23Ma8JxzLZ
	 ZZ8x1M7pwhNsyQvsyTB2FFMS2LZUisI3eHvAIrIqx1iOjq7CSJ6B3JNxHH0SvYKe7lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G+c7WqgT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95A4606A31C;
	Fri, 13 Nov 2026 01:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G+c7WqgT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E700E1F000C4;
	Fri, 13 Nov 2026 01:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794534834;
	bh=DJGW9+6zznTnsyPYZZe/qVXufV83u2YocM25E6tMsGc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G+c7WqgTV6j00Wcllc5IjpzxFwZEPNBztFkyixxZAYsI5bl96nLbmBxtY+D/a1Fvl
	 NvgGUrKnLRdqKb3YfItix7EGTbEA/cZGvSsRuXmbh5eN7acwd3VwmwLIeQzMEdKrte
	 MXH4ygAiIaKaI/RV27ChUX/sg2fqSYs3uiNHS6JGuNlDXdyCVOryq1G4jCKbz8llRa
	 /0Ezhwn2UvfUW+J9GGJynG39Njnq2IJo8/8sFXItdpt+anyKooIIXugbbqNV9B557Y
	 j0k7WAfiGL90ri/MdMPqhqjqWGdWwvp940nf6gYnV5yMs3drh4d36V0tAUjXetrFU3
	 5ovpanT3IdbAw==
Date: Fri, 13 Nov 2026 01:53:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Gwendal Grignou <gwendal@chromium.org>,
 Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: proximity: sx9360: reject out-of-range
 hardware gain values
Message-ID: <20261113015348.75a452bb@jic23-hlaptop>
In-Reply-To: <20261111164041.341776-3-kapoorarnav43@gmail.com>
References: <20261111164041.341776-1-kapoorarnav43@gmail.com>
	<20261111164041.341776-3-kapoorarnav43@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 22:10:37 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> sx9360_write_gain() passes the value from userspace to ilog2() and then
> FIELD_PREP() into the 3-bit PROX_CTRL0 gain field without checking it,
> so some values silently program a gain unrelated to the one requested,
> and the write still reports success:
> 
>   - 16 to 255 write gain codes 4 to 7, which the driver does not
>     advertise, and the next read reports gains of 16 to 128;
>   - 256 and larger wrap around in the field, e.g. 256 sets a gain of 1;
>   - 0 and negative values write code 7 (read back as 128), because
>     ilog2(0) is -1 and a negative int becomes a large unsigned value.
> 
> Return -ERANGE for values <= 0 and for values above the gain of 8 code.
> FIELD_FIT() is not enough here, as the field also holds codes 4 to 7,
> which the driver doesn't support. Values between the supported gains
> of 1, 2, 4 and 8 are still rounded down, as before.
> 
> Fixes: 1cdb4c47f7f5 ("iio:proximity:sx9360: Add sx9360 support")
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
The whole off by one thing you had an RFC for can be handled
on top of this which is just making sure existing values actually
fit etc.

Applied to the testing branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/sx9360.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
> index 2a9b37df8f62..22b6b751c0a3 100644
> --- a/drivers/iio/proximity/sx9360.c
> +++ b/drivers/iio/proximity/sx9360.c
> @@ -68,6 +68,7 @@
>  #define SX9360_REG_PROX_CTRL0_PHM	0x41
>  #define SX9360_REG_PROX_CTRL0_GAIN_MASK	GENMASK(5, 3)
>  #define SX9360_REG_PROX_CTRL0_GAIN_1		0x80
> +#define SX9360_REG_PROX_CTRL0_GAIN_8		0x3
>  #define SX9360_REG_PROX_CTRL0_RAWFILT_MASK	GENMASK(2, 0)
>  #define SX9360_REG_PROX_CTRL0_RAWFILT_1P50	0x01
>  #define SX9360_REG_PROX_CTRL1		0x42
> @@ -625,7 +626,13 @@ static int sx9360_write_gain(struct sx_common_data *data,
>  {
>  	unsigned int gain, reg;
>  
> +	if (val <= 0)
> +		return -ERANGE;
> +
>  	gain = ilog2(val);
> +	if (gain > SX9360_REG_PROX_CTRL0_GAIN_8)
> +		return -ERANGE;
> +
>  	reg = SX9360_REG_PROX_CTRL0_PHR + chan->channel;
>  	gain = FIELD_PREP(SX9360_REG_PROX_CTRL0_GAIN_MASK, gain);
>  

