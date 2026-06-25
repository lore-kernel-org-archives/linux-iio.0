Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AA63074B1
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 06:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782369814; cv=none; b=jFKUzl4SwBPOw7GcRoW//3LEic/EeH0aYaPwkM3lo4m1rFnhboafh3m0RaTZW/18T5LR6OYeMwqY00mrP9x2+5+1Fc+CsORrLex6XBaP0KtdoeTP4QYgW5VvamK1IpQ1XX1Hzcc6GGEE0rhl3tHiMoHyBwLgCyatMTxDOfHd3UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782369814; c=relaxed/simple;
	bh=FOptH6ZvzhlJ6Pd/lhC8aOE0NYTIBTsPVsogRFK1MvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USwjxPSkqrnOHNquUUl7mlhqydnZLneo2ND1VyOM6I+RyOv2u1x2u3X9cdjju0xKHKUt7nbU4dyQNlCq9BvuTdU3qT+YftT5iISxNev6DHERVTqb1177utP6lvKBGs+UmbOzH0Gyf864itWpux2r8vzyX846pGhg5jMKXxEcHx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJod1GWG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJod1GWG"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490ac357c55so16142525e9.1
        for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 23:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782369812; x=1782974612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kkic55kRlud5YPK5TAwlhg9T3x+lnJ6u4AS3OzeEW0g=;
        b=aJod1GWGuaqFCQG7CYfq/7qZ0AN0E436J+qa37TDEZWfjhOq6ruomlJMQNIVeKMdJd
         lk49byFPs3MMOPR8Gx0qtIxW5Lx6yH1i5jD93syPsBKtG/q16nH50p/uFlQEEYUBWc2q
         g82zvl7VT7rHlmwJe2d7fQBU8vQaRaV4Ft26Av1WzueHRtiPBFfHnYAoitfvxQ5mqD/E
         w+VGUXiInnreppTlo+Fs2fkTWAJQ4qgFR9weEXkkKIviknKMiOM9yMcIjmUXLCyjshdI
         83mEgJUTu+HOgOCBEqL781n76qHUdC8WKxRZHH/uJbnapn+LDuMy5unyb1uRsdRGq0sk
         9D1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782369812; x=1782974612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kkic55kRlud5YPK5TAwlhg9T3x+lnJ6u4AS3OzeEW0g=;
        b=T4aAbVt1b8v/cMLGaJaABzJyXFzvbKrc07xWjCcSdz26lrJiaYrH1aSOpNhrLKPNCT
         UsGWYiMWTS3wzNylDelYnO3jdzNbmrtuXibD2Pa3Cf+a9qy7NfQdzSJdIu6Qh4n8pCmg
         gqB+LOefnAirH2GNME2XOO9y0Zn/ykkRWOM3ZpGmG27nR71SvP/slkVRc/SwlY3IIxUt
         oZJDzEobxJUfJLP6g9WXZVebTXHCNb6+IBEPCzKYbptKU6+3PI3PUMtE/UMrNNydIrN5
         tzzo/G1m/7nOFRfyIIYdk4PfPCbxisIVODZTPsqL9jvRlmzDRrjN2KetVxyGJ9SdHlWa
         psfw==
X-Forwarded-Encrypted: i=1; AFNElJ9uG5FjwSQMWcCJMScO1N3jSyZRaEbmgilNUZ1WGQ2hPsCOvabEqBQWdP9pUqoAxuOkD8CXN+j83Js=@vger.kernel.org
X-Gm-Message-State: AOJu0YweLaewIcnxggZdZ/8wE2hSFtpHiacmaTvW3uuVp904+dDzo3OG
	xSDGYBJmua/4gz/D3ARi6F9r6P/S7URGrMBB/bOZ9dMC0D12TlGerU6d
X-Gm-Gg: AfdE7ckuArtV98BjROMw7pnKi8Zkv+G3xsCAU4clkXgl3vXz8sc/L3SlKRVubdfgZcI
	EZpNGqyahCIhwCkvIZmZhEjhqhAlwuTUmtDqiSs3vWOFg8N5dYmoSN7loRO7wwqDBKNmsWP8Jy5
	pdAWqVwohcj0jIU8/WB4G2zToHdhGS3tEzE5oLf9W0p4cNzmUhjgo+AjQOPUYmPK6lZMo5v1ENT
	O81PDFJJxduYmeJgdOsTT19HP/hReSUIU+t5dCgdf0nioJbtGZKPzC8wTSbl1L4LK0z1DtXsGyh
	vYpH/86DePFLoS6u1CWZ247eBtaIUpEWhQtyQdMUQlfOP2Y8oTPhHcdOSkySrAJ/Jo0qNBvIBAj
	7ltPz5qdPnN6p0UXclJtbUwwpcwjtTWPJ9XdQ0F8gGCKOVzl+Az0sX/HlXfOGec/EudL3rmdfNo
	MFLdpL3+PVuXCVGGLPHK8oYF7TuzLUaK4ONJnYjBXkEW92QO5BvA5I7KwtKenOmZLRXJ4ZMvAo6
	YsUDDxAmAYtqPB8uYup17+gRN73Z5Gfrel2PTw8EwkMJ5CZpUHupCNE80F/uAVWb9B2FqHAGKev
	AqmtBjTGx4DiRK7D1ADZZ0EGCGt6Ceid9uYJKhHUdCTAZakje0/Hq0A=
X-Received: by 2002:a05:600d:644a:20b0:490:a298:acf7 with SMTP id 5b1f17b1804b1-49266899f6dmr9406295e9.17.1782369811643;
        Wed, 24 Jun 2026 23:43:31 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49265c89253sm19333385e9.0.2026.06.24.23.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 23:43:31 -0700 (PDT)
Date: Thu, 25 Jun 2026 08:43:31 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: light: al3000a: add missing REGMAP_I2C to
 Kconfig
Message-ID: <20260625084331.0000371a@gmail.com>
In-Reply-To: <ajzNMwT8Y640fnw_@ashevche-desk.local>
References: <20260625-fix-al3xxx-kconfig-v1-0-d41cbc0c3cf4@gmail.com>
	<20260625-fix-al3xxx-kconfig-v1-1-d41cbc0c3cf4@gmail.com>
	<ajzNMwT8Y640fnw_@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 09:39:47 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jun 25, 2026 at 07:20:43AM +0200, Joshua Crofts wrote:
> > The KConfig entry for the al3000a is missing a `SELECT REGMAP_I2C`,  
> 
> SELECT is not a SQL term here, but Kconfig, hence small letters only.
> 
> > causing build failures.  
> 

Haha, good point. Will fix.

-- 
Kind regards

CJD
