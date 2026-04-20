Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D089033436A
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693285; cv=none; b=tm5wlPbyjZqmbTCFLya9rPaQpk+UCgnP0WA39+i35B4FI5AnKjOqszNytHiwWaLisKr1yo3D6PRn3Yyps93ZTrP4DTlqRv30nVx7P8tqO9tCGdiA6/Ia4KIjhkmyhBy0naRvRX5B8Adj6oR9uIwGdRmkD3Pkb6LUSb3oaHkWvMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693285; c=relaxed/simple;
	bh=X/sCA35vFOvvORX04tkckmfa9UgTGg8SVbzaASPtIpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tz4egRr6uIB5d13C6UG137+r2DxCIip9gdelPjNL27fCV/nRC4zJaxn4TqxnYk56PAtxTIxSMpyxQxhWnjvwzDTDjLspoZXuEdGP0Qt/RRb2+J3LnD4HzPTntX74t0zKCe9hd+YDHMemmGvTvgITGQX5WbWjkD12yJa9f39wcOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sIwEmePa; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIwEmePa"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso42447095e9.3
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 06:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776693282; x=1777298082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hm2ZrQCDBXbvG0flA6wLHxmfqP2GwLTFudbVpMDZjZc=;
        b=sIwEmePaTePYruco7kBupAk2HWLRw2306zqygsSSw6DWgp5aSf5k41F7mUeuqHyUT8
         YniA5FFKz/hf2KVxBIUXtO2tauA7AtFZwA2g7eeCPalfEH86QZJ81oTyX1CzWUbz8p8T
         YDYoxLpxcU/5ALFSs5BamD79q9Tu8plhGtfqJ3RMeT5FQxVrg3cCuR2FPrYqWLIAPSSk
         4n5PsKXWaHkYYwRKFnKwk5tkF7ZGjEhUMDhGaZM/9t51XmuD9ZroQ0Ku5ue3Ixq1ka3E
         Vv+iCGpghZ0x6Okr8Z8YpYW4AHCl3g7TTeSH4J/jSDrFEUEQMMfwfcL/SOXERx+lJGWb
         sCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776693282; x=1777298082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hm2ZrQCDBXbvG0flA6wLHxmfqP2GwLTFudbVpMDZjZc=;
        b=EW/yMy+LIARDc7AHHV1GTIIMZ9100Qslnl1lxfcx224boINBT9ZLKefr2O1FGVOLX8
         bN/VySVKTlCSOrbY0ppY25HvWSKZU/eCM5OF2Jdpn9vSo5IFIBr/ZRqtF4Sx4RgmQpG6
         6DpFoCKHBsAiJ7n/QdyO5GnTtNrPS4TLK2ZU2CcP1jn58JyXgFOvz7Ma/T9gEj9lE+BT
         2LkWqQRWrpJl4Chf5erQ1YCExtnhSRGp4LJNKBGyOxgK/GTCUQhSS9KVbFQY7Q5JhwRH
         5k7M9XjLXylxNrs3Cpk8CYFEyeAel/58v8fg8zZYxtxHEBNWcG4tb6QPzWHz6QFfpDqO
         oLgg==
X-Forwarded-Encrypted: i=1; AFNElJ+6YkvW+OJGww4bHaksrJXQXyUuFINL//i9zRBZAlxJRtBG49DrqY+/SIJVJP74YKpJ8ijNxvZm1TY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkd0qIM/ZIn1ldf5IOsXO2fBE117czuj6ZIhNgr1o3wh1oUHiK
	r+qIFVvA/QxL+3q/9tjYjxAmuo+ARqP6zhhDpIJrA7z/g9hUjlwWrnBk
X-Gm-Gg: AeBDietaluo5oaOzmCZg0Wf78aScWk0vtmjiYoYKYrtwed2EUS+oKMRuDksy/RH6Fbo
	krWaIEbiTAV2SzYipGjtnxfZiz1IJPvqcYntVe/v+e1I2Q89a6KlrnGURSQ43Hc3rua1IfU7VSH
	ydvuJw8yz7UejvxMlo/HnezbHzZxayTE0kIpDzsELm9A2ftztbjpfdNAGWDnqTNnfsdg66NsEu2
	/5savLAEdhmnFp/KYB1cQJRY2IKsXz5xd88evtCeJ22+iBYx5ApjyLY/wPIxK7vNRH2GMzeyOTN
	jTPcxNXCSqbEMgjRDVMr+FyZVrvXYswPa0jyFJV0TGeBzONkEmPDXlGqBlw1tZ2498UhCdE9Bwf
	C6Av0AmoYhTOB2kA6gROYBVhmYiOJ5wtS4CQDgYr79bNyaKMdy/TikfSUGiBEWENos2ngLIMXap
	W8OpPgJ30wZjoGccJDT+LkEbVTMP6LWA==
X-Received: by 2002:a05:600c:4f13:b0:489:1a65:dd6e with SMTP id 5b1f17b1804b1-4891a65de3emr80115755e9.8.1776693282087;
        Mon, 20 Apr 2026 06:54:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a4b329542sm49978285e9.3.2026.04.20.06.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:54:41 -0700 (PDT)
Date: Mon, 20 Apr 2026 16:54:37 +0300
From: Dan Carpenter <error27@gmail.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adc: ad7816: replace sprintf with
 sysfs_emit
Message-ID: <aeYwHbngIdVRLqpQ@stanley.mountain>
References: <20260419010537.116002-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419010537.116002-1-m32285159@gmail.com>

On Sat, Apr 18, 2026 at 08:05:37PM -0500, Maxwell Doose wrote:
> This patch replaces sprintf calls in ad7816.c with sysfs_emit to help
> modernize the driver, ensure bounds checking, and to increase stability.

This says that changing to sysfs_emit() will increase the stability of
the driver, but actually that's not true.  I am fine with these sorts of
hardening patches but I want the commit message to say that "The original
code is fine as is" instead of implying it is unstable.

If the commit did fix a real issue, then we would need a Fixes tag.

regards,
dan carpenter

