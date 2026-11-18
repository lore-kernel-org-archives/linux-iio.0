Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794998330;
	b=sfJw5zkSrLHeJeHf35+wbvB3zQD7Lo2bFMsgXz/yCfFngiUrKn+hVMOWRpWCuHWBm/+g
	 sSPZvp/auUTh/y5qISXjtPhZUrfVJz+zJFgxD0BBPTgALO69UfYE9Ng6LvuJEreeWcf+H
	 O6JHdm8WgU5Jcqr7FnjA6bZx7FEwS5uB8zubHZB8r7/g258VvQU5oLSbY+olWNHarqoZY
	 kb8o7ISv6pqe4XTx2WeH9y4XYPhDSrvLOz/PQB1RBaUAKHUAjgk99HM75DlxubbsQBT41
	 XUlj2ovCv8Q32ao/5yIKArJgVXkDVCb+fB/qo5fArNUQiZGIacZQ7eoeJGg5a0fCNlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+MfQLDdx1Y4Bx0U1RxKqtUd7c1coyv7kAuMJ4BK5L64=;
	b=QkCAWeogd0fO4F5zGmobEdnu5wVY8bMwFqOmC6eWbiN9o2aS3gFn1dSH5z3MBXDPKVOE
	 gSTW1d17VKcNenNAsIGAahdVo3SQRKv0cRMq3JvtSmX50NqeVei7nhSm50NXlsaE8zjnN
	 srOROWF9xpcT9zeN5jLb1aTOdM3R+CwN47bw+4WNyosyxZnWhgtPc5Bmkx6OwRe00lZac
	 ATSGjy/U3dp3NT1nWtSfBRwjeEa79CS54tgJWicZURrfGjQza5qPChvjvjNwoXIWiwexH
	 E1EbBHIMp5+HHdJ3vqNpW4wUbi4jc0C9JPlkaYF+s0AlImImWz1w/1/F8XG0OACn4vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YEs98tVF;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B301B606A331
	for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 10:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B301B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YEs98tVF
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-38190551625so1527795eec.1
        for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 02:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794998329; x=1795603129; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+MfQLDdx1Y4Bx0U1RxKqtUd7c1coyv7kAuMJ4BK5L64=;
        b=YEs98tVFfaKkt0uY2PI+a8myC6B86fvsOY/NyW9W6/9KvbR62cesRhu5ia7ZPyH0Hf
         hYvxVw+USd0Uq8vPgzcEAMFr5BX2twu9M17xjE7uYyPHZGiKt+Dk6G5sTKCxD92arsVa
         b7ULrRMEE4j0OAGy0Y9yFGXaoKDTro61K3A7bC48WWb9dsaeLGjjR+Phquv1hyV0JfwU
         cXo0t7ZEsjgWLmXRtBa1IUypEAnlFBRUWDZpzxnzEcHb8Ku9KUZWrIwZ6s0SZdZ4slfI
         i6is0DlfQqe9Po687kRmGrTFramG7vn0DEFylmT0Qs3bHaFm5A7a7fRpT4j/3uSE4fcB
         t8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794998329; x=1795603129;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+MfQLDdx1Y4Bx0U1RxKqtUd7c1coyv7kAuMJ4BK5L64=;
        b=0dkdzUQK4Sn/h3YXPXtRjhnLzmEmKHEULFOheEJSrYVg+Q3AGU6mFwolyPu7yJgF5f
         0OVxFjGcc+ZgM9w8hJaOP5fhb5fj4u8lmtl0/gvPx3f5oTwBdfUROHTTt1olsEQqTclQ
         cuqe+Sq530s6qX0STm+3wF3ofWJj9yIKK9KYFFsfFpqST5/nQRuQroc+1g58zfsWjB2D
         uqoZooiIlVGNnitGMO52ppU0ACG3lVEtw0HlJtOnZQ01ec0+fMjtAdD4p8BNX7UO8k1/
         qJ54+nTh55qCAuUy3fI9LH4tWeFjVSDkvYW9G8yHYEtUwpIeHjfSyPguCFMEwG2GqFE0
         7drw==
X-Forwarded-Encrypted: i=1; AL+hErG1wjoFJ6POwFAgMeXOQwZOyfH2hBv5SoHbXwywZ+HpRXgBEtUp+HInel+ZBr4/M2VKCxhr+t+9T7M=@vger.kernel.org
X-Gm-Message-State: APuU4Z86kRmTfetfTQWniNmlbPestV83NRUJq0300h/7qXv5QKlIRFn9
	FPHoEsNiP/VYDWS8YKmbBEQiRzKlSmCnsErJAo9oDjcsTZ6O75Jv7Vt9
X-Gm-Gg: AZFdTZd4L2WrFxBaPuXFLKALWiPSdR5kZz3sVz7s/EYltGOp/AmCvr3LW0ygyzOKUDu
	A2XLmW6VzzGM3fCklVkASJZ6vRi/P17gXxnU81U7goy0KA1kTcYo8TZAOJQlCFaUDtz3/AxAwJW
	wS4sgcPAm1kPwOfB8pCAHhiEsQpd8SoJngc8JImAPAKQgJLph7BsaSk51tGfjr20ReCDyBrU93v
	shJKRwzXEG6qHvp9x4JlpbBlAV5H/qjh6lPQA0LOYPKKgcL5S7ePOmkKbLfMQc7QxC+jj9cFDgR
	An9zekqVHviivsaVMedtRU56h7LdV93b+SdrzuFc8KHhJCMDaKOubymteCk504QFXoOMeWcCR4N
	sQW9U8xgFzhZichnMkJ5PuroRIvaHW6PW1u8265OmDweK0DrjlEUtAhN9w76fSeBtTBunAFShs7
	3/e5mzA5EESctWAflCgnirk5J49iyY1WyMSVx9mqEztlscmJ33R3wqlPhPPiYeY5EKlaOC47Ar+
	N3njnWXSk2O7jc3hfQk6Lpitu1rfzlzhisbqf6HweifobqHnFEUfhvroDZaFpVzQc6H+jJdwEww
	mNgG4yJmvj+Pj5PB4+Fpha1ykVNAYxxgM0gJ+dX5jow1XFqcIeHQUIqV+1Ba4fquBgIU6MjnQeh
	lQ7EUPLxZjUVDyvEkkgopwwWo94uBK8K3e7Yj0SrHOPucFMCn7t6D0NWbh2acHSqudjrVA+YzkK
	PWn4d291thQ3mfj6UpZj4EI5pMQ/BkLOpvcV9FVgSmFw==
X-Received: by 2002:a05:7301:db8c:b0:376:b957:bfb with SMTP id 5a478bee46e88-3828016fffamr2311908eec.17.1794998328713;
        Wed, 18 Nov 2026 02:38:48 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a63054ddsm7433869eec.4.2026.11.18.02.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:38:48 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: bh1745: fix 16-bit register accesses
Date: Wed, 18 Nov 2026 16:08:42 +0530
Message-ID: <20261118103842.132528-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <c2e9261c-2906-457c-a6c5-8a81d87e3375@gmail.com>
References: <20261117110327.198084-1-kapoorarnav43@gmail.com> <c2e9261c-2906-457c-a6c5-8a81d87e3375@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Nov 18, 2026 at 12:31:14PM +0200, Matti Vaittinen wrote:
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
>
> Thanks a lot for hunting down and fixing this Arnav!

Thank you for the review, Matti!

I'll send a v3 with the linux/types.h include Andy asked for, and I'll
carry your tag.

Thanks,
Arnav
