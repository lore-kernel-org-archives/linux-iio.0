Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422973BA222
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159374; cv=none; b=DemqK1/e4qMW7q1zZvAOBTWhvyt9tFGnF3c84rKCpVkt4U4J2AgNodeUguLGuFhCUrtdax/Rg6zaOkoh9qH6SxBrcFuTvtDvix9ar3f0DpWOiG3SWzCCkBYsUho1KNVY/OMURPtqcbpPsie3jQLBp8mE+6HLbO1XZ3rkHXEs2QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159374; c=relaxed/simple;
	bh=I4E3BJ64QNjlDpPRGxu26mcEgdKOcJ4HAqG0DuEZpuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQpQ+5OTp738REY2PWfJhawgwCOzT9Ndk4S3hhkZQuiaMbSD3NwqAf2AlLg/oUeyKdXHZjdz39XFmc6WxK761CUKKUH4gk60v5EQGCcMrgA3Ow1UYP+HcWaHn+Ds7HWSPixABgucaAV/PBNLWzJjNbZkbwDn5E05JcihBwLNWHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEsAibVs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEsAibVs"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b0046078so52995105e9.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 02:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776159372; x=1776764172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kq5csPkEyD+lw4ZkaxgkRlgf+I1PvGk3IpXK+2wCzQQ=;
        b=MEsAibVsGExIR5Y4j2ln7/QG2WXYPAPCxFwFJFf19AlLOg8+bDaQlX9wz4vMQ6cBQt
         2JFktkhWtjh21bsfqF5ClUo4heub3Imm1ieJzzLNTuNx8U5BqyQOWfIAM9Qh4M2FooRB
         G51i0ekeekt/QetRGcEC2lkBwa2iNn8O/V+w1qSBeVyNe18+VDhEF63ejZvuuvIXwnR8
         zQucgOUEAshdipEXPzOV6QtB8OXukLVi8NZVaPdCB1qOixNFDEJN6N2s3npLN5spKXLX
         k/VJ5fG+IaEC00zbtrdLlXb1RST7iVvCUJT8LK31JKTv/PfioBHZWaqLgvuzMTGu4ad9
         fJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776159372; x=1776764172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kq5csPkEyD+lw4ZkaxgkRlgf+I1PvGk3IpXK+2wCzQQ=;
        b=ojpjE+T9Hjv5/KWec0KSAz9+coMfArENPU6k7rkfMmRiJVXrIwNGDPrRbCk9JZgaeE
         GY2La58Lxb8ne/UADuDU0bfr/aGilt7h/evLhFBHySjWZVICOzWR/gEo/FBGsdQQujD6
         zBVlcmoflKghmBnM78Ui3mPXpzf2FErk3R18b8pj+UK7xLBTfoHJm1O48MZuMJlxykdk
         HP4W2r4hynjkiS5JnMsyMkmJ7Ryvsaj0eWy/V9GpBA9JHjAWSikcYgsq72Ue74VaQpUV
         dy6LmtUthmA6Dskl9F5VeM+XCPKGl29koPvwprs349u+lgLXkhtI/fyjLMwvEvT3QW7C
         piaw==
X-Forwarded-Encrypted: i=1; AFNElJ+YjTzUMem9T4Re4yId0HYlNdlPpLCxgEbcDihIn1yN28laHOtKlE+TrCPtGPi4ax1QCK362euBktY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeA604Dxc6zGnIQQIZPX39zZ29iT3OEPA4s5gKpSjdToWig01c
	wbyQ/lF55MVoR+Vx/955yxJoibzRv73HLczwS/gsPeAfPi9z/EIcMypv
X-Gm-Gg: AeBDiesUk3IN/XC0YfP06e4W9DUNGfEK9Z+nESi67+NZty8x72PfXORLMsX+knccMkh
	0Mg43XAmIGaozjKn7TEmbrXart1drtjo2Z5uU2dg5iZf9v5+wkJAtCU+CEPoF2mJiTqrFRCpK1R
	l2dPhtm6AhF6d/s1kJR54lrP4jPyKI9qCrFdDnhJeDnoq2DeC1Dl61cYU2vShmwesIs1Kr7X+Qf
	AJSmQTe9K36EJaUhe5FKbDeozEveLD9ipuGwIvjEVOjqvxRrxnKAWDH/kLiM+5wKWUKyKaPfjNX
	T7M4To6T/CcjNRFIGdYt6hYEj6UWv48WQqG1lLPybcJG5Dw3NMGsYOP+EqlAY7J4QGsiM0WqBw0
	NtT3j0oa1bjOQZJgdY0BJUZyU2zNwgixVvphMCKnPTDvWVgKOyCNUEnCmTyHcghqrUMVFMU9aQb
	aGHCOAPCAWjtuuYcqIz5eF/sz7sNw=
X-Received: by 2002:a05:600c:c088:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-488d67bf744mr163761685e9.4.1776159371565;
        Tue, 14 Apr 2026 02:36:11 -0700 (PDT)
Received: from localhost ([41.210.143.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ea764eff2sm2500276f8f.27.2026.04.14.02.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 02:36:10 -0700 (PDT)
Date: Tue, 14 Apr 2026 12:36:02 +0300
From: Dan Carpenter <error27@gmail.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: frequency: ad9834: add mutex_lock() when
 reading st->control
Message-ID: <ad4KgkcR58lQwPaD@stanley.mountain>
References: <20260414091250.1295-1-joshua.crofts1@gmail.com>
 <20260414091250.1295-4-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414091250.1295-4-joshua.crofts1@gmail.com>

On Tue, Apr 14, 2026 at 09:12:50AM +0000, Joshua Crofts wrote:
> Add mutex_lock() and mutex_unlock() when reading st->control to
> prevent data races as st->control is actively modified by
> sysfs _write and _store functions.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---

This doesn't matter in real life.  "Oops, the root user tried
really hard to do something stupid and got "square" as the output
a fraction of a milisecond longer than they were supposed to."

Is there a tool which detects and complains about this?

regards,
dan carpenter

