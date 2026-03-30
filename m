Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30753DDDB7
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894505; cv=none; b=R2Xc59hqI2lhgGsRbnvaikg9qof1hXQDi0Wbb71hfV9OCt3z0/RmjjVoXo6WpvjSvTczftux2g9yHlYuACaaYq21zGb0DaV3b5FPWZdJjQqRqU6gScF/5DmiBpVAvM6737K2+KR9jgq0yqLQwI6YobuZ46oggYWPTLuMV0fy00A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894505; c=relaxed/simple;
	bh=spNuFOEOYJqTVx5bzfB89ZGpdbeaUFcQgfpsAZsQITw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ncGIVmzn4XBgpWvJ3QGJvm5TRfpqnILDKrUvSjXUarpEMLUbscy4AepSq8C4pBjAKoOqC4ZIL9nMzFz8vLhZSW3L7b1i++uNsD5kZNBWFnzOzojBWX5V7r97fh/WlyIj8bdfm7c8WsPXTkxR33obdq0DqKy4mjmna8ZZPOHZrPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZD60TLT7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZD60TLT7"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-486fe655187so62863715e9.2
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 11:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774894502; x=1775499302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spNuFOEOYJqTVx5bzfB89ZGpdbeaUFcQgfpsAZsQITw=;
        b=ZD60TLT77PnNADtWQzUZxfeeKsI3cd9ZNVVGIQaAA4H8HuM1YOFM+iHmtQVxV9fEv2
         fAOD9vzqFgJbVBu6vu4nlYsBRm9fpNUYnY2zttMTo1U6DvaqVgB/w3G+s7PS4YUcY5kj
         +0/uCVstbk2eL5ztA+dCraUhYrb5xcUahoUUiLhwMBohkHAddQQel6Sh8oWRvGyGXzKj
         sHB1RBAnrr0XLpW0UCra10oN9dI41LTL3amUqI4C1EAJrMectyzq+jl7FfRQQk3bF1Co
         0z7UZb9BJRSiSAxjilkqlScklQ7+Xm32r32Fi/jFv6XdON6OHf+Z/rfnE9c2p5a0P5wq
         LnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774894502; x=1775499302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=spNuFOEOYJqTVx5bzfB89ZGpdbeaUFcQgfpsAZsQITw=;
        b=h16FvX4J/im33us9VIEMnYqN/MKcVcbjfLrCr5KNQfMJ6pQqAw8V+DfvnSigsaLhYR
         NMaZrHh0wMI6S+0+yTkFCZ2So4BlzZXoT4CFycbGAcxOs92JFzP5DL/gz1W+83/W+g8L
         Z0sALndet4Sj3c7BY7Jy2c4zsoB/zzPULhhAmzo6IuG0j6m6FE0KVy1N+7jvt5yxWG+0
         ZVskC8kmS6DwQY9iEctuhLsbQ2t++cwb5RZJLnqnLRJfhPGyuzcV4whdELxurW75pmwb
         CDjWnjekKHMZ7+FaCYs+bNuo2mgePyvYr1Q2nsyXJA9NNuZoDBvxx5l0bRb22JjOYT/n
         /b8w==
X-Forwarded-Encrypted: i=1; AJvYcCU2DzDszfoq/xWasa2IMrNmpqlHsuQFfS4Rqs4+2T9aIOFPqtjwfaJAi7PQ4OtIkIaTyFA4ioHPJlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrY2zIS563uvIIM5poASNb0VWdaiAEil11TV7ybZW+V4hO0uNY
	jJrhKjTeG8Ck9JG5hutIHYIdOjzodv6GBg0yWs6B55WjdDtsrYEzakHc
X-Gm-Gg: ATEYQzxMH7C5iFgFnSPGhCaVkPowrh4bsXDmg6x9e5uUmgifyk0BQeepQopPxJzBglQ
	tADKbJdO/Sr+qylSGI2Yvzg7bkEuNOORAjH0Xnc+ekPJjPMP1ziKhGjh0iab8frEpLmWCX3NeCI
	ZCX/giJAU7ZLwwKywkjdKwej34zLE/U3zxM63y8Zyt7QGBhXrnFfz5Z7hGj/kLzsf+62XyMFMtx
	Wb8lGlrwFFjbAecFM83n9L6jrxOfketbT+wOM7H+WGGuu7W9JIPU1HXdWTdy8HPJQ7SqqZCNao5
	ZgeSni3Z53B6LZC3U0kvP9NbDrFVe0kuhn4I0TqXEWySvkwPkKcCnVkO1nN5X3+Y2dd87Wr/Mpg
	G1kPjvZ8NGTxbUHmVMHJWAPi8WK8O8VSj03+QbC/g4Us3OOMrSmFO5RJnemZEq/4Gbv+1A4REap
	AxHpYVmn1ARJEVDyzX49/niSlnTnb7EKkC2AyZhLt0c/iYavVNTQ2E
X-Received: by 2002:a05:600c:1d0e:b0:485:33ad:3c9f with SMTP id 5b1f17b1804b1-48727ef5634mr232294715e9.25.1774894502153;
        Mon, 30 Mar 2026 11:15:02 -0700 (PDT)
Received: from localhost.localdomain ([2001:8a0:6c9b:a000:3437:41ca:45cc:e6f1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf90424fcsm15562433f8f.32.2026.03.30.11.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 11:15:01 -0700 (PDT)
From: grondon@gmail.com
To: andriy.shevchenko@intel.com
Cc: jic23@kernel.org,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gabriel Rondon <grondon@gmail.com>
Subject: Re: [PATCH v2] iio: adc: ti-ads8688: use read_avail for available attributes
Date: Mon, 30 Mar 2026 19:14:59 +0100
Message-Id: <20260330181459.64390-1-grondon@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <acT1CDjDmR6s6iUu@ashevche-desk.local>
References: <acT1CDjDmR6s6iUu@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriel Rondon <grondon@gmail.com>

On Thu, 26 Mar 2026 10:57:44 +0200, Andy Shevchenko wrote:
> But it will still cut the value, so you most likely would like to have
> GENMASK_U16() or alike.

Jonathan suggested keeping the original expression -(1 << (ADS8688_REALBITS - 1))
to match the existing table, since -BIT() caused overflow warnings from the
kernel test robot. Will send v3 with the original expression.

Thanks,
Gabriel
