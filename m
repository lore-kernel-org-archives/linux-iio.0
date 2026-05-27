Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA6C426D09
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892522; cv=none; b=i+8XVhCwFStKUWRnEMxKcpuk4LOrEXNpKQEApOlNtFtmXBX2FI8oFe9IVUMAi7n23wngBQSkIpIAsmTXDKnDT4QGPcga1IkFwb00GL4NWj+vEQnzgLZYv8xenG1DtE9yydsUisZvb5FY2hZUvvB/buFs5rN14CZguNrSU1yVd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892522; c=relaxed/simple;
	bh=R1JOmLNp9EHZ0WEabHw7L+RqlPFyqYvHKyOAqJ5brCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1ahlMs0FsY6dIACIfS+AYlSLiQevx8tpvyt4WcKSIYGsIvScepos+dx6KZrHBbI9QxDvoj+cA7RhvHgYuIhjIXY5G5oPcLSzPhQE3ayKtZL9uQue6lFhJWtCj7wXh76+HOmy1UYLcJw5fAOeblbAIp7QNDR5OfaczfasKEPbjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URiPOihO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URiPOihO"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d75312379so10014675f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 07:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779892520; x=1780497320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RZ5Q/PzDGNXsKLZr9eRwm4Xl3D/WdSaJJPxHZSkacU=;
        b=URiPOihOIO1gISUqvrJ1XGZKkKamc9tEakh05wtPKiLw6fBej/C01JH4lTvHGoud6s
         sZjpLxj1EFWnJYo5B/rIEuVXT09NHrv+NonUuNu3OBn4MXILiyvMgHier1d0vDZyJPGI
         4zgSvq0DJo57cMyAclwcE2F5an9xgZiqNgDzVDAOA4vLz3foPCqS2ERXcsRLGrRB0ztq
         j5IGmsde57z8qa55YQe91SpK4s+H/Wii5/U3OTpF67HnsJqMbAPlZItCL6nhmkWjCy/1
         WvnmMFvz0/n0Ldg911ZW25igRwJfzFZ9IkHH4HcorQIjJgWXCbqrt3Tssfc7YKMchWdy
         X2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779892520; x=1780497320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0RZ5Q/PzDGNXsKLZr9eRwm4Xl3D/WdSaJJPxHZSkacU=;
        b=F1WCEl2jweYQMuw6SdIgWKZh99JnmjFsfzpq8GMJ6jaTv3MDHkXJCFQbuWmUlk8692
         zrC+Trd7QVO41OzyRff88rvmtpZKOebFLd8q5zPbb5WJSuoG6yqWeyiIqrybhq8F66Jh
         A1O4L4YxUkyzQqauOoPCe/vptwXbaJ4Od7yBMIm44Tdj+bCjqBbEoRt6Wo2v0SLIih7I
         z80wnbj6UZv3IMt2lx5NqQNajRzZIbhqPdejVBPcjtQCT0iiS6S87uBzXVN+n1PNKxbC
         avSzyhMmZ1RJkcoLIoqiKXDNY+ial6tM5wx7TKnOWqycAmzaWAOJnp+75IacrY1MDQhl
         UEKQ==
X-Forwarded-Encrypted: i=1; AFNElJ+hjIXr7tU4eJjS/1aKm6PoMOTkOAIImbMtpmQbUGQizJjbgi0F5ywEddI/6X5TXkaMrE/etxzXje4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJrBv6zSOS3d4OgqIV9pXtR+p/uEZJi681dXK+rCtAe8+CvZfr
	Ybe8cK0j7R+9jWjJlEoe0tey2LVq2s2KmLW0sN/LLr+piDCGTlVX5oCf
X-Gm-Gg: Acq92OGI/wnUPu2k4bUZ1HTM+YTbKHV8rNrXUt3Icy+shLTqRPV1wq0EcRDuFXpJ16j
	9kCfvxhU6r6PNvqPUknW8a4Od99KpCVrltNXWG2NZQ9YoL8oizyi4MP1+UPHel8+LC9MuaNGNAf
	IEzHoR5egtJWy03xGl5LqwnFBJVa9BFPsh0YJzLfw1DObtJAO81WS/+uNXivO7zBkeFHYjZHW57
	UeamIRWkKWWx3WPnxJl0P3dRsKWwhmBDNCNGgytU2xI/pJKNI7LXv7z9R0RkXY3E6iQJcpurIJZ
	y0BHgcXnXxa/STqNkUYdvMwvpDZV2v82xU2/HJoYbLeHopW+Q87A5BqKvowAwa0Q1ybanbzjf5l
	ZsWiBSuvd+5gGd2gkWRX0P9bkDoLkbuf8H0WCieeZRDgbp/eZ/W14Rrpk3FjRzL1omLR2xE4GY4
	JnrMJeNn+OFkxLPyQ=
X-Received: by 2002:a05:6000:2608:b0:45d:2b7e:a20 with SMTP id ffacd0b85a97d-45eb3131940mr35157326f8f.14.1779892519687;
        Wed, 27 May 2026 07:35:19 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5584b8sm6239763f8f.11.2026.05.27.07.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:35:19 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux@roeck-us.net,
	jdelvare@suse.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 4/4] MAINTAINERS: add entry for Sensirion SLF3x flow sensor driver
Date: Wed, 27 May 2026 16:35:00 +0200
Message-ID: <20260527143515.102794-3-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260526173616.256fd535@jic23-huawei>
References: <20260524205112.26638-1-wafgo01@gmail.com> <20260524205112.26638-5-wafgo01@gmail.com> <20260526173616.256fd535@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 May 2026 17:36:16 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> > +SENSIRION SLF3X LIQUID FLOW SENSOR DRIVER
> > +M:	Wadim Mueller <wafgo01@gmail.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
> > +F:	drivers/iio/flow/slf3x.c  
> No need for separate patch.  Bring it in with the dt entry in the binding
> patch then add the .c file in the following one.

Done in v2.  MAINTAINERS hunk is in the driver patch (3/3); F:
line points at drivers/iio/flow/slf3s.c.  Series is 3 patches
now (types, dt-binding, driver+MAINTAINERS).

Thanks,
Wadim
