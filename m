Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B943148C9;
	Sun,  6 Sep 2026 01:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788658910; cv=none; b=gk386A+nDRddonAKk8J7bjxA3pHozofnFVD3siOFS57Dwjq8kMEl921Irlub7sDhrYLk1vQGX1Yp2PZI4mAWrjSAviApb6rSQ9SMpicQZFyoWJ9WhniBBEbr3AAPQFufe/TRwxUwLSkavz1hhijymwY8TiImD9gyhLmIWsev5Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788658910; c=relaxed/simple;
	bh=3Y2eo6qe0NfLcF4I1jmPZLtotXwyvZbE727MyZrzsG4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=iAXhNoUEL5aJ0Cw4UhnMkJhy7sRgVHJsFBlFQFXpSG6qKPoXwSQw2eLAK9Z99Y6jnIx65k9AxkLMwl3BWs8p9EJAhj/iUdMtHW+Riw3kcsXMzx2WhKwtb2GVIgQh8dufu7UNl5bfUhU6iEMGrU2bBZdB9NxEbME2VkuyucgWUd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ix1KG0Eh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ix1KG0Eh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506DD1F00A3A;
	Sun,  6 Sep 2026 01:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788658909;
	bh=mpS/56QEZvMq2ji6nYZkCHsVv69jKP78ix/tSrqK1YY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Ix1KG0EhOhzISoGMUeRuMz2F2TB1Iooq/iesSNjQLQawMqXm1LCNhO9RUBYovX/1N
	 pt2BFWHDNgQIMVmwJd/dtfhcqpfEemynZ7fCdXaYJrjhlO2lm8dJRhkDUHPb93cmCa
	 CWavv6rWF1KqlhOqEwPKYjD6Wqzxd4bocP1d1HrgkMsLroe/Al4s5WnMkQj83+rOjq
	 OI6+9U+q7h1XBFZmLEGnQZ5FQ7/FDOhiBuSY/FyvLtfjbdvsjS+zfU7lrEwpLNW/nP
	 ZMNTSwIfAHAFd49AgsVqTnoKpG9JOLiEGXoQyFoqaVMMYo5XpmHGQ3ijhyvU9Aishp
	 02TGGsgtljF1A==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 06/10] iio: adc: ti-ads112c14: support external
 clock
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Chris Hall <c-hall@ti.com>, 
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260904-iio-adc-ti-ads112c14-filter-support-v2-6-f86592360658@baylibre.com>
References: <20260904-iio-adc-ti-ads112c14-filter-support-v2-0-f86592360658@baylibre.com>
 <20260904-iio-adc-ti-ads112c14-filter-support-v2-6-f86592360658@baylibre.com>
Date: Sun, 06 Sep 2026 02:41:33 +0100
Message-Id: <178865889326.3402141.1657980938012986075.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=3Y2eo6qe0NfLcF4I1jmPZLtotXwyvZbE727MyZrzsG4=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnMTQV1x64Q3U4Ek85/Ttu7Pw6bs7X6cT+EeED
 P+FR0pfj6uJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapzE0BEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiCJbD/97NeCvR6tuHKoByGhEkQK3SPHHzle0CBZsDxp5wxIEYj5
 QH5q+98lZb2Rfr7UiKsXLL4pTO+/Y58dYfL/Wl07aoGn/Cp6fuAOshS/ZIVUqAgwbpN+NK/XfJ5
 oO75V6Y+pfb/koRuPY+4cNK+5LwHvac5y6Qw2qgY/S6sPNvkkJzQAcGLPo+WR9Oz3fPTRMeAcjs
 4aML/eRZllFuIQkfg7pUf7iyz01n+kCgiT4TNLYR1ZyahreKjsLnXAKe47EpLOnWATwTexNhcCx
 +6cFURZ9rg5Ys6L4ZHaoQ4xF1ipjsacCrOw/e3kM8M4X9b9lzJEC1op7mdUQ/gExwyXdKQjN7m1
 J6O8u5qMkvxs62U8y5FejKRkgt+koEjNGdXW33Tz+t+sBUbgiQWa0QPfS1KL2pLCb/DuEUH8HwG
 SyuxDFs9t6gPKHKzbPkSgommgKI16/L+Hfieo0IPlHqi1bhYH9K9Wa+WCCxJ2+0zN/ZxeGnOJ0e
 8sIe7ne8yxBlEFO0KMXT1YlUQY77nMiHbQyApwGUpt1ZMfOcPzEvUzu59Eiy5K19sySO46vcnGP
 uE3wpjCaGymzBEiOa4ivZurkcezbQOUhMgw0O+Zyq+B+/A+rKAoGYURzmqcSDl6NaUjRqUVHGCU
 w3rkh/vFZsqWE0WBl4EYASl9eRP4cBhpHL2LPjw==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add support for an external clock source to the TI ADS112C14 ADC driver.
> The unused fclk_Hz field is added in preparation for filter support.
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
One minor thing inline.

>
> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
> index c03789c3d95e..55462fc57752 100644
> --- a/drivers/iio/adc/ti-ads112c14.c
> +++ b/drivers/iio/adc/ti-ads112c14.c



> @@ -1737,6 +1752,20 @@ static int ads112c14_probe(struct i2c_client *client)
>  			return ret;
>  	}
>  
> +	if (clk) {
> +		ret = regmap_update_bits(data->regmap, ADS112C14_REG_GPIO_CFG,
> +					 ADS112C14_GPIO_CFG_GPIO3_CFG,
> +					 FIELD_PREP(ADS112C14_GPIO_CFG_GPIO3_CFG,
> +						    ADS112C14_GPIO_CFG_GPIO_CFG_INPUT));
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_set_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
> +				      ADS112C14_DEVICE_CFG_CLK_SEL);

Given it is a pick between two things I'd rather see a FIELD_PREP()
for this one and a field value name that tells us what is being
picked.  That means adding defines for values 0 and 1.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
