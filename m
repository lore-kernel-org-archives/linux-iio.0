Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934619;
	b=v2T3wNxBqdOiRvYJN2dYxmwmk22KanFm/uOHb//pJVubio26OT5ppXZGt7i+4W0pGOMl
	 iO6mOb1PCz0seiPUB0RqX39hG+83w6df9VO4sU1wkx68uDBObuLYqqpYebBY3SSI+vzhp
	 4lz0RkANB0qO1Az3VXLpQaU6pFU0FHYqsoB4hLppf7Sqfcm1f75n0GpZH4V8igdR2ngjR
	 Exy437I+bjbgydqzBArhy80C3Ur3lhxB7tPA0hG2N2SRVoqSUzzTzq+vurSxCQ42xQNfw
	 BPEBppdS8KFfA2WpSsT9f1weNVZgILJHQ1gyLP4829oGUaQENLZoHfCfPd3pPh4YabA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934619;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jbsYC7NKNiG6reBJgo4fP8WND8f8XrpJahS4ciAER50=;
	b=hSON/K0AVbSc+4G+e6z7LHoBsBNjyFjKNmFsuC6wYr1MVKaUT/88bwnrqGN5tpzqRFXD
	 AvusIQ8eHSeO9HcF270j/prlv/3Uk9yKXVUR084dJQDslr5VuO/RlgZA0b+yxGKkjdoty
	 TsZ9f0Y2NfQ1hJ1OSSP8Flyvdq9qV+SDtF6Ltsc1Wl+zqEiJoqlPGiAJrPyMtGylbgkQW
	 cT5mF8JkwtC+pSfK/t1ky9U/FwGAUF7RUuZ3S2pW7lENEkRndzOQZbZIp+T70SOCTDh+e
	 TC6PqAV2Y26imtfsQr2cWWXn4ouMoY6YfOszLf4cY3dfJo55iXMQ0lvAbM1NYnXcaoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eWWlIE39;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAC8606A32E;
	Fri,  6 Nov 2026 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eWWlIE39
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECB91F0089F;
	Fri,  6 Nov 2026 03:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793934619;
	bh=jbsYC7NKNiG6reBJgo4fP8WND8f8XrpJahS4ciAER50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eWWlIE39UR6C9FAtAgx/ECpIaLD2sDYt+0W1pQkqPf5fpNUTd23ET3E6cLPkRFpmX
	 ZZdeVjhTvi8SeT7yS25atqxT/3v+VbNbb0cEvdkmZtDzk0gn5EajwQbDuHtJyD1lsM
	 k9t5R5eOc+m2V80WtuoIQnnYldewH0QvKxOoqZ3oDGGh9h41JUfH5Hq9uBBai/f0s/
	 maiId33NU+LJoNaxlcWLUw97eoDHzI/dY7yFFmLg99uzO/ejRjRqlVlxptnqpOfUyJ
	 6plR7wLv0W/dfn/WPdZLlS4IGqyKFr5LIzDUgDYboPA6CY4akZeqBWET5kc73eEKCy
	 iNgHl8stG8T/w==
Date: Fri, 6 Nov 2026 03:10:15 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Satyam Gupta <sgsatyam@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: cros_ec: Use platform sensor_num to unregister
 FIFO callback
Message-ID: <au1FF5K9EALuqnNR@google.com>
References: <20261105132057.2429385-1-sgsatyam@google.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105132057.2429385-1-sgsatyam@google.com>

On Thu, Nov 05, 2026 at 01:20:57PM +0000, Satyam Gupta wrote:
> No in-tree driver changes the field after probe, so mainline is not
> known to hit this. The ChromeOS RGB light sensor support does: it
> changes the field while a command is in flight, and unbinding the
> device then leaves a stale callback. Found by an AI code review agent.

I think this paragraph can be moved after "---" so that it isn't part of
the commit message.

>  static void cros_ec_sensors_core_clean(void *arg)
>  {
>  	struct platform_device *pdev = (struct platform_device *)arg;
> -	struct cros_ec_sensorhub *sensor_hub =
> -		dev_get_drvdata(pdev->dev.parent);
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> -	u8 sensor_num = st->param.info.sensor_num;
> +	struct device *dev = &pdev->dev;
> +	struct cros_ec_sensorhub *sensor_hub = dev_get_drvdata(dev->parent);
> +	struct cros_ec_sensor_platform *pdata = dev_get_platdata(dev);
>  
> -	cros_ec_sensorhub_unregister_push_data(sensor_hub, sensor_num);
> +	cros_ec_sensorhub_unregister_push_data(sensor_hub, pdata->sensor_num);

So now `pdev` is only used to carry `dev`.  How about just passing `dev`
to this function in [1] so that it can be simplified?

[1] https://elixir.bootlin.com/linux/v7.3/source/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c#L394
