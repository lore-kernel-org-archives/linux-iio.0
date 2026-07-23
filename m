Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B7B3E2752
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 21:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784843748; cv=none; b=CaMpvWKNSM8ou8QT2qRsar5LwsfZ6P8pWOQ7QCntdae9JzBgb2S2CHrlIa8bb5nNcryP8SX4BGPGGFZDvcgo3tT0ZryXBXNAV8s74V+kArB5kW5cKJDCIez1/zBW3z6aqg7fPTLtXRLLz86kr/xbBmHp3rvWUNUzqFQCpMeVpR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784843748; c=relaxed/simple;
	bh=VPg6rAtVJsb91gbWoQSIflkk23XesfyA3CglwAbx3B4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e6dN6omIp0Ui0AGdhdsj1ySg44wFjKIoWXuokEpVylgMoJ/qNDqLllUlXCmF4PJXvKM90JkmtiMMeqaVFTKlMK5LFw03todlaVilVuxUKCx5QixJ91aK1fEBy5vB58vuT3kSet79x614PPdnYxu5OPiNCi4kd6LmruMfy741ck8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHEt1YuY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHEt1YuY"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954afac04bso11058715e9.0
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 14:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784843745; x=1785448545; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GI+1TZTSHVUv7hNRHiRGiiEfjlN56a7Ttsg18X440BQ=;
        b=YHEt1YuYrbHBqhSRPz64ICfiUZgzKoa2nwRQp4ecYDd+x7Yt1P+sN8z6AsF8oet304
         S8v7h4f9txxb6eLN0tE97JyEHiLT7CeBhrM3W6YaT1OcCMeky0K9lAlGMMESr9/gsYJ6
         F0eoyla32I4ChwQTZXKQ4TKD7o9P4ux5w+ooIZnFRYiFlpVzNG8QqeL0ISdGqCG4/oU9
         AUfRRQAYFnbLQdGKuLPlGtLNcWObE4y9GKUmSSeXZn+n/Vk6Kc/DsAaNkJKWsecj4Uqc
         g81vS7aTcRJRpKQTbIhDaJCE1NOtb5qlU3KUz+FN9zC8KT73wosoABHM6944aBxQ8zrp
         Wnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784843745; x=1785448545;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GI+1TZTSHVUv7hNRHiRGiiEfjlN56a7Ttsg18X440BQ=;
        b=IeD3eP9DKT/n7yqJ5XyyBdpGi+71+O/8qtGr7fdH/kNUwot5r+VcOMMgEciZAHfIPZ
         BSBnc37CC4NYB55CJahZWr7EpOf3xL5pCumoIMS7ad9euMnj4QNu0wa9NoUWn2Qbo1rh
         w+bXoHf8t4A4CQ5zfnO2c0il30WrDCEtsDcbjQW1D6i8nF2ofJBhHttucv79KI2hnejt
         /LClAH5K+KF1rZIJHnJFrWLIpaS4yaGyPUrnLIo6J+gTsnudtIyTfimq19S2Mm8di7DO
         1mj6ZjDaVwdt+ePJZUxvy3uqNnOZVasv0Yi95gIuFpNVG8dAqlWlyauFymsPcyk76tyZ
         1fGQ==
X-Forwarded-Encrypted: i=1; AHgh+RqoqESJV1ZdpiFhn974AvW2yQI2BHyFnpH3eoZKDxHDXfuK+C1tGsX1wnqY/e2Gi+yU+IUO6dmxTqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDlTlLAmrA1PJI2g6kbtoN507A32PNUk2yug/9IXKfx77iI0o2
	Og/k4X/oKmKJX1KWmX8pUzCmGvuEn2Ha2RXctsOSRj6siGcN5H9+0yLM
X-Gm-Gg: AR+sD10M2NHF0Ub3kMQBPsiNdDx2zY6u5y5mz4EYEGA+4yXAQ/DyuRZ6oQdFND2zUgq
	zzLlz+jgILO+vI9XEAp0iVdKRRw2G10huyJUj8pFbcm2GI8D0rjZTQfzyYx8WgGBrmQjN3ZaVr4
	t57RUvf3abWeJKRq0yW402EvwM+GjdO4Od4TVN+z+WGfRrGCRUro69KKlYyKCASgQnwgfRKA+of
	G+bl7KyIC8j+tpLh2ITgmjAVnPegopKe6OqOe+N7s/Po8M3A3PuDPkK2hyuNwqHk6KI7RdIJcfV
	q539yeUlPbv3lrVQIBzPJTeSBrKt/YTXLXRfBIlxyagLR0mzFQc5YHJvkGENYNXEsTq/+62ysOE
	RywGHrGp3Gecr1FIRx0sVLwHF19iuRva3qKcMb20tbLxLwI12nxY4g+9yaszsSW9zUGClY5SmXm
	xHCQmObx16YJvdrbM99etV9sYDk4RkrjR75IoX0lp9aJAEi+9d717TGr5ySRIEe4XBDk6Mnw6cT
	nX8ozz9Bc2FzAuCiyE9ovSfi9ptMZPKrAdZfsJVgqt1HW9yQhCL1LF6BKeTUQ7ljxOR5o/b+fkj
	yfDdF8bvgHk7f3YOreESZEnYmwg3oWvqeK03c9PnMkJLQN5gV1slVCOYGuCYTLmEltn90gqE9QR
	PEP+Jtr6tQ5Y=
X-Received: by 2002:a05:600c:5718:b0:495:4e89:3f30 with SMTP id 5b1f17b1804b1-49573cd069bmr40619145e9.15.1784843744599;
        Thu, 23 Jul 2026 14:55:44 -0700 (PDT)
Received: from systembl0wer (ip-86-49-244-181.bb.vodafone.cz. [86.49.244.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bfac3casm10195525e9.0.2026.07.23.14.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:55:44 -0700 (PDT)
Date: Thu, 23 Jul 2026 23:55:42 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Adi Nata <adinata.softwareengineer@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, u.kleine-koenig@baylibre.com, email@sirat.me,
 krzysztof.kozlowski@oss.qualcomm.com, mazziesaccount@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] [PATCH] iio: chemical: sgp30: cleanup codestyle warning
Message-ID: <20260723235542.152a6a25@systembl0wer>
In-Reply-To: <20260723161851.21722-1-adinata.softwareengineer@gmail.com>
References: <20260723161851.21722-1-adinata.softwareengineer@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 00:18:49 +0800
Adi Nata <adinata.softwareengineer@gmail.com> wrote:

> Reported by checkpatch:
> FILE: drivers/iio/chemical/sgp30.c
> WARNING: Prefer __packed over __attribute__((__packed__))
> +} __attribute__((__packed__));
> 
> Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
> ---

Same issues as with your previous patch. Additionally, the
subject contains two [PATCH] tags, perhaps you've used git
format-patch or git send-email incorrectly?

After fixing:

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
