Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6870F1F94F;
	Mon, 13 Jul 2026 01:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783905650; cv=none; b=XGORsFC3Ril7WQm6FX116QJ1PGVw5GXm9any+MJdqmkzUTMbstUy42ADA7ozhNXGuXl6MloTOXiUN7EUqHmRTO1NgFT7SbtJiQMg/ePnD/4r8xaTTrzt4xL1E36sZ/DwmDWnnc/aSGSr2xdzsqVHGEaPbSkRA8ORULPFAWDncWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783905650; c=relaxed/simple;
	bh=K4ir6G1+80tfqwkLar7tmNQZtEzAmLUzDp6yv0rC8xE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KBKRemWrCKVg78rd1Cz5BV0OPxsV8/7ruIUHHAmlgFXbE7kCDfa77gILt9/NaOyoztO0IAtmBM9x51VjqThKquUlxmT8OxocfbtqY50YEt5sL24/Gfzu9uKYz/OyHZFVY1Ot6GF63pzZXMAWvP2ZfFP9IFf5lWhjltaYo0TmrpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3zJ7PjW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3zJ7PjW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24951F000E9;
	Mon, 13 Jul 2026 01:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783905647;
	bh=IU6safCA8FSLkmbMZdZg7KZsDUF4K4bd1XSLGrGQGTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q3zJ7PjWsAMOsfpNtWWcTJmAWwDgeY7bYk3OK8bw2qkSqznbiuPJYDsENKQtClszK
	 f7v/anRYQHVF6quAORtCtxJfvSrOC3WyKPude+fc/lJW6XbMLsRkbV0w05ggjfoB3E
	 3cP10ixyns60EnvC/3FWnSwuOn6DMLAZi/HJVHD3siaku/L7HXikvD+htBu/OUkXrl
	 ++Kxk0syH/cLjBLebbnkRiAQ4yzNKOoA1knVRVEdPk72UwRjyoD4LtyKzsi2FSiVTK
	 WETBOEAogLUZpfQ9w1SEA80a3YzXUOlIK6tIdNhm+zB5F7gbZSA2u/JkwUmtzwSgbn
	 CkFyXwy+5VhRg==
Date: Mon, 13 Jul 2026 02:20:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, antoniu.miclaus@analog.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org, dlechner@baylibre.com,
 duje@dujemihanovic.xyz, jishnu.prakash@oss.qualcomm.com,
 jorge.marques@analog.com, joshua.crofts1@gmail.com, krzk+dt@kernel.org,
 linusw@kernel.org, marcelo.schmitt@analog.com, mazziesaccount@gmail.com,
 mike.looijmans@topic.nl, nuno.sa@analog.com, robh@kernel.org,
 sakari.ailus@linux.intel.com, wens@kernel.org
Subject: Re: [PATCH v6 1/3] iio: adc: Fix incorrect reading when datarate
 changed in single mode
Message-ID: <20260713022040.146555b6@jic23-huawei>
In-Reply-To: <20260711184414.1013686-2-jakubszczudlo40@gmail.com>
References: <20260711184414.1013686-1-jakubszczudlo40@gmail.com>
	<20260711184414.1013686-2-jakubszczudlo40@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jul 2026 20:44:12 +0200
Jakub Szczudlo <jakubszczudlo40@gmail.com> wrote:

> When device is suspended and it is in single mode then changing
> datarate doesn't make it actual wait for new measurement, so to
> be sure that read after change is correct functions that changes
> datarate and gain will wait for new data.
> 
> Fixes: 541880542f2b ("iio: adc: Add TI ADS1100 and ADS1000")
> Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1100.c | 67 +++++++++++++++++++++++++++++++++---
>  1 file changed, 63 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
> index 9fe8d54cce83..6ad80d42d390 100644
> --- a/drivers/iio/adc/ti-ads1100.c
> +++ b/drivers/iio/adc/ti-ads1100.c
> @@ -15,10 +15,12 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/i2c.h>
> +#include <linux/iopoll.h>
>  #include <linux/mutex.h>
>  #include <linux/property.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/time.h>
>  #include <linux/units.h>
>  
>  #include <linux/iio/iio.h>
> @@ -43,6 +45,9 @@
>  static const int ads1100_data_rate[] = { 128, 32, 16, 8 };
>  static const int ads1100_data_rate_bits[] = { 12, 14, 15, 16 };
>  
> +/* Timeout based on the minimum sample rate of 8 SPS (7500ms) */
> +#define ADS1100_MAX_DRDY_TIMEOUT_US	(7500 * USEC_PER_MSEC)
> +
>  struct ads1100_data {
>  	struct i2c_client *client;
>  	struct regulator *reg_vdd;
> @@ -123,10 +128,46 @@ static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
>  	return 0;
>  }
>  
> +static bool ads1100_new_data_not_ready(struct ads1100_data *data)
> +{
> +	u8 buffer[3];
> +	int ret;
> +
> +	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));

In theory this can return short (generally reflects a misbehaving device).

> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> +		return true;
> +	}

	if (ret < sizeof(buffer))
		return -EIO;

> +
> +	return FIELD_GET(ADS1100_CFG_ST_BSY, buffer[2]);
> +}
> +
> +static int ads1100_poll_data_ready(struct ads1100_data *data)
> +{
> +	int data_rate_Hz = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];
> +	/* To be sure we wait 5 times more than data rate */
> +	unsigned long wait_time_us = DIV_ROUND_CLOSEST(USEC_PER_SEC, 5 * data_rate_Hz);
> +	bool data_ready;
> +	u8 buffer[3];
> +	int ret;
> +
> +	/* To be sure that polled value will have value after config change */
> +	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> +		return ret;
> +	}
	if (ret < sizeof(buffer))
		reutrn -EIO;
> +
> +	return readx_poll_timeout(ads1100_new_data_not_ready, data,
> +				 data_ready, data_ready != 0,

Kind of related to David's question: sashiko doesn't like this.
https://sashiko.dev/#/patchset/20260711184414.1013686-1-jakubszczudlo40%40gmail.com
I think I agree with it.  Generally need to check for errors in the polling
routing as well and return those if seen (in data_ready I think at the end?)

> +				 wait_time_us, ADS1100_MAX_DRDY_TIMEOUT_US);
> +}

