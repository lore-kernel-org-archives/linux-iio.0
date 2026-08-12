Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D42647143A
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786559237; cv=none; b=NvCgMTA+48vfV2ld7YUyC1aPmVKkmJbq8qPDrXhWVft0Ga1smJH3M2d4WlI8LX8mgTyK6TdyACVJNnkRIuY1+p9jjHl8/Sgysb51Zvby2SqMmxmETyQY1xUFhddREvoErwrSJC9pxeJQ3mL+zWYyJ6G8DCgURWrXRjemPxfBwA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786559237; c=relaxed/simple;
	bh=Nu8Ru3iuSZZX9SpYcbORNiVzGWTxhVBNzQvuJQZ4cFo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X3On1y/mdOVUY3Pr5AWNaMgHYq4K1VrgT2i5lInqRcjEIRRCo4rn6eJlErv9R6Ii3BxRdHiKxyGrxYrf5JjlMgbm/2UnAlx6S4BMdcnabaHZJiuI/k9PSzg4bdeeP3gySb2m99H/tjtzGp3fcWYHAXNcNCcVuwahx2xowsqpie8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rp8bWp9i; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rp8bWp9i"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c928bf172so6516361cf.3
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 11:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786559235; x=1787164035; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7j7z3tqC+AIDzOQzM95h2HCshoUvxiPDxpv6LnHwMNs=;
        b=rp8bWp9i/Pco9rqLD3vXeW1t7frTabhc0fYwbGVwXM4sKJ+4NfZ0F020YOF5dw1w4O
         31yNqwnOn5ftUFjYJOq7tg9MnjI21F9oT7B1jYRrTLNKUSc7ErOlCqJqQ5BVv8O0XuHc
         Zah2M5lA2oUpPb/sAOrWz4OXvPmL0Qrbd0R4bramsreQBO8z7zEsOLaT49V2rBniSIMS
         N2aVLKnlA4i23wN7gTNlc5joNXcfXmlplYRlxkkAekEPdx8yQqGKfnoBvPtN2V9NnQKy
         S42ZUy0Y++RHQMWlYUbuQoTNo/sLCIiP6Txv+S+/Ug3fRhhrGSUtjm0hyl0N9e/U+P1H
         PIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786559235; x=1787164035;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7j7z3tqC+AIDzOQzM95h2HCshoUvxiPDxpv6LnHwMNs=;
        b=KdbgYe55cmpYzsqHFJAjz3BTCBq1IjJE6xj2zp9xT+eVmAeMFRHwEm4XsrszutqfXM
         fCSz3TaL9ZzMcpEEcGyp8YDUN4lQSJMyLAyd9pX8hM35HnKKPYh9t2zSxXnC+f71Un2P
         G0a41B5pP7zTuxzmGwHf9FtqbYupYbfnTWkZaiJskbJygZdb0fZHr9iMoABNEN+jsz1i
         fsGh9aJsZWc1Tts1VnIwz0DpXaZSYt7kA534w0M9atDwrgkMeKyb8xs/E5ZUYvMQk+cV
         KrWSGWn2qieEG+IdaIwj137sp656OjSn72UGCphMmdsFh/xwF5Y6UXVfsiftIhn7dftW
         XAqg==
X-Forwarded-Encrypted: i=1; AHgh+Roe+VtUjAjbLJg0zhUZzJSnjLrVQW0ebFGrpwxthOiuLR26peoCd5D/SZGW5CKal1g14UbqKv/aTYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ19VkFaKcCIQFrLyxIsbSNH78OOIIrmVuBxqeXtuT/0QMPhy4
	Gt+tp/4nZStcLarwkOzBkvkKn/vSvWPXfZV0l3sPEbOJSka3SDgHSKPd
X-Gm-Gg: AR+sD11nWXIkZgWnuXHhGlxSnMQUSlF6EUGuVOfqg+zoJRL23vcZUzqqJUDdG7UPxbk
	kUSYCq84gyy0aY5jCjexrP7CVFTMdpM7BPNho2AoyOb7qEwRlMe/GnnvnGj8lZVkPSdfURTx2Gv
	tz4rawBsaauq8AnozRi4x0RnRdw8OLDev4PbAQFLbj3K3i0Ac67PwzrRRSqX4lqu8/S2Xv1BQZt
	9gdID1AvWqTXHHW0DEx9GzGu9vfwUWVLaS1+FRo8TnjMFEKQCsWqNXLiB+XDjhW/G4KNRQdZ+4o
	K0ZGF5/w04WZTmNFdrAKdtwrVk/Tw7s1FnqGnL0k/kGjLd41rRqK72l1FxZJ/P+sC5pWPFIhJ6p
	e0H1XgNDJj7thG1lYF1AfTlfMXOI6DhpEI4r5iuK7xr2JgWy93uctLTcNvSa6TGWhWoYd0BFpIV
	3YMNmwIuZrDnwHW3kM+DwYXCJoq3CVLw7hAjMtdpNg7kIu+TEAF8x6+bCf+dsPwY400Oo=
X-Received: by 2002:a05:622a:1106:b0:528:15e:d1d4 with SMTP id d75a77b69052e-52d73be0ed5mr2122511cf.4.1786559235087;
        Wed, 12 Aug 2026 11:27:15 -0700 (PDT)
Received: from localhost ([2600:4808:5693:8201:bb19:d9f0:6e53:91ed])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d73fde61csm74641cf.21.2026.08.12.11.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 11:27:14 -0700 (PDT)
Date: Wed, 12 Aug 2026 14:27:02 -0400
From: Marco Chen <marcochen.dev@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	matt@ranostay.sg, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, pmeerw@pmeerw.net
Subject: [RFC] iio: health: max30102: proximity power saving TODO and
 datasheet history
Message-ID: <any69uXah07eA8lR@xiaolong>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The proximity power saving TODO in max30102.c was added in the original
driver commit b3c590ce14b1 ("iio: health: add MAX30102 oximeter driver
support") in Feb 2017. At that time, the MAX30102 datasheet documented a
Proximity Function and Proximity Mode Interrupt Threshold register. Both
were removed in revision 1 of that datasheet on October 2018. The MAX30101
datasheet did the same in its revision 1 on June 2018.

That also explains the PROX_INT defines in max30102.c, as they were
correct in revision 0 of the datasheet when the commit was made.

Since there is no current documentation for the proximity function on
the MAX30102 or MAX30101, I don't think this TODO should be implemented
for those parts. Does this seem like the right decision?

However, the feature is still well-documented on the MAX30105. Is
proximity power saving worth implementing there? I don't have a MAX30105
but I am more than willing to purchase one and develop and test on it,
and I have access to a logic analyzer to verify the I2C transactions.

For the implementation, I would add MAX30105-gated defines for the
PILOT_PA (0x10) and PROX_INT_THRESH (0x30) registers and handle PROX_INT 
in the interrupt handler. The MAX30105 transitions out of proximity mode 
automatically once the ADC count exceeds the threshold, so PROX_INT is a 
notification to start getting data, rather than a mode switch.

For the ABI, I was thinking of using an IIO_PROXIMITY channel with an
iio_event_spec for the threshold and enable, similar to what was done in
cm36651.c. Is this the right approach?

This feature would then be enabled through the event enable, so with the
event disabled, the driver would behave the same as it does today. This
is important because with proximity active, enabling the buffer would
not produce data until an object is detected.

One interaction with a patch that was applied recently [1]: enabling 
PROX_INT falsifies the assumption that FIFO_RDY is the only enabled 
interrupt source. So the handler would need to distinguish between 
causes, likely meaning that max30102_fifo_count() will need to be 
refactored a little. 

Thank you.

[1] https://lore.kernel.org/linux-iio/20260808195450.25420-1-marcochen.dev@gmail.com/


