Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F213793CD
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778171822; cv=none; b=jFKbYO9WiCcP39lzNiDM/QaCaw42ipUQRW+rlRhtZ4Ebmhjw6PgPQj9QllA2N0oIJDYBegVLg7tm1fFMKqlkrNV4Y/wKdD5ejFo4wNrh5/JqaQ40wPpI+8zGqAoccTRMqXGY1LSHb25zvtbrBYQi8JLr8+8H27EcJ02CF5A/tzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778171822; c=relaxed/simple;
	bh=Z7fSwQqskTBl3FfCO4pax4cQlw4d5uZ5pYxGu5Nu7Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETNVkpS6DF65zl4s5Hkx8qnDNzPW4HVvxznf4nMe0P6TLkqvekhWrIghfAdgEwjecbWza58BC222T/mT2uvtSXQVunl9up/uhcIkCCdilkrDlNILlkFSlnEfTyajYKWdge/4aDECYtjT88s5h4DK1NNnxrnOkFyETWCVre6+EMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4Tbn1/T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4Tbn1/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942E8C2BCB2;
	Thu,  7 May 2026 16:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778171822;
	bh=Z7fSwQqskTBl3FfCO4pax4cQlw4d5uZ5pYxGu5Nu7Fo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L4Tbn1/Tb6bVLhJFSWjD6euHOX23TdGhlSGwfdjEOHkEU1mvrarJkSA9lABiTGJmz
	 I25xtQ3Re9+ZGqk7QDIyDeJkySwuYL+eIoAnp7JMD5Exyx9hLjjtX4nIeVae+huGOR
	 57Bqrcixap54lWJ9W/tJqeebCoHYNTX+ihsvu7lAb/r18rcXy2XyWf5Txdv9mUd/bs
	 V4J+yYNN/L4poEhSYObPTQ1OnkahsfyP8Y8sRcjhvlCuaDq9OQVa/XZVMlR+mUXU4B
	 uYGmppLk3sf2o9A/Uqab1YkamVNCUUieca8gTYxcBB1i1FfHsGwU4V7dmDHfa2Ewul
	 +79uYYRGnNGBQ==
Date: Thu, 7 May 2026 17:36:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Raffael Raiel Trindade <raffaelraiel@usp.br>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, Kim Carvalho
 <kim.ca@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4] iio: light: vcnl4000: use lock guard()
Message-ID: <20260507173654.3c52f58f@jic23-huawei>
In-Reply-To: <20260506210616.313636-1-raffaelraiel@usp.br>
References: <20260506210616.313636-1-raffaelraiel@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 May 2026 18:05:33 -0300
Raffael Raiel Trindade <raffaelraiel@usp.br> wrote:

> From: Raffael Raiel Trindade <raffaelraiel@usp.br>
> 
> Use guard() and scoped_guard() for handling mutex lock instead of manually
> locking and unlocking. Remove gotos in error handling logic. This prevents
> forgotten locks on early exits.
> 
> Signed-off-by: Raffael Raiel Trindade <raffaelraiel@usp.br>
> Co-developed-by: Kim Carvalho <kim.ca@usp.br>
> Signed-off-by: Kim Carvalho <kim.ca@usp.br>

Hi All,

One remaining minor point and a suggestion for where there may be
some more useful cleanup to be done on this driver

Thanks,

Jonathan

> ---
> v4:
>  - use guard() and scoped_guard() instead of
>    lock() and unlock() in all functions
>  - drop ret = -EINVAL initialization
> 
> v3:
>  - fix indentation problems on line breaks
> 
> v2:
>  - remove unnecessary ret attributions on non-error logic.
>  - remove breaks on switch-case after return
> 
>  drivers/iio/light/vcnl4000.c | 148 +++++++++++------------------------
>  1 file changed, 45 insertions(+), 103 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index c08927e34b4e..d87a95a05329 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -18,6 +18,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>

>  
>  static int vcnl4200_set_power_state(struct vcnl4000_data *data, bool on)
> @@ -442,18 +433,18 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
>  	int tries = 20;
>  	int ret;
>  
> -	mutex_lock(&data->vcnl4000_lock);
> +	guard(mutex)(&data->vcnl4000_lock);
>  
>  	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND,
>  					req_mask);
>  	if (ret < 0)
> -		goto fail;
> +		return ret;
>  
>  	/* wait for data to become ready */
>  	while (tries--) {
>  		ret = i2c_smbus_read_byte_data(data->client, VCNL4000_COMMAND);
>  		if (ret < 0)
> -			goto fail;
> +			return ret;
>  		if (ret & rdy_mask)
>  			break;
>  		msleep(20); /* measurement takes up to 100 ms */
> @@ -462,20 +453,13 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
>  	if (tries < 0) {
>  		dev_err(&data->client->dev,
>  			"vcnl4000_measure() failed, data not ready\n");
> -		ret = -EIO;
> -		goto fail;
> +		return -EIO;
>  	}
>  
>  	ret = vcnl4000_read_data(data, data_reg, val);
>  	if (ret < 0)
> -		goto fail;
> -
> -	mutex_unlock(&data->vcnl4000_lock);
> -
> -	return 0;
> +		return ret;
>  
> -fail:
> -	mutex_unlock(&data->vcnl4000_lock);
>  	return ret;
	
	return 0;

Check for any other cases that have been introduced where the final return
is always success (e.g. 0)

>  }

>  static ssize_t vcnl4040_read_ps_calibbias(struct vcnl4000_data *data, int *val, int *val2)
> @@ -878,20 +834,15 @@ static ssize_t vcnl4040_write_ps_calibbias(struct vcnl4000_data *data, int val)
>  	if (i >= ARRAY_SIZE(vcnl4040_ps_calibbias_ua))
>  		return -EINVAL;
>  
> -	mutex_lock(&data->vcnl4000_lock);
> +	guard(mutex)(&data->vcnl4000_lock);
>  
>  	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF3);
>  	if (ret < 0)
> -		goto out_unlock;
> +		return ret;
>  
>  	regval = (ret & ~VCNL4040_PS_MS_LED_I);
>  	regval |= FIELD_PREP(VCNL4040_PS_MS_LED_I, i);

If you want more stuff to do on this driver, look at FIELD_MODIFY() and where
it can be usefully applied.

> -	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF3,
> -					regval);
> -
> -out_unlock:
> -	mutex_unlock(&data->vcnl4000_lock);
> -	return ret;
> +	return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF3, regval);
>  }
