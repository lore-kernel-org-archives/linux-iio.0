Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34633E0244;
	Thu, 14 May 2026 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778764650; cv=none; b=DFeIKbn8Qjl+jpgGNQc6xu1aL19cK4Q0TycsIzFkY8e7wEjeCeLJUFl+kennf1cKAF1tmeCPXiqqiTWw00Ec/vam5zZpx/WDcWwDJrS7Urrz9qnn01X9mgIDABDAioojdotqLeoW2UDhatMy9eNsiSbKmwsbny/elKsTsYSjx/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778764650; c=relaxed/simple;
	bh=EkWIIli560mWz0bwtZZxmS2TApAQiMmid+nZBy603YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fl/p8OsTNN4/DAsTs2d0KRWuMJw9Ltp/e6J/Gm2wbiGJlnfHh67jg3sJIj1d7rBuy++d72V9j96BFYcND3BP4A+Lk+7UFWyaKKQQsqg3E/QUMrrmIUvBl3vDisuCWhIG1FH29G8c78NugUXxQFaJx27e9a0FZQPalsk0jo2eFTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRUV3B+7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRUV3B+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9FEC2BCB3;
	Thu, 14 May 2026 13:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778764649;
	bh=EkWIIli560mWz0bwtZZxmS2TApAQiMmid+nZBy603YE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IRUV3B+7as52K+cnLx7gV8r0u1CdwW1TjoxvlxU3NeFSHLpPUH499tebrwYkofsy1
	 783Kp4tvFwXHBbxaZFJK6Rrn8gVFZu7eHmA5QZ2L0ff0VV0NjOn+T6YKAcMw4GmwYW
	 +Btz/Fi3CerlboOh9usTPjzlVXi0yrsYGEt9gdTUEFo+VY6/IU8lPoPt6OXWYaBiTY
	 1vf22ZahgzMUNh9Pkgm6+zd32FWTgbnlM2FkJ85VC6edQAI3rD/jzq9+sEdtXkT7TC
	 Uc0gq9LaVSGUCxcCHz+VHy0MYgM7ZnMDbp7oqUGZ9LYNwQ/aucZwwSSVMP1DtH6eF6
	 wGSLJVkxXKr5A==
From: William Breathitt Gray <wbg@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	linusw@kernel.org,
	brgl@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor.dooley@microchip.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] counter: add GPIO-based quadrature encoder driver
Date: Thu, 14 May 2026 22:17:21 +0900
Message-ID: <20260514131722.236394-1-wbg@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <4mklwzoe3g24rse57hcrztmq3u7lmr3czxs6jha4ltkys57o5z@rlrxjfjbpkeh>
References: <4mklwzoe3g24rse57hcrztmq3u7lmr3czxs6jha4ltkys57o5z@rlrxjfjbpkeh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1260; i=wbg@kernel.org; h=from:subject; bh=EkWIIli560mWz0bwtZZxmS2TApAQiMmid+nZBy603YE=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFmsp72O3szxNV7SoV+w+rO2+xz9hPzfMlxtLzf29B5Lf Oqiely/o5SFQYyLQVZMkaXX/OzdB5dUNX68mL8NZg4rE8gQBi5OAZjIikMMfzgnzf+gP7Ns3eqH G6XP9XFPknM9IOXbMW/lqQrp4yzcvz0ZGfb8NJH0jd1w0uTQ0RyOF8tr6/7mKEn9O5AouT97sg+ zMDsA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Wed, May 06, 2026 at 08:50:33AM +0200, Wadim Mueller wrote:
> What i would like to know
> -------------------------
> My reading of the numbers is that on this kind of SoC a kernel side
> edge counter is the only way to get correct counts at industrial
> encoder rates without burning a whole core on a userspace listener,
> and that the proposed driver does exactly fit this role. But like i
> said, this is your subsystem and your call. So concretely:
> 
>   - if you would like me to send a v4 (with whatever changes from
>     this round you want me to fold in) i am happy to do that;
>   - if you would rather not take the driver at all, please tell me
>     so and i will drop the series. I would just like to know either
>     way, so i can stop sitting on the branch.
> 
> Thanks for taking the time to look at it.

Thank you for the throughout analysis of the different GPIO counter
approaches. Your arguments make sense so I can see the merit of having
a GPIO kernel driver to achieve this. I'm going to complete a full
review in the next day or so, after which you can submit a v4 addressing
whatever comes up, and we can hopefully get this merged in to the
Counter subsystem when it's all ready.

William Breathitt Gray
