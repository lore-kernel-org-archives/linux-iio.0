Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036914;
	b=W3BAsGQXfXJ4UMq81MSPdf1bOCpxUWMhlEuBimTQ30b7KDo3DaxQG6LbGHIlfOr6RyOg
	 VHyERkJ7TNfPONKnuFaqutI3/kvsRTQCZ1wq1dF3hkDqqNr8QhIUiF7w3AJXJ5IXpMcv0
	 BfSCaWZR3rdIGZdPiLBpdBvkUTR0AqgtrZUSfoRA0iu2fysLTYOIKyft5BTrC9Ej0lYZW
	 8t6Pk/li5FeboKQXziQXYFJQEBFYFTlaN5gAfL+1hGekEV+38ZxdfnDEzBxF5WFnN5qMs
	 2zlBM03oQInOYjn25TR+M2lQhidgU8hLAoIVyvol7m7jKwh+fpHYJUk2s7TLd5gyv4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036914;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=R08mAYcTQcWB2r8FelHkX1V+KOtwsNomKQFygxVqclc=;
	b=eyGjBSY8wgIbJn46aU30fP/WvPG99RIMb13YPxFLbDJu82ajXqeKUqrdhBOM0K5g3LIs
	 TataOB3JtBeYDbnyopwwTuZjRIOHpe/8rOfgmTPptE2K7arRSGspRGTKvllPcNvnDKpnb
	 NULZMIgKQQhGRsA7SxSsrVKbA0KcqrpGckvOMb0Wp+nNBvtMsbi7CeCtLzk88pPwmcSwx
	 3kniHJ6ZYDfSCVzGrIa49ox17Kzekcyp6hTFkKzM5dX0bhLtvC29jUn6IuWwJH4nxMH7G
	 WLz2QaH1D9cltqgdpEbQoiztH1DAGBPFynzZrzEdEUHCL95YdMsy/MEK/+nbf0Q3QrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Q+M0nx8G;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54053606A31A
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 17:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54053606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Q+M0nx8G
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1438d9363fbso166662c88.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 10:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793036913; x=1793641713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R08mAYcTQcWB2r8FelHkX1V+KOtwsNomKQFygxVqclc=;
        b=Q+M0nx8GPPzRz3Be//8iqthyZZvySfyACiyZ6H40xy9VXMQOVooazxdrKaVCxgeU4+
         +yeIXyJ1jEdJQGklELZhe20Z8U8YGhru0E/E6c7JA4tI1eQRG2JO0aKgoUkw5Z+HpSRM
         HTpoEzzqnkF4tJyzkMEzYwEoI+buQ2RUOEQO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793036913; x=1793641713;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R08mAYcTQcWB2r8FelHkX1V+KOtwsNomKQFygxVqclc=;
        b=vyT7wSxXm7nfcSlFwY/DE+KK/ouY9dkKmcm0BOmU9+RX0jTvQH5h74FBV0cpqan+eJ
         5Shh5QFC0ah0MjfRMiomnUo9BK2fdWzWj/hUUzJFsvCJBxORd4B4Q5XVEA8njPFsqrpm
         H6NjmvepMxYSN5fV8QdXR6VlFeaV25yGRfYUmJOfHjaHVlkfJIExrQPP4is7htl8iVg4
         iI6SqBiH0LotqTZFBPFKLUPlGVQbUkejEb8sSn/cKZZmNvfAAGlf7UPvfu4QN/OTHm0Q
         p/xo67HQABW2N0h59WzUTPlyvg8y42bA8r/ZaBYihl9ze/KNyMwZoZJuntBrUmJb3XJe
         Xv8Q==
X-Gm-Message-State: AFq9FYJaSgetlXKGIp8fqPO9VJSlccT4MGh3Xf7luqw9FY+r6yy/rSge
	DDj1VQ6CVnwX07D+jY48sBpe2lM7+PCYGTtBA5TgZiIVlYNxRqS1HWGOK/n5X3YM/Q==
X-Gm-Gg: AYBFou0wZFQ4k78Q8JIP4F6UvKWAZ57OotrtNeFARigjIyMI7ETwT8YZHJkIINjmpBG
	n6+X0GHEwsYJTDy+hHbADZbm7fYnaUkc+hB4xJ+l3qbk2kcPkIwxfnGirAZMOsYQauGtU+OyQvE
	fAFM3YHxMywUKZAv9arXbAXnThLcTV6aygH9ZLzqHKOyXdWNfslR2OtuTpw0wrq/L1r/bvMudiD
	cJaOsuPGVVkx8HDrL/YpQTP0JZkNWPoi6UuffjNSIoy1CNCewMU5XDsiD871OW3VoDIr2y/njck
	FONaYLwJx8WV2IngEuCPgksGgrlG5wC7mWb7VH4HuhEY7YxSNfHwL8blHQiuj4PRqN4Fxur2qom
	kVrhy7imev+LKftXxA5tUSgO8e7VGGIn4ZcjJqrF7Slz1hT8rlbvCjfP9rLMYm6LIzBvwMgL4AR
	Zf6NYenXTQhpmqt12kXdyU6UIPIIF7idhPF7tT296QqKInZ42dGM3e09j4YCngx3Ahghe7FuwSc
	6YymjXjdId5g9tiaKu2GQfZw01UH4qiyuCQUf25u/kduxcOKwb06q1pmdQaMbM10e3QzAMCeago
	xCFXRGR2rgCt+lyTuOE=
X-Received: by 2002:a05:7022:b058:20b0:190:716:4822 with SMTP id a92af1059eb24-1a3c3eb8f00mr427726c88.8.1793036913336;
        Mon, 26 Oct 2026 10:48:33 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:79c5:9cd3:db14:7468])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-198a37c88aasm23677436c88.23.2026.10.26.10.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 10:48:32 -0700 (PDT)
Date: Mon, 26 Oct 2026 10:48:30 -0700
From: Brian Norris <briannorris@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/2] iio: gyro: fxs210002c: Use guard(mutex)() for
 remaining simple cases.
Message-ID: <at-SbqRdChCsEtcL@google.com>
References: <20261026032051.1004536-1-jic23@kernel.org>
 <20261026032051.1004536-3-jic23@kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026032051.1004536-3-jic23@kernel.org>

On Mon, Oct 26, 2026 at 03:20:51AM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> With the exception of the more complex flow in the trigger handler,
> all uses of the data->lock are switched to using guard()()
> simplifying various error flows.
> 
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> ---
>  drivers/iio/gyro/fxas21002c_core.c | 71 ++++++++++--------------------
>  1 file changed, 24 insertions(+), 47 deletions(-)

super-nit: it seems like the name of this driver is "fxas21002c", but
your title is "fxs210002c". Understandable that one might miss 1 out of
10 gibberish part numbers ;)

Otherwise:

Reviewed-by: Brian Norris <briannorris@chromium.org>
