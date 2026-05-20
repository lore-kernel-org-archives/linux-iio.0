Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228D239BFE6
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779277349; cv=none; b=uAcxRJgDSFKWODga2pst7/KYara1EuIWfaRj6LTaEFT3bF+xDnorRxSTqZMbIlkT97kj67pSbmXm1n1zw7CGBx9h9cNkYVX6fB9XQltGejPRr2WZVHsxVjyF+Cabmwse7Y8to58NBZNHsyB9XIdgg/QO7gK9CGEbCwkGSY6aeTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779277349; c=relaxed/simple;
	bh=TAuvyYudARAkHTzjpNfFTMQwQ0je0Xwjq+y2av6CwfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PRnYlvsgkU8eVbyuKLAxo840mbkvaURWBAUzWl+VKJvd5EujL9Y6Yy4BBuYZLfL7Ux3enfVDssclNm8bbYSEhwWLlIKjVLC82GMlVamlB6NglTq6EqguHj5PXgZbt7F50i4ZGD4cV1Rrx482M1IZarkfEYJ4YPxYFzj0w+0tAMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=spkuAuKt; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spkuAuKt"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a8985fe4e6so586753e87.0
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 04:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779277346; x=1779882146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAuvyYudARAkHTzjpNfFTMQwQ0je0Xwjq+y2av6CwfA=;
        b=spkuAuKtLaB4HZH/1fxxhnlogCoR6uWa+2CWzr3jxmEVjK73XNEVSLKkG23+R87YZ/
         WDpIP3Heu2WS/o71AU33W1fuG+38st8RtLyoiDp7fFk51uEfBsb7Ai6R1j0rclskRvlw
         Y4qQFx4x+Jvx82ClYWak2bVSzDwPT+vKuX1V4ozFs0nApW7sDBA/jX4yMOPEP40f7/WK
         +b5GUaEOZlN2czs7280GeDEPQ9OvDvNWz2gKeiIexSXb0GaT1QZyrKxGJ/tQgD1+PvKJ
         4DfhgPvshTfaOxdMS20jewpdeYCMRnwL4nKClJVx9Z+V1ZBTcHrmklhnvHUKRRXi7ZMX
         h2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779277346; x=1779882146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TAuvyYudARAkHTzjpNfFTMQwQ0je0Xwjq+y2av6CwfA=;
        b=rE1YFhJ5FI1nOuTSPWkWPbfnafWT/sQgPu65YQYueQ7ivS4gviLJ1Ai+LHcHiFMxxJ
         rZQ/K0WHsTSl7bBBKRXmDM43RE6+Tq9kOf8d4FxVIov/FVyRLlSi/hkAHqF3+XJuTV2A
         6eVCVWgDeRVC9kQf5IHodH0Wo5TcRc/B5Lb+JZfSp4LTgBuDwpESXkgeFnzQtINM5lv/
         H5FnNrjG9aJieO1S5C7C5Yab3/9kVDLJDJmT63DV9SKsAmvmJaaYEJFQihRD6VEHcHF6
         cBgca+eeVqgNP3hQup5P2MwagjnEK4NPX8GuypCzTNLK5BAi6YBtuJAPgPtHraGsoEJw
         8hzg==
X-Forwarded-Encrypted: i=1; AFNElJ8o2NIsN8axhKDlVzIAk/wmqJcSrGkmLnkrVAZOxdiPoR/6I++7qDLK6KF/gGjUs7pb+E3CwLSTcqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwnys03zJWGn+9LJfNjuD46n7JxR2jJdxUkkNLwK1oo4raARHd
	Qu5HxfO50TdJOa9Qkknm1Iqgiek4ky9zK3CSCR9E4T8x0kT1T6oTPFrV
X-Gm-Gg: Acq92OHYqcB59VdlCj4FKcEQIMzLPwH5apcVgMF5E4OXGuEl6lNgg6F07YaD2CrocMG
	+3xeFzHH2uOqWOOrhGxqe1BjFima9o/VVWUZOWDseVG/ckBPhf0sgWoz8lpi9Zd8vClw7CxdvLy
	KlD913BlAbBlF7ggd1WVtDDu8YnLIci0H9xw65n6fwW3AaOa7LcvmaNngbGgQE8Ojuc3IGr6ROw
	sJv7vql6IjjDUhrarcQYqGIeRQf5hsNz99k6Sj/mHjpN4+qeSALYrWs1w9FafNWAToGOjcquYCp
	TNWle1K1eI2aR9c53yrNb2id2fAP+1kyEVh7U6xp2mRNJPoubascO0O/op8hLhDwqMCj30qsxPI
	QBdq69fhKo6To1ybR5MmHaKHfIehB8xLBBwXGE8gKj6WksVr+TvYJmaEdcxa4uAbbj8UfcQMfH9
	+9M6KQksldpRN2M+TdGWi+nqrLh03/0odZqmvPDbFtY1aNkGdRkwkeNvm4XiQDQXksrX6i
X-Received: by 2002:a05:6512:158a:b0:5a3:ff48:f7fd with SMTP id 2adb3069b0e04-5aa0e747406mr2918624e87.8.1779277346154;
        Wed, 20 May 2026 04:42:26 -0700 (PDT)
Received: from localhost.localdomain ([213.230.116.218])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164bc3fcsm4918597e87.48.2026.05.20.04.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 04:42:25 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: andriy.shevchenko@linux.intel.com
Cc: jic23@kernel.org,
	daniel.lezcano@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sashiko-bot@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: Re: [PATCH v1 1/1] iio: adc: nxp-sar-adc: Fix the delay calculation in nxp_sar_adc_wait_for()
Date: Wed, 20 May 2026 16:42:13 +0500
Message-Id: <20260520114213.14849-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260519215607.78241-1-andriy.shevchenko@linux.intel.com>
References: <20260519215607.78241-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reviewed-by: Stepan Ionichev <sozdayvek@gmail.com>
