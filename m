Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D37A3A5E6F
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568586; cv=none; b=VmukgWo2RaaTEyqgz4mq+F6M5l2WxIz2fZ6abOM9zxKwlo+U7ct+V/1bQ1v1DChET3cmvcRWtnsCeDdbrJ/RIFM8fqcAmFoDpt3g/j7rFoFBYF+hNQCaQVzLe332VCfpVHhpHquUQIzgcv5ZuDNJISr/OGXM0LlPvqSzKvd7rVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568586; c=relaxed/simple;
	bh=vB0ydX+eG4BaRyIca4/G0Hvvsf9bBHfPNfaaxXnWFpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0nw3FmIcSBk9JbNFfTgTF6q3L00nsBB/MDr9931l/fRjD64JKaoRkQHHdezIxZbybRhY84WTGjVgPwOPIGMCgPsrK0F0k/VbzsDX8Vva8ziodEcjiWSXkAbwnz8FMnIdcfEtOLbzxrGl1RcMS6G7bWjTLp3En7+HYAAlynEikY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qbOOF+CW; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbOOF+CW"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ba895adfeaso1732379eec.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 16:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774568584; x=1775173384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0fq2X7bSFhgpO5BzfqYdwn61zCNsu/ZvDF4WiBUP3U=;
        b=qbOOF+CWxP36d7mhy1ObfTRR9RJQJHCJL7jYCx3iHKvJn0bPBRT3+UUdeWwDYiGQ4T
         /6ZQOQQRvkeGUnbb7JR/XJly/9IoriWP4NfKtnRiadYGfJ5rQIlMqymbrf683jNrZGxm
         s6LkjGsQAI/AnuEyzM38omxi/dGJ6p45CzN6kSoKHs7PxWFywojHodd6n0e/2xE0k8U4
         AcvGscXJeFrhVpnIpdMCGEA44JOwpEZZHRppe+wCF/fT7IvEkafPdamSVS3LjmEExv/u
         NCfm4KFupSKb6VVQ3JchfeeI3dfkVcmuSBJaPfew0fMEI1dsaoj+ya2Vi11pHerJPOrx
         Azrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774568584; x=1775173384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b0fq2X7bSFhgpO5BzfqYdwn61zCNsu/ZvDF4WiBUP3U=;
        b=ltBnnPjgvzsFZU8INvxtE1nP9naM4gI+XAL4UqEYJClmWFrD2uMfkALhRIpaPuY0IH
         EOHj8b/bIZfy6W6xiTCcJuby2X4gqvUyyMqa2Y9e7QON/1kunqUUzKEosGem9BzfXNOJ
         BYAWoUe9GxgIwN+XVnG6vy+IEmUkHKBS/X9dK4K7csuokjFVxa5Md2fVPxg1GGBJcsbU
         3viCsApv2E86j9TVpuKGMViFS1DYQko/6S/xsdKRskYyl3NWZ1Tbk1dqB2mZK7nKAw6R
         9B3UKD+07CZJMze6yzSoiNqUCgvhSkoiZE/RuKIN+znP21t5IQRtLmRdn2B7zUXxQoup
         8F7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyScNM6DYj9C8MBVA0LmFFXqm+kdu4PEKTmv0U9i8G4upgzQovC0P0wJTmcW4k6wi+u1mB7+Q956s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7UV9G+oiGaMIj0QvV8iKnSNoh9yRvsCUzlqDcKlcz+EnhheMM
	gmrMA3EkNvpupJla/liheR52CHqM1ppvxIjY9GK8pe5s6GnS94B/2e8NZ4YkWQ==
X-Gm-Gg: ATEYQzxJRtYxr819yXLWZjoUnPXMZArwAza+uIQvzow+g+24AXgeEZTEK4kloCvOwuc
	QVc2fj5VnVNhKotV0vnAdgZ1L99bh6ccgKyo9uyQ1ToDlJuCH4x641z734ZGpUgqGJXaSBPzlGG
	fIeAHfYrR0B6UQfuB+UlHVuw2Dwf6e63jT9D6dMJWjdcYBBiJVfMWvBjo0xDElcNR94IBnAQpQx
	I7JU4Wh6fByK/1BFOwr3i8XlTg881MzKYRbYlXc9kUEdvGq7UU+LuHtBWXS4oEVtkDp7520taPh
	Tto9DwYkCEJIh9TciCa8jnkW6M/QkQTEywzwXH5Lw1uRA02+Pn6oSXgdoRKiXkcL3v3sVdLoy//
	yZ+tWfCnZtbGzmCeNvvdoSVh5CO91BV5a5j/GmajkA3AO4kuza6HCMFfrwcDnilULZvNNrOmZ+f
	Izu/ryQD+gmax9W47jULRWAitCfbcjgJOzvmQp
X-Received: by 2002:a05:7300:ac8a:b0:2c1:5134:54d3 with SMTP id 5a478bee46e88-2c185e12907mr311048eec.22.1774568584153;
        Thu, 26 Mar 2026 16:43:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ec277edsm5333936eec.3.2026.03.26.16.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:43:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 26 Mar 2026 16:43:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, brgl@kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ina2xx) drop unused platform data
Message-ID: <5f2226b2-3dbc-4ddf-9ffa-1b8792165753@roeck-us.net>
References: <20260326-drop-ina2xx-pdata-v1-1-c159437bb2df@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-drop-ina2xx-pdata-v1-1-c159437bb2df@oss.qualcomm.com>

On Thu, Mar 26, 2026 at 10:30:00AM +0100, Bartosz Golaszewski wrote:
> Nobody defines struct ina2xx_platform_data. Remove platform data support
> from the drivers which still have it (it's effectively dead code) and
> remove the header.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Applied.

Thanks,
Guenter
