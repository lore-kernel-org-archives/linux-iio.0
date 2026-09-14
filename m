Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821F1364959
	for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2026 03:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789357523; cv=none; b=aG234fSKKWY+dFgK7WkcEvQMGrkAz0UXsaT9jcgc58fBC2A9NGoljIVodGNJsbKdxRtKjGhJluC43yrS2l82PoaCYUFOF9j4ivRrDIQ73WAEHGWxNJ4/XrN3cpH1vULSHa1YqlhRnbzhRkTBDW9GQvJ3y8wXBxeAIQXtrMrza7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789357523; c=relaxed/simple;
	bh=nEQvniAYjY06dN8L1spstzHJeZhroLN3mj4n6Tpd8Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwAUI6JTMEQRVCFpCvAl/pCk9gpgjEH/BDpmXbLtrpdnFksXr7jpGdNps9tBvCi5YwGwK/wDqqPc0zMC+srZuhNn7Jm8RIOkLNGMHj+c9fAnE/Oe6Frsx+WV4nDsL57Zn56pdbNzpVf8oe6t9q7DKhNqFP82EuLUYlZ1gkHHZYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvPQeMVE; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvPQeMVE"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92ed3993c1eso182651385a.1
        for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 20:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789357519; x=1789962319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hx4IFiiUO6XLO/s3kNZnWsmhsivyvUzhEVkE3MQOHQ0=;
        b=ZvPQeMVE8DjMEOHmkhr9iHf4i78JMcq/FTl0nn/tWK8ZtQMWzCskRffu44RTt+Lfyk
         ktZQ0EGiAuAadgkoK7mBPRn1PxklCksCyuuH3fboyKDGHdOrU5Q/RJhPiVIKOnRDZ+OY
         nqnpNh35W76+PM+O/+2XcPkCjjS28IMaiOVQG2imlAoQ6Rj6jqvAHesGJyGNHvQNPiJJ
         8b8OqpDg2iEt6l7q0Bg7HfXIU5+hyqnZyL/RKIKaKHAJN7Vq07154DhgWFQaAWQUwSkf
         adSJDykU8UeQthHdZs7vxIwZLyAA4fJrL2Yit8bfbbefhsA2xErkVetz0nVAtkvOm+Xk
         ZOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789357519; x=1789962319;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hx4IFiiUO6XLO/s3kNZnWsmhsivyvUzhEVkE3MQOHQ0=;
        b=Sah252VCXQWrkWjs5Mfk7ZyABDXGxaABzdcH4Q9lB7npTMh8MwmG5cRln74LooTtg2
         oFxds8E1dD8oITcQI6xRAZLMl1qo925mCAWoQUbooSRyBTH5eZ5NWg5RL7rcbqcTazY1
         N2W0LAIxctyzAHCT7jhEYl3WKKCV04AK+5kHouV8XGvI8toqD8C+yGLz+Lo3uTctqbjx
         m3qnWuHiL6HrWOUzFS+qLyE2RiGt5eIu9jPnLYEdxcqD7ymFrgu9rUDbGdL1llG/65mc
         sno0lJqPJuIDEA2INXbOhOR2jA5U+wzsbopHaDhBI3PR0piKcxXPojhhmp2vyNhspQIf
         M32w==
X-Forwarded-Encrypted: i=1; AKwUvBzmF+NKVx/SyGHeWXf3/h1nG3E/fHKtf8dBFq6Wbn0JpD/7zpQShtMDiKio+MOsaX2fXoOrt1J6Jt8=@vger.kernel.org
X-Gm-Message-State: AFuF++lGXgvycS9xZO7+9eMVIBrXrIn4Kl6lltPXsWKW98mpGdhi7nVv
	u3cAYzgY/uKwszXpVjcrjyTVowi78qf5MNGvQ5LUxNrJyig0oqwMbcqG
X-Gm-Gg: AYBFou2oQTkguuWQuvUtmgb5bOfFdjIsrNFdawokcP0s/K535g2k0DJ7z6x47HAvERA
	g4Bco5RGN42DPe9m6hZ+W/AVlJnfmAvd+Af7RSlspOzSpuRAqXP10Q/7/KZzRJQzXnUBKMERKyx
	GA1BP/9WiHkXPzoGPuM+vhw7+r7UcALA7kYQJ+iD7qSa7nIVF1wdrT6rzzrpyZKhWQ2XjO9+DxM
	I4p6n8Y/7h7dnGwUooxrQMdui9yGNNF9pMAXxOT+iWyJ/RgTYrsDXhNYJlqSbDeHpHUkPOh8pr1
	IZQ4Mt5K3lcyVp+y6UY++ZzhsdUWLJu0AiCxHocUBDNdiFJG1vjrFWNGJaPX9pHmup25q2PUllM
	kFYXQZT7XZo5eHZ/EwAIl+IJni/xR50hkPH1uh4/cwNSk+PsYgOQWi6hAIJeFBLq7tIKI8FuqBt
	6tx/V1ECkoAqWApo+xBCMIVfPT5jCexSKC2oMnB55jVy4lNBHAQrLVhfQu7T62+sFKhsw3/ILS5
	ej93zla9Iok45X+Ici24HCboqSu
X-Received: by 2002:a05:620a:31a0:b0:939:2d77:d6a8 with SMTP id af79cd13be357-93a299eaab1mr121544585a.34.1789357519511;
        Sun, 13 Sep 2026 20:45:19 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93a26921baesm104710585a.24.2026.09.13.20.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 20:45:19 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: adc: ti-ads112c14: add continuous mode support
Date: Sun, 13 Sep 2026 23:44:23 -0400
Message-ID: <20260914034428.2165528-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901025147.583b3f61@jic23-huawei>
References: <20260901025147.583b3f61@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jonathan,

I took another look at current_trigger_store() following your comment
about the possible TOCTOU there. There may also be a trigger lifetime
issue in the attach path.

I checked mainline commit
fd73f4a6659897191fa0d40695fe370925dd3780 (Linux 7.3-rc3).

The reference acquired by current_trigger_store() becomes the reference
held by indio_dev->trig, while iio_trigger_attach_poll_func() does not
take an additional device reference to the trigger.

For example, hi8435 uses INDIO_EVENT_TRIGGERED and allows changing its
trigger, so these stores reach attach/detach. Assume the consumer stays
registered, initially has no trigger, and T is a sysfs trigger with no
other users. No one writes trigger_now.

With two independently opened current_trigger files, the stores can run
concurrently because kernfs only serializes each open file:

  A: select T via current_trigger_store()
       acquire reference; indio_dev->trig = T
       iio_trigger_attach_poll_func(T, pollfunc_event)
         allocate pf->irq; request_threaded_irq() succeeds and returns
         <preempt before reading trig->ops>

  B: remove T via iio-trig-sysfs's remove_trigger
       iio_trigger_unregister(T)
       irq_work_sync(&t->work)
       iio_trigger_free(T)
     clear current_trigger with "\n"
       oldtrig = T; indio_dev->trig = NULL
       iio_trigger_detach_poll_func(T, pollfunc_event)
       iio_trigger_put(T) -> iio_trig_release() -> kfree(T)

  A: resume in iio_trigger_attach_poll_func()
       if (trig->ops && trig->ops->set_trigger_state && notinuse)
           ^ possible UAF

The consumer reference keeps T alive after removal, but B's clearing
store can drop the last reference while A is still in attach.

At the pause point the IRQ is installed, so B can detach it. T->ops is
NULL, and free_irq() does not wait for the enclosing attach call.

I have only checked this by source review and do not have a reproducer
or KASAN trace.

Does this race look possible to you?

Best,
Shuangpeng
