Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421238;
	b=y+uCqZMecF/iAQdVwarK1FnFMIPy/1DtNRXNKpwS5jrcCFef26xou6ppmKA2PljnIbPI
	 i8ZqvP4WoNOwja0p4z831EK5MqPObdx9FiSWvWI9SSJ7W+z3TP6OUlssCjgkJmD/Ou+dQ
	 MbY1zb0m2hnvoPL926RHXZpr33VHT9MYLbN2OHNlrNqiX0PnQozxBdZ8LnC0IOq1Tpx7J
	 +ikEdjV/B7+TUypslRQgHU+8Hz9D6ZPlV+2cSMwYHYamgYftkVxM5RAYUihPNcLe2HIZj
	 zQbJR94sevsZyKSWWs2zyJc7fRv59hUfaRnkGk+1/j+bw2ZvJcv2BAV9UJJNTH2bMcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=fOYd5ZaOeADhD4tIe7KmLNJoUGjDoAdQhQUbMCR5XZg=;
	b=108wtb1eRAhQ8oK/3lzDXTf8lPUUy2DtjcBh3xixoOUSACpGFPpCe8iV8PDiBe/pXsYW
	 APOt6vjKIJSLNdo3EjIP4uPxkdQOwCZYFd8p8ylSRgTdQO9X1JcCrIcMr4l1DL/wP07uX
	 VzhGRglYhZMWWuI2p9dg5j4J7v9IX4mc+iBbBl/f4CKk7xh9nOmhERz4vqa3xoEROCdXR
	 /KtNRaUQ8icnW2Tv7by/jS54e+E7m3O0n64AroMvpNUIaEi3ss65y/LUb1wfSWO4FMu/0
	 ZNbaOmMVd+9qg8jQzUXihUpMOJsidKu+RfQSKnpnxQsrBsvy9MkMAkHp829G1MxYc9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=HeBshIKC;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9958C606A33E
	for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 18:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9958C606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=HeBshIKC
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a2761c69fbso5850622c88.0
        for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 10:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794421237; x=1795026037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fOYd5ZaOeADhD4tIe7KmLNJoUGjDoAdQhQUbMCR5XZg=;
        b=HeBshIKCZ3c1YhzQ39PfZ6aMIiTWxve1gcL/S0yWtxWipXjQctQgyI1sgENUCcIon6
         5qNh5/RSVxEtuf8ru4y2TVLSy7O8bYvfwt7ZfMeEiJuNFNnIzeIGaXAsG9gIwkcCkRJ3
         WkK2bcUf33rZ3lADYtzCT/pysuWuy9U6rhURQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794421237; x=1795026037;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fOYd5ZaOeADhD4tIe7KmLNJoUGjDoAdQhQUbMCR5XZg=;
        b=arx4aoLQIkC5kjmQHkzVvlS3kuGvqhXBAMXzSNpcsLiYgkM63OaIDWtbLUdbQkFu/n
         WYCc5aw2EXCNDRI0PHGrf9Oq0Ra/00qeX4is4DEWSD+W+Q6crK1K82fgnIDhrcI3qMLt
         zullR4OptV/Yb5iBoI2SqMsH7czEu1AvySUb5Z3dVuSWqfNMRWqgeuGV2y0QxouO5bGD
         zOo+8WcqWdFLKj4xSoIA7EP0vtevMRKWc4PhYmltoO77Q1LY3osXGK47Nt+dUlUa8vvW
         OdBWN5GAV0X46AcnW1YydtVky6a1TNfYgW5tnezMY6wN2j8eNd3Cqf0d6tZkt/9PPXOh
         9QDA==
X-Gm-Message-State: APuU4Z/yG6CXxhcbQbusPgjFhOblWUTkX8/mX0MlQpWsQMQVO6CMnomM
	0qgfoPEOIdJz6DR7SRHzIuSD19EENLzP7BAXcsnVxjYDOnasPrSmiu4kZMZLC85C2w==
X-Gm-Gg: AYBFou1tgu+f7kFPbg/WdVSPmXF0S366QgotM4nL2Vr34f9QoExAxXqNI/QmuyZYFjs
	OdXSHwb0ub/HXFDzZ7G9WAG/l4FiXFWyeKjLnJ3/pBy1pmfqx7kIFVEmbM4XrSizk1FMkkaFDqn
	rk1Ulj3g1RTKYOXqYWytMSUbInI760UGfcywMTmGb1YL0rElEmiGiwFxS7+fG1s1SfI2uj4+vCj
	LENvQwDAptNWkXJy1iZXlxgIo3B3qLDQMQOb7soSyPbleWPpU13qRgO2Sm3v0SDD/9VMh07iC5k
	4A3YGiW/9S2LAlSEOu9zWjOzJARlnrJBt4mz04EeyZonLnGYEvTC5uxVl9YqOTjQ9+QIgWaJCzL
	3SdqP5xZZbm8SKvXvY/Q9u9OiCmy7Rr1tDhMBGIaIuVyAZ3JRL8//nlrNxpNOJSALbLwbZCgOh6
	ZTMgMuzYSfU8jF3gbxg19Cw8PHhNzcGIxKNLxOFGZr117hWC9Cu64nu8JDY519W1/H9f2Y4CmdS
	TZ9T8QrV7P6lw58AF1SEF8Zg0pjMWQZWJcGEH7szfOWEB4/XWV63aKZmDiPVbICOmvFWOJm56gZ
	4DBKvlsHooEfS8prtyYbyR0ChHJUslnzkJMwuU/3Obwhe85Q4T6IV78d+/hKMwnB5a0=
X-Received: by 2002:a05:701b:2504:b0:15a:9834:73f2 with SMTP id a92af1059eb24-1b3c0346852mr2790013c88.38.1794421236627;
        Wed, 11 Nov 2026 10:20:36 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:1fca:3f2:2d78:dd60])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b3b5b4efc2sm15239325c88.15.2026.11.11.10.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 10:20:35 -0800 (PST)
Date: Wed, 11 Nov 2026 10:20:34 -0800
From: Brian Norris <briannorris@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v3] iio: gyro: bmg160: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <avSx8m0KegrXO8D4@google.com>
References: <20261102014830.679216-1-jic23@kernel.org>
 <auj9j3sbYa4sVoil@google.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auj9j3sbYa4sVoil@google.com>

Hi Jonathan,

On Mon, Nov 02, 2026 at 01:16:02PM -0800, Brian Norris wrote:
> On Mon, Nov 02, 2026 at 01:48:30AM +0000, Jonathan Cameron wrote:
> > --- a/drivers/iio/gyro/bmg160_core.c
> > +++ b/drivers/iio/gyro/bmg160_core.c

> > -	data->ev_enable_state = state;
> 
> This is an unexpected (to me) delta vs v2: you've stopped setting
> data->ev_enable_state here. I think that's a regression.
> 
> This is also one reason I think it's unwise to make so many changes
> together here. One person's "churn" (to apply several patches to similar
> code) is another person's "hard to review / easy to make mistakes".

Gentle ping on this one. I'd like to advance my
pm_runtime_put_autosuspend() series one way or another. I'm willing to
respin this one for you if you'd like, even if I'm still personally
hesitant to make so many of these changes together.

I'm also open to going back to a minimal series -- that only drops the
return codes, and inlines functions that are trivial candidates.

Your call.

Brian

> 
> > -	mutex_unlock(&data->mutex);
> > +		pm_runtime_put_autosuspend(dev);
> > +	}
> >  
> >  	return 0;
> >  }
