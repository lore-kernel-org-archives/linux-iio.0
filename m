Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.82.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793121728;
	b=orWKYvmVUifEVpJbshm2SAlRHn21FQ0Em33WcBtZy8NciFga4XQZVIhTct/whJmc91Of
	 qKUaDwD7RjhcZi1Ur+RRhCnv2U2XdbJdimX/SkMmEY3+Nfle9sFjRePZ1JA3tIatXnb8G
	 sVXiGpqHq4HITYxgZdikKuS9+cmwgtt1PLX4rTMZkqeJ6LNQ2njdTnyBeB8XuHkDPteWM
	 fce3g3sbkVj6WF4isaWqMjTRx6rEcpb5HdpN6imToSZVCAPn5MbyjHQpxi0KgK7q753FZ
	 bLzm/UAPXT/6MUQiVLw47fVOpEqnUMTndSD7O4hnxIQm14fM91JulLvvvRgbltOw4JQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=sCMHExecnr7EVku3xKOnADgdNnCumi8ICt8RRfPLFyc=;
	b=RvWbF9t4utXzZ1uOndwAUR2BJ6fIj5U43iLG2uUZbNXBH/ynPt2J7lc64Ffk24eKQG/8
	 1yPCGiBC9yA//ndrf/hK1rqpBRBZindqZL6YLThhW/vejIgkguTDu/6qG30/JQGxbsLEI
	 zN6JY2osS2TMO4cPhAGSa/FhTPaIJhEOt/G/oloOqBI827P5urNAjL1h/a9XNpbD1u6FC
	 OzurfqKBVmbfV4qBrUad9zx5xkKaperqvkr5fIvRyu6IcrAU7AEkQjTlm5yB4Dk2nWulC
	 cYCzMVNYhpZ6tm7rBdlnoUSX8ZJZA9J6+3y7RN4xCdY4dgOlnreHz1X9O9zBJTFt8CQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=C41cqylo;
	arc=fail smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495AE606A31E
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 17:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 495AE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=C41cqylo
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-157fe9d771bso60521c88.0
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 10:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793121727; cv=none;
        d=google.com; s=arc-20260327;
        b=SaXOX1bAgVOpGWlBEdBhaVZZjlP5dlC0vwmM9WAaImWtbjbczdX531Owa4mVoi16LH
         RfJFiIQfN5ulmlq2JZxjb9BA2tnC6SxsHpHnH/jvFGTFob1kGuaLnXpw1i+nnYLGSACw
         sliqQDEEGYFAhZtksmEaiOHM8JmgavlhGzSrYuXuJLbw+Ym7wLnQCkpCouKc3osoDuKE
         RRcHc2MKsZ+PO0UxnStctsvEPclVd1LIYHEUjmUFUS6+HHtJwgIC/bm21wy0ev7ENjVs
         DjsLdvosD0mvmJeQHAR5Wr/5We/akVpQVNQjWTfWx/j4fec7qBBTwzFWVd93AXT+mJxE
         0q6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sCMHExecnr7EVku3xKOnADgdNnCumi8ICt8RRfPLFyc=;
        fh=BkzObC5PHWdpBlOxW18gdDres+TN31XsQJGsE5S1RyY=;
        b=I5GJoQonMtauRT5Umsgzi2KrpoVgFnqIeY9hOego8WCSPhwfFqxj5vOLTeZDTKrQoH
         GsitqyDj7EWfG8KvCjCCudlrgRUKtJFdQVx8pVs3gATAWYfw5pKyltOPUijAMev1zFgd
         r85YKKVsed2v+/A8+2N91YzXEyys9vie/K/MV+Yfz45afa7m44eqRXLzetOv+1ShtGrW
         ocBL7Hx59B9x1E0XmVmBQOV7w6sLUj9VsbKX/iNpQc+LQs/n52M/i510lu6vhKcu2SVO
         ZYVC4KQMcEg6K+r+kkihbQbz/suJq5R8si1XQ4WIW5qOrlnbclArYqUV2apWo+MK18Iv
         jiOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793121727; x=1793726527; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sCMHExecnr7EVku3xKOnADgdNnCumi8ICt8RRfPLFyc=;
        b=C41cqyloeS/h5Vtwj4fa7MIjm2aLukQaJNMjA01Wn+JGGCcQqxaMEk4qtaeGLTgF11
         +xXojI6iydcNCHCInBDP9VQyo1hJAFD3dr6yQmpBM6HUXazAlicytsDrwlamPA50lS4I
         ot5PvMH/HWpuW8LsxGwuM5M0OIfhb6YxMmvO1BL7uALyaS3FIvEjHjPJFzKMoA1yF8FI
         hrNTtVklmnbX0GKT3t5upCjaEu9RMl7g31Ii5f+e1EuriC9yJOvccQQtUIHojQFDkmTh
         oSuMUeEQcN3ZJUIM7OREyaxa56yxzKExGn54vpm7A5KxV62XI0nsE+2SOQIxafVeXPuA
         1IkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793121727; x=1793726527;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sCMHExecnr7EVku3xKOnADgdNnCumi8ICt8RRfPLFyc=;
        b=GtUofp4Q4zuhyVQ7WiruNGLaSQ0EPk6XfDz1FwQGGi0AqtGsGav5bj/O3xGB/i+Qyx
         3pL1RGxdqhalVgHum9IvxsTjIwSSh95mFFSwjENCadDtpZSvOp2EueuZab98tpKtFe+U
         g2HU9gz17u95HtyUdlbWR1v/uEDNCcSyFDXHkQHqnN6BweG6gS3hWtOnYfLsWbQ/rQKM
         /e9xSRGBJWsOR44eWN+R7/80g0Q27bD/EYPKyoYo38oFP5U0dEwla/BdKRZV5d83aKpo
         2EUBHFyOdBQNLbTP7OXXRCcf6PIO2t7lKbZ+l+jhYUv3Q4o4kCmIVlyUezJZlKxD4298
         nncQ==
X-Forwarded-Encrypted: i=1; AKwUvBw05VDPGJCQkEHp9tJEjouoE573q/eIS3+ZX7oIY8sRpsXEVfcOJ5jd7AUh5pboiE3HxuIxP5gy5DM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCI1hYYjOPog2KCYR2UTD5ajoDJmpuirZsGFDyRFIgYYGgELxj
	Q7jsAq+4rYyl7smGfrgg/gLew9C8nI+wd7T3mBgcscW/Sz9Jnztoz2Jc5uCre/gJJGVXVqA03Qu
	zxiW6rJNlPsnzZ3ZSiHKXyzuodEcVPBWRlPo2iuwI
X-Gm-Gg: AYBFou1OrnGxo+vLNKrPYel60GUQwyd8OTpaHx+kF5Q+WBXsr2an3WIWUvVZ/2I8V2C
	vq+kyQe1JajnkCXuRhVt9Ug8RJZ+bzBy1zVGbVhX+CO/XoUGwrETk6GbXVkHSa5Ljcks+Mv0Zc/
	1jUWkbEZiKB5aODBiMVyrTBikwNnpCUq9OzF86Fpx12niGi8ZuCGbN6hnDTVzKgQ0W9MCWpDWym
	3mVnEJs/LjOEsxnqEBuZwObRriwPV6OkXyFQUWvmsfc3CTH7fDNBXRqzAEugPnCm5g611aX0+lm
	LfOdeaxGUZwiRauw1mEDUBJcp9s/m8NooNmbjrm4SZvG7rvtgNsp6yB5XSIKXX9UWZl2uLzXl9g
	95U3Kx9SlgC6hRhgzadwh8WBNqsWJH0n9036sIJDSPOnBzGK5Y/j+7JVYTNJoydsGfZnjOFakLY
	k0dSakm3gnDYQ=
X-Received: by 2002:a05:701b:2311:b0:16a:8ffd:4977 with SMTP id
 a92af1059eb24-199363a356emr13049111c88.17.1793121726447; Tue, 27 Oct 2026
 10:22:06 -0700 (PDT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027124954.110697-1-zoone.rupert@gmail.com>
 <20261027124954.110697-10-zoone.rupert@gmail.com> <auDNzWMPy0VQcazt@ashevche-desk.local>
In-Reply-To: <auDNzWMPy0VQcazt@ashevche-desk.local>
From: Marco Elver <elver@google.com>
Date: Tue, 27 Oct 2026 18:21:29 +0100
X-Gm-Features: AclHuK8orvmEUb-f7W0Au_t0jJZW6yeRJKoPRMRQ-D7ejg8oB9UAKvhykKBG7IM
Message-ID: <CANpmjNNNw3Ont87-Uqo_j4YrPbamHLue=EAMkc+B66Q_yywQ9A@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] iio: enable context analysis for all drivers
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rupesh Majhi <zoone.rupert@gmail.com>, Alex Lanzano <lanzano.alex@gmail.com>, 
	Andy Shevchenko <andy@kernel.org>, Benson Leung <bleung@chromium.org>, 
	David Lechner <dlechner@baylibre.com>, Guenter Roeck <groeck@chromium.org>, 
	Jagath Jog J <jagathjog1996@gmail.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Jinseob Kim <kimjinseob88@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Remi Buisson <remi.buisson@tdk.com>, chrome-platform@lists.linux.dev, 
	linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Oct 2026 at 17:14, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Oct 27, 2026 at 02:49:54PM +0200, Rupesh Majhi wrote:
> > All of drivers/iio now builds without context analysis warnings, so
> > enable it in every Makefile that builds objects, replacing the entry
> > for dps310 alone.
>
> ...
>
> > +++ b/drivers/iio/Makefile
>
> > +CONTEXT_ANALYSIS := y
>
> Can we reduce the churn to only adding it here and do some magic to propagate
> this recursively, please? I truly believe it's feasible to achieve.

Should be:

subdir-ccflags-y += $(CFLAGS_CONTEXT_ANALYSIS)
