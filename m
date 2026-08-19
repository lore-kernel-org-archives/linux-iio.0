Received: from mail.zlab.su (mail.zlab.su [109.73.193.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF98400DF9;
	Wed, 19 Aug 2026 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.193.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787126399; cv=none; b=eLtpYsKtFKF21FnB402cX6aequ4wdreTN/m/f/VjMpo6nQG4X8tT0v1ngg+2+DVtlLHpel3GM/VWi87EE8yaMFd2kmYa49JX92J5+9Hu6TnIWNoM7JxFL5nNH2uMPO83mmx74kt29EhjQtidMsTgjDOUdU1xE7AM29nSRze/H30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787126399; c=relaxed/simple;
	bh=V9qFe+jEsJnb09dRNVDkkZlzIonD8UKNe3Rg9EAkjE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWkSYi+K56CzVb0DaPnmmVNIcMpoo6URnY+CKnZfxn6Oi1cIl9y9JwacZpIoOIMbSeTUFGjuKnwatZj+jzvNCHTjiKDwWFWjXyFwaz8glGLbSLZp7rP0AbYj5REHM8QuHRSjfKeBVRHnilUC664RtWcdbMMg3fDbkiNJKQ2ceGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su; spf=pass smtp.mailfrom=zlab.su; dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b=h31gRPB6; arc=none smtp.client-ip=109.73.193.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zlab.su
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b="h31gRPB6"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 28349BFB3B;
	Wed, 19 Aug 2026 10:59:36 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zlab.su; s=dkim;
	t=1787126383; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=V9qFe+jEsJnb09dRNVDkkZlzIonD8UKNe3Rg9EAkjE0=;
	b=h31gRPB6PJ2B5wvVWz56MsBIuXcx2If/lQlji5TmC7QDi/jicwekZz9J0vlbYb5fEBwzny
	mD1wYPjbu97xYhrBJOvh5f00W4O/7TCUgY0Lh8QRSJz/58Yv3nRHGEq2w6GbHVP0eSF6BH
	G9+uJJ+LkstTdCVqe08RFlfFql18JTmBJO6XggW7vWSGPdEPNcome4BbBU/j8jrKx0zf4E
	sNYX1zkTGaxooteT7CdfMkR5JjDYClLEAJac+WW5tUBDfMODpgbYAnCEecYGJS4/Tbs0MU
	dpYRjeoYkfJxA0NUjPRlKN7QYU5+oRNP/dSiudUIaCNqkxo5XF9ChlKmonfPbQ==
From: Vladislav Leonov <vlad@zlab.su>
To: joshua.crofts1@gmail.com
Cc: andy@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	heiko@sntech.de,
	jic23@kernel.org,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	nuno.sa@analog.com,
	robh@kernel.org,
	sjg@chromium.org,
	vlad@zlab.su
Subject: Re: [PATCH] dt-bindings: iio: adc: rockchip-saradc: Fix RV1106 compatible
Date: Wed, 19 Aug 2026 10:59:21 +0300
Message-ID: <20260819075921.14356-1-vlad@zlab.su>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260819085255.00001e60@gmail.com>
References: <20260819085255.00001e60@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Joshua,

Sorry, I forgot the Suggested-by tag. Should I send a v2, or can the tag be added when applying the patch?

Regards,
Vladislav
