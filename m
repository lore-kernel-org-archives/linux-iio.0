Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C1A363C48;
	Sun,  6 Sep 2026 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788720091; cv=none; b=b2kVv1vJPtoXAxbCTr6mf2kAfTqNRz3SKc/QNklSzN0XiDlN/bARovNOZeMQqCcPcdWDT0KepocmPgh7OCoNR2pec2TMftBM4Yig9aTtCx8tyEdlSlDvKa395fl3XXHr7/ATG+HsKUBcv/3PQ8bsF6Ct/2f0Qg8CncmHVH+FtgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788720091; c=relaxed/simple;
	bh=bJma6qjMkBmkrsew8txUTwbVezkKEYszB8Or3uujyq8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=InqLZqq6/bCzVoWyDfqjI7ADMGof5x1ax/lOrrNQBTcUrnl7VpblrTBFMvHMP+V4FvpyE0BEoM0sJUcco0OkxpCNtFicZon1Rdhz1fXRFvnwmhjTwht9cellKTrM553pIexSaRLl28W9DjeKNurU3c2SBN2BAMx4MWzdA5ZdcuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SE+C2dzO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SE+C2dzO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFA51F00A3A;
	Sun,  6 Sep 2026 18:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788720089;
	bh=SNvUlsPgaM3N9GqrTTga5ripAMVFDQzMZNOl9a4uyRE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=SE+C2dzOMUP2qyZyTgmTuaECGu0d5I5jjfRFVUp4mVCdarbD4zIr/veGMrRiVCY55
	 xwRf4unPsmwuwKHYRtpZec0t0bguhbGWdaQ8yVvlen7P1SEHvZxt4HioA+9lz9TgNp
	 SDB7DdfhWtchZLmLqhYaDABjFXYcUOs1F6UBDHdcvesthWDLc4QbrIJItHWIrkXujn
	 8oP9Km15sPsX+igq6U5BbAnRNSVb/+bFN9Rhoj8XuVRHq3Fe5YjPwq0UPyRSEcILYl
	 Ne3sgcTCgMiTtC/YZeiklgLA31jkEbTjXwOJ6AntVEynpQlHUiMWSk936irLcG8ATc
	 jrvXeRLkps88A==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 4/5] iio: light: vcnl4000: Add IRQ disable callback
 on cleanup
From: Jonathan Cameron <jic23@kernel.org>
To: Tsz Shan Chan <tsz.chan.dev@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tsz Shan Chan <tchan@jacques.com.au>
In-Reply-To: <20260903-vcnl4000-v3-4-5e69c2e715a8@jacques.com.au>
References: <20260903-vcnl4000-v3-0-5e69c2e715a8@jacques.com.au>
 <20260903-vcnl4000-v3-4-5e69c2e715a8@jacques.com.au>
Date: Sun, 06 Sep 2026 19:41:12 +0100
Message-Id: <178872007271.3402141.14738588921320424322.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3513;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=bJma6qjMkBmkrsew8txUTwbVezkKEYszB8Or3uujyq8=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnbPLCQPiBFK+5VundJaRro2V7INHkyNpWLBfZ
 oXAiaXmiteJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCap2zyxEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiF7jD/wK/owkWGZmoTuv7zlhWv7ziAmrTc4SK5/oBF2tuGKe5Og
 EyOIvnUeFpLN+zjNCdMTPstG3a8SwByyvb4KoC/EmerlAJPxBmWyLqskOHa9sOFappR6Ko/Byl1
 FsvlTVVaAQ4iaZMSdCBdlDKuEXg1c6YZ/Y/jlWeBIiT2w7uYJ/RVTgycOSe5RIcBAr7E5byoHhR
 v+v7bmNvOfV/Q/tiXLGPVSLHAtOp/RK8GuAcnA2EynYF60TOLNgfa/stlEvDe1nF00pXZe1RN9c
 KRvX3KqUdVEFYoOzhFtpC0b+h+oiJU/EeZzUYJ/bOBHbQP/VfTXkHsO0u34dZJ8SWO7pgyAflhy
 ynJpbMwu65It10FzhR8HGLeDfzNtvw+jt7am87kdhX4PGIpoNIZB73Tw4FxdreW2HPBfS0NFfek
 KPm3pvUCiz5yB6PRLV2hVcqY1XHptwfiXaUz1bOVox6GrikmvsbxnP586Nrteez4FnPQM2Ysmwu
 3e2PynFsgFdoWi3aUWubgqNVWXjHIfRhWXpS6pbrsedZSw0OgwZScyhcBBM0RdEaELQfzXOktvO
 kRikz+emjxao1qgtNKNBfeTUjrS8btl7jdVAPeliiRHreO0USUd5yAtiFlOCwIacNoPcbuZkUhn
 dbVN60RQKv5Ia2SQnQJhG7mr6q/MHIe8UqHTpDA==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> During driver unbind, devm cleans up resources in LIFO order. The IRQ
> handler is freed before the device is powered down. This can lead to
> unhandled interrupts.

Add more on which interrupts and whether they are race conditions
like maybe happen for the buffer tear down, or this is actually
disabling events (as the core can't do that).


> 
> Register a devm action to disable interrupt explicitly after
> devm_request_threaded_irq(), so that the interrupt is disabled before
> the IRQ handler is freed. This prevents any unhandled interrupts.
> 
> Add a disable_irq callback to chip info structure. This allows each chip
> type to implement its own disable sequence.
> 
> Signed-off-by: Tsz Shan Chan <tchan@jacques.com.au>

There are various bits of this that look rather incorrect. Please
take another close look at this one.

Given we've had a lot of races around event disabling and device tear
down recently it may be me need to look at adding a suitable hook
in the core to turn them off.  Anyhow, that is a job for another day.

>
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 9f5a9dc6f87e..82ce940d3bef 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -218,6 +218,7 @@ struct vcnl4000_chip_spec {
>  	int (*measure_light)(struct vcnl4000_data *data, int *val);
>  	int (*measure_proximity)(struct vcnl4000_data *data, int *val);
>  	int (*set_power_state)(struct vcnl4000_data *data, bool on);
> +	int (*disable_irq)(struct vcnl4000_data *data);
>  	irqreturn_t (*irq_thread)(int irq, void *priv);
>  	irqreturn_t (*trig_buffer_func)(int irq, void *priv);
>  
> @@ -1467,6 +1468,48 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int vcnl4010_disable_irq(struct vcnl4000_data *data)
> +{
> +	int ret;
> +
> +	guard(mutex)(&data->vcnl4000_lock);
> +
> +	ret = vcnl4010_stop(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);

Does this regsiter have anything to do with disabling the interrupt?
I'd expect that to be somewhere in INT_CTRL.

> +	if (ret < 0)
> +		return ret;
> +
> +	ret &= VCNL4010_INT_THR | VCNL4010_INT_DRDY;

This bothers me. Data ready should be turned off by the buffer disable
that happens when the device unregiser occurs. Is that not happening
for some reason.  The threshold is more interesting here but I'd
generally prefer this code to be turning the event off (side effect
being to disable that interrupt).  So
vcln4010_config_threshold_disable() should be doing the job - possibly
via vcl4010_config_threshold() (I haven't checked locking etc).

> +	if (!ret)
> +		return 0;
> +
> +	return i2c_smbus_write_byte_data(data->client, VCNL4010_ISR, ret);
> +}
> +
> +static int vcnl4040_disable_irq(struct vcnl4000_data *data)
> +{
> +	int ret;
> +
> +	guard(mutex)(&data->vcnl4000_lock);
> +
> +	ret = vcnl4040_update_ps_int(data, VCNL4040_PS_CONF2_PS_INT, false);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = vcnl4040_update_als_int(data, VCNL4040_ALS_CONF_INT_EN, false);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_read_word_data(data->client, data->chip_spec->int_reg);

What is this doing? Just to check, is this stuff LLM assisted? That
read is random enough I'd not really expect to see it human generated
code.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
