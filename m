Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792754121;
	b=eyeXGYw3AuFLAu9lrdQwQJF9CAshuMlje/tUTsDGDQreWISrE+kUmGZ5AB7/W+g6p7DB
	 /KKG25m2juyTMRnNdqaBQ/iPykFefaCvSLS9pQqISYp57c7pRbOIvvnaOJrwvYmqHq6+G
	 T334MKwhzn9Qy2T22yu4S7lsy5eF1Btq/ibJPE9fkXFGSH/axSWl/6U/HBueEBwpsQJFB
	 Ole8GYiBlWffuxdghfLmuDogaTwVoZJ7eBJEozLCVY5vAVLzZ1wq+C0tk9uunir3ESPxV
	 Nsvn0Gcof3rW1bmmnrjxPiE6Fs/7rCCPqvd98lRiaZ9Wk1qHIk6rWqn6XY4udaX993Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792754121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jIxHZGuZV2ahnY6L2CqzTw2j0WYDDpMIbxX1aENaO+s=;
	b=RkOSaKa3fNYPK1qbRvLZXgTaQDi2/RPXuBFQCWSRux/x0+ABXxTyizlT/5K+OM21afbV
	 aLzXwYPdhAj/XWQFq1hheOtJ9hyubO782fHJ1phHMT/MfiSMQuXxFsW7VLdpMVVdH5Nfz
	 kOf4jmEvVPVMiI5Je7aMWajYHeYnw3vHlxOrPoVbGhElXfET5zbL8nkQS/3k90SaHF1fO
	 ATAEPX3ld6/dDHg/yW6qC5LphndnZmxubTf9wcq9IM6K/scO+gKC3acBR7JWBL1a9A7SY
	 tm+1pR1sxsrbWCpuqtnPJJjFb5FH9FugTuNJJA2WiN5ujPn3rgejh1jsEktgntauAjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gB7ZU72T;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B87606A327
	for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 11:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28B87606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gB7ZU72T
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ccce6d9abfeso499243a12.1
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 04:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792754120; x=1793358920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jIxHZGuZV2ahnY6L2CqzTw2j0WYDDpMIbxX1aENaO+s=;
        b=gB7ZU72TlDrjtJg2VoknUpiMrc5WLYdiqf4lkuMe3uifTtYoe7UpNL2lsmXJmD9kvH
         SsLAi0bz0acbuZguvc/MJxABOwXflROvoJ8fXKuCex/V5dfSWnupFH2RRwK3EOJ/0Bge
         6F4Y3MDGJP6oj474/IOPZ1XnA9Bd43ACAeZzQ9CAx/aKusmx4s3DpnEIg1st86GSMR6o
         S2TXN+ak0DiSPieJLTyV8uyQ3co2B/kCLvqlJA3wcwQFQFtCjjXuv6dX1SqYeofFleQD
         vgTpIYXMp/KtAvZtXa3YCiB2P4VG66t2hbESu+Ea3WYI63IPpSbD6lJiuDhV+6rcB48z
         AkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792754120; x=1793358920;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jIxHZGuZV2ahnY6L2CqzTw2j0WYDDpMIbxX1aENaO+s=;
        b=RZBmKk2z27CH4lOhSzelpPz6Ns8+ZPF2OAHl/CFwS6jGJcq/C8Wvyx/H5M6LEq3jgA
         bgbS6E3IUitYwYd3//hKv/JkdRRkve+fPGZGHu2G1Mvo4DHxzh3Rg1JdyZx3d5cDzExA
         VVdo2L15r1a5qAjdzRpWDSfX/JCHQEU93vKh3jeLoh9sOyMY940c8FL9Vb9/OH+Mm2Pu
         DLIP3kNXupeBEvHDQ7vrusqeoVe9wgq5gsQCmR9kBuvvYUawoMJl7EGlBx4KOEfS5OJu
         JzMsTkvtCu/q7SAyQ48XXChU2DwxyMMXOhHg3AkqNK+f5dQHvsyj9Ty/OR9yo4McmVpX
         XeQw==
X-Gm-Message-State: AFq9FYL7lAL3L3jbupJGazjUWXweXzjmKI20igzHl1jpzDG4Y+5DoG0Z
	QUxe8n1u4si+eZL9Xql90Au/MWTOM2vTLbyp2FBztwvxHV/AGuqcVDXg
X-Gm-Gg: AYBFou3NgoWZ/VU+//WBbir9gT7Uhf8P+e57E65Gpv/S5sv2dPdfjC1CCHyMapf/JCQ
	Mjqka7eN+CxLL6rYtpnn+gQWVlCOZF5h1Hw+4+y2dp1VZ/4l3g+wG24UsTZ9FgWJwj0J/KRohGx
	/8s2yrxL8Y3eK6NRP45VQesRAGteFs43PgPRVTokere7EJwQYNd0rIJXp30mDhCUZ/WxjbG/HNZ
	GGQKfWRWiEziuiZiq4ikHWpx09EpLANoz5WXLNLizcV08P/WvpmIXgtESCsPfW0ijgVdgyOu89g
	rTHa05UX2Y4i/46j1LtBDDKAg1A/FuBv3IeMMwy8sXqSuCaXkW+ZiICAzJ06jIf7t0nbf9yjYtI
	6aIM8mMkOFw5+2DKvThQ8ZChg+hq6brKuynLlA5Q/Zv8hQ8o4jLpFX4zAFP5MSSMaWHQftxitM7
	u/6t2AiB0wENz//NB7LTt7FiyskoZMw+ka1bQfBS1IB4RTOPfpFc4t68wqN4KK7YaygXkqysyJZ
	3jYFf2KNYySCchzW8dSFWPlW2kN5sUvEqSqspJ/IaUjngJxbla7Xjnfovp0smRpvX402qZKoot7
	PWoJ9YM4RApywFBARG68dwkK+ms1PuK0dNXvwPh+BRarquvWP28=
X-Received: by 2002:a17:90b:3f8d:b0:3ac:7556:8ee0 with SMTP id 98e67ed59e1d1-3adce7a5a5amr1475790a91.19.1792754120415;
        Fri, 23 Oct 2026 04:15:20 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (158.95.44.30.netskope-rdns.com. [158.95.44.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3add2ae880fsm1037959a91.3.2026.10.23.04.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:15:19 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Fri, 23 Oct 2026 08:15:07 -0300
To: Conor Dooley <conor@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 03/10] dt-bindings: iio: frequency: add
 adi,ad9910-axi-backend
Message-ID: <hx6lt2u5j5yh3iez5zimolukip4a6ak36rdqridrvaz7bb25hw@6blwtzy2iuat>
References: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
 <20261022-ad9910-backend-support-v2-3-0ff7f0bff326@analog.com>
 <20261022-banish-scenic-030717ca503e@spud>
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
In-Reply-To: <20261022-banish-scenic-030717ca503e@spud>

On 22/10/26 19:38, Conor Dooley wrote:
> On Thu, Oct 22, 2026 at 12:19:01PM -0300, Rodrigo Alencar via B4 Relay wrote:
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add bindings for the AD9910 AXI backend IP core. The FPGA IP core
> > interfaces with the data and control pins of the AD9910 DDS, streaming
> > data from memory via DMA into the 18-bit parallel data port (F[1:0] and
> > D[15:0] pins), which is clocked by the PDCLK output of the device. It
> > also drives the PROFILE[2:0] pins and the DRCTL pin, which controls the
> > slope direction of the digital ramp generator (DRG). The DRCTL pin is
> > driven by a PWM generator, so the IP core is described both as an IIO
> > backend and as a PWM provider.

...

> > +  '#io-backend-cells':
> > +    const: 0
> > +
> > +  '#pwm-cells':
> > +    const: 3
> > +    description:
> > +      The first cell must be 0, as only the DRCTL PWM output is available.
> 
> I was about to ack this, but the wording here caught my eye. Are there
> other PWMs that are unavailable?

Not for this version of this core. Other signals to control the DDS could be
modeled as PWM, e.g. DRHOLD, PROFILE0, OSK... but that is not being considered
at this stage.

> 
> > +      The second cell is the PWM period in nanoseconds and the third cell
> > +      holds the PWM flags.

-- 
Kind regards,

Rodrigo Alencar
