Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A6555C32F
	for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092575; cv=none; b=KQghJYrXAX8Hw73ucAlcKxQrfmbmFw+poywbxcR29ino1jSYWe0gfXxK8gncr1pphUyu4q9M4XkiQ1xu5Lz2CqWh/74GyRG2fFtpEyQqncQ2c3UhkXfAIC3hkFtG+U41DZYUyKzQhlllVrYLIj0RHbJW99588LSO3/DVhl56MTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092575; c=relaxed/simple;
	bh=cJMB1C5NwgZ9t/F2vTcnLRABUGE483z9RikyK8kCd+M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3aJSyR+MLVOPBcKACpqxNqZDkUKawTtg4BCp8fikGXTeJFbplpMzMZ8ay6b6ctzu6pTG4+Jzrn/OASs09f1lhnDdKf1dFBjQDq/Qhu6sq2b8QTsYxF09lwcHqSjIJCPQQF7mduMjGHyN/v2z7IgoFrF72Ge39RITfzZSS6ZZg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qbShvM61; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbShvM61"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so24322405e9.1
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 08:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790092572; x=1790697372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2oj0aTA7VOJyZrVWcneUoZKYnaLkcgMjrZp/pYzU3RY=;
        b=qbShvM61cN8CPZifWFN5SJ+3FTVRuLGjpuSm0/2kL8b650xzaSMwfhsCVBL6MHrxS5
         NS3hznVK17OmaUgIv4yY+7hHuKuIkMpI1NjVczlSqTtsxiaky8Cz+IjWF92Q75rDuex1
         qir951Zo3h+29zze3mon1Ukei5drCIfFZFPZB6hG/ATGXtNGXkD6VDEeIGtfcmui7igK
         ZP6E95p/uTkgJG1s0DZVQ/8e7oINGyz/+OBjvsgBj295vSLEMlkgm4T86a7KPO0YktUC
         cbdZrIFjDTpSiNEDdsiPbKVXOXPzxuSjKs/Gv+xR69UpM1e/ZbIivbHdH/3nJsKv7Bsq
         EojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790092572; x=1790697372;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2oj0aTA7VOJyZrVWcneUoZKYnaLkcgMjrZp/pYzU3RY=;
        b=q9hni8uhaXnEs5C3yEfk6UCOgNTejaKMcaybNXGIIZVMlg5XkrzT6li7mw6AbhmEXi
         Yasz03sZ3yWfee9X98XT537BzMOfYWEUI/I7Z9bjMOgw4bl7yzVYxse1Nxo3Y7EPny1b
         lO6KYYfbMEO+yrQ0HY9sAe0LjATehnlqzLYtvMlHeS3U4FsVIfQNYQSudNR+kOX55+LF
         DwQJRHojjmJ0cvcF8wi3UKV7ur0jFH3yHPZRTZ1+2OVh56CGWRo7/3WEx0N2LRdPe4dh
         Vj6lHWZLgbUIjwjJTTagZwZ6N9bxnPQ54ivE3/T8lOHBAjKBWEWOOSR2LbyUsvH+9rWP
         0qRQ==
X-Gm-Message-State: AFuF++kULgEgwwG5s0z2JHGb3vnGDTmP42mU5FBG5AOiaE74NaLnp+gt
	LF0yOCC9TsTtVPc+q6tZLFHip2pLAROoVS85+Nru6PcHg4ur7cVGm/9naxMby8RS
X-Gm-Gg: AYBFou35PZpDCAOvfPE7apEgSeKH3i+vO1Es+VjCsNfUY+o3hG5WxkLLNbhKKpCLbOk
	fRCIH/ASufuvJRTQ1fnI8zxs5TSIvl8QWfREvy/AomTM8WdJNmani06ph5kacXvwFMXZhMFs29q
	3KpH+ZlsJbU9WxQNoupk1iPghU72z4Ev/2rA448be+zOAsX+gnH8YHg2TTh5qGk1RlEumiPkbMs
	Z04+AAg9ppz9JcyRQd6PaQ/UcnqV1Tt+Jr5PnaOOSutHARTZI802l5ch6ohn/YhgN32klrlbnjw
	sx+8FwAVdfEZJgn9MJpA5886wGSLGwEHTSQPaE4dWqYaDHAAw2UN/ikwpQYUgj9Ec+PjvrYqYUF
	+nr5cCxF03qrNPxFRHkhqrM+UlwGKANk2AHJ/dnPSEU6UV7aPOB/Zu5ghUd0WHRziM1HJw0UtLd
	/weNAW/ZGSKkRPpQyR+e5X1YGIBckYvG37PQEsIqiXHhuNQGjY1GMxt/LaCS77soCic2c6bjBF3
	DwlOnGWLyNFSp6ecZqdhFjlcKpi+PDIhrcVTsSChBvw622XQmb19VSsiIBHkbcAtOktPQMJmZoB
	BNYUub8i/mqJ5A==
X-Received: by 2002:a05:600c:3b05:b0:49c:fa21:e746 with SMTP id 5b1f17b1804b1-49fc57570c8mr186611695e9.28.1790092571470;
        Tue, 22 Sep 2026 08:56:11 -0700 (PDT)
Received: from HYB-2NH2WFe09VB.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde18a8a0sm325825e9.5.2026.09.22.08.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:56:08 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Tue, 22 Sep 2026 16:56:03 +0100
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v10 04/17] iio: add IIO_FREQUENCY channel type
Message-ID: <xevuqaudwm4hpnhbful263yx6r45liuch6yc7xjk2i7wly3oxo@xe2htu27rkl7>
References: <20260729-ad9910-iio-driver-v10-0-aa1f6167729e@analog.com>
 <20260729-ad9910-iio-driver-v10-4-aa1f6167729e@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-ad9910-iio-driver-v10-4-aa1f6167729e@analog.com>

esOn 29/07/26 09:25, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add IIO_FREQUENCY channel type to support Direct Digital Synthesizer (DDS)
> devices that handles frequency values written directly to its buffered
> interface.

...

> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/industrialio-core.c | 1 +
>  include/uapi/linux/iio/types.h  | 1 +
>  tools/iio/iio_event_monitor.c   | 2 ++
>  3 files changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index bdf3d4c06331..a45277bc5d99 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -99,6 +99,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_ATTENTION] = "attention",
>  	[IIO_ALTCURRENT] = "altcurrent",
>  	[IIO_COVERAGE] = "coverage",
> +	[IIO_FREQUENCY] = "frequency",

Hi Jonathan,

Thanks for not giving up on this one! Taking a look at the testing branch,
I think this line was dropped during the rebase (addressing a conflict)

-- 
Kind regards,

Rodrigo Alencar
