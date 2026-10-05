Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA277472F83
	for <linux-iio@vger.kernel.org>; Mon,  5 Oct 2026 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194321; cv=none; b=h4eSnGgq++692Nw4vKMpEOfREUmvLHKVj7MbVVIop85KZFdz3ZiWPFi6BcPQpRQEeEQZJgnuIqnWeqUFDSMBIgqvNn67d/AKKRcKlMpAyGEbfyryw/gmXW3cFLUUrRrgSr0Pnu9XRcQrt6sZXWfBvcQBHrCYtGOOCSiC7jJ+97I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194321; c=relaxed/simple;
	bh=PVy4XiZVvVGnrrqLHJ++eKCppwJjFZExwQYU2xEaRTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QkGLPBlwvV3sXbT1szQ2HSXqzN4Bcsq4AgrmzZZ73RgMSvEbHcaRIngbm1XqXD/a3YP9X20VPRMNfxp8p2vDz83e+/D8L2lAEY2Gfk0nKfg4kHALsMOTVfg36mHD2lhoZyQBKhT7OdXXfGNq0ONFgEMLiBZwfzSEJ+IGPEdv2bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDreTxVp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDreTxVp"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49ff680331aso15523045e9.3
        for <linux-iio@vger.kernel.org>; Mon, 05 Oct 2026 02:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791194318; x=1791799118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fmRC4hX1HkUO2ejwd5/7P2ssChMP4j4+YtVG78yP6GQ=;
        b=EDreTxVpRP2aJV996ZrMjZ+6oyjfp6JJ+iDEonHwWnwA+hxDXVNwajt6p6Q2hVwj9z
         8UbkWGMM8yhn6B/FRbzG4BloQtfIHC4sqDWX2J5fkWQrLF/Nop56RiNeTPpLH/Zkk4gq
         EK2ti7SC8TVO6igj8TaQ+Zt0QGg+8iwWZUkIJfOG2vgJS9Akl3YpVkdByStBOJFSYnof
         H2IaJKSiTTiPr7Rj+mLdCUqnkk7Hl27Y7uJ7WpWmssQEqica5iKHwTto03bqzeTO2Ig0
         352N07/YV4O1d3d4yAbGIuhPbkdktHRimcizusYwV/N3Y5A+hsUliMejYB2WGzTKIjcj
         4mJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791194318; x=1791799118;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fmRC4hX1HkUO2ejwd5/7P2ssChMP4j4+YtVG78yP6GQ=;
        b=Sj54wniP2Z5fLJg5xtOIXO2Vlm7Ap6HIqsa2GswdwFKzcCn0gaBuwY7TxdblkI4ETW
         MldtEL93wJ0ep5DnO0eYvRhZuZsZAJNY1QdG4u+q1njlfZOaynZAEA6U5xylgVs2Bi7i
         JGc1RsUHJBwZYgs4FF0MCSJ31+CGmpeVuRxTir2VCl7L0WWdtenTfmQ8aAMXSCyi1mJ7
         5rLKGPEuVdibjAveSY8l1DTT1phRYK0DrrvNkGLPnFwAofyz6c+BKkkUzaZRigJhSuhp
         VFWwYpydcU9Inf6QgJPDZyHgDnbsAF3hMqKA+9mOSdVxr6JR2Z55RWvcuZZF0TQ2iPsW
         5CVg==
X-Forwarded-Encrypted: i=1; AKwUvBzT4GPqm4+GzqbIHrvv7ifyXacfgZPwN6kpN6FuJn0ktVGxhLGTAFUhkOU4O9x7tVnKgo3xJ8teM0k=@vger.kernel.org
X-Gm-Message-State: AFuF++miM8QVox+UiUbK5ZZKWicN6PszJ5aR494gsVleBBxmW+9BPoUj
	VPe3JqjmcEfJ4EKsBj2kq67JgMPT2Ll5ApJhBGGiTqushd0jtH9o2Tdu
X-Gm-Gg: AYBFou2aEF1sxjTq79HzGEGQQylk7LwmK46QcdAlbeJ8D1SSFdruZLpEC4a/UcVuX5r
	ubAPe0VOsfEz0hApNgkLvqehGWKsALTN9aAFP/W5ug986Gtq4Y8D0aw/HZRvQDGAuP42js/zcp6
	a6N8fK6nIabaBiIaYJkV9jxHhDCmXwy3Kb5LD7FbhlqPbcYTlUxLPbGFP8BFLNq160cbfVWmqrh
	hvwYDG8iea64Pw0tRL2bPdZ2QFQNfojU69UNtd8fHIa8f+C9eCYru9vC1BjPm6yAnQpwGAh2sCB
	pvQAcjNw/Xe+8yGnoLTD7aOb09oXyxHJZBO6ERrWH1h8RRDUfXzl7FqTGI+jsx68qBfwoNxCFJs
	n0grzY3d/aRHFrkrUK5f+Slf3sAOW+OmtWl1j2N+/as2kDw5FM5nlCVDvuY4XmgvS3MrSbrA1Nd
	htyGg9Yk6y70muKXRc2mvTPQJR03QSiQiZWPaP2ANC1HICXNIs6izVZ/xzfMZ2kCPUv5TXKV4Fi
	IxkMRoH+eBHOcL7XPQsklheMzGrmdeY31/SbId2cgd+5VWEqpfehQO3UcZ1VbIsr4GnIVGrBgO2
	b3jM4KwHCLHOxkuPqvQa6kC1exK6aCRnrxdHuxmytnoANuL0Nu0OYOFeB15a+lI0cZEKn58VC/U
	75K8ihLYs9/7n6jIAqmHe6iEbEANK0wO2sZaKStaNeFTUVNfMP+CcPkGvR+dpgIbGvT9JvahcXa
	zoWSHs
X-Received: by 2002:a05:600c:6212:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-4a1680e9466mr102508015e9.10.1791194317881;
        Mon, 05 Oct 2026 02:58:37 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c621e4966sm2518880f8f.6.2026.10.05.02.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 02:58:37 -0700 (PDT)
Date: Mon, 5 Oct 2026 11:58:33 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Conall O'Griofa <conall.ogriofa@amd.com>, <linux-iio@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <git@amd.com>
Subject: Re: [PATCH v4 00/15] iio: adc: xilinx-xadc: Add I2C interface
 support for System Management Wizard
Message-ID: <20261005115833.00007cd3@gmail.com>
In-Reply-To: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
References: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Oct 2026 15:11:50 +0530
Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com> wrote:

> The existing driver only supported AXI memory-mapped access to the System
> Management Wizard IP. This series extends the driver to support I2C-based
> access, which is particularly useful for System Controller usecases.
> 
> Key Changes:
> - Split the xilinx-xadc-core.c file into two files(xilinx-xadc-core.c and
>   xilinx-xadc-platform.c)
> - Add required helper functions and callbacks
> - Add channel configuration via callback mechanism
> - New I2C driver for UltraScale+ System Management Wizard for basic
>   voltage and temperature monitoring
> 
> Note: We are working on x86 platform support where fixed channel
> configuration is used(no DT support). The .setup_channels() function
> pointer introduced in patch 2/4 enables different channel configuration
> approaches for various platforms.
> 
> This series was originally posted by Sai Krishna Potthuri.
> 
> Link:https://lore.kernel.org/all/20260323074505.3853353-1-sai.krishna.potthuri@amd.com/
> 
> I will be maintaining the series going forward and posting updated
> revisions.
> 

Unfortunately you didn't specify a base commit, so Sashiko won't be able
to review this series.

-- 
Kind regards,
Joshua Crofts
