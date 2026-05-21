Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF38F366048
	for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383728; cv=none; b=mo0fvYneJgb0/HKuf30mgFLuDaY1GXiWnjYxbVfE9bcStEL8bx0T20cpY7tj1jjqA6qmVqd2C7U/HP0yycc1qad4g6/Bou8R70Kke0sGu8cLNh1BeCpbV806wG6you1VuTFt0jC0qoB2pb4b6trRNEGr6yYdwt+IyHFjLW7vED4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383728; c=relaxed/simple;
	bh=In1Vj7Sj1agc9US5gfQVXapFaCc41+yPXjcP0EfiEDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUyMUpg769JSNOGgbqv0KMrQegdTq/v72fo8fNMh2LsXdvlMgwuoinxcIrPzEpIM7gE/nul/JWtXeO4bsPcn8B0Nu75rWH2nYwjk+pDcL/A8oQGN6eJzsf12KylWq07qVv8FPWJJzZkJ7KM6NxR6VoO46dD7orXH3+wmLtzVtF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNTOvqNU; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNTOvqNU"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56f72d27e7eso7668202e0c.0
        for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 10:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779383726; x=1779988526; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O0ntonv0FOD3AhrDmoF4S8ZdtpjjfgeciMhRnZnu3cQ=;
        b=RNTOvqNUJNnZ1qYdYGo1ro9373aGEmBFzSzk0cFBqf5YfxLqKYuTDcu2mC6JFpdOup
         SE2Q3fYUHCmkvk3uwOt9GQFLm236HDVHu2rdGwR7LZFeM2327Oj7dFcoR1A8UMhvNC93
         CVawAOiQFG3RpTtut+RIRxalemecqJLaPndsUylY50ChAcLYAphLa45q+bRaK2ydq4V0
         1y9S4uhYxaASn5ql/6t8+bzlN0XxSYxcRLrKDcC7AUMed19Cz8ifSpxaqemAjvocsQVu
         kQTQYiFaUyDoWCUCKUzcoIKL8GI3hB19UyaXjt0nGEPSD/8vjAN2idytzfnwMglJgBP7
         9o5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779383726; x=1779988526;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0ntonv0FOD3AhrDmoF4S8ZdtpjjfgeciMhRnZnu3cQ=;
        b=a4vBpu6ScJboLQqddl/7TG83xqYKz+RxMt7TooPF8f29tH7ZgIs1mdC4MsPRQD38Dh
         3qpq1vqmV1PWaPhP442NIO5O8b2eWI1r+snShKIe6tOq4pfWJmR8kukuiVUZv3z79nrs
         zm6jhYpnkMaEUXjvari1z3Xz6AuEsduCkde8LSzyt7gca5TX72IIXEy/pavE+layOe5t
         pD525WcAfRFTY6HmRAzUCzK7v3hfBrx32WNn/cGLSCuoSMH5O1YMunfzt/mxc6bYxECS
         8NOJpiSRAA+Z8ABqmerJ6v3Do41Li15+LipFyVoQbLsjbKp7uSiLReJCXETybU+k9v3a
         vLMQ==
X-Forwarded-Encrypted: i=1; AFNElJ9bWOYF2AqBllXI4zkkRTkJFA8lNyIECBGeIxAodu11wxcPknTBoGS4vq57HyF+HK9VCTIjaMhz7N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxratCcV8VQ2oHYZ9icvdq8NYvICn+UxqzAiq1lF7DiNLjUC/jX
	Z/FOGeKa4/tFjWMv4BMQvoIvqYT3dbkeqGq7YKq1jXMMMtxxuH8/5e9i
X-Gm-Gg: Acq92OFJBoJk1/emCgJzc5/XgkTe5qgBhI8usOqTJeB18aw9Aw9TVVMYpVbey0mFKWb
	wzsQXmtZ6fAWsL3pTqf6WoT7U4qVRlZh9W2pZItO0kDxPw1BB64ri9S9vAdA632UT5VNzmDivar
	mfpVLQ6bonMIjTvoDWBILt8Z4z0ErC0j99bCdQXLkk2ptALS2gMUH2IxiUtXtjzdiHbOgmVb/RA
	5L6/7XuKhzthEzGBZ8PbIc9VGvT6MFau0VSW8Ee9RLvK7r4czP32RK+uZge7z4B2Qp2oh+LVGjm
	LzdS2UT2wrQC33bQkgmqvwJ+ZZqtg/A22wkEyHW89naporCkaiFJA+fr3OMGV0cUJ4Oo6YXHHoU
	atDKFJBI9rueRWwTvF92mh0Ixsjb1YL2evlsTq91QWCq42cTrlpnaj9QDxVzjWBbIT98wSSPGUl
	l7zRnOT0ZdmU3v/n4hOA4jZNuFS+knNTjw
X-Received: by 2002:a05:6122:2192:b0:575:39bc:c6d9 with SMTP id 71dfb90a1353d-5841c32235amr1928077e0c.3.1779383725614;
        Thu, 21 May 2026 10:15:25 -0700 (PDT)
Received: from localhost ([2804:30c:1f02:6000:8b59:7c96:762e:9faa])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5856d716bd3sm1510190e0c.3.2026.05.21.10.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 10:15:24 -0700 (PDT)
Date: Thu, 21 May 2026 14:15:41 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] iio: adc: ad7091r5: Simplify driver_data handling
Message-ID: <ag89vYd0qFhOq6Oi@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
 <2464690a0a70aa65880c5c61602b52fc9ed9d69d.1779136001.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2464690a0a70aa65880c5c61602b52fc9ed9d69d.1779136001.git.u.kleine-koenig@baylibre.com>

On 05/19, Uwe Kleine-König (The Capable Hub) wrote:
> The driver only supports a single device type. So the return value of
> i2c_get_match_data() is already known and can just be hardcoded without
> type casting. While at it also remove the unused .data of the
> single of_device_id entry.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Not sure still on time to offer tags. If so,

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

Thanks,
Marcelo
