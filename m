Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793525135;
	b=c/Tdo12p/DZCWNDutRvTErcDa7So3amNuI5YhK+8h1C8pXvVUqp4AjGI0jJ4zrC74et0
	 hMD2TdI87OrdaF+6vPVgVxeBd2qF7setIwwwAtFCsU2S9DQiAAq8amMTL0QtfLuXsyRAQ
	 nQTtXO/7eAZROkpeb2Rk+irSkKNKZwwWKnonMKOqPOWPZHBA8OA9TQB0Essl+ZUpj12rE
	 gpFKT92EmNJnkd5qZ9HRH8ySdoalAZETRMsjRIoege4AKrIES4HFKtFHyFQbutR0aTcx2
	 0V4zII79TgMWoQwa2m0GuYT8SW6S0w7q3/B8rlfKaOjkg6PBb0XQzpYqzw6gKOsh6ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793525135;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RezLhFckeReSx7n+JaAFqSGfgExphmuMUiXgxjTqYZE=;
	b=MSMVZbO+LSgcsTq9JGJMknR82K1/Wy7MJd77ebAbedJD7PMvqffD7Ef3bvRp1FBshT1i
	 nC06HJlssRmT0x3kPUO2XnUi5z0w6+XjpLhyasfnzFngAkhWXZWZlNK5bUcPoWLWGzXiq
	 /iznUtuo8/8aKZR2vJx0dltHZ+yT+etrvi4vooSudsKniEaA+9PTKcTHUGeWq+z8Hm5+v
	 CYhQ+stNxy/aVmaRQqoO1a/aEN6OBfRENkLe6T4Fxxzlnunnr0gXrMaHSZ9hH8dE3gToY
	 n5hoWfsEFpXg2DgaVopnPgybCnirOVoylhP6ukiq/vW2ZWbY8pbpVf0HBjBT3JCOAtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=V14uc0Tl;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850E5606A324;
	Sun,  1 Nov 2026 09:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 850E5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=V14uc0Tl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=V14uc0TlbttybLNJg1tFdVjM7jSpjzYOrl2gaapbfyxbWy2e58KwxLGMXQqeH+ivLW/6bjrIwusbp
	 Cn9va8V77Lm5IBVW6deI7+sr/MAyCfnZdXANnJ2GG56Dfxjvm2wb0CIUCVilwqB0WcXZkfVl2KV6Ta
	 URuf/SPXaAGRIvyA=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76ae7057cf81-80220;
	Sun, 01 Nov 2026 17:25:30 +0800 (CST)
X-RM-TRANSID:2ee76ae7057cf81-80220
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[112.22.250.195])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36ae7058788c-a2fbd;
	Sun, 01 Nov 2026 17:25:30 +0800 (CST)
X-RM-TRANSID:2ee36ae7058788c-a2fbd
From: laixiangwu <laixiangwu@cmss.chinamobile.com>
To: jic23@kernel.org,
	linusw@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	laixiangwu <laixiangwu@cmss.chinamobile.com>
Subject: Re: [PATCH] iio: gyro: mpu3050: Fix runtime PM refcount leak in trigger enable path
Date: Sun,  1 Nov 2026 17:25:27 +0800
Message-ID: <20261101092527.219-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261101000404.41fe1028@jic23-hlaptop>
References: <20261101000404.41fe1028@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jonathan,

Thank you for the review!

Both suggestions are addressed in v2, which I just sent:

- The enable and disable paths are now split out of
  mpu3050_drdy_trigger_set_state() into a pair of separate helpers
  in a precursor patch (1/2), so the error label only lives inside
  mpu3050_drdy_trigger_enable().
- The fix (2/2) now uses pm_runtime_resume_and_get() instead of
  pm_runtime_get_sync(), which also keeps the usage counter balanced
  when the resume fails, so the manual pm_runtime_put_noidle() from
  v1 is no longer needed.

Best regards,
laixiangwu


