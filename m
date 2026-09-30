Received: from mail-ua2-f29.google.com (mail-ua2-f29.google.com [74.125.226.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB4B5187F2
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792577; cv=none; b=L/lfxuP47Zes9THNMRF25X2lMwtp7rNxYDEWgPUkx3sXzeNYNSmR8qQBa87Or3sQSEmeLMToF5OG5f541+a5Jq08RrFDwHtWqqjDuH8uxHvForZw3RNZ0aQLo9seGuO/+0UExv3ihvtr1SRGAWjHNbKIAhdvv5SMzTu5FEcA9TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792577; c=relaxed/simple;
	bh=2C+bBiPe5DNT+9DNg92+7Lm4v0Aro8GKHfxyHmnKvio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJdlGafdVO8b/LJFWb7ffgzVQqpnz1Bge83HhCynx32l4+FBGeoVa1qtH66A5+SL3k7QkIJa6Oe0PttVsU0pMnlJtnKkRDJSpH6Ojado8KLO39goR9a6mJOAYIxjBI2mHzduK97cYAhyU7ESmvM0lUhkKAOT2J7C1Hwsnh6uSxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9IXjjbm; arc=none smtp.client-ip=74.125.226.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9IXjjbm"
Received: by mail-ua2-f29.google.com with SMTP id a1e0cc1a2514c-988bb9d055bso1285137241.0
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 11:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790792575; x=1791397375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rHAmxuGP8QS+IgIpP7bcBqqzxOp25g01NqU3vCP0Yos=;
        b=B9IXjjbmtq2z3bRyuSNMtE4YewdpYBDWt/MZVHjtyO2vpAUuV6eZslgWGaMbzd+xCK
         HEAYJb0vmqL/Ql2FUltaYlM3DsdE1dSJMphPoQL+cj8UeGUQz0TYhL8wRLKiCt08GCOp
         2dZPcMjVcDFc36yAReo61tUJ2VUdbX3ddjnWjqoEYBLZWNsZBqDEu98ml5JFhjTW7RbK
         h15lwAftzZu5ur2sS0FnunDtVOanTEPBcmo40tTjHQxf3IyuVgzqt0vKVa7goYwgxeAU
         Hf4SCb4vrkgEtaSnTAuUwgm2SPd1VLGdke+dmVlCuoAAQUg82h13IGWZruOfhwiDeMK8
         bYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790792575; x=1791397375;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rHAmxuGP8QS+IgIpP7bcBqqzxOp25g01NqU3vCP0Yos=;
        b=yNYMPfPcWrgMVlwU6bBDAUw4AhMMVfQucMvpAabkGbnZgNr7u9kFxYOpyR3rQEH8sC
         SPvCzfFbFhDWsZ/MjdoUScKLM3wRO47FsittwN05pdxMGROuhEM8jpQC2wELiR5EZHcb
         cHCUmz58SvnzvsZF3n8kQopII2rTFb/UPJmvizm6fnmWVSGh/UID7xJLYLAw97i4GeXl
         jl8Z8bM1FXUCIqXM6gv6vMWMS6Aq7NDYHvkhMQ2mwImypOtc2AIQKSWDQdUoFS2y6vGt
         /F0Da/O8QaoOH697XW57bpYvPmdcAlQP5PbuuXYOO0KFLVqgoB4+w8xNAlWGwjpDGFIX
         HIBQ==
X-Gm-Message-State: AFq9FYJyHb3EU57grY+vYqs25m1m9Pr/mwRM3QswRHgXdVY5eCOvEeBI
	i3WxZZhFbAoqFY4gwbg033B6j5WKNlq0CI9FyGOkM6UuW+C3pzF9DvxOW6zKgg==
X-Gm-Gg: AYBFou1awvVW5H+9e1AwG8AljsjNO2KUercPEBZ0MPwmyxG/iw0//UdcVHgXYIGrRzS
	wtaZlFIVDnKDO7Wrk4AMzpU4PzCHEbwOczNPy+4wmOHQvLVT6itDGk4SgAdg8p476+FritZJAV7
	OyDcU407RT7Y3IUf2WpJjgIFYv9FB/yhAF3rSLvAqwg0uVHcEV/YcTw+2i6QOp+T7oKmyhFaJcG
	1E+Kq0Kja2fn739uJoSqkce1VMn2l6LgAmRji5n5EH9xZilnZjGxZz+K4IMSbHRlwYhE/AL3Kwg
	QgVqkVtkxBB/LdH9dv8t4HmKUIIdtKjG/8Kc5dovvvB5V/m4qIx5177Wo/0N54TRqjap/ghYpZv
	gPcPamxwn5iqIhzmzo5JQHuV07iJrDbAPM6ybhJiTC2khop2yuy27xSNSX4eFZ6twTAd4+zcc4q
	unIzQOIgZVU6vWGepfPf5smAW3vl8V+z3Gw8qRUAruBhjzpmUA+GFMfgEaXwcW2FuQ8Ssx/tehJ
	Rrj
X-Received: by 2002:a05:6102:6448:b0:7a0:f7cc:5045 with SMTP id ada2fe7eead31-7be728b4d55mr731989137.9.1790792575104;
        Wed, 30 Sep 2026 11:22:55 -0700 (PDT)
Received: from localhost ([2804:30c:96c:bf00:7844:c38c:894:4054])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98a86e99290sm681741241.1.2026.09.30.11.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:22:52 -0700 (PDT)
Date: Wed, 30 Sep 2026 15:23:05 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, marcelo.schmitt1@gmail.com
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, conor+dt@kernel.org,
	robh@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 08/13] dt-bindings: iio: adc: adi,ad4134: Document SPI
 connection mode
Message-ID: <ar1TiXPQSO3xCp6B@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1790719424.git.marcelo.schmitt@analog.com>
 <12e5af9d96f6c5e800ad860d3cfa6ac8006a22e2.1790719425.git.marcelo.schmitt@analog.com>
 <20260929230226.DDDAE1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929230226.DDDAE1F00898@smtp.kernel.org>

On 09/29, sashiko-bot@kernel.org wrote:
...
> > @@ -141,13 +161,30 @@ required:
> [ ... ]
> > +  - oneOf:
> > +      - required: [adi,spi-mode, '#daisy-chained-devices']
> > +        properties:
> > +          adi,spi-mode:
> > +            const: one-channel-chain
> > +          spi-rx-bus-width:
> > +            const: 1
> > +      - required: [adi,spi-mode, '#daisy-chained-devices']
> 
> [Severity: Medium]
> Could this regression allow incomplete device trees to pass validation?
> 
> In JSON Schema, property value constraints only apply if the property is
> actually present in the node instance. Without including spi-rx-bus-width
> in the required array for the two-channel-chain branch, a node could omit
> the property entirely and bypass the multi-lane constraint, falling back
> to an incorrect 1-lane default at runtime.
> 
> Should spi-rx-bus-width be added to the required list here?

I'll do so and further test dt_binding_check catches any invalid combination
of properties and values.

> 
> > +        properties:
> > +          adi,spi-mode:
> > +            const: two-channel-chain
> > +          spi-rx-bus-width:
> > +            const: 1, 1
> 
> [Severity: Medium]
> Does this YAML constraint evaluation cause a regression where valid inputs
> are rejected?
> 
> In YAML, const: 1, 1 parses as the literal string "1, 1". Since
> spi-rx-bus-width is defined as a uint32-array, the JSON representation is
> parsed as an array. Comparing an array against a string using const always
> fails.
> 
> This would prevent valid hardware descriptions from passing dt_binding_check
> validation. Should this be formatted as an explicit array to match the type?

Will fix that following the suggestion from Rob's review.

> 
> > +      - properties:
> > +          '#daisy-chained-devices': false
> 
> [Severity: Medium]
> Does this regression in the fallback branch bypass the intended daisy chain
> property enforcement?
> 
> Using oneOf with a fallback that evaluates '#daisy-chained-devices': false
> allows any configuration missing this property to evaluate to true for
> this branch.
> 
> For instance, if adi,spi-mode is set to one-channel-chain but the daisy
> chain property is missing, the schema matches exactly this fallback
> subschema. This causes the oneOf requirement to pass entirely, skipping the
> intended validation.

Will double check that and, if needed, change how the constraints are written.
