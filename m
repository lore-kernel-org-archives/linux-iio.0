Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421010;
	b=KPZCF/vG2RLRsHAYtM5iQawsJ2DHN9kZLtPliU+ApQ79vdQ9QYdcAceh/ZMTVoCl3ROV
	 MeuzY7oqb7b1upkAw8jR4pK9ayGerJveCHkbgGJpYSW1QGygR04D7MzQKN+jxow1HmN6Z
	 soQTgMzJPj25kVyYSqQsD68Ij65jpS1+11mNYSn+RIx9zSnyVjwupfGp63Qozuab/rQLm
	 Zzdaf8qTw9H4uQyeb1RUxmJzSiIZiv7sdICqY7VyI/M2oT5mJUiBAjZh8J01v2Iu4wHP7
	 W6Qpxy31NA3NLY69uSOtqQ36ghtNR/JCZOUSSEF01HcO4u5uuSP4zntn3wXLoGjOCSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421010;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=iSp+6Y67zsfn/WpLtVUfCKIyxWtLaKdyUG5apCNSwDw=;
	b=yA7AxeCzKohKmx84tiutO+XCrEbPuBwdNbxFSigRMQbmlKYHYQeTQHb+NmnbuiJg4vlz
	 2DNAl9pDxd/QkN0N6h6T1r/HQYLAsCoO1b0pFrFrneBfKzIp+FF9folE5yMiALYTzhndn
	 U5ROw9dL1ifWW6m4/vFrzxW5xnxqxCAH9RipncupS8/qS6lgeK4Q5Gdx9Qde3c3gC55bq
	 eImmmA90VMUyWbnHuLgTQHkZCNXdYpkfgmS/mYIIj/3pfP50cps/SopZRH6lGneRRYc7M
	 wCOi3TbapoV2cVJSF3ahjAFQ15M7vrMECgtRfXMw+sHytzU1TGzDxOy1XGQem4yKEmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkUu4qcH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B7D606A6A5;
	Mon, 23 Nov 2026 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkUu4qcH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5F51F000D4;
	Mon, 23 Nov 2026 08:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795421010;
	bh=iSp+6Y67zsfn/WpLtVUfCKIyxWtLaKdyUG5apCNSwDw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AkUu4qcH9drXb9xgMaNlzw5vEkS/7ZFFrwoAA347UQxbFPH7hcyVVXYvx7WweNV3r
	 XsnNHS0pQ0brOTh8KFBXpS02vnsNZvzyPOisZ4jZSmCTdngWtMR5Dwb5r8NuDZ9LG5
	 luLttXNHT4JseguiRjYpECtk3bjJHyIDolwXmG2d57HaUqnhTyT4rPDhH+SlvEVQis
	 TfVy8mZlVEfpae7EzS46JBDGifFJSanFgv8fBY9CgkqG4MhCmiZwGgDi0Lk/XIEEDg
	 fATFrwNAWsrcT9+Jdke3LXtdDOsghDlriY3wfR1miyjAjEjxjYnnjd6rhemc/yEAZJ
	 wkwcvUYgdHybw==
Message-ID: <bc070af5-62f1-4836-baa6-3749f2fba6e6@kernel.org>
Date: Mon, 23 Nov 2026 09:03:28 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v5 6/8] iio: adc: at91_adc: pass struct device to
 at91_ts_register()
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>, jic23@kernel.org,
 linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, giorgitchankvetadze1997@gmail.com,
 amin.gattout@gmail.com, antoniu.miclaus@analog.com,
 gregkh@linuxfoundation.org, mripard@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
 <20261123070101.53868-7-abdelnasserhussein11@gmail.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261123070101.53868-7-abdelnasserhussein11@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23-Nov-26 8:00, Abdelnasser Hussein wrote:
> The at91_ts_register() helper only uses its platform_device argument to
> obtain the parent struct device.  Pass that device directly and simplify
> the function signature and its call site.
> 
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---
Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
