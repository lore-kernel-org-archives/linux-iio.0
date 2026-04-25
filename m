Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0F031327A
	for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777143321; cv=none; b=hQ6LKn4GGPbrtqcTRPNtBFVUFBf8uswUQEwZlcXfmWKCMBYjHqed/qt7zIDDVfVrwfaGe7isYJr2DqDXRl0DGwfZmCt710e30hry//kBjB9tkSclAFEStpd4/NEFSuNHqZbWJbYIsIIF6ZElYB+NNAfBM167I0kix/vJaOv934M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777143321; c=relaxed/simple;
	bh=6PC5k/wB15iovttGKhDrvKcF72yoyScM3QZMtUPjQSo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R/+6Q7BMFcRiAiQ1RrtC5jL/tfZLz7Sd1grVtrA/6ox0sZQiDgfIVBMm9GIAd2K51UqsEaqloAQ6S21nhdTrkhT2St7giPNSILertLMs8m3YT0OTOzGXD6nlaNTjQLktJYgNKLB9R+I3pFdQw87Ws96PwJet2qILZ4nKNUFJxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lh457qgi; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh457qgi"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38ea6a5a0b3so87407801fa.3
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 11:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777143318; x=1777748118; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJITLO9f82dhzr/WR0Vgm9oDU311eY+/4fzqp2zrKeQ=;
        b=Lh457qgisV6ZK+UdoVSJciORTc7YuO4PV7tqpteXbXTPAbR8RYLVHGxCMIc0eJ10Os
         +y+9uGVlHU0a1ISNPlJjDVqLUmvwAIw2mpGU8K2ye4GZqjfyp5mEvbtYOtin1xcfTxT1
         K+Y94mje9MWJIGC9te8yfXD0VLYeY1kd1e0VHXlQ+kyyFGx02D6YlinWhngGifSFUAkl
         NBZx/YCoodWr+vAPmi2wnRLe53zfo+7wePxTr9tjWpWtP+cZZAvPZ2pv4CGzB1ZmnS8+
         2IZ5O/zOWWQWbXYuo8qiXU2ZZP4U7tkl7WQ7BHrvGgohuZ7YKuxZWC0bwUGBaHPT29Hp
         V0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777143318; x=1777748118;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJITLO9f82dhzr/WR0Vgm9oDU311eY+/4fzqp2zrKeQ=;
        b=kvKOezpLAs+YAhnyExAXLjyoiCIjAxT2h0/q8BmNBuoynfCupGjzVJLGV+Q8ugu9ca
         0KOVpWL8SjbMcUBaf+NNUC0GNpYShsLoJ2VT9AjQ1a8YST8IJN2ONKdJZ/EigQmuWHki
         wq/0To0ZV2I4CsocbyR8qyHhru0U60Y4w8Zq4ad6LqcgsbtkR8ir93BHQ+Bj6dqtMN3S
         PNG+aHBqQozcwYqodLqrYobGBrcrXaRaVVySxceqrey8zZwa7jcBLHh4d6DRQRRXo0xp
         JHbyVhLWswMS8TYRW8insVloarkGc0tuWFPuYPvliv3UTgyXq57sWw21SphYib7cF7Ft
         M/PQ==
X-Forwarded-Encrypted: i=1; AFNElJ/TmFmkCXKwp71p885vH3bFb+J70RdTlP4VlJSLRijGH3iATjOmgp75kngdPCWwqk+pBQ4VqTChZAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlYrFTT74RLnhLXa3r6GlQ+VQTevC971BTorJJxmb2uHM/DWRC
	LrxTHRTUviI61qK5vLky31tUpMEXlkkQ4bU2LcIRoD/fjCTXY0HiDpE=
X-Gm-Gg: AeBDies7G2L7Oj4Zo9rGuviMcCmbAOk9yVxfbS4j1PAFKMnaVG/pGWArgk9RnfhL/xd
	eX/PBTzMmZt4fUWsMkAC+LJ4wxu/vcvStbaNJhqdLQRFsVtssFWML0qE+v4SpRnPqnRYMZ1WAfC
	Br27w4duJFdR1z0hhQY1KQ96AlJsEaURaGnoy6cbB0FdHugK9Qil1smbLLLI69VMXJ0n+Yz/W87
	RTWAW67OEgsi7HRqgcRwrai+Q6Bwmk3cTbXU/NcDnH7EnyVZQTmUjbab4Ukwu9u1FHKpDNhmQAP
	+4kmj/XVmq2nJJsLMh+ZgPm/c8OSpQX8emM+s+jBnCpkI+6lT+rGGETRXjwsey1CdrGCPaGyDgC
	ExHeP7UmgnMhXcv+2Ei+JDidpyxV0ui6wUDJczToAoDhE0dxEOjVgNbxrVTm7sKaNIZRM4612LL
	Ok9hPuLt6lsnLXPyNQFMnR1I2huXFD8Vty0Q==
X-Received: by 2002:a2e:be1d:0:b0:38e:49e6:a376 with SMTP id 38308e7fff4ca-38ec7acfa4dmr137809241fa.22.1777143317812;
        Sat, 25 Apr 2026 11:55:17 -0700 (PDT)
Received: from p183 ([178.172.147.163])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb4f54ffsm57552711fa.1.2026.04.25.11.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 11:55:17 -0700 (PDT)
Date: Sat, 25 Apr 2026 21:57:29 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 02/11] lib: kstrtox: add kstrtoudec64() and
 kstrtodec64()
Message-ID: <4b7b42fb-e3db-4218-9deb-ad609e07bfb0@p183>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Rodrigo Alencar wrote:

> kstrtoudec64
> kstrtodec64

The only comment I have is to maybe sneak in "fixed point" into names
somehow. Or change to kstrtou64_scaled() because return type is not real
fixed point type.

	A.lexey
