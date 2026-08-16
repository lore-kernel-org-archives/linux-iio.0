Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B783A9015
	for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2026 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786913285; cv=none; b=gAfZMLFWSLObcQqgRueBKM6gg+Uq486mJQt5K98NuXQy04xOiwEv/UDV0n+QxO0MzTJxN/d264+lh5H/u9nhxi/CryWkJLLcRx3mmxa4gO6dv2HB5CioOWSgBMlyqeU1necxCdtWkoGnweYxtv0uei8tnAjJqVkAYQ8cwRNIuJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786913285; c=relaxed/simple;
	bh=DuoCdJG+MEx0tgfDfZZF59eyA4gIICfIAGuGBN0B5KI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QnyEPdOdV8LILcgyPb3ikWQahgxQ0exOy2PilLb0QYySu9ftkumOLT3bSyubIqUZzKzf6iQME6waxcAjCJp/WA6kVmHrBFbGqOEptfyrodtDcucZeUkv5TSRXkwdDHOEQhk07BNQd5kxd40C2ToXoWw1myaxg0aHzW3LQcjPGFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I16xZDBe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I16xZDBe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6CE1F000E9;
	Sun, 16 Aug 2026 20:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786913284;
	bh=5wR4IdSy4//FmVQt6tF+Kc4ZpQuoTt47Cud70UCAZSA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I16xZDBe5qxaszo5ot2bExa2RAk+zS88SUhcGW3Nwe1ijNQNR/XIe/0yiuuY9HeIv
	 lC/1xXFLH/JXrwrFPBUw7MbX9VfeSzD8cGQRzBotkMeMsJwvP49NTadnquIhDNWhxg
	 bcaXlyzc/4bFUI028z5wpz1BXwxvFr2E209kJwvD/RqJiDZd/dg+Pchl6v1eQPSb4G
	 GGqbSg0dbVLVnQ8ja/vMAHVSfm6paRW/uvfW0/eoA8NZZOeGfBssN9NBHojvhajCjo
	 Cu1eaB6eQvF68v3blVuYo2drik7sPxgRvt2PUdo2Lomdh2R5CI2iU3U2IIqy+zdl77
	 NHMwZKBXSTAug==
Date: Sun, 16 Aug 2026 21:48:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Paul Hollinsky <phollinsky@holtechnik.com>
Cc: Amit Kucheria <amitk@kernel.org>, Thara Gopinath
 <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] thermal: qcom-spmi-adc-tm5: fix all temperature reads
 failing with -EINVAL
Message-ID: <20260816214800.433a39ec@jic23-huawei>
In-Reply-To: <20260808024552.57496-1-phollinsky@holtechnik.com>
References: <20260808023938.57146-1-phollinsky@holtechnik.com>
	<20260808024552.57496-1-phollinsky@holtechnik.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Aug 2026 19:45:52 -0700
Paul Hollinsky <phollinsky@holtechnik.com> wrote:

> adc_tm5_get_temp() rejects any iio_read_channel_processed() return value
> that is not IIO_VAL_INT. Since commit bb21ee31f575 ("iio: Fix
> iio_multiply_value use in iio_read_channel_processed_scale"),
> iio_read_channel_processed() returns 0 on success, per its documented
> contract, instead of passing through the value type from the underlying
> read.
> 
> Since IIO_VAL_INT is 1, every successful read now takes the error path,
> so get_temp() returns -EINVAL unconditionally and every ADC-TM5 thermal
> zone is dead: with no valid temperature readings the core cannot
> evaluate trip points. Observed on a SC7180 Trogdor Chromebook (Lenovo
> IdeaPad Duet 3 / wormdingler), where the charger and skin-temp zones
> report an error on every read.
> 
> The check no longer serves its original defensive purpose either: since
> commit 05f958d003c9 ("iio: Improve iio_read_channel_processed_scale()
> precision"), fractional value types are folded into the integer result
> by iio_multiply_value() inside the IIO core, so the return value carries
> no information beyond success or failure. Just drop the check and rely
> on the ret < 0 test above it.
> 
> qcom-spmi-adc-tm5 is the only iio_read_channel_processed() consumer in
> tree still testing the return value this way.
> 
> Fixes: bb21ee31f575 ("iio: Fix iio_multiply_value use in iio_read_channel_processed_scale")
> Cc: stable@vger.kernel.org # 6.18+
> Signed-off-by: Paul Hollinsky <phollinsky@holtechnik.com>

Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> #from IIO
Sorry about this. I thought we'd checked all of them but seems some slipped through.

> ---
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> index bb6222c8cc5f..af72db6299cd 100644
> --- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> @@ -369,9 +369,6 @@ static int adc_tm5_get_temp(struct thermal_zone_device *tz, int *temp)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (ret != IIO_VAL_INT)
> -		return -EINVAL;
> -
>  	return 0;
>  }
>  

