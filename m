Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E272B57C9F
	for <linux-iio@vger.kernel.org>; Thu,  5 Mar 2026 02:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772678227; cv=none; b=WeyNcPkk9nYuazNvxSXDotKwC55efPxGVVt1VyY9zZUXbLtqtGlarVMh0dvMA0nN/upLugj6FmfDr72Whj1WzdJ1pjAXNyHmjGwtDND+lhicThR8v2W3TO0MNXGG24P9zkzk509EY5ASvlfQ9Rd7A+XkiCWRa9/1iimNEuO+TtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772678227; c=relaxed/simple;
	bh=2d2GlJa4ApWpFkUSafbhx1eWIy+ibOALbHyyOErspDo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gMRaGkE6TawoZ1TMkBvWWKxXa4xnsjPK+fPFSuoWGxkW8qXtnm+g6Byx2iu/7n6ppJf9Cb9jsnBdBfIl7q4A7RsAsH9Lo+XIYWk8CMoVyPcq6IPsRTkXM/2U/WEe/aaNQfyDKguEx6FhnN5FTw/bOnJ0m6/xTzvF8rJnDIi0eg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lp08v+UM; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lp08v+UM"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5ff125cba0fso2122629137.2
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2026 18:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772678224; x=1773283024; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MH/itaeWvx9zMZ5Mj7aed6NUelB91B1Mt42+Zj/AjL8=;
        b=lp08v+UMp8y53C/DV5sGRNm2NFl89TASHZdar44HnzB6bDbHrhEe6B6/xt4Nhm2En2
         qLukAT4C0gPlM3vGNC33n4z5VHYabNsK6fkYMLOwYcK4BvHWkLOJhjF8PojDJe2l5Bjb
         fsgBloHTMaFO7aNKUOaZK6vjsZBvKNzrST/bNrYk57sxO2KF4nHiMD9oL92pzmk5YUDJ
         Qd6aNhH8PeyX5XOpJL+CTq/iO4RWcyl3H1P+32BYGFBjJXRQhqlEtwOo5/4pYM7qgv3T
         G1xo/540kx/167nL7ag5BeA5ZyMZI4tDNxIN/keN+AKZLAJhCaYUguwUyUv98b9Y1OF3
         ToPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772678224; x=1773283024;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MH/itaeWvx9zMZ5Mj7aed6NUelB91B1Mt42+Zj/AjL8=;
        b=IxHJp/QqRmyupaawLOY4EElk3VEnJBtahs7Vac4sJs81zEHJkPCD1HI1V5IKiwlxk1
         jiJCOVnCQp5puy2Qd4M2qEEQDx1jGKiY49LiqJjsXSITTu0fE4AjAUjxWFRWFlwaRigh
         stH+S8OQT0FvQtIJXlPywmSnzv6TM+7K0zMhsXT7EajgHSlUKm9hww46pSO/CH59t8d5
         IUaPI/CMII183Q7dUMbYLhHDHQ/rvb+/ylp1uXB15GqAiNr4drZbwHriWLjNJAFr9sxx
         4maiDuviVMl24ZRmX/Nt9tUetocNal1JUg7kG6sQHZHCJxe5MU8mXvMF02hYJVgxrnhc
         koew==
X-Forwarded-Encrypted: i=1; AJvYcCVE1iRmvwRgVG403lPVM7TiW4Yc5Dk+zvV7wK8qG/CWdZIkOGMoFiw/4+VfgDC54J6Uhw2rhyjIk4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGrViq/ULUUyHUJEhNz3rUTFh3YQfXcAWgwAWBbfa4y+KQZzE/
	slsiyMQnusMIqpUvnZoyIOF82qs4ecI5EkGnxd8Xt2ajfeZNXtw/IANU
X-Gm-Gg: ATEYQzxHV86kvxgzPb4FV/ZJ/UHKcmHevDrJQM696QBbmfpnUAkgeOlt5bMylq+0guU
	d4PXXnSPaW8A5G+GONqcSSTNzyc8wqMFtv6dSfxMM5Jod31l7xlRK/PV/JSZVabt8XVI1cammTT
	s0eN0cE30UomDcSql3rwPBsrdOErUnRLsUvK+EG7sFBNm3bvE0IAht1LtUJrn2rKQ/U6KAZZWkt
	Z9bY9YZJyyXNKSuTkwB98z/19GFQzr9t/49nQMqc4MuYywbPEc0wQuzQq0sVPdD7ugTZqz59+BO
	zZcEM83FI/eHEkRx4SK29Iccmy2AZ2ejvOS1Q1TLG3cFDq3m0D+jJgLy4v5DnurOQs6XfYTKCRS
	0IIOP1l2GuQ1edNgb1W/dm/Zf1r8VRFYTy1Ps8gsIPn7RUc0Vsz+EAel+JN327AUnPy+Xr5KHoL
	v1qGBQO3sFBIANmaY=
X-Received: by 2002:a05:6102:508b:b0:5fe:43e:63d3 with SMTP id ada2fe7eead31-5ffab2a0332mr1622511137.41.1772678223774;
        Wed, 04 Mar 2026 18:37:03 -0800 (PST)
Received: from localhost ([181.91.18.156])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ffa1fbd888sm5315436137.0.2026.03.04.18.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 18:37:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Mar 2026 23:36:59 -0300
Message-Id: <DGUHZFW5IACK.1JUICZ99ILHKG@gmail.com>
Cc: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ti-ads1018: fix type overflow for data rate
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Chunyang Chen" <chenchunyang0908@gmail.com>, <kuurtb@gmail.com>,
 <jic23@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260305021550.120614-1-chenchunyang0908@gmail.com>
In-Reply-To: <20260305021550.120614-1-chenchunyang0908@gmail.com>

Hi Chunyang,

On Wed Mar 4, 2026 at 11:15 PM -03, Chunyang Chen wrote:
> The variable 'drate' is currently defined as u8. However, the data rate
> values in ads1018 can reach up to 3300 Hz (e.g., in ads1018_data_rate[]),
> which exceeds the maximum value of 255 that a u8 can hold.
>
> Change the type of 'drate' to u16 to prevent integer overflow and
> ensure the data rate is handled correctly.

Good catch -- thanks!

Interestingly, my SPI controller has so much latency that I didn't catch
this while developing :/

>
> Signed-off-by: Chunyang Chen <chenchunyang0908@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1018.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ti-ads1018.c b/drivers/iio/adc/ti-ads1018.c
> index 6246b3cab..049b8c00f 100644
> --- a/drivers/iio/adc/ti-ads1018.c
> +++ b/drivers/iio/adc/ti-ads1018.c
> @@ -249,7 +249,7 @@ static int ads1018_single_shot(struct ads1018 *ads101=
8,
>  			       struct iio_chan_spec const *chan, u16 *cnv)
>  {
>  	u8 max_drate_mode =3D ads1018->chip_info->num_data_rate_mode_to_hz - 1;
> -	u8 drate =3D ads1018->chip_info->data_rate_mode_to_hz[max_drate_mode];
> +	u16 drate =3D ads1018->chip_info->data_rate_mode_to_hz[max_drate_mode];

data_rate_mode_to_hz[] is u32 so I prefer for this to be u32. This also
kinda matches ads1018_calc_delay() which takes unsigned int.

I'm a bit disturbed by the type inconsistency here...

>  	u8 pga_mode =3D ads1018->chan_data[chan->scan_index].pga_mode;
>  	struct spi_transfer xfer[2] =3D {
>  		{

--=20
Thanks,
 ~ Kurt
