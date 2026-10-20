Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483184;
	b=K2FAYhfdyfGBFoxupbyvJ7A7RDxInxLgOkuxlQYq4MYlNZlnsMu+KWlV5lPxlZ+gwOhs
	 zc4WtfLQw8l3dJYFusTjkZSQaLBFscmSZBdYiBesaIlBr/0agDVhnAkeZ4OMAQr/f1gJG
	 xg3KrilKZmoiPDFtULxAPwoCW7h23iUExzdVW8aA7Qh7YNR+ZdINq6Ly7BOu65PdLMYGj
	 new3B5oXkpEXaw3eTMQ5PgIrO9kw1e1qLW4ub0cGEWIyrrK24USsQaZzzlLsNPKu51yov
	 lvAUk4mdtpJALB5u51qYRO/goZnUhl6BlOVasciX2WsMDHL2f0CzABhkimo+gdbpEEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483184;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Zg6hXztxm57ZgutA6Jjq14W1datgteH45TcPMGjkBVk=;
	b=JZHCMhfBg+n3TDrUlcaYNEtvlpqsbqg4cXebeCEK4Vl6EXcHlN/cvQPzMKHosY8lERm1
	 RiVdhbhvdv8uJbUuyf5HASI5CM/bdXYH6XOOpTm4mMXezgD0yebGGwZMBx6wS7cHRdcTw
	 7UKVqpTE5Avco0BxMMsnRavCRrI4gZaiz152gpfuTbHQeKqstPS0JW/HJqB4feANJmrD9
	 PYKce4xcbp9IZTXfghHmHI0/NX2AeYNSMcgHxr8JUMGgx9ohK+X8gmSI6R0sPZtlY/Uqw
	 eUu/pWXO/ZKGxGn0/iC4B6QTc40ENwXVAwm8LzLaxwgNauYQn+TI/loZNnLKFu1MVlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="JwmVh/q7";
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F13606A319
	for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 07:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13F13606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JwmVh/q7
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48df4e9d2d4so1831068f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 00:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792483182; x=1793087982; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zg6hXztxm57ZgutA6Jjq14W1datgteH45TcPMGjkBVk=;
        b=JwmVh/q7XOUjWXSlgpeq8sAkiSMaBdn3GXJLLjO8qoXyBD4SbwvvtPxNWN6uFYwRZ0
         f/OVSJ90CXZL9/zm+iyQIR9WqMW+TPQObWw93zga5hurcvvBY1EA4GuqTYRe/zN312fq
         WFt3n3k4+ESrjovm4maAWgY3STD1WzVjC6D9ooJzqfhhYDYMIX54vyOvdjEtjH96YV6v
         b+DssIoLkkVtFCQkrG5FBN9kdfUYIKFpJCo8qmsIQXZrV4zpcMpkBro6Jt8/2WhDuS4v
         xka5AsFJlx6B9xZy9p8a2yQ3C2XvPCwPbHLdIU9v7pC9udK0+SVVPuDx6iRU0hrMl76Y
         ML8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792483182; x=1793087982;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zg6hXztxm57ZgutA6Jjq14W1datgteH45TcPMGjkBVk=;
        b=XxMbPlHfeeveuF61wMDZnT/BCrQR7izFqXlC1FhbmOv74iZjDiN2IdgJSyeUAqZJBT
         iab14xbb7bZwhByc4wRejEXeItaC5+VAz1MTu2Q2VUmL91y7OtvmTDjv4SISlfwe5/XC
         n0ZNj6PejiK4wyBH+L3adLiy5/l5fKGeZoGiUrE6L587fNoKikViaUAiZrcAAqox8vv+
         QBuJiS3Y4jxUf5ECcU89iYdw6F3J/YT8gcpD3g/7gmdYG2GpTSLVeJ29840AJcZAzVUJ
         htvvlgGKOkXAYvVvcFAkDlvwgFJPDoxLdOx+9tfHQ2yehiTMONHOFQn/lF6gcppOaADU
         jJcg==
X-Forwarded-Encrypted: i=1; AKwUvBwDVutSbDy2rJx/zebVHCxE5IGO3DBtFgJdbS7jQMAxy0Eau6RkhjlO9dxpM6Nj+Cv9RF/q8lRyFwY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSk1qI6ZDrjMA2Oun8aMuj1JI6Qr0k2qzDh/9f5ZDgGZBtytKE
	uiCA4TNGzujD2cjyvI/vMMvhFBLJbTmxuZ1j6BTttquNgIx4njUB9CFT
X-Gm-Gg: AYBFou2KCD2247X1HKTjX9xlpyWBXITL4qkA0S2QWWc2LuwH7FmVUZvWpZBF+2NWlVp
	EcK3a/lWEKONcn8cczSOfIIlyVGm/aFuzQXCivCCdPxRIcM/li23VaSoDgx6Tkmj6sAFS2WVRfL
	GY5YOGvkl0DMaFs+WYzWZRcyft6wCQEcc9/7tg4cWmhKpSjcZ9aM9RttjxQ2z7CqEJYLzZaRCKH
	0aiVBqAEaF5k9ZFr7cQt/XaG5sZd4K6EXwXywfGLEp36Eh+NT+D7i8tXig1GQynr+X9sTaoCcT/
	bL+FYMFp/+yCubqRmH3w5qqF1QdhirAUcu41U2MbrK8d6fxfEXX7XBU+KbVsgCAzB0TcMsaym56
	HKH+eSWuO/3zCU2tXWfK0uG8+nnMovMYUMd3ErZpW6ojUSD3lYnQhWOMNHui3CXrRkRwK4KImJF
	EZr/o+C5XV4wetGzIBr6vD5pMDnEHvLlt83FaLTe5OYy5XuvCRtiwBunlBrQefLlALAppfIefsa
	BomupiIKKpFQg/yLmgr44LW5LPuePT6Cd31XcqS+Y7Mqgs27wwdNFv/HOm7gDGcjfJgcigDGDPX
	20nxA8Fsv/YJS9Js3YycexdbTDfqhIwPw0/Z35qGagg0KE5tAw/O8t5hArfasROjDZ05O8LnrPZ
	dOgheaLYzCXyNN11eq7QOiTtgtNUYoAjP1mHZXJdhloRek287hkPyHGsFkuqwlpYO5RQFMQl7Sh
	HsvY1AxBAVKVze2tc=
X-Received: by 2002:a05:600c:468a:b0:4a1:efba:511 with SMTP id 5b1f17b1804b1-4a1efba1091mr63117565e9.35.1792483182082;
        Tue, 20 Oct 2026 00:59:42 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d6dbd43sm3586563f8f.4.2026.10.20.00.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:59:41 -0700 (PDT)
Date: Tue, 20 Oct 2026 09:59:36 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Jonathan
 Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_mpu6050: use named initializers for temp
 in hw_info[]
Message-ID: <20261020095936.00002ff3@gmail.com>
In-Reply-To: <20261018000924.758186-1-kapoorarnav43@gmail.com>
References: <20261018000924.758186-1-kapoorarnav43@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Oct 2026 05:39:13 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> The temp member of struct inv_mpu6050_hw is initialized positionally
> in every entry of hw_info[], as { *_TEMP_OFFSET, *_TEMP_SCALE }. The
> order is correct today, but positional initializers of this kind are
> how the accel and gyro startup times ended up swapped.
> 
> Use designated initializers, as already done for startup_time, so each
> value is assigned to the member it is named after.
> 
> No functional change.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> ---

Your patch fails to apply, please check it out.

-- 
Kind regards,
Joshua Crofts
