Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793530742;
	b=ya63bMMVQBOoXtF+GPI7Y1cX/72E3oAG4Rfa/YwCC33vCZjmOy9zNZH8Gsfv7d1bCv4/
	 6B0lJRM37fNaySpPhckFhxn/7ZnoqOTxa2BGiZa30jqSltgxE8fMEieiNeuTTbblAicNN
	 AxE4PcJ7ehbVR9LiEKkkypohRjkRIMP9VRiUNN5hCUbv4GtV6E/VkCEPC3mF8UGxDpP26
	 68mYlEQy6lN0kNYypnAYdFP4eBwwXxCJej/Ug3z3i9+nQUldYrFNjo8iDU9GmUAyeSmDg
	 kVPuVIMSgHLiFvaqVeZ/gzjZh7WRVFc1Zl9kxehWY1FNWhIoMjdR66sm+xUarun8BTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793530742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bQN46FltKWQa6o9flDUmociVk/15gU/NOC0TSHc8r9I=;
	b=j4+NW+xF99x7r4bWRn+t/gC0sdz877HDfUNmHAvkicbTuEBHolOV5SuJ0zHaed9591X3
	 6U6g49dh7DZYW0iAbdiyXgNzmRPVTCNgjzbAoDmsvMsT5jirTrdGAWXplItSIKIOVXyPt
	 QxozAojr4oxtdLHsaswgV0t26QLwQEYXL/8hp2ljm+XNblyK0sAVEmZek2If4t7xHBkFp
	 dVJNwpzY+60gFiFCV/h3JiZ3hdtizuz3eQse7qdy7ebjaCN8eEVBwfIfcvW7NFWNv4H5q
	 doxS6nJgFqcL3xGyaK87z7E2FhROZtBvo6x/Jvqmn7lllEeDMNApBWf4b9aphIWdtLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GRsbOQfY;
	arc=none smtp.remote-ip=209.85.208.172
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDF7606A326
	for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2026 10:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CDF7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GRsbOQfY
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3ab01c46697so22447111fa.1
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2026 02:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793530740; x=1794135540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bQN46FltKWQa6o9flDUmociVk/15gU/NOC0TSHc8r9I=;
        b=GRsbOQfYJo7A5Z1Xd5UZpGyg9bTL7K90xbCH2Kl0QmLd1sYz2CcRW/VYUd5rJ6+2aa
         HsttAg661qFIuD7oJeyDGskDXRtqJxRBe09hlrf2uQGsjjxa76eCYCNFy1Yk/QiVmbub
         y+M+LS4xP5RtuktJBRagx34tumd3eeg3InijKVPJQxEzj8gqCqCM6a2zvQBtYuBdPBrG
         HgxM8Pv3PLG7BzXKmi+GL7iC3Hb7LOtCnRNPDwPBEPccx/UeBekov0wdJtcUaawZ0M/T
         jeUaOrlpVL0c2wdNAOpa3YqjRJn3NnTb11KTZarQP58dfIyboNFnqxIGRQU2Ic+j48IX
         eanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793530740; x=1794135540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bQN46FltKWQa6o9flDUmociVk/15gU/NOC0TSHc8r9I=;
        b=LionPG9L19ugHX/4P0FM396bhlX0vbgnHYRPH6zvQhNZPukvmKY9hCiqPSBfZaOd8Q
         2DKNJE0ZDlmYY3UfutQM4jmg5Z/AavPVhLrWk7ihYIYaW8Y0eCNfbxfyGDAHvtYv1x/3
         fs1+3IAL1Ox+/38BDObOAFW4QuXtDSPF0AKNklR+WeTtECvfb0fxSP9yWK0+Y+wu8URK
         T8azI175DP4RZcOvvAUwBZe1HUH92BGg4j/3Jr23styGlNhWOgXk0BB7utoSPIgJD/Zm
         IMEQbbAfmPsvSLsiGhMIeSADeSedQrUI38p4eKpjhm5IPTS2ehr5Jq9FpTCJJ2uy931L
         Jmeg==
X-Forwarded-Encrypted: i=1; AKwUvBzNn63+i5sDilLr+bfSBG9Dzu65pIo79CK2oY40sRkWvSXiojhL8Wc1pIUov0zcNlBke+ZoBUD9T5k=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpavpwWWmrmjL+mLMATJ7Z8SIlEfyCQR/9nyKr5NK9fKeb+agi
	hHjTHDcn/jdhtJLiiyvLiPC/FYz6ZKruvfQKsc/wyLoXeV7dqLKSU9GtCZGThLRM
X-Gm-Gg: AYBFou14d7VJGBye+RTgUbAXmolH9ZEd3+3Tw05RXv1KHQUFbVYZ/FrqK1SB/oTZwz+
	L8T5JQWI24PYcWGvI3AXKIdhABWJ+TD6p/QWH4WlX5xCipY9V2aQwDYrQKz/AUC90vEn/Kb5mHc
	QUq9hF7w/qrgoisXlSfLBAYem7X2ab6RPG6DQWvfmsGMyAu1Wcgc2VHLdi0Uif7SO5GfVO9fsRX
	2xERW8VjQh5f0mU/c4vif2nQU8elcY9no0gD+yAKJmKb3yGwr+R9UOU5zsh5LZlwpmjNBDw8gSS
	X9C+KY75qboQUP/hrAbN2jhhkcf5IH0pOvZIQPDhq9HaC797gzbJ5jgDKSWpJolXRfDUn222U0B
	mFmJr++yluEWNvojdB4LabE5AcoTC3wAceB4/cyvqbsv7NZIdv3PmL8DZvhUJeSc4RpTCRWUfdh
	CSHLywspVT+2Gong5pQfcDmDZPoTjoPRskFUARckNp1c+iogcrORWjpKlMLMhIJIZ3WGjD8hCy9
	yIr/zzcWKJG7o+DJAYTDVCHnfHt3uwFEUNqvxVtGQJjoE1u+y5dThppp4Q34BbC3raFvVm1v4ff
	1uMrUWnDZWzGvJRjlaTHLuaKTAvGTUBKDzWIZtV1zBbxksJ6m0FyOI8x+id2fwGyeoVcE0rZ2xs
	B5MTbd3SsCe/tBwxHaFiUdC4MzVfb5EpXLB4tuA==
X-Received: by 2002:a2e:b896:0:b0:3ab:f43:a3ca with SMTP id 38308e7fff4ca-3acb7a80dcbmr16287441fa.16.1793530740401;
        Sun, 01 Nov 2026 02:59:00 -0800 (PST)
Received: from yantra.. (nekmmqtbv463r5fvgny-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:5462:a993:5223:791e])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3acbb80953csm12768841fa.0.2026.11.01.02.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 02:58:59 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: jic23@kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: Re: [PATCH 2/3] iio: pressure: dps310: reset the chip at probe
Date: Sun,  1 Nov 2026 12:58:55 +0200
Message-ID: <20261101105855.55716-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101010444.2803dab4@jic23-hlaptop>
References: <20261029220635.18816-1-zoone.rupert@gmail.com> <20261029220635.18816-3-zoone.rupert@gmail.com> <20261101010444.2803dab4@jic23-hlaptop>
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

On Sun, 01 Nov 2026 01:04:44 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> > Reset the chip first, as remove already does.
> Why do we do it in remove?  Does it put it in a power saving mode
> or similar? It's fairly unusual to bother resetting in that path
> given as you've seen here, we pretty much have to reset in probe.

Yes, in effect. Driver leaves the chip measuring in background mode,
and soft reset returns it to standby (datasheet 4.1). It came with the
original driver without a stated reason.

Writing 0 to MEAS_CTRL would also stop it, if you'd rather not reset
there.

Rupesh
