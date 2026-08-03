Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31733DDDA0
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785749203; cv=none; b=LCuTleZFX9NQ+XWG+g4mIVapvOKoCXoo5uO/W5y3T5m6I5mCfnATsDalx4gAZsizCEI058QQJ/+gyswH76X2eBvJUVN2E0dNnzjqvGUqyPOAI3rDISzZK2nC1kH5RkMfLahu//XAqk0PpGyrToANnoZPKOQGJn4eL0OHOlrH4co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785749203; c=relaxed/simple;
	bh=5F7AlIcnfhiQPjlKOB0geJOXnX46pUAPT2hKAuAKx+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qefC7eKE/AaP6WzFGbpo7BxVZk3hyXXhsJCDiVFFhe2QqUJDNQj/3JkV18rgzN+GMoo8motpQj6AHFD0vzYOY5+OTluddNR2VweZjsPTNOnPpBNQj+bKowOh1ao/aLJVVlJC/9WKmnY+La8E3Vr8UH3wgMCBaO83oOD06Ygq7DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDj8XKVu; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDj8XKVu"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f59f25ec4so1178824f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 02:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785749200; x=1786354000; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PbuT+o9oWLq0ldYEZH19OfeKxsUJu1JJ5y1+51YG8jQ=;
        b=VDj8XKVuKzAEHjL8/j5Fj0X7GegF+owm2TQTCwQNiNLcLO9UTbGyFH3965ZfIMyUJw
         43Kmc2yhxIse5it1VXXRsR5hl3jIFZC4F3+klz9TCv3F6SLZPdpT1zb4Wsax8iifruJ6
         1fQNuVPbANI/UlZ2pmeajRJbIfDS/vY23JjSQoq6AWGsuRCUxgCa+ghpkWkP5D3ihw9i
         OcD7rTCOPsbdTU+Wb1wPCjutO4p++p7xdGEwbL+oa93cNxrlSmcQJg0QhiseZOqOjmlJ
         fJJhPBJtRhe7CCN1rM50sQDnIqXFmpmVVGvBinFIigLzurMVpBUa7Pqywzecdu3CdTdD
         8+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785749200; x=1786354000;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PbuT+o9oWLq0ldYEZH19OfeKxsUJu1JJ5y1+51YG8jQ=;
        b=B85U1MNLkoyvO7toGWwzerk8c40XUCDXjPCX3v/18RQ8FAaUusWpM9jE4Wt01XXXRH
         /GLhxhC76GU/9UuSxwZGrs8VgE+0d5RW3YtdtHBBlBKx6Yna8Hdw4uXGErUtaE6uhoDq
         ZcUAaVG2a/PAv5kAOZehFNfaR5HNQmk/vEsQg5x0rOiGwoTT1Ut9oQujn5dPKqISifSd
         j0+fpUoG7qPaenA/f0jGooaff5vyC2JHJSpqKAJGy4QOC7J6cJSDkvw9IJHJTjbdvOuX
         wMQC/2M6R5+nJQbU8ShEwmcjY2HAOSSxZqGEwgNaSy+VjKoitd5Qmw+niMr0VMWsYNpZ
         dlxw==
X-Gm-Message-State: AOJu0YxahNyDEHu4I/8NOEXZBkYrect1Qk9KUDmPEyfBA1uBG92o4yDS
	+fnnMqk1/Jn5U5J5QFKSfO5D9vH8IulA7apYgcYWyyE5SBXthDvweJGsi/RJMHG8
X-Gm-Gg: AR+sD1145OVkxi/TwMNYSIOQ+ALcJtjU4qkk/rzmeHfqyJw3z5RDBAEOcGuZL0Y+JCc
	vSHKZMxnmumwOHxzFExZgk/Mlzi4T5fCGsNtJeH9RrwtllFHC7uUY1QU5ka3NjoBaS9EoCEA16C
	xh3p9lY46zAPXKyEdQOk/fcPgyn00SgcEVhglsajptG8jxBmRK2qbVGhf/3xwmBGvAa3ma0bf5u
	XbtYLnT/NElkjkW1bXFBzyL0oA0W1kKDUT/y0PUXK+M3SaSCV8B/t/WuVP+Wrf7rrMEWzWVUu4s
	oC5Zd9arTsN8kbPlMUdiFm2Sr+lFvM9ce1zafPMxruMJqLwi4/SEF6jOHOFWpSf61lZFl5wkCvG
	CtUx5UTHl5MRk8No621hvVMVqpOpYclO2aCj8f64UU3+QQFCeXXCT+gYbGL4ocemvPL46jvehwk
	DngegXHwvmaf02jXj50kFUwoUeD8NafrMj6lC6XnztiKqAe9oKKJH9Lu0fpctJRA3L6O9avv0Jq
	29j+RSIbNZC5pgFyps3bhiowAqOVU6jqR04OGUnUQGqyw6KZIMKr2gYLwcO/rD0edh9zXErIKxz
	vzIMv1r4x2SgZIUQulruAaq0nqZJp6WVePw78emyeTn1f+I54MVeGcTqKFHEKCjPuZyo47RCvqF
	U228ju1kjKBoFNq0L3Qj+QKp1MAFw6O9O6jjUWu0zUHqbCszhxwxSs8Ju4C6tdu29/uPKFd0=
X-Received: by 2002:a05:6000:250f:b0:47f:91eb:342 with SMTP id ffacd0b85a97d-47fd72b4841mr22689058f8f.13.1785749199876;
        Mon, 03 Aug 2026 02:26:39 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0ae0sm32333191f8f.33.2026.08.03.02.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:26:39 -0700 (PDT)
Date: Mon, 3 Aug 2026 11:26:37 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Jinseob Kim <kimjinseob88@gmail.com>, Sanjay
 Chitroda <sanjayembeddedse@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, sashiko-bot@kernel.org, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v2] iio: buffer: Ensure bounce buffer used for unaligned
 case is zeroed.
Message-ID: <20260803112637.000045af@gmail.com>
In-Reply-To: <20260803012224.219493-1-jic23@kernel.org>
References: <20260803012224.219493-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Aug 2026 02:22:24 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> iio_push_to_buffers_with_ts_unaligned() leaks uninitialized heap memory
> to userspace if the data passed in is not a multiple of 8 bytes and the
> timestamp is enabled. Specify __GFP_ZERO for the devm_krealloc()
> to ensure any extra space is cleared.
> 
> Fixes: 95ec3fdf2b79 ("iio: core: Introduce iio_push_to_buffers_with_ts_unaligned()")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260529121005.1470-1-kimjinseob88%40gmail.com
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> ---

LGTM, but shouldn't this be a V3 as the previous patch was a V2?
I got confused for a bit...

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
