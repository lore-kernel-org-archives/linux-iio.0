Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822C21C84D7
	for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776378104; cv=none; b=WpBOrvBbt0OIRf2Dre6A7KKeGX2CY+H1/wkrJkfxHgWlB59g3DsKpAUuskPZkEmBKn9S8IcO/r6/MeFaM5++L1XBPDluuwQ5bAo4gff9asybM0H98AAiL/yVU3lpMdKp9CihCJ8DIQwMJ5YRLr/JZ95In7EFWqasPMmBwpVwan0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776378104; c=relaxed/simple;
	bh=whrgW5d5KlyW6bmlSZG7Qk7kFuFyfu4hmZkSYhcpyIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpWbHfo7LPhHmmXrXHkJO9F8VMEgN3BEKrOsF3JKBsY5csnZjbNIqxpUc+fK6K4TTeNSPQsLh1J+jchWkJ0+sxDv1nKjzqydlBD0mcJu8b3QOhlT7zlpH/khIK379JlgrOTwDgaaQtFmHb+bmeAKEcJXPJZjVxSzBcIy0zJoDYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBE7788d; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBE7788d"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso521915e9.1
        for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 15:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776378101; x=1776982901; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sWp5CoFLY8d29IHfqc/3dRjNfeku6+UGKmZys1drG5k=;
        b=LBE7788dRwJO4vL4uvgBcPZXW2a6UyynHcfcaE2zyNBePVN1D/t1aqoajl6zFlOl6P
         64J6VSUysHiNn0HlrwBC1lbtdsPQiMifAtwry+/M9TC38Vn5xQlG3SkCEYB34BKsIaWf
         8u3Hk4r7iCMTdnPbn66uGMKgWbVb9Y40zCC5nIx05Q6Hk9bLB1Bf3t7BvW6BCERZSJOS
         dPYxmG1trC5rdfHGobQwetvAa5Xf5URyVuueyMbNqhx3rVU9C+KFoALZLpwkFdPnaf34
         hEHsX/HO1lgLWfGcKrVNsPoeEh2AM6YYXpVvqFSguiqZ4c/8DYNbxZF+NBqomiWRBJON
         61mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776378101; x=1776982901;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWp5CoFLY8d29IHfqc/3dRjNfeku6+UGKmZys1drG5k=;
        b=JTDMT50sK8kaYrAdl5wluydzPBYK30Jp7khrX71CUnxf0Rj9ACvYHBjUzMK8U6ZKS+
         hPmQFIVAg1elL2zr86wI771VbVvTD1NzAIB/MytXiP20dabtj+DXE1d6Ds2YKu+mvxPi
         Lkb58x+WzGiMin26GQgageGbQGaW6QsjlhLAe4I+DFokWDz5enlYXuTQtXQAjHwb7J9N
         RFPp1o0uAkwNHXuEV/LJh3E08devZV0nia+FVtSSIFutDecd98Gh4m9wAN+cN3s5LFsa
         ilgPlrcyhVHxupybaaWvtc/Jfn9C3hbb8g8jo8U7eAbJJjuF/jzanfK3AD6vW9H2iLgn
         A43w==
X-Forwarded-Encrypted: i=1; AFNElJ+BWKas+K673XxEqzI72wyPpmBiVcwYX64ZXqCowYjYNus16zHewojBgkkXKikGE0nsE+cgi4u6/D0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+YPj43HLtfaAthQRfrxdv4O1PdHC2BKc0SOPO7w8akUhpkF9b
	eomBcDMA3Avf94D3VYlfTUKLrufANJpte1+4zwiEafKuV0C76BYs9jKa
X-Gm-Gg: AeBDieuo2Nka1QqJ6xsV2/YLujezEAUPmAPvoYKr+7KEVR6guqMWi/N+UsGSkBwcHth
	zJV+CIzmSc+LKF71mBIaTGisSmu8BSI/d7ALTWxAUGx+qF4nValYaNVCVdj33XgV8tFDHzlkclU
	vVHU0ZsuSULPl9jhjwuPNZoU/YtqqgDeB4uc2eE+07fTFy8sB3dvk2/MKbuv5Ki6IXuPpqCzagv
	LD2AAccgiYqzSkOPFvDqdeOR1YmCbMgtQl2XeXcgNII64SZ5EY7er0ph3gXcxVSo081jhGp9PSC
	vpGIMezVnrwsXD2w40AGa6TBAUraXRJZFjQF5Yhe1AzgLBmOyqfaxy2h5DrM0Dsv5qDQLJLUFhT
	RcyW6VBhfesfGMx+AmyjwwlMFf2qVdcn7MDI1fIkm3CinwzYULa0Rp1a/yl4G/evViC71DMJIXh
	WBa+YOj1sIzDxQz7nbO9ksWo4BO0BFVHKVttn+EQ==
X-Received: by 2002:a05:600c:4e4f:b0:488:a2ac:a34c with SMTP id 5b1f17b1804b1-488fb7433ddmr5186215e9.12.1776378100610;
        Thu, 16 Apr 2026 15:21:40 -0700 (PDT)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f584e39dsm89464335e9.9.2026.04.16.15.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 15:21:40 -0700 (PDT)
Date: Fri, 17 Apr 2026 01:21:39 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
	Brian Masney <masneyb@onstation.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/3] iio: imu: inv_mpu6050: fix unbalanced
 regulator_disable calls, when probe fails
Message-ID: <aeFg80qug_B4CWok@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
	Brian Masney <masneyb@onstation.org>, Rob Herring <robh@kernel.org>
References: <20260401082737.781018-1-andrej.skvortzov@gmail.com>
 <20260401082737.781018-4-andrej.skvortzov@gmail.com>
 <deaaa498f1036ef39e66cca3d00b54148f4d7547.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <deaaa498f1036ef39e66cca3d00b54148f4d7547.camel@gmail.com>

Hi,

On 26-04-11 14:22, Nuno Sá wrote:
> On Wed, 2026-04-01 at 11:27 +0300, Andrey Skvortsov wrote:
> > During a probe functions after all regulators are enabled, runtime pm
> > is enabled. Before probe function finishes, runtime pm triggers and
> > disables vddio regulator. When probe function fails after that,
> > inv_mpu_core_disable_regulator_action tries to disable already
> > disabled by runtime pm vddio regulator causing following backtrace:
> > 
> >   inv-mpu6050-i2c 1-0068: trigger probe fail -19
> >   WARNING: drivers/regulator/core.c:3244 at _regulator_disable+0x2ac/0x600
> >   Call trace:
> >    _regulator_disable+0x2ac/0x600 (P)
> >    regulator_disable+0xac/0x148
> >    inv_mpu_core_disable_regulator_vddio_action+0x3c/0xb0 [inv_mpu6050]
> >    devm_action_release+0x4c/0x88
> >    release_nodes+0xd8/0x178
> >    devres_release_group+0x214/0x3c8
> >    i2c_device_probe+0x6fc/0x9b0
> >   ...
> >   inv-mpu6050-i2c 1-0068: Failed to disable vddio regulator: -5
> > 
> > Fix the issue by checking runtime suspend status, when vddio regulator
> > is disabled. To handle this correctly pm_runtime active status has to
> > be set early before vddio regulator setup.
> 

> The above looks a bit hacky. We're playing with runtime status for things to work.
> Also, setting the active state makes sense logically when the device is up and
> running.
> 
Thanks for the review. Approach with setting active state just before
regulator is enabled was taken from recent commit in inv_icm4500
driver [1].

Another solution could be that pm_runtime_set_active(dev) is left,
where it's now, where pm runtime is initialized. So there is no
playing with runtime status. And just after that devm_add_action_or_reset(dev,
inv_mpu_core_disable_regulator_action, st) is called.

And if probe fails before inv_mpu_core_disable_regulator_action action
is set, than regulators will be disabled explicitly in error paths
(goto error_vddio_power_off).

Is this approach ok?

1. https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/iio/imu/inv_icm45600?id=2617595538be8a2f270ad13fccb9f56007b292d7

> Maybe we should just move enabling runtime to the end of the probe
> function?
The problem is not that pm runtime is enabled so early during a probe,
but that action to disable regulators has to be aware of changes made
to regulators by runtime pm. Action is called, when probe fails (for
example, before pm runtime is enabled) and when driver is unloaded. 
To work correctly action has to be set after pm_runtime_set_active.

> 
> Also, fixes should come first in the series in case we want to backport them.
Thanks, I'll fix that in the next version.

-- 
Best regards,
Andrey Skvortsov
