Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124942F6910
	for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2026 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774218629; cv=none; b=mM7zCXXLhfpwt6Oo5Ul/A6ZHT3MH3lOosbrr8MqxoWkhQj5JYi7l4berDme6pXzdWBWhZiOoY6V9Kbs/uOpK7Axkmc562oUHBMJTxs96UsQ0cxyVBkg6Z1BjsPsjJmYUsZYkRa3VB5IaFVVoBsxM8r7ERjHiGkVp+6TptYVTk3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774218629; c=relaxed/simple;
	bh=NJZZRr6u7AK+2zjoYjxWMsNR4fFjykW2ztLeAXUoaiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHEWEfQ/bnWB8brs+bsfJv9aNdoUPOjUHwFuDsGL6MEwa4zT0jiXGjDXrkb9kh6ZaXsgug6yZaDZ7iQ1boBQknL0jkDEneMRnUhHKL/JJsuBfqA3j2GjuEh1rilMy1ZR1r81Ow3QQUB9KpaPM6dvEb1KB3GNIV4vLoZ0metQkM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epjURxeg; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epjURxeg"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c10a2e2cd1so1201978eec.0
        for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2026 15:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774218626; x=1774823426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v8/snDZPO6XeO4hSNMbxl+x8zM51kjYVWzx4jFJ4eVs=;
        b=epjURxegdfxhbUotuR3zifm+ylcqb+nD3QBCrTB05jxUOfkE3CF4umIhowaajO2gqy
         L+LyMf20YsJm0qJDlvcbJYciDRt7NXQxKyEWRETYxjZeResFC6VwapjhlBe8CU4Qift3
         xfzgTTAEf44+qxJ2qGiJzl9u1TfKazLD4bAu/zxBX12t76n3h5k65iyhDe3i0G6cMV2b
         wN3tgiWeAGNdPcp3S36uH0AmAvoM9ufaJGIiZvtiPtl0YjdKGLwbvwNERTh9JlXbz1Sf
         X2/9j1L6YoJWKa8N1QMCtMhdeVjrvDqsVEhMrluQbAXrNXliHC31Sqg5Pdx3UjtLBLAP
         i0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774218626; x=1774823426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8/snDZPO6XeO4hSNMbxl+x8zM51kjYVWzx4jFJ4eVs=;
        b=NJF/EACfc9guCkB8mWIb7c3Keq//Jn8B5qcsCFS64V6DQVrLwy3w6mqg2DRtRwR9TH
         ciE4XIuTopdNnD0ucsgpYUzB5uY06mgurCO7ri8qkhbcXSnKCwKDDJf19A9D9C27nF+J
         th2MTzSEzp+G4y4jLKxwLbphNc3LOYgQ6OZTACvwM2tdkKQ0h2zZncagttl8C7D98AlU
         cYy2l6zXKlCZ6rMsQ5ZE2w6IPqeIfu6TPRBukhPNUlDRJqr0vtzDW0Swt7qB8bWEvBWS
         8uk3Wy+Zykq7O1kjE3XvbbhfEwxWvYmFlPADyVVCReYxk1JpSbnrmyuBHo7KEDfh8JuE
         C0zg==
X-Forwarded-Encrypted: i=1; AJvYcCXRwm+jEGpRuPLNeUPQiq+byUF06ecglqRbl/svcNKyVoqDO5YUKdBM+PMNarNR925XqjAnUdMFxJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9drfjJAvYQmgCMff0AbwIic4pq7NTYjr3H+C7AayloWeo7owT
	6IQpC2j5BdD7upDlPxzdL4Nilc1aZoZhu5n7OcU4lFzGyuWYjVzsAPD8
X-Gm-Gg: ATEYQzxFUqkJcjZU1Jgdz2PHRbNcpwAlabVa/T+FmGmebfgq6GbET6XGNPgXMJlTZ8i
	zIkheSQMSAKsNRpj+AN2/3JhHMcQa+/NSg+IQKECVyNr9ZqG1fW+BTEHYausH7kbocyOQeryRE5
	9z9OUv1ZUKoDcCKD/1pKKx9avg+n5IIfQ5N/kuhSlQe3a7zPdZVDbCm4h2x02hvND52eL/H9SaT
	u2xxizHGQSIOo53RZwzjugvP4sA0lAF/ZGHq/RZCwRFO0mJRLS9t6rvzx2gQKsXupJKQJS8ryzf
	xHE5Xsg56X7JbSUdechKBk8xj7IDmzLj33wbl11eSpKvGvEzLRLCNWbMD1Hk71Fi7YUDbiR2OHY
	jMlsRiD8K/KvKj5A4zkc5nmUS1WPEp2D3O29s4LQB0BmKOTO+wnpJGZ+rIY7rjS//KJT1PHsVyI
	nsKWzUmdcLPk8phR6ztaLOcBbcOEb6IbxX3Zv2II3vg7oAqLmksVXuC91dvt5I9GWW0BRD5x4lf
	RA=
X-Received: by 2002:a05:7300:d945:b0:2c1:1aad:61ad with SMTP id 5a478bee46e88-2c11aad9c45mr1952031eec.8.1774218625893;
        Sun, 22 Mar 2026 15:30:25 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17b8f2sm15091997eec.9.2026.03.22.15.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 15:30:24 -0700 (PDT)
Date: Sun, 22 Mar 2026 15:30:21 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ti-ads7950: use
 iio_push_to_buffers_with_ts_unaligned()
Message-ID: <acBtUzrkMGK2Wd19@google.com>
References: <20260314-iio-adc-ti-ads7950-declare-dma-buffer-v2-1-2087fc18b077@baylibre.com>
 <20260321210539.2de04bc0@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321210539.2de04bc0@jic23-huawei>

On Sat, Mar 21, 2026 at 09:05:39PM +0000, Jonathan Cameron wrote:
> On Sat, 14 Mar 2026 16:12:24 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > Use iio_push_to_buffers_with_ts_unaligned() to avoid unaligned access
> > when writing the timestamp in the rx_buf.
> > 
> > The previous implementation would have been fine on architectures that
> > support 4-byte alignment of 64-bit integers but could cause issues on
> > architectures that require 8-byte alignment.
> > 
> > Fixes: 902c4b2446d4 ("iio: adc: New driver for TI ADS7950 chips")
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> > Since we were looking at this driver, I was going to convert this to use
> > IIO_DECLARE_DMA_BUFFER_WITH_TS() but then I noticed that we actually
> > have an unaligned access problem with the timestamp since we are
> > ignoring the first two elements in the rx_buf when pushing the data to
> > the buffer.
> > 
> > Unfortunately, this will cause a merge conflict with the series Dmitry
> > is working on. I don't think there is any rush to get this backported
> > since no one has reported a crash from unaligned access. Since fixes
> > should go before improvements, we could apply this to iio/togreg then
> > Dmitry can rebase his series on top of it.
> I've done that. Applied to the togreg branch of iio.git pushed out as
> testing etc. I've also marked it for stable so it gets picked up in the long
> run.

Cool, I'll rebase and send out my patches as soon as this hits
linux-next.

Thanks.

-- 
Dmitry
