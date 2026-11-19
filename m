Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795099923;
	b=BFsq7M/9haUVhRwl6pxF9zhSPJBGdoNpZQXD3SpRn5VyhiM9z7HSZPylHj8Btigh2Fsh
	 dHah0q7vylwThVhuEHmtF8T4w2QdDfCdR1rXbeSEH1hYqPil0Y2I1M7WNLl4OXxa+S4dP
	 TmflPLzVzGWmMRfx0g8C1E2sbDs8DvtZoeYuSB8rIKJxS/FsW/ItkXn89jSESifdyRRAg
	 qoi9rpXoLTmZkEXaqeSrzVEYK9PP5eZ+XK6EPOVo82d2KeiM0tVp/umrhn1Kl+ZDQiLpr
	 HCtAxgvk5dItUbd1/qePu/P2CBvjxQEJcnbm2AP2g1zd7MIhH83o+5TPPmtqn4obRUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795099923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=sHDi3n/DwJusFdRaY4+52UP/45IKh0P8pO8s1HdZiBM=;
	b=btvapCP7417WQmWc54fgSjZ3kJvgpHCVZDn8hjJWcJd0RSPqiSnMLfW9TVa8gdsM4ehV
	 w47k8dwkhEvfzG3vYC/N3uLC0+OaGW3lEXhrUopQjmgHQ3HU0H9VgxZZFVzkmtxINyItf
	 eTzgJz0hIkKxskxCeQmWeDSDI1KDKV+4FFg7DWCYIrPBNHgrcuTgt8WmPbhW5JXEYxLge
	 6XJ3uPFfc+0dX/q2Ro2JC0WRCFVWOjagmJqXJa38nbSH71zuxxK1IJA1y520VkL/4iU+6
	 DlCcFyl8cHuaEdOJtKRzX8MQ6HYd72nhrMZSH2+f0pIj9n5QBZrhBLpM6OqRKR2lTOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K33iAVDr;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A44606A324
	for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 14:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50A44606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K33iAVDr
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7cc0ccc2fddso839648137.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 06:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795099922; x=1795704722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sHDi3n/DwJusFdRaY4+52UP/45IKh0P8pO8s1HdZiBM=;
        b=K33iAVDr28WuDqdsKQ7c6BaLdM9PoKWwfFp/RVmBN2ruREIvpWU/CcVciG2GuHy/XY
         XOGuT8cyqW2Tr0sBsK3AEPFxOW1Tjq5imWBh0v75DOPsRzT3H+UFzClalx3Azancgmrp
         A/wMT/ychNoVIhpGSgg3HskeSpanL20YKxOLgu2dEcqlRReo2X+2IS23fygsWrx/pS7g
         gQkKP4lZvrEbArMfchoiO+q9vIwcMFnjhqR6+PMZNCtpvEwUnmze5zWfKGVUKHdKipUA
         F3cVE0JSC618twvZ2hmJq2c4HgvBPqc8qdngMWU8t3QnTe3soWwgSEMFi+/LjI3t2ogA
         avtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795099922; x=1795704722;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sHDi3n/DwJusFdRaY4+52UP/45IKh0P8pO8s1HdZiBM=;
        b=Blnysple5W6m/JWM6ZX9fFEq8NIU0fOfB5SRn+G1snOofvmG61MpzyVQOOiMPbfEaH
         GgaezbwuKSDLS4XmLmYEiFYffoD14l3rgawsnMaAaAQDLO7zFFnfKPwGcX92OrOguQ/5
         BuJJPMyS5NWV5KMCAKeKwe87SpXUnizATaEN4cK8GETj57NWj2FmGEWCoPzHh7mzPEuT
         Cc5JEULUDKX1swtARho0JGaeFi4qE/2GqZgV8meR7+onzsNyxP9VBvE+rR4/Rrq6zvkH
         ARrKEkdOAe1frikJybhvrD3l855U/Gl1FY5RdQkwM50QGu4uUCzknb+fyGpdzrjL7YC/
         Br2A==
X-Forwarded-Encrypted: i=1; AL+hErFvcZRfaR1JBVuVbfDRnRq7/90GvBvZ2MShZnc3pTqk+2KXiODjqchlBNdjorWkPIQ8I9Iihy4jqEQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8Ueh+W8oU8ocLSzD7/1bWVzdUa5OHVbfBP/szOPj/+CfPAL4c
	25clU1JfYeWY8Ii244qA3hRr2cQW3Wq1r5EuGkLun8wzuRMpfTb+KnmQ
X-Gm-Gg: AYBFou1Xk9MpxyZLr1sfF4AUVISrPrMqXKK32J1bD8P4dd7iCuoJquvrZ8tXYP+6CDe
	liveoAL73RU2hNgnneg+4h2Q4kmgTeEc7Kya7DDc5cxgXESevj+7EKz5Ys2DbVNNOEILPsoHxJA
	01skcBKtkip521PdhXrYy0HHwRAljaimq2Hayzdcw6g4t8YzvnrrmALjo1seDQNr4zkdLHLjXFT
	SpApA+oain6G2uXL75xSws5aEz56tON092Uf/sSJT3GWcQDP6o2eYg2e4wKqhMX6yx7d34RNUdD
	w6m6+19Q75ZSB6zFRSZp+vMRDn2ga6sG1suiEmtCoKuMICv/rLH+toqXORTR3sS7xkDT/70Q8tt
	YeQQdAl4QXVUgLbaxJBHfuSc5uEI17lqPjb5g1J1CV7LnSTB9CbsDCfvYqey3vu6GWvULzaH0Tx
	cUDqd75qb4//5c5EJeAHaQgNbG18t9Z2r2H367abcSod7R4uL5GKM7TxvRJs4L1wH3ZEy4Vkw8z
	ryRKaf7sgCJoh6bJBu6+/jW44+Gf71/Kf0jKupAGbfqrWXQteikuvu8ZIm6Bz7/46F3xQ/kGWEX
	HomG2nopCwZwhkzBuZWQoeKNsP4AHxclqXE9
X-Received: by 2002:a05:6102:6044:b0:7d6:864a:5509 with SMTP id ada2fe7eead31-7d6ba43b12fmr2019264137.24.1795099922016;
        Thu, 19 Nov 2026 06:52:02 -0800 (PST)
Received: from localhost ([2804:30c:914:4500:cd15:65cc:e2cc:7363])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6df8a28dsm150070241.4.2026.11.19.06.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 06:52:01 -0800 (PST)
Date: Thu, 19 Nov 2026 11:53:26 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Conor Dooley <conor@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux@analog.com,
	Michael.Hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	olivier.moysan@foss.st.com
Subject: Re: [PATCH v1 4/5] dt-bindings: iio: adc: Add ADA4355
Message-ID: <av8NZpVuodpXM7GU@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1795003864.git.marcelo.schmitt@analog.com>
 <c7be62089d2b54dbf7fb57cdea189bdb1cade7c5.1795003864.git.marcelo.schmitt@analog.com>
 <20261118-liver-decompose-434eedb257b8@spud>
 <20261119025950.456dc645@jic23-hlaptop>
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
In-Reply-To: <20261119025950.456dc645@jic23-hlaptop>

Hello,

On 11/19, Jonathan Cameron wrote:
> On Wed, 18 Nov 2026 17:39:46 +0000
> Conor Dooley <conor@kernel.org> wrote:
> 
> > On Wed, Nov 18, 2026 at 10:04:13AM -0300, Marcelo Schmitt wrote:
> > > The ADA4355 is an integrated analog front-end and 14-bit analog-to-digital
> > > converter with a serial LVDS data interface.
> > > 
> > > Document how to describe ADA4355 devices in device tree.  
> > 
> > Please explain why the 4356 differs rom the 4355 such that it cannot use
> > a fallback compatible.
> 
4356 has a different set of selectable input configurations that leads to a
different scaling factor to get to milliampere units. A system with ADA4356
matching/fallingback to a device driver only supporting ADA4355 would get the
wrong _scale from the IIO device driver. Users would not be able to accurately
read data in milliampere units. ADA4355 cannot fallback to ADA4356 for the same
reason.

Will provide this explanation in v2. 

> Also mention it in the patch description!
> I was briefly very confused at Conor's comment :)
> 

Thanks,
Marcelo
