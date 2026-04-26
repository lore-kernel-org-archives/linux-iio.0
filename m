Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9502BEC43;
	Sun, 26 Apr 2026 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777212842; cv=none; b=IdJRDxi2hw74sziQ6EudYjVa8wTQZG4Frc++D61xwipideWJUPv3AmJOv7tUdLtFRktycrSuKQ0THfAnJ4ZTM5ppBsy2bWzrZ2rALjTWkpcDnhzJ0NDfMtSlezq06tThl7j9t/COobXOm5hqayMdUpSKXC2AuUhP78lDCEVptQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777212842; c=relaxed/simple;
	bh=Tdlmg1INLof7Mh2kBAJRyqANztdaSuneCSsuXOirDcY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0ce7Wx0gIg2cSoSkmgmtLYHKtgJZuIQQiLA53kEG0nwuZ1HRr7lPk63s6X4IMKzJLp8+dLko+Y+fVYb7W/kxwo18hTJfiKMI7TZwnsMGNDenC6lU6Dq4rVWWNsXJpg13aiMr+FQ5P68QVYqHc4WsfqwUZO4efafFYZTL6AcUz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmwMX6zI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmwMX6zI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68C2C2BCAF;
	Sun, 26 Apr 2026 14:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777212842;
	bh=Tdlmg1INLof7Mh2kBAJRyqANztdaSuneCSsuXOirDcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JmwMX6zImMhQGLJecKbON3D4NdXD6FlrO/vV0qD/IQXB1MgofFNl9z/ti2xWwBlXT
	 doaNqZaI/HjXlrs9I7g9S4oKT1dkjVzzNThMsP49MXhliK8rcqstxkDw2F83yXveUA
	 6naeCo+Tl79Rxy4drY3e6ROh1TRFKZ3a5J0WAGEvnFnXIUWwG+Mi1Rl4esqMQr24e4
	 F1ks3m4CQgG7hZDfPqOlJndV69sovzY/hbUXV5hLr6ASTPovb5etNj9S+EOdEE1xUW
	 JMdwNH6po0f244ZatTHoF5ItimpAzLZvO21ijAK2J26+V4QHFzs1erhJf33RHqfe2w
	 0bBLMoT06BYDQ==
Date: Sun, 26 Apr 2026 15:13:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 mingo@kernel.org, christophe.jaillet@wanadoo.fr,
 nabijaczleweli@nabijaczleweli.xyz, kees@kernel.org,
 kyungmin.park@samsung.com, k.wrona@samsung.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/9] iio: ssp_sensors: factor out mcu enable/disable
 helper(s)
Message-ID: <20260426151352.4f9926f5@jic23-huawei>
In-Reply-To: <20260426091710.3722035-5-sanjayembedded@gmail.com>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
	<20260426091710.3722035-5-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 14:47:05 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Re-factor the enable and disable MCU logic into small helper functions
> this simplify transfer flow to follow.
> 
> No functional change intended.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  drivers/iio/common/ssp_sensors/ssp_dev.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
> index 51730dae5871..9b8642193176 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
> @@ -89,7 +89,7 @@ static void ssp_sync_available_sensors(struct ssp_data *data)
>  			"SSP_MSG2SSP_AP_MCU_SET_DUMPMODE failed\n");
>  }
>  
> -static void ssp_enable_mcu(struct ssp_data *data, bool enable)
> +static void ssp_set_mcu(struct ssp_data *data, bool enable)
>  {
>  	dev_info(&data->spi->dev, "current shutdown = %d, old = %d\n", enable,
>  		 data->shut_down);
> @@ -108,6 +108,16 @@ static void ssp_enable_mcu(struct ssp_data *data, bool enable)
>  	}
>  }
>  
> +static inline void ssp_enable_mcu(struct ssp_data *data)
> +{
> +	ssp_set_mcu(data, true);
> +}
> +
> +static inline void ssp_disable_mcu(struct ssp_data *data)
> +{
> +	ssp_set_mcu(data, false);
> +}
There is no significant shared code in ssp_set_mcu() for true vs false. Also never add
inlines in c files without very strong perf data to back them up.
So something like:

static void ssp_enable_mcu(struct ssp_data *data)
{
	dev_info(&data->spi->dev, "current shutdown = %d, old = %d\n", enable,
		 data->shut_down);

	if (!data->shutdown) {
		dev_warn(&data->spi->dev, "current shutdown = %d, old = %d\n",
			 enable, data->shut_down);

// I think this is debug only. So I'd drop the print as something that shouldn't
// be in code after development is done.

		return;
	}
	data->shut_down = false;
	enable_irq(data->spi->irq);
	enable_irq_wake(data->spi->irq);
}

and similar for disable_mcu()

FWIW I don't like having a dev_info() print there. So demote that to dev_dbg().

> +
>  /*
>   * This function is the first one which communicates with the mcu so it is
>   * possible that the first attempt will fail
> @@ -146,10 +156,10 @@ static int ssp_check_fwbl(struct ssp_data *data)
>  
>  static void ssp_reset_mcu(struct ssp_data *data)
>  {
> -	ssp_enable_mcu(data, false);
> +	ssp_disable_mcu(data);
>  	ssp_clean_pending_list(data);
>  	ssp_toggle_mcu_reset_gpio(data);
> -	ssp_enable_mcu(data, true);
> +	ssp_enable_mcu(data);
>  }
>  
>  static void ssp_wdt_work_func(struct work_struct *work)
> @@ -584,7 +594,7 @@ static void ssp_remove(struct spi_device *spi)
>  		dev_err(&data->spi->dev,
>  			"SSP_MSG2SSP_AP_STATUS_SHUTDOWN failed\n");
>  
> -	ssp_enable_mcu(data, false);
> +	ssp_disable_mcu(data);
>  	ssp_disable_wdt_timer(data);
>  
>  	ssp_clean_pending_list(data);

