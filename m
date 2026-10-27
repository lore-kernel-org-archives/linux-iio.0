Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793066948;
	b=svV9yA0FHO+KxizQuESp/N1I6LuDmen2dh0laowQsXzUBDxGwdlOAx4ZOCve7aSMLTsY
	 x/UBPawLfEeXbnrOSq5KxLKqOCEEnctz5aWYvQJsGeB7FbxFMSzE9xulAn6uWohVGvmwp
	 b12/y+3GmXhZnmmh8XNQGHoKU+8IFhyKa+E7MqNBvz9KVHZsCAkNvfOObCkgFAkd68ON1
	 32Znytv+NJzj5I4iXDWgBPY5Y+gdVx58HFqIFs6pmxIdJ47kIvTpn9r/qwwG6LaEUGYMj
	 CV50L7dMuP0N5hsU4DzDznU6JwDc8QX2Tl9RjvD0iBchsB7ZF7z9xGKxWhtwCWunYiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793066948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:Cc:To:From:X-Mailer:References:In-Reply-To;
	bh=0b4fB9swGVBBbGBZ5tcCFpfaDUC7Y/M3lrrwFNgrSLk=;
	b=uX3PG4qaejuLtG+IpkVAgrRMekdA2TgygeOPLso7ro3PSMnGpANaFOzyHCSvsab/4vxN
	 znQVB66jsFX3mr4+A3fnBwbGQJ3CT+wqHY2jaujAE2XgoTOxM3Bkj3KJXjwiJfLjKEvTO
	 mXXN5ziT0IV/dYvoSFj2QUqgVhef2vHtyd+GCp3PoUYehWuoF1s3jrraQSLD1K7PYgI9I
	 ZkaIJufng7sgDEZECIt5JgpCwhrqWGln9/Qz0plAHde467NTQzaDO+yS724LMDDMeChjd
	 ozjezqH/dwrfL6xGat9zLrFHAAsAUzzvFudHD98oNr2lOBVdcgXOEoqCzeaI8OgTNPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H6wgOr9+;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38881606A31A
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 02:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38881606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H6wgOr9+
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b0a921ee46so29533737b3.2
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 19:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793066947; x=1793671747; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0b4fB9swGVBBbGBZ5tcCFpfaDUC7Y/M3lrrwFNgrSLk=;
        b=H6wgOr9+AyNC9LLK19GNj/VcIzJg2qede+mKus2swpC164keT5eYwdWlx3z3X9Nts7
         k4StoOiEwq+YOjRPYeqNL2E9+3bu9+RQSvC6/Td1D5CirJDuPmdy9/rhLU3i1PfB9CNM
         oSZh7qTqOrJM1sRB1ZfPPrbGHO02JJNQ1MiyoOtAqAxwPZ+3Eb0R2f3xX63f8gmNods2
         +E7PCalHgkTSDFY8f/K7Hl3kKs+VVuiKmxjPhT/HU2s+Xdhe3+x9i0lXJqm+IU3g79zX
         MXt/qOgX21Drq768Zw+XG28Vt5c64UekCLElqKku9CUFZUhst/zPm50dhidzrLqlJqmX
         tbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793066947; x=1793671747;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0b4fB9swGVBBbGBZ5tcCFpfaDUC7Y/M3lrrwFNgrSLk=;
        b=IraxpKVPEZsy+JihwhxhpeHM2lhjyl81JWEzPyzCXcSX/PP3qyce09kTRWsvxA/t+7
         3UT338ozbhEDtK6p45csF+/cUCmWqSLj5cdFwVx6OS4LbozKtuyyGJstJ/60k+ogdt4H
         3xTfN1VfhmAu+hHna0I7IwF/+RjzmXaeWtHn/m5rYREMysnFp1QtfAaBN6va+v50orbr
         n9TlGz43gYfjMxznd+q/yGhFMCjptXckrsWGCSuddnIWqhcuyasCpbx0BofissuOFbFm
         Y8Q+HQO5lM0PkXNMY4EURs79FoZCHCQhzkPgP+BRx5XR3lpO6htWCBip/BPBQqAMwBjz
         YUfA==
X-Forwarded-Encrypted: i=1; AKwUvBwHdE/FVB6fS/An7AJ7vA9XeYb7iW43i0+c8jEQWnTlAdkXq9mqYRe9r1ioaTApwbddVLzZ6AA0SgA=@vger.kernel.org
X-Gm-Message-State: AFq9FYICJd7YM9+ZhTMFPJMqfq7YjPKEPk78+7NUvJhdnU7R+VGOeuNc
	8p5K74tdPFyNH8gryiBiorIhmPnFHKZoW2tVDOiDx+NxbXa5XDFl/eLh
X-Gm-Gg: AYBFou2sclXF9h6bTRfWq4DivGjbk6h8TI/2EJfvJSdKKqCDEGniw6G9qH9ssRnugT8
	1rlSNxftnlQr8fexQtksdbjXfvz+wh2UJpT9pcc2FuAzHOAfDumzsjBSKWCVKti0cRuvfKnGj/X
	ot3V9nZ4V0bHjHPfMqojV0kIfw49YvxH140kWa02fvosD5efbhgOdd5ZlH2Ucrok4PdJXkJkZNm
	RYZgyKpE7hMXc2Zr8RQSJ1F40S70gBwqgWMOcbSyL4yqLZ8ezyjPDJ/ZEEsOqfcp5R2fiOJhLXV
	qHDZHaqWQ9f3fVB9Znrk2KoAJt8TinygMVxSLXzkiW6x+8UAVGFmLnul0nh9E2piY3RqCYzYkGs
	RGNFkIQy/AZZ1B2cX5ZFWucrcJZSPQcRvDNXJea8LMGgIMm3DusqV3SkaLryX525q0zeaQ6+avB
	EFtje4/jgFo5KDn/VeOZ2R9N/vtWuA/BMLAN+JaYgCG8OB5zIB9AwnswdNHuyYuay8CQVzsyVh9
	8COe3uKZGA7N/EBTWkzr5BJrpawtyJvfdlQ32YBKfxEkBuzG1NZ4DzU6pyf+0s3a58sSS7qAT3b
	pHasWlyXXtWiqCXMfCLaYbSzL81k4hmX450en84gdvjd9RQ0MNy1jXYYVc5N6AJNTMM=
X-Received: by 2002:a05:690c:397:b0:8b0:a08f:2ace with SMTP id 00721157ae682-8b166bb0075mr57024907b3.42.1793066947082;
        Mon, 26 Oct 2026 19:09:07 -0700 (PDT)
Received: from localhost (host-209-35-187-178.broadbandcancun.mx. [209.35.187.178])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e43e1d2sm5153797b3.5.2026.10.26.19.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 19:09:06 -0700 (PDT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 21:09:05 -0500
Message-Id: <DMF96N121S91.1V9U9PV9TT2FH@gmail.com>
Subject: Re: [PATCH 08/39] iio: light: as73211: use
 iio_push_to_buffers_with_ts()
Cc: "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Christian
 Eggers" <ceggers@arri.de>, "Javier Carrasco"
 <javier.carrasco.cruz@gmail.com>
To: "Jonathan Cameron" <jonathan.cameron@oss.qualcomm.com>,
 <linux-iio@vger.kernel.org>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.21.0
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
 <20261026-iio-v1-8-8b136778eedf@oss.qualcomm.com>
In-Reply-To: <20261026-iio-v1-8-8b136778eedf@oss.qualcomm.com>

On Mon Oct 26, 2026 at 6:05 PM EST, Jonathan Cameron wrote:
> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
> which is on the stack and local to as73211_trigger_handler().
>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> ---
> Cc:  Christian Eggers <ceggers@arri.de>
> Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/iio/light/as73211.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> index 67f33bbe1c13..675866029cd7 100644
> --- a/drivers/iio/light/as73211.c
> +++ b/drivers/iio/light/as73211.c
> @@ -695,7 +695,8 @@ static irqreturn_t as73211_trigger_handler(int irq __=
always_unused, void *p)
>  		}
>  	}
>
> -	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(in=
dio_dev));
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> +				    iio_get_time_ns(indio_dev));
>
>  done:
>  	mutex_unlock(&data->mutex);

Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
