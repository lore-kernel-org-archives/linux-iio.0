Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FAD47F2C4
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077360; cv=none; b=TEyrNC45fRLBGw9l6sMJQ0UXhJ6zPQgXSDxnpWPKdlCJZdrYLYi0g8D1VisSze6ToBPLCGShkZcbh1u/XgI7BktxvkIX9KpV3q1OCW4LBuHdqUgV6amfr3hTD0K479IhNxZahgX9w75gFkSRy7V40r19vn8n2UYvMUVoHKBtz30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077360; c=relaxed/simple;
	bh=rHjWjSqiO/RT+Ipwv0MHkK/FlE4HDQzsTbGsxEoUoYo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsvHBpwHysT/6ZRNGhrpVsbUa7gYOfCMln2r/nXHnfpLJ10L5YhNKioWyaAFWYvP0iGoyoV8N85L2b6BjNwcg84wJYrIg4glnfXiTAxdZ9UXoVSYPohl+vk/dsOHiKtGFRTbTRk2i5L3nbC23Tg647gAlqjtrwUSsXeLQEmCDu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXGVEKB3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXGVEKB3"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba0714574fso20655405ad.2
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778077359; x=1778682159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xrUI/Uqz/vFYa+7KA4LLhhP51oyCYqZg8PWvjcL8Mx4=;
        b=RXGVEKB3u9dN8cBCctIIUykmUP21+79o7AIDEqf3oo7OPmIdN9Ror0SXHToPCjMc/R
         Pp2PBk2HlqeS3uKy7/j5gcA33PicqRWG67zWQ8jv2Hke2PVMlAg7dJ4tTWUpxukYDVcy
         PPLhf/qa7c4nslOUnhqRtjwd1yMN1YyE7sDMrKXoGReMe0ENXW/Bj/JlRI1bL4y2A7c+
         2HYjTMgXeOCUeyb+7z+ywNVMkk5+HIPgI88IGsiqIq1N4DCgm2fWBN3CNxAZXnBJLWGp
         x937swur9Dur2ZuKbS8p47qk5XfrwQrPdCc/WfZr4bQAQ0oikd2D8nFzVL9PWvJ17O84
         ijqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778077359; x=1778682159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrUI/Uqz/vFYa+7KA4LLhhP51oyCYqZg8PWvjcL8Mx4=;
        b=KJkB5oEA1SFRi02WnmjxEsBGzpPL0c2cBmofp7mXHwZuzPT1bDmp2JshYUpbuuLhEv
         7gZsZRFUhNhzMj/mV/8DJw9o/JN91RW94fCgTV1Fak5OW1nAn2hZvNxI6J+aSAZ9WDS2
         o4smMRsz5HDHPKj7TXMH1T2m00sLO9QMEabZ2Z+yIpo5PA3R0QHJmWI3eKXLqXNofMtx
         d4fDYNlqEqBHZFbGHyi8yYJUkfTedhNZZXtraDMQCGtEq9DQi9yfzmoMadBQKieGbEdu
         FWRoRBXaRgjW2NzPr7oLQX7ktfe3OQp8ukBs+nFR+i5W9QDDq6sdO6yYbNBYylF+QEPQ
         DUFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+CublczyfrhR2JpyMI8ZTkeFMSZ1G7tjKAXKmKZRa2PlYEU5NxSZTlbYlxjjaQrK/oNf/e2iJlIy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoEB8PKmcB/Vq8Gxr7fybklZImpxpIf2D0RCVBPDUUTh+apb9n
	nruc4L6MrLM5zwM5KZRC3BddTEQ2CIa48+e5q9Hrq0u2lb34ksxePXAm
X-Gm-Gg: AeBDievsvEsP/DikTxEmf8jriZiN/gvWqMmPSNle8iyfxvmQy7wMejACdBS7cDWa+iE
	nO09VXanrm+gLzz782Sb8+S7WOuAVd1pULIEJtBx1pAv6hq4X4RFNKvP7xr8GNedc9jUrya0ZYk
	ypqo8vkpPSqF3j5RJQ3fN8lxbOSWVORDq2V/62nfk4/JPDv1oULFL7ktWxNnSp9KsX8Lb2kxyXq
	Ceyw1jIMgSpEuMC4xx7UuOBm0kq8z1ebOMIEyKN2oqipX2ZLIh+iyy4yVGABudt3PmqxJpE4NaZ
	wUNpDDLJPWNxMwUdgKsnYLHjFsirX3KoDbkpyeWsBxOeqxuXmlsjbhVfEPjlZSn+VhMu7LlKSkw
	RxxqdrIfZs4GULZGaNJlyzID58C1YPg1NV0tQKQ1LtnD0B00j9DeYXNOlmdYXPzvFR8MFWXxDOc
	PfiIjcPGa0zqJREnBW83A+qko5tSR2Jz11JPdGqn/HyisBWEMGrO7ejhgYZ4j39zYGwYbzkfmpA
	oJg9H+mWd/ub4788ooe48CskOz3YROEcn9pMn8bgYeAdHPo/CYhd6OJu1yz
X-Received: by 2002:a17:903:1c8:b0:2b4:65d8:6a20 with SMTP id d9443c01a7336-2ba78f50177mr39936015ad.2.1778077358538;
        Wed, 06 May 2026 07:22:38 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7ca10cf3sm34331495ad.59.2026.05.06.07.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:22:38 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 6 May 2026 15:22:27 +0100
To: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>, 
	Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Michael Auchter <michael.auchter@ni.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v6 10/12] iio: dac: ad5686: add control_sync() for
 single-channel devices
Message-ID: <cvsuzh3gimiihkxe4i3spc6bmvpws4qzt4vhhmoszoesrxld4c@6p2lnq2klj3a>
References: <20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com>
 <20260505-ad5686-fixes-v6-10-c2d5f7be32be@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505-ad5686-fixes-v6-10-c2d5f7be32be@analog.com>

On 26/05/05 01:35PM, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Create ad5310_control_sync() and ad5683_control_sync() functions that
> properly consume the mask definitions with FIELD_PREP(). This allows to
> reuse a function that updates the control register with cached values,
> without relying on confusing logic that depends on st->use_internal_vref,
> which is initialized earlier in ad5686_probe() because it is also
> applicable to the AD5686_REGMAP case, removing the need for the
> has_external_vref. Powerdown masks initialization is simplified as
> *_control_sync() masks outs any unused bits for the single-channel case.
> The change cleans up ad5686_write_dac_powerdown() and ad5686_probe(),
> organizing the code for feature extension, e.g. gain control support for
> single-channel devices.

...

> @@ -471,13 +490,12 @@ int ad5686_probe(struct device *dev,
>  	if (ret < 0 && ret != -ENODEV)
>  		return ret;
>  
> -	has_external_vref = ret != -ENODEV;
> -	st->vref_mv = has_external_vref ? ret / 1000 : st->chip_info->int_vref_mv;
> +	st->use_internal_vref = ret == -ENODEV;
> +	st->vref_mv = st->use_internal_vref ? st->chip_info->int_vref_mv : ret / 1000;
>  
> -	/* Initialize masks to all ones provided the max shift (last channel) */
> -	shift = ad5686_pd_mask_shift(&st->chip_info->channels[st->chip_info->num_channels - 1]);
> -	st->pwr_down_mask = GENMASK(shift + 1, 0);
> -	st->pwr_down_mode = GENMASK(shift + 1, 0);
> +	/* Initialize masks to all ones */
> +	st->pwr_down_mask = ~0;
> +	st->pwr_down_mode = ~0;

Sashiko's feedback:

	https://sashiko.dev/#/patchset/20260505-ad5686-fixes-v6-0-c2d5f7be32be%40analog.com?part=10

	Does initializing these masks to ~0 result in writing 1s to reserved
	hardware bits for multi-channel DACs?
	The initialization loop in the probe function only updates the bits for
	active channels. For devices with fewer than 8 channels per register, such
	as the 4-channel AD5686, the upper bits (8-31) remain set to 1.
	Earlier in ad5686_write_dac_powerdown(), the transmission payload for
	AD5686_REGMAP multi-channel devices is extracted using:
	    val = lower_16_bits(val);
	For a 4-channel device, this results in bits 8-15 being set to 1. When
	st->write() transmits this value to the AD5686_CMD_POWERDOWN_DAC register,
	it appears to violate the hardware specification which states that bits
	15-8 are reserved and must be written as 0.

In fact, DB15 to DB8 are don't care, so this is not a concern. That is also the
case for dual-channel devices, which requires unused bits to be one (gap between
channel 0 and channel 1).

...  

-- 
Kind regards,

Rodrigo Alencar
