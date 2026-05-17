Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AFB2DCC01
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779037658; cv=none; b=fiqnf8DGvXn92RLB2RHZ9iW8n91cVQEnMOa1EJGtUDQpMfpQ5MmOXABWC7FvY27Q75W0LTqs0Fvi2tPQeKm1/37USNK7YJ/e4DpMXyPI9vg9hzW6E16utp2B6moi58duEr0f8Qnlu0NfVsWJZar1zmVIbnOVeqRNaJ4gndx3Gck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779037658; c=relaxed/simple;
	bh=B+gnwHBAfIoCpLNTcKZqdCPscmLQ/yi14UzJTcxzsQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqQMPx2C5Y0PVr7HRKsPgcEPZfEYh6DsWAFz1f4eleqq4KoHG8hesSMmcZzzJ5Jv7LVyX6vsR4qCb2ZXxQPOK+ZVDNneZWY9mdDfLr40K8/lJjELhe/Phm5mkTF2JRBuErFpLtyn72OUncSAvnrB8jLgxz2f/P1N0sc2aqxIyAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=mFmthNfo; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="mFmthNfo"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dcd689829eso1402241a34.3
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 10:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779037655; x=1779642455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hrOnBFPP1Ld1TfCVTVS9lLZmmZK95raO/NO3JK/+lUU=;
        b=mFmthNfohzVMZ/SaWMnJUpMphLArtL698X24lYrEPvcrhq9//Pfwe7lBnuwY1j4Ljy
         4/3abvjznNBNAXb6Tei/ErnSjbJUkmh+EfapJfxWpzr7BDnpWn5YJ4Qh8+uf2OadvaCK
         H9ro9NzH10bqO0CNUH7L8JLnRcj8H7utZUZpLz0rPJ2+DeyQD4bMmYZ3vreJAKMWsqyo
         HH0BEuz+IbQ4PCW/FgRA/FjpzyY2yoE5Eyxw3qyK9LUcW0nZ8Eky4YzwQq0P/m8iJcv0
         REQMoDSE9jd3dnaz8dkbBehKoIMY+Lh3F4XDXMb3acXjyAmnaDRtOxB1EiHl+qfG17be
         u7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779037655; x=1779642455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrOnBFPP1Ld1TfCVTVS9lLZmmZK95raO/NO3JK/+lUU=;
        b=XRVST1YMMFcjkH5RFJQXUIW08VBAY7HnGE/mndtGuHFcvfTDCkdUuU1dD3LLBg0GkF
         kRM6vY8F54DyD+o/Qa2XVTdp9OsrphM53f9iH/9tPPQDE1X+KRwjUInkSVnwO68nbWr3
         yLPnwuzUogilKlUEDe4EWUa58pRS/VXr69tp48vVvnLC6OjioRjlNG9Rmc/Nc8PUnHa2
         mK5HL7fiFLXC4jGxahDe+mR//OQZpVzRNivJHnOFj+rfGDZc15NBneBBcjr3Cpff614U
         2y0asFByhXiQvLtRgQfiRaqyhQgF0tsA/ln7+cg03u3CG0cgX5i96a72ig71COBV56vT
         7oVg==
X-Forwarded-Encrypted: i=1; AFNElJ9AVpDQcPvmYm7GxzofHXQ/yYUBVoelXlR7ZdODMfwiXTg+McoixAvVT8ZvJIo4FXAu53WDuLoaRZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWXN7CmZA+g5A6w5JRRTRobQzt3oNtN6SHmDJdan8TQxQY7vlL
	Gf6bUPPsNznjUOPQy77l7R84S8/veciVd8CuH3Y0I5+yQhmy9JLeHSntHTtdDHc4U58=
X-Gm-Gg: Acq92OGF3ffA5sOyQH8cpoblUW2XnLg71J90QsAcnQffudQbconaER8MaNtwWgmGnlz
	IjlEKd8cJtxcedOBCjz1Dla4uZ9Px6gv72R39KjszWEPwizoUcnU534JmEJi1/ac0u/Ms1mAwUZ
	LSTdmaEX017mC5kVxUufYA3JubSK/lDYzLvKQi99CMC02tfq3CU4POxUhG+Kte4P67Wgfe17slf
	HIhXgz6wnJKvwgKR8KUMhKct1NIFzrgT8Ru9LAtd3FBhVprlZDi/7gkEYfiFCKi83MomD97Jhd1
	wkJUDnwiUD6PzFoys1GtZcaLMoLl/k/vzlb963LtZI5/Wi6VbRYz5TXvg8MaV/ZeWsNzCkYKZmU
	Ykb3IXDjMF9S91ri2WJmMD8hf1+jvCG5tw0KqO0+UizqxUlCc7fARbps+KO909TBsl1mOgpiu08
	IEz78orRADs+G9ZxrG1hP3NDZ0ZGY3YNLXzRSIxTOx5SgWyoW7LvfOeKT2qxc4VV/vA1DwdN8=
X-Received: by 2002:a05:6830:710e:b0:7d9:71fa:3079 with SMTP id 46e09a7af769-7e4f2a13f65mr8565931a34.10.1779037655575;
        Sun, 17 May 2026 10:07:35 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7a4b:ddf0:f61:f58d? ([2600:8803:e7e4:500:7a4b:ddf0:f61:f58d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bc111d6sm6311763a34.19.2026.05.17.10.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 10:07:33 -0700 (PDT)
Message-ID: <57d1d577-39fc-47bc-b01e-a2cc1d2ebdbd@baylibre.com>
Date: Sun, 17 May 2026 12:07:33 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: nxp-sar-adc: notify trigger on channel read
 error in buffer ISR
To: Stepan Ionichev <sozdayvek@gmail.com>, jic23@kernel.org
Cc: daniel.lezcano@linaro.org, nuno.sa@analog.com, andy@kernel.org,
 gregkh@linuxfoundation.org, hcazarim@yahoo.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260517162346.189-1-sozdayvek@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260517162346.189-1-sozdayvek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/17/26 11:23 AM, Stepan Ionichev wrote:
> nxp_sar_adc_isr_buffer() bails on the first channel-read failure
> without calling iio_trigger_notify_done(), so a single I/O error
> leaves the trigger's use_count stuck and the buffer flow wedged
> until rebind.
> 
> Route the error exit through a 'done:' label that always calls
> iio_trigger_notify_done().
> 
> Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
>  drivers/iio/adc/nxp-sar-adc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
> index 9d9f2c76b..ed004812c 100644
> --- a/drivers/iio/adc/nxp-sar-adc.c
> +++ b/drivers/iio/adc/nxp-sar-adc.c
> @@ -341,7 +341,7 @@ static void nxp_sar_adc_isr_buffer(struct iio_dev *indio_dev)
>  		ret = nxp_sar_adc_read_data(info, info->buffered_chan[i]);
>  		if (ret < 0) {
>  			nxp_sar_adc_read_notify(info);
> -			return;
> +			goto done;
>  		}
>  
>  		info->buffer[i] = ret;
> @@ -352,6 +352,7 @@ static void nxp_sar_adc_isr_buffer(struct iio_dev *indio_dev)
>  	iio_push_to_buffers_with_ts(indio_dev, info->buffer, sizeof(info->buffer),
>  				    iio_get_time_ns(indio_dev));
>  
> +done:
>  	iio_trigger_notify_done(indio_dev->trig);
>  }
>  

This is fine. Although we are already duplicating the call to
nxp_sar_adc_read_notify(). So could be OK to just call
iio_trigger_notify_done() and return too. Let's see if anyone
else has an opinion.

