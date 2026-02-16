Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938EF381AF
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771231549; cv=none; b=Ug7P0XJZ9QkyEJGwdJKFG7Q7d2FMgCkizaP1e+Z2EvoAbhXF9GD/f18hmLwndrec5QO3x8QSGfubcFNNy+2xrTX/3PEJe9PAWa69X43myfmekXwGZrrRVCYFPxu2NS+OTvs/9o9QV2yXG86zrIVEOhKrp96WBDRWnksug1sn7TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771231549; c=relaxed/simple;
	bh=YV/8XQJR2BaDti+aiMeFsE8qQijmvXtUMemVuIe3X6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQqAUyx81LZphxCLupJKxrqioahp4f1yRSAbjLOPKoV77n4i47Ji0FRmbrTiXnMpwPjVFYB8DiHGjTJt7LV+yIwnGUn/LpspKrvNFE26uk89rwLll1BZ/IiX5vHeJ05HldNS0CxuR4qSdJGUxBnr15bsT7ldULVHd1lTEsm12TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8ebj9qi; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8ebj9qi"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so27201335e9.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 00:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771231547; x=1771836347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YV/8XQJR2BaDti+aiMeFsE8qQijmvXtUMemVuIe3X6U=;
        b=B8ebj9qizutTkg5ht2TpGed2VAyvMViIIPUOeEdj5mhq2JXViOYloh4tsA8QXAKQ9p
         T+IAfbZSM2m+ezQ2Ir4Q7uXuniJdW5IuwTLMxOVT2i8kyOi5G6zO5rZyhEAlijDvhOFU
         6W+0bJa0iv6FMiPSjJSEseiwV/uabuQAVobEebhEJw6Bqw5ds68CW1E3Vp9W0XkVulm3
         LE1T5RwNsstk1k23waZo03ycQtUs2M8Ul0yVbq95RvJiWi/6rtndm9kHT378kQlmmB03
         CRTXJDEb4vHDfA0UYYp6sR2qArSUElQPKJ4p+498N3MZHTHooO3tvksuwyOTHcNBTKje
         ZgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771231547; x=1771836347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YV/8XQJR2BaDti+aiMeFsE8qQijmvXtUMemVuIe3X6U=;
        b=NG+gQ6G6tqnITCxBPzlVDyIUWpRf+EtVpUBD5ioZuZKoPAuKO1Ton/o0voJTKb0sL5
         +QGp6Gk3kXNLh8QxBWKFplKyXKeA8+BupxEvFMwE3rbuvZsqXVP5LVp6CK0WRXY82s7m
         vRr6x37xfeMmIc4aPOJ65DM3o2CJXagM5V+tTUC4kcrNeKrsq4OPZY315FPdZUIRvgTB
         W70NeUyVkCp37jBorXtoMSAkzd8OXs3WRS3qP5A7aOlWC9BSDOIihANWA7IpTIKgU8Cy
         qk9EoauS9Ibpng1eKdYvy5OZg45WisvymvoSK6oqRwPqH4PQyykqpHTzdI5X143PvcBR
         jDHw==
X-Forwarded-Encrypted: i=1; AJvYcCXHW9mYo3nPOlvnd6ldKuzM7DAE7HaS2h49Vr/X6eQH5dCEZT+vpMWbqkqLBJjOpACF+B25Iu36fsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDZW5je1lbcwWt7BUTiHaKrCtk7vBILN1Yy32CuX3UgyvM1rW4
	gmRcOf+7fVXHhwS03gTo59caZMz+/kkzEVDWnl+uTXGmUkWHP+Im8Spj
X-Gm-Gg: AZuq6aJEYeF5NtoO+ziQIFAHR+wmpJicSizFj/qXHl2Yi7nmnv30mat+UmNoaj86PWF
	mP0Sg0fSOwdxiqJkBAoaFbuWsKIhksprAIbn0Z/Gx8nVVeAAM05UJq/8T43fMglOxFB3tAcQ7C3
	H3E41OAnkOJWYQtigFo9GqtXiE2p+R4ZJZFc157QC7vkzfKTau0uUFNtw4qlrrHiSixt6n2K1c+
	QoZVXBDBSPPvOdJPM5zt091NJngavJYQFAsMTXozTVMFkZ1OkLs5KisfLI8Bc4gkLyGQ6UxB+Bk
	IldSot/aQJT3fbIpLjY3f8xvODzKvPt44KcnK2tLMDgjxTc3EqArlTUVURrkjXr5mVo6rDSMs4c
	YYLnxdLwLagTxFCRdaUTKyh7GZqAS+//xFPfouZL45Zo3VttVMAg+XboR94LZKrKsMr6Cn+ZYpy
	Cg8FJQLDgBrGTB
X-Received: by 2002:a05:600c:524d:b0:483:4807:210c with SMTP id 5b1f17b1804b1-48373a5d7a0mr196426675e9.24.1771231546718;
        Mon, 16 Feb 2026 00:45:46 -0800 (PST)
Received: from pc ([196.235.75.121])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5d78cfsm643512305e9.1.2026.02.16.00.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 00:45:46 -0800 (PST)
Date: Mon, 16 Feb 2026 09:45:43 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: trigger: use put_device() in
 viio_trigger_alloc() error path
Message-ID: <aZLZN6sD9H9dF8Np@pc>
References: <20260215222348.186806-1-salah.triki@gmail.com>
 <aZLNX6Ifw68k-zu5@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZLNX6Ifw68k-zu5@smile.fi.intel.com>

Hi Andy,

You are absolutely right. My previous version (v3) was logically flawed as
it could trigger the release callback before the necessary fields were
initialized, leading to an unsafe irq_free_descs() call.

Since I don't have the physical hardware to perform runtime injection
tests,I relied on manual code path analysis and clearly failed to account
for the side effects of put_device().

I'm sending a v4 which takes the safer approach: moving
device_initialize() after all potential failure points. This way, we can
safely use kfree() and irq_free_descs() in the error path without
involving the device lifecycle prematurely.

Thank you for the catch.
