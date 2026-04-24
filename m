Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581A93ECBE5
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777054539; cv=pass; b=MizEKV8dXeXNuzeoYa+k6MhJNpdR2890Dc4eC2HUzrrmBm9kIT5Kgz2D783nSALOG0ViDLImJVRJ+xw+uepYEYrp5+6VHQHWEVL5v/6CBXQd0/R3vK7M16XAd9dyijLZvSKe5iyDv4YcdL6AWV2Ocptt6aTl0ROO5D+uwCzncAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777054539; c=relaxed/simple;
	bh=ZvQRjTG6JND3vgld2jR4Fid93d2WEEFV0t4hXpZjLdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnZNI68qbqxrJuYnSuBWQInHfs40mBI5gT3hqCRht++nDlV4zGVjuc9wVY30rBxalhZDk3orzUfY+/ejXgkmSCcGUSmwGHZXByYBfItDQMF4AfC7mvMhTHL6pOyky9p+As/S2TD9QP1sWwq08Hsy5GT//mzrjZpG769S5siUdPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRuGxYMd; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRuGxYMd"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d7650202fso6254823f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 11:15:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777054537; cv=none;
        d=google.com; s=arc-20240605;
        b=iVY0ToFYlkOCNnudyc8pvS6zCxco4L1+bHuoaUR7NAZeRmTlQ/ZKVF1qj1HsXm84Gt
         KQv/83BGM6eiduTdLjkUq4aqKhopePV6pGdsvI61Y1Vu9KiQbxrmVmcfg6Rr04SoPoS5
         aMDyLfKxe9AVDvizj67AL9vk49KZpRptMOAyizOJLWAV21CZWbI68ezT580j77z3EsAZ
         1VUVVZiRHhckSMUL05hpz0gPvxMe46i+vzN7i9FIZsheSRV/837mk8nAXHPvU7Z8R21M
         Pp9ZGl/bHyjxSY2N2PNCiqL+qZtXFOBsoOvColR+qER+i3WiASpZ5/8TfJSjehNWJHui
         60og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vir2L0aYU007tub3aDfdviHXSVXVLAcBaqmmPykOnvw=;
        fh=DjU6lGILslyiyt3Xfjhq77RN8Y9tyrlycBS2OiiLruA=;
        b=bTtvVScuiKIPIMBdjn6Al+NTlidCvZL1PDGKmxesgKpSJBiobuYIkXRFlCYRSUY6Fv
         KmkyzJrYXqHJ/ukLwMcR7P1VwQUdu3m5Vn5URi2Cfwk1MeYu/KwU58T6VLpqizkmHuCN
         E541R1sD50VxN51SEika4pAvMmwch+ZN/dw1Mntw2lWZnmXtNhwjrnstBfNHyFrG9uk9
         Z4GutMVQ0dR/F0t+P9oB8aE2MnA38dYvZpUpZV/VVohKgkKPQI/p+UcHagPGKokeWuzC
         AfxmS/ATef3h58Bwo83Xkw7CHpwkW7pfAHaQ608fkabpaaqP7/py+U2QjHSifYDj+X+y
         lHpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777054537; x=1777659337; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vir2L0aYU007tub3aDfdviHXSVXVLAcBaqmmPykOnvw=;
        b=BRuGxYMdNdupiUuFmc2PGLLSoP7MFyiY4amtJej8dfXVxGbH9Eit1V5DzcHo5bXs6I
         LWzPLf5ZwMeNOzYJBmCsXxYZ5WyPyKyX5xSJ+8ABEv9/pDARwoqcDHl1d75hUq5YsL8U
         I6rffT8cR8v/HorQle6u5OhkgeKgZAN6UQVMpmeaSdz0lG3tLE3tLAExyc4ZeEBwjCFp
         06y/TUJFbBcvsCDhqBvZyR3e9pCKJN0zVqMhhKBF1QXPjC/LWXVP1WDoP3lJtq5zIwDa
         NErHMNH/JATesoFEEmRbfHYITf7uc6ALiD7RZyzn43VaagC2jNL1MyRzqGLWaS43aXP0
         B/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777054537; x=1777659337;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vir2L0aYU007tub3aDfdviHXSVXVLAcBaqmmPykOnvw=;
        b=Yl7v/UvoUVNqPOVUpbEzns8V6JIRj1P8m+P9JuoR4ZqagtPxM7Y/Jl1t3v1wuseYGt
         S+FjG83hnPouefyAt5i9qjkIfUou5taoGr15rF34ZPYF7MvyqbG18FM7C6dACnnZACgv
         WVDmEhWlyaMUtxD2gJ5EsMXRdcB5aZVU5ajMzco51xgUGg5840r9wvwzH+3dZ3WtreDI
         +8C788DYJy5NXeacdgEmakAf//qKiQrFrCu84OBF4h8xlekaiuJTDV9ErLVAmcbV+4MA
         B+/YlfCsU0idIvmMuiR6fvVm4EVKYnHYKZdJ/NDnHFrMTcOKg1AORfCR6Ph0HKY4lRg/
         qq+Q==
X-Forwarded-Encrypted: i=1; AFNElJ9gc9TVbD0fE8G8SK+uEnFp793J3xkeugjgIyPgyZoP6KaenXbflmxWYoF+adIpF4MWzXAA2zIHf5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5iFsBDRaznRKZbstr23JKTuaRp7TtTuVPvKiCu90PzkLBjYFs
	PogB5T0C+xjP8Hf+2/E355jbcTfulme6Oan4zxO46fyjzhDXCw2v0xvEnTz6QAth+CF8eyBv8U9
	OhHYujS81YqwV+rixgmSgzCds+931OcI=
X-Gm-Gg: AeBDiese/J2xNaypwShacOTBOctgqyJw9IhYV5dJ+d35RV1h1i+NwNFcHERMau2PwRP
	YhfZZ8nhKV38uORlUhbM42oGPF90B3NweYXceJ14d8nrX1Me41srxC2LdURW1bspdGB0hP5T3vL
	pxBJtwLfvxuEFseODFOPGv47DhqL66uJG5CfmR1WwO2sqmZO4xMJVBOridJ2huvW5f6SxYGKMSy
	9do1eRCcj+h4pMaLqMDM5UBqMSzBxSbwzhoDbv7nFyMAQcY61qy4QRXVzx+u/YzwnoXwaCIUI3V
	PkpglMfdH6q8+dGDT9m4L30FIoVeqEFf0lwlpLtXGzByoFzyORYvNd2lPeRGqKmhxKjOEhcUQrK
	8/7NNKXOEErpWyN62bTgYycYvM98r7dnVpnJYI1Idj9lRTevDvcV1binzlb+IsIlZ9OxHxKB97Y
	Nm3hFGeM/1x3XTrRAVLAQfl9c2XrGY6lchZ3OQbbOxE5NRX0VYPw==
X-Received: by 2002:a05:6000:25c4:b0:43d:69ff:6898 with SMTP id
 ffacd0b85a97d-43fe3dc54c7mr50610519f8f.9.1777054536589; Fri, 24 Apr 2026
 11:15:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422112207.1313-1-joshua.crofts1@gmail.com>
 <aejKKKD4JdxIzlk0@ashevche-desk.local> <CALoEA-w=N7ch67R+DgdqCrSy+5GtbuGkiAbJtnf-9c=Q2Mb6CQ@mail.gmail.com>
 <aetDc7Cvb-_qkf3s@ashevche-desk.local> <CALoEA-zCU_Em4U0F+Kf64g9yvQupLM5fXtQo_OxnPftcDwSwgw@mail.gmail.com>
 <20260424190249.62c4bafd@jic23-huawei>
In-Reply-To: <20260424190249.62c4bafd@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 24 Apr 2026 20:15:24 +0200
X-Gm-Features: AQROBzCZzxcbAt3ReKscDzWYk6EKLFPn5ItUi4me8NOeDsuud4XKfD9jpGPNUSs
Message-ID: <CALoEA-zLHVF_yT2n8iBnhZ+NXhOROHGSWO6n6hU6n4+WNRrBNA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] iio: magnetometer: ak8975: modernize and cleanup driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Apr 2026 at 20:02, Jonathan Cameron <jic23@kernel.org> wrote:
> FWIW I took a look through and have nothing to add. Looking forward to v4.
> How Andy manage to catch up with is backlog is beyond me :)

Sure is impressive judging by the amount of patches that come in daily :)

-- 
Kind regards

CJD
