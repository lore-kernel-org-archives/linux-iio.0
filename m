Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ECE4734D3
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268718; cv=none; b=sFO0PkrWBMYQOP48tVcIt9tIar02G4nSm5/N2a2Bt/bU6X5SXNF3aXgsT6WsgnpoFF7wrPEjSvrifsUtwpJn3n4DQl4AQZrC+xDPjwIX9jyoJ7KyHbFG8M7fgHAPJfY5QqhynED+PJxJcYffBYkrbGRsCXmkKAXWg5hnO2pxIhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268718; c=relaxed/simple;
	bh=WJuk18KFkaw0c77iHyRMK9iDRuejuY3Va+6n3Nq22Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQD65IpslewaHp34rquDFL4w1WdCsZrJUddOOUP/Bd6nkIaxyDQriTMnKqfhFvZ4bpclu94vjOu12z4PMpC0Pu4BMkty2dAtT73DmopFIV2Hn9zbakPPkV5HI4WkJg+Hcyy5bSsb0xmseEEhiE4t7EohphQF7WbevlOcZADvLeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fy6xzn6M; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKm8P+ZD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fy6xzn6M";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKm8P+ZD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785268716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXcoR1r6KDKjpy7OYoN3vSMr16JpkIBQ322hefXtCjw=;
	b=Fy6xzn6MXYUAQ77cyH9hfA5K2GpsCD+Mjy428+qI9hFSzzAi5vfRqskWsYRWyi+545CU7t
	GkY5PS04klRHnSIiL2SZtdKIULx+gFjbnVWG2aTrbJO+74ZfyTO87Yma1xcP1pJ9BEaOXr
	W234SCdd6Ttwqqz9mXkjTiVHIL7jntA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-H7S7Jn1IOUihCfq2yc7YSQ-1; Tue, 28 Jul 2026 15:58:34 -0400
X-MC-Unique: H7S7Jn1IOUihCfq2yc7YSQ-1
X-Mimecast-MFC-AGG-ID: H7S7Jn1IOUihCfq2yc7YSQ_1785268714
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8fc92c5373bso2314466d6.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 12:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785268714; x=1785873514; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QXcoR1r6KDKjpy7OYoN3vSMr16JpkIBQ322hefXtCjw=;
        b=SKm8P+ZDc03JmX+k+L/5V/7tWI3PJ5r2wJ1Pkki6tFSVcNZHey2AbixZvFt5AXTtU8
         hc6fum3mguulZKCaVn/N8PXNa3jYlIuc+fotKa7nh2pht1peyar+Jbr/X5km8eHja4GM
         IpzH8CimTRYdINHA8bhNmZ1e6wBbLh8+KVGuJFNf7vu4B123lZwBTVxVxNcUOtBpGkgR
         YVSL9vE6QGXBn5uV0IL752UM+Riwsltgb0l6gxmRkmRYZtrN6asMHGB1z+xepD4bZOr+
         rhXvkjnQxGf5Iwn23a8C0WgsrUmxAIHrw0z1MP4Bgsy2KNaThBzIyKLTv+zHMhBMW5Xr
         vdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785268714; x=1785873514;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QXcoR1r6KDKjpy7OYoN3vSMr16JpkIBQ322hefXtCjw=;
        b=A94pAfZA22YCkRLrLTtv2L7bXOxk28jyb/4YCqunPyXc8b61t1GdwArEjCiYZzZE+I
         e9Kn6yACjzJDdD7nkY/CS9sviLblFdAA2gyD4j7Kjk1MVlQ0XYRhMcadV/fMWNoQXEBQ
         6GrBQ42VKvf0QidKkXfsO6ekKgC9gUXoM6hCe4cqwWvwi+aT1NPChlmSJrmujGjClGW5
         OIGxXkm5WBRKunr4moboFcGcRO8gswcUg/llbm1RPJb3hkoyN/GvuL8DDlZMmLmsaS+a
         JGpm7kdnhL+ab2R9sqE0erIvYNsmEH5mgGkmeTp0XRbvD+VFyVjwV+/1oAqWW5iLn4/Q
         yQhA==
X-Forwarded-Encrypted: i=1; AHgh+RqIkvyHayWH6m/ulCpbcw2WTRLrhPnCkpMfwIIggn2L/0f12bUZ28c6evzSFVmk+/evcQLlfQMIyzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc9gMWRgDWEGw4GzgmEBOPg8BZK3+4PE13pc580NvQPgNbdUW6
	QKE/JFu1F3Ye0WsgJhhxg8JdeayG+zMpeCC8udVaQjnxqS3ThnB3yDfEInyRap/jaFy3eAV+GjA
	pq898TfHT/8uXDS9HVFtDqCiB8t4VilhoCjEKe3QxPyzb0jyf2YGixAC1X69TLw==
X-Gm-Gg: AR+sD11RSGib3/gAXy6IfnAXT6dbZQP6Ds+8202z0uBMSnEdTvX+AxTSFJG3ejX47mB
	yxplW3prznC9oFu27zEpjjoZrkXUu3Vot4tKwI3w97LjYE7KD90u4Lr4oeMZuSSi72KeuuJfSbd
	lJn7DYW67yL+bFW322jhocRpAR0f39v4lwzTn+NjMpjChODYSxqhzftMRryrarSwlwvSs8bptss
	J6gdvEWgPomoj9GpxOIIl6Q2JI5d1lTfJkilKq1lod8XPkAUufza+TZLev46rNL2g7VGGJl9vrg
	+iAj9FalXLjF1aDPSF3YLVOReMrMuBiexncx7xTO5oqWhph6REtt8JI281E2DIE6DnZbHiTNWOW
	d7/IEp5T3ilkYrAAQDBzwScNVT9u9nCq9Yfk=
X-Received: by 2002:a05:6214:5289:b0:8f3:9d85:405b with SMTP id 6a1803df08f44-9081705b500mr41433466d6.16.1785268714026;
        Tue, 28 Jul 2026 12:58:34 -0700 (PDT)
X-Received: by 2002:a05:6214:5289:b0:8f3:9d85:405b with SMTP id 6a1803df08f44-9081705b500mr41433186d6.16.1785268713645;
        Tue, 28 Jul 2026 12:58:33 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dc461a9sm6862566d6.5.2026.07.28.12.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:58:33 -0700 (PDT)
Date: Tue, 28 Jul 2026 15:58:30 -0400
From: Brian Masney <bmasney@redhat.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linusw@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH 4/9] iio: light: tsl2583: remove
 tsl2583_set_pm_runtime_busy() helper
Message-ID: <amkJ5vzoI-IdMF3G@redhat.com>
References: <20260727184755.2055414-1-ekffu200098@gmail.com>
 <20260727184755.2055414-5-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727184755.2055414-5-ekffu200098@gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Tue, Jul 28, 2026 at 03:47:41AM +0900, Sang-Heon Jeon wrote:
> tsl2583_set_pm_runtime_busy() just calls pm_runtime_resume_and_get()
> or pm_runtime_put_autosuspend() depending on its bool argument. Call
> them directly and remove the helper.
> 
> No functional change.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

