Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C906A3515EB;
	Sun, 20 Sep 2026 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789926525; cv=none; b=cYT/VkYn6f2Lqceok79CoitSNXCOiSXXTDQLj/i7bgB2sUXQ8ucqZko1NIJKPAgLjEcseDC+ePASgDcgKAuzeHYt4zJdh4WWX09hvR0ZsmNsNeCWPPiY/t7LHa5hKegdgTu6z9RK/iyVFlIl7K7fYdO3TjRQNmRV6AMLm4egblg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789926525; c=relaxed/simple;
	bh=ZSp9cPhLXqk0gMNF2vxZ4/V/4ovuJA8EYMg0ikdaBH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GoXnS9eA7qgr00pKRlKwJONBtUUp+7YKOlsjsgI82TrxSp36ZZ5llwaEow99HmSsRmUxi3D2+ar+PtbZBk9d+3ZvIhPwfkTVNZhhAxzUc8Af1aSd4WektCtoq9ZBkSDl06TAbsJdsAomPwUEiiSPYIrH4YmWCoIcV3lMqE4BRY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwML+czH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwML+czH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE5E1F000FF;
	Sun, 20 Sep 2026 17:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789926523;
	bh=KwRQA3be4ONm7rVan1uRGscgGvuBIhdC4tlpxcuo80Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FwML+czHKqjkthxIT7v2pmpZpoG/03VH+0JpEfbtdPnG187b8Tc3nchPnKGkT+Dvf
	 VrBSWL2s7eiorifPRTorLoigzeXwzQbkAyiT0pP3r2I/rJyUSDJAVDqLsfUv/rAlXi
	 wxASvK1dwrTw8yF5DkfDb6/C8RFKP3zcj618NzR1kFW52E5y8PWXj/Igt+B541P7tp
	 p+D9VtmJfJ2dLwyCrJ+vp/JYfSO18AfWh33C4fU/ANrRpkhaJ7UG4OnFoAQZeGOVgW
	 /1L9ClrrDHiMeclOMYhE/aOFb3Yw89I2zD1V6pSkTgsh7K/AFS4IUCvFC5iKO9xcF0
	 9LXhoVRm1IUlA==
Date: Sun, 20 Sep 2026 18:48:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jaakko Koivisto <jmatko@utu.fi>
Cc: Andreas Klinger <ak@it-klinger.de>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: chemical: sgp40: Implement
 execute_self_test-command
Message-ID: <20260920184837.2b2ca5dd@jic23-hlaptop>
In-Reply-To: <20260918134019.1101308-3-jmatko@utu.fi>
References: <20260918134019.1101308-1-jmatko@utu.fi>
	<20260918134019.1101308-3-jmatko@utu.fi>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 16:40:18 +0300
Jaakko Koivisto <jmatko@utu.fi> wrote:

> -Run the chip self test routine testing heater and MOX -material.
> -Log error if the test fails.
> 
> Datasheet does not clearly state if the chip is completely unusable if
> the test fails. Because of this the driver will try to use the chip
> normally even if the self-test has failed.
> 
> Signed-off-by: Jaakko Koivisto <jmatko@utu.fi>
Hi Jaakko,

A few things inline,

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/sgp40.c | 53 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
> index c1e2a992ec2a..28d5e737d1dc 100644
> --- a/drivers/iio/chemical/sgp40.c
> +++ b/drivers/iio/chemical/sgp40.c
> @@ -84,6 +84,19 @@ struct sgp40_serial_number_result {
>  	u8	C_crc;
>  } __packed;
>  
> +/*
> + * Datasheet table 13.
> + */
> +#define SGP40_SELF_TEST_PASS 0xD4
> +#define SGP40_SELF_TEST_FAIL 0x4B
> +
> +struct sgp40_self_test_result {
> +	u8	data;
> +	u8	_ignore;
> +	u8	crc;
> +} __packed;
> +
> +
>  static const struct iio_chan_spec sgp40_channels[] = {
>  	{
>  		.type = IIO_CONCENTRATION,
> @@ -210,6 +223,42 @@ static int sgp40_get_serial_number(struct sgp40_data *data)
>  	return 0;
>  }
>  
> +static int sgp40_execute_self_test(struct sgp40_data *data)
> +{
> +	int ret;
> +	struct i2c_client *client = data->client;
> +	struct sgp40_command run_test = {.command = {0x28, 0x0E}};
> +	struct sgp40_self_test_result res;
> +
> +	ret = i2c_master_send(client, (char*)&run_test, sizeof(run_test.command));
> +	if (ret != sizeof(run_test.command)) {
> +		dev_err(data->dev, "i2c_master_send ret: %d, expected %zu", ret, sizeof(run_test.command));
> +		return -EIO;
Only called from problem so prefer use of

		return dev_err_probe().

Also don't eat the error if it returns on (rather than a short access).


> +	}
> +	msleep(320);

Spec reference needed for any sleep times.

> +
> +	ret = i2c_master_recv(client, (char*)&res, sizeof(res));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(res)) {
> +		dev_err(data->dev, "i2c_master_recv ret: %d, expected: %zu", ret, sizeof(res));
> +		return -EIO;

return dev_err_probe() and don't eat the error return if there is one.

> +	}
> +
> +	if (crc8(sgp40_crc8_table, (u8*)&res, 2, SGP40_CRC8_INIT) != res.crc) {
> +		dev_warn(data->dev, "CRC error in execute_self_test");

CRC fail indicates broken comms. I'd fail hard on this one.

> +	}
> +
> +	dev_dbg(data->dev, "self test result: 0x%x", res.data);
> +	switch (res.data) {
> +		case SGP40_SELF_TEST_PASS:
> +			return 0;
> +		case SGP40_SELF_TEST_FAIL:
> +		default:
> +			return res.data;
> +	}
> +}
> +
>  static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *resistance_raw)
>  {
>  	int ret;
> @@ -421,6 +470,10 @@ static int sgp40_probe(struct i2c_client *client)
>  	if (ret)
>  		dev_warn(dev, "failed to retrieve device serial number\n");
>  
> +	ret = sgp40_execute_self_test(data);
> +	if (ret)
> +		dev_warn(dev, "device self test failed: ret 0x%x", ret);

There should be a distinction between the test failed to run and failed to pass.
For failing to run (e.g. comms error) then fail the probe.  Failing to pass
the test is what you might choose to carry on from.

> +
>  	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret)
>  		dev_err(dev, "failed to register iio device\n");

