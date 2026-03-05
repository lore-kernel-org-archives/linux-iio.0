Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC6839B943
	for <linux-iio@vger.kernel.org>; Thu,  5 Mar 2026 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772716377; cv=none; b=Wf/nd2LDx7vzM57BBrnZkre/LRniduIeiIH7gZA3JAWo7IeKs87lIXos64c9BjALanPGIa6BHxCk/MLZ14YdzaTlSLoldxIewPmuztnifmjmNImwATy3d7aDuxQlL/M4feR907ZXnpiq/2DMNfvk7xm+nqBtaXIM5tTnbC3SmoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772716377; c=relaxed/simple;
	bh=94qlGcdT5yncrBEruyWNNGvj9NcPx5G681UhjXzV+2M=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=EwF8LE0DM/YNqPUdkVSMMa9bPTUYHUTzvM3eweaz7LA/VarQTls9BZoJ/mXXJmUrPfJm3jylLLtMmFx6at1u316zJ69Vhq33q3rq9eD2isiDOj5ZK2NC/dzvX27gF9jAbN/rFX0JwRt2mJS1CaQkC1MZW/FfwafrYT5ZfLE/3q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZn76XGt; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZn76XGt"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5ffd797184fso98113137.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2026 05:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772716375; x=1773321175; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytfWDKic/1qF3lMKDrnQYPY9Fxc1naE/EEiJEtyLdGA=;
        b=WZn76XGt3XCJsfwggIKn4xPsvW1/pMoGkXGNnPergeQEkkEfgOm1nHhSAd2lWWtgs2
         AKowW2FxVDrluhofdP1loLGGbbCZtzo0D8rqqgAjRW0aT1zGCjoJARion8CR9XXOgXG9
         OqEmbqxE/EIS/WU5IrlHSBrUL9Z3LySOeXyOJwxB/QO4hJ+MOEOYws2HO6pQOiBMeezS
         b5WkGSNkMQzhQizSUz9JIoq0HmjEQCNKpzsgOQ+thFXT86Rnh9ViYqSQOSz/ywfT/rNo
         FoBytL3koAnq3OykDc/ZrR8/YqaqInb2JFNerkvMAYId63J69FZ65IeX0uBFuy3CvXUK
         TNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772716375; x=1773321175;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ytfWDKic/1qF3lMKDrnQYPY9Fxc1naE/EEiJEtyLdGA=;
        b=McfWxFK4plxxVnl7/cxqKVlE1sMHsbuXFqnPsLumXoFPPlP7DkNhX/Culg6exmzEg4
         6E2dRJFBRcWim373Z1K+0RA8JpI5Z0uv/QnDQD2phOoEKXyVKstO+i2YvT/JIkNtMfvZ
         1jSG/NW1nbECG36J6j1VsTFsXBijkLkalsiOPuHH0MvHTNOBt7htoL4F/Q4JFHunfJd1
         tNssPMWc/IRmGMLW98LEc6BkE2kVUiQiyHNLh2oCICqr70NWqKaWIgg2LMb7pO99NuZb
         T4xLw959JiES/7+D8/g1Dw9FbEDFU3/RRujCEyB1s+qAja4oM5gx8ZNYEFQT73EzvW9i
         X0zA==
X-Forwarded-Encrypted: i=1; AJvYcCXTQ1zg4ug/nfkZhwSaomUkDJvp7w2aNrUXYGi1EW0iWcsvb27ajx1NtS48sZLXKzfRjib87lG1jPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0dscLLtVPd/ubZoD1zMJa8I2MVnGGlvuvXeQHhGnFCyGfZHgo
	V4ObBN+BUrxKaaMIQzzRY7xZQyWxvvllI54hUzNkgW8EMN1cwChgD27Y
X-Gm-Gg: ATEYQzyJB6imePK6KdKj0p7miXQ/QUAD6qc6kf7lLbF5YUfBcMfyeF9MnoSHygi1Rd8
	urykMkkWScZjpjUxxx8wjyep9ozh093UuyU8Q2hZ65Yt0G02vcbZ70GSj7Z6JPuCz8SO9ZIR1Ib
	qOHIxFu1y5qq7FAaXHxZ4CrzqT+vN7w9oXmTO/sN/K3yH1gYppe54C0b41fOL4Mh84hDeGfrs4q
	ll6Qa0a/EDI+QCtjhekiAkN6mDEgBnvO+NV191j+n9Tk96NC4R7Qt6U+sK9fJKQBaJ+u3EJGZw8
	dHt1HxJfzrWdpaeXsrgOaTaKLNQibKZp5b4G5Bk0ayBICUDLu5tnP3+eIcCgAAL5w6R/KS92xhM
	DlFojQxZ4h+FzQtuEdmPi5INpJVdJDQ6WykzjjORzjsOAR6HUJ2hUMJWIEhytZml8uq4bVvuuWC
	TrdMyiVc2e/4/AENE=
X-Received: by 2002:a05:6102:3586:b0:5dd:c53b:75cc with SMTP id ada2fe7eead31-5ffc8d96ce0mr749612137.13.1772716374785;
        Thu, 05 Mar 2026 05:12:54 -0800 (PST)
Received: from localhost ([181.91.18.156])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ffbf2b3b0csm3560520137.2.2026.03.05.05.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 05:12:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Mar 2026 10:12:51 -0300
Message-Id: <DGUVIAHN0BGR.FQ4ZP9PMDMY9@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Chunyang Chen" <chenchunyang0908@gmail.com>, <kuurtb@gmail.com>,
 <jic23@kernel.org>
Cc: <andriy.shevchenko@intel.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: ti-ads1018: fix type overflow for data
 rate
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260305021550.120614-1-chenchunyang0908@gmail.com>
 <20260305124302.129637-1-chenchunyang0908@gmail.com>
In-Reply-To: <20260305124302.129637-1-chenchunyang0908@gmail.com>

On Thu Mar 5, 2026 at 9:43 AM -03, Chunyang Chen wrote:
> The variable 'drate' is currently defined as u8. However, the data rate
> values in ads1018 can reach up to 3300 Hz, which exceeds the maximum
> value of 255 that a u8 can hold.
>
> Change the type of 'drate' to u32 to match the data_rate_mode_to_hz
> array definition and ensure the data rate is handled correctly.
>
> Fixes: bf0bba486b5b ("iio: adc: ti-ads1018: add ti-ads1018 driver")
> Signed-off-by: Chunyang Chen <chenchunyang0908@gmail.com>

Reviewed-by: Kurt Borja <kuurtb@gmail.com>

>
> ---
> v2:
> - Change drate type to u32 as suggested by Kurt.
> - Add Fixes tag as requested by Andy.
> ---
>  drivers/iio/adc/ti-ads1018.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ti-ads1018.c b/drivers/iio/adc/ti-ads1018.c
> index 6246b3cab..0780abd0d 100644
> --- a/drivers/iio/adc/ti-ads1018.c
> +++ b/drivers/iio/adc/ti-ads1018.c
> @@ -249,7 +249,7 @@ static int ads1018_single_shot(struct ads1018 *ads101=
8,
>  			       struct iio_chan_spec const *chan, u16 *cnv)
>  {
>  	u8 max_drate_mode =3D ads1018->chip_info->num_data_rate_mode_to_hz - 1;
> -	u8 drate =3D ads1018->chip_info->data_rate_mode_to_hz[max_drate_mode];
> +	u32 drate =3D ads1018->chip_info->data_rate_mode_to_hz[max_drate_mode];
>  	u8 pga_mode =3D ads1018->chan_data[chan->scan_index].pga_mode;
>  	struct spi_transfer xfer[2] =3D {
>  		{

--=20
Thanks,
 ~ Kurt
