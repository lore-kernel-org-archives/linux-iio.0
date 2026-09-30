Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768E744BCAE
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751874; cv=none; b=ilpNj8+pZCKzY76JhwfSi57St1ogpWozpXl2PcWGnVB7FltUGgzDKGTNzjTq0gdbwfVqz5X1atAOyGOQv5cfk9bKgfIzRtrI8l2FFkhMnCxgB/CX89qxtW1nYDnau6RIx2DOYqr+mjvq0bzxgwVawE/4es5j9WdEC14UWJesndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751874; c=relaxed/simple;
	bh=yFAS9/v1M5fbag8LFxiryNj/dstnuUqvUFxvrR3AwQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIv/Vm1jl/KptfI8/xx9+JhLhCqLTnhZXd6kuapDiXrQ4JJIZHDVZsyZQrIt1RXuizi6bhdTCyRBL6i/8J/fanZxzx6LSEWAsPtQnoOgkFJzYLJ5CV6fcg4yR7dEeU6VcPNJinkfpYKlQH8C9TyedVVARyfJl+3NrJKW4ljCv18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnTTUOBU; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnTTUOBU"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so27809235e9.1
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 00:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790751861; x=1791356661; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fnSRLEDUbCFQeuJzEmlR0hd67GUctSzHNjgJH5Lw/K8=;
        b=lnTTUOBU+jsn8hrSkkt4kxTHigXzJm9Q8hDlQrLdEHPwgcugKEqSCxDSEEsVM6Intq
         GmnqHW/qF+w0zG4L3l7aXznXGXfsiirAt+AaveCPAP2RndVi2aYwV2o7BwhKOlXz8AUv
         pTksh/g+nWUXwwvaBbD1bJ/YmPIxoOGY7wZbKP4v2XrPG2wtPLigtUiCizmR9SKFQTqZ
         WxSvDAPmKrevkRJuV6FN7725pTXIiPRdZqdThYv3T5p5kmz+v023Iex64mGZKZIBANIW
         uzetawdKfW+lvq53W11iHQEnq88CDlEMSuvRQ4mat0HSPINims5PD0tr2FEJfHKESWDP
         qO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790751861; x=1791356661;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fnSRLEDUbCFQeuJzEmlR0hd67GUctSzHNjgJH5Lw/K8=;
        b=ur65nbc6fo3SOa13/18xeJ9btx+/YHPPrWxub9kodm2pUo9z8NYRCUsgb3nBEYGWSs
         rgHzFSMCT0+ldry31s2juhcUBaFb3yGzti1ED2/ZUO1ZamUSDDFvSzQdvroO3SiFbcda
         syjbSQThqiLmFfQsEwBH0STzHqrqsMcmCQESIPyixQtlwC7TBmQUSi2u2OTesHf2PN2/
         DaMvxyGg/obKBGzfqTqk6rc57/3DNBRGU+GTPQmtjWempkJSA1CEFg3TOOwF7Fc+/2Iu
         g9xOi2QD3rRBdJQOiUZjDjerBGSrFzcb2PkhJfXr+KZNuYEE7TifFqec4OSWUylXjK+s
         GGsQ==
X-Forwarded-Encrypted: i=1; AKwUvBwq0yUmLYFzRSpZ8aWBRGeQVPNkSJVLUh9uw5xrXWLUtzM+oanGhE/cOAKSKI9PL1rL11HrFs7L0XU=@vger.kernel.org
X-Gm-Message-State: AFuF++m+9GgslDWfAfiHAwwGLiBh0fuu8n3eInvM8+5MfCJpxaYacVus
	1wHzXGncHUMECatxIdgFieQaJPqy4NPw62FbL7nC9T+ffllgyAdBTLm3
X-Gm-Gg: AYBFou0LWnIkfiblN7Z3Rzm9sOX2BBE9ZK8p2mhfq6jysBcSCPVMZtDOtpx9bSpPGsv
	oqsDWDzspXgIKvgHCw5vcv4+hNIJyMmjSN0UKKymxHoLHb2KA4MYVe+vkaBuSlYWKzGDIyTa+wM
	PkA3oW+FONfuwiGMqhQSGTRDCAFRk+AOaFAvo8G0NsjxBmSxfliMNX0FghX6dB/JDer5BB22mK9
	1rYj0yjDJrv1yeaLiSLFtpzWFXX2j2zJIQ9Uatm2QXAhFJu1F2EiT285cuIAkcl2Zv3D5ZpdZwo
	l3Vt7q8xiRXRbegIqQZw1EudSTMv1fwOEM8jYlNmKnm4kvhVhaqCEBDGGolSyFmIeUHEwfYgOjN
	A/7OYH1LQLfxBWy7huaZPElsJmVEBa7WcqJi27b7dqxKUYRlwBDD51jGyLj90yX2TLFKh3Z054a
	EHXEPZI14XQE0vecEMMMWeJi+m/fK6ykjFX9AYId1tbAYi7j5zPHyvevDuxbEsS5hYwgUFPdXQY
	jdwMHEKXwrRQ1e2qGLqaWuxDhj4s6lX8wDn0IjYTTIuR/JMp7kSRhIhhdinPebVTDKulxRwIUYv
	wdY5Ck9fRmY+ZRcG8/iuL2v7N60c7wSfeM+tIOs0mFEutJeHWqnMFbANdL1Y3Y//MXoAiphYJ/M
	pHAaleqxqJOVYWZhq27DPan30fGpMN30hoQyU2S1MPVmh7vDIkwLaVqIoFdTk/dNDe83z3f/LyB
	56Brum
X-Received: by 2002:a05:600c:5391:b0:4a0:1559:bafd with SMTP id 5b1f17b1804b1-4a01aff068emr5650595e9.8.1790751860600;
        Wed, 30 Sep 2026 00:04:20 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b02949a5esm1515980f8f.4.2026.09.30.00.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:04:20 -0700 (PDT)
Date: Wed, 30 Sep 2026 09:04:19 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, gregkh@linuxfoundation.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, error27@gmail.com,
 narcisaanamaria12@gmail.com
Subject: Re: [PATCH 3/3] staging: iio: accel: adis16203: clean up register
 definitions and drop redundant comments
Message-ID: <20260930090419.000073f9@gmail.com>
In-Reply-To: <20260929184900.39515-4-abdelnasserhussein11@gmail.com>
References: <20260929184900.39515-1-abdelnasserhussein11@gmail.com>
	<20260929184900.39515-4-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 21:49:00 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> Drop redundant, single-line comments above register macros that provide
> no additional value.
> 
> Vertically align the macro values with tabs to improve readability and
> conform to standard kernel coding style.
> 
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---

This seems okay, at least the macros are named exactly like the registers
in the datasheet... but I wonder what the others think about this.

-- 
Kind regards,
Joshua Crofts
