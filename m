Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04523876C7
	for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 20:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602122; cv=none; b=QJZbY4NCP6BJYRmfy9ZMCfqWWCVlodT7HdHG/vYgcb4mld0ldDVCFNWoDKEIQpTzjRx6mY05NnmbWg0KJeUuu/3xGnorO25UNMAjRKA5gCgGY23Dq45xHwPgTFjUPggEWpKxIJ/bptXqjntuX6WQT9nhbAIt9UtDg0zuF2lt4Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602122; c=relaxed/simple;
	bh=UuAPn/EF7lY+IE9eu/1z2yhVlzvOtSClEOJcTV1dF0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtsOyrhhGNYhr1nfS9ton0DTlTMlJHO7idVBQC8cPx52bUn3YXxrF34JBtYDHSFZVxGPBMVyc31QzEsM+4Uoj+2zUAmby8eo/MLPopwCrujElz+nqd29PXQMWeMDPI8XkOqSzVVKK/fFdnfQ8Ogh/3rP2/xnybxIy1pE41Dvmcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=owa6Z3nk; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owa6Z3nk"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b48ced973dso3148701e87.1
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 13:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787602119; x=1788206919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UuAPn/EF7lY+IE9eu/1z2yhVlzvOtSClEOJcTV1dF0E=;
        b=owa6Z3nkvaInepfqY8fFyO1u2z4Q2N8wV5wwUp2zZe0QrN4JhXi1p2p8yBSrmOupWS
         7XrbpEhJPeQt5MsOj3y/dCaANNk3SZIfxlZXgGwnBdYFVWpbNH5ViR4j1ClKTxGtcy5s
         n4PceiEXVIyhx8itUdVBZhMqvITm+7aJr4gTBN0cop+Ey1Hg1Pcc/GWjbHCk+LRmubZC
         gGvuOfN2GFaASakUDYcgd0OZLdVKkBT4ARsd/+bIZLq3FxKx6TJaqyIwkQMzL/4M6oQk
         T7tazEpB5mqlU77S8giEM5mKXlrTYP29c5/GetT2mB3lopUvTGw1dzZRn1eOzC0i5P7f
         EZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787602119; x=1788206919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UuAPn/EF7lY+IE9eu/1z2yhVlzvOtSClEOJcTV1dF0E=;
        b=pxheXnLpHAORtyGpnv4wB7JwJ9FQBHLTKStPWBEtmW4x5geatUm6Bdxl6U3d2CG79N
         htKZ5rG04yJIMvDlgdbAjf5hF4wGtuPf7qIxFLybYbPo41qPdRNKIT4gGGSYUqbvb/w5
         Yhp4WCgnj9gWeJMW5T4SBoHz++KryCStEFWsC5na3AOZNlDAiElXzVj8/xHlt/Qx2h/D
         L2f3KmSxZTwn5L+R4NWuADfopuRoN4/O+klt6Kb44U0b2RDg6Y9+p4a6hqo3+iX5djYp
         FlBDMPC0R/kCLYHo5qi85fCRn4yG8WkTYz0A7HQ1Z5B3eA+hb58SNLCpAQ5onvsV4qUa
         Y8zQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp1K6SlGKk1nA2761Abg4yKbosDYGeJG6F3tLnao20qhCFWzOo/Qpsj+KQRO8Y4YhvXUvShquQhmCg=@vger.kernel.org
X-Gm-Message-State: AFuF++m5oM1vUGtn4l3haDyNRjUif9yowa2ObGmQHz3tbAPhb+/1C7YT
	TxApzzOFjMTpRPjNP8i8Ya++OIO7XoYhMN3ehtIsSo25d1ppBufIHQGz
X-Gm-Gg: AR+sD126z1OsJQtOrNrBNRY/85h7xdQz0ubsrj+kWJywZKu08AeFmXDFmCyQqCdJ9G3
	g5WFK9ByCdmcuhUMjTPfLn4b8BfKpVgIVdAxc5OR4haf9Ifv67tubC/f+Dwv2L8F/u1OVHTctjO
	9+pz9T4CnB8TdlSQdWnjTIhyPbhbJDHLwCPbNuv61qbgCe9uT9C2jFAB09I/mYC6d2fERKQsOYe
	KcFCSKzVVbnTaFzkKzr3ebSj8zXkm6OUtJ8fTOmIIDKU07VeSvBg0PD9DStmGytd3Vp0/0OQMxB
	lYuxWE5mCuYAOoTywOKWdlWYyJdBzN87PWaZuxGapOMcTN30FpeYQOVm46tc3JpMa62D30OvvzD
	ms3OnsMpqRgOx7Ed9Yn0OHdSl0mHHMY76jBeHlTIvScMhqqXG56rKxYBx9CDKG8PA4VBiIYNS+L
	g4YWBw9bfh+JcjSq4K4MK8BxC4q8fHFBMOQAbfKHh936rvr6Plwmjg1uVjmiv1wEqUNdDolbA4s
	/iajjjp84dVS5F4qbN+aq2ZH4IVV0oEry6ysqYFdXfXcLwn8tmDnPIsUyBWgQuPYfX7Cw==
X-Received: by 2002:a05:6512:3e28:b0:5b2:1de0:5ea2 with SMTP id 2adb3069b0e04-5b48424ba49mr7818366e87.16.1787602118682;
        Mon, 24 Aug 2026 13:08:38 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b48ce0dd0asm1964515e87.77.2026.08.24.13.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:08:38 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: jic23@kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: pressure: dps310: add hardware FIFO support
Date: Mon, 24 Aug 2026 23:08:34 +0300
Message-ID: <20260824200834.395586-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823003328.37645f05@jic23-huawei>
References: <20260817170725.1074078-4-zoone.rupert@gmail.com> <20260823003328.37645f05@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 23 Aug 2026 00:33:28 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> Not immediately obvious to me why clamp() doesn't work.

It does, neither needed the _t.

> Given this is a 16 byte buffer the possible timestamp position is fixed
> however many channels are enabled. So you can use a structure

scan_timestamp_offset is 8 either way, so my comment saying the layout
could not be described with a structure was wrong. Both memcpys are
gone.

Rupesh
