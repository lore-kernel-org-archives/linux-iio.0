Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13825493627
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 23:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787441163; cv=none; b=Ug0avuFnmCclpQZd2RToRekmXh2xbYOC6Go3VDl2nuRSlc91QLG/kvkMoH81zN6Mkr/Dkp37SwW/kRIAQdj56l3I/byoWEPNhaoYW8T0c9ox73E7+datxNVrbFLcbDqUhvVDMzFigS1mEVOXYSR86DGESN+aMnc0XZbAcKpI/5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787441163; c=relaxed/simple;
	bh=Z0BHmih3zwEKVf1UIhHjS8FRlzSBcON1os9HbVW1lco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qv2oLIUTiO4qWz474hfuNJrDGKcixn0kxkaCaD5ZmHSYT1z5u18YkRO+RjcNfsCjS0ULjDgxIvzET++tjwuP73lf0rF/J0yHwlVzcpd3qBvv1J8cNXG3CGraXbfVJTxtqmbgECnNGXWWI1E6MPZx2ctNt6epc/73z3qEjhxpkVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=To1mWPHW; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="To1mWPHW"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7eb4d532e65so1294036a34.0
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 16:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787441159; x=1788045959; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+s92g3OyO+nluogZsGa9t2jIOxlCnJFatsZxBV9VB9s=;
        b=To1mWPHWIy3rdNYnzXZzbmubNMywJw+PVuMVth2piE8cGer090UD3jIAZZUBuAHwN5
         0asVlhba4mIGxat8jlteMmFBAj4PWbRgyB2izLcDrnHIceE6P9r+txb5Q/UxsPT9UGrt
         RT4wKn8cU0em74hcE7c40RybQ6cb6hbkfd0i1AyWUDECt0ln49A15Ft7lYd9utrVeKA0
         dd5OB4GlemTYO/LtMbyHWuYp3a286Sxpx7aGIOmPXr1Gxe2jU1s4mApuWTfipsjoa5QL
         dfrO2a9xqJSor/S/ekqzQioGninSxt0DxrnsdrRpYysZgEul1ON5MT81U4VAez1ZWpT4
         O1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787441159; x=1788045959;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+s92g3OyO+nluogZsGa9t2jIOxlCnJFatsZxBV9VB9s=;
        b=Tt6p7JB/70ZpwGsBTh8G9eS+rczTRBcLFRFsjylC/jbtgRv5s1NZLM04r5cvhTIRvD
         ZsZ7zRJjAocwlOEiFPTcihzPXD4yEbN5BBNGuT2Gy7+/BTxmq00Bqb2BdoMIoPBBUEfe
         uV9hPucSSS3r/k9ey+ZXyxpGRfFJfUMS85P9Wncq3LySx92frn+zR46KwRwJi2BdDcCe
         l786lGuwO2lVH3VhvEbrLcwR0rJdhAsYq6FGyK90dtzF3pCt2H1DQx7h3MEKRmOY4MJZ
         6n9Qc18DrxwoxWeifX54z872x7pdNLfNNX8j+OIm60aQnm/yKFGHVjttHlUQRoL9hjZJ
         O72g==
X-Forwarded-Encrypted: i=1; AHgh+RoKdgGBlGrRHKtgGuXvTUjkfHY8+rKpTAPvFkUuEfBACVXpXzxqwndkayQgKD9CqqIUN15VdCLSWWY=@vger.kernel.org
X-Gm-Message-State: AFuF++kDlVTPAIqrVOtBg8xw6bC2zwuzEpBt818U9w4MJwacJp/VenrE
	ILQh7KuqBdBsi2t00Wn1Je18oWzFFXBjq/8nGn1rol9sM4avVl/o71WIuFDGL2DNqlw=
X-Gm-Gg: AR+sD13Jv88bXDOrDSa5IgwvPOghcRZeGe7FjIjMdEh7P7U9pW5Ym8zNh9ywFiyy3yW
	XdzEJFNp2vlRNc26pmyOZe69dbYlNxbDgiqKYRBIqkZhEXg+YZUStvNZ8MF4jDmJNwM6GQxx2kl
	8zrAdei4LysmDF2zkguOUT3GJJQjhQp7SL6xcaJL6HjixMQCtqef7nd8sotHsqqAVT+vfXXAskA
	trTQuVELGjwml06bKvk2I+Wmw7rwcvNH90/9ROw1HKoSa0rHvNcAMu8NdmgWTImQe0mu2Lz02Vf
	P3eA7rcXHnKT6FDxLTtfi6rNIhzMLpmeH3WgOZPfjQF3qeHzWyV1hGLqv2WNhgpLFpeeHqilE9O
	rRv/PeSOUQKxXtLwDe6L6UoXBRBxACRSRinj2e17ZDsg9S3zRBNTcH8+pd2bzSjsgWXCyxwvgGp
	pGMX8+7Qk7OqDoF5u4MpY6qBpEEM412gd0/bbAKVWGqwNWICOti3m7pr1gYuk/xSMvkT4BWc8iF
	KGzBQXXqIvvlmbUbvKCqfRFBF8BCvVmbFpJHujt5UcYvaIo0w==
X-Received: by 2002:a05:6830:380f:b0:7e9:8867:cb23 with SMTP id 46e09a7af769-7f476556758mr11377836a34.16.1787441159024;
        Sat, 22 Aug 2026 16:25:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e0ca:316a:4629:d835? ([2600:8803:e7e4:500:e0ca:316a:4629:d835])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f48fc89283sm108603a34.24.2026.08.22.16.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 16:25:58 -0700 (PDT)
Message-ID: <886f7b8a-ccd5-4a71-b5f0-3d3453dffefe@baylibre.com>
Date: Sat, 22 Aug 2026 18:25:57 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] iio: gyro: convert to iio_push_to_buffers_with_ts()
To: Gabriel Rondon <grondon@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nishant Malpani <nish.malpani25@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260821140553.80246-1-grondon@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260821140553.80246-1-grondon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/26 9:05 AM, Gabriel Rondon wrote:
> Convert the gyro drivers that still use the deprecated
> iio_push_to_buffers_with_timestamp() to iio_push_to_buffers_with_ts(),
> which takes and checks the destination buffer size.
> 
> Each pushes a struct with an aligned_s64 timestamp, so the change is
> passing sizeof() of that buffer at the push site. No functional change.
> 
> Gabriel Rondon (3):
>   iio: gyro: adxrs290: use iio_push_to_buffers_with_ts()
>   iio: gyro: bmg160: use iio_push_to_buffers_with_ts()
>   iio: gyro: itg3200: use iio_push_to_buffers_with_ts()
> 
>  drivers/iio/gyro/adxrs290.c       | 4 ++--
>  drivers/iio/gyro/bmg160_core.c    | 4 ++--
>  drivers/iio/gyro/itg3200_buffer.c | 3 ++-
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 

These check out. I also looked for alignment/DMA issues.

Reviewed-by: David Lechner <dlechner@baylibre.com>

