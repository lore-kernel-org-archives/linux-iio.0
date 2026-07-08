Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E30543E9F6
	for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2026 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783514259; cv=pass; b=PebjbgmL5XtAr+f/mpgd5QPzbFxWEtDbqNiel0ey+wuBiRQHdtv2u86BVf/CkKSW9bsK5Zo5pTX631eQeEve4D2cFSnPvtKNt3WgfwSzP0zl56iNCM2nxn3hHnTSguFvkGdVcqI/ccqZowwRzYvQybQnSD3hFHDGIHBuT+T9X0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783514259; c=relaxed/simple;
	bh=RKB8o6GjrdgfJGNQpTr30hRzT5pRDKe/NXhxMY4NO4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvA+wz3UkjnJv2L3EHevu1YsGOo1sVGhNAzi1cdfjyQr+jGxVotb1gU2sQaMocOg12eS/zDSvbTO6irJhuizwhFjSVN1Qm5u97XQivj6Y1cGQRjQuso2/wVh0i3Ljp/XCG7PdGeiw8cxtBvXqa3IMK4+bUZ/VaQVJczBTOv6PVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGJnPkz7; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGJnPkz7"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39b38198496so5395811fa.3
        for <linux-iio@vger.kernel.org>; Wed, 08 Jul 2026 05:37:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783514254; cv=none;
        d=google.com; s=arc-20260327;
        b=cEU+Ix5AcQX394fYJC77scIup/DQJeZ+pQM61eH2ygH1XKISrXgmRPcb+VYoUQ/fNw
         2ODhyMyprjn8AQ+7A6K4+OmADTIoG6gy3Q5HcX82tNfu9+66DdFDeEZFpk/fN4fa/gKh
         k0tD7CKw8Iueui/JfJLxXTS02gaBOgbWmNctlOT0Bs11+TIFgfTvfy+RXCgwrgjZf7gg
         wT5hjXgFP0rU+MOkhB7XvfiyhOst3xItcQJWANq+D49myDu43QdKuusFhFlj0tcgC4YK
         oT0kqKh6YQA/Z1M37/85W4aqcWLR0WFSWqxVHf3InVUJmq4K6OHGbFUIwAUK4ijwFHBj
         22uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RKB8o6GjrdgfJGNQpTr30hRzT5pRDKe/NXhxMY4NO4U=;
        fh=2VQiYqa2ZDiHGwXKj9J8Mn4DBeZaghiOf/cVAGsbuBE=;
        b=BfdS1l4ohSNyy8EqZXbvHsGEsOe94ttlCMRaP+Q4779xocQIOVbZrsxaF8/vdwpPZu
         cAAFvDma3kpPN8I9X/A0Db8y0yaeBtzzKUEiaIUjfTs8U+s+wGyz7THttOzjtLr+8jD/
         pODG+xz/LXJs93MzLUftq9vXGEnORdUC0LRlz5sZE9qhQSbXVEs98MHEAI6iYzss63wP
         cSprY4LuDW4XyCW4o2I7qbyfToGfKFHQFamHcEe6qrxlj6KhDMNybBhbjv21+mKEmySc
         8Pb0gLuPOwhHU3J6Rwmpd1qV0Zovwa+W6/3kg0JFNn36VPpqVEMRI8ztF7oyrwGxkG5M
         yZVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783514254; x=1784119054; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RKB8o6GjrdgfJGNQpTr30hRzT5pRDKe/NXhxMY4NO4U=;
        b=VGJnPkz7jry3sSBBc6ToDVQ4zShuMfMwOl6gfwbDZnZsRqNUlKvsLeIanUzlfwyFe/
         Pt5ol2TcUDCVjcrUZgoi6nFhT7fVJS/fJjnQZtLtjeJ8LcNVubk2rzPPnJMfppXJ/luq
         SqJxTIItrInFXthF/wqGOqAYZSdkifwXAWjR8YZaip7mbV+IbfaPrpuDQGpkeIapq9Xi
         aUayVXslJtE5+b9f5bbVXG3FFvFd6B3hQkiYNy/MwIolrXty0sRaJnmGUkbUpS9CLmkW
         BGjgTVmVzC5sHqlxl182jB/8L2NdVMcYzuExLG8ChLjfWgzrjhlOU8pEJ6t6Uccn1bQt
         sYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783514254; x=1784119054;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RKB8o6GjrdgfJGNQpTr30hRzT5pRDKe/NXhxMY4NO4U=;
        b=aETrWXoK3di5YoZLZIVA+IdO3ZzEAvdu6a7pLC/e39jYyRHQ85IdX2Uue1NMohPzZi
         O4vkHcz6ruyumfyP6DN8qAyBh3ethXoplOI1Z0Ky5NY73hmftF+L3/UL5MY3pl0FOZdJ
         UfK7gxqxZHawpB0IFZp43iII7CCU/a39uQo+f6lTzbZdEGDfpweOGjlSaKKKYil2pyqh
         GunOHQULszctsUlPGCgvuz7GGfApmRS25KJNXenKqhtgTFXcMxQbLOM5v8SqxGpFKupJ
         GuYDFrp/oLldRf56ZCNm1WvU3GmIvrFScFiLdHgLK08tkC4faQCEn/+FyhQNn++rClEo
         uKhw==
X-Forwarded-Encrypted: i=1; AHgh+RqHPGh7Y0Vd5rnuWVMuUaDq9sWK0nGHcyemwDNxBIFztnz+B9jGwCAcH6N0uYroKAad1aP6x0lyjtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoMkzTTUogLboXcG11UibRdGs92nfDJbJSpcZqOe8BCrnuxutR
	rWX7YLyVaAG6yvvcp6tMCeBD/YLcCiAhDSGwfnefgyusTVvOILBzoG5/h2tRZdr/fMBoiszkIks
	GF8/QB/TUj8rWltOKjAWrBtalOf1ngG8=
X-Gm-Gg: AfdE7cmANodZdiNEchQ/xiAibRnN2arXYxwpqt4sJgJGCJqwf+IqEMahHzrhKAxILpY
	BWdzNPvzE0rMMKOe8fZllAMx43d2CKqgNlPc6VPg0gWh9i3AqhidDBgbIaJOzyTZ39tp138M8kZ
	WaIcqyClqKjN3l8xy1+mlW4pzPBdkpn3ravFBktzryglyh4GXselRZHsXWbqVMEOEkYzd6DJk4R
	XlveT1fNpzrncvyeiCmigfvk1SndZt4eGPe7ZDJ1yjDK2TCC/44oPISpxYVAiVftrqPLEiK45eX
	ejf+/Oa75/Dfp57hjO0ICk9aPHu9VwAXs1daNHYWag==
X-Received: by 2002:a2e:bc11:0:b0:39b:2df2:901c with SMTP id
 38308e7fff4ca-39c79870073mr5222991fa.16.1783514254053; Wed, 08 Jul 2026
 05:37:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com> <CANiq72kQ0=MqAhrSSk3m5RNVrO+4Cv18xv1noTE1Y8TsPeRhDA@mail.gmail.com>
In-Reply-To: <CANiq72kQ0=MqAhrSSk3m5RNVrO+4Cv18xv1noTE1Y8TsPeRhDA@mail.gmail.com>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Wed, 8 Jul 2026 19:37:22 +0700
X-Gm-Features: AVVi8Cc2__SbyiWeUKOd2eZf6DwFxVexg1Yun7S0NV1eIyHrGLZ-6Z4DPn_Uk_s
Message-ID: <CAO26r3S=0UBOwSetC3cqqCZqwsoj=F3ff_o0_2YknG11+g_z=w@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/3] iio: position: add Rust driver for ams AS5600
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	andi.shyti@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org, 
	dakr@kernel.org, igor.korotin@linux.dev, branstj@gmail.com, 
	rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> On Tue, Jul 7, 2026 at 5:17 PM Muchamad Coirul Anwar
> <muchamadcoirulanwar@gmail.com> wrote:
> >
> > This is v4 of the Rust driver for the ams AS5600 12-bit magnetic rotary
> > position sensor. v3 hardened the IIO abstraction layer and introduced
> > kernel synchronisation primitives. This revision simplifies the driver
> > substantially based on review feedback, removes components that were
> > over-engineered for a single-bus 12-bit sensor, and validates the result
> > with comprehensive hardware testing.
>
> Please Cc rust-for-linux as well for patch series that contain Rust -- thanks!
>
> Cheers,
> Miguel

Thanks Miguel, I missed it.

Coirul
