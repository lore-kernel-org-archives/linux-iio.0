Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD473D9043
	for <linux-iio@vger.kernel.org>; Fri,  6 Feb 2026 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385236; cv=none; b=cCAi2NV7ZKXze3BAaCDcE11732mJrikPTk9I5pzp2zrnVourC7xAbhWQdgsN/RnqqfGkqw12BTgMcmaPf86ZQ2e0iyt/boKzvBhPkLirBAzk+BRpJh2zKHYtBa2cwRLAIozAOi/AS4T2PPQLE1+UlgnBmVGt6nwRUcc0yQe7Zdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385236; c=relaxed/simple;
	bh=9xkfp/5sEkljnpwnbvMQYdsISAyCde7qxaq/u+bkt88=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=W6H9ajzlubcr7p8Ryc+PzMcHO9eCXyGKayEHVw0VROBfHAKq+XVR9I53YfvubS/P04qT1QFRMzxhqaXJEvIaR4qcyGjzN6x2znBuEgH0myCqZ1rNL0plxl/e7OWOMQoXSr+B7A7ZSn8FlSyJ/K6bai8TFbw7ywxYgb7f6LP0TGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u0K0oHRU; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u0K0oHRU"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so32248835e9.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Feb 2026 05:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770385235; x=1770990035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ifQVd9mHvQ9A0LehS/GYxtjaFVzIJ5wDUx2GxDCApAQ=;
        b=u0K0oHRU4twpWhfCIFHS4hMIl56+KOq90nW2Gok0oqVJ6g9mUmxWLsDI5FIjYbiGYS
         ECCV2hVQBwlORiCxpHP3yf5mfYBreYc5ZMxBW5QW+PY6B8gPu53M+38+ZhzxuksM+Gvr
         Sd4Fe7V0Pq4fnV2usYvtFpt+XiFjFv2TvG+euQS7Qyhh++xiPXhVGy2m7pyXFJnAj1T+
         iJVxo6UvHopWnAEM5EtxqSCc9Eka8IYjLs1A1dLt1wBAZqGeV2/nssLp+lf0NIxaIvES
         THTeFVCc6P8nx1wK+pLVvYy8nbcOhVEEH36gZheYXB0ygMqLg1vOOLIwwR52smUFCXaZ
         Dctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770385235; x=1770990035;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifQVd9mHvQ9A0LehS/GYxtjaFVzIJ5wDUx2GxDCApAQ=;
        b=n+m0qNeVs/WcspZ9UgI3YeecvOnaNamIl/Iy/awVD2ItO2OyTO99NPWXAC3SlmtGaE
         gnHbf78ukWQKRa8gt+atmFCfv0AsAdP87QOHhdEThWvZPStfGDRQ8HlhW7Bf7jNd8JQQ
         k+IuIWVkrb37lC9F0Tcjxvt/egypo94MTbxSoSfHlrTJxRo6MdeStzyx0hUtCj/09kTu
         OOnxY8Xi4jCOFtLhKi4CEYzYHurXQqapdbQnz2M3zcUd/PZtXfFWrG+VIyHVdzw11rvg
         JH9elt75QSDJPt5k7giomArwMMDIyWiXUhsOzjYRRjxoMciFs6rWZJeAosER5stXwRb2
         kcLw==
X-Forwarded-Encrypted: i=1; AJvYcCWdJtE9IkQNF9SjYKLMWECeLBcUt8rv63Dnd6KVE7OorqJmIQ6DwevPkCI6HXUzcIGjdWB6FEAhDFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoYWct78lgnRIgCjGDnzr8WtxUCUwpUChrg+LpBnAM2EUFq8yr
	+vPhfvnM7fRe8Ncg9L1P2BlSkqcJi3QlF+g6mKy4uTEMty8JFPJ1f+fAU2pdG1K/Z4I=
X-Gm-Gg: AZuq6aIyqfitUSBPRhUb6FPZYdQrdQSTzet4ReqnX5r5NBqghS851nTYlaCSyaJs726
	yD4XP4fwfakckB/Qic7+bwTKH03L03yM2+N7vAJoH2/rk3adNGzsyXvhZ4D/SVLHsuG7p1GbMuF
	+WbvNxMcTcZ7zb1leH1hZJvwKE5NrIBlvKjofUOkpRPHmyGQC9IQT5I5vdEFGnn4ztXiZGv0Iua
	ynx0nVv+fDydEMKkqUAPTRVZDNwy/vBiMwzCTCVw1Tu9Ilq2ytY9SZTK6Otd9+swvBm8FcscaVV
	VD3+m9K6SDnTDh2ZbHOHEZUY/5hV/ysA5EI1862t8GmMsk1OzUNgGbFS94OGs8Orfoh53byoaMr
	NUNpkM8iF53tY2K5SuAnAGdJG0M6CwKxHfP4ilvA6bVnusJKDPdFMegEffB0J1UM/cw3NdpkGWF
	RjFis7lJEfd/VDrZQf
X-Received: by 2002:a05:600c:1d24:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-48320236b1emr36327525e9.32.1770385234828;
        Fri, 06 Feb 2026 05:40:34 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483207286bcsm50480925e9.12.2026.02.06.05.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:40:34 -0800 (PST)
Date: Fri, 6 Feb 2026 16:40:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [bug report] iio: adc: Add support for ad4062
Message-ID: <aYXvT5FW0hXQwhm_@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>

[ Smatch checking is paused while we raise funding.  #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello Jorge Marques,

Commit d5284402d28f ("iio: adc: Add support for ad4062") from Dec 17,
2025 (linux-next), leads to the following Smatch static checker
warning:

	drivers/iio/adc/ad4062.c:1557 ad4062_probe()
	warn: passing positive error code 's32min-(-1),1-3' to 'dev_err_probe'

drivers/iio/adc/ad4062.c
    1547         pm_runtime_set_active(dev);
    1548         ret = devm_pm_runtime_enable(dev);
    1549         if (ret)
    1550                 return dev_err_probe(dev, ret, "Failed to enable pm_runtime\n");
    1551 
    1552         pm_runtime_set_autosuspend_delay(dev, 1000);
    1553         pm_runtime_use_autosuspend(dev);
    1554 
    1555         ret = ad4062_request_ibi(i3cdev);
    1556         if (ret)
--> 1557                 return dev_err_probe(dev, ret, "Failed to request i3c ibi\n");

The comments for ad4062_request_ibi() say it returns negative error codes
but the comments for i3c_master_enec_locked() say it returns "a positive
I3C error code if the error is one of the official Mx error codes, and
a negative error code otherwise."

    1558 
    1559         ret = ad4062_gpio_init(st);
    1560         if (ret)
    1561                 return ret;
    1562 
    1563         ret = devm_work_autocancel(dev, &st->trig_conv, ad4062_trigger_work);
    1564         if (ret)
    1565                 return ret;
    1566 
    1567         return devm_iio_device_register(dev, indio_dev);
    1568 }

regards,
dan carpenter
