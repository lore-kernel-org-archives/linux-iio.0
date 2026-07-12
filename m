Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A17342515
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783874311; cv=none; b=CsUxBXujzjQmyhl5oJI1DyXCdgGR0HazfQgDCbVWADkcfiTSkeSpCl5oHobgmCR0Kr8khhzwK3w2VOItmyms1H6jWfS4pxNqE+D2zkAoqn3fxA1QdxVvRbpgUjTNypGCD3GwHBx2hyif7G/MuTfeCmWdD2umXJCPuowttBjtXkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783874311; c=relaxed/simple;
	bh=WgpVXf8J119QoGJHXRfX5ufe5hIxEJOs0qPmFfcdhPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fCOVjkQ/lHtyoZHqUWWRsnq9/33O7I8X3q6x3jE3X05oiu0Sg9arVxf6BQgtqsfRn1jA5/epZ6ndakZGlcTTHZ/ROHZ3mNk3zx2NSSRkQWfY9MuGssdP0wwJTjvmyJy1HN7HWaItA2/z2YJq7kVANqWGzq4zF1s/IwbzrKncnoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1VG+rcQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1VG+rcQ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4938d5f86f3so17818795e9.1
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 09:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783874308; x=1784479108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oBeqD+zoXhOUQV1xacnEku0uxvNUMotgOTqmmTw8mQQ=;
        b=K1VG+rcQ38wNJFOMXNezIxl0ioUheUbNzcgI/y37rOZTT97VnDT5NQXpKByPAkTD0S
         DADqLFhpI3Nj9jFSP5V6AUyYmZmX2Pv//GiManGFGV68mpGIF4eKKec58UdInRvEermq
         cdNYAhZkvGhjAwj5rEoQFhtehHxv9UCXQ5vsVCgQCL9/VbNAy0OBnFSIfyk7eie25dVx
         /VkdXvnXt2hci6g+tptIzMjHfy2Vn6nZrbqWIpQ10IIx47K/RkhEfm4Tmw3Upjo2uLbl
         olMk0jwhCUdB17GMiUeQTFbi7sOrucwuuV8hrjr114GlTAJqICS3HypRgFckbUHT22mX
         +tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783874308; x=1784479108;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oBeqD+zoXhOUQV1xacnEku0uxvNUMotgOTqmmTw8mQQ=;
        b=TNYhjvKfH/cWMN+wwntgjDVHfOgr9g2Rvs9eHbAVqwmQrwUbTQ1udMpiyNpj0Fd4vd
         Z0blv17fUunO87V088mrvnLslUKlZBG/YXvyqnG5/LQdUAH5jaES7ULHhNnFxtpRFoE9
         Cp0fkrUfUftwllE+ktD/sxM5mA/L+h1vNq29S4HRZCsdrKl09b8zlDVA0lmK9YaEFrzf
         m4f870nxvviR0bjPs9qjmT2cz28o4bQzR7XKOZFySb/0vCzng5gIq7+39pOZpDSnwCb4
         5R6/IZST/VF18Szb1jKn6FzgINmA1Z2ZXUZqkvTx9KMWQvSL33ex9U6XjEvbHnqQrtAf
         eyjA==
X-Forwarded-Encrypted: i=1; AHgh+RqyCRRi+9CJLWQ9fpNBS26ueYSn2UGG6pCqfMERIBQVD1mt+Q/xNRDHeqhORJYin5k0yt/kZ/xe2VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrcllXBJXO9PQHxP3zL2JoEqKNr4HwIgnKTpyQuuSkDkRvmc7Q
	96DGeEfUotICcKTF8tfYwiopJ+xVBNmsCZ51e6HsSAZ5I/c60hTrWSG+
X-Gm-Gg: AfdE7ckBLbuiupjOzCXqtm06taXEg9+4N4pMjBMRH0pdoYAz91sZsqhQ8TCjVKwpmHG
	DwFB69Wton5piIn56lBU7LXtVLRW9Uy9xhDY/Bf4oE5rz3qXB+Po3K7xWrsgN4iQYrsd7SINJse
	VkCNstEW5PcU7nQEuDq6i9+mmlXjxUxAs53yQW4hVILQt2AubsYZvydQ2O5aRmq7xW42iwO05WH
	+w5kvmYuTsJkduZ5IVsklnN0IEMn87ZSk/FOJWX/um8iCVyS3yYI0c9nPYVgkVUknki//0WUs2g
	6ki8EOsr/bGWQsbntTMhGPZLwudauFUcHjYFX8jWidgq9XIroYXoKreQECShL1E0BoBVMuA2lUD
	R/xcjmXydZJy186KSl0G1F2APfAxiqXhokpocemXSHzFXLYZpbajc++wKKc6ExKRquNdb0FCs+1
	p61sTHPT/RoZrOJAqCZOzIHOgGJLwgbQ1irWuquhlO7ooEuIWKsZvmhZ1b9jod0Ym6eiGL/tNwS
	skD3MzI0Y28FOD6Vx9fZ2WIPLl+GS9jz5yOLTMBRpN6pzOo0p9sAZT/1yENk/YvAII9S5leADrp
	3VNMfmm7RqlT7+fqAGDQTAkfl0DLuIKWzG8SdRj0DkH1WeWFBw==
X-Received: by 2002:a05:600c:1391:b0:493:d117:18a8 with SMTP id 5b1f17b1804b1-493f88bd849mr68661845e9.9.1783874308011;
        Sun, 12 Jul 2026 09:38:28 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2a2e499sm227660225e9.0.2026.07.12.09.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 09:38:27 -0700 (PDT)
Date: Sun, 12 Jul 2026 18:38:25 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: opt3001: split opt3001_get_processed()
 logic
Message-ID: <20260712183825.1f3dcf30@systembl0wer>
In-Reply-To: <alOdn0m3fbznqqDm@ashevche-desk.local>
References: <20260712-opt3001-unwind-cleanup-v3-1-5fa336876b08@gmail.com>
	<alOdn0m3fbznqqDm@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jul 2026 16:58:55 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > +	ret = wait_event_timeout(opt->result_ready_queue,
> > +				 opt->result_ready,
> > +				 msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
> > +	if (ret == 0)
> > +		ret = -ETIMEDOUT;  
> 
> ret is int and for holding an error code, with the above ret is rewritten
> with positive number and might lead to subtle issues. The recommended way
> to handle is
> 
> 	if (wait_event_timeout(opt->result_ready_queue, opt->result_ready,
> 			       msecs_to_jiffies(OPT3001_RESULT_READY_LONG)))
> 		ret = 0;
> 	else
> 		ret = -ETIMEDOUT;
> 
> or something like that.

Sure, I can do that.

...

> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to write register %02x\n",
> > +			OPT3001_LOW_LIMIT);
> > +		return ret;
> >  	}
> >  
> > +	return 0;  
> 
> Also can be simply
> 
> 	return ret;
> 
> in both branches.

Yeah, I agonized over this since I did the change you describe in a
different patchset, and I was advised to do it the way as I did in
this patch so that it's more readable (i.e. we know which path is
the successful one). I'm really indifferent to either change and it
doesn't cut that many lines.

-- 
Kind regards

CJD
