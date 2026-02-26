Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A7D399026
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772097658; cv=none; b=B/KPQ07FGRuK/N3kYPnKHgNFPFwnv1eB1RDG8QlP4EL0ZfQKwQXQYj5l6InuLqRbIqEhBBq433lLm77X8mQHfHUspCwRMkAWHkbURAE9ZNpMUIyhfstLV7wrtcSsGwbp2kmG1GkdwEo4mUJFiOav8C3Tivt+dZp8ciqEbbcXZyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772097658; c=relaxed/simple;
	bh=8qs6x4Pv9y+qF2DuVeJ8w+TpvkUvEUks+sRLZeSXwYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3JRF5HlvjUtwC8OdeZuJ8NpebyQ/ohX3x4lYZbT/UW/CTIc9c/dTQc2AdIbPOxNm8U1ba91yliEwtF2lWmVmngbwCvmqb1wcvsnRffxicRhte6yJiDavy81v7DxRb5HjYDY/uVmr3n88e00MmBikkBWfF3l6nQuMqcYjkNkMVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SMF5eK/B; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SMF5eK/B"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43767807cf3so400355f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 01:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772097655; x=1772702455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SEN2Mxya0NO2eS3wMKqR810X2FDpQZBHPAnpB8bwU1I=;
        b=SMF5eK/BqQtbDbxRy4NP88bOyVXmZg5KJOe1SuUownqsqmtjy3bNvqrBhpqYSoX3TN
         x/tgnFzRmKK/Lqda5j0mpb83uAB/6ZdYT+qZTCXK9fEFyZoROtjZTes3WWaoiuh7lKO7
         9gz4qqmceP12637akan2NetFQbYW+8RZY/H5i3SYY+ftbEulYzJTFhHSNLf+SbI3pmT4
         fuRpBTjUXC2McQ0e6gFWyph13SG1UOsLxcwyQ0Oy9P/nI60KQH15+k1+LqeAQWTpV/fe
         b4uBFuZuAuHgY32DppZd4GPO+3ThCTYk9LEXH6lImXDClO779Xt/iNbTrR5fAEfN3qvW
         UC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772097655; x=1772702455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEN2Mxya0NO2eS3wMKqR810X2FDpQZBHPAnpB8bwU1I=;
        b=mLodc0AhFfH7psD6ID08dyscvcrq8sZN+yMfFLIvriWxf1Vpvl9pw7MfLMDimWsXTl
         ds8YwOY52WAZXv8njKfMlscbFCI2kQutqAckCb0gY5aoAzch91ZS+8O3/l6fUAWi2Ij8
         1p44yhAQkYs42e8aW//GiH3/nd45FCGDM8HYO6n2dViZqGh02JJoQSM1kqXkq2/u3xHJ
         xBDTqKDOlBAkDEuNg3Qqtgv7VE+KFEGHdiipR0sUzLNegpwqF76AjAaxnfST6v1GHqNs
         V1l0Vsm8lMyG7Ucx5qgcLC7/ZvGdPm6J3SgpZVSRXaeeEX2IIfWdUwJFNMHUDL0IjTk6
         RfKg==
X-Forwarded-Encrypted: i=1; AJvYcCXcwLwxECnRRgLOIu3//J/8Lwv9R4PsODPzC2/YYRRTEH5mqYrG003ANc71ISQgmv4lkL2Zu7I4eJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvzNH7jEgdaPt6OLw8nNW9pirXUQ1ueLCVTMobLPssWuNi6aV6
	UZEPDRWy3iKBXYbFMT3TuWm8vQZTJdSgEpq98iI83l+9iocNLpjKdsyWdm3nW9m3Y8k=
X-Gm-Gg: ATEYQzy/sqsqCC97gBRHJ+iyl0vaKoCvoHFMn+zMRxiyCOyrt4q8xlh3OXxhSTQLsTB
	l80FZVrV6/oQTaBEX791xxDQnM9GpVQ8IUNHd477FQiScCXxsSJj2Z81bfKa7EafDwQIQzK17w9
	T8zaOX6aOBGOPBhhfZ+CXYvpP2cqawT/2QS0lYamh9+Et2TlDSnSFQqqGoeu5DyrqQJDfpleyYz
	5RYRIIgqdlxhmVVhqSBM8DPPRu+WA1T58vdnFIb7+smxI5AgcDNhKtLHtv9Zu/2/rxJztPV8AkZ
	I4VynBOy0cHkpKmM6uGfp5q+LS1lb74QKbnlCJNQrAb1iA18QKqKYXxqFO21fU8xMiBk6/QigLK
	phgDSt6fG/JhMuJ0k2CuTQfiumEInT2JBPB5Rm+5MgAtrFBuKvwr5TRcLOMB3in3Us5gASItJvJ
	REWy7+zQPCFJLtE2o5q1cj1MJdaVvp
X-Received: by 2002:a05:6000:288d:b0:436:1a2e:9f1c with SMTP id ffacd0b85a97d-439942aa2c7mr6219113f8f.19.1772097655070;
        Thu, 26 Feb 2026 01:20:55 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d5463dsm36575369f8f.34.2026.02.26.01.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:20:54 -0800 (PST)
Date: Thu, 26 Feb 2026 12:20:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ruslan Valiyev <linuxoid@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adc: ad7816: add timeout to busy-wait loop
Message-ID: <aaAQc036akWiJ4uQ@stanley.mountain>
References: <20260226052615.65734-1-linuxoid@gmail.com>
 <aZ_9x4q5BZRJi3ue@smile.fi.intel.com>
 <20260226082535.69503-1-linuxoid@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226082535.69503-1-linuxoid@gmail.com>

On Thu, Feb 26, 2026 at 08:25:35AM +0000, Ruslan Valiyev wrote:
> On Thu, Feb 26, 2026 at 05:26:15AM +0000, Andy Shevchenko wrote:
> > Have you able to test this?
> 
> No, I don't have AD7816 hardware, compile-tested only.
> 
> > Have you investigated the code? It was an atomic, now it's sleeping.
> > This is a huge behavioural change. See my first Q.
> 
> You're right, the sleeping change was unnecessary. ad7816_spi_read()
> is only called from ad7816_show_value(), a sysfs show callback, so
> it runs in process context. But for a wait of at most 27 us per the
> datasheet, there's no benefit to sleeping. The atomic variant adds
> the timeout protection while preserving the original busy-wait
> semantics.
> 

So this is only from reading the datasheet and the code?  I had assumed
this was something you experienced yourself in real life.

regards,
dan carpenter

