Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF526472F8B
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 19:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268523; cv=none; b=iFxkV+jMqIwPYn/+HnBjOSR2Hwfj6o46Ny+LMXs+Kk6ysWDaWMBEQ081gbpWK1RPjAonk8zyF38os0GQZFq8KZVh15JPnglpc+Sfui4AaiZ68S2bnst2YJLNFZo2kpXxhmBBSKvslCsR8GY3LipvOsp7HWLDIYbcvjyCFsmDd5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268523; c=relaxed/simple;
	bh=9VVy2f0AATEyNT1VKttOOmHAJqDlvZ9+jejcvHhiM1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8RPCYgpXlGW+jJ+r1Syl8bUhxFCbVwMypt1dQZlpk0AdCJbzcdNjr0AQWYQrKhA0GtrRdRU/YxclON46x4Gadl7/FObabzTyENlkNc3kt/3kxk32GdywmvUT13LBwkKOhATOldaN4ONkUxXIEOFxGINpPkHsH7lw+kTsBe9SC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DEzdLOTJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHNhDoKu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEzdLOTJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHNhDoKu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785268520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hHF8nc0/suG+jSqyRi2zB+GsqmSj7T01Kq8vZamAl88=;
	b=DEzdLOTJt9vhR9LDjt/tGSTf0YbCmaf5eO1ff/3Z7EycaOIRkOnMm8xne59alShNGLlOqW
	jUgW6CLGhOscqg/FVU1/E+p1BYoTs4bXJ3QPu6kzi3aafa5Agd1zzJdc32IkaCVZq3xvNg
	wumtJ9YSiqDzFAxqZFAnSbfE5IAdP0I=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-Cs5lIGieN3Oeio64U1MqPg-1; Tue, 28 Jul 2026 15:55:19 -0400
X-MC-Unique: Cs5lIGieN3Oeio64U1MqPg-1
X-Mimecast-MFC-AGG-ID: Cs5lIGieN3Oeio64U1MqPg_1785268519
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c0408254aso17857161cf.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 12:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785268519; x=1785873319; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hHF8nc0/suG+jSqyRi2zB+GsqmSj7T01Kq8vZamAl88=;
        b=HHNhDoKubdI2bsqJ+xEppUs1+EVwvdOQ7TGUNd+4DI06Xr64/rughbQ85WqDMnUgvC
         N157lXiOqHfBtNXaWDzC70+FbdFl1+ZiuDgsZLq4lqSpBIx1zn8y1gjVBXyr//Lyhd1D
         YzEpzaeobu4AmQoJbXtfGPFD+u0yvtHudyn6mXpATXcqHP0ygneYcz4RT3K36uv1KmNH
         n2qgcKsPdkGUgUhZJxZVbFhG5fJOdQBLpkgqo+N2I2t6KlOta4Y5rBnOCe3OuW+KNSH6
         q7hEVNIjrsm+GNrIZZhGwgZs81P2xSwGv/oN1x1cf2CuFG5R3Y9clFOvfPVjtlq7TyeS
         Cdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785268519; x=1785873319;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hHF8nc0/suG+jSqyRi2zB+GsqmSj7T01Kq8vZamAl88=;
        b=cn31gJtakri+jb/08RJPLuUGOv7Sq2sk7DijP0d97XVhxrzP+5XD4JmS2m9QlQnIX9
         myDH/JYgBRnuF8IiSHH4ZYQHHIYrN9hcC8t8eWWjXo7YuDCZ8aQ1PscCkuid6RMv7TpR
         jAAB30slqCjKQJlgbBt9iUkMn1s2lmj7H0M0aeZ7erYAH1qWflQnPxNJRsUkLmtF2+uv
         +JYSe8stbxC6GeTI6IKKT8rM5+7ZB3oOvpnIPH/ds6bkjNzuCMcT29LcbG46X/q21Gyu
         mwLpZD6s9b/7em6Jwtsvs+IeH/Lvnv92OyXLeQMKs3bIArjnNJ9R72+zTiGxx9vRHcnV
         KWfg==
X-Forwarded-Encrypted: i=1; AHgh+RqnpzhrjKsdsFOQud0KZ6gJzNUSXRXMCfmBf8W0e2lX4tppfIIcYLIvseyQ12QBSc0g6RjZXygckEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxARWTVipRFKpZlnZxAqCk7rUauwesdn0mmHHQREH13GBfCthin
	RRlkUUY8gk/HYMSy/NnGwrSEUlPPMAuKiVXrlndyX0Vmp8tsTNIg023b50CsYXMAdk2D+YIGvRI
	LTsJo/VoX/EQYPXp8qZcBKXo2DYuHmmfJ99vXqhNcQBmSb2e6mXMYZQFx8a0zPg==
X-Gm-Gg: AR+sD12JHesVp0nJNDxXjVxUxDwtslIwlfa1EC2y/dlvbS9mZWPFnjCaNu5r+vK1oU/
	2W3TRo0zIDZ5eC1ogA6Ajup6scUtRxhmEp1X2788pgkx614v56FJv79nitc6SQW30EjuLPEzA8n
	yZAdk5O8Dp2UgF3sJ/wzBQnwsaAyfFP9gs1wywNkFqyGLXWOSn+TTbCQC/Kwh4HjQ0tpWRdoePf
	aukbssB+9iYL4h6BwbW6KsLDWAzVyjnnMn33TIx4V2pm1KZZs0MT4R0yGIFxq90GSn+7z6DoSFB
	cmk1/SpVJSBVpYTnYVyICyCkCOJFy/7HsBcFIJqAvyovXV+fpxZucynlF3IF5JHCiO5Y4lpr7wm
	OWpJfR8ts4IyXghd0FM/Zee5hrQtE/J1Mz/s=
X-Received: by 2002:ac8:5713:0:b0:528:ce0:e9f8 with SMTP id d75a77b69052e-529d6f9df2cmr34231891cf.3.1785268518841;
        Tue, 28 Jul 2026 12:55:18 -0700 (PDT)
X-Received: by 2002:ac8:5713:0:b0:528:ce0:e9f8 with SMTP id d75a77b69052e-529d6f9df2cmr34231511cf.3.1785268518250;
        Tue, 28 Jul 2026 12:55:18 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dc461a9sm6800076d6.5.2026.07.28.12.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:55:17 -0700 (PDT)
Date: Tue, 28 Jul 2026 15:55:15 -0400
From: Brian Masney <bmasney@redhat.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Brian Masney <masneyb@onstation.org>,
	David Lechner <dlechner@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linusw@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH 2/9] iio: light: tsl2583: return zero in write_raw() on
 success
Message-ID: <amkJI7wtsqI-OK5q@redhat.com>
References: <20260727184755.2055414-1-ekffu200098@gmail.com>
 <20260727184755.2055414-3-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727184755.2055414-3-ekffu200098@gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Tue, Jul 28, 2026 at 03:47:39AM +0900, Sang-Heon Jeon wrote:
> tsl2583_write_raw() returns the value of pm_runtime_put_autosuspend(),
> which is 1 if the device is already runtime suspended.
> 
> In that case write() on the sysfs attribute returns 1 instead of the
> number of bytes written. Make tsl2583_write_raw() always return zero
> on success.
> 
> Fixes: 371894f5d1a0 ("iio: tsl2583: add runtime power management support")
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

