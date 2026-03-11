Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89F82DA74C
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 06:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773211887; cv=none; b=hd+l30FAM8LKXnqjMlmmWW/zK1RFzng0/YF3UIM6JblIUYuV/KtmxaQWDbVsoyyiy20r99X2vwiL7mIYWxeBGH85GGJrUcq0M1wYJm87mMmKE46hKt2QvxmOGbnI7LcPsPjK7WZ90ghz/RbNEtMY9rDMl5vIUg+1HLh1Lcgv38k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773211887; c=relaxed/simple;
	bh=PzPcFTQ3tXwP7zF5f7H/cw0KlxWYCJGLWtrtgS88JXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5g0Zr3RN+0haX1E7PbefufrCanAbl3immfs3mySuJbeMI6fX4yS7X88V24oe6xLyhxRS51L1c37zrbnhPWLc55FqJZCKdKyUfPUUOvbQsNMUJxDC0Uxkd5SuM8WKn5Xl33Z/4wKQ5t15X44ay22q8c/SJfJIzKExy07Hwdf6Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u0IgWttN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u0IgWttN"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48541edecf9so22914665e9.1
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 23:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773211884; x=1773816684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7zvEX0IAkMa6oXnGfx3rdipMmH1BF7wL9zhJ+aTV/NY=;
        b=u0IgWttN0t2kyvnbuaA/cPXyQSBGDt6n0UasqFNVxJUrU353xF55fuUABB6DJA/qkX
         U/qiU5Ark8KUIF2CQ0KopcGh3F/PMW8c+adL0lf4Cgae2591SU0QzLAir+FXNMFORF87
         EWk8TY2mNXC0cGxCpcYAowv4onkc/1xJl/NkbpsIdL0ZyL7iGshqvxywjsvPFuh5piEw
         GCZ4lrEjfTNPd6ZMSUZxrSgVXUyRIDiC0weIAb9huh+C0yjQaE2Mgi3KGEbKDht5qE2F
         6xs3MAhJMtCBSjF8lRYOhj4ykV9OfXqsDJgP1NjSRlnyzqO/4P1e317nQFihI8Hnv9X0
         J5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773211884; x=1773816684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zvEX0IAkMa6oXnGfx3rdipMmH1BF7wL9zhJ+aTV/NY=;
        b=v8FcGLTxMizsnvxXW0QBc2nSAW7VeyY1I/XVXTF6pOsRz31UaRxxTmfdSCf1YLGnjs
         ARNVxDikHKRWPCCdaV0NNnEHaPP30RZIP73qZzhmAGoeKXL6XHSN1Pj5eFo24OM1X8Yh
         iGe46egX08M9WobWVETWq+tqe2a7DYip/ibqFK9DokKJr2OaW/FRC2zAXnwTmXtCV4V5
         x1PFDOsPpLaC+/zOiWs/m0Tnn+OA2NXfTCZWE2LaNwGgA5iR13UABhon/myqQ/zyLkUP
         aRdq0mv73JeSEaw3JsoudRkAbW/ktWmb14Rwx8XOPxLn5cwYY5sR4H7HahIrYI8ITKnh
         +/wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM9L0qtwVovFgCdttDuNQ+5OxKi/JcXM31mMPp921OxB6rq1s8ZjkzJJ+cLZvBHGoSqlexJ8epxV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA7pJjSTbYDoyZDfuVgnDe3x+WHpt+YFCRLyDjybletw0r8CGL
	4BjGiLDI9u8T9j6xHfkEJjW5a5AD5vLE6BgN/fjzJWmotC488+q6t3953x0w5moYvRY=
X-Gm-Gg: ATEYQzzHGo2YaIvKEOBjgMbVeEWz48tOE+c6hpEmYFD9gMlNM34mNm6iRnTMXeWsdfb
	AT6o6kAniJsDk/gXYIRZnNmxS8fikFcawwhK+vGDxLETSRiJ4pRVaJDICBXoVHZFnhyAI2mLgsX
	/QkZzuNDCLRWWo99t3XyXwDKgiMMu6MvqJe6ami3aZftmLqREGWGyazdxSUaRvbzmTtZMzAwMF3
	+oeHJxPrXnS5CO70qZspOoDEEiofik0psFruEjIL479EsrLfICcWwOliTmDm736Ha5xA2XKS7vI
	CNcjUMA0cNYmgFylvfOtNoWNXR2zgCO0p14yD7nvKsGWOFfbw/xKQGAwyXQbRcFmcBQNTt8sLnX
	ykyhLhzaFuQfHpb+qigQ646HMZYHIf/dJECBX6viGsfhOHt2cxz3gyBSJPczPsPZ+c6CKhUdFl2
	/zvyYBXyiEHmOiufHyOAiA2KHYxwu1
X-Received: by 2002:a05:600c:1383:b0:485:2fe9:3375 with SMTP id 5b1f17b1804b1-4854b0bff59mr23795475e9.15.1773211884113;
        Tue, 10 Mar 2026 23:51:24 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f820a2f1sm4090148f8f.30.2026.03.10.23.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 23:51:23 -0700 (PDT)
Date: Wed, 11 Mar 2026 09:51:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jic23@kernel.org,
	m.tretter@pengutronix.de, mchehab@kernel.org,
	p.zabel@pengutronix.de, tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
	pure.logic@nexus-software.ie, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, kernel@pengutronix.de,
	kees@kernel.org, nabijaczleweli@nabijaczleweli.xyz,
	marcelo.schmitt1@gmail.com, maudspierings@gocontroll.com,
	hverkuil+cisco@kernel.org, ribalda@chromium.org,
	straube.linux@gmail.com, lukagejak5@gmail.com,
	ethantidmore06@gmail.com, samasth.norway.ananda@oracle.com,
	karanja99erick@gmail.com, s9430939@naver.com, tglx@kernel.org,
	mingo@kernel.org, sun.jian.kdev@gmail.com, weibu@redadmin.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, skhan@linuxfoundation.org
Subject: Re: [PATCH 1/7] staging: greybus: simplify cleanup using __free
Message-ID: <abEQ6HA0CGGCyV1B@stanley.mountain>
References: <20260310200513.2162018-1-sanjayembedded@gmail.com>
 <20260310200513.2162018-2-sanjayembedded@gmail.com>
 <abCIBPZzZBfMoOtm@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abCIBPZzZBfMoOtm@ashevche-desk.local>

On Tue, Mar 10, 2026 at 11:07:16PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 11, 2026 at 01:35:07AM +0530, Sanjay Chitroda wrote:
> 
> > Replace manual cleanup logic with __free attribute from cleanup.h. This
> > removes explicit kfree() calls and simplifies the error handling paths.
> > 
> > No functional change intended for kmalloc().
> 
> ...
> 
> > +	struct gb_camera_configure_streams_request *req __free(kfree) =
> > +	    kmalloc(req_size, GFP_KERNEL);
> > +	struct gb_camera_configure_streams_response *resp __free(kfree) =
> > +	    kmalloc(resp_size, GFP_KERNEL);
> >  	if (!req || !resp) {
> 
> Now this check should be done in a better way.
> 

Yeah, two if statements, right?  Drop the curly braces at a minimum.

> > -		kfree(req);
> > -		kfree(resp);
> >  		return -ENOMEM;
> >  	}
> >  
> 
> >  done_skip_pm_put:
> >  	mutex_unlock(&gcam->mutex);
> 
> To complete this, one may add a prerequisite to use guard()() first.
> 

I don't think we're encouraging people to re-write existing staging
code to use cleanup.h magic...  It's unclear if I have to review these
patches or if they're auto NAKed because we're not doing the conversions.

regards,
dan carpenter

