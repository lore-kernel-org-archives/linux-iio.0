Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793930775;
	b=KKFf2xT2+P+zYI5afutskWCT3fGMmNIzio7xKflvtuMmPGtUhTVyfpkQMDEFXTHuu3mJ
	 6o8m9HiSG0WOC+svGuY2L2eJYl6py7PDJA9y6ZhEYJGhZrP9Lch1+bA+qtvZzO/vCNpdD
	 5nTq8fBRgSSdVEuSlGbcqIG7INhmEjLd6yvd/6t5O/604+0UlLpmoWF5/wRFy6z6988Q1
	 em7khgJMryHCqHudGRiM9SWAM+bz5kD/WyHgL1U4Zlu1TutmnpNaPaBM6pCMOJ6jfyQu+
	 eoQMaCMl3E2+RoUIAcO1xrQ74mElIdjqkLBDPU1mDao0jnKq9oESwyKETars7e3Tzyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930775;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4TaPSXfXvaklMpD3qt0rBIRAk38gDmhfsHAWYscetjI=;
	b=yp85Z+e5qOKBy8Kktum+eVsY9X4jDG443SC8WNOoff1Yowkmq5ixaJapCbuVqMZq2ezu
	 IsSApr5NmvrdFeS/Zxc0T2uu76kDuCrBPu5mZwEJlKvIfME7HZxuQIKAjMAO0fhTNsFHs
	 hCyttOReeelScjLCLTRhyTbWkXFSlJafdhnRgpf8LDgg55M5UBiSO3mqwxhxTn9zJu2Mg
	 V6dao2xPHcKROhJmCxGBg+yZgQLFbjzDv/1U+6VC9+ZfVx6ZpcKsPMxzhNFEEv8+LLoDW
	 +hBfQEEz5KUtiPlvf0Gh/LHvr2OL3TRZMyMY/5WRXxS3SXziLUjVPQok9zV4VbdEjfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=tLnse5+0;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CB2606A32F;
	Fri,  6 Nov 2026 02:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89CB2606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=tLnse5+0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=tLnse5+0HSDKAZJXWbEy3seuGrFfEemljUCm6ZUwCItcDtvQ6srn7z5Nq2ceTTaf3qEiU1mDRDLIy
	 gFUL2eJ6UlLEaRC1dJMVl6MPI2bKoenNiAy3r5hipCahG81WkY/zEY1hlvTweVzUIJLW/qyaWKb07D
	 7rG2yQXDX1EIt38Q=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66aed3613e5e-776e3;
	Fri, 06 Nov 2026 10:06:11 +0800 (CST)
X-RM-TRANSID:2ee66aed3613e5e-776e3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76aed361140e-0d52b;
	Fri, 06 Nov 2026 10:06:11 +0800 (CST)
X-RM-TRANSID:2ee76aed361140e-0d52b
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: crofts@kernel.org,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Subject: Re: [PATCH v4 1/2] iio: gyro: mpu3050: Split data ready trigger enable/disable into helpers
Date: Fri,  6 Nov 2026 10:06:08 +0800
Message-ID: <20261106020608.993-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261105163118.00001538@kernel.org>
References: <20261105163118.00001538@kernel.org>
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

Hi Joshua,

Thanks for the review!

I have switched my default diff algorithm to histogram now.

Best regards,
Xiangwu Lai


