Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C56654705F
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798365; cv=none; b=hjca1Q/51w8Q/5EgKBkDDEVe0RjckNQ16ez639Pay92k/fWOS+gj7BDWJvbmSuaosNlUh3Snl2h38RuGpenRTnhb22PIwCfoCzefgNiID5587GHnKefXL2KJlKAEzOZsG6ABn48J1VLoORKXhv5Wpk0sTxbTGVHWsvFvQq8P+yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798365; c=relaxed/simple;
	bh=IxDoNCli60KtOg3+odC/CQMJTv6w8XvqkxAtEahBsgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rN6HdbCUXELNBbPBkFkqFt5KqpRQBrApB8FllJ0WND9Y2tN0ob723ZpV34gxIuL8ZLbaIHmdMENOLW9eXs2BRRFbdZMmTthhhIP0kcKcdEIptyEqcLXXv5OK6DbsN84+KGD4sEgUgfCIjDx79kh2HYCI+u3H5TdZhuZQU0khWhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkZ84HK0; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkZ84HK0"
Received: by mail-vs2-f43.google.com with SMTP id 71dfb90a1353d-5ce4d8751cbso1643581e0c.0
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 12:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790798363; x=1791403163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J5spSizosrOmpK8SzSSYeLKeSXZf2rKWRXHBMWYBveo=;
        b=dkZ84HK0bri1q2vaczZMGxz7cb5I4HK12p1QwpM3cTJb9DUO6YpY68MKcnwQZkoUp8
         GQXcq/QzArVdEkRcueS29tzD67xZozNh4wZq3ZcabrSX8OOM+fbKTNZXvQLSQN0UuiM7
         Ev1Q6BxSjcnrNqM/Iyruaklwz6yzknC5X3E7mAq0YxQYRYlXEv374td5pGKaFJLSne8L
         VPkUY93sbpVmeM/vXTMsevi8yp0p9VwhGNuoagdKmaQylcuih5A+4QZHfNUQ8Xk8KTD2
         Rqw5oY6QNiiPgYdN/S0Fm0D/30jWG2OCzURae/YYkbbadWYkPst+0ntaDo2Iu3O3izXY
         LUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790798363; x=1791403163;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J5spSizosrOmpK8SzSSYeLKeSXZf2rKWRXHBMWYBveo=;
        b=Ya35J71vHQW0SSmzhrVqVmCCiAtLNL7MuQEUmGDmqD6UK+R5zGvLticFbT7mQBJIDO
         6NmJFnJ37yfYUOAdQ3EZg8/a4FIrh3AjbP4HTxaeQLtv37MMx+qvW6coZNb20GObLnW3
         x5N16pFpxFj3USoinPdD0dhJoy58VbES74UjpOStlVO4PSPVkVUzufFqKZF3rLNyFbAt
         rSjpmZIrIhKN5Qn+hpyfHjp1DUtvYjlQO5p8s/OCR8OVhwlOKVKbgjEJNPAj7Y32KlNV
         3IOokBm8I3EcsAKJR7QQijwlJEqfxr6tB9Irqpk64qWyhIu1kckIN0c5PB6fEe41Wpjn
         6giA==
X-Gm-Message-State: AFq9FYJ8j/wzRuYJUHUzu+23MqBUIAviJH1+elk0pJsP6TLhcjPVNUSb
	vHyPKFGuae22xc+AYJ+Lmc0mPw5dhWkGUwPq3XWvwKACNJxEqdfL5C2JMMFmdw==
X-Gm-Gg: AYBFou26kYc7/b0ZdhCfWLnD0/QFPS6Zg9fwotnbN9OfPWI2a5sWxbSEUXxpHa3d7sL
	skj+P2J5KJkY3jJ27iNcQatVwNaQiGRRURkLn0hdbERcQrCyXzWQk+IEJ5kGt6kLBDrWuoOmoLI
	ZBJ4WFwTvJyroqmU/54DT6Dq+pxiq9iExwDLlDHU+lIx+seDmXIF1+WpCAswNVc7htKUVaof/4q
	fLikf/FBLcDzW/FbBPM/+EG924UfrlNuJ9w2+cZwwZawBzUgO/ROV8iJ6qPVmH+dyNrkSA8vMyE
	J8kTvCLhZXGdtC9aibTxGjM54oUUdppJa6vFciHim6shJfQCXdcFV40jzkzojZkpz5n6NsBN+HA
	+VLN9CpcVnYsFX7PzpNcYQloRCTjQwfBSsTILT1LziFu5Zf5obMkiI8t4WKKa+BAqWn5QC4aev8
	HyPESPPCmJYikxmZ2mtKAVTFdYUjZpM6a+22BvwUGrAFvb8YA8yPdeQ0HIsAb0SvZDQ8nlXrqiW
	9uOZfXEV7lNJ9M=
X-Received: by 2002:a05:6122:e26d:b0:5c9:c60e:f4b5 with SMTP id 71dfb90a1353d-5d67ee922b4mr906149e0c.19.1790798363052;
        Wed, 30 Sep 2026 12:59:23 -0700 (PDT)
Received: from localhost ([2804:30c:96c:bf00:7844:c38c:894:4054])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d7fa498cc4sm481660e0c.6.2026.09.30.12.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:59:22 -0700 (PDT)
Date: Wed, 30 Sep 2026 16:59:35 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, marcelo.schmitt1@gmail.com
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, robh@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 12/13] iio: adc: ad4134: Support high-speed data
 capture
Message-ID: <ar1qJ8LaNaiYF3a5@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1790719424.git.marcelo.schmitt@analog.com>
 <60682dd6c61806bf0d024d242c62b39a349db4f1.1790719425.git.marcelo.schmitt@analog.com>
 <20260929231610.BA7C31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929231610.BA7C31F000FF@smtp.kernel.org>

On 09/29, sashiko-bot@kernel.org wrote:
...
> > +#define AD4134_OFFLOAD_CHANNEL(_index) {					\
> > +	.type = IIO_VOLTAGE,							\
> > +	.indexed = 1,								\
> > +	.channel = (_index),							\
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),				\
> 
> [Severity: Low]
> Is it intentional to expose the raw voltage attribute for offload channels?
> 
> The IIO_CHAN_INFO_RAW bit is set in the info_mask_separate here, exposing
> the sysfs attribute. However, ad4134_read_raw() is modified later in this
> patch to unconditionally return -EPROTONOSUPPORT for raw reads when offload
> is enabled. Does this clutter the interface with an attribute that is
> guaranteed to always fail?

Oh, I should've done that. Will change accordingly.


> > +	if (!in_range(freq_Hz, AD4134_MIN_ODR_FREQ_HZ,
> > +		      AD4134_MAX_ODR_FREQ_HZ - AD4134_MIN_ODR_FREQ_HZ))
> > +		return -ERANGE;
> 
> [Severity: Medium]
> Does this validation check inadvertently reject the maximum supported
> frequency?
> 
> The in_range(val, start, len) macro strictly checks if val < start + len.
> If a user requests exactly AD4134_MAX_ODR_FREQ_HZ, the condition evaluates
> to MAX < MAX (which is false) and incorrectly returns -ERANGE.
> 
For cases where the range doesn't start with 0 or 1, in_range() becomes a
bit harder to read.

if (freq_Hz < AD4134_MIN_ODR_FREQ_HZ || freq_Hz > AD4134_MAX_ODR_FREQ_HZ)
	return -ERANGE;

would have been simpler, IMHO.
Anyways, will fix this and all other issues reported.
