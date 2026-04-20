Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBA33B7756
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692365; cv=pass; b=ObrGF0ZM/VGUlxJr2eVufSVewHRxNUQ4028VDut7vh437yzqOIFRcr9REUWU0OUza7+3AQ3tRlj5ayy1Tj5FjIoOgDFYHkk97lfqbdA/5kZQrEJLFyPdIOvbVs6XibqOca5m9oG8akE+iXQL5q2jxa5R59I4vfULlEYedbiSaH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692365; c=relaxed/simple;
	bh=O+/x8AvmMb7+rX0uK7+niBHBwGIx7nhJpHuy4AJ2c0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWCjNXHBODRPKGOFlYJ8vVbR8msOpzFyBO5WofbSYgQTX6w08NqLLZk1VnZBJFeHQnvAjFZ3T/HhVD0xbYgD7HbkRm2nPdxdEQhWaOfjBaFc9drWOHutuWfkwRPkZsi0/VIxJQawcmQJ7EIVgbY7G9FHHVbxA91nJCGrPvaoOVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlDIV28j; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlDIV28j"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-40ef10ec84cso2464618fac.2
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 06:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776692363; cv=none;
        d=google.com; s=arc-20240605;
        b=Re0OxTXQXWZWuNpoLiMmwo3DQMccNQbZOi6/mWYxc77pgJBTleNWuVsHj01lHE3FjR
         XfzmVAlC05rRpntzV5Isk2F3WavRXMEqwb6ylGRROWJmVzdbRWr0pCK4J3BN6+abDGCC
         CFl8wRccOimkawoJUEnrkO6M97QfzRLUAlmoZp2D73voLGSitEZOjnjLpFDFcNsO+xtF
         L9cNO+j4bJkU40w483KK+Yk+w3v9cvVkAXnNZD+eNzAznvxAO/LB4ukXAEJTZ6n68Bpm
         +219vViDLSnShKBFBFW+SDmVfOtb6skcM86MdkawYrM9swzl8HoMA0Y1V5+0jFc50Zkp
         /y4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+Sd3d3cpNtLYAro4qMWTE2P4rnOA83jC2nXa7sXMDDw=;
        fh=WDQY2ohnGWXyV4pNRlgIHSPOgqQFOlWWJcYuSnN4R4A=;
        b=LZze2X4zLus4t2UOkBQVrCUqufnbNSSLch+zS2vvTE7TnAPFWCQouIs25xfOm/iJOl
         uwl/cEcVbBbRV2SIZb1VvWVyj/HgMa1kckCoEX+K/NXrYotyP8C4uqCLyN0mLG7eFS0b
         zRd2DxtS/R1NwDqEtU+p3nwW+f4jt/QFqmlTzaD38W4o+MFIdenAOiAFJZ+tvKbp60Op
         XDBYoTYyZXiyH4OFAp0f2jBu92MUUaVapndX47vj7/aoXyjyp0gPa4vqgrnS0KfUiYAT
         w4C8t9eunaDxCbX6vv1UD3jAFWoSLeYKpQFW3vQI6xYKY0KsIltNJ0Mw2EKOM0xSju/r
         yp6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776692363; x=1777297163; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Sd3d3cpNtLYAro4qMWTE2P4rnOA83jC2nXa7sXMDDw=;
        b=ZlDIV28j6jbgzkYfz9iLVTR0ZM0olbqc2twFaSdNaj2LtKg4T8mePPBjSoFIuZvOuY
         Fo58f8nztrUnCM5iKTS1VnJIBBRzxvyyVVQ2zNdpgzjsjZ9KRpNgF12k8yoUZSl3xdzS
         SSUAD7ldsGR00Pu/sAOU0MDsYY+Xvb1ajP0tq46WIfX5jclD9qVbrTfklP1FlB7HF7Lt
         0maDGJi3DlHoQCWOhL/5eQd0r1QMwy6RCIvNbBAXnEcdjPwLrAUKVOVo2o3Kz/tHEIri
         f4E8q7u5WNKM6UguADcBG3SMl0VP8mFODQzqdRVcEItU6c6aT5HoRuMFfyMtbUZa/Q7P
         LHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776692363; x=1777297163;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Sd3d3cpNtLYAro4qMWTE2P4rnOA83jC2nXa7sXMDDw=;
        b=Cq3ew8PCzWlHG99dCRO0trnoro0WrZwy5UiNoMnN7G0Hbq65iyr00jHs8iZSzzCjw6
         qpDaBsaQyGlQwEInFFqj8w6zUI91M+GY5yiupE5aBn8rNM617Kw/epswiaftnVJyP2Bu
         Tdqkv62Zy35mRxataWcXsr3orsXpwyZ497Jt0ghY6Grz9YJZ9CPR4033UFJntcinGZt8
         /yyMKqt7W2hoj1aBLVUuGtCDIRrcHeqKvC6mC8w0d+uxS9cz3t79Th7lvpERvzuNBvPW
         EX7bzq7xOHlSCDcx1Il2hd2mbsj5+yphF3uDv3Cm75p+FSMJF7xSJbhpEJf+DnTifLqr
         kOMA==
X-Forwarded-Encrypted: i=1; AFNElJ+U954X/gWLyv4WHJzciRin8JP+17IHr+NcDjYpo329xCF0+qewylYPqC3ZVh6IHmfRQCTQe47gOBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ+GJ1voBjpMqAprMU8ksHyv+O2gsstYrwpO8nawX6CsUs7wZK
	e+3oZdKcH2smATLSFgzWa3rTuhZcCTBS/tkAu5IMJExirWv6Qj3ro8u7C0PJsgrDWyRc2wYHbC4
	jDGUnqPkRxSHVjgO4u1bncL9QiGrIItQ=
X-Gm-Gg: AeBDievV84zu6W4bMIfDqFB1tXAD2naq2Jjpg8o3RXsTs3zKDORZVpTJnVd8ujdV2Mg
	Srg6Qlj+g3sgiCyImeJaAgdCjrxO3d3E5IZJ+qxzdXJoXdUVcEqNKhjZrA9ALcJDKxWxJWdWc8R
	GIQ8Na8cTAC0ekK3jqIrEwnNqys/FZMx3tddECCkO4pfmFskwnL0CyBvd3/z1whrSSBZ/OjQRhP
	DdlIdfGMu5o6HokqHTSbbD6ZVHfPSeHwqH4pXW2TQX2WxC32AAMKEeRxmeY2DAUhNS+MVovSZpx
	qCYLfjdoFpoxyuzHxK8PvHvgRY2fkMQe0GtSLevPQGZaxYYh
X-Received: by 2002:a05:6870:d8cc:b0:409:7a01:6e2f with SMTP id
 586e51a60fabf-42abf2eef66mr8177587fac.11.1776692363371; Mon, 20 Apr 2026
 06:39:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410193737.35905-1-devnexen@gmail.com> <60c2cdbc-2ee3-49ce-8a94-590230899cbc@baylibre.com>
 <20260420142158.2d8b05e9@jic23-huawei>
In-Reply-To: <20260420142158.2d8b05e9@jic23-huawei>
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 20 Apr 2026 14:39:09 +0100
X-Gm-Features: AQROBzCymbI2-fFWH7slMTP6eriNyPrtR7E32j8ay_OcJ-TLG6bOa5wFcv6C8Yc
Message-ID: <CA+XhMqzMfheQrwsDKHR2d8pTckn3+ZSZrkvYLSkmv533472OTA@mail.gmail.com>
Subject: Re: [PATCH 0/7] iio: dac: Convert several drivers to devm_mutex_init()
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Kim Seer Paller <kimseer.paller@analog.com>, 
	Cosmin Tanislav <cosmin.tanislav@analog.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan and thanks for your review, I ll remember for next times. Cheers.

On Mon, 20 Apr 2026 at 14:22, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 10 Apr 2026 15:03:33 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
> > On 4/10/26 2:37 PM, David Carlier wrote:
> > >
> > > This series converts seven iio DAC/ADDAC drivers to use devm_mutex_init()
> > > instead of mutex_init(). These drivers currently call mutex_init() in
> > > probe but have no .remove() callback, so mutex_destroy() is never called
> > > on device unbind.
> > >
> > > Same pattern already accepted in iio for other drivers (e.g. ad5446,
> > > ltc2688, ad7124, ad7606, vcnl4000, etc.).
> > >
> > > David Carlier (7):
> > >   iio: dac: ad3552r: Use devm_mutex_init()
> > >   iio: dac: ad7303: Use devm_mutex_init()
> > >   iio: dac: ad5758: Use devm_mutex_init()
> > >   iio: dac: ad5755: Use devm_mutex_init()
> > >   iio: dac: ad5686: Use devm_mutex_init()
> > >   iio: dac: ltc2664: Use devm_mutex_init()
> > >   iio: addac: ad74115: Use devm_mutex_init()
> > >
> >
> > Jonathan has mentioned before that he doesn't care to take patches like this
> > unless we are making other cleanups to the driver too. So we'll see what he
> > says this time.
> >
>
> The one time I'm more flexible on taking small changes is when they come
> from someone new to the kernel.  A quick look suggests that's not quite true
> of David, but David also doesn't seem to be an old hand.  So I'll take
> this set, but no more of these please unless part of a more general
> cleanup of a driver.  Maybe at somepoint in the future we'll have few enough
> of these that it makes sense to do this for all of them, but right now there
> are ~300 mutex_init() calls in IIO and don't want anywhere near that level
> of churn when there are more useful things to do!
>
> Applied to the testing branch of iio.git.
>
> Thanks,
>
> Jonathan
