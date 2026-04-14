Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C99264619
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776185056; cv=none; b=ET2lZd4S5UNBabzdrXccMdwXGqE9trAkSTluEXutBu+sR8cIqv0iCc3m3OzUAmgj3w+TBLnh8FTodw/hHXx0KRQn7yT+r7EyEyMswGaLxjxZBhPaeWkiBibGZy6lW3MCPL8yQi6lRnt7+2J94NBXUepvrUjb80h1aH2KzCJmTpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776185056; c=relaxed/simple;
	bh=i4KQwkIap6IvD8uRPHLY1UCwRBZH1zADMa3/wRtjsLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMGw4uXTqIDHnSShj2IwwOBB6sggge2D6nnfoAw2xauqggh1v46sbhg7EE6xXh2LmDbG5m1Kg7L99Mu0Q8xCyBvl5n7tE0GJtedi6ChA2opYQde5gceKZLc9H8Lm+20ZJpZKKrtrVRlB6dyiAUW1Lus4GTwP0mcj3O+fNTxOyJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJ9zW16Q; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ9zW16Q"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c76b95e652bso2514844a12.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 09:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776185055; x=1776789855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0v5pdTBRiwulMsfGJwsXdYIRI07fHSulknVhkgAQPRI=;
        b=RJ9zW16QCSvoIGEQyFommjxpuYWq7l8i9+G0+x0DG0fu8BmzwORS1x3HO/APuQGA6i
         6gLI4l98MH1nH8DA7fHSo1igy4+z8Oli+jcASWW5CQVeCcpTOzv2C4rlABPovQzX7+BM
         M6WWhYlBFBTJ20CJeAAj2+SrJjvp6t+AVJOUPmQStsOEekGhriN+D4pQR0oPldwPWT9x
         OlIqFjWlUYc5dTSkYFnoGfTU+EQs9tDTCtkUtgos1YayRO51XevUKBuqPR6o6utRTUm3
         N0Vp9phhTgehPBNtTUrhxmdAL1bMQ7/XilAFyNRvKHW1m+jE9px3XitZU4xsufRuj3yC
         D9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776185055; x=1776789855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0v5pdTBRiwulMsfGJwsXdYIRI07fHSulknVhkgAQPRI=;
        b=ivIYp4a+a/nHMOmG/VXxgSz/WtfvxbuPip/2VKn+EebLgF6F5zkjrnOHz4ADLmVFyI
         1xPAibvzkIrokzrZqrOilBN2GRlEyvXuIIVUlE4otEl84rBfEUh5Tcohutul0PC6zM3L
         ej0BEERpWV3X/Q5IYD8de/WZpDpP0weQfnPkqJ9XbV974sttJeTy/VuND81t5mIaPEGd
         yE3KtTrDuVsS1HOrtMDfGRoZV5l2ThmDrM5PmD48ShtSSa4/L9VBpQlckPVg5pb8MNld
         gAZfzJ583MoqfuAghTaC5KKrLs8gzTrKH0CbuUberwxPs0bhaP/ZzxScV+45OYKpNmBD
         x/GA==
X-Gm-Message-State: AOJu0Yyqzw7SEELx0Nn3jTErhDtFLbfuhmfiWKwFk7qgQVqOn5mig3iH
	E7AY4cu1aby27LMarwW6BqJHzKEpxpbejJJ4CnTJE+wwCAaxSVbR3XU=
X-Gm-Gg: AeBDiety1VvVxe0MEjwqO0gbgwu4Qx0aA3gDNciFjdwg5Zf07Dry87lJ4Wub3aKyKDK
	VdfKyT1eHzkEo3JxvbdDN5LRv27Zyi3/2mTW8PsvDu/y54jyJ6ccQ4CujVbrkJrP4EnKAsdDPki
	PT4/zpuyt9+UJcqehOobsyynCfSqJp5q6e/Ns1zYrhJund9zwuRvDa+vubqYz0O7c6UPgjN1/yS
	mX4w12atRDwaB0hkyTda4YKuan62K6XmwMNPAFPuYvzo48hGwKtzSVrjzjyfPeCcOtYf1NBdZbv
	O1/VI4e4AxE9lj9zz4KurSI1nV8xD2EtblCQtUn39K85s7/NttvNN3qqpAdQJNbthFkW6eKSnbY
	XwyVNwp5p5rMsYgrei/3JMAkv7UlKJFWKp4dBub6T4yFeXw2kbzC432FXuRKhZYwNRhAAshXGRW
	HZkFerJf911gW5sxdRQXyp/zFFVHETxvdLe4jlCnKkN2IHItVQ
X-Received: by 2002:a05:6a20:7354:b0:39b:c469:6c81 with SMTP id adf61e73a8af0-39fe3f1a673mr19565053637.33.1776185054605;
        Tue, 14 Apr 2026 09:44:14 -0700 (PDT)
Received: from localhost ([101.0.62.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79216ff41dsm12095653a12.2.2026.04.14.09.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 09:44:13 -0700 (PDT)
Date: Tue, 14 Apr 2026 22:14:05 +0530
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH v5 3/3] iio: dac: mcp4821: add configurable gain support
Message-ID: <ad5u1Z4pgkjN36sJ@nik>
References: <20260414092254.34883-1-nikhilgtr@gmail.com>
 <20260414092254.34883-4-nikhilgtr@gmail.com>
 <dd2c2d45-ea48-4024-8d35-c3f482515fd7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd2c2d45-ea48-4024-8d35-c3f482515fd7@baylibre.com>

On Tue, Apr 14, 2026 at 08:57:35AM -0500, David Lechner wrote:
> On 4/14/26 4:22 AM, Nikhil Gautam wrote:
> 
> > +	*val = div_s64_rem(tmp, 1000000LL, &micro);
> > +	*val2 = micro;
> 
> Technically, IIO_VAL_FRACTIONAL_LOG2 can print up to 9 digits after
> the decimal, so this would be safer to do nano instead of micro.
> 
> For that, we need to also implement a write_raw_get_fmt() callback.
>

Thanks for the suggestion.

Currently the driver uses IIO_VAL_FRACTIONAL_LOG2 for the scale
attribute this format is sufficient for all supported chips
(8, 10 and 12-bit), the resulting scale values
are exact and can be represented without loss of precision.

The write path validates the scale values based on exact matches of the
expected values, so additional precision (e.g. nano) is not required.

Using INT_PLUS_NANO would also require changing the existing format and
implementing write_raw_get_fmt(), which does not seem necessary here.

So keeping IIO_VAL_FRACTIONAL_LOG2 for both read and write paths.
