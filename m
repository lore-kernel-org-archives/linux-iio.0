Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E5D54705E
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790757026; cv=none; b=Jlm1fmouc4v/qy8L3zTo+DuFOAz5wqf4UhJS9YQMwUZ660V44uXzF0sce+nZsP/XGcFN57+UcxcaC1ixzjzO9/I8umTCaPsMhdtaWzyEvq6CTKzplxDtzyjFsAclBRxbp0he0+/hVoCXBgmpcS3VfRDdt62hTVHgsnUXHONh58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790757026; c=relaxed/simple;
	bh=ZTLy2b/aZ6jnk96E49OmqQA6r9eoSOmIhpd2yxFKaIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVLSR95nFE6d8zdQl0q2h41SUWpcFxYgRded+YXnJWWC5W1oSiMLlL5HwKUS7MJYcJJE8CW/Hf86zBl5VxGfHlmjf+uZ6eikrSwzzKd5Y6QYiJHNZgNycRBTj0HKFtx+3Fo7CuiPrNnfB70ZghcXFMOeVzWdGZFWDwSYN+RE1JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1w6eAP/; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1w6eAP/"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b8eb3a9d9bso4561329e87.2
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 01:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790757022; x=1791361822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HsFzur6ZDixhPdht293SKHwUgftZBx+zn+PzskiFAnU=;
        b=S1w6eAP/aW4ZcEK9/xRzb9Jj81Ff9uLqlMuzPoaDd3U0qd3nmEx+Hv2qJt982bMZwR
         vR7YGrciwrIUW4+rMlDc0cvWcS5xpOphkmEKgld5qO6jbSvFc6+guuPgrnoev799iXT+
         xA2awM0DZ1oZnokupBBpnj4uJzfujVfrXYsechEQwbeI1BJLFYq+o5D84ERfIBomyO8w
         EagQLq+lYi8cHnKUtQwOH1fO/GlqnCSWLC43cOB4vYU8gnbA7pqUanTgT1M14541g1R6
         h5JV65uNHAwTI+NNU+8Al5RAjF8wUk5sqVWah5jN9zfS366xDOrEoCuAr+sayxVq7lMp
         DS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790757022; x=1791361822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HsFzur6ZDixhPdht293SKHwUgftZBx+zn+PzskiFAnU=;
        b=tYK53o/+WeoYtN3s98XWKSicu4vic6yyy9pyJQbYKsTsf0LPSE0xW+H7mjPrJZu1DA
         VrmPz7cxOgZZAr9FkqVW57VXj3p/6vK1uyDsqiXneQtouDSvS8k1fHwR3U6ChzDJOb7V
         fVZR482uZYS0FJGZ83PZwxR4tHYKz9+Yt3c3QFaLdsjFhBgxHjc3XUoscFldwRP2G9qc
         jGcXaFGjlbSQIlAgIwboV8vll6mgvP5Wbg2Xd2r9tGhLDdrk79U4XvPw3db2HaL+TJe3
         ptoTn3beM1QcXPiIt8SmrZCgZ6VWtHttU6GlDMXlLMMpJ+Yr8h+g/rMqwgDoPPu6wE3v
         o8tw==
X-Forwarded-Encrypted: i=1; AKwUvBxq0Kv4cBFMvWuMWAMdKRT3VfItXkh10vxOhEcHPznYSmuIXE+VLlhT0Bevkt6zhnCSai+Rw2Vv18E=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfQGYQeiNSqt9WaTNBLoBifiTRcDqIedhqKUH9IDpqBBZStqAw
	9GCtRN7Oq/IeyOzkCHf98aI+LNZDvHwBjP7Hihnw0UTDtfLFyagUpNnh
X-Gm-Gg: AYBFou3EffXF1kURZgpIgv8o+M/cVsi2cE4q3JHhEwOhOxQ5lsNKSkhJk2/3vHSCcaq
	H0I4k6wKuBqW0+XJVvCF8VUjyHCbUl7oLhufodnWBg3yVmYYQ41jML02aKRmBLMC6tLe5FUslRK
	bL9Yzps6S+HeMWWWF1009MYk7rcOYyvlePEiq+FxUg14ynQtpbUoD8U23ydwe77PIrzWClLCfOO
	Er2tup00hhi0OyTUGUo8Av/hgFiGAl5lOP+fAnDCUUDQXYh1Ifxj9cQ0v6jT4Pn+xPcFi5ulUfm
	SjDBiXGwkoVKdhPvJdhtGv5EuSX1YuT4HGOZj9kbGC1wYLAjc7m5MkTSaCbs2kYm7n9b8dSXgrd
	Rri7ixu1ypMBEcyhvxR09iacCfKPa1WsD5trxME5JleDzFgwl3nX1LPZpYzqJQChwT9tHpakpon
	R4/gPQpW3ltUFp/biP1MlWFSZ1RgBtKadmYuS/iCJCuG9mSa4z8lyjoMD5JeBvKEJzSxulTtHXp
	ucR2pYef2IfM8A2A1oTdMcOOxSMi+QYxFx67efaAtgTPjPql4QJcAMiITi4nCtZ4VnNFgk=
X-Received: by 2002:a05:6512:b95:b0:5b6:183c:5ca2 with SMTP id 2adb3069b0e04-5ba406177f4mr276043e87.64.1790757022218;
        Wed, 30 Sep 2026 01:30:22 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba3fc08d3asm187309e87.80.2026.09.30.01.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:30:21 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: andriy.shevchenko@intel.com
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/3] iio: pressure: dps310: read buffered samples from the hardware FIFO
Date: Wed, 30 Sep 2026 11:29:52 +0300
Message-ID: <20260930082952.878967-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <arriSm8L567yqOjV@ashevche-desk.local>
References: <20260928211127.641828-1-zoone.rupert@gmail.com> <20260928211127.641828-2-zoone.rupert@gmail.com> <arriSm8L567yqOjV@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Sep 29, 2026 at 12:55:22AM +0300, Andy Shevchenko wrote:
> On Tue, Sep 29, 2026 at 12:11:25AM +0300, Rupesh Majhi wrote:
> > +/* Returns which measurement the entry came from, or a negative error */
> > +static int dps310_fifo_read_entry(struct dps310_data *data, s32 *value)
> > +	__must_hold(&data->lock)
>
> Hmm... Don't you want to also add lockdep annotations?

All __must_hold() functions here are static and called only from
dps310.c, which is opted into context analysis since patch 10 of v8, so
clang checks every caller. If you still want lockdep_assert_held() I
would add it to all 20 in a separate patch, as 12 are already applied.

Rupesh
