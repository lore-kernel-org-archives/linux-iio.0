Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FC739F190
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782647113; cv=none; b=uFH3Xaz6qpRANtRraB82P/VfQmT4b//BTv7y/cP7/Zxxe6cNuPNg3VhrCx57jXWATQpO6EvVGYX9r2qewjagGMRILpgFTMS341Vte67MfbmRvxg7UBoDX1VHY2y+Girpm7q98vmeA/8rTIk7K7p6ZieIPqYEnMdvtXyySSR04dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782647113; c=relaxed/simple;
	bh=NUYxuS5sGJDzBG5kR1dWF0WwsB45nQOIgWBFKLJVrhA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yv+INYPEoFRuIpgbviI93TGz09mF71e8g29o/ZqNYwliCZS5ylUAjTX9Bq+PrThEGfT5hChs4euM4M8UBdotH/iZ64d/oR2FmSZbG8/txSjD98suBsl+atKhJn45NHhur2SSkanzsqfNh0yIvxOmLp8R6P43GRI1Wq4mmI4aNR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsO5wdf1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsO5wdf1"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so17058625e9.1
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 04:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782647109; x=1783251909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xq15Nj4jlgObhHgQvW9vKgfX8g+OXd4v8K8i4Y0X6nQ=;
        b=JsO5wdf1PKLWWkRnKbwyPFj5rkzTWr78dAMuctuA/aab2yuK4Ayi/yzH1kS+GujpP4
         8AcORpSawqpySnGZKFelXa7ssu2wZyqLG9J8AoJqvoQy76JqNnSFwrpGURb0dQNPWSlv
         MlLaRQDFOISsv/KcVYAtDas6kqrz2E2HCPPnxi+X22Y6rWNWmX4FpsVbUlgTSfCG38jp
         6IuupCkY56iVMsF7OfKmRxn5GoqJty698aC09c+gLTKFSHCibeXNkK9RBQBqHXFWW+f6
         zuQZc4AObEKrtE+IAPT42wFTF43mfHc/H7QrocVL8HV54zeECUnkmsNDep4LqmW+72pj
         sP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782647109; x=1783251909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xq15Nj4jlgObhHgQvW9vKgfX8g+OXd4v8K8i4Y0X6nQ=;
        b=ovlMpEICN4D3c3RR3wdcxS+SG4me9Np21ZzgA6l1CmEtYjXwNilhZws8JSSIdtzUK5
         u/yrzx7H9hRojE3ahU0jDHBXsLCL0gzcRs+q7N2IaqIh76U8Kt7po30nhNg81BJn4AZO
         wJEkGZr8PJo272DS1pl3XsuxLlm/yuVMnXat5Bb6Vqju8uxPwCjMG/MUcLr3QC25M/Fm
         tvWKI4pWmEtYJ7vKP/YB2bT+y0HxkcnJlk+WnF7VsS54WjZtFOYss8LaxVnO+ALQWPvA
         w1E54EkALfuMt7RsDyqQg/gomSlEvd/W0YGieq4BNntky0do9syVLdHcxuLWmWqHR75t
         JnEw==
X-Forwarded-Encrypted: i=1; AFNElJ+agttSlIjMxmrc9ZdPPamqbuWu47Ia7sNH57Uv9UpMUxywsWJctU7XD2uuZnnzEaxULjEPiLQV6AY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUSdqGWppNF+LK0e7nW1Z62K15YQMt4nGyGyAAth5AnRt9UgYf
	LiR1SYIhsZwJ9iCqqhVNquplODoG1kLmIVIaGG4LINwzH016ATwG0qcn
X-Gm-Gg: AfdE7clGL/D6/buo6dWFH9ScjSI8FhcLNl83Rhpl54ojCZmpBQXc0n+uisR9by/u2tX
	IgIMcBTbDYp2EQXxCe6u+ZM6y3Rmq78J7tATMn83H4f1kWZMiqXQ0AFg92T4pgxGQ7mholLkWN7
	8C6bSrCYzpSwKJNo7X8/PDjC4i3sHJfvuL8Z+S78ma5gJI3cd21J3JV/9wwUeRHVrZh392dbIPS
	LnGJnJ6qzmIbJDxD+/dHte2OVxRgDBpbkUBhAxHm4lD3S7h6ErH/ofbO2kcbtsFO8aRBKXtdD4p
	d9pG54LFELWTjGD+Xai5JcWQqcKVyQCFrELXF7OeMqyYKtsny2DSl9HR3MrpeUDaLEiJwRNfnxk
	Z78+AdscG62ccFD3y+sWmiVkd7Llpmx3CSvp4ntEs9PxWUuVe6YDNvuAHX6sF9Cru89RDlwYiNL
	c0LZ2pR2R7eGe6XCpo3XoPmqCGrrY7/pep9q8rg4FrspsahU64wjDOqKl5M30n4sB0LHlqxc9bD
	bV/CXc0RcK0zrNX0GtF7kIdX44Exnv5veSAhbU7iqZoiqOyiEpIZ4r4HTUvsGOnKCmqunWuAZzG
	4X+LxuINyjvGgdQ+
X-Received: by 2002:a05:600c:3114:b0:493:a5f9:d33d with SMTP id 5b1f17b1804b1-493a5f9d51fmr36702115e9.18.1782647108581;
        Sun, 28 Jun 2026 04:45:08 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493a7fd1b0fsm38321085e9.1.2026.06.28.04.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 04:45:08 -0700 (PDT)
Date: Sun, 28 Jun 2026 13:45:06 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Erick Henrique <erick.henrique.rodrigues@usp.br>
Cc: jic23@kernel.org, andriy.shevchenko@intel.com, andy@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: dac: m62332: Use guard(mutex) for locking
Message-ID: <20260628134506.47f30e3b@systembl0wer>
In-Reply-To: <20260628034811.152946-4-erick.henrique.rodrigues@usp.br>
References: <20260628034811.152946-1-erick.henrique.rodrigues@usp.br>
	<20260628034811.152946-4-erick.henrique.rodrigues@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jun 2026 00:48:11 -0300
Erick Henrique <erick.henrique.rodrigues@usp.br> wrote:

> Replace mutex_lock()/mutex_unlock() calls with guard(mutex)() to
> simplify locking and make cleanup automatic when the lock goes out
> of scope. Also simplify the i2c_master_send() error handling by
> using sequential early returns instead of a combined condition.
> 
> Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
