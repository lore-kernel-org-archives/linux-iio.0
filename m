Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB3D3644C3;
	Sun, 26 Apr 2026 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777212561; cv=none; b=QfxB46Ht/btnJH1P4sEEiVSWxKmVRyJemgg/2/y/QCcCtCFNyBG6TRJgCc+Ep4vOtLuNW73lpmZp86/SZ7AAMtC3eU6uQYLuDQWklp/Tmyklz+mwT1E6Ga5Op0jBTVzni9S8KOS3J4rYl6LVt3GIbc9EetMz0VD1j3FHAUXvwHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777212561; c=relaxed/simple;
	bh=wGKvdZRnofY/mY4y5o3012T2Utic3jEE3TiX0WKTHe0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hD7ojRu4z3gFMUBRKBLjEdJ/eFNC5oIRAEnfHTcx+86cNYnWxAJyL1vIdRCGW92vgnNEBDuUvZllEXb5TsPhVu3VF5RSSk9Dy/u7YFttmiRA092wLWfs7WJdq5qQAnex/LlQLAW/yaof7oi/5U/eV+KYLZt/ETyp5yA3+2aoRVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTCfIiNZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTCfIiNZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090BCC2BCAF;
	Sun, 26 Apr 2026 14:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777212561;
	bh=wGKvdZRnofY/mY4y5o3012T2Utic3jEE3TiX0WKTHe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BTCfIiNZjew0kHgSqFpHrMZ5WZFx0eRBeQcPqgweIhCJyJMgx9QFVFV8VECX+Fnvj
	 8nWlVZCNtp5hc8OGOS7du2HX8KaALZtLBTii2fW2Ey5g7wi3ML3MIBjBkpXky2JA3I
	 5pdJAFwORhnvxAc7F3yduWSjAoPGkqkxwQgVvWSsIjzBxNNHs8FTv7L/6t+xNA1Maz
	 2ksJf3KLoT1Fs0OcElKxxXO8NhckjgER8Hhc83uHoQKo9ioSbPSlwEx/j9wqE3rP19
	 waODHQ4jz1xGl1HVAjbW0jyhsKB3VOra4Xh1ONZ/iR566i3zv3/oOXtlXyBE4nTsFK
	 O780Dp+sQEpoQ==
Date: Sun, 26 Apr 2026 15:09:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 mingo@kernel.org, christophe.jaillet@wanadoo.fr,
 nabijaczleweli@nabijaczleweli.xyz, kees@kernel.org,
 kyungmin.park@samsung.com, k.wrona@samsung.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/9] iio: ssp_sensors: cancel delayed work_refresh on
 remove
Message-ID: <20260426150912.765d5985@jic23-huawei>
In-Reply-To: <20260426091710.3722035-4-sanjayembedded@gmail.com>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
	<20260426091710.3722035-4-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 14:47:04 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> The work_refresh may still be pending or running when the device is
> removed, cancel the delayed work_refresh in remove path.
> 
> Fixes: 50dd64d57eee ("iio: common: ssp_sensors: Add sensorhub driver")

Fixes at start of patch series not after some refactors of unrelated
code.

> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  drivers/iio/common/ssp_sensors/ssp_dev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
> index 7d07fae295fd..51730dae5871 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
> @@ -590,6 +590,7 @@ static void ssp_remove(struct spi_device *spi)
>  	ssp_clean_pending_list(data);
>  
>  	free_irq(data->spi->irq, data);
> +	cancel_delayed_work_sync(&data->work_refresh);
>  
>  	timer_delete_sync(&data->wdt_timer);
>  	cancel_work_sync(&data->work_wdt);

