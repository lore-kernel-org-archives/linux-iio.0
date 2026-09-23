Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1D6456E05
	for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2026 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149134; cv=none; b=O6KC2H4tmmAN031e7cTqsACP5foS9MgTO6rO9P1fLAqEIDp1ukCrif4UEyDFrWGshzRnq8UM6VZISCp3xyvcqCrEGv9QrZBgOW5wePx852nWowaBLcNAC085MhV31TWcwsTcd/zH/4oh2W/HJ9rmMQynAY9w/WQzMTYdB1sSFP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149134; c=relaxed/simple;
	bh=CgvfhIqOZAHIwmp9VQvCKx4wipNWh8764BFs96AX6hU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1ahWUlJZfRUWCRUoqHfvX1BPdXBRh+mttzuU58lfUXYXiXnfC+gTRvJ9HqDZt4p1lYIlpGd/AHzjUu/VmjjBrMfHjAtpRUXszaDbIk35ReNYHA3ZpsaGLih4J9CC14QwfLb2L0FUlZVOkSFnGfXqZgTYlZl771eDkb8RmG+h34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFELAUH+; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFELAUH+"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso5047875e9.1
        for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2026 00:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790149131; x=1790753931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3fgvGkM1pyyECB7C7U7NNpHz8bjTHVJbR1NgyRpCdbU=;
        b=jFELAUH+ZaoTML/dAJ9DH0XOR0j/lPpSpfkWaFurv3LtCk0P7DMQ7Jeivq7XKFmQcq
         JSEab2I+ah5RVL/JXlw4jPDHCbEoUEXfUdrGKjKA3Lz9tkdt+4++JRvWwpWB/hqxOmKC
         Qo1K39jM9GxOX/nQ7o1EA1be05Wwo3xMQ4oK0P3zgYgyu6VsALfGTxv9dp/l/VoJuk0v
         3Z7cEDQayZ3lr3FhAKKH8/5oQDaNhdxsDIMSeKkckIUrnGRxipaXsdEyFYZfSf2JgiEw
         fcR6QshcaRDqQAgmIarc/w+V++rVqVBQWzrVRXxWiv95hSE29TaNZtoic+tCf1boYx6R
         CTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790149131; x=1790753931;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3fgvGkM1pyyECB7C7U7NNpHz8bjTHVJbR1NgyRpCdbU=;
        b=jdFpo564CR6S2FXnU9RsozfDZ/mVlLS6mI0HQX6z5nB1PhauRUThFi4LBz03NLC7sN
         5Sv3J7bENdcdVgNOdYIOP0EWp2NevS2HlQAHQo6/HGPej5tnTCMAh6n41U6RpEGOmrrm
         JFjsn7O5tIs50XNtOz4UeNG1GT7DqFk5P5bjtiQx92shF2Wt8mvXFykPN3MUTLUqKBwA
         IApw/oIwC99dLl4opK2oq863mLHZ3BTyG8bx+/b5L8SgzIsQk4Z20PQp3899C9nbNfdH
         SVPVauLqwk3PzyKgZCrQOFit2vhNaGpadBRxF9Ukhaqjiu+NWslWqJJlZ9h9OEdk3e+5
         OGRg==
X-Forwarded-Encrypted: i=1; AKwUvBy0veWBGwaDahxAzQx+PHEm6/rW1qOriMSYhN1JPXyI1aJx7OWy6Di5zmwJxOlxt9okqT6WtcV3w9E=@vger.kernel.org
X-Gm-Message-State: AFuF++mj6m0McWyRr4tQXg0TBghwEKOYeLGEAjBR2CJ2eUWTt9hfsMP0
	FqkEydJZIMG+mnNPEXZEJ8e47s9C4kqHOU5+AKjmLFGB6HDlDP2kyNtN
X-Gm-Gg: AYBFou0f87r2PYMuW1T81PYYmGbV5ztKQjno4z7VIr/5GcF3T9YmYvHli2/2yLqbp0N
	2S46JrbxE8vqCvIlemouQNxfLxGJCHEfSQJFL4TN6h4kPP+et8ibLxFU50rC0dbM2abK28/TdLq
	8EggGah3SKj1YwWwgmMNx0G31l6ALunupm6Pc0O/ExsefcdC85WNCoAH6b8ljW2vFYznZlvo1m3
	6N7XN5VN3Q6EaXssYbuKbdfFJ3VzOkAuhG7TbdJa+5TiTQaRzlHK4H5/lRDEhuuMQfg0HNdD4ot
	SCECFQUfr2C5dIE4ii9jRRceLJrkM38xkzoWrs672ub+gSSoVsdqTeieDJQAPCuMhNtKtRr7Mp0
	7CLGp0bP5sLS1Z6QoKhzvJTWhtNmQICgZIw+Bk+ko2rkwiOoZeyqgTFXqUOluX87VOV9gIpGpiw
	/ztU3Hq/T9LwbPCNIJiSWcLi88mUPD0AFE2LbzvI3P0R1LjY+Rzf+lAAni5X5lZgkwizd24TUHh
	RiRBqsRKCi9L+Gymsj84pbUNfdIUbDiJ7u0Hh8BhMHR2xq4Ing2lALeheoAkKh2e/8fO/5OCzm0
	6rLNXtJ2adlAcbtjgfQNr/D6JP4VGixtDfs3oVEiFbhjPKlHHmqL2+eudgBPP5RHt93nYF0mbTq
	VMKtUNZZvzLD6WWmbiO3nPAqTZXblDoWyWubmDBGkjcK7Frz8+Gbjwzl5oPmSye3TpQ4rilj36F
	zZgKDO
X-Received: by 2002:a05:600c:1d1a:b0:49c:d019:70c5 with SMTP id 5b1f17b1804b1-49fdec98769mr20567755e9.0.1790149131103;
        Wed, 23 Sep 2026 00:38:51 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde134739sm52926645e9.0.2026.09.23.00.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 00:38:50 -0700 (PDT)
Date: Wed, 23 Sep 2026 09:38:47 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: serialize buffer teardown with mode claims
Message-ID: <20260923093847.00004c4f@gmail.com>
In-Reply-To: <20260921062421.64647-1-kimjinseob88@gmail.com>
References: <20260921062421.64647-1-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 15:24:21 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Buffer-mode claims hold mlock to guarantee that the device remains in
> buffer mode until the claim is released. Normal buffer updates take
> info_exist_lock followed by mlock in iio_update_buffers().
> 
> However, iio_device_unregister() disables and deactivates all buffers
> without taking mlock. This can invalidate buffer state, including
> active_scan_mask, while a buffer-mode claim is held.
> 
> Take mlock in iio_disable_all_buffers() so that unregister honors the
> mode-claim lifetime guarantee. The info_exist_lock -> mlock ordering
> matches iio_update_buffers().
> 
> Fixes: 0a8565425afd ("iio: core: introduce iio_device_{claim|release}_buffer_mode() APIs")
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
