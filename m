Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4876338B7A0
	for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774107167; cv=none; b=sKdKbE3R9OVPHXicGIuMWNecenJkSbHoj7YEpWdGkN/Xw0a9rfitvrBJTys1I/Eu9WI3hxr1EqHq5jOEFT4Rw6RBTjvuuEQ9fkWxGSq9q3cZq7u0loioti9l3h1K/MhFkmFxpM7giaM/1odyLOw0yJN92FLZp3HUHu1BYfdr/WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774107167; c=relaxed/simple;
	bh=nw4QcdSFUVxY7JeDmPlncuCvC4La8p06UFbAu6YKNFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkZpXXuw1SynZdnG/M+DU7mq2H6w2dUUi1eKaOOcFEJonq0GNO4U5qsxXxsfIGhTDyjhTk8oxCLJkfhIdjcWXKs612/wjMIrDFiT3zE+lcxghzlMw1K6tqsEoYKK7Kp0AUDXvScLozBpSXTHV0L8UMopiwU4apfP6gkEmBn4cCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qvBlp5ou; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qvBlp5ou"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso22128365e9.2
        for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 08:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774107165; x=1774711965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3dzHj/qPvXNDV/FPnpoktTjASNEPHELip3yFLAmvNe4=;
        b=qvBlp5ouC9HF2+i1WYoqMCNHL704KtZdwxwbznzPxJzQKDJDoD3mvPYkNqeElCiW5S
         22vO0K0NXjazLNVMKPuJCe67VsFzeTTHislSFzuuee3KLdiCTyCPvHHUE9BGsZYFbtgP
         YADbMI6M3lLQyHKK9njZJw4AVvqk6wIeoP/oeIT/NvjdL99wzsskIw58GNmGfP2yxaWz
         LpsGzkLuaaquwLGCHjE/664ebralh9b3mWUB1re8Tgx5eMkpp73mEUicA4L0nBuViAQN
         Gwzd+7kf7ozeoJjlB28OiPtUm4Q9s0MjfAfCFjnKJCpsNgdRD8fPMboMOpwO8564OKIB
         kN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774107165; x=1774711965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dzHj/qPvXNDV/FPnpoktTjASNEPHELip3yFLAmvNe4=;
        b=HTZdpgeJNqfCjSBE+P/hFDU/X3ybtJBEVwaqNLnFxMUpQDRIzvSPNvA0GPlk6ylfWC
         iMNMb1bg0mHt//ive4iSdrZDJjsNFPLvj4cnTb6O83Lnv125Sjp09P6TSr2b350Q2P6Q
         iXS6wRlClNPYgNcYSqFX+WECTeA5vhv5nIELHe01jELZDmI9MZBW6MBJS72yS433YCUn
         fYsVXv9PI7DvQBllV6IuxEqs6gH61CEJfa/sbr08SyjGurLudN8HPzeQTcVoA7uCdoyh
         dr81iolPIpeQTzoBoo4ZVU2Z5sSbojpqsKJv4O6q9Fd7zG31tSu1fMIoxBISfIUuzFOb
         m+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTOedvyOk4OvQfiYQpsslotYBf3AJJavTMwposEpBCNm6vIBRXn70W7W+KgUN6pIR7Y7RW6ekkYio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsX5T4Mo9SGFa3fDOoCUiojtXnMYwBZ4cvxrShYOd6bhu8PLhs
	KMHdcKLm0Ih740k6B6YLGUW0z2MK1UhuSEt6dnG3OBP7Te3oK7co8JsprL55k1Ki3Ks=
X-Gm-Gg: ATEYQzzV2HWT6e4OZHu1H5dwygLQNqo1sCEmk98fD4Tv3xieiDL879sMb1aqfP8NrPN
	WJ53hts2YvA6gi0UNohfuBBt7KZB2FT/Fkubr6zdMveVZV+vBACLXezw291x6fgJU+dbwP5AeXN
	Kxyq0zpnl+aMKN+hBZIQd96u6zlBICZM4xHcjX2AjfXPczRR5yLzhIkKU//FwOME4iUDUxYCw8x
	9zVVrxf5HQNlXC0GNfX1b2N7eYh3zODW62yY1WRaCHVKtcGOqkhdXdaezAv+T2Db4Bt6XsUz0AN
	Tu9zSZt5zZIv1haGhEPoQO950uZo/PZycPpqhgxlAuaYzyMhpOQeY0JiNjPX7xYvQWKOvEtiLnC
	erAMltYUMptlGqF1Qtdnda2CkqeIJSTJPAQAurmHLdHJmQViNkiP6KBCGr7107IV9cQx42UbX4g
	UqIrJWXvFfj2Pgs0RNZKP7Y5egC4QK
X-Received: by 2002:a05:600c:a47:b0:486:fc46:be9e with SMTP id 5b1f17b1804b1-486fee265demr102213965e9.24.1774107164594;
        Sat, 21 Mar 2026 08:32:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487004e7bc4sm52580815e9.2.2026.03.21.08.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 08:32:44 -0700 (PDT)
Date: Sat, 21 Mar 2026 18:32:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Gabriel Rondon <grondon@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
	andriy.shevchenko@intel.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] staging: iio: replace sprintf() with sysfs_emit()
Message-ID: <ab66GQeWKck9rTSs@stanley.mountain>
References: <20260319225719.73587-1-grondon@gmail.com>
 <20260320222424.53294-1-grondon@gmail.com>
 <20260321130307.7992dfb8@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321130307.7992dfb8@jic23-huawei>

On Sat, Mar 21, 2026 at 01:03:07PM +0000, Jonathan Cameron wrote:
> On Fri, 20 Mar 2026 22:24:21 +0000
> Gabriel Rondon <grondon@gmail.com> wrote:
> 
> > Replace the remaining sprintf() calls with sysfs_emit() in sysfs
> > show functions across three staging IIO drivers: ad7816, ad5933, and
> > ad9834.
> > 
> > sysfs_emit() is the preferred API for sysfs callbacks as it is aware
> > of the PAGE_SIZE buffer limit. Build tested with gcc 13.3.
> > 
> Firstly a process thing. Don't send a v2 in reply to a v1. It should
> be a new email thread.  I'm not sure where this style is coming from
> as I've never encountered any kernel subsystem who ask for it.
> 

People used to do that in the early days of git, but now no one does.
It breaks patchwork as well.

regards,
dan carpenter

