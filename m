Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3477835E93B
	for <linux-iio@vger.kernel.org>; Mon,  1 Jun 2026 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300830; cv=pass; b=WdUei38XdQIstBdGxET2q1iKrtXwzPNjvWGGiIVi2jsy/68T5L7pHnzfHrLE4Pb/HAmauTMNZUdKVK8hufuxHSUhUMizFeEt6ZDgm1TzKQGN2LOiSLgvkdqdUkMj6/0off8YNGvoU3B6X6qOcle1r2L/IcD7ben+js3PmDhIs/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300830; c=relaxed/simple;
	bh=+WGimFxSBi9AwwmJKWgclnkERaomHNOiuwdezUX+TbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZgRdLtU9OLPr9JPqIKXs5u81LH5/Te3VMQB4txIKpO3fKmO6YBPeYurubUBAfO4eMtbeVq2NGHoajY1Mq9yT4K4i6+P56x1my0Ix+hau5FoNpGe5uPDH3hzbRoFNLqmHBG3Bz5YN7sDeC4tZlRVyx4/Y7siWyDVfejf2eLxmpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pSn8KRvn; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSn8KRvn"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39661ba5d7eso20103841fa.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Jun 2026 01:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780300827; cv=none;
        d=google.com; s=arc-20240605;
        b=GzLxrGUH0PJs3pb10rBXVnCWqX5VmOPI7IATmQ4nHN+buSXCSjM+DHVc5g+hVOgY/C
         PZsAksDCJy1KqgK1DOONU9f1+Zyi6de/BjDGX6dtU3cLwsbCcM8ZVbTj15c6lKZE0JpJ
         a0IUnFDI+vKyqS2o/cXAC0treOfSlwR0a4X0j3PPT6VuavIQt10OPTJIUDCJOgmDO3Y6
         q8DGjl/LX6FAY5AfjiqwTbO1O3e3SLQFYTTZcHh9A8XKp3QlFAm1C8CX+q3bBgftFMiN
         8A2mjQkRgyx6YTBZwWz4fyfyFOSeHMMFwzFL0MKgzUjSmVU9FHw4WbpUeWd5pppv0rxz
         7S3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L3qSVCHjuApLVKFSv4QmeQi5TnmD6gcVzjmpr1yaRjc=;
        fh=TUck8HYLQD3M9WBUn/LrbSlXofXqCUAwF/sB3KNoSq4=;
        b=HIKqu65KWSjun/mEz3vMuSb+Q3x+q7fi4yoN6PITHbGe5p9Q0R5HpPJzMiWgp04gzx
         GKz7J7aag70V3wQfGCGAeoq2Dq4yyO7WHyIuLoPh+v//k6blnv6KwdWwbhIlD3CIpDxM
         jOEIZwJpgsmdsVLUYR/6JPLnAWNbfFBqG0GGfgLc2lGpT3wIma2NuS4FWye6Fb7zQGCj
         OQXPWCiM323fJg28wL/QMCR3OcVQlJgage5Ui3N7iXehAGXaryIFS22+6YucibeaAJpL
         gi91QQ+ilo0Pm8Eh62WB8JdSj70b5h5NTP4I8JL05BG3nY7rOZG4aJXKno/0DcKPSPyY
         7kGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780300827; x=1780905627; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L3qSVCHjuApLVKFSv4QmeQi5TnmD6gcVzjmpr1yaRjc=;
        b=pSn8KRvnVABH0kOL2p/EzugLkoqK5HHRTy4wcvAmah08ENhKuOtPlXbqTWY7jSCSoo
         GRe34eNsuen25tsHmWUI5m5NzYRW8U5u+wv3LDsHeIafB3Snyx5wszp89c46W6Xk73G+
         F+hOM+YdocMCKDcl+0VBf07UWvbv4OlIlb9Sw79cfDDALqeRc52qbMnTU37fjnO3AY7j
         YAXm8/Au6wZq3XS/VGoo+gU9rbejYfQqnYHQrybxKggMqhg+GEpskQSToVC5BnfSugOp
         05EXx8+V9gKB5Ynkh4JmR9SUrSJjfOyvbHP3bn7VzMyGDt1bujebpr37FKa6otrFDw7q
         y/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780300827; x=1780905627;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3qSVCHjuApLVKFSv4QmeQi5TnmD6gcVzjmpr1yaRjc=;
        b=N51Er1UcINzKElhxwgqEsZNBrXAnnxxc/YyDsDLxwaUtTTkXaSVHS3rcjMtkj5GmnR
         CUD82gfR9/8h/xH0fe1LWzH1GS7S01iDMCYi+1k1Q34smJLcG0h9hLU+/fwby9bcvGkO
         zVb5fGljn1BuppfxBcL8TyKzBoLpum84VGvD21VjtXVxjB1IJFy9NzRcoM12AuTKiXlt
         ffiwvNjxbnnoOrzIkwzajG1jmLd8hxWxqiyHjz72HM6sRz6i8iqS7A1S6hR9zAFW2XrK
         nD2aGNRNCz1l/mpSULPJQz7bBfsoiobz6cF1kcWIAxfMG/PAayV2DnCM/+7/IcGzcFNP
         0whQ==
X-Gm-Message-State: AOJu0YxXUesEBflOKO+jSZA/dWNBB2bFCPfRG31xqdvOckippBICIPVW
	eNI2nk8u3jBk14S1McyceyhngAePF6V56MiWHjBRaXRU1tOmQBiRKeav+1wYtveWdx0uHyBv6Oc
	uzlo7iUkdXjF/RJ+eVBL/XU52ddrMmJmraBJeJr4=
X-Gm-Gg: Acq92OG2uGrq1UgUlZ5uzT5K6dC5lnuSSr6RCHsOqHUqT79SoRTwqHDTRGwodDvhq+a
	XQUMKmFWKqud6F7fwYfoDYGxBQ1sbT4yXxPN05hbnvZSknHY4uTXKSTVxXqMw+C2QmADUqbd5JS
	vv2GGqMkZn+WmI0Ky91rYPTmii4TrfVxVVhcK8WUsAtJvFgglRmnizcfsGut7Uv16LtAsUF8YZn
	h0v7+92wOEkAo8xNNOXxhzoaV01XjQ9L0veVMDZosCbeM9RDLGnFb+dEDeGk8zN0OpfWiZ6MxyB
	JrGd0Xc+NXGw5K2o2wJjsXYuq5I3UdA5ElMFhJ2/vYWBzgvHFrxC
X-Received: by 2002:a2e:9a11:0:b0:396:746d:a985 with SMTP id
 38308e7fff4ca-396746dadf6mr21472801fa.27.1780300827144; Mon, 01 Jun 2026
 01:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524132824.54918-1-muchamadcoirulanwar@gmail.com>
 <20260524132824.54918-5-muchamadcoirulanwar@gmail.com> <20260528170910.3b513fa7@jic23-huawei>
In-Reply-To: <20260528170910.3b513fa7@jic23-huawei>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Mon, 1 Jun 2026 15:00:14 +0700
X-Gm-Features: AVHnY4Lqs61T-L2Ft5o5bJlygKWygPckuU3Z7eLGHet-bAULTebr4WYQZ2b8W8A
Message-ID: <CAO26r3Tr+qOe_OZBz+hZ0eihVqsGuebuWfmM86PhLPd1MaW25Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/4] iio: position: as5600: add Kconfig and
 Makefile entries
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, Brandon Saint-John <branstj@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 May 2026 17:09:00 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> Combine with the driver patch.  Separate patches for build files
> provide no value.

Done. v4 will be a 3-patch series with Kconfig and Makefile included in
the driver patch.

Thanks,
Coirul
