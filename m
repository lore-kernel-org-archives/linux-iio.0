Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792441296;
	b=YR6Wl5bUJ9pZzVOy/qAM7k/8SSVz7/W5j5kAGTNoZY4WW8WBO4oX467QEq/bPemoWtNf
	 yBU8hbSF2VYVg/DJPL6aQHcW6Chyca1CsT0bJztRR3tQhyARURbqdVRMv4hf6FH26daTr
	 ydZbmX3azf+oxEAp6FzBUtXl5poYXT9uLQnq6I6dos6pK0APIQO9XmSo7cSLiA7tSY/63
	 rEFUN7YAmZ4UfRPIGZ04Jm+OkCxj7/MtnGW2EDyvXh80ULZAs7oWGGTesmX96cuMzb07+
	 bsi3jCbbPjjW7bCw/Ep0JKMDGE/3Lxiqx0vHJnWx/JhbnQsfxZh0NiBXnhzcSdp/GGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792441296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=lxY+bUlnXkp9HLTP6VBDyo9xmYaSPEc8yORJWUbNihU=;
	b=Qg0QLX9kdIQxC+QPgd/+DdCn7f95tK4ur65lHW+N635I6rCoWO6Fk3/UyS1zzJxin1qV
	 ApNeDShWgl4IVCSvfdOH5kjZa5ofDf3Yd9IChX9Wpj63//rDkdQZ680DIqbpOMYChAcXT
	 UQ6Fx9AK7o/mMMKTMGj4KhjLis3a3JXLBoSJWxfi5h/SvZyNaz9RjAZsXRflS4xj45Yr4
	 UMEtaBFmTstCQSJb4GFFo9GLU1Qhe2o5ptw5keu88VGJIQFlGS8t2oS5qTV50eiRYdIrj
	 qTbkGAeDHR6Sx07XAU3ws7AR8bT/hqO4bvrBTYvN1Mhz1QxUcvP3t57w5ROIIJbYZ4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XiBEVISy;
	arc=none smtp.remote-ip=209.85.222.45
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDBE606A31B
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 20:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FDBE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XiBEVISy
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9906a5410f5so44812241.0
        for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 13:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792441295; x=1793046095; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lxY+bUlnXkp9HLTP6VBDyo9xmYaSPEc8yORJWUbNihU=;
        b=XiBEVISyRUSaKTM2KkccmpCYmSCxtkzIT9pO0e1ILZqqpIDrCarUcKeRKwEiqGqFjs
         eTQ9qd8be3XLJSDCMiafjEnEUjd8zt1HB16T6EqvAo0fhnwhTkEWS0MStUFlZOm49U5t
         jcW42PITAbU6s1v6JmqyMJCwYN0hkuXsoj2oP6T+Iv97KQ7gA7ICDvzCgsYE5TjxO6wn
         UYYeAgUoeOlxW/2tqeR/V3WkNnyeZVHXii+Q/vMNkX7r+pROjGz2tKzAzWPwkxey7DAJ
         SvlyEv1Olggw8DwwpfLuv77Ht85Lvi9uB8DN4EZzuwSYDA/hnvDofsVInA4wxHL0UUwy
         g8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792441295; x=1793046095;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lxY+bUlnXkp9HLTP6VBDyo9xmYaSPEc8yORJWUbNihU=;
        b=WiNJpg59WHp/G2vUZa3lBCoC7UJD0tMKkJQv85MWYZ8RkFuagAGTovEY7druHHMb3W
         oIkt2DXacvl0aTOyZdxxO+zwJbxe/Rz7uhQAeWIRF71E4iEsKk6tFVld1VMQfgjbfKsd
         duetZLKVjA8Gycs8/VQGgNXFcyrc4ZmvKypIqgq2PGwJWjR2phuhv7eb0dBCHgAEfplS
         LOlsIhRDgrxvwBcZnis2+KryKpAaJf6IyE/FrprxuE1MpiXpRL9qjMb5Af/z/67tz4uI
         AGw0DnvboYRxK+aNP01loEiHeJS/+MqUCPg0hNdDm/WyMVaIHebM9GGEQEBrpQoDLk9s
         SuXw==
X-Forwarded-Encrypted: i=1; AKwUvBxiNAenHBBXbBeizz9x+oeLyMv6m+uJL2tPTz74H+dzGmOJiPDk512Ju3Tw5z6SQaDwa0eE/L9Ga1g=@vger.kernel.org
X-Gm-Message-State: AFq9FYIoV0Sug/n18QysHHhT7r207yA7KRZ4EuB0KbOXBnswyFHGFBXK
	zaS2J+2v7tbhz0HLRDwRdxym+BakgYRRcbjoh0GG0VIt49A+aa0sT8Or
X-Gm-Gg: AYBFou0YT2FEL2nHmmlhH6YMCMy/LxW5ez3xjn8fRIMxKFfLnPbydD5yDPT2ABz7sP2
	wBnRLIOPHFIITdWqhHfHl4WXhvysso9ETdH3pBQarYPZXqJ8rStQ0igaOym8bikQWhJK6mPHpkm
	l2r5ONxBL+iD8ubL80Bs0yM2zqB+WwKxCkWjjuBEgep9RbCRdXi9g7rPTi2VhNypLK5Cp01bPuM
	o5XeClOyCJYu0zotocoJsY2tyM7hs9bUGB82+DK5PwPPIXR7AvxUlULgY5JZsu9YUo7kS8ZZD7p
	VDLrtQNcp+RB2zxm3tyL/70ZmWzfSatKBKabwp5apdQAnFWvoFhSMd8NXm6cCUd3M2ca7dtb/fL
	gTyvVc7gMXX5UWg2LDDobl5/YKf22S7fBTonzXZ1gqKpJAOBnVxMHbpk9MZruALizwfzUvLfxBw
	Wi1dV846H1edQQr/pTgxHVQpL8965RRMHES5vI9BoMjgUcPeGvUf1bvgY488yCuN1PILAci8uxX
	HUwcPsur8XMYtYPTQ==
X-Received: by 2002:a05:6102:4410:b0:7bb:64cc:1362 with SMTP id ada2fe7eead31-7cc7bac38f4mr58992137.6.1792441295093;
        Mon, 19 Oct 2026 13:21:35 -0700 (PDT)
Received: from localhost ([2804:30c:4067:b00:a68b:4892:7af1:b51d])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc77264634sm1081672137.9.2026.10.19.13.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:21:33 -0700 (PDT)
Date: Mon, 19 Oct 2026 17:22:36 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@analog.com, nuno.sa@analog.com, dlechner@baylibre.com,
	andy@kernel.org, Michael.Hennerich@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 05/15] iio: adc: ad4134: Serialize single-read
 operations
Message-ID: <atZ8DPLg1Zqzhba0@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
 <fadebc9f9fd6fe3924d086bdd7f549555dc069bb.1792200021.git.marcelo.schmitt@analog.com>
 <20261017193929.12ce61bc@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261017193929.12ce61bc@jic23-hlaptop>

On 10/17, Jonathan Cameron wrote:
> On Fri, 16 Oct 2026 22:57:47 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > Protect single-sample read operations from going wrong if two or more of
> > them run concurrently. Serialize the data read operation so to avoid
> > single-sample read requests disrupting each other.
> 
> Why isn't this a fix (with appropriate fixes tag)?
> If nothing else comes up and you agree it should have one just
> reply to this email with it.

I seem to have forgotten to add that.

Fixes: e0bc6d7e2584 ("iio: adc: Initial support for AD4134")

> 
> Otherwise LGTM
> 
> > 
> > Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

Thanks,
Marcelo
