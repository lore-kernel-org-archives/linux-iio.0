Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511913921ED
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780250974; cv=none; b=CkqdwZW8cAX9VDby5AdsBGyf/d5c4iV6LeKglJq4NT22gxyeCcrYMOj6ddfISKe//6Q8DZub2/tJ3BQ2S2d7TKhoGarfrKkqr8WbxRDA6ryfabopb25Nk19oVr2hxv48abfdE5FfDUOBr/HU+8k8cHXoCORnEEw1gvX8e0CB8Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780250974; c=relaxed/simple;
	bh=9/xTQ86TP9KKDpmV3juKQ+8JETyHMqjxNNbNZJQ4CFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irr9WsmvsGNjFA/oHbxEJiPFy/lERC8oF6Co7dSmm8J3/E0Dv5x68wuOPTDFDhyiSTJN8ZsfFb/9pieZmUx7GgR/639NutC7O3xtsOmZTxuu/ls0Zt9iFDkflsyUSPG8mTb+k54u9463By4v5jClBwFLlqBvcGKswYkOs1XW4Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2juMyc1; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2juMyc1"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-6c5a522d648so1497511137.2
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780250972; x=1780855772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+mSzCvroumpiDFsos1xbPMHb6ldCMd++1hsQi+z4o/M=;
        b=l2juMyc1J9PAqFVSPVnZEBF92j/U3Tfgsd9K4jDp1I0FBRq7anTPun4gtWUEvEAPWi
         i2mzgMK91p06VdTgpST8rqwFokqC09vUa2edndK6vXVDYdnfK/CaaUd+7l29cam7lECp
         tP/wuSXKy9N8Z8lZabHVAvqvXtva0JnSvto39CFB1iqh0w22xJih4jvcQ/9Mo98+V3zx
         oXdd9ANYP73RohRayvZa63TwIJnVGcBSvHLDuV8AjJNh5al17qkt0OIt8fsXrd43eS1Z
         GkswvDR4SiBFOwsLxTDUkFgvLln8SjLshsDVB+tGhZW37eh1ahoi8JU1zHfN4/LAOw71
         on9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780250972; x=1780855772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mSzCvroumpiDFsos1xbPMHb6ldCMd++1hsQi+z4o/M=;
        b=Wq2xOphuBeACO4a+wUBQiJFi+dzbKS5VWRt9utvS0E0mOfcBCwtbw2ojqre8ljOCbv
         /vRhmK5xtw59LvcuwLf6r3ONHGEu48VWrcLIrER0j5vsSgNelyiWb4efw6iy8liM0HsG
         RfKwPZfMjzl6nF/LsZ0MBRMbbSx7HoRch2++J1wcBAgW4DCNWElOTpY0wb19gUnSJBLi
         U+hskSN3F8Cf0yAzqQe9hdP7ZJsrlRrSQrMafBDxcMQessE0OhScUX5JCg4W+WPIhvDG
         N/756qZI8uFoUHqLw5gKx4WriGwUyUOPUOTeYxJDh6UUwtu3+3cFhKWFFTY3v3fmmRPV
         oSUQ==
X-Forwarded-Encrypted: i=1; AFNElJ9bwJQORnG3QztxxNS73ZT/q861z6l6r0mAvhklRBfKiaQpf0cwiqsCHPW5St3mdRCR0csXbLfgifg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIbPQA0lNkD/wUg7XaHCTbkUQObsKm+kmyRQW055ZkwgNakudo
	YTthI9D3IpPaE9FRdN5E9jE2Dwsu/Fazdaf+Avrt1IggKbVn++31Mzf6rHy3r/m8
X-Gm-Gg: Acq92OFCuOdtpbh3k3b1RYKQmOwKYveKVB5a+IsQzMKro5PcjgE5EG7uTPMV8HccK3H
	sbjMkszdWYwxt/FbeX35oA7mENHD2JA/tCn6L5PJy2AdQoKnR4pg/mEQpy3w1TmstVrppO1Wxj4
	x8NdH4vduEW3wV4snbpWkypQW+7qO0pjjSAZ6GYd7L8HkPiB5ig6Arlr5c+24s7ZlcxO9r+m+a3
	vv5/4gCC6TdPXdLE6RO9B29z80MQJXOi6sHqQpP58hNpkiz1173wsSNEuJc/9pFD1TydmLgT4ET
	CGubOl7VUu/LGasWeBn/1UoDeUHyLbi5LOtsAjfdcBkDFQwcLJHQP33v6r3ixBqz/paUiT6MbnY
	2MBNcgpOK2rSUPCQY0YGH/Zrfay3Bhb2znkwhO+ARli/493uSsCWz8YF1mi1ibdflnbp0S9hbe9
	Wii7l0LD3/riRqjP1Q199+NuQh/UP8h0BAYpKZt80pRao=
X-Received: by 2002:a05:6102:3347:b0:631:b834:e051 with SMTP id ada2fe7eead31-6c6863e35e6mr3356217137.12.1780250972326;
        Sun, 31 May 2026 11:09:32 -0700 (PDT)
Received: from localhost ([2804:30c:1f02:6000:8b59:7c96:762e:9faa])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6bfc81ab8a5sm4854666137.9.2026.05.31.11.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 11:09:30 -0700 (PDT)
Date: Sun, 31 May 2026 15:09:54 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: types: add IIO_VOLUMEFLOW channel type
Message-ID: <ahx5cuM1xlOVP6DT@debian-BULLSEYE-live-builder-AMD64>
References: <20260530205435.37326-1-wafgo01@gmail.com>
 <20260530205435.37326-2-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530205435.37326-2-wafgo01@gmail.com>

On 05/30, Wadim Mueller wrote:
> Add a new IIO channel type for liquid volumetric flow sensors.  The
> unit exposed via the standard _scale attribute is litres per second
> (l/s), so drivers reporting smaller native units (e.g. ml/min) only
> need to set a fractional scale.
> 
> Update iio-core's name table, the iio_event_monitor whitelist and
> the sysfs-bus-iio ABI document to match.  The new _scale attribute is
> folded into the existing shared _scale block; only the per-type _raw
> needs a fresh entry.
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 11 +++++++++++
>  drivers/iio/industrialio-core.c         |  1 +
>  include/uapi/linux/iio/types.h          |  1 +
>  tools/iio/iio_event_monitor.c           |  2 ++
>  4 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 5f87dcee7..2188557cb 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -507,6 +507,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_scale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflow_scale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflowY_scale
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -2458,3 +2460,12 @@ Description:
>  		seconds, expressed as:
>  
>  		- a range specified as "[min step max]"
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflow_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflowY_raw
> +KernelVersion:	6.19
This is probably only landing in kernel 7.2 (or later?), so bumping the version
seems appropriate.

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw (unscaled) volumetric flow rate reading from the channel.
> +		To convert to standard units (litres per second) apply the
> +		channel's _scale (and _offset, when present).
Early reviews suggested to use SI units so I think we would have cubic meters
per second. Disregard if I missed some review accepting it as liters per second.

With best regards,
Marcelo
