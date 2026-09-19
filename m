Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C54A4718D8
	for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789814692; cv=none; b=EXp3NFhCiYQht7QYxI6MKh6+kYfUumBzYGTHUkeUB0SuUJhzvifetygzdF4AsDIpRXD7sFtP6rgIjU96zac1YiBOOT0SXSyWJ/K113r6rKigK/qB4g2pMlBhYaO/K9pPzeCoJu4mE6mI5xmiOOK0pSgqBwDE3ymH/y/dzIpbgdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789814692; c=relaxed/simple;
	bh=TJmcyUMfUmcsYyZScDlt8xhUYwQRzwxjW+m4HiJ0NoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nxc9/5ISYvewq0K8TGw6gguOLiq3B6FIUN6VWzCLtnHFsld/XcyWWitkHixOuhuYJQ/Dk+dEAvFunRhQkLzX3u4Vj6vCE3JVkf/TPlEPt2t1WkDrTGd5j53rNaegjfoxxBAqFOFcShNxuAXjNaC0iJk6gMIyox5HGtc3AXvnR18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSlcqc2W; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSlcqc2W"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso20135645e9.2
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 03:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789814689; x=1790419489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wg8QRQKmkIfgrPNpMhEYrYo1EuPYnVkkY2nrckW83dc=;
        b=VSlcqc2WJfSP6ou9NPzP/SwWKUe7vGvrDVUYsQVIaVowvgfXUdu2Py9GLhrwD3WHvo
         EIE5RGo4DuJQqqnniakSvii/bQtP5yTniXnOyvDjiyKAE9STRHKs19q3602EOwDycTe8
         lor32Rnrc7Pvb9r3Ux511lj6KqO9v+R86U0FA6wIfza6UyQ4K1ejbclzxKEHJRfrWNA5
         jUKuJnwMqs8UAh4ri2pU2cpefqUzaW8l/YJUqk2gsOI186107ke1bOfREsNyLuDzbzPo
         LWgXlFKvNcJGLAra0FyIVB/d7HagC1iWMjL3GSEpM7hH6HEIlZ+MfOleIfVvAI9/WYhL
         GXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789814689; x=1790419489;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wg8QRQKmkIfgrPNpMhEYrYo1EuPYnVkkY2nrckW83dc=;
        b=zZjWQGXjtd04rOhXtmakYvYYoiWD/Wc9JDKLWg8ZM7vcQp/VAXME/HxoUOFjGcHWaO
         sKGEQYj52D2VY9cF3abbXoNoMxEpUZFifee8Pk0RigowXvkcNw3CXtZwTS0SioNzK2xJ
         X3R154+DnyNK67fpfWwfFZbCm4GV2pR26gNuXCK5Men84m0Zoj6q1IdTtftUUumdEkWp
         ZqZm8Wh6m5xGl1utYFy/AweSb1MYmo4VqierXfXNP+Uhl0TwuUocW2wtGlvUMnFLRcgA
         ru6yTd3l679fuLZWdzJxVdLjQ0/TMovgZpTvcETh1NFDajeJ8HwYCzhc306TuD6LIeh9
         zVTA==
X-Forwarded-Encrypted: i=1; AKwUvBw656a6bhDyyNvZPWj9MlKpTvi3QUzbmxlfWRCSiSzej5H89LRimru3T2l7oQSdKZ5xW6vHTtl1sQw=@vger.kernel.org
X-Gm-Message-State: AFuF++lzxi3bugT23OTTFNuctjz5LW1zr3S0YUZDeUH9NPeebY1DlyoF
	UKoTHq95HcvcK3ciXlXPDSdGVEHt9TI5LRJSEsQhJ+2irBc0vvkZfLwf
X-Gm-Gg: AYBFou0gpZ5VXvpvouOaWTMCwiu8eWVVUgabRsqZrbulvPzXvCl+lqOL1Bc4gCf0S/x
	Ll+f8VVOINCKPfTZsXkNtmPzkOg47f88kj1hx58QzqHwZjWqiu4MEiir9zU1i8zlaHdQtUM2iEH
	pSv0NHC2547MAd98Yk+VoTazznKew/eQ1jPt7PEJO41/6VCYiHT7Z1TM8d9wLpckmgMWKD+6+TL
	F/m5AC1WMv/AG5yLdVJNTTx6khKyRKJL/eD9hpymSTcA2lTen4EoP6/Hj/8DLS/wIamVkxtXIQa
	+YLtFGMr1XSz6JsU5jukEJvHLJ66iYdXldyCHTypcjw0V0JQF40ur1VCgznK0CHkGN/OMrgJwTw
	v5QT3neBroVu6OEVITP34blTgsNXIuRQusF0Ku11UABz8gzfRi/oCf+j4WbyBIz8wW75qkgwCLb
	4IQ6z4NAzqSWBddpzEPyNTyqN/0+1go0Y6Ca6a1HnAMT0ilaTNeFOGp976lBzE3I70x+s=
X-Received: by 2002:a05:600c:154c:b0:49f:c451:b4ab with SMTP id 5b1f17b1804b1-49fc5743c34mr68901275e9.29.1789814688641;
        Sat, 19 Sep 2026 03:44:48 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd074336sm62992825e9.8.2026.09.19.03.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 03:44:47 -0700 (PDT)
Date: Sat, 19 Sep 2026 13:44:44 +0300
From: Dan Carpenter <error27@gmail.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, gregkh@linuxfoundation.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	andy@kernel.org, linux@analog.com, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com
Subject: Re: [PATCH] staging: iio: adc: ad7816: Protect sysfs attributes with
 mutex
Message-ID: <aq5nnHPp-tg3C6k0@stanley.mountain>
References: <20260919085513.9173-1-abdelnasserhussein11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919085513.9173-1-abdelnasserhussein11@gmail.com>

On Sat, Sep 19, 2026 at 11:55:13AM +0300, Abdelnasser Hussein wrote:
> The sysfs store functions (ad7816_store_mode and ad7816_store_channel)
> modify the device state and toggle GPIO pins. If accessed concurrently
> by userspace during an ongoing SPI transfer, this could corrupt the
> SPI transaction.
> 
> Add the existing chip->lock guard to these functions to serialize
> access and prevent race conditions.
> 
> Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>

Add a Fixes tag.

regards,
dan carpenter

