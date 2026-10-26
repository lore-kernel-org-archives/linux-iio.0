Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011124;
	b=lsdWLDjcEhX3sleNPI5WqjZpZOZ7odVW3EnYaF1wFwmsKA363GfvhjUXA1Tzg73ZExjG
	 llgEOlDnM9C0gnb8UHrnvyf06XVS323VUfCbscP+JulrSBqUHaZkM7b8aDIRij8H5gzA8
	 bi6s0HNdRf/qi+AZNFsn5NDFgDUMdQ33q/SXzak/cEx6jC04VIDtpR/Vya/+dQB+SiBLg
	 uGtjsEhus0I7BS8jjSV6Z+wHZNPDPAJsnI/y3aLI28d8SzbsvD4+4EDACeEhaHTFoIiFK
	 HxZ51JR0n3I4GMGQReWsRidVxM1RxWmynRQ2mIjafIUDQLb442KFRI/X/oK9/6BfvDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=skVw1yfqLZXOPzWoETXOkA5tQYujR3wIhQszB1NNCeM=;
	b=sw7RTrU/hagrFugrI1MWt6olAk1tcHASFI0H32cv6e2iiJcEoQTQWwPwqJGWtfmW3SWO
	 RSTfnjZKWIjBQgJ+cuIOm0UbhAFoAbCYMIUo+IV9YGlialYwzAYy9ELKkocVT82l5chFV
	 xRwliiQtRuGZj6gcDleFe+5t+aUBkFkjWoy+sVNQj5hO7cJzA/xJVvluOGPuzPkt5CEPT
	 gZnJqTwn3lxjTy5CkdEwuefaOGioBtxfsnrTXOBhCc6FFjrkIXeQpZBmVtUm+MUUvK1js
	 hYcqITMPuTUN8Vhlm3Pb3NqtGFZZkpFr+K0jsN0c890rOZ4HAnW6NQBV2bWSrG5EkFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UltD07cl;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25E8606A31D
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 10:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F25E8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UltD07cl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso14789605e9.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 03:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793011122; x=1793615922; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=skVw1yfqLZXOPzWoETXOkA5tQYujR3wIhQszB1NNCeM=;
        b=UltD07clBw2g+Y1aJYem1Dl1rIWB1uh8fp7BUdxaZ4uc5gMQGC1HSwdgOUYeOP8/dx
         2TkThOJk1VP9OMA2ajX02tpdaLLAa5XG2w8XHnfR99TLeHIhpp4CUSsvJFI/9J5IGG7c
         pGzoT7+hbDmAEe+Lj0blTQX1cy/K3pYIgAmUvAI6NR06P+hLyHXNoYC4EEOjfsP4PddJ
         tykQqtvjlvbunzbk6J5SlUFpbGUQcZwwcJDkjq9SfqJRVTEvOT2Jy/gP/WwtYNTUMPH/
         6Ls8CKv69hJpKI0qEtMEemKuUne4ij183SbEp3ZiQq9ERIHvQ8aSHt7vps2ehiKxt4rM
         jK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793011122; x=1793615922;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=skVw1yfqLZXOPzWoETXOkA5tQYujR3wIhQszB1NNCeM=;
        b=tBVld2iyXpSVjDVce65jGfc17hAluh01rJSFF91z5t8I4vW7gePp8SQB4qNPGJniYx
         oFpOVOnZBne9F4tcxN/Sw4R1B0v6eV1mJubv/j1zv6AWzdJcPQiae2o4pUkAyBObzDRp
         QWPM44QXwXW9HNskMPV7L95gCbdPWG9e569/ewppgBNDixnNubBXPYQoufSoF4u0BdqL
         pG4Aw78WWDra22YlVhcbINpRG5qCxSRUPle3ujUgaFMl2y/bmEVg0g8fdMS2nKjipCmy
         xev/kvay9w3cmbMocW4eYvcyPmNJVJcmLRQy5RJjjDRnYIY9ABKZEODz3ZRrkyMAO+2L
         65Fg==
X-Forwarded-Encrypted: i=1; AKwUvByE2iQP+uW5dfB1xZetDVRShe7cfNDjPa8X2Qr9iXAxlpAZ/ga5OvHJ5GBkwZKpRLnNJ2xji+WIHQE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyw6SKiWppExb/lOwBEkk8uYVEHa1AxIcjWuN20qTaw/ZVOcc3
	nIKRHA00TrWGKQ0a42TXO+++eM1VeohHMA7t/xhmUGdg59Jg1EkYM0YN
X-Gm-Gg: AYBFou36KqXh5wfEthtoYocL+ftvLtnUYe/cZ17yxJVZegRSSv+R3E/lkcD8IPC7k3K
	RJ2wEWRvyGPjrs+1mHcLB/6TbHxM9296VdydRMBNQNowFYrOWlYaCJsKJw8HXM1vxcqUgJ0GkKQ
	deyvlmyTA3IUvuStLz6zScLQrdNZCIVTidyexQnMYrdSq7BQVibofFYlRvF6/YItvoufNo221Q1
	/WHZiXoBcSL9wNU26StwmlDpuLbrUmmgZDJ55P9oyoPrttqrfY/9ic06yfgvQT/+qXxfrZwotaI
	eSl3XQmrmBvl0/343r0to4dFu60PiO/nQ4HQ4mGZp2DjZm5cdU43QvsLKJO8btyqVcG0shYLcl/
	zf9YCyJGM44UPK3womMv3Tx6bfHgR7mn6oUlfM/t3y2WjxGEQB/8YZwvjpyfvAloRrHgxSXWEk5
	5q1v8WSXHvhdQ/9qvu7qGT6D9iVj9Gj8+VEMpwmMR82J4tGGXHviRpEaaMsRiWkhLgkB6AHEm6A
	Em/Hr1PTSkcoTE8QHQLhPZI4qcaZJaZ5uC0OmZkKNlJBuKoZAubKs7yeVOIwExQGw358zgn5MW2
	nXOTpbilS0RtCFcN8JGkbJw4GwpNLXPTViFHenExNdlrbOx4bOwjHRTcHlgW4jDtk4RHCFff7WH
	vOsI0tOFA5TAVSQlXFgcaRa3IZ4dphXjAhoPxsfFk2QiVVqrYC4vbIyTjz3Ie0Elr/7Q+/aB21L
	X/vcwf3q5cyD5U7NOjDpeYW6peqSbSVAnxlIxNMFxMtHsA4RePyB74vRvV4Rl9wA==
X-Received: by 2002:a05:600c:4f56:b0:4a5:a5ca:de1d with SMTP id 5b1f17b1804b1-4a5a5cae166mr78474005e9.30.1793011122095;
        Mon, 26 Oct 2026 03:38:42 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a58a293sm184743375e9.12.2026.10.26.03.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:38:41 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:38:31 +0100
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Gwendal Grignou <gwendal@chromium.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx9360: keep the IRQ balanced across
 suspend and resume
Message-ID: <20261026113831.00007f06@gmail.com>
In-Reply-To: <20261026100450.17023-1-kapoorarnav43@gmail.com>
References: <20261026100450.17023-1-kapoorarnav43@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 15:34:47 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> sx9360_suspend() disables the interrupt first and returns with it still
> disabled if a register access fails. Resume isn't called after a failed
> suspend, so the interrupt is never enabled again. sx9360_resume() also
> returns without enabling it on error. Without an interrupt line,
> client->irq is 0 and both callbacks act on IRQ 0, which the driver
> doesn't own.
> 
> Disable the interrupt only once the device is asleep, always enable it
> in resume, and skip both when there is no interrupt.
> 
> Fixes: 1cdb4c47f7f5 ("iio:proximity:sx9360: Add sx9360 support")
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> ---
> I'm sending the same fix for sx9310, sx9324 and sx9360 as separate
> patches, as the Fixes tags differ.

Shame you didn't send the patches as a series with a cover letter
given it's the same logical change and that it concerns the sx93xx
series.

-- 
Kind regards,
Joshua Crofts
