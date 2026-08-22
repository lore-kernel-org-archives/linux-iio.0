Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5BF394785
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787386107; cv=none; b=jWQZfDZuUfgMPY+3d1HMQm41l6fa1zT9Wjwp91XBZEKUiuc/UTFGM6L6vRbCuJouqhUZiTEXNEgxs+oapM1k1jmnfZ6Oo0o+AAbqIiY9PwgC4q5NYD0wWgYsBFJhvDReYUjBOdX9Ntup7Evxr0uvlgm3YRUZvrpZtZq9mx8Yw8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787386107; c=relaxed/simple;
	bh=wqmQ16BAqy86KFYeJLtEnDMdkphx8CsFzjaDh5ONv+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFjVw24eCIyqq1vn6YyiRCM3kunvOwjm119bjhPqf7mc6zo17Q4HK79o99kbGN2WppfEK+9PSpT+NZsZkhWYp9i6SRUl45wk7tfdtySV40liuC/k+hyzfgIG6GRjpIxsh9xIQqx+x1aNLrA/N+czllBdKUsMPauVVVTkmK/MecY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FU/JqV1F; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FU/JqV1F"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a15d54ac95so3244819a12.0
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787386104; x=1787990904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gIM9PtSc7DDddvJO+LR6IiAnlyIuGLagxq0nTtp4UGM=;
        b=FU/JqV1FRV9tY+Yn7qAH7oGHpQo5TFLvPmQtcdHpF58ySScNNR0n/aFEQ5APd5WnBz
         6ibONB+vA1L2HZyjCtykBoXM4FVh+mxKcLoEIBlf0CwOLieEdvZnhEJYYUxX4Py8aPkk
         G1sOBBmS9Lz8oi2aVudnObBOFi1tUIovnJJlbW65PQaWwMjTvZbRkLEAzOLtOmYyA0cF
         pb2sx1LBr3ljml8nf6F65Au1XUCy1SwZpjaslf85QtD7Fde8ym+1BOO5TuaC+ZB6nGL9
         JcGw5Pk34pEwjSVAHf5JtPw1nWkrZf/aABGBKmYxRrxfc1pLCfW2zNCr3YiNSN9O3ewl
         1Jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787386104; x=1787990904;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gIM9PtSc7DDddvJO+LR6IiAnlyIuGLagxq0nTtp4UGM=;
        b=k3/SthsyhuW8AXBvzkXlsRiPLIPvOH+q9W7UcytZ2zXjkDZTIoLmDhEoP0azowv+4U
         UnOdbphGHX4nLFHDpb3tKV1yL4QszAijpbVMJgAqHID+5YtkT4BhBIcf4S3xyiyAJ8QJ
         Z3IbBfmmv6OtB7dglkoYG9Em1fjxrwu6WWp2EWwA7yiR8U0avAz/BhTnWxgHqAZrGyIi
         Jt+lWQEZXOZS7j3ewkTLskN7KqErYQNDjvPq/vof1uiOXYJ1iNwqXwJWl+mqiCQdJZi9
         0i8bawUO42tYxiETjgDeTh50z539zJGO/BPLoW/vaz8kIxpdphCTf/bqvMwamiexy8H3
         2E+w==
X-Forwarded-Encrypted: i=1; AHgh+Rpn7RqFdKkWMVoh7MaLKd8qmO9g2xVyKojW0VliRW3mNzVdVdPmfC+Hr6j/0vM8g5whX74iKWXDWV0=@vger.kernel.org
X-Gm-Message-State: AFuF++lEChgjFXCRfKGaA3aEKmTuzf6CNBTy/Y6wwUfwMyJJh6It00fp
	eLl9JXcpKY4GNAmh2QykSJOuKiPrawT0ih6qXOuwBo2lLsilCyaOdYWX
X-Gm-Gg: AR+sD108GmUSO39258hBqH3petaD8kxE7D5yR4qtea92AEsmN+4mAunVor9xiUH7T2P
	lHE4mZdYeT+FPtA1oxp9TxpS7AyenqsH3FPFSiMhi1McQLf/oujz4imqQrlHeulDJdeCXpIrcXI
	N27aE6nUNoeIW41JHhZcX7CXSblkrUwC9nXzynxhZKggoLwR3EgqXj9J8Ip1SRiztEdgr9894kU
	9LSmBWZ2BB/1QxbhcEmqa8jebWcuMvJgCBH86sXmCc+uK4TsrQXPuN2Qgsbp/tZ72CXfLO1alZs
	zXjbQZNGi8jcN139EGy+bX+E8Mza4nd4Cp3Zow6emPcY3Y2hmtj9SA3Ln8WWgU6yFzbZ57bGlSE
	0aDw0ocaErZLq2sUEcABuwHykBKgkk31ZytqWgpbtdxvaKyhSbGtYaxcOtV8QkAO0gJj99AfGdl
	exq2G6iUDysDXdc2HI1mzDzHOcp08jtZAUl9Doli9NZzS5Z/55BmdBE6vOK3N+AHRm2cRPzwWoe
	KJJelJNjTLRDeKWqHHsTIJnVpRmjW7JMfwVyILsSUNHm8aGh7hbWcK91kbN8we+Pq2sc+IrswfP
	QoL/NDU+6cU0wdsR5q/Hcn+WGuX6AvEzUjWKVQOeEAKvGmI4EVyeBOtyMq7HEXEbSzAJH1eApJW
	iI3l/3FAn5gxq53X3RwBf
X-Received: by 2002:a05:6402:434a:b0:6a3:691a:9d82 with SMTP id 4fb4d7f45d1cf-6a582af951cmr4955201a12.3.1787386103677;
        Sat, 22 Aug 2026 01:08:23 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff178289sm10954557a12.30.2026.08.22.01.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:08:23 -0700 (PDT)
Date: Sat, 22 Aug 2026 10:08:22 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Esteban Blanc <eblanc@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, linux@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad4030: fix invalid oversampling_ratio
 validation
Message-ID: <20260822100822.2a4725d4@systembl0wer>
In-Reply-To: <20260822021935.17058-1-salah.triki@gmail.com>
References: <20260822021935.17058-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Aug 2026 03:19:35 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> ad4030_set_avg_frame_len() computes avg_log2 = ilog2(avg_val) before
> validating avg_val, and the subsequent range check only rejects
> negative values or values above the maximum supported OSR. It does
> not reject avg_val == 0, nor values that are not exact powers of 2.
> 
> - avg_val == 0 passes the check (0 is not < 0 and not > max), so
>   ilog2(0) is called with an undefined/garbage result.
> 
> - Non-power-of-2 values (e.g. avg_val == 3) also pass the check and
>   silently get rounded down by ilog2() to the nearest lower power of
>   2, so userspace can write a value to the oversampling_ratio sysfs
>   attribute that does not match what actually gets programmed into
>   hardware, without any error being reported.
> 
> Only powers of 2 in [1, 65536] are valid OSR values, as listed in
> ad4030_average_modes[]. Validate avg_val fully before computing its
> log2, using is_power_of_2() and requiring avg_val > 0.
> 
> Fixes: 949abd1ca5a4 ("iio: adc: ad4030: add averaging support")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/iio/adc/ad4030.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index 9c5f19321e3b..93d9f143cc91 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -751,9 +751,11 @@ static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
>  	int freq_hz;
>  	int ret;
>  
> -	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
> +	if (avg_val <= 0 || avg_val > ad4030_average_modes[last_avg_idx] || !is_power_of_2(avg_val))
>  		return -EINVAL;
>  
> +	avg_log2 = ilog2(avg_val);
> +
>  	if (st->offload_trigger) {
>  		/*
>  		 * The sample averaging and sampling frequency configurations

This seems correct. How was this found? By reading the code or some tool/LLM?

-- 
Kind regards,
Joshua Crofts
