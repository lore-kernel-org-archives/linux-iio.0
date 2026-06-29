Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEA037F8A5
	for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782752833; cv=none; b=HwXgKpxVsYAe08P75vf7sl/72/s7nJXkkrAvdyAW/CT+9MHEgt79qnzJn8ktcoqFTcrggNf8FnalfLBPEDI8rCrCpm/0qo6QxcF8huIPIha6Yk/DKkKzb0gD+Xl8kzydG3IkSt+27B+cuMeAJpUn2P78McrI7LF0RmZiodXBmZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782752833; c=relaxed/simple;
	bh=ZUrSvMg9fi4SRNzeMfBED2xYYv2e++b4UcAYASECwEI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bD2Ii8TPj/6gO9Acp816fgtlQQ09cXKFkpsmdXMl3WgQM4XAigndjW7fiihvkXSiKNNojIjv3QPg7qo/HO3RuSsAt76T00wAIUTuAQ79MzCY7rWyE66idWsTwjrpbbsAhybT9ArCmOY5fqGb1AUMvmZvWMZ4JEjL59gUwhqutB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2V8FFsC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2V8FFsC"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49395888c7bso29803395e9.0
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782752831; x=1783357631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4W0Q1OQWjOJuaRD026ighL8U3gGwLvMZ8/hGDIVmOc=;
        b=L2V8FFsCIADS2OmnDwssV+IKtaztoS0FKMZ93UhWVCHvaIqXvs4BuGWo7wpxQHcmZU
         9r0i7U3YvaK9ycdBAntL4V+PZO5z0UOGtr/Va7O9qCVs8KRTEBwXwbtOqdEFxWDzfr3U
         rcA5t6ypTrwnE8Ry/QYOfLNY8ta27fNDNgMsNctRQWNfcFh2OgVVQluLP+KTP4omZr55
         YM02dbwuZzGvocPMfYdjsBt6Cz1bKFgifzVOaliw7o9X6oGXkH82eNqp4dHou1FRvyef
         6lrkKQhHcIaD8nab5q1CxQLXkeLvmrvcMze50B1ackzfcZaqPgaKScSha7m3wsevejV6
         rDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782752831; x=1783357631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U4W0Q1OQWjOJuaRD026ighL8U3gGwLvMZ8/hGDIVmOc=;
        b=hodMxMZU6CaGziRJkSc1NbHCEZF9l+YxZeBgmduhHGSstjGkKMeojmp0zVdtiqFCJt
         Gu5TGZH2JLjPtKh4DlF93fxFZDaYjekZ1S7dLmmVsOb6++IHGnJSgJDAqaf3Q5iJ59sg
         p7UAH59oqbWp8pair40yBQ4v4iVgagO2zgfxf+MqXNaFvWPP/QbbQuNI5DY0npKDOkKr
         Bqc8S9DsMIlN2zgV07yFb5k7duXGAlKYRFe/DEx+OVgkLorT4eqX+Tfur/CEm3BpnuxD
         /2Dyu1IEr6cTkr3vwo4fyn78pa9ZmYElZjiOWGM+GT8E3HUkTMVtaN8kfG1tWWP/h1hE
         Lcrw==
X-Forwarded-Encrypted: i=1; AFNElJ81UP3oYVGMCKfuNJkzCJ1677t13/NMQgvldqANERWpFRLDAVc4hmDxiQxlyq/3o8Sruj1tiwh4+/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3yEJF/heanJKKcQPNLyGhci0JOtc1eXVoYUjSybbtczOROy6r
	VnlRharq+WWsfU9GBlSENZ2IUd9a36f+GPe+vG/rgmRFsAQVNBgymsUh
X-Gm-Gg: AfdE7cnAwCXYDr/UICCLFcH6z/e3mG1E0MXFr46xKuWSCu9xCp0QVQaYUPmpvlIi3k7
	3WC1P2uR4jfUQ4ImRP9hA0Mq/HSWJ044aleebJW7smjpykGLHTurNXKGggG0c8IAAQTWjBA3UJm
	kSj2peLb6TF+IK2jOnke5MAAdMkjOM6iVrcGuQdqwyT2EzLOA/273IQGRGXbqpsM/3IcWKTGOls
	RLv3yItuNyCi6WZabaxQ/JmIAF7uZlIoFaXyPCXzCeNgeISTMWWcGmxF7y7HXU2dTjOeyaSyLz+
	grqw+lCO2GYPpK6FT9+nnIytL1uQDNIzksr0sWCKYv294DgKDoxr+rT6Q+q28la4pZ20kKCtMrx
	HOLlrBD+GSdpnGz63DJF2KcBiZypqW6SnAjvVZVkba0iDRpZb8E++lDYLmWHh8w5awU95NmtvRk
	fJDcmdtrcagLbahb9yn5xBPusURFTA43E+8weiQ7HExg4pSaOmDu2T045y0Zwq+PYDNG0iv/xlm
	NfjqcmULjhoYS6jqgDMYDQEJ+vsPGvknd/1o2r0wrvzEnrJaib1/KOMLpJT8jOy9hEFuIfpQHji
	MGV1uQ/dwFc9gqYv
X-Received: by 2002:a05:600c:a48:b0:490:bad9:de43 with SMTP id 5b1f17b1804b1-493b8148d3bmr9035445e9.0.1782752830650;
        Mon, 29 Jun 2026 10:07:10 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c28673dsm293957105e9.2.2026.06.29.10.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:07:10 -0700 (PDT)
Date: Mon, 29 Jun 2026 19:07:06 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Erick Henrique <erick.henrique.rodrigues@usp.br>, jic23@kernel.org,
 andy@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: dac: m62332: Clean up header includes
Message-ID: <20260629190706.647c0274@systembl0wer>
In-Reply-To: <akKfqWoHmEVUmfQ2@ashevche-desk.local>
References: <20260628034811.152946-1-erick.henrique.rodrigues@usp.br>
	<20260628034811.152946-3-erick.henrique.rodrigues@usp.br>
	<akKfqWoHmEVUmfQ2@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 19:39:05 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Jun 28, 2026 at 12:48:10AM -0300, Erick Henrique wrote:
> > Follow the IWYU principle: include specific headers for the symbols
> > used in this file and drop the unused slab.h. Add array_size.h, bits.h,
> > mutex.h, pm.h and types.h for symbols that were previously pulled in
> > only indirectly, and add mod_devicetable.h for the device ID table.
> > This prepares the driver for the guard(mutex) conversion that follows.  
> 
> ...
> 
> > +#include <linux/array_size.h>
> > +#include <linux/bits.h>  
> 
> > +#include <linux/device.h>  
> 
> And this is for..?
> 
> I can assume one wants to convert the driver to use dev_get_drvdata() perhaps?

I also initially thought it's a case of an opaque struct device * pointer,
but the driver already uses dev_get_platdata().

-- 
Kind regards

CJD
