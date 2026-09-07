Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE90382287
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 06:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761314; cv=pass; b=Q45j3hPSkJXGVwuoVreNlucip3xssoPAFUDiM7FFu9qsG4YwZAVC9EqBNlPgTEtQN8R52vKCRI8s2167TYTqtx4KKlZ64Xx1XlvwUQzPEVI83w3d5SWjnjeC6ladJiK6cEBSpST1GLoo6MGQqY5lvTxV3f0yqz6/hy6DtrAuWQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761314; c=relaxed/simple;
	bh=D52xDxlcqI/RQ3ynxyqFDlEyKqGQSfoIzfbY99oQqZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2AnFjGWP/OnJo+OxyhlwkaIbFVXJUqymniEe6ZV5r7VzYIb/7QMkNi7JJtD5onKLM6bq2UAk0g++EcPz8kJ3GeW55pf6Y0uPrjd0xEgwy4g8oXo+YRO462Yn6V9+RjbOeWy06eWqzB0bY9RUnaZdshVcx1WljR5dYTOhHU0Qi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oU8RxX+Z; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oU8RxX+Z"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-451a49abd8aso2996275fac.3
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 23:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788761312; cv=none;
        d=google.com; s=arc-20260327;
        b=kva8jvX2lqjtibs1D6S4QlIdy6eFTpU9Iou5C4f6VGdIm6LEQrtwXfC/Of5UlVCBGA
         E+nHjpFhGg6n7WFwQ36pIZJtf/K3sXjesqCpfT9WlGdTTak2IIgL1a4WP7cMVFOuO9Ny
         Q0RhzxJyS4VnKYsp4pR+MirWCO4dMIPTqbSvAzF+NVpb287QAhFd/wL6euErhbdtp6Wx
         mIEcuOQyndNYUsn3fWOBZFNJuLQLifvFzbeQURICs7sTWmXcAfH8DBCRd2bX90LHP8G6
         RlH3mXjnSodJaJHvy+UwwLoEzPYdVXG29zfwDSbjaFp+Bae5iA3oPyJpR3gIoth4XTck
         1sjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=D52xDxlcqI/RQ3ynxyqFDlEyKqGQSfoIzfbY99oQqZY=;
        fh=zhNrFMNf1qWir0QOTxHwO8thVRJ1yGRoFtS49GLIHCY=;
        b=qvMO5F0W3j38zj7EhpwyQIuFMQJ6SbJ4XkNS1yFKO77YamKw+suCUZuVcMEdiHOxoD
         zrGBoazicm8eY45A56wVwHgXA9oNQYuIIJ7p8dfEKO/AbSaV5SixThyHUrRGrAQQOHEr
         MxKFyNxD6BvhlcROBwUny5DCBJH548+S0K9NFMlL3k0CehAdTqTVnoUhoTEPBzbSFqYU
         SGGPkIddfaCCFS1Gk87dsU8G7g9DO+pZ+CrQ820xzHTr1ixWJiaEVctD0KR8g2g65wb6
         dGbK+OGUZMhdaSBDzNTq1AXxrz8dDJMggUxDGx4hccUBEwAsFNe1vxJhCeYJkVXBKnTG
         YqjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788761312; x=1789366112; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D52xDxlcqI/RQ3ynxyqFDlEyKqGQSfoIzfbY99oQqZY=;
        b=oU8RxX+Z/79xcCIJo6uGLwYD6wz/miNCy3Rbzuvalaex7yJZt8O7+FM3J65AFO5r90
         hYyi0z5ZEwyBGPiki7u3PIEJNOlJPUnojyVFVKJ8aFhB/KEYy6A5opmr9GCk1hxpx9oQ
         3vND4kGra/xMI81dxqeAZq880XCXMOAvWXPMqHgM8fWVIxo1ZY5anuwGzq4wrMxUQW2+
         6HZDjBgEJRPyNWqkYArxcFY0zQ8sO+dGgHtoZqajlKbUpUESZHWPCWK+lLtHEJ/8olci
         3RghyLIJfXGbFK+bkZGK6pePjN31f0HruQ11XgkD5iyeWt/WcUC31uNQiCIMbyHYvmIs
         C3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788761312; x=1789366112;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D52xDxlcqI/RQ3ynxyqFDlEyKqGQSfoIzfbY99oQqZY=;
        b=UxGc/OaDFwHV+6Sr2icWYDh4JmRU49OUvCO5nMXVJCg+9Wy3lvM6e9R1Mylfwfq6PS
         DjVcvnwHPOlPwvdhwTuSlAFBG8DJ0kTkR7tLXxP9YGApqLtamdySz4tKpnu12Pt57V+0
         GFmER3ZZq9M7wxKBy67/k0FlcKBmvg4u/LFNh7kR/I5LroofgiLCBzJJDQHlPu982S++
         joURRJaF4cbn8Ef1CMAy9lXqXHaCR2xCHkB7bPXfG2uRpFwXgrwN2Yy0X0+tZQT0pZyW
         Na5hlZXG8Q7pjVT3lqnyE5+ojJqdQpp850z6/pVn9iZRKZ6gXJIu41Aq6mFb74Md0/lS
         tXJQ==
X-Forwarded-Encrypted: i=1; AKwUvByVOE4J2JZpoVbwr2bb6ixqkZecQXdI4IwHhGiqcYmD6t7wtHmlMB9hosvt1rjyYKGIZEisANmQEeo=@vger.kernel.org
X-Gm-Message-State: AFuF++nTZnpLdU95y30Mc63s1wN1gQhIuexDcW5/JkMEfgfIFEIRoxqY
	vzGzeIU4lk7Ssps+DffXlaG02HFmXeGQqFgUjfjkEpgXTZuIt8OgzuMFnZSmZKpmus05+cLFIMs
	m94e0V25TQE6q6K5AEIMK4u0KH4OsS2w=
X-Gm-Gg: AYBFou0pTa9SbjevU15PDccQTXQXONa5K9xaXOH5JyUM23/ksX52AUjGFV9v0jNmyB6
	xdeuaRcE1gRnG5wEzpjp+m2MN1F4WXBU1ak3AxVydIXxRHW2KybJRktbqRgY56OFHzDJKf9ex2y
	uTHa253QBBIpcBzp/o8WCbKKHlSrbfGmeHDfj+93TDjZS+eNzjz+hHi8ij+e4Es6aDjsMbxGwzE
	Ci9xRsZuKVYc3EPznQRGkblmtf2ppIvRb4VXUkkXVXwmN339gHGSRKlE4xjc4hH4X83fXF5F/EJ
	MuIlXSnwd4n8JW3EJSxmo5o4UgIWiirnqpeFcZDcHOWSbQ==
X-Received: by 2002:a05:6870:3210:b0:46a:6e07:28a1 with SMTP id
 586e51a60fabf-4755135293dmr15159931fac.12.1788761312125; Sun, 06 Sep 2026
 23:08:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906114049.32912-1-abdelnasserhussein11@gmail.com>
 <20260906114049.32912-3-abdelnasserhussein11@gmail.com> <20260906185025.6a0d1240@jic23-huawei>
In-Reply-To: <20260906185025.6a0d1240@jic23-huawei>
From: nasser <abdelnasserhussein11@gmail.com>
Date: Mon, 7 Sep 2026 09:08:21 +0300
X-Gm-Features: AcwNN1WnirY3cqNKZJJwKb645fYo2XIsR3KNHFtMCzd3d6BaT1y3Wiu5R7VGG9s
Message-ID: <CANpqX3Y2njgY4KbJmfa5WgJ6_WpfeC1=xRwnj3LUUiZphMxFLw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] staging: iio: adc: ad7816: Use DMA-safe buffer for
 SPI read
To: Jonathan Cameron <jic23@kernel.org>
Cc: gregkh@linuxfoundation.org, nuno.sa@analog.com, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org, 
	linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

Thanks a lot for the detailed explanation and for taking the time to
explain the underlying architecture. I really appreciate the mentoring
and the pointer to Wolfram Sang's talk; I will definitely watch it.

I will rewrite the commit message to properly explain the cache line
sharing and VMAP_STACK issues, rather than implying stack memory is
magically not cache-coherent. I will also fix the misleading "correct
the sizeof" wording.
I am preparing v5 with these updates and will send it shortly.

Thanks,
Abdelnasser
