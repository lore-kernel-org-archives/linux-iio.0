Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795742359;
	b=lks7gg9PnAny8907aO5KBV04rwnfgSaFLr0laPUFRDndV+c2/F4rCDeoLNAVF1/djasX
	 Ac2OhgRhyFLwbWpWP7NCUmKRm71HZCHlFX2JH53+wsUAoIlGCN4d/8uVO1RJVxnsRzvAg
	 m2doR/xZmKtEkVLdQpEGcXPY31V0Q3IxN1OKejoqWHFsWWznDszr0xamanbYLIJp3QuVs
	 lkkcHnW0UrUzoITdeWlaLaFu34taveqLIHpzvKNU/sE/+DC4r+xpQGV+DWlaxRS+ovAtw
	 Hvfkz7bvE+b2fbCVGSxUs3JhLPE51+hWxVZWIO+4ElsgQg5hcFLV2YmuXAtJBuf4UIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795742359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Content-Type:Date:
	 Message-ID;
	bh=Q3yk6JuBVYGaDg8/tP3a+chRzUs23UDHyDZreRS7jcE=;
	b=psxE7+vuAdg0Dq29q2xrqfPah+SfLz0rNmVp9zpZb7GpjtfA87QCY3DyIJzilcSukXC9
	 E01Ox/yupkKkthABpuciMYsR+qGPmDQwqVXz2Y0yJS7+JOWfQlZOQnfMmiWz2bH0SPbVz
	 I4zc8Bk3GJ5Ml3wqP6WJH6oP5gAPrv2u63Gqp4wAgR2R4RGQ4CsQM9ev/BgmCL82kvKxx
	 f6ajreoIO2kW8SVFuZd32WB+458zqkxj2n620qtrygUbDp2uLfgcc0N/g18q240cF3Ecx
	 uixXYvlFZnxsXAnGmwwViovT3fS2PAcYkhjiN3GtblwZXbuJPThwNXJpNslN0Fs7PFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xXuq0+wr;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6E0606A321
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 01:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB6E0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xXuq0+wr
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-386ab9ab619so10177468eec.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 17:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795742358; x=1796347158; darn=vger.kernel.org;
        h=message-id:date:content-type:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q3yk6JuBVYGaDg8/tP3a+chRzUs23UDHyDZreRS7jcE=;
        b=xXuq0+wrnpAH7UpE9haZ/+L7MutpZIBEKagw0QMKq72w2hxnPNM7ey4qz2ykvgnKh3
         OSY2eJOIeJNEdomKUvdn6IvJUIUXnrkNlS1b/x8QfMNTTtUTCu5eV58LfwCL0eEOJkDn
         VPfUGiNs+WAeh8Po1PPe3c3Rc3XT7d0JucL2/13QODYT0LpPt2i9nwwQi/FwI+DIVavk
         1EcA+MDPvU4ktjbmbG52LkbDzWt+LaluPJZw5W9UjZx0+gazIevKPLoteO7e5ZlPWRkv
         7zGCrPzOpqaq4CFsqgZt6AXJQD4NzHmzLH74s8FTl2sBrY/JUD933NYfRl9gXzt0fM/e
         WPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795742358; x=1796347158;
        h=message-id:date:content-type:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q3yk6JuBVYGaDg8/tP3a+chRzUs23UDHyDZreRS7jcE=;
        b=vyFY5I1ti/75zBxncVEdkciGPvO7cJMpTJuw9T9eHltSSs9z8FTiHT6chhly5+0j99
         VVvN+LR4bYNnjsm/8THnUkbwDhL6PlymHn1i9xhzpTLAcBcOt4vVk1sflQEOi2dA0YvY
         KSJkvU5NsTEq9vvT4gIrkAyTmks3+qN+cmq7CAs+gpFr7pZKzG8IQ86Jd4Fm6hICI4Ky
         utGASwrFAMRNYOC5oRw17e/X5uXUpKX34rAf6nl/73eCexkbZb6qQh6oK+zvceG0Z9Hl
         2DCVfCWt7eg6Wmpu1JhxE8EAbUc0MugF5pnXH9soZJd+KMF7S4jbmAn0BVLPO18PAtZb
         ED8g==
X-Forwarded-Encrypted: i=1; AL+hErGO6YbgElY42vWcA7VNhHYmrV0JmMavGljueAqSMdjkkanZiYDN48Wleb9hNe70nlmHLWTmg8N2vlE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8chiPmku5sh+39vaIkaXFMJ3hJAVwiG8d8KlHmQa2BMFClLY+D
	VHPLvKplZDtObVQzsntYxfUoakbBkj8DPYyS8j5d9HvLNkYYBVyJwMV2
X-Gm-Gg: AZFdTZey9OyxmP10eBOS7MP5mYbGZHmYphV4wy6bvIhkWDJ1cWUJcYqC6MK6Uq7u9Dg
	A1IH3TQcA0tI+4IyGFE9IqT0G3Sp/vDKDk8NZvmcQVM9bPlBlQfC1Sp0vWUjpVAd/DQXmG1dv+O
	Mi3WagqpaFH6iFGLyVUUicY9jxHhqjnB6J7hmGgKxsVX5hfISg3r3R4ArFRA6CzobLTGckjBTpz
	087gulUZAa0kYulWUaxoEFehrzJxYZIFLzPzhxQIqtDEg8QXqkBd+QQLNCu583GwOR/Gu+MKHrO
	7BFWviKmbUU+D3z3b8R7z9oVp4++o2K9sbZ71GV+LYvn9FRIimc78TlZxDMsAJsqvnpuNT1s7Mb
	0G6wdxmUsIcatGbxo9rX7WyowBFE35hbSozpHbgvxvqcBUPy9QR98UC76JIWPC/L7kSenzkIbU8
	zqYlxoZFBNH/p0bEG4/ZBpHS38pMIFT12pb6Wt1QN4HatjbktoFMqCOrQLa6bJ6Acxeg9x+KxxQ
	2CtU4WZDNIovgdBPmQvox1YyO72WhLLDhLZTVf+p5HRmf6KXOyyiEE2j8vmABSI5LauA1MfCYst
	cq38SmeBuEcMRZqR9/Eji55pRHEu28VuaaokvdH5TArzG5hCqtlFMIDF/HNGbZN9nXqLsMUPRL8
	=
X-Received: by 2002:a05:7301:5093:b0:36a:31b2:8643 with SMTP id 5a478bee46e88-386992b3f3bmr19402083eec.38.1795742357644;
        Thu, 26 Nov 2026 17:19:17 -0800 (PST)
Received: from mac.lan (114-45-165-38.dynamic-ip.hinet.net. [114.45.165.38])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7fc3sm59524851eec.8.2026.11.26.17.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 17:19:17 -0800 (PST)
From: Ilia Snezhkov <iasnezhkov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: inkern: guard fwnode_xlate with info_exist_lock
In-Reply-To: <awf5uvVpYC72orT_@ashevche-desk.local>
References: <20261125234827.94791-1-iasnezhkov@gmail.com>
 <awf5uvVpYC72orT_@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 09:19:13 +0800
Message-ID: <179574235369.59467.3738891359915793741@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list

Hi Andy,

Thank you for the review.

I sent v2 at 06:06 UTC [1] addressing Arnav's feedback (-EPROBE_DEFER
instead of -ENODEV, dropping the num_channels check, and moving the AI
note below ---), which picked up his Reviewed-by.

Good point on placing `iio_dev_opaque = to_iio_dev_opaque(indio_dev);`
right after `channel->indio_dev = indio_dev;` before the scoped_guard()
block — I will include that in v3.

[1] https://lore.kernel.org/r/20261126060615.63790-1-iasnezhkov@gmail.com

Best regards,
Ilia
