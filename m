Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182B4B67E;
	Sat, 19 Sep 2026 00:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776334; cv=none; b=OwNe+Vld6yfdItrSYnRNMPPXKW4WH/teQ586Po1cyvwfk9YK/YI182fGSXZN1H8TWHMqIW1L51f2TRUYXaMmp7w7lharJS38kEbG+5abe0ntxVYnzfeKvBWwssQpghgoFKaw3gUPnJzK3Gp8C9Yo/bxmcy6KIX30jrDWyYK3oz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776334; c=relaxed/simple;
	bh=m5QLi4MU9IhXJ43JuLn4ROAP1d4tOZmrlGm/EzX/kks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nph9lX16GHeEolqLKKdcVVscJiAJGhIXPNN9/+8IVcuJBAfHJGpdGMCPLhuGe0vJiyxRumPGXrhKk1L1LRztHf5JMUbIbWlTui8YSfMkLcQbxqinMmCyBFg799loN5ZSsN5E2F9pgXyDeWaGZ7DzSVtgHGcJc/dw/MyYXseVABU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=uLnAEoZC; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="uLnAEoZC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=cuK36tX0w1oMWbj8Rduwto0JXT198crApPvx3gSSjl4=; b=uLnAEoZCMjwph1DwNSAwvZ7gRs
	f5pbK2stK3gOPVJ0OMkckXTrDa71LrxFXuy45/PFFueIhHB1kcwjBlMaqvN3L7GlE8RG+J0zFlc6c
	110ikvA6lW6HBEkjwI9zNbz2fdcNTLrg/39XqzmQhaw00kRVEZ08RjCRkTfVMXrEWvksNZcQcVFNM
	LmPwJ7+PFZOescAKNRyOhxzRJIowtyqLFZ6wCnhkkV71JYIQDwwH8AWL3w/Zi4WCAmgLgQtsBMitn
	PeHlxqPMMkfcZ7cowC/kOyoquTpYlWKcob+QbFfGGS3s6fpaaCuGCP36wLDaapQ4D0ML5v1nQ74Of
	xkehn1QQ==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1x7i8N-000FDN-2w;
	Sat, 19 Sep 2026 01:36:47 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1x7i7p-000Pto-38;
	Sat, 19 Sep 2026 01:36:47 +0200
Date: Sat, 19 Sep 2026 01:36:45 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: Jaakko Koivisto <jmatko@utu.fi>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: chemical: sgp40: Implement
 turn_heater_off-command
Message-ID: <aq3LDTnLuJm6vjFt@mail.your-server.de>
References: <20260918134019.1101308-1-jmatko@utu.fi>
 <20260918134019.1101308-4-jmatko@utu.fi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918134019.1101308-4-jmatko@utu.fi>
X-Virus-Scanned: Clear (ClamAV 1.4.3/28127/Fri Sep 18 08:25:28 2026)

Hi Jaakko,

Jaakko Koivisto <jmatko@utu.fi> schrieb am Fr, 18. Sep 16:40:
> -Turn the heating element off and enter idle mode.
> -Present the functionality as device attribute,
>  'echo 1 > turn_heater_off'.

Instead of introducing a device specific attribute couldn't this be implemented
as standard power management operations (RUNTIME_PM_OPS)?

Andreas

> Saves approx. 2.5 mA compared to regular operation. The heating element
> is automatically turned back on when measurement is performed.
> 
> Signed-off-by: Jaakko Koivisto <jmatko@utu.fi>
> ---
>  drivers/iio/chemical/sgp40.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
> index 28d5e737d1dc..a4fc5c778303 100644
> --- a/drivers/iio/chemical/sgp40.c
> +++ b/drivers/iio/chemical/sgp40.c
> @@ -29,6 +29,7 @@
>   * by writing to the out values of temp and humidityrelative.
>   */
>  
> +#include "linux/device.h"
>  #include <linux/delay.h>
>  #include <linux/crc8.h>
>  #include <linux/module.h>
> @@ -259,6 +260,21 @@ static int sgp40_execute_self_test(struct sgp40_data *data)
>  	}
>  }
>  
> +static int sgp40_turn_heater_off(struct sgp40_data *data)
> +{
> +	int ret;
> +	struct i2c_client *client = data->client;
> +	struct sgp40_command turn_off = {.command = {0x36, 0x15}};
> +
> +	ret = i2c_master_send(client, (char*)&turn_off, sizeof(turn_off.command));
> +	if (ret != sizeof(turn_off.command)) {
> +		dev_err(data->dev, "i2c_master_send ret: %d, expected %zu", ret, sizeof(turn_off.command));
> +		return -EIO;
> +	}
> +	msleep(1);
> +	return 0;
> +}
> +
>  static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *resistance_raw)
>  {
>  	int ret;
> @@ -417,10 +433,22 @@ static ssize_t serial_number_show(struct device *dev,
>  	return sysfs_emit_at(buf, 0, "%llu\n", data->serial_number);
>  }
>  
> +static ssize_t turn_heater_off_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t len)
> +{
> +	struct sgp40_data *data = iio_priv(dev_to_iio_dev(dev));
> +	sgp40_turn_heater_off(data);
> +
> +	return len;
> +}
> +
>  static IIO_DEVICE_ATTR_RO(serial_number, 0);
> +static IIO_DEVICE_ATTR_WO(turn_heater_off, 0);
>  
>  static struct attribute *sgp40_attributes[] = {
>  	&iio_dev_attr_serial_number.dev_attr.attr,
> +	&iio_dev_attr_turn_heater_off.dev_attr.attr,
>  	NULL
>  };
>  
> -- 
> 2.55.0
> 

