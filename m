Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794996646;
	b=JdsxEyU1YIaH1P3acJonbjVMRQd4qXpk7rG2Hs95+E5osJZOlYeh8LXvdH7L0vntr3CT
	 jja0DEDd46E3qEAgSf3OtyU4uy9Dq+DwbFnEGrpqsJYv8WVumy2o1y2kqT4YkWxLpZql8
	 jNi2QU6SGBo7SZ8x2kq63+BBQOu9fhOzVN0bFsdjleGHmgWiluCmj+hrh2LnnpVN2dMKo
	 2DVCygxj29QkwXyb2cxflqnMjwGK8OXBqNKasttkxPOESFyn0DTqGAtJN2K0DCsYaDFkj
	 3lfZQlzU9i8aMZagWgW2spobFii7BNgU+113jLpoqoWNv3z6OitWw38BDAihVAa/XDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996646;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=na3SCtKaMWZuX/KeiC6h6IrCBQ6q25xd39tU+cz0gjU=;
	b=JO56gZSLVKRgQ1JgImih8/dD8brOknZnRdTnLGKBVnbzKyMk66GGZuvk7qXAmiY1aHpx
	 m2ssvO7j1vJIQv2z2/ijvoqumDosps5UVxvdl6Dy1GGKl51c4KxtRzk27/mXWUwzI7SAf
	 lbixsIYmXHAyDtVpp/S9NeDr9OjlLw7RPoN3md89DAo85ulerLf9ytiIfQ9Y/H8kNOGxx
	 OJlImO+b/C7XYuX/gnxveDBpvAUBzjHQ/XN6rYW96WCMkw2gLBLV0ilVfxehsF+Ya32hb
	 N5CQWQjDu8oa/mBh63BvcHljZMRbOL+ZRIhdcNuBqL1JEf9pZRtpwUOJ/ErABTCCn8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fR0kzRCI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C201606A330;
	Wed, 18 Nov 2026 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fR0kzRCI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794996646;
	b=PAqAyahoImuSrah0r4cPW7n9m0aHOdlCiEPDvc4+UPGFexNqwR9CUjlQy89WXb/FpRID
	 Z3IGA5pn2u08wyGkc1Hq1M/qfdRKnIKH2RjpQhUJYCqibMCAaF3iQaDaokK3tY+LjOBSA
	 vp4175ykw+MK26eXcRYTHwRs+XKjGol0umjfxFQXVrmWCLFK3DaYbmBdv5IS/GGRUe2GU
	 HLCc1plUp1K3EBhBTmYarvUSWmKLmsIQckdnKm3hJdhjlWKsjCA55KoJ4rcRXSPUtC6bs
	 ZFrbx9lqVJtqCaL3R3kp5W51dzONUrYwdifMz6jFWuC2/SGs9RG9FBG6Y+io20GW+yw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794996646;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=na3SCtKaMWZuX/KeiC6h6IrCBQ6q25xd39tU+cz0gjU=;
	b=IAQGhMuP374eMSaBV3yJnmC5hSPWp0Qga3oT7P8g3clXzNL1TBDydmCgHrX6n/pHLBEf
	 RvO68RnlPK5pHUiykPBd4WXNkv3hsB3ImIz+AKDaK1DJcLeL5LC+prA9mz7WDK8Xg5Tle
	 ZpY84lb68yP9HxoY2YWe7EocU/GyjGHYV47aCrVnyfdmm/z+jkYcQjvnR4R1Ejjo4H30T
	 z7ntVxn3lgpXCFdbP9jbfVjMgNTExD+Yiild8axTxSaFur+6O83ip0Ru8o432xItIl3CB
	 LdtldiIydC7rD60oYccjThdVMsockee932v33dONJE5wZSwhzgBNhEAkQkFCQQbNYBw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id C14931F000C4;
	Wed, 18 Nov 2026 10:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794996645;
	bh=na3SCtKaMWZuX/KeiC6h6IrCBQ6q25xd39tU+cz0gjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fR0kzRCI3bNULEazq5ncYwDPD+0lBU11wInTF5g1oPtyPmkXiDaQkcIe3kNXiCmS3
	 YTu/tChM3jvUJsV3BuV+uE+UB7coT9vx8NWpozU9KVwLUDbYthjQXjumcN2YKK5eY/
	 b51TPw2FRBTjjDubKuhkTvVGlYP77+OpwLM69ibiaPIXxIBBAjaR+4RH2IoPLKFrFL
	 O63AHVbUOb3mwoDlBgIX2dTW32R3Lit/+iDDSyTTTZfxsfyM1errSr0sdiWLPiigDi
	 iVpdI9KDXNWC3q8Xgdue7fLGda3mYYohmR6vMO6R8ZZOej7iKdvakJaRgQBANTU5NP
	 IgP+09YwDkV9w==
Date: Wed, 18 Nov 2026 11:10:30 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Maximo Manriquez Lizarraga via B4 Relay
 <devnull+DelaySystem.tubot.lat@kernel.org>
Cc: DelaySystem@tubot.lat, jic23@kernel.org, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, gregkh@linuxfoundation.org, andy@kernel.org,
 nuno.sa@analog.com, linux-iio@vger.kernel.org, krzk@kernel.org,
 linux@analog.com, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: iio: adc: ad7816: use dev_err_probe() for
 GPIO lookups
Message-ID: <20261118111030.00002090@kernel.org>
In-Reply-To: <20261117-batch1-s3-warn-v2-1-17f4e541123b@tubot.lat>
References: <20261117-batch1-s3-warn-v2-1-17f4e541123b@tubot.lat>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Nov 2026 16:06:03 -0800
Maximo Manriquez Lizarraga via B4 Relay <devnull+DelaySystem.tubot.lat@kernel.org> wrote:

> From: Maximo Manriquez Lizarraga <DelaySystem@tubot.lat>
> 
> GPIO lookups can return -EPROBE_DEFER.  Convert the rdwr and convert
> GPIO lookup failures in ad7816_probe() to dev_err_probe(), which
> suppresses the error message on deferral and records the deferral
> reason.  The busy-GPIO path is left untouched: its optionality is the
> subject of a separate proposed change.
> 
> No functional change other than defer handling.
> 
> Signed-off-by: Maximo Manriquez Lizarraga <DelaySystem@tubot.lat>
> ---
> Changes in v2:
> - Resend under my real name (From/Signed-off-by: Maximo Manriquez Lizarraga).
> - Apologies for the improper sign-off on v1; no code change.
> - Link to v1: https://patch.msgid.link/20261107-batch1-s3-warn-v1-1-4fc38341ca38@tubot.lat
> ---

You've missed the following segment starting line 398:

	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
		chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy",
						GPIOD_IN);
		if (IS_ERR(chip->busy_pin)) {
			ret = PTR_ERR(chip->busy_pin);
			dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
				ret);
			return ret;

Otherwise the existing changes are fine.

-- 
Kind regards,
Joshua Crofts
