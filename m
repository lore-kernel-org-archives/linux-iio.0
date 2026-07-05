Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23A42F8EA2
	for <linux-iio@vger.kernel.org>; Sun,  5 Jul 2026 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783272581; cv=pass; b=U8sOvaPNYIrEds3CYquoxLzwAp4eHNCx49yMh6L8Gbx0OrfpfOpAA3aAInfLiEVzFcKw2IvRmIQOOe80Ec9ovru3BVKvfoE6H0YXoDvKKM9qf7Mcw6Zx5j6VOpZe+s67WL1JzeICx7TbwclCPMsqwIGDs5VtRZkBLWqNGJCudXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783272581; c=relaxed/simple;
	bh=/9tz9Gj7/smAtDHhEOCvlfAtZV2MqM8svnwdDenrBQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qz3Br6CAQiHN4u2wbvPMf1fC8xZgxjE0Bhn6REwspkGH/WBtVKF/wFn7Fo4QiV8V1D4BXONbRrHonHi9sb0/QdZ6n6xP3yvALCDNIqNOSC1LQZgcuRbiDq5i2ndZ9k3cVS9Qjx14RRThXVpt022Q/QI2Kn8Vr9yfxF5BL2hnnQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0r1Bfgg; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0r1Bfgg"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-475881b9a4bso1881012f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2026 10:29:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783272578; cv=none;
        d=google.com; s=arc-20260327;
        b=XI1AXVVuQ6vrFSxIep641cqPm2240AgUPKXd3PfeQJwa7M+FOCu1675FmQhgJ8mVqP
         J7IZTrDp2uWT77/jd5JP6mwL/llBk/fpmVaRgOnTz9By5ufBh060gPtaRFVfa8s4L+PC
         Ht/l1jEuNEw/txZbVfnAgtAcnf/9sxMblVbS2oEZhtCr0F0GB09v3ipJORpekswEiyzv
         XhtG0X7pKeWvxEk0tGWg6aVmwl/wqq/rO42SHMxORiQotPKZf2ButydZZgEwHLQbkd2Y
         90daIe6CAm2UynMM/E2Idi08VNheSyDC+x9mxbDMLEiYFuxoA30A3HRkyrMv9LEF5DIF
         C9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XLezQwhPY7BUrn23M2xpKTiVW4rocfdQBq+p53l6sXo=;
        fh=1ZfYup76NvM/go+Qa9WjybAirQl610ftSOECghK07Uk=;
        b=OsRQu1W11Tvb31u+hSS1DIv3hd+oMoOj38JdyKZltsVr7x+fIUVRDBcu/V6OaRP3qw
         8iklh3k+D6tpSZB/v0o0YiRZRUjZO2Yd6ABMlu9FA4FK8jMEjps2pzbQWwn/kh7W8pUw
         pRLH+fX16O1qFIOEEyEfBaAYaZgQMkhSswrwefQMx3t7XJKa5/m5mUsHeobs4NjAuxv0
         K+UZknMJFXZjm5Zp+1hpO03OTdDn3v5asqPta0Q4LJ+avdjsJiCRhwUWBhs9psn5xTfa
         U/fv8n3bDX663HmqkOBIIV6lfQPeuarkc/02tm1Mzx3SqeWcznoABPbvePuLrtneGZXq
         fduQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783272578; x=1783877378; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XLezQwhPY7BUrn23M2xpKTiVW4rocfdQBq+p53l6sXo=;
        b=O0r1BfggC+LjcZPINm4juLgMG4gG24UnXCXadJU66f93/SSMQAhmjfnEHU6GVVik4H
         BPeaqbczwHCzy/vDHnhNlCZhy9Vjh2YR/XV0w8+XC7sWNcQ8StWJVGdnHq9OmM8+NAx1
         HM3gNtyzf9Fk2mfX/dkUI+6UHoEmDjxhMkkVqsZWfX80n5WBsYJrgSMVCqSPCgXb9ItT
         v+KFivMiQkC2CFn/K0eveYXwx5POXhoOFDPzv+lj1bUV7fMdx9yO/duwAc6Y61q8NT4Y
         OP7XPB7QgLV5Xulm5Qb88iidQo8Rg7Ha32RiEQHL8gT/bS+oPJnCgf9CSgr8+/91Xd6D
         pKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783272578; x=1783877378;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XLezQwhPY7BUrn23M2xpKTiVW4rocfdQBq+p53l6sXo=;
        b=Z8xVjUnpK1knok3MESt17qzl+Sqti89MJytkTco83Evt9aZ/lclNWgyVq9+pMCUvBs
         BneesG1EAo6RJ2uHbby2tn/ozJ60aH8ALsf4yLYTkCc1YXqUoZIQk6KnAln+t/y03WEY
         iy1w5V9AsqXlHs9d9OtszLI+i1kbUK5xC/5KtW5k8xKlCsVR1zZxQKrHLGf2MLGuwD/a
         VyRITOG76VYQNPEDZ7o0ivUX0NhiYUEEhnrBQ0RhJ+UbwsDGXiYku376ooB+3lspFPTs
         tCgPjLx+KrEo/ILMiBQauKbgA6qrLE5pwFtPnTy1x5SPKyPHbhUyk1MpDeCXF+6ilT4f
         aBWw==
X-Forwarded-Encrypted: i=1; AHgh+RofrAAKbgQNRsDRR5Uk6+8GbadpeFM9ne2vYsnd8YMmhIYbVqvC0SBLw2bvz2ux55fX+vYkZkclxSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDOjR+U9fzgWooGw9HTX8WaCEL+ftnOL0J+n7RBEt3LMbDdaBC
	OGQGXTfpjP7JtThSAGUns5mbZw3JNVmHgkApHp92KquP27EVShcYF8q8GG4VGQxY8oHKaDIX3ns
	nCFJPB8hEWLqzidLUs/wVilApF3XYaPs=
X-Gm-Gg: AfdE7ck/jr4imKGSvXS7MjO5dn/dxauylo0foF3J+niMl1N7nwdkETYcEP6xqHEJ8zT
	uIxvuzBhZjz4Goo3xf7rd/7IVzESnGTsL8mu9KLTlShzpIVjvc/68660YfnY161Gb0UGfXkTteT
	dmGYDzTSsPAbDtPvSHyUzWNAcm8aMuP6ltoxFjmJQihSYtebtZRldyZZi0qZdyibvelYUwCdDvx
	rk9pOE5hKtRU0dMDTkKGqVZIBR//6ZM3QC9CYuvWo9fDgIH9vnU/dQe3Y6Au6PD595YFmUNADaS
	/fh1vf+WCoQE/rClxHDIU6rGSR99IxLkPJCJCrDunFvFDTwRkutslTjd+B4Q2UjCip0sgd5KSRi
	3vjDHS3Kesezs9Tc6AY7UpZQ0rgrNX+0RUdFa73agfc592nALjpnlhbeIQB4QiDlzuzUKxWhIag
	WB21Mk3Nn2xi/W9gQr1JOevmvt04JEZ0P+7fw8m9Xk7CTGOKL2JTXrQTfmUZhHz7E=
X-Received: by 2002:a05:6000:298d:10b0:46f:558:a43f with SMTP id
 ffacd0b85a97d-47aab57d3b9mr5698021f8f.4.1783272577955; Sun, 05 Jul 2026
 10:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com> <20260705-gen3_adc_tm-v3-2-ac62f387dbce@oss.qualcomm.com>
In-Reply-To: <20260705-gen3_adc_tm-v3-2-ac62f387dbce@oss.qualcomm.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 5 Jul 2026 19:29:26 +0200
X-Gm-Features: AVVi8CfQUxrT1-hVwlpSkwk0fu1ROQnVJWm80bpEdP3NZQ2u32dEzKUetnRoGfM
Message-ID: <CALoEA-ynWc7Dash6sprqZotp0gxy3a=t_VY5r7_00KMN6kYBDQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: adc: qcom-spmi-adc5-gen3: Remove an
 unnecessary print
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-arm-msm@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, 
	David Collins <david.collins@oss.qualcomm.com>, 
	Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Stephan Gerhold <stephan.gerhold@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Jul 2026 at 18:55, Jishnu Prakash
<jishnu.prakash@oss.qualcomm.com> wrote:
>
> devm_request_threaded_irq internally prints an error message using
> dev_err_probe in case of any errors. Remove the error print in the
> devm_request_threaded_irq failure path as it is not needed.
>
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com >

-- 
Kind regards

CJD
