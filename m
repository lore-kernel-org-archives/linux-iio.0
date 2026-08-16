Received: from mail.zlab.su (mail.zlab.su [109.73.193.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63411346A14;
	Sun, 16 Aug 2026 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.193.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786880763; cv=none; b=hSpfzfuJLhDsngo7P97AleoS9WJO5ltf+YKgt+UwOafXUA8/TpkRZ5ZQJmntH0VorTRq5jeFDdgTRea2jiA22ZadVqVTscY2WYlzn1a0JgYEHWINLbIxGKarBfOq5P8Znga9XVMC6s7sLBwcSF+kFkllc+ca0p8CjSIqkDxh7YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786880763; c=relaxed/simple;
	bh=R0koM9OrhIxJRN0+VCg0TT33XqoV0ZT9GF1MElgCdq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOwwwxuKwoTWZij6QAM9LBYM0nXsPNnDb+p7MVNfK/CEFaTsGNKo97TVXNTIkJQjqX4wNhTeMjWhLdBsNNO8apQ6ViB7IkxEQrRXN//CjMZpHx7iiQj3L45NyvMbCkYGRbgq7NvJr8YwWQ5nOf34BCquxnkgarkDSwbHjyNkix4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su; spf=pass smtp.mailfrom=zlab.su; dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b=WGjL7sgl; arc=none smtp.client-ip=109.73.193.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zlab.su
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b="WGjL7sgl"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2CDF5BF955;
	Sun, 16 Aug 2026 14:45:44 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zlab.su; s=dkim;
	t=1786880757; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=jc96mxmG5lKaawG+ldy1b/MyHnPfRmSyj6w7fW+V8nE=;
	b=WGjL7sglgmjOlqBkToICXDxrXVgFe2epa5glSZBr561V5iYakoM4E5RDIzAGzqPXmDqHXT
	cs9ap10YICUaiQUVVtrNGlXxFoMd606h/RLNvaz92K4AQVJYykUA2FKCzi5v2oG14C0mhE
	Il2SZp2Iv8cwyF+OMPND3rn6YETClrPjYVAjG2d6ynFv1XBhaQNQMPjjhR2F9Hsb2uc3s8
	Q6I09PRlKwcMgmjNiIs5eS8WXp37I/YvvYluRogeaMu9aY5qfP5yrKqX7BMh/MhnBoMRsR
	GdLM5qFRFFqUXz2YCcyHQrkJgKJqm/JqdPnLDCQKsaY/pLfSooqWP0L9yvMtZQ==
From: Vladislav Leonov <vlad@zlab.su>
To: jic23@kernel.org
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	nuno.sa@analog.com,
	sjg@chromium.org,
	vlad@zlab.su
Subject: Re: [PATCH] iio: adc: rockchip_saradc: Add support for RV1106
Date: Sun, 16 Aug 2026 14:45:44 +0300
Message-ID: <20260816114544.35502-1-vlad@zlab.su>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260815022036.7c47585e@jic23-huawei>
References: <20260815022036.7c47585e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jonathan,

Sent a separate patch for the dt-binding fix:

  https://lore.kernel.org/all/20260816113636.33635-1-vlad@zlab.su

Regards,
Vladislav
