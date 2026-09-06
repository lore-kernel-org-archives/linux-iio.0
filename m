Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42283126C2
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 22:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788732939; cv=none; b=CclrB1Qo+1iCi4oMW9oMQbZQ+fQk9OiTK+jyjUUxgGVoKMsBcm6GLC1j7I5cBAaj8fT3Ejkg6vMXtQqClcl6dmW0NiANzosDyV8Cr5os8UjaTsf9bBy+L5InEweo1A57LiHcLvQuKmvWJjIhM9KQSnHYKYdcWOPx61RIwdu9pAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788732939; c=relaxed/simple;
	bh=zdu8MAVqmcOr+XoknERUafm3+3CbOKJ8mESo6skZT2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFCtZG1OPLMAYW4hUfxGYdUx7H1OkLm6DZj1WxRVCx0mEVVV99hCFppYkk0O/tPmc/XPog2xaM41wy3hU4e1fBafpE6PDnvQnrw60uzinVW1NJSwgmGwbfyXHaFH0ITjjEdcT7KNqesmhf0/SFXvlg/UpYV8IGXsP7GeWQLI+BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sE1pN+iO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sE1pN+iO"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso23643115e9.1
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 15:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788732936; x=1789337736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YgXheOJxpTCFTUmGEEIzpEQ1QJwXxoH465RbAA8N87E=;
        b=sE1pN+iO4wiONWG9N58JE1p/vhrLM8M56Mfj4sdBwfzfzkajAYcwCLemqcchvdfEhl
         zvFxC7ycAqjUrquuNNLQopvd6+iBqsvMfwbc/E2DQdIXymM3bu4sOsArMzV99BTw1IG8
         Ldg1oMQp0uxWatxejYsUaoNO3Miv1Wss+00t8tPyVBB9RQgC7DYvbryxaQrRKfdc0+06
         DxlMObcXDeQAJno0sZ2mf8RUUMNdM5hqs36b+iCjRcagP7+nCKikHca1g9rwTAQhDtR+
         /8lGHZSz/GQbq9ylps2aIwAEGPqp9PaLEQze2AtL88gEP4y/Qgm6Ygwna1/uPJhbyPgG
         v6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788732936; x=1789337736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YgXheOJxpTCFTUmGEEIzpEQ1QJwXxoH465RbAA8N87E=;
        b=XV84bF+ZNKjlsDAaMj3EqcGqyI/G5vm2bY/8jpeKEVPstejytECXylj78t7tC2TEZy
         s1gITOrPHoUy4rImKw4RwVkL5NQ35XLeO/t6vwVufgYt4G0L/tSlp3/cJSeIn4fQ52R0
         UxkgmBSUuihwc9yn5OBSoWhjkgyNMYtrhLByPNl7zw1CL5UTs8zmu7OrfuvTNR7a+eoR
         kc+IIaVMZ1Aowq2oTrFImvhRa/ZAoF1myYTWOmxBJx2ZJ10tKPP1Uif4K/8yqHfwZ9E8
         byUbwZc1Jarb5TUT+dIdvjofM4NoTTryPCBXTwxcA5dVuhhS8AS39LTtEVqW3aAq/uO7
         MC9Q==
X-Forwarded-Encrypted: i=1; AKwUvBwW3AIQPRj1f8eGrNNBClaYYZAMrJ3b05Gq+CtuuCwF5yu6iDMP9u8T/R5/ORoeN07ZdE3cKTvNjl8=@vger.kernel.org
X-Gm-Message-State: AFuF++lV1ColF3wV0Wa+zxoYsr3v0XqlYMrYbUKS4KpWJrFzkVIQVu21
	1XP4T1eYtV5qVkO+qtqwCK8wb9WBZHrUhMjDfXxVrWxTU6ON5QRGM4rF
X-Gm-Gg: AYBFou1zpr98C2loyKd06JIh7BT0db5QG/sxGcYhHVqogpEEfcHOg6SyVbz7201prd3
	QG3in2LiVSWIaHr76Gfze/dr7MP705objJ7lGSqNkAxQOhjE8Cjt6wUS245nVqbOG77+/x6VMK2
	idNj/UlAYfpsCwqJz8wqHDqDjOZGJU47n/Muke5N8sznJuCZhCkKXSn7wA6Utszt1VHFyhxQDpV
	m66VlreG2gDoa+Uxzs2uB1QJG8T9pIkVKCwCOFl9YhixiaCKjC0KgaFkBZkRy18c1BvnN7bazv5
	EiMz3knD2CZYthrY1Ix8NBYwnYYQxbicgNFJAUnTH8tWCitZJtWbWayMEYbrweSqN9PxobdnC2M
	g9CKjr6otM2BeIUUs2kNNox44npd4VGXOCFrPALibEEvuRTqXfUaJSWfMlfRafEWge8AyxREC/x
	FZCwG09JmZbS+Iv6Y3K6W/QE7EaoP3g+HTTHFwjhoc1iysE7H6fqASAdrIaIFDVOqU55PSq1R4z
	ZJLGZ5qWlnObAjIddkNjlyKMNM+3zAFjUqWcdeb3KJKD3ELXV/n0SXrWWjNypF3UEwQ3pWBob76
	ixL6xszD+/9yIY0RM2EQ
X-Received: by 2002:a05:600c:3b1f:b0:49c:ee06:9c58 with SMTP id 5b1f17b1804b1-49cf821eff7mr190069715e9.4.1788732936168;
        Sun, 06 Sep 2026 15:15:36 -0700 (PDT)
Received: from kdev ([81.56.8.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d476esm377754835e9.1.2026.09.06.15.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 15:15:35 -0700 (PDT)
From: Fabio Cesari <fabio.cesari@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: isl29028: fix runtime PM reference leak on error paths
Date: Mon,  7 Sep 2026 00:15:17 +0200
Message-ID: <20260906221517.201877-1-fabio.cesari@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906184358.398f3f1d@jic23-huawei>
References: <20260906131203.125407-1-fabio.cesari@gmail.com> <20260906184358.398f3f1d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jonathan,

On Sun, 6 Sep 2026 18:43:58 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> Whilst perhaps not best practice as such, it is pretty
> common to just not bother checking the return of pm_runtime_put_autosuspend()
> at least partly because of that annoying -ENOSYS result if runtime pm isn't
> enabled.  That is what happens with the ACQUIRE macros for instance.
>
> Do we have any particular reason to thing it is more likely to fail i this
> case than any other?

No reason: both functions already returned that value to userspace before the
patch, and I left that unchanged only because the patch was aimed at the leak.
It makes sense to fix it as well.

v2 will take the reference with PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND() in
both functions, as Joshua Crofts suggested, so the value goes away along with
the manual put.

Thanks for the review. v2 follows shortly.

Fabio
