Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975BB318EDA;
	Sun,  2 Aug 2026 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785696599; cv=none; b=FaYAn0RJSkIYSWP6G/axs19EjjUCyL7Ve4rryt9z7s7KXECDbzEHH4cNp1wJkGCdTsG0Bi9DG+29YfMKJIFhaWQ3wWHmZsjDh1GojQta3raq3Ai/2/MUPWksswXBA9oV+ULxLySu+l6xRh0E1tmy1bwrRL7YqHryfK9Mq7CVLs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785696599; c=relaxed/simple;
	bh=q6IcP2NZ8VtXOSP3++Aeq2kYceUrKzQEETXWLdg0uOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OgCUTImT/AsYeiafTgBY2QpLJ4uAn/OeIZjTn2sQxlYsxBO9xw2JQDKtVtDtKoOP/Kf6UatmZw+Z6CsdAUNxHxmVte4kja0BkoeqZHqgnKMkiYo1uvFHCVnSjhvuL6MpqqKjXfDnB7YTPtS4c+gX5TcUvgQMvxiCf9N0gFBXueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2sy5zr93; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2sy5zr93"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=xhWt6jr8JZihiGThYig/NqKAx9byV7fmohEp1wFu2gs=; b=2sy5zr932l2o3B5VaZS1t+ti/4
	0bJvautk0gtFwt9sw38nmTVx+kzGhbmCpk288NXP8iT9IN7nZs24r4d7J02K+XWCU+HHQ2IIO/847
	Yek6iihPbUe3eTz3YXCmxGyDMX+aLeuXz9JH9z+xCH4Va04nEVaAP5MJV1r0vli+O4LlfpRRMVe2t
	LrEAQ8hceDNsSeLJR2+X7GFPCKV4ry9V4/xcPYfEl1Uoumwso6AlPVR3I6J0fSMGWVq/wbuw8Z5tt
	Ueli3C0QHlxpsWZK5qgRHF0jEU88VgEN3bT46c9Lri9Z/6CSgctL2SsMM4zcUpNlx9MUCFGwe3Utx
	wjMfGtgg==;
From: Heiko Stuebner <heiko@sntech.de>
To: linux-iio@vger.kernel.org,
	Chris Morgan <macroalpha82@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: (subset) [PATCH V21 0/9] Add Invensense ICM42607
Date: Sun,  2 Aug 2026 20:49:39 +0200
Message-ID: <178569657657.1403346.3269375069451049226.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728225542.174825-1-macroalpha82@gmail.com>
References: <20260728225542.174825-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 28 Jul 2026 17:55:31 -0500, Chris Morgan wrote:
> Add support for the ICM42607 IMU. This sensor shares the same
> functionality but a different register layout with the existing
> ICM42600.
> 
> This driver should work with the ICM42607 and ICM42607P over both I2C
> and SPI, however only the ICM42607P over I2C could be tested.
> 
> [...]

Applied, thanks!

[9/9] arm64: dts: rockchip: Add icm42607p IMU for RG-DS
      commit: 264429dfe5294b76c7c3b4ed2c9e6cea1042255c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
