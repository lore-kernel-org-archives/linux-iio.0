Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738033;
	b=QLP09XaIeECAzqfQh0DMKGtF2kYHU7GXo11wHvCHHKCTNukbzVuFPdBeCDcn60urx+jB
	 MHIEpINdlo1qM+jgAMAHx5/VogCpj9/RTO9D1/OCR6+26CQSUz++IwmcsMPbf1ftZUhvf
	 /ule9DDtRxoBCmQtXiYpK5Xu2CR4FhgKIdam8nQYT40GxpXKW61PWTPcTaw4jM/eZr3RF
	 tY7Cb8dOutST/2hwMPxRaYChxaDK7E9tlE1D43F+5bNni+37swKPXNR7633KvCBcjKJHt
	 gj3WcCC6zA5WbgcIKR9j0KbHp6T2Ghp8BBkec9PxIYzjjpYJ97B5KNp/Qtemlvbekrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pIi8MdAeFNPPZi1519d1TRfnKE7WeSeOMYcIAex5C5w=;
	b=ikmhFcqoHZnVsbmgufNFI9MA1AGj7Ny1CHB+Yd79NtTMUEthiW5rW42KIYqU2qLoXzR+
	 GWOyVPOCSVvjRLSGHHlTYXxsEoT823yYYSi3g4MCS6AR3OED0Oo4UiWVd2ZsCuuprbCCI
	 WO17htQN2+5BK/Min35R3g7eQH3GyeUrfnZaoORVxW6Ye8hkfVzyci3nXsKNCbpyhFKb1
	 hFphbrcU4piOVhfeRj5+PIMTdWGZntA2Lr8IXDzSMXtr1SCP9NIQE/IlVOXUnbfLzeUSz
	 QGz6fafzDs3D8Vsnh9xhcpsS9pfaVueTkvRY83gNZkFi0G1Q0BCQXenEgD3Hh+PVScg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WrYKUUeK;
	arc=none smtp.remote-ip=209.85.167.54
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C39606A31B
	for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 06:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78C39606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WrYKUUeK
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b8f5e2ce5eso565096e87.0
        for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 23:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792738032; x=1793342832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pIi8MdAeFNPPZi1519d1TRfnKE7WeSeOMYcIAex5C5w=;
        b=WrYKUUeK1wAUN0YSD3859zM1x9INQBLFaKDfd/J/HNg68fzU+DejXhaFhHpeym5mxf
         rA2CyHX4NdIYHbc7g6Oqdea5tgdFnxWQdstK2OQMgD+oP6xLiqGH7Nfu/GjrjZejCbBH
         dGSZw1aMinokzAcax9UmLdsA5rxMSnTMwg9W/GLVlJy6Tzxvm7eCa7LuqXnRwjZ5Dc9q
         RzpxpweKS0gHSVEQCkCHMVkHdhDKlVQqcIvwgKjGy6xdd/gAxjnss9IonXTQG/YYmzSm
         UbfW0LusbyQZvem30e4cYKxHwFeOC9Y2iej3vTEeScmC+Uunvc7h0HhamiWPpKZk2nO/
         Se9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792738032; x=1793342832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pIi8MdAeFNPPZi1519d1TRfnKE7WeSeOMYcIAex5C5w=;
        b=FQgkAlSNvJMg8Ke/tu55BNUeZULo4h/6p2dza40HXUgr8DrcrwR9kooFsYmHP8CVmV
         Zoc2l+pcOIvd/77JuMIj1MNibBv6Xoo2gCLrEuUQ3Mc0enbRDhjRcgmHTi8s5zQ2Oclz
         A//DFfrfUeQzAkWH0hTg7jvlmm/HlO4TzAy8S31pUzpxZSjAQ6ayC6vfudgBzPorwAlR
         EkFrUFQaDFTD4domM0sCfO59GvuWWy+80Q2H3tSCFpzlpMBzPBSzoD/6X0ywrBEdxnKD
         BMxx7h71BnXAdMCULJgInaJSKlb5cSG8nwNp5txBIixOVipUqw1RmWejdXZuTNozcYhc
         zjkg==
X-Forwarded-Encrypted: i=1; AKwUvBx2GhFP/CbL7MP2s+Xr4koSF+a74EBRlcDxeH1qSr9PUHzfvC6TT4uBXJs15dbi70/CrvRtxAH+UJI=@vger.kernel.org
X-Gm-Message-State: AFq9FYINkKec+2Kpnudb5H45PdevDK9L+LDSq75onc3AZVSF6FyWYezj
	wiWddhAGc828KTEkUsqhDCE77Fc9zKQaZ78PcIep/ag0pfPzexjgE7zc
X-Gm-Gg: AYBFou2avJFqCI7LjQJmtlVqfLJNah44eD4Tyw7O8apn2/rIa0H8gdcAgOyA+rcL3x+
	ROS7Y4GHw18pRWwQfUixF2Mvj0PL4DZRwabenMGLwV6x1C/3VFS1VNfQk6ZTb0vzse2eRnUDhEt
	55RYdympvOCm+TiE5duBs5/WjNsji4jWO8xdSREhPUzdDi3v0CXTa2+g9nvw61h2VcnPcKVaK5p
	b5WFv+9F/PB8XVxnJ0ZMZg8WvHvwRq9/VPTZax7mZfMEKYpUP3YG0H62RVA69JFerKmmAuzYNe0
	8UgUv/VXSL7J9gD8biH5hrW1yPityyurnOnE6jthufuAws+imK+kIw6LA1GL11e1thXk+rGXXQ2
	J3sZe5PE/6XdI4H/cIV2X78vXO+hCzQ6EsTAVVUixOEVsl6hXpA3b0SUgY/a5krbdw5TMuA7Hl4
	lGOvmz6QNWwNYmzT/EYwgYMtJpjXarWeanyfZi8MbMj/ofJe1MAyZFKF5CdxzhqOf9ozj6EOCu8
	N6p6oK0nK2qDUtslmS2fbzj96TC01Win8T6dbLGN6lCVFyNfexaRA35Oflgh2qQ9NL3utETPgw/
	JZ/ys0JPXqu2pUjAcxBjruVoCm6GfMpV4Yrp1Ma/KMk6Vw46kPMIoD5FgHXeRKX6
X-Received: by 2002:a05:6512:2c8a:b0:5be:414b:a84b with SMTP id 2adb3069b0e04-5bfb0abb0fbmr363051e87.51.1792738031443;
        Thu, 22 Oct 2026 23:47:11 -0700 (PDT)
Received: from yantra.. (nekmmqug0dsu0zzscv2-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:9db7:a72f:37b5:1f1e])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb027372csm246233e87.14.2026.10.22.23.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 23:47:10 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: jic23@kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Marco Elver <elver@google.com>,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: qcom-spmi-adc5-gen3: fix lock annotations on mutex helpers
Date: Fri, 23 Oct 2026 09:47:09 +0300
Message-ID: <20261023064709.77180-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021202433.0efc7979@jic23-hlaptop>
References: <20261021052435.112686-1-zoone.rupert@gmail.com> <3f41338e-fc47-4306-b68b-5a81c26027fe@acm.org> <20261021181944.14272-1-zoone.rupert@gmail.com> <20261021202433.0efc7979@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Oct 21, 2026 at 08:24:33PM +0100, Jonathan Cameron wrote:
> I haven't tried yet, but I think you said not much broke?

I hadn't tried either, so I did: CONTEXT_ANALYSIS := y in every
drivers/iio Makefile, on testing, x86_64 allmodconfig, clang 23.
255 warnings.

240 come from iio_device_claim_direct() and
iio_device_try_claim_buffer_mode() lacking __cond_acquires(). The rest
are 4 in industrialio-core.c and 11 in five drivers, none of them real
bugs. With those annotated it builds clean.

v3 would be this fix without Fixes tag, core annotations, one patch per
driver, then enabling it for drivers/iio. Does that work for you?
