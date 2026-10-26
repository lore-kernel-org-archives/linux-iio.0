Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036358;
	b=PQZlKUU8ETzOHa8ga1VWdF9FetnvnJBnB/Gc3NOMHKLbz0WqWtX7H7defNlrI03MiIyV
	 pY8Oez1ohKpxVeV4w33kALt1Bbz+IdVBm/uZOXajhoacGxC85PKILh60LEPzLQB3m1A1m
	 +4Oyp03iiO2GMjcVIWE5XyYhCYLns5I8Fp3m3IxDqYrclnQOMNPEgFBwzQrIHp8lgw4Z4
	 d+E0pcO0cSTQgRmWLtOc0KSzVDoltHaEQgnCgLFHnznuxVfLJpBaoVv+i6szAD0VJ1Nlc
	 IV5eJOX0ZN/KaNmdbYS94S2P+tb6PU7Gx0+gj3OB0IruhOO9IlcOk+OXCFIOKVFsMaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PnSIBEinvI0aWOXfbfSxdS14sk+hrl90vzujOjLWDnE=;
	b=OXBoVly5JMR7F6gxEMwc4p7s28vGqUsuFdO24y/u46VAixn2CaLcX358DzxFKjgJEL+K
	 YwTyoRSKHzaDHtucGPFS1W/tga4uV6RxFtGKk0xN9Dn+9FPY3otpsG9Tj2YLJOuRu6n/a
	 djn71hdBDelNcuko/tmR+KZJ//daUQwJU+N8JmgugppMPjuGcuep4oo8zbOhql1TyDtoB
	 9ZF0oD3+n+LekzpMupNc5mzly1iYN2VpKL0mcdizvLtCdm7P0ejW1VPkLtgkRAf6gfN5H
	 jY/5oUskvc0G3PUlFwMiesSA4SFc33at/QSc7JhxiS8LpKNEbUvbtDC2PalNuGlXw7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KWNTyjiS;
	arc=none smtp.remote-ip=209.85.208.173
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF935606A31D
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 17:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF935606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KWNTyjiS
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3a9e87ba696so23072301fa.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 10:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793036356; x=1793641156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PnSIBEinvI0aWOXfbfSxdS14sk+hrl90vzujOjLWDnE=;
        b=KWNTyjiSseh8CRmBtZ2wrSmoout5WMIyNVt4NfUzr7M4iL6TvFU4puGMODBpTeXLjc
         KdwxAfOs3VOMlLGb/XiRW30VSo82DUb5vdDcZ4xFHAFAXFrHjJ6tlPjYs0CjuTOIv3ux
         HrDTjiVgs8bWoKoUT5px1oVEBL9dBP0uBhSomaaF94k0MkMe7ygEGLb4XyVFkQe5xCS4
         y9DMI4KAZolgfSwuZuX8Zvy2yEd/cizD6XPGDxOxOLGy0Z/C9+J7rF/UN9RPEX4bX9SJ
         B8BVl/hfCRyhHL8j7PR00Y1MFK3Gas/14IeU5PjShFWvSJmWi9BwPrLWZ6lZssF9IR/h
         N9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793036356; x=1793641156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PnSIBEinvI0aWOXfbfSxdS14sk+hrl90vzujOjLWDnE=;
        b=0dwUQRdYcesEqhvfu04BmKw0xQnCcMhB7ykq7ThEEmyhJGaoXEU5z77+vcC3LTFKx6
         dT7gIOSEM4+/LJB0DsHs3OFSRZKOGt8zoJhnl0dAjc5EYeRHI+82ujtrl6HFTG2MYFNC
         bxo+alJb5wSPHkrxC2iCWBNZ+L6c+bNjEK6n0F4nFFWLxEgzJ4MJ0c4yNXk37kMqSN2U
         /101UO0cwCoHZh7XWv1bsiP97A0cueZREvZdrR49WZe3cM36r1GtVAFwdwPCwetDhJgy
         WBIXA3KPot8R7UfYoO/lrmxIpPSKkhUKVDWonaa0bRRmaySWjmJ6NG2z32UM9upDvwsz
         Ulmw==
X-Forwarded-Encrypted: i=1; AKwUvBxfQGYov/aPS97WLLba0kh35cYzPwv6LP/C3taqTtUydrb4GOEWOpfgxekE+5Pmhuu1LlabfFLJIO4=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7sGjAVH9GWmu4kYX4paLy7E5IHTqZKWQWxMSxYgFQjPsL74CL
	p6CY8+mZktrEQzxUCtb7SbkSER4cXMXdICMb8BYhTMlIXpB1k/fj23FQ
X-Gm-Gg: AYBFou1klitHq6fZF0l/9+w2AN0e7MaxDk7NLu0271avXJm7oCCwrN1Ato2aJtJsre9
	8hiVpTvifWBJ2u2PLqSHY2utQLtWat7SF6KcOl5UWamhSUhGL2q/5Q6kHYdm7Z8vG9EfXrQJxpu
	u8TJCHpGN1hpg/C9Eu590e4EcJE1AlkXemLPysiir3EaxU+QwJ7AwDBKrZTqgkWo7dAtVVJF0jz
	6LMHjJYMdmjCl69h8ju2EzfTnKK6TNVU7XHRrLfOWovOIYIdqk4KzEYyozo/H5rCRCS43TE3jP3
	K6TSSVY5UIiM6gbhvGbqR3HiatopmmKgAJ7qPKPHq1V3SXBhSFFoTp3DLvntvI0iMMyXUEchRaN
	BhssrCIRVOUlMA/IPB77xSMOhlv9GPdQV+oapAw/r/AyRyrNbPZZiF6YIiAQW5DGAewdiP7YmCS
	gi0gecNxD+pJKUIEAhyxLSH/PcyRjzBAmgvsroBTUQspHo+O921Fh/L/nrRYRx6jdIuDdJsuAFl
	qTAsUml5Ety9vxv8LCBADyKEMmu8S7m3zoyV1eWnE+7lOeoqv5xk5hfhD/2tJSCtjv1upQtXXYZ
	CN2x+QpeFIIFesmM+I8Ljppnmwqi8Y31QBMMU0Tu0gSAv0d9W0dNyaTKs1rrUXvu
X-Received: by 2002:a05:6512:b8c:b0:5be:4386:806d with SMTP id 2adb3069b0e04-5bfb71eeac7mr2553829e87.53.1793036355836;
        Mon, 26 Oct 2026 10:39:15 -0700 (PDT)
Received: from yantra.. (nekmmqua92iezg7lpcf-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:9332:cc42:ba9d:ca8f])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7a950b9sm1685199e87.63.2026.10.26.10.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 10:39:15 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: andriy.shevchenko@intel.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: dps310: wait for a new sample after a ratio change
Date: Mon, 26 Oct 2026 19:39:10 +0200
Message-ID: <20261026173910.23788-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <at8X810dwa98w9iL@ashevche-desk.local>
References: <20261019153328.80739-1-zoone.rupert@gmail.com> <atZqSXI14WojGso5@ashevche-desk.local> <20261026024605.3286702f@jic23-hlaptop> <at8X810dwa98w9iL@ashevche-desk.local>
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

On Mon, Oct 26, 2026 at 11:05:55AM +0200, Andy Shevchenko wrote:
> If Rupesh is going to add the patch to clean up that (before or after this patch)
> I wouldn't be triggered.

It's ready. It turns the 30000 into 30 * USEC_PER_MSEC and does the same
for the other sleeps in the driver. It is in a small cleanup series that
I'll send once the dps310 patches already in flight have landed.
