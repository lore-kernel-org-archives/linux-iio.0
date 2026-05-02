Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F59440DFB7
	for <linux-iio@vger.kernel.org>; Sat,  2 May 2026 19:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777751661; cv=none; b=GQVJ6+V7wjIyjWU1O1I1rvAvGCn7G/QnjV8WEaqIuZQ6hXV0TX30xdHxStcWW3tgOoWBlU5x9kASqXJbDduYqmGD5kxxksXHyvdwxDVjtKvYGKChCijaJRjqIYY5iqjN+5W5TNatVmGHWBYwJMlYsISmIMBEogAfgfmRnVuPQYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777751661; c=relaxed/simple;
	bh=wEOU4KBtabc99iFh0K3FMdyCelSMRV402iy0H+qB4w8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=mKKcucZacyBIAa5vYugznNN3QKG1+5urleZlzSGsrcA9/FA8IwmzwC2EC4V9E0zkg3mrdB0zgqgaedkWXI+bZzdCSuLigYHahI2xSTArvPkcAX+UfkU3fMACxmaTBBB8a35a3X5qPYzviSrNFpAa+ZUoHUknqf3LbaRvFkyempg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n0KUPh7+; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0KUPh7+"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-42fc6923f38so2466608fac.1
        for <linux-iio@vger.kernel.org>; Sat, 02 May 2026 12:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777751659; x=1778356459; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKrz1i8Pf4nacd6BnyObAlueq1k8W1nzGMqs6R8yKzk=;
        b=n0KUPh7+eQeJDdouGiMV3NvytO+QFGNHdna0abGNWfPx9vjfq8taiU7P8SQLjNlepS
         3NR73fenEwgjCSzWEaUEIwyjN9xBFA6BuqDZS8vxN+u5p3bIUrunsAUazfTTnYU0mW3X
         hTTS/0ZGALLeoQiD54GiueakGyG/eCts8gPoXruJB2rubMkLYyOgtXkCTbEr0h6JBrtb
         SJEqNmi4mdzPH92vb3AUBccmcpZE2E4wK1lxzRW8zEm2edTarUgDhD7nOX6nt9+Htwih
         BsK6adRpoUkORZulikPhdMAwZA28eI5TofPC0q1DNP2O5t1gHk8lqWWYOtq/rp4d95Yg
         FhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777751659; x=1778356459;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XKrz1i8Pf4nacd6BnyObAlueq1k8W1nzGMqs6R8yKzk=;
        b=qjkM3/8njBgU+0/KO8+mxOB5dyGybIgHlFSg7B4mQ05S+j4J9lfzBoxRkMWCS5a28O
         Y9bObo0JSXF4ELU4BT4GyMLrIwLVBOz6nUTT5OmGx10KL4OldU5l5DPcQ61don+FqtCn
         pUmApvvRuhp+HiV78w/Fiiu98fsgxKw7p/nPubbtGc5v74HUz30K+1iEjc+EYT7+lm0p
         P4L2Yck9yS5CxDj+mABYpQ/BdCX8xCET55DOwktPWtHgxMkx12YskvDwhhZ/QuEhnHpM
         UrG3lT9556o/BkkBsPvFyOAo6sNgygbqbM4LzykdZnFz+SMfONfISVp/pxl/2FTrpXen
         wcAw==
X-Forwarded-Encrypted: i=1; AFNElJ8hfph6oDvH/QRnRc0hbHl5hY0dOuIoy3qhMSrYqtF+k5uyE5zsYcDAidKvKBwS+Qvj+VN2qSxjiQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt46odBOI3bIwfTmdDPrsbZAdS19yTav/nKpGqjMOgGZP5yxJ8
	kAk2eJFLaH/YqZaZciPkMXZc5kiELmcFY4qiEQjNSgjXBnpTs/jQ96FdxydCmGuT
X-Gm-Gg: AeBDieuHz1yyNoT2+b3fP+9+eW/GqNh3AWu/Fo55yyCgB9m+6M+iCdgNGBGQt450LZV
	xU6T1Fn+K2EHZiHS1E+RlbiKcmC0BjY61jrU7UWgNWEVRK68mrP9WVQ5urwyrWv3DczN3PXeBOn
	hEeCx6fjRMse25O7DvPdsQCGIsN4NVAh+HzvgKpQUHDgIRDIISjZ0Matas0j723kAcSeOyXLrDj
	XJpX/Ou7QyMhO/CBRX89imddWLLBJXM+vs/+KpfmVbHqlSGd7Y/L+P21BvgRzasOLyN8JIETNyd
	RY01f2xVmYPsTuXmGtsIkUrFq0pX0TgCKuzdnRolkexsbicLcqgnx+HysOY5beyKP85DixJGMVF
	N8C726JbWdY9hkKJrwRRzO8sFgV8am2lUaJzT6AMxw0Wc9FVFO4nHjFkTNxRmtB/KMC0CEgo6Vg
	k8mVKSut0FhH/mzyNKhOzU+D3r6cjsVMZZ6hpLqoQvyxpnN5BaTCJjMtFeWSRD
X-Received: by 2002:a05:6871:29a:b0:42f:f3b2:e2c9 with SMTP id 586e51a60fabf-43475c751b5mr1793252fac.0.1777751659323;
        Sat, 02 May 2026 12:54:19 -0700 (PDT)
Received: from localhost (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43454dd93fcsm6233970fac.18.2026.05.02.12.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2026 12:54:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 02 May 2026 14:54:17 -0500
Message-Id: <DI8GD8RZU94B.Q3VZJO6EIP3N@gmail.com>
To: "Angus Gardner" <angusg778@gmail.com>, <linux-iio@vger.kernel.org>
Cc: <linux-staging@lists.linux.dev>, <gregkh@linuxfoundation.org>,
 <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] staging: iio: ad9834: fix probe error handling and
 comment typo
From: "Maxwell Doose" <m32285159@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260502021815.3953423-1-angusg778@gmail.com>
In-Reply-To: <20260502021815.3953423-1-angusg778@gmail.com>

Hi Angus,

On Fri May 1, 2026 at 9:18 PM CDT, Angus Gardner <angusg778@gmail.com> wrot=
e:
> Use dev_err_probe() for the master clock error path instead of open-codin=
g
> dev_err() + PTR_ERR(), consistent with the avdd regulator error path abov=
e
> it and with the equivalent driver ad9832.c.
>
> Simplify the -ENOMEM return after devm_iio_device_alloc() to a direct
> return rather than bouncing through a local variable.
>
> Fix a copy-paste typo in two comments that referred to 'AD9843' instead
> of the correct chip name 'AD9834'.
>
> Signed-off-by: Angus Gardner <angusg778@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9834.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>

Patch itself looks good but maybe rephrase subject to say "Use probe
error handling and fix comment typo" instead? "Fix" seems a bit generic
for my tastes, and we're not really fixing anything anyways.

I'm not the final authority on naming so its at the discretion of
either Andy or Jonathan, and maybe Greg. So either way,
Reviewed-by: Maxwell Doose <m32285159@gmail.com>

best regards,
maxwell
