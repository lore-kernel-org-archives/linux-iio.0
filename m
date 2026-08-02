Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ADD2DD5F6
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785683680; cv=none; b=J3X6A+CEDMlZcHAMGrcggXyCiHDorBRLtQ6Qh0SU4G7HbYYY/bj5PYbUhZSVX5Ls4aT9vvpS3NxYS5MD5lcLy91CwrorvzxvygNAnvuxLs+ivqpf4+8fEFxMrzX3iOjHKORdzWYHx4qWdL+STsFbWH62R1YDB2xPwI6xcIMZfQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785683680; c=relaxed/simple;
	bh=PLLcLqMx1gfzbLZ/bw5r7C+UIrKhF4+HRnGPl4TA7eA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hy5MI7w4IKoJUMDy/A2fYhvoLG7Vrv8fQeDCYoAWMx7lUR8BwsLS0FTW8VHk6/+GHx3q2WKZltUXWtktiQfymy/mIf0+4Kb5e87XLO/hcSMvQ9xw7qOuH370iAgI4vyWCp71QqkZwTeTlBSP+NegVlKxC8/dKzIkOHkTSQ5hZ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LPcpvGxH; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LPcpvGxH"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7eb42a2f5feso1281730a34.1
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 08:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785683676; x=1786288476; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rr0TzZh8MRzpbub91JNUFmvt27M8H9CPFD+akea5yMo=;
        b=LPcpvGxHLEoRq6QNUt4ikhJcW1nEvX0ktgo0ByMtsEabEAtMoJzc2BWdt6eKgrd9Jo
         3ps+Kz6yXLTQCMvl7eH06dfuYjsOL0/w4lxQ0Ds4M+1/I5PzhvTcStBKhoiOt7ancXOh
         7GvNMsDYXrOn6vqS2lRU+wvQbga1lv2rOgHoI32uXQMfVWnYngKeoxqtBNXdEG4az0FW
         hS3GNTU0+76baS2y+epitph9bXHw+AwtiyhD/kFHOZdb8rC7sDThdt8eIJQ5cdvgoays
         DNUFwOnXEdhos4MtlvT6eSBtN0NxVlithYm9JNkgLEi7425YDBaX4sOp2huU8SeBYm/D
         kpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785683676; x=1786288476;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rr0TzZh8MRzpbub91JNUFmvt27M8H9CPFD+akea5yMo=;
        b=l4rA/SNQCK/tpJ+xpgyEaTthDQI0VFCF6YM5ebqRWmihegxD8S4PLMBxrDu0mDUAcm
         DXtZsdSEyGLWzJptwy8u1fg6dVaRS9ELGzpmvk4i466gnsdEzuMVflMw8tsHYcvt8dHM
         iCkiCPJsmBGNSqd3pSM334ac5geXbMFgC7r/qHMSaNd3SN2qwvBB4RINg7SVsSsTlwDf
         oRLI0PvzrAk8QIBDWff1v4tSptMUDJ8kHkgivfgYI6tG71HreHRvL6YIIKiDAgbTUuD6
         USxhwCWsElRYlIKZBeeQFWjNK0/Oo66iiUi/6YhrwsgdAyYEKds1b2Twbj/kAtyfvf0Z
         AOKw==
X-Forwarded-Encrypted: i=1; AHgh+RrmqaNaSKdzWwEQsfe8wR6hnP9fPSEQeZ1do7TohsX3IOsMbyiLMGOz0ZcpHetyXCL8BOTO4mfydig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0kIH4Jo9KogQ75QQQ/gFxJ5x/exFzsVm9vw585UGfxRiqDubY
	4vm3EkC2drZ/ldp5V5kACCj+ss9ZUUftL+KsriErDKYVzz/Fn4cBYDRZ5WL6rVGIWEI=
X-Gm-Gg: AR+sD10e90Ia+A8KkEqCOr0WaWGnTfDunTv10T7+aRVZt7P5bV/5y105tlia2phcIkZ
	k6V3OkTI4PlVrfns7a/NieQ+63jPj4taDiCTqhwV6Iv0E1iFKVrDIW7Lz+bwuykZJKeIvDRcdOb
	osvlYAqvXOY76n00P1dz1OKCkhH6nhrN1sKL06fRD1xkN69ZQrKLupbc8tXZh7TnxdMcUi8OT5g
	Cnm77ouZN2xlmr545ctnTCNBlBuyAjlpPLrjLNSf7PkIpqHqqYbE9vB9EOqGGnSMUidn/L9S4eS
	2y39QtXD/OoSvNQd0LdbXPQ2RjkGfYC+OrG+XXNRdx890iK2db2GVODoXCUqiKWggxd7MpZIOmT
	9/pKsBKgLlIVSigVkGu2kmqXG0h9g7yEwa04i3NfRI14IYx24KHiF76qodSeePF86vPChOGlqOg
	hvz4MR6VcY8ym276DPCdZxisXLab/SecL0YV4wSPmtOEbJqZpos5dp+zEf8OujfLIzycORtHXfP
	Sp8tHCmHoELG6CzvJM23KoykMqQspc70YuFLno=
X-Received: by 2002:a05:6830:2409:b0:7e7:8dc0:3951 with SMTP id 46e09a7af769-7f196cf6adbmr12788526a34.8.1785683676486;
        Sun, 02 Aug 2026 08:14:36 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5487:2b6e:1057:d3d3? ([2600:8803:e7e4:500:5487:2b6e:1057:d3d3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18e8cc0efsm5219109a34.0.2026.08.02.08.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 08:14:34 -0700 (PDT)
Message-ID: <349e5f1c-b162-4e10-a4b8-87c2c3b83554@baylibre.com>
Date: Sun, 2 Aug 2026 10:14:32 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: chemical: ccs811: cleanup checkpatch __packed
 warning
To: Adi Nata <adinata.softwareengineer@gmail.com>, joshua.crofts1@gmail.com,
 jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 u.kleine-koenig@baylibre.com, email@sirat.me, mazziesaccount@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev
References: <20260723235312.432a895c@systembl0wer>
 <20260802022559.23138-1-adinata.softwareengineer@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260802022559.23138-1-adinata.softwareengineer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/26 9:25 PM, Adi Nata wrote:
> Change instance of __attribute__((__packed__)) to __packed per
> checkpatch.pl warning.
> 
> Reported by checkpatch:
> FILE: drivers/iio/chemical/ccs811.c

This same feedback applies to all of the other patches you have been
sending. Making checkpatch happy is not a good reason on it's own.
Find out the reason why checkpatch makes this suggestion in the first
place and use that as the justification for such changes.

> 
> WARNING: Prefer __packed over __attribute__((__packed__))
> +} __attribute__((__packed__));
> 
> Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
> 
> v2:
> - Rename commit message to include driver name
> 
> ---
>  drivers/iio/chemical/ccs811.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
> index ce7187ccd706..0e5c79b775a2 100644
> --- a/drivers/iio/chemical/ccs811.c
> +++ b/drivers/iio/chemical/ccs811.c
> @@ -70,7 +70,7 @@ struct ccs811_reading {
>  	u8 status;
>  	u8 error;
>  	__be16 raw_data;
> -} __attribute__((__packed__));
> +} __packed;
>  
>  struct ccs811_data {
>  	struct i2c_client *client;

