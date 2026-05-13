Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42EA3D88F2
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778660022; cv=none; b=bXFZkiY3wRQcUFXlFZvpK5ihtzYC0nXeTOX3FkJljwd6776F1cHXODcdMjvrIs2q6oMbDBtsMI5/QDlZxJ6CxoX0AjzNjzL/3CA60aa62EIcsFzs0/aW8jWKAJBmZjAIFfR8wWxvcyMQHEdETWus5EbauVrTcIV/evltBxUvs2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778660022; c=relaxed/simple;
	bh=W/Tm6ZY7aqYTZnCt8CaRAJtaTbcydmqv0HpK1qTn8/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sqpZgybUMc3HCp8ZU1UP88ty3dKihvNxn9b7Yt7d4S7i4+iZMD5w4OGnAEHejwoMYiLJWdWqgnrSMmcn3KyJqW9Xshtw/ucVUhi3ri6n9XLM2P/0FXjiusQ/BPT6taFXmESQkfFUX6GhoUo+QIq6WLXQxz2hWJ4rr4L1xFtY+rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWAQ2p/W; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWAQ2p/W"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48d10c981e4so9152215e9.0
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 01:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778660013; x=1779264813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/Tm6ZY7aqYTZnCt8CaRAJtaTbcydmqv0HpK1qTn8/E=;
        b=DWAQ2p/WrtT9G4AylmvAi87/oSxO3/tXobJ9vqLTTb0Y4fwdJiMIl2OrUcC/ro5Cya
         SoOxGSJyNiwUYii0syYCsU3G/Ash97+rOoxYvg9pxDW0KM7c8KOiKRLT7I81sAa1U5xP
         2GfV0cLsvFDu1VOBbdOLmt55fiNNB+R0uMBtug0SExNsDU4Gd2q2aJxvWUwL4v+MNMEU
         7AvTpGgCxhkgFGDK+XmrBVUiMGxuPtv4nXpAyGR2adYMpYYCWYwHxur5M0GH29PAFXHY
         uFQBjdc+/X1R9Z+aIyLMbraceGA29LRDZviu3rqNRyHANlx+Pzlz5ImoOYAwTsuxvsWv
         p0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778660013; x=1779264813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W/Tm6ZY7aqYTZnCt8CaRAJtaTbcydmqv0HpK1qTn8/E=;
        b=HK5e/lKLMDDonHJf/H7FcTVWyzPjQEa6trypQq/OW/FwBl/nHOHT/67jmvDF+tvMbl
         ieVGZyoEj7gbCVQxL7vKfxdXR+2QGnBx9Q+mqhEO8Mkormiy6gJcX9kFgqCxuH7+WlH2
         dwpAyviXqnQ0Hyfgg/HsIdRtwCeBD7CC38DBqdegO45juDdZEDgBO9FZpTi0TFjgvOH/
         hkimjquf3tdjdzGe6hgvDOCZp+g0jY/knDlR4Dw64TeB/XFtoUH32zSdfLB7FmZlWyTW
         OGlpqyFvdpchx9421pKIARRoNdHHJbUGnUPqJK+LXiWCiHPhzfTPOLtRLbu8RYFojluf
         /58A==
X-Forwarded-Encrypted: i=1; AFNElJ/g14/MvYHOvpZMApMOntZVHe7YQAxHPEuacNi3B4nd1XuZgePj1WAeHm9JX+Y8gtl+tyur2xqlp1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjdg+nwl07l0Qp3Yms3NPwrkl2tRodLVh/jEiMfAqQ7KPi9PJO
	wX/a3CuUUMMsk+y3eKgENQnxHoboIJ+4F1pYWP+sTiZ+P9SCEvf2q0OUbd9m9A8kfbc=
X-Gm-Gg: Acq92OEfexJLIp04As6xYX2LeOQ0yxwmlM5XKou8k2QG8f1jRv25k6nDMNOQEK0n10k
	DHa8vrapzf4wPUYUc7XRAUhkgVmuZf1KqOLGKudOt8DOzV7ympikQX95pKKnYn/UIehnKTkZ664
	P9UryKd+t56Q/RpFQy+4eJ8pWavZYhoAVZne573gXR1JfkvIQsuOhArQ0TMMH9D9Slyt9PBZ4jN
	x0jRkTEbzJLKiMZc1OwRIG35P07EbR3jBaKVE2puLPDzHkDez/kE2W8R43ZujsIM0yfEg+CVGyr
	qxbcyJxcKcRPGfphT56bGbfMvT0bgfPAyiMKkrwP1ZeLhC0ZY/Kd+zdj5JhKqE05jmFxRVpVIaA
	0i/Is9XYg+JB6LjmloaT9zlPFRJM8my8QG46FV/G859YadWXIpv1Jxg8j2j8qtv+ENrBgPrREHd
	vq3saxmOj34AVzEhMlDomhzbDAjeTH5RRSWBF5RnV66nS+
X-Received: by 2002:a05:600c:840f:b0:48a:5501:799a with SMTP id 5b1f17b1804b1-48fc9a25a54mr16601985e9.5.1778660013080;
        Wed, 13 May 2026 01:13:33 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d7438csm50140965e9.14.2026.05.13.01.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:13:32 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: Re: [PATCH] iio: gyro: bmg160: bail out when bandwidth/filter is not in table
Date: Wed, 13 May 2026 13:12:51 +0500
Message-Id: <20260513081251.1781-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260510023500.61036-1-sozdayvek@gmail.com>
References: <20260510023500.61036-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: 22b46c45fb9b ("iio:gyro:bmg160 Gyro Sensor driver")

The set_filter() path is reachable from userspace via the
sysfs in_anglvel_filter_low_pass_3db_frequency interface, so
userspace can trivially trigger the out-of-bounds read with a
value that is not in bmg160_samp_freq_table[].filter.

Stepan
