Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795742614;
	b=glfexaH4U6g4c8gHVAGa5WH6Q5xYOQaVV+nitOJ53nPHGZ22kyHaDhDtLgesfBfd4Msu
	 9+Y6C7b+GRUDzJqp3rNmtBVaefydQOizr7gBM08dGiRtCGD6QT52Wl7aAbpwbTOt83giT
	 57T70WmIc3vrHqXmW6g8sSpmDdiG4C5ZAMOu2ehpkOF4r+UKwp7o0HBSbRH8RFo3lUp+M
	 KOh5W0OrDhD2pwyyxd4kZpcFIOOSzXJglXM35r0tRCKZUSiXS5+h4deLc4bNFGpL19jph
	 aPqXoXv/vl6ctQrd7Nau0fMawgQtjtbd5DrJAY1RaPIrNL8mQ52rvi0DUNsSOL+OZgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795742614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Content-Type:Date:
	 Message-ID;
	bh=m0D3Y8mkojMn8kpD0m2n9BecyssVqApB7/PKctN5U4c=;
	b=a3cK3wpocBCeEtsQ8NSLb7MEk99OAVH6qwLd+GeqAnltr3wk2ckKNeOgQDpUMC2AY/zm
	 M02z/2EV5Hl9YdhiLrCJKycGHAPvHXCkksLfYNmJgAZ7Ei18zm8R+0pX2sTVcGBYF0qWR
	 02GtT926DjwSZz8jdeEIRB7GiZGSnZyOTljjN9JKBXwTUIe461bxtgkvAsQeN2MhR/B8x
	 3hbeOrsfDlDE7Jq8m0UCu2j7Gb/LtAPVm3PanwYnhvEN7ArVW48VPmY2yb1XSyJVs8HhJ
	 wQ0qTctb1GB527SDOqr1KjZd3tAIZls79p9w6qgeu3WzXrYCqvq5zohGGKOydNtJYsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S3+k98PE;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C77606A31C
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 01:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7C77606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S3+k98PE
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cde4b4e936fso3644195a12.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 17:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795742613; x=1796347413; darn=vger.kernel.org;
        h=message-id:date:content-type:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m0D3Y8mkojMn8kpD0m2n9BecyssVqApB7/PKctN5U4c=;
        b=S3+k98PEmDcReVHhonVbTr7m1AGY5hbcvkj/ef133v9FRCmT/uq5AVtj1C4iCXMI3S
         c3FrM6h1jA8knldRkHlb7KeZVX78ZsXrEDFKDhGnqTxAhNojHs/pb2GmzwFHqIjr0bny
         IesnzHAo5lN3pzQkOw9nMPTsdPwr6tdKYBm3ynW/WVj//MTNLoyHcyvmUO1lfTmEMPqY
         Exnvi8aC882m8A1LQin8y1VVBWVLrYQdREJ1Z1A+zoRjxskFGKAGdqlkZbjM0wO1xRN5
         XJmwLNz01qWUQ/vpA9xuSGziMFvCWzjk7of8Di63xXzri6J6oQN7DnHeeqfZmpEEs4ma
         rKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795742613; x=1796347413;
        h=message-id:date:content-type:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m0D3Y8mkojMn8kpD0m2n9BecyssVqApB7/PKctN5U4c=;
        b=1WINEzjE/r5JN4j1h4fycrJFrSWg1j5OVmYT1fCNqKqdOqh11MZNR55tKQDS1J8nHs
         PjXZRuYcak2IS8mk88oLlc9rl+PVtA31M9DK2QrYOiKB6115ajjsay4DAthM6YF0Gblv
         8xrWtMXzrxHPEx4a0AjqD0t7qfVeC3BpdQU3UgqYIl3soa047midJ7cAd+l4G9JRqW2g
         N1u6N2XUu318prVnQegScuqOrdHVniq8fEhmQVvTk8vYXdbD105M56WU4qfT3y71vKDz
         Wr+KmTLhVmwl4vOpc3f1zABN2fnLcvRrVwHQ9is9IgyzQd5ZDMNg30ZC2gPK/SRPuLwZ
         wYDA==
X-Forwarded-Encrypted: i=1; AL+hErEb+fXudg5LT8V7gebN50xlLCiDtRTN/sRWKUKkcNAOQ+pvLt9GPJoJyoXgfaZSwQ2q1NUYQWwui/M=@vger.kernel.org
X-Gm-Message-State: APuU4Z90MwHyoybrXo7Tw1HVfMS+fwRNNaXIdnf4BJkA9ieXimlBpzsB
	DT6MMS3z86vwKkCNSf9PWki+H34Jdhc5ARtxPD2kJKwiuTT3pwaR8rxM
X-Gm-Gg: AZFdTZfokd5jNEbg8glrk3XUPtAsecDkcF7mI2A4G5nJaxhbwyihH4mz5QYChFinv/o
	7D+OD4yfZY2efb/HPa/zXrt1ESkmxngM20RPnWVN49nIMpAyyfwKMJrwLzUgfGO00WZGcPCKSic
	VK+R+PjA8HvqQDs4KKQ0n1aW8EDCGva+b0Z8jdDcF3SEQoyUwB7Py26QyzLuKpSI6cTLV8bkqJH
	Dpfrvp4gs7RHo3Tv4Oae57aDnTTwtW99H6sP4qINT+hQ60X8uGdqYl9OGnP8N3TsymVtTZmSbMN
	zatmjuu8TZPsLNo9UQkupGznXVK0nY+3XAuTvaEjLywvlKg8LWuUW1z+jf/jnzJfRT517lTSuVp
	F3m5/F4Od8jZvMXT82HfzRCzD7yowLmlqiUNomQU0rXGWWHPp0Z3+Q5RM35CAp17JXk7Q0ie//M
	6igPiQDYFgngZPOcgvIMt/2KxqEo7rM6brjK2c7oSgl9pkbZ4reLXuJt2W66xGtHQLbcjVP4dN/
	DkEGDGbzMOXARv7Q0D4z1KHLP5s7Q3Yb11sEMPXskaDK58DraujDo/stG+8gHv0J8VTsYJLq6US
	Br5xEWnQJHgVsM1pwxCHsvrWwJD2Aosx38XHa2sTRP4kILfapD5u0SjdlNq2+h/+YUMv09A3GQA
	=
X-Received: by 2002:a17:90b:2e4b:b0:3ab:330d:6e47 with SMTP id 98e67ed59e1d1-3b41c8e0ce5mr14432697a91.10.1795742613003;
        Thu, 26 Nov 2026 17:23:33 -0800 (PST)
Received: from mac.lan (114-45-165-38.dynamic-ip.hinet.net. [114.45.165.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40578dca0sm38459035a91.2.2026.11.26.17.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 17:23:32 -0800 (PST)
From: Ilia Snezhkov <iasnezhkov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, Arnav Kapoor <kapoorarnav43@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: inkern: guard fwnode_xlate with info_exist_lock
In-Reply-To: <awhBEfD6I5nakCKJ@ashevche-desk.local>
References: <20261126060615.63790-1-iasnezhkov@gmail.com>
 <awhBEfD6I5nakCKJ@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 09:23:28 +0800
Message-ID: <179574260890.61388.10862990171445957182@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list

Hi Andy,

Sorry for the confusion — I did not ignore your comment; our emails
crossed in flight. I sent v2 at 06:06 UTC (after Arnav's 04:59 UTC
review on v1), and your v1 reply arrived later at 09:19 UTC. I should
have replied on the v1 thread right away to make that clear.

I will address both of your comments in v3:
- place `struct iio_dev_opaque *iio_dev_opaque;` in reverse xmas tree
  order, and
- move `iio_dev_opaque = to_iio_dev_opaque(indio_dev);` right after
  `channel->indio_dev = indio_dev;`.

Best regards,
Ilia
