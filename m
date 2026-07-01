Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E14135E93C
	for <linux-iio@vger.kernel.org>; Wed,  1 Jul 2026 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782922937; cv=none; b=R5bMdrZB8SMhFZYatcRlGjfRxXAc6fNiU+09H9PrNNQaZNRmtEcCNPFpzZ+C02Fiu3PZqMCHqGqmDtwSfEfmoEKq1SzePU4vg5tWsjZjC+b64YKF4sl3QPSBrbGa3BjKJpod1EVVeB6rgPrRNGTbvtt7uxb0rG5hNYWmCZV8a6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782922937; c=relaxed/simple;
	bh=ghnmSn32KA2pmz1YV1qVunziiD4cwnQVpbeGx0vFXfw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJVlchd3ayKnjwa+7mFA+RW8n3pVLjiNgCsxJ664IzgFeKYDHizpNt1sN6XyhT6WFEGuWaK6QHH8Ap+ZtLnuOYpb5gYojiiPeKvIOOwCeiTJM/B7PaiZBW2shaLZwKgZygxfMrygkqeg1vaSFG6qTLP+oGPpjgaoAapO6+G5EYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+KLNw1A; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+KLNw1A"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4728c12ba97so560326f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 01 Jul 2026 09:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782922933; x=1783527733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTl0Xrk2VL81HcsN53vqjMgr5tHj1yG6DZF1PEU0RJM=;
        b=V+KLNw1A4ew3X+5ItwPHGelFICgjCXwXs9ReIg5KTW/aVi2wkWETEI+tBWS2PUvWMK
         XP1TV7qGiHy0Cios6PezEgoCG7pGkYAUCWkMVxHplgKYsiyWBd180n+FhRkKOXhomA2d
         qxd4aQtKR6Tgw+bx+I51aPL35kaAJMYK5Qp8Jrz7O1DnXTUVS93zFirPsS+FaDlmEAK6
         heaVpxgpOQ3bkN3v2bHbBP/cgDWuHaXbjBLvxz0Zitrkq80jjNHvVH/7mY9vrmB7OsMh
         0Fj8BKE35gD5+bDTT9BRvHaFZ0/CJvaCiiodeld3BAaPihxCjUF2kIHZZgfvCi8TTC7r
         ZjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782922933; x=1783527733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zTl0Xrk2VL81HcsN53vqjMgr5tHj1yG6DZF1PEU0RJM=;
        b=fD3fzEQb3sdtxFGZzoAfjR3mUjxWV0hj5J/qSFgrIxnFLWPC/BS0mOeJEt5Vw5fB1M
         uNsiAQmtKd41jN5lRwx/Q6AncDZzXlk/O64No6fJmrFLf0l7UWi/4vAjmUYEPVcsABLc
         G9eNxUJsR/hlTpI9/qW5g1GZydkKJdTjJvjVnfdGTxzr2m/s4lB5VzqAWDTwRwjdaDu+
         ZBYOXabhxEEMVjFmMzBs1zNarbBJE2x63OngZnCFLbBmE4JQfUCEglJ/gPMfowkr9e5O
         zo+7r8fki7gcAiSPNxyCTCBNB+6BdKBz0h1f/0ce0u0kprQ8Uu8wgJzOAj43W9Al+Dn5
         6JSg==
X-Forwarded-Encrypted: i=1; AHgh+RoS2eDsSyWcxvkU/cKITCaBhCE0RAnA6mY7lDhu8SI+gLK1h4pBCnUwlgdk+F/H8+RS9ofyDwj2aJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1k0LQaXJ5j/aXjF9LRFlm/+6mkCV7gkVZZTxujDX12cWjw7NX
	f37EFx5v1jjlmWhzPxS+ivXZOQPiEl/NEUqiJ/XWIpnaNLVSco70u/iZQN6J8fYP
X-Gm-Gg: AfdE7clSCfHqSxxixJVGhPNbZsbfq31Od/+iqHmCMO5yce6DvKe9rx1/kMAv8Gme3zu
	x80M9hgDx0LB7UY0odLQMvZiBjvjlAIsaHL4/W/y8VtaB1Gh4oTzyqLS+fM4gl0jOTqOm0Hp14a
	ir+L+Qqod2I6y6wbXoiMoIq8uG/mjdW1lpgXuZUd2iTYNLIBu8P1o/ScgfmjxpfU4wG53cs30kS
	Sko3PEtSWcnpAQIOnGwuR8svtnQ6PV8u41tbyc0HjoSJCjUYh63nXlR/ptq8Vysk/2MaSMlOLDF
	WqKhsNOZ1r1LMrj15jfsGu+uxSg9aijFIH3rrlX6p82GQS9NiIkAYp47V2R0V0kWZDa1h5GFfNz
	qfL5JE/afOde2l/vhtGlf8bKrFz29J0XChOURSaUgB5kdvKg7WBtIDeODY23G6W8O4Ixoa2SxgJ
	qwEpDAY3CT8S2mHkHISU2ydyZABq3RbtI8bPgVdjBnMetjPZTlPxa5oYG1r54PcwhTbXJ6m9xN9
	z/fNAxA/0zXJIfojJi7uxvhSX3EVBUw1TpQaXU/3Wknq25fqzeH3KazubkhoLj6SoV9obNb+SqP
	BFxP8xrcsbT0MBWj
X-Received: by 2002:a05:6000:4203:b0:46f:9c9d:d7c4 with SMTP id ffacd0b85a97d-47759098536mr3837213f8f.39.1782922932621;
        Wed, 01 Jul 2026 09:22:12 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477ddf0f27bsm840420f8f.30.2026.07.01.09.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:22:12 -0700 (PDT)
Date: Wed, 1 Jul 2026 18:22:10 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Kittisak Boonmapa <goorock.goopop@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, srinivas.pandruvada@linux.intel.com,
 sakari.ailus@linux.intel.com
Subject: Re: [PATCH] iio: hid-sensors: Fix poll_value sign check before
 msleep_interruptible
Message-ID: <20260701182210.4739035b@systembl0wer>
In-Reply-To: <20260701154319.23497-1-goorock.goopop@gmail.com>
References: <20260701154319.23497-1-goorock.goopop@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  1 Jul 2026 22:43:19 +0700
Kittisak Boonmapa <goorock.goopop@gmail.com> wrote:

> hid_sensor_read_poll_value() returns -EINVAL when the HID descriptor
> does not contain a Report Interval feature field.
> 
> _hid_sensor_power_state() currently treats any non-zero value as a
> valid delay and passes it to msleep_interruptible(). Since
> msleep_interruptible() takes an unsigned int, negative values are
> converted into very large delays.
> 
> Only sleep when poll_value is positive.
> 
> Fixes: 5d9854eaea77 ("iio: hid-sensor: Store restore poll and hysteresis on S3")
> Closes: https://lore.kernel.org/linux-iio/CAPr6G1qLDrgHvCNsVxj7xHxYUKkAkyo87Hq3Lfyoj3RaZ2v4dg@mail.gmail.com/
> Reported-by: Kittisak Boonmapa <goorock.goopop@gmail.com>
> Assisted-by: Anthropic:Claude Sonnet 4.6
> Signed-off-by: Kittisak Boonmapa <goorock.goopop@gmail.com>
> 
> ---

This bug was introduced 9 years ago!

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
