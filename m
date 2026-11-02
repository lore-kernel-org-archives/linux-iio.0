Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793614834;
	b=luoZXO+OcalJSfdChjM2U0fBl39m9+/tErGV5MGif9x+jWzTpZECMUopS8XHLL0EkrVt
	 vx/q4VDoKC0q+Ma3Ny9yf7rDNCnzMV47MR02pjAAhK51qNW/gC3PeCpwsRmryQhQMZAmw
	 cqF1FaaBFTrJuALMaRKFFwsHvNGiyPWRZ6lFjX0JCPQMT4/TNNxYVpoXB0Zvk6vX1DSNA
	 s8ZooDQW5E5uFH9lgoBjbakKXluml/35gJ4YMnvjvANRQP49pZFvXTVuUiseoLpCXPMRs
	 Avpbrwzpx+FxF8ij5gYkhDss9dQixV5rBRJb7MQMxsOugdRf1s7/30aSePgo3RQRzrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614834;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ChAjq+USbykNWav7CKWG8Sic+ou5ZMqnmIXxXX+I3F4=;
	b=0RaYkNfOLpgT0mmpI7YG1oE2GFfnJ3sgl0lONWZaI6Bjc6JPfPIE5a3tghx+5xfcyBez
	 WoRe4i3EbznpUFVyido/EFZgRgJ1fOFobj0tIQCfyDXDeWNYDFJquZdYhxH7f9gXfsw4f
	 XxmIlHaE52OaU7h3FLRilpzqfUpEowlN761851Yk0T2ii+MgxZMwuAB995WCncn8hvrd1
	 qxR0/V3Rx7ZJadBbvIKwB1WAwWGtiYlwj8qA6chYTqG2pDpPQkPTYyB7v03tXXFKKTZTf
	 zeIrgFxCUO1jRBlKheHCg24VjQRuKI+06DU/A+IPfQpTjMtuH6IgaR5mdIF7UZrupPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iptSnbcW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195B606A324;
	Mon,  2 Nov 2026 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iptSnbcW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793614833;
	b=J0pQGXYskruOSfKEwhcRd1xVT+3pUP9yNcrU7UkPmYsEEL0cXZ7zgoRn4byAXFxVbD5w
	 TJ0MS4TATroDdJagqOh8u3/5GyZ5zarsjoiQpeOW06kb6yeflHyO5rkTzYEoQn8GpaioM
	 CzBi2JxlYeA6W//O3ZrUzuyzSO4s29t0htuWtC8JhP+g+LG9XSLJQOswi0xxV9LmYfu36
	 B7+NASKa5eAW6PwLbNMN610u9CfOSIv0IbgGYS9MU8yGgj2JsOZlCUV+x4biYM/6kTH4/
	 Zm8iiBFeaUlpUpO+RGin9eEi4brmBczUc51RSYuP5FdH2C/mRyQWbGTEGOX75RdOtJw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793614833;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ChAjq+USbykNWav7CKWG8Sic+ou5ZMqnmIXxXX+I3F4=;
	b=GMcXlvufW13GDE0+/tSPMRUl7ZngmbdofwlANQLM5ZDHn/PuACpFVI3nhcnbzgGt/EDe
	 ynU1ehOWDTvvE10MikplT8wVyzSdua+21Yo8M5MiNjWi94edGU+BLHALeDqIUMgVdPikQ
	 JnuThv3xpe6CrbN1y//6axW1Bf/VXkD4Z/HAfBdccqsyzp5BXQhLCIMyRBHNQX3kLKXHe
	 acIajtMSWWR0VAcxIB2mC+gm464QAn6756bE3IfnPjV8leFIreRhn+/8/0PIsOsT2QmT/
	 sEhc160GJQ7qdQH21eWFv+C4E2zlF9S0FUgakFZNmju2/WK76jcYnE43O0uX11IUvCQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id D5B861F000C1;
	Mon,  2 Nov 2026 10:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793614833;
	bh=ChAjq+USbykNWav7CKWG8Sic+ou5ZMqnmIXxXX+I3F4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iptSnbcWJvcYNcpWpfGH6Dow0CxtNhx+YZhCNzm3DubzXi9ZqO7dzSvQH+YehihHs
	 +oDhopT982byJBeHzcBQJiut6NqEAEvE4NKZ6HVmSf5EG8gxuAPoE4KtoNxf9anQ67
	 XdUVEvuTOQmB5PLLNPYJXJ6B9O6QUP0b6AEWJaBtcqAdFAItZIKulgUJa6HuXiJcOK
	 C940qwnTFE5qFeiMvQsB4H6MjIboihf29ajDu7pLlAGn1V4eHniVilye5xrgV8M9Dz
	 Z+qHbZVv8LYMHKV5kbqrak7Jn2qiIcuh9DxFrJc0TweglzjzlJTA/bbjEUCqngHWgk
	 9tb2OQSorJM2A==
Date: Mon, 2 Nov 2026 11:20:20 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Jaakko Koivisto <jmatko@utu.fi>
Cc: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] iio: chemical: sgp40: Implement
 get_serial_number-command
Message-ID: <20261102112020.00007167@kernel.org>
In-Reply-To: <20261102091258.247402-4-jmatko@utu.fi>
References: <20261102091258.247402-1-jmatko@utu.fi>
	<20261102091258.247402-4-jmatko@utu.fi>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
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

On Mon, 2 Nov 2026 11:12:56 +0200
Jaakko Koivisto <jmatko@utu.fi> wrote:

> Add functionality for retrieving SGP40 sensor serial number
> and present it to the userspace using serialnumber ABI.
> 
> Signed-off-by: Jaakko Koivisto <jmatko@utu.fi>
> ---
> Currently only the bno055 driver uses the serialnumber ABI, and presents
> the SN in hex. Documentation gives hex output as example format, not hard
> requirement, but should we use the same format here anyway?
> 
>  drivers/iio/chemical/sgp40.c | 76 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
> index 080d51f9f53c..e0a300720fce 100644
> --- a/drivers/iio/chemical/sgp40.c
> +++ b/drivers/iio/chemical/sgp40.c
> @@ -35,6 +35,7 @@
>  #include <linux/mutex.h>
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

Could you add an additional patch to your series adding any
missing includes? Just looking at this patch I can see that
types.h, asm/byteorder.h and delay.h are missing.

>  
>  /*
>   * floating point calculation of voc is done as integer
> @@ -70,6 +71,18 @@ struct sgp40_tg_result {
>  	u8	res_crc;
>  } __packed;
>  
> +/*
> + * Datasheet table 16. Serial number is given as 48-bit value 0xAAAABBBBCCCC.
> + */
> +struct sgp40_serial_number_result {
> +	__be16	A;
> +	u8	A_crc;
> +	__be16	B;
> +	u8	B_crc;
> +	__be16	C;
> +	u8	C_crc;
> +} __packed;
> +
>  static const struct iio_chan_spec sgp40_channels[] = {
>  	{
>  		.type = IIO_CONCENTRATION,
> @@ -161,6 +174,41 @@ static int sgp40_calc_voc(struct sgp40_data *data, u16 resistance_raw, int *voc)
>  	return 0;
>  }
>  
> +static int sgp40_get_serial_number(struct sgp40_data *data, u64 *serial_number)
> +{
> +	int ret;
> +	struct i2c_client *client = data->client;
> +	struct sgp40_tg_measure get_sn = { .command = {0x36, 0x82} };
> +	struct sgp40_serial_number_result res;

Reverse xmas tree order.

> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = i2c_master_send(client, (char *)&get_sn, sizeof(get_sn.command));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(get_sn.command))
> +		return dev_err_probe(data->dev, -EIO,

Sashiko points out that this function isn't called from probe(),
therefore it shouldn't use dev_err_probe().

Also, you can use a local variable for dev.

> +		       "i2c_master_send ret: %d, expected %zu\n", ret, sizeof(get_sn.command));
> +
> +	fsleep(1000); /* Max duration for get_serial_number command. Datasheet table 8. */
> +
> +	ret = i2c_master_recv(client, (char *)&res, sizeof(res));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(res))
> +		return dev_err_probe(data->dev, -EIO,
> +		       "i2c_master_recv ret: %d, expected: %zu\n", ret, sizeof(res));
> +
> +	if (crc8(sgp40_crc8_table, (u8 *)&res.A, 2, SGP40_CRC8_INIT) != res.A_crc ||
> +	    crc8(sgp40_crc8_table, (u8 *)&res.B, 2, SGP40_CRC8_INIT) != res.B_crc ||
> +	    crc8(sgp40_crc8_table, (u8 *)&res.C, 2, SGP40_CRC8_INIT) != res.C_crc)
> +		return dev_err_probe(data->dev, -EIO, "CRC error in get_serial_number\n");
> +
> +	*serial_number = ((u64)be16_to_cpu(res.A) << 32) | ((u64)be16_to_cpu(res.B) << 16) | (u64)be16_to_cpu(res.C);
> +	return 0;
> +}
> +
>  static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *resistance_raw)
>  {
>  	int ret;
> @@ -306,9 +354,37 @@ static int sgp40_write_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +static ssize_t serialnumber_show(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	int ret;
> +	u64 serial_number;
> +	struct sgp40_data *data = iio_priv(dev_to_iio_dev(dev));

Reverse xmas tree.

...


-- 
Kind regards,
Joshua Crofts
