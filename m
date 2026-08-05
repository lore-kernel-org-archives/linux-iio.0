Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7494468C17
	for <linux-iio@vger.kernel.org>; Wed,  5 Aug 2026 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932720; cv=pass; b=EWtQCHW/V+zhGsDbK3BYG8ipdwMIXKQMWoB8JVsSADQ6kVJb8KaQOHaJDzHHc+rPYWcWWhSxHlX1nVNIGzcJiegqMh5WtZouzVzuBUOVs7sNCjOj3ieR0Tnbdqsac3IzSquC/zpYGXanOPCCm1fZBL+NCMZh6e8YhC590sGmosg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932720; c=relaxed/simple;
	bh=bFbGFUKhn6hPzcodiVhZG03IClzc3Ieo5z0zEMXtp1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B91H/zYdsiAZGI52J4c3H6VWL3WHhxhT7cqvTWSE5lls4bQYrgM07t/CoyMpFGm4EAMW3PDoWtkeez0ZsVDrJ84Tc/z86xmYBR+zkFCVD9Hf27lUa5FDDIcDjLIGX8b1EGtlgQ3USYydxOT+qD2JTlKo5/WKjp8TQ9TY7bqHH8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G75w+P8E; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G75w+P8E"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4472500e25fso345865fac.1
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2026 05:25:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785932717; cv=none;
        d=google.com; s=arc-20260327;
        b=Wt41qP+2uhhCmtfYzjOSvVRj4gZemtep8o6wGVquES6hGmwks02z7f7PkJZhNBtEWB
         6iMR9PkHEgy7U411vizAm2Aj0RGfxmMhUK7nxdO6KgEHr/MBWR+UBDVzApl058s1pRCG
         qq8ACRu522vbR0nFdcMnsKIVqgM1BXe5wq/xlPe2R57mDtMlQLrJaMUoLpTvVQRYDpPt
         PN+gmvacdFapRg45eB8d21lSY6f3iM4Mfo/3pLoMt6rzV9dMK2CaEabXgEYqfTG0r+J4
         nVj5cOdUlPVtFxpX6247T2cBv6wkCV5Ew1fKQj4c0Ys3ahWrVc/WJSRl8xQhbW8Qwy03
         jTtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bFbGFUKhn6hPzcodiVhZG03IClzc3Ieo5z0zEMXtp1k=;
        fh=8lQbFohyGi5SNZxmnYNyEjCC+aqwFtWEa6b/7FgGCGY=;
        b=Dc+A/5YzofztBeEci88SPFs6qq6jno00e1Nm+7J9urW2g8axUW6NF02K2a0AgEOfuw
         mpch2At5ZOXhGFpsDTcKUC8jDN9/a4joMoTD7r520H57ghGCz1JTXVLzAjr3hFBby9xC
         pKjDQ6j17oWkMMrWL7yHA0OKrUOXOahX9nVP5/eEHXfd1NlysznB2gO8ZfPgoDGh5nvZ
         Z5tjCkrynfGkNhDB5lWVTuNLHdIk1gWrgaMuWKw0NqZvhpyMQKy5tQISs0r2h9Ir6quU
         eT1nbFz6snKnm4pWncE6sto/pKlpbQJB9LszD9PzyU44TtQij733RfDAw3DSpEph15VU
         9EnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785932717; x=1786537517; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bFbGFUKhn6hPzcodiVhZG03IClzc3Ieo5z0zEMXtp1k=;
        b=G75w+P8EmA3U4xKPjOT15VhTqcmbszRo/2ZW5h6T2gW/Un2dethYZf11OtBwEvqiBm
         4Y2t381kXvrLJ5UTO5HAvwAEZnhCZAh0sE6D1IRawpl+/r8UDspE/xr32CjXAqxjXsZI
         fUtPFgC9aWWY89fpBGU7zU4fk+rOnqnT3T1x22gZdGdxXpeKjyiBlpCidaKXGK18y6NV
         eWb+aKU3pDIvuMIPSWYKa2b1rFZWgOHpkiEC+bJXyCHC5+07QOaxy69yZs/lrPBEcHOE
         lBDoQpCGAFkLtPUhafgefAyd9Ed5zy4WbPceYdOW8AYsiqTr3kykV/RGN7xccYj/hB5/
         OllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785932717; x=1786537517;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bFbGFUKhn6hPzcodiVhZG03IClzc3Ieo5z0zEMXtp1k=;
        b=QQYwCp8QkcB4+cC7VZSKR0u+Lra77BdYjS1BixBpuZVpVRqHBfgo3pvJOqK80D+Z+K
         sBo9kRH9b90kSagM+S2kugD5i+4+L+rhsY3HsJTEUbMAa2rM1l94s4XKnnfuhiJUc3Q+
         1wZ1O/TdbyW2J4x+bZG0a7FgI5kL9bAf58uRv2DYG49NYoYgdYSFT0SFA1ngv26XQ/xp
         ReGB4n0K8fcjwC/cYexjAxFG5VE6bzCZExdEZ9ps11UaS/UwQHw5oYVdSriZTdqmiXXN
         eH0QwzKEM3xAP4d1rQhLPoIFWmglEnBZ4MYIpvKGQSQQjyA3GJg32W3aNhDeq/uXwv3j
         CLAg==
X-Forwarded-Encrypted: i=1; AHgh+RoLlZTitm8/Mr2YUBRrylzIO/pEFFvpPG96LkJ/JwfvguzphgmySriS4iMmfcN2/PJ/OdU5g7npS4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTX1FPt8A8B0kWEE7qUby+s/Fh6hyO4tPs3Q0Ne9BSMQumopqH
	7QyZRppLLM+9vJIc/irC2VJALvLP6putxz+affuyan6ZAuJ3R5zEKlWe2YL5SGD/utPG7Y+VFS/
	Jjuv1bzXOPm3lBt0rKwCnpxtOO0oxn9Q=
X-Gm-Gg: AR+sD11YQJgbTJKvTyCoRXuWCnPlDe9I0BZv/w2T/Xv3MvfWUIl5omm0S8rKo6js6BI
	c8E2RGJSJvZxToO2uByL7akqAGKewIp5mFrhcCUygqJv4xLkLJbTN1RIDA4VfoEjs5cAjFT/gKo
	1aUjWMiQ/3GU/FxUwZ2DOVCO/6UzPJghz1Kb+pR3k8opUgDbtY0ugN3zZPrR8oF8woR0+FZxbl0
	X9Eo4p7EwOdfnnVJQ4lN1coPFsp2Qw8Sf8EzSWDrHMuxll4dlfABEHzGzawEh85CW5kkQ8xAR8+
	vvxnklO2XvEk3WNwTSIdFpcV1uBdOdsn2ycw/8D81rB3IA==
X-Received: by 2002:a05:6871:4714:b0:456:a154:67ec with SMTP id
 586e51a60fabf-4599ed5a979mr3365318fac.6.1785932717650; Wed, 05 Aug 2026
 05:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803134346.6733-1-abdelnasserhussein11@gmail.com>
 <20260803134346.6733-3-abdelnasserhussein11@gmail.com> <20260805005909.3137c74f@jic23-huawei>
In-Reply-To: <20260805005909.3137c74f@jic23-huawei>
From: nasser <abdelnasserhussein11@gmail.com>
Date: Wed, 5 Aug 2026 15:25:05 +0300
X-Gm-Features: AUfX_myum6W_arZFRJa-W3k4H4Tmr9edTmhQd7oJfRc1q-qsOtlGpvnYGgLYS3Q
Message-ID: <CANpqX3bQP0TT=q3MU=kDwexAVHg0QfL3_NQt9aMG9gWxS5dpSQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] staging: iio: ad7816: serialize ad7816_spi_read()
 with a mutex
To: Jonathan Cameron <jic23@kernel.org>
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com, 
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for the review. I will update the code to use guard(mutex) and
devm_mutex_init() in v4
