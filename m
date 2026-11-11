Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395857;
	b=XTJqNiEJcB3idyj7OTtgZqlorwU4lm6yAkNCwrQzq3j5W8erIwz8SB0alSPk9frCjzo1
	 2N7B75rE9V73L0yw+3u7NfI3SzVCQOxDIDiv+c3JauEDYSrOp+m2tkdg58GCgxL0x6Dxp
	 iQVwQO6IB9D6Y7WoP9XbfVw0A93GRX+yKQR+LTL6aqZxJZJwcdDNqaPVsqm2masyl5N1L
	 SfjqlICE9ovqNeabewx9KYCocsWAg+bxfSGTxHDSpfP64z06QF5EXSsqgIFQ0oT178p/J
	 KLM2syuyDJ0jhecFbO40dD/bFE55u2Hf7ZDKdI3zSbzAxaVVUn5qpqrrqnTQkBbTQXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=f5dZF2vX2WwRp/FVprc8N43I5ckqGSvz1h8CuNziLMI=;
	b=gUc2QmS1+fZstdwpYjEQibmqg0opfM5jm4GkZrrz2aaFZycafLQ43Dy/eiW92sS5gpam
	 v6xqYHbpHT5Pz56GCKm0B04ik5txwyHvEtL8vjwMzsAT3zyswcGebmucZCMo+FFoR7XSX
	 Av+1n8ARFJnQrDNmCiCK+It7+/eZrnXlSh4rzxKXP3GgUvQqMUdbRtmx3pB2I2pIJ98LD
	 1gXN6kfvDU4H/FlC2t69G17n7/AySOyRaBeZiWgokYAB7eKBeHH1b3GO4SNi0TGeG5CXJ
	 JtgDUysyIaBM2HN9LZ0P9G5xvE5fGy/CNsvMVfE7szMu0GXT77sLC7INvpbNnR/15DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yS+VSfDO;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1301606A88B
	for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 11:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1301606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yS+VSfDO
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so2609928f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 03:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794395855; x=1795000655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f5dZF2vX2WwRp/FVprc8N43I5ckqGSvz1h8CuNziLMI=;
        b=yS+VSfDOsq1WLdyrZwKIJxqv2qunddy0oQ0ymczjrymHt2ruUc1tPU0jkyFn4Y/E8Q
         vgqP+dxu3qNOcnGjWSR/DHGVuFnV0Akp4ZRHvF/nerdOVAiKxhAwphMT6X4YalB+qrrq
         QqizBOm5ocpf3q39ruO9u6pGBVL/BSVKKMxnpwjMD5SaeiLAvaCyP/S+761l3IDKp5zN
         cJ8H+10t0pPbV6TO37Wk36Z9GCpcQ/GZFM1RgQPj0U6jALN80usL22+15mbxQB5j+YoR
         jMGXU2rJqsZJOU3h9VSUfeQJKJMPDITuPgJ1uodOHyVVXaL2X4mCMapWC9szvsYJJ+rc
         sXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395855; x=1795000655;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f5dZF2vX2WwRp/FVprc8N43I5ckqGSvz1h8CuNziLMI=;
        b=i/CMc98G0uVbZ8hzecP3PiPf4CL1ObbPKe9iYkdcFtrJ5ORGqgqaYZw+NMxofH2ZWz
         ejTIXWAJ8Q3MkkivJZv96N5x6nmQOG30D3e4gefjYVWpRQ4tLgwTDv3zydFOFs1Ud4dN
         VyvNaiUVRUyyhHDVLk45DDWNrXcKaKPeeOgDKWIlxwDwYkJD+vx79QJHPZ7Fcdk5e6I3
         5ZDyDUk2kPlejKWgZE99vD063/dvAEYdMh4Cs0Lt8EBoPnUBNj3RU04W9/ojJLslidPZ
         FCdxRyOBXsrG1wesuvvHtVyHSTrtuNbEjNDJEI0LpBK5au1fO25RM+91w5CGk54rynPw
         WI8g==
X-Forwarded-Encrypted: i=1; AL+hErHg+/J7UqeJjer/i4S730q7ok1StsJvE1z7pg2A/lXCBeScLYSIQVo7T5i8BAQEdBaVAL3lWCqjNbc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BIdTsvsCLRXdPmfskKCGlK//boPYH5pYtqFAtkax8s5r5RQ3U
	cJ9vfRSYBddyPnnOla/uiqI7N4i+i4W7wV9Mzjo6qjQ7RMBdL+4YZWsc
X-Gm-Gg: AYBFou3UjVCtvkt+gBH7wJfH73lKvGsGVc1Bc7ZCkatUxvB8K1dQtKe13JWYq2rnV+e
	pfIqP4WRVBBBdeS4M03nnFbrSGb8p6iLAIzIwWe0K0nhUXwFRc8f63gYhr2cwzzkRSs3NoG3jkV
	P7SLX85IiarYwCO4b/FDa9Sxgr+L7bMPzlMxxxpBucBAbjNohV2CQAum91XdMYicxEGmnPmw+sF
	E+9/hGuq3/YvQ6v69uMOBOpqFTvlaUxyvbRGMeS++gA7WknBXGVAcKmuMbzINF038hYMPUEt57U
	NuiErJhqB0hyxM3nRF5oik89F+6WWjOR4f8SGyJzzeVU2jTYXgu76bam99Qz9OuiqfFTgV3dL//
	Fzt/o9LZC/ydm86LZnBIF84BwZEg4vuVCY9kMYVYtcq9eblL/hNZi/4nSGQ0wVk6/h4dbIGmnmp
	6up12QXVXwmqtYVKg3r9kInSCxg/1XZHUy5QOf6/YUeCyuWMfoEaX3p4sR2avVuuFCTR3CreDsW
	oH3d60fImiDWoNXKSd7W66P+s44AeoW0hPLt42d5NU3dtHnm7R/3l6WDvGcwkITV9EBvBP6+g9K
	vAjbJA60Sco8DBBEOfDh2oXUeU0IL3mgVCxPnIwBbfPQH0jr96w8d2my0gBBw2UMqw==
X-Received: by 2002:a05:6000:18a8:b0:48e:4115:f3e8 with SMTP id ffacd0b85a97d-499c70828bfmr3850067f8f.27.1794395855165;
        Wed, 11 Nov 2026 03:17:35 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585c4fdsm10587827f8f.10.2026.11.11.03.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 03:17:34 -0800 (PST)
Date: Wed, 11 Nov 2026 11:17:33 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Di Wu <diwux@google.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, bleung@chromium.org, groeck@chromium.org,
 tzungbi@kernel.org, linux-iio@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: cros_ec: use sysfs_emit() in show callbacks
Message-ID: <20261111111733.678199a2@pumpkin>
In-Reply-To: <20261111072608.3490763-1-diwux@google.com>
References: <20261111072608.3490763-1-diwux@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 07:26:08 +0000
Di Wu <diwux@google.com> wrote:

> Replace sprintf() and snprintf() with sysfs_emit() in the sysfs show
> and ext_info read callbacks. sysfs_emit() is aware of the sysfs buffer
> PAGE_SIZE limit and is the preferred helper for show callbacks.

Reviewed-by: David Laight <david.laight.linux@gmail.com>

> 
> Signed-off-by: Di Wu <diwux@google.com>
> ---
>  .../iio/common/cros_ec_sensors/cros_ec_sensors_core.c  | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index d03e40c91582..624d4b32b034 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -149,9 +149,9 @@ static ssize_t cros_ec_sensor_get_report_latency(struct device *dev,
>  	if (ret < 0)
>  		return ret;
>  
> -	return sprintf(buf, "%d.%06u\n",
> -		       latency / 1000,
> -		       (latency % 1000) * 1000);
> +	return sysfs_emit(buf, "%d.%06u\n",
> +			  latency / 1000,
> +			  (latency % 1000) * 1000);

At least two of those lines can be merged.
I think it is 86 chars - maybe ok.
Personally I'd split after the format.

David

>  }
>  
>  static IIO_DEVICE_ATTR(hwfifo_timeout, 0644,
> @@ -165,7 +165,7 @@ static ssize_t hwfifo_watermark_max_show(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
>  
> -	return sprintf(buf, "%d\n", st->fifo_max_event_count);
> +	return sysfs_emit(buf, "%d\n", st->fifo_max_event_count);
>  }
>  
>  static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
> @@ -465,7 +465,7 @@ static ssize_t cros_ec_sensors_id(struct iio_dev *indio_dev,
>  {
>  	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%d\n", st->param.info.sensor_num);
> +	return sysfs_emit(buf, "%d\n", st->param.info.sensor_num);
>  }
>  
>  const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[] = {
> 
> base-commit: b70566610b48ba49dec636019da4d696db64b085

