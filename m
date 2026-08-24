Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86973769EB
	for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560599; cv=none; b=j0nbFUjtVVgo7mwt6nqWYhmsnqjnLSWd3SqG+S6ZpqJSWh28/NebGMnqmCbtfCX9TUHRjfGeChOs20MnNIEPOIpKI3yhxv8vhcCsDwFAKXCSRdLYNzQL9B3CGTbYJ2faIbAN1eEYJDGlf1JHtppVMJ2aGezk0VBN3jvDyicDyM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560599; c=relaxed/simple;
	bh=m6K8tE9QRE4hGa6G/CQf+I6T52PwvbcaL0qUrYBhutg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PqGsNZXWiBs2rPYuEBzsGY0RZQbizLMuLquKdhDDs4YKmYIEvmN5ivp7UVcvudTslfjjm57ycNIHNvjGecrsGqQmoYvonqSWrwrMoFHCTxQOlBzxbn6QWrsOx6rsq4FLv/iudsNBJ2CLbGtW3BdIK16OA2hg7VGka8MFQKBfuFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEsihEpB; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEsihEpB"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a15d54ac95so5492139a12.0
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 01:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787560596; x=1788165396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EaOtM/OjHomrIPjUwp42BeVv7pgR3bvvvm+dmtmEEOY=;
        b=CEsihEpBDdGeN9GExUeqAVdj7qmgzfUbcY35IzBpbbgf8p5uMn4iVLAbIPA+bXU7Xu
         BT2bvWU4Qh83ENLrb0zSWQSLJm1ClF2PpIgB47/DYZODFSYKvLcxVp7ac7gDC8bmD5eN
         hD6++soNIAVtxiLfUt+io30/I448Wr4CYBu6OHe90+Y/RHpbai/dqn9nsfCy+DNvC8E/
         Q/hcLTNERYGbemqchga4wm3aeOLlchKT6sp81ssmFxtQ+Z3CURSg6YrZQcDp/3/JUHll
         OmKhX0Mgw50afPrsy7PfDFgz9MbyMCDr/5y7ofghgwxrqPJdNNfJUOkmHqv/WwxwBJvU
         QaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787560596; x=1788165396;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EaOtM/OjHomrIPjUwp42BeVv7pgR3bvvvm+dmtmEEOY=;
        b=I3dvwjBOcWqfR6h3LLbS0oE4EFpNxs5b22qW+bCGdB98KeHnpRLtEGasLIDh4RTeGT
         Jgv2Vw6euXgjOhkfU9Y2qYJiSfd9pu5+GROVBVW/6l4e/ozHFYK0G3Gpa9TReIgkGmW1
         WnJU0XmRrpoH8Md2REaJDo27yaEw1hhWpsBfC/iAjWIvWwRVMa2cRHgaE331W+NdHhjy
         XBF4fM9lnFPJGpg/sqy54X0//lqDNcpVpRPvHaPVl1iOf0pZTp3wIs2Gw7UVeeJqAdyx
         /iX3Xoyd/u3RmEKoCYJz7Vy5FbaRsJLyfrbE2qJk8nqWCwGyGWqsmQiDduinJj3pBugV
         +faw==
X-Forwarded-Encrypted: i=1; AHgh+RqcKhy7v7PZS0cwtppx7bOMUNnusLzQkxwn9JC2rJ+46NkjI6+Qf3L2+iHqE9PuIeh6HOHmYoeJYKM=@vger.kernel.org
X-Gm-Message-State: AFuF++lXSKvT4CbS77q+4Dhf89os7kg/C2Z7s9E+75hGA5eEsjKpAqRg
	R9chbNbaJFuZOpLIIReO7oanS9i4V+zXzWNAMSd1kfPmuOSTtSEMnm12
X-Gm-Gg: AR+sD12Z+LdKYqV43SDuw1DwmqE0C0NvkSmMhf4cNmLxCZ8G2dfhWnoF3gS/4miCXNe
	TACX4HyygT7I2Ftu+yrDQCzyav5AsnW7JvEBySpO6XKnEVtB78afjhJIBIZELuvKW+j4VoTikqR
	cep1bdtft+nsE1AJf8LYMzwlPGROr1anpgVceSckoTdB730fKe3QIEBBw2yL82eMbKxJT+zB4Mi
	adiRw3Ht7pMXdRmtHEL0Gxs0MMrT1i05JxkpGtyejPWYUvOjqdafl6aQCGb/RhQz5/Ra1z5tPlm
	vamtruP9rTYzzLp0kEOX9KjcTFy2ptS630Ye7crQ5FxVhuW6YMO0LMBSamWrkTqzADIb8Af0DWk
	DB60y+pHD4PYOfpw8BDwS4GS1UmeYe3etQ4KYu2P9H31xOAVwsLgYZ35tpgI+aJOdfhVCBqIoZo
	3OmV+gj4xe6jm/SGm7gAmKjXoTZ+LBLic30whCNpWQXPPvRMzad6V6VsDioz++p4Xb/blSCF+ar
	arsXUPGGaVzS2EjMgxdxWs3CbrND2mOBYsnin5DA5C8q+cJzj3f9aWGkufVgaTCl9DUV48JGs0i
	QyxX6Y6cPm5jUwRoToZbMaO0WGhkIKLLRhFYmt/eqozgTvfFJ7dYbBPeoZMfoxlDHWM1c6IzfmD
	BE82QZDaiSxpo5zfV+v5dnNLnr0aF+otaMaSxuv64MCrQ8Nbh8FiwP5YuoG1E7cNuT+CVZA==
X-Received: by 2002:a05:6402:4543:b0:6a1:f092:3c1e with SMTP id 4fb4d7f45d1cf-6a582b77e22mr15734174a12.13.1787560595652;
        Mon, 24 Aug 2026 01:36:35 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e1d741asm7259404a12.27.2026.08.24.01.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 01:36:35 -0700 (PDT)
Date: Mon, 24 Aug 2026 10:36:31 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, Puranjay
 Mohan <puranjay@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/14] iio: temperature: ltc2983: make headers conform
 to IWYU
Message-ID: <20260824103631.0000315b@gmail.com>
In-Reply-To: <aowAYN7j8_UXkxQD@ashevche-desk.local>
References: <20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com>
	<20260822-kernel-header-removal-v1-4-ee31b124be11@gmail.com>
	<20260823185219.222c7990@jic23-huawei>
	<aowAYN7j8_UXkxQD@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 11:27:12 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Aug 23, 2026 at 06:52:19PM +0100, Jonathan Cameron wrote:
> > On Sat, 22 Aug 2026 10:02:31 +0200
> > Joshua Crofts <joshua.crofts1@gmail.com> wrote:  
> 
> ...
> 
> > > +#include <asm/div64.h>  
> > 
> > I think we normally use linux/math64.h for that one.  
> 
> Right, the rule of thumb is to prefer linux/*.h over asm/*.h in the C files
> like mere drivers.
> 
> 

I was working on some driver that had asm/div64.h so it just stuck.
Will replace this.

-- 
Kind regards,
Joshua Crofts
