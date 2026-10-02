Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1064DEC19
	for <linux-iio@vger.kernel.org>; Fri,  2 Oct 2026 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961822; cv=pass; b=DDyqdbCnfFCdvz7lvmTZuLvPKEcy6cmdu6zRgKllzhdpPqi1v0fOsZKRvF7BKeswOW1IcAFIy48VjADnsTnVQpMNSE7bAsboYM9pzylTcuRfgzsJ14oPbdl7y+uaywyAsqAd/9ghXGq25RcCnzdrh2oYYd3Btf/UTDuZZ3Tyk7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961822; c=relaxed/simple;
	bh=VqsakkF+fiyAxZb4saBmZgbMsuByqSA1isMXBNXFd3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Adp3lzNrq0ZwxT4u43H/rx+KnAipV6JRDOgTG8gHNGH//DuCt82g7Gtpf/WOvLyshlGIopn3qLPEWMEnUQRdsSpN2Qswz45Sp2gxpnb8XgWYl+rVOCDqr74qi0vqdHD4vhLlmJQWNX/kSyRIDZcrJAHSCFUzkJn17RvN4bZq6Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8gLYag4; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8gLYag4"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6cfb1329979so15105eaf.1
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 10:23:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790961815; cv=none;
        d=google.com; s=arc-20260327;
        b=RldTHof495iIddeagFFoV0rO8e6VJa5sOiKk/YQn6B4YTerOdS+ucjmWxX3b0NgwkG
         AZxzrMhYEnZ9Vz2A6TDqH+uytyFNHfo1H1iplndyYveCKeLjH8GLsBxEfyMLEKJeN+7T
         dXkWQXhk7+4X8LITr1g0+TY1BxF0eLlYloeoM3kNbt3gtDiDg18rrasR2SxLJEJO3Sbo
         EEUuLxAlAjZNQqcMPSuIO7SL4oLTexz6ieSzBh/cadeFzAw8s+6r9H4JTs0m13b4KuPE
         ruXa459LEHUGPwMrl7PykbtNSBfFXkSzmAgTVgm2WFVQIPLXJ10ETG7wQp/V5NOETJfy
         ihrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VqsakkF+fiyAxZb4saBmZgbMsuByqSA1isMXBNXFd3A=;
        fh=g3Hna1eIisqQHjG6tU6Bx9z2dD/qh7u8sGIfyldZHco=;
        b=ILodOpq4oVUqJS5kTEXrT5HVyNFOgWXNLlzaLiveptOdpeqe2JQmjDqle23QQf4BYV
         g94Pe4F74pWzzFuRH5zStdJN0EqAWGCJ9ZBeRLWKyMFzNXbksF5s4i4XFQRoFbfDDPFE
         72SgvDPCmEeNX8JMCeVU0Eufyowj9W2vDQRHXqfT8N41e+O3TLXhPxipu8tEv/Woduku
         +v8He1lXnYtdbQ5FDi/ocAjObBPD3XO8GopnwPHNF5Fk3+CWFJ/vqux+dlMddzPEGVAf
         mI/EbPKNNvyMLQ1SRjjXbZnUmRqYaEDsKDG+8R7O8brB4nECp6Iua05jy+JG3yBo3rM8
         s85Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790961815; x=1791566615; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VqsakkF+fiyAxZb4saBmZgbMsuByqSA1isMXBNXFd3A=;
        b=E8gLYag4dZCzvI+Uf/NbVF420DDHqjbqefxKp25f/qJg4wb1IlO8RD8F7e8R5kQUVC
         0jHKcdbW26iDzh0Nd9XwQiO1zpb2fo1m0qokrf1V1JyVyUMfxNkPVZIHWm1034qXvQO8
         Br565nvphwmOuhmEFPE1+MFVnk0xSa2Z/8/hXDN77QYReAziyLq75Zdgz9l1K9TIFlnf
         tHaUa0EHgKKPRNDYQKiS9k8c80JTZp/XaRFbPtNMiqngXs6iuS9bNEbV1CmLJ4RbUGfC
         BXQoV44bfZdt5QJFCM3uo+EWuJ0Uz3RLhza9MXfvvLhw8F109iQiisjcjGGX2SbNESR6
         SeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790961815; x=1791566615;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VqsakkF+fiyAxZb4saBmZgbMsuByqSA1isMXBNXFd3A=;
        b=NXF8iIpEWYlBnk27p6GYmz94QRd/I3/mWs0Ig6WiSIRoe2+ztQMXw0DRmCBA3HW6hK
         K9QrSJa+Ez7zKQ6aYpkwCuWAFtRXi1YdYB5Fo9b/FyqQwsOfd2ezJu0F1mBPbJyTfRBO
         CoyNkl2EBQ52LkAK3cmN/X/G9pa5tTikym4E7Lhc9EywISVhqVfKuqgNG5g4lDZRI6g9
         LB61Of6xBn4r/dS6QdGDVMI3UHiHOXhrJqZym4H90TydJ1niaw4r+JiDM4jwVwnOxWtz
         xc/hptwpEl1AKG3D0eQgd9QrOV+BdHSLilQTphzBmI3KrDlQlBtwEGrnWxaeBFgx7PrI
         v0ZQ==
X-Forwarded-Encrypted: i=1; AKwUvByuAD8+Vp5V6Wi+KrDvzwsZHXmhQwVpUsoudQIGgwLkC573bx7MD8FJLEGzY6apvWDmshcduLshQfE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyZP0ERHfNT79PKMUBXqwOiUrGBxdTuBdTQtJzC261ObVhMQyn
	4uyz1VSE8IT2xzG8nfeMSpgQu1kJkija1gnHgJdR0dy5WUuqdmglST5Gg3XOb8QPKH6EUTG/e/M
	8iZ88u92DU+mFVgAApAd25IYuco12T+A=
X-Gm-Gg: AYBFou0jBreozuOPaojlvNhWsyrIlZB7ITKJXir1Yzbc6+chGR5UTbdGhWnBOHdxmkB
	9Ty8hjVa9YlRdNKh8TTOROEGl35kfrfD4R1yvUfdOCF5dYKSrCZCYlfEKNm31JpnxW66mlJPCQo
	+v2BpsQAJt/1E38KAtric35c2Sapvw2fETzH8VI7NVJ90YzoF4nG+wuSV7d1CrCo1VlHUDqKt6P
	2nB/SbJXpKXT0byKzI0tuLdmoXJ+mTLqOykEMgrF8o1ElaLWPhMKr9Wy31uO8zMkzNLM/qhF0Q2
	q80/awz6KSmPDYDNzumqVy0hKQubDR7zieo8mnG3p5a9ZdtmB8z6g0NlRhPqNYSdp54=
X-Received: by 2002:a05:6870:e18e:b0:49d:d850:8170 with SMTP id
 586e51a60fabf-49e3a8c248cmr24800fac.23.1790961815496; Fri, 02 Oct 2026
 10:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929184900.39515-1-abdelnasserhussein11@gmail.com> <20261002153302.5c64819d@jic23-hlaptop>
In-Reply-To: <20261002153302.5c64819d@jic23-hlaptop>
From: nasser <abdelnasserhussein11@gmail.com>
Date: Fri, 2 Oct 2026 20:23:23 +0300
X-Gm-Features: AclHuK-al5mseWXmh0Z-6X6KwSRpq7Wu9lvhjorTUxxTKLXGZtC6BdvJZuUovys
Message-ID: <CANpqX3YLq5ckiwjaS19YCVknmz7pRsZXw_f1hht0eWwxn-3s-w@mail.gmail.com>
Subject: Re: [PATCH 0/3] staging: iio: accel: adis16203: fix axis mapping and cleanups
To: Jonathan Cameron <jic23@kernel.org>
Cc: gregkh@linuxfoundation.org, nuno.sa@analog.com, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org, 
	linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, joshua.crofts1@gmail.com, error27@gmail.com, 
	narcisaanamaria12@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

My apologies for the noise.

Thank you for pointing this out. I will drop these patches and ensure
I base all my work on linux-next.

Best regards,
Abdelnasser
