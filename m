Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197474;
	b=OCkW4lgfThCe4czIHSvZ8Z85kHT04Ukqy/G7wO8P8y8CWC+l+7Q3Q2mYU8xuulIRmlo1
	 ARRfs/+3KHjav5h3Z3TmmSVuDIj03QYDWsGOsK/wXSyV8dO2wxCbgJWTrWOnyPTnTjQT9
	 rY4FMh5BwF0D0FCflVaFEYDIpLlMjqETjNYQzUh+1PxuXCI0YkbkQwyIDFI6en/xCRHi2
	 K2mCUi18duNKupQCLhnl7sQyhIOlwmSFnO6tIuOktxCg+oJJoO/qS+ngBtLTNzbnuSFpu
	 1sw6mSg7sX/FvA5MagWLJG12OffKxsebkHzdp0hUxGpY6/qh2xUJIRJYxpwhLo6NR4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=2lNc3TmeFA42z/vlls1GtDaaIwnrmScSpoxbIc0sB0I=;
	b=3gNaHJMOOvPiVrwGQNdO7QK4zYEDjfIh0WvjB8l/ty1werIc+aiF+jkmM/tiWGW0DtSR
	 OLCEsppZrWHLw3AqObpXKY0n8Vls4r7iPfLvHCiDPxdL7ULLpMbQ9/Jo/8iatxp24F20J
	 7oqTUj/NuNHX8VcO1lNsEC+cJ/9CeWt4T1rlpXkIwb4ONcuyOPqBYYHpCSTeugWihHUn3
	 vwjNBYUOQiFrFNaewRVP7p9o8XsqeoxMwyqmFSBI/3nRAUcPLrJzk5eNq4DMLzwaYY3qs
	 1vqEPRodMuV5+UNcYZvHmCFci3k1VjXj+h8tRkn8MqcM7q8R3jLTOaOTYpSpkYwWT+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Iuj+M89E;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE582606A32D
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 14:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE582606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Iuj+M89E
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3550c917fd3so1471371eec.0
        for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197473; x=1793802273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2lNc3TmeFA42z/vlls1GtDaaIwnrmScSpoxbIc0sB0I=;
        b=Iuj+M89E2C4BUXp3d/YGDW8L0zBd/79sxNVHYvvpUsD8kuWPNu6jNoS9QAPi137XQ8
         Max3lgZ+9dS9GfQvT2IO0vN766ns5hz4aqX5Ck3PUkO7Z92AgV5A8d5KvC8beg4uEfyM
         N5FRVYkT9vwajGJYW9KocJ+ufbhfArqdcWUMVtYaZP3s3M3FQUOAFS6beBv/iWrMr1VI
         upDYD7SS3VWgn9Kf0jjK4vCUCMxvQAz7oQoAav/wzyOUbiYc1y5NcPJ1d/0VxDnDM1rH
         jkDzlEBO6MQ2LaPaR3nV5j5T9qDMweomiegT5pVWV2QSrGcvxkT6cnbN/RRN8FvHCVuU
         3uxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197473; x=1793802273;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2lNc3TmeFA42z/vlls1GtDaaIwnrmScSpoxbIc0sB0I=;
        b=xtagEJaQMHaq3KR4PrLYw1YgBizBZEBpyZUWjcpk6La8pXwSzeh+RryfJ5oQ4CKvJG
         kCiITFGN/yWgSrXmjfzzlpp1pQDKry7rSLLQdYz5lPsFYZvl0A2fve8+Ul7vJUkz5m7U
         TN7PCsiK/cisEqm2TlukFOPqns7oo1lx2BSEOnSv1QVKavj9n/NJG6LCLjKYAuy2UT69
         +GQxPp+IXqlcIkjTsugPFngpAXVJx4pSJcMx9YHqSrG0zIQWAh/oAZ8lLUe6FYNZFXaS
         XlDhmApDlAVQTMwzaGx7v+mUUfCDjNgExn5OU3OT2GserpIIf5aXfFjL5y83VHGn1tjE
         PJCw==
X-Forwarded-Encrypted: i=1; AKwUvBzqhwDsCnaMn1sSH3yMrXdn7GmZ9g+u+90rX4HnOomeLG+/c7KOKBPuUk4mz40cGTCFM2699SVLYtg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5T4nhB3fTD8YGILuboDGBFb3ahCj5SlxUG8gEeX+Ha4oRol/E
	Vpn+zni7Q0fqfL2J26RC8Gxsx6/0Ag+WUc0S+I8XwxXKYO/+FdhOD+i4
X-Gm-Gg: AYBFou2aYYNnM01w0+1r7k0lReZvZI5IgcQFjrq4iBnctgg5VR1qb7yugX2kOX0B2HP
	W0mMQgBETOGpGnR6dB5N+p84CJNInXTChXKoWUfapY8ddrDSr/wYg1D/dgmtw2Tsf3GtDhE66M/
	BYTfqcyIy2p/ZIW+ZVecH+FXShfVmul6eQQ94ve7dgfgYFrn0EwRWShvd9w4QHZcE/c3bXRrh0K
	jgJwowJaEAmJpAkPCxiW0U/EfhW/AjmzshQFL56xk4q54BrCdfifMUM6SStkUWUjVjlaxHzNuh0
	ntG6+zkX/Q7FsYDIgui3p4OBl0OURl6CHpEy4dDWCiF6TzMAFY7OxlBgsagkB6MC6T3Cpmzc0Q5
	KKWS0y0MSZmv/E0rHCIOlu9aUr41bY7bnd7yzh+UKGnPTqVSKN5wAcjK3IsNofqJip32ZFg/HhI
	WTZUik1N/r0ev3tdrVTHrHtV9TZvOIBHGPs4WuZK6yptSuuCTu/uGsmNK4XqmtzZT0niF98nTqw
	OP+vyDOgeRR872LS03dO7dPk2zXp2hMKoaLTcY53ipxt9C+LX8tY/3DTr54tgXUHbz7rnP2L5Pp
	QvI3ku1CKal+cA==
X-Received: by 2002:a05:693c:87dc:20b0:368:4acb:f8a with SMTP id 5a478bee46e88-36a203af6d1mr3477586eec.17.1793197465873;
        Wed, 28 Oct 2026 07:24:25 -0700 (PDT)
Received: from l ([2406:da14:1f64:300:5751:346d:db2a:88a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239198c9sm6895930eec.15.2026.10.28.07.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:24:25 -0700 (PDT)
Date: Wed, 28 Oct 2026 22:24:11 +0800
From: Liu Yufei <lyf98405@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Gustavo Silva <gustavograzs@gmail.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi270: fix zero timestamp in triggered buffer
Message-ID: <auID4_vQSZXuNk0Q@gmail.com>
References: <20261028-bmi270-fix-timestamp-v1-1-99c0e5fe7d0c@gmail.com>
 <auG5MXTh9ZkXMw55@ashevche-desk.local>
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
In-Reply-To: <auG5MXTh9ZkXMw55@ashevche-desk.local>

On Wed, Oct 28, 2026 at 10:58:25AM +0200, Andy Shevchenko wrote:
> On Wed, Oct 28, 2026 at 10:59:26AM +0800, Liu Yufei wrote:

...

> > +	s64 timestamp = iio_get_time_ns(indio_dev);
>
> Do we need this variable? Why not call it directly?

The intent was to capture the timestamp before the bus read, so it is
as close as possible to the data ready event rather than after the
regmap_bulk_read() over I2C/SPI.

If that difference is not considered significant here, I'm happy to
call it directly in v2.

Thanks,
Liu Yufei
