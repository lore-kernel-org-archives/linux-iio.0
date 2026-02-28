Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D72DE6F8
	for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772296060; cv=none; b=d+HxYviFDEnHXdCxo21pRuozvpYVVU79QH67eU/HgGfxJ/FyFT/FHN56dcK0UpRPU3GbDIPEjYByZ9bimHtZiIcMUHAbdTmSgxY22DmJ6mq1xtNOBkOGwQOuwZ01JxyN1wWISbPa0qgqZUy7EaA1D/yQkHbDjIfM4HbBSvnTBok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772296060; c=relaxed/simple;
	bh=i3/rg94Wfo6LrOwSARkMAUOZfbV/3KB0aCm2MchfZZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhBgtktmm8mZjMJvDYipUwA2SyS7h8bnrvfi6DfDupAtquH8RIwSOwhdTUUtlCoawSFXAPdV4qa/KP/VU3le+txpyTb6Z8GpF2zZ/tYxdg1k0O0ejhKORvrfTiVroGESa4PIbb44vigSQHeoo+8bjNCkDfkI9DIeQ6OcWmXk+Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UAf5ztuM; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UAf5ztuM"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6759a5576f5so1965322eaf.2
        for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 08:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772296056; x=1772900856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CP86Ut47LCtiOHeXtYEDxgLTZp2P6pBREzSVZZ3bzCw=;
        b=UAf5ztuMGiaK03VMRKM/7oay37SOZg+3gjmRDZlO5RlgdSyqz6y6oRJPqqf4sMnjSs
         eMFB/RPwq3U0nD67jkjE/e48yORdl/798WHTW/a+HDF031sK+OZ3plOPMXMasIUE32WI
         HamnS8Pf5rIlvRxLLXufesOltaej0yTChMGuNtYraqX/lZOD18QinQFaHtQzzLcp7oHv
         A+9I3pBCeGpmtdBnFcY2yYibFNC6VneQJ7/QLYBbw+qP/qNHuHnzKyNVMcrhYUxPs2Oc
         r9KYzxab/IQG2yeq1R2tOptcd9wt7PDooMz1Iy+eF0140+ZJc2pU1jFvrHvdGQqDIrjl
         ysuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772296056; x=1772900856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CP86Ut47LCtiOHeXtYEDxgLTZp2P6pBREzSVZZ3bzCw=;
        b=FgSxZ6KNrakmmL4gQR5kzb4JgUquZsS3VpuM/dPYlZBj6kyJACt0bEgZApZzRb+vpI
         riSwDh13/l8NxFch4upX8yDqP7TLmkN38D98+Q3nLhFbNY4eUHcrckXtvA0EEF44URLY
         l4Rf0iheOJ3vlppFLDOzxJatj3xwhmbCkMgJT4hxQqksUMJKMZcXYgF20QsAKhtbvUBx
         fVkjhiQzYFld/WqP0cqpk59KO65SpA+7VOc1lZdEhTRP3uGKCLE3zSWjon/A8AIoLUeR
         19SCkekR2u1zBQROWTXSm8f1AfXqPPKmbRJ9vAYTHEJGbxKvGUVwjLRk4H6KFYk9cwcd
         U6/g==
X-Forwarded-Encrypted: i=1; AJvYcCWYTDMJrB8yK8lAyogfD4idaWSq29vTxdtkivt4aafyZwPDJvRQJIvIaWDNblGlriz3ngSjHHNoQvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7miOZQ0Jev2c+NW0uxcsHHEycVnha3WeacPR+0GUcKLFVYNvm
	JCE60pn2pXmk0pBNvTT4Rupl4DZCD9Stf4miXMCjBkpp6Y0Fldm1w+o6F+RrykdRXT0=
X-Gm-Gg: ATEYQzyimnkAaMGQANa+npR+0+Njm2lBO+Kt/ubCZxzNvnB7fnLovxr9djuG7hAMKmv
	BRllBU+72pBny8msMVoUDugEuSFhCOprWrRu0Tqqkle/EmIoga031N3RuuoBPSDU87xAuNw1vxc
	MYmq4BxbfGfkHIufDHaN1p0ZZ6UFoHcwyOfrUZW47ifoKi5T+MgzvcCAogLv0/E1+qv28tlf3sI
	N83BQWvUCWjUgWgqQFPjVWNRnPKXuDq8I4uJhY+Lpjzb+bZWqsVBDChZYKDuP+LiZp7t3tEDXO7
	0Px0AmCT4lpw1IHf2Y11JxpWj2SH3chRZTFhiaoV5oSEzq2IKtyJPIkz8YQH8VQkyvTTZfbY5yE
	kot+um9hpHf5dg5z5GsccynVg8WfKWw7dGDbjO8xdS57zKxArtZG0Q8Bw1FSQLS/JhOFGKMEKLA
	Xq3dUon0eraL7RJ4rvhM5MI8KW7hCDDqCVnXtMqng9ZXmeZgVAfjBFuykKCFreZapBkwGIPt0Rn
	w==
X-Received: by 2002:a05:6820:1b10:b0:679:efce:99a9 with SMTP id 006d021491bc7-679fadb8724mr5462181eaf.11.1772296056439;
        Sat, 28 Feb 2026 08:27:36 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1031:c44e:9f1f:17c1? ([2600:8803:e7e4:500:1031:c44e:9f1f:17c1])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2bec8a1sm6258781eaf.6.2026.02.28.08.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 08:27:36 -0800 (PST)
Message-ID: <f697a233-2fde-49e8-8c85-dbcf2599eaa9@baylibre.com>
Date: Sat, 28 Feb 2026 10:27:35 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] iio: accel: adxl345: Implement event scaling and
 ABI compliance
To: Taha Ed-Dafili <0rayn.dev@gmail.com>, linux-iio@vger.kernel.org,
 jic23@kernel.org
Cc: rdunlap@infradead.org, skhan@linuxfoundation.org, nuno.sa@analog.com,
 andy@kernel.org, corbet@lwn.net, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260226151108.22383-1-0rayn.dev@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260226151108.22383-1-0rayn.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/26 9:11 AM, Taha Ed-Dafili wrote:
> This series addresses ADXL345 driver non-compliance with the IIO ABI.
> 
Reviewed-by: David Lechner <dlechner@baylibre.com>

