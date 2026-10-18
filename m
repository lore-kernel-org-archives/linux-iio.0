Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09BF3DF019
	for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 06:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792304063; cv=none; b=fioqo5dE+PXC7Om7s7PFZwmtQzkSjJ/JuHMxgrFckJpFEimFX9eHs8A6i9Nf1XzDoD8Vsa+hvXaFeiFydSjeC17/lqtasp/NJ/QRZap3u04TE0P+RbI6JTf+ZJV5B9bGQ+aUlHf7NcrYkCh5igOiu9ZVgZOSalDiKRqcaSSa7DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792304063; c=relaxed/simple;
	bh=+2lEsHyBEj6ioBUM00ZaO+fos5og6KcV34JeUe9h9kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ig3QE0iuqS8qpezecVtmLsGCMt2TPXs5SRo7/ebkTEtB5MkZyhQHknvDGwNmb/xVU8IwyTlmINVQCW41m5mDgGjdlt5A1nX5Ze8It0a4yQ1QMCHrYESAu6uMcsxxkOeJRhPPuBmdoKdGwd9H67Prb6OODXyaeEO4+YVoayK+gI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qASQ5Cbe; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qASQ5Cbe"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-15354aa70e8so394055c88.1
        for <linux-iio@vger.kernel.org>; Sat, 17 Oct 2026 23:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792304060; x=1792908860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hcz1sgIE2hsxMXDV8dXqqMZVM6gJO/fdOKrjWhvUYTA=;
        b=qASQ5CbeSnYv8rF9d4E/1QQXlPU4xp4jS4DDecT7VuB5icPrBfwyAT2RXA5+FaVero
         0wAgr+O8UvVyg5AII9C4OF3aZKQYuwPLe6p1OWiwCwAdZ60/9ttMtbHuutao3USzx2PO
         EKN20kDKftlH8gO4QfgR0KfUE3KqaoISx7DPnDuSAjzAk++0PapxGeKBfiU1wtyNHnoL
         ziWdc5Us3JqWWP3+lHmq+jWYO5X3Pz7lSulv0eZrRXk0DAS4XVp2f1/8ygxDM62zqudB
         dopUT0t6Rhq7DJLEXwmz1r4oCse7VBfXh8ufJRkUc5GgSIM8afkgBM0YIdypWhYcBt8n
         81Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792304060; x=1792908860;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hcz1sgIE2hsxMXDV8dXqqMZVM6gJO/fdOKrjWhvUYTA=;
        b=BXw4jv+bLt10OgB5M6B8OTdUMwVpsoYKkHped3QrG564k8z1mq41J8iKF7JVs7JYuJ
         rMeIxk2m3VTxzZ7VsDyQZsHICsNZIqPHYEs0lbur7dAlPh8p4yu5JSapMPBbhIrK611v
         C+/esBnM5m9jv7Hp6lb2a9UjR5zipAFym/U16fFBaKmaM7CEOtdYxLCt/oZRLHTLEukb
         q6ky7/j50p5hf3Wq60jfhT3QywrkMLgXD/VD9eDSSq7+jI+P9KSog54YePJ+1w/AYeaZ
         5s3n+xAQ5B+SwSWOWRv3LLURPaU01zLAZcS4PeW2dtCDyXEcDXReFjLYv0JsV2qkEqCv
         ETVg==
X-Forwarded-Encrypted: i=1; AKwUvBw3nCMsh+SrZNqNvj6irk+F5N2UzJOVeeVNkFd91T/ysoi5JWs7HNdMgl1wvi0jBLUUYtTjLmm5LIE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqr/GcTvNSSNKkE+aqCXY/lHjaOIJ0Q3Mbzc1nU1vZPDCuFYnJ
	QmdcCphaW+o3RTB4Y3Qsqm4FoEQNjnraK853/o8G2w/ViyiARyOkXAKQKwp45g==
X-Gm-Gg: AYBFou2N2wWmrGfCAGcGxgIKH0Kc9JrynnFT27gWuXLav9IkBzG9DqIFnnJHdKBC0lO
	rpCimk/bHpTWb7zFRNYXlKz8dzqvarfx85PjAzUBhH5D08g8SNhnivtds4Q1vRQ7Bt1F2Kmrnws
	r2S1iFQtR+wvcLom0o+h+Z4l5qKy1WSPLYo/5ekYnQb4I5X9z0O4mr7gajAUhw6C+4vS7Ce9xh2
	O5ySRtWEtT18AExOFysQG/mr4+Sprx0SQ9CvIpNUqonwaviJ7p4XthbhQ58RU5YZBFT953PokNr
	PL5i7zw+JGCk+aCEO6vaj+CZwq+PGvQBhyFAAvMOhfianDMyUxHv0PohYnX+TrPM++pxVSrW2yr
	Dc9/laRPqEZFH2J2uJ/bDDRKLcDPg2p6Fnnu6W3sPfGR9pK+g0mAxTQKpgVby5DGLuLsRNY9Z50
	DG23lsU/yGjx9PW9p2bjAvKi/MG/G2k3J3/cHSq8DeiJBUt+AcPdND3OmclYc8PWxBo8at0G34o
	8atQU4kVSMvFv1gRpb9BJN02J3fxLdchXFSXQ8=
X-Received: by 2002:a05:701b:2319:b0:151:2e62:fe8d with SMTP id a92af1059eb24-1851238b627mr6194268c88.9.1792304059620;
        Sat, 17 Oct 2026 23:14:19 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:297c:6f48:9e5:4e5b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa411sm21099809c88.4.2026.10.17.23.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 23:14:18 -0700 (PDT)
Date: Sat, 17 Oct 2026 23:14:16 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: lee@kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, 
	mfd@lists.linux.dev, linux-iio@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mfd: mxs-lradc: Pass mapped IRQs to child devices
Message-ID: <atRjqcFvWVSSKKgX@google.com>
References: <20261018022400.599028-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018022400.599028-1-festevam@gmail.com>

On Sat, Oct 17, 2026 at 11:24:00PM -0300, Fabio Estevam wrote:
> The MFD resource tables store indices into the parent DT interrupts
> property. Since the MFD core is given neither an IRQ domain nor a base,
> however, it exposes those indices to child devices as though they were
> Linux IRQ numbers.
> 
> The touchscreen interrupt is at DT index 0 on both supported SoCs.
> platform_get_irq_byname() therefore rejects its child resource with:
> 
>  0 is an invalid IRQ number
> 
> On current kernels it also returns -EINVAL, preventing the touchscreen
> driver from probing.
> 
> The child drivers try to map their resource values afterwards with
> irq_of_parse_and_map(), but the touchscreen driver never reaches that
> call for index 0. More generally, translating the parent firmware's IRQ
> indices does not belong in the child drivers, where platform IRQ
> resources are expected to contain mapped Linux IRQs already.
> 
> Have the MFD parent copy each resource template and resolve its IRQ
> indices with platform_get_irq() before registering the child. The child
> drivers can then request the mapped IRQs directly. Use per-device copies
> so later instances and reprobes still start with the DT indices.
> 
> Apply the same fix to the ADC child, which uses the same IRQ mapping
> scheme.
> 
> Tested on an i.MX28 EVK. The mxs-lradc-ts driver now probes
> successfully, and its interrupt counters increase when the screen is
> touched.
> 
> Cc: stable@vger.kernel.org
> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
> Closes: https://lore.kernel.org/linux-input/CAOMZO5CgTzo6GuXptD4mFTN=UsJJqpkixDW1Q64gqZGrij8+uQ@mail.gmail.com/
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> This is a long-standing bug that I reported in 2020:
> https://lore.kernel.org/linux-input/CAOMZO5CgTzo6GuXptD4mFTN=UsJJqpkixDW1Q64gqZGrij8+uQ@mail.gmail.com/
> 
> This patch touches MFD, IIO, and Input. Since the IRQ mapping is moved
> into the MFD parent, I suggest merging it through the MFD tree, with
> acks from the IIO and Input maintainers.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input

Thanks.

-- 
Dmitry
