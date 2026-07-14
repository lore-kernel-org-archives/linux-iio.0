Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2854441616
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 19:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059128; cv=pass; b=q0Dpsxf4Nu0hhc3ZRCQVQABVCdurRYUcXY9Ws5ENFYqffwwP36WxJTTHlpADRVgBCBtlITPN2MyfU+aBhcT9yeO1ybyKtETNxLRmkTVLWoBjjbzYXAk3upmDAyc9MqdYJVMMcH6E5E4OFspHQ1Tso5SHaDJA/FBQNAav/kNkh5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059128; c=relaxed/simple;
	bh=XZ2kilMID1jdVFb3NXkl2ELqxMEbMA2hedlSLEWHaXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdO0pGj+VYYatEihku1gUI2oX0sBIAEeliAQWpSeaCCIwn24elB4bJoFXY5Z56E4J5LDVTHr7AofJ7oiRY5j1j/qej+jTlOu9OIrrvQHMiD0UX7ESE5Udvko0tylmF8yM02Gs9gFuh0roMZvcEO0n97Pvpwb/8GoyQ4YJdZ6BmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGi8qq/k; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGi8qq/k"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-848643382fcso5281987b3a.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 12:58:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784059127; cv=none;
        d=google.com; s=arc-20260327;
        b=CIPd1s58k70RYHgPVuP2/gMOsBo8vyZcDM+xlIfVeAvb37jt9SRaff8cX/s/WEwF/O
         fBS76e9x//++MxIMnZrLhfbFk9M/cJAJ+dhmbF9cVmLlXRIeXeIOgpyUmgmTnNQ2Jo7p
         HCt8h0AtKBqrWh9BnT9WVXJOE44U3IhbsN3qKZJF1gbV7gZ7417aBnOeucDIMywsWLqy
         wZvy3F6zsZuf3+ZR2G8lqW+fMa11ugINpmxLOhz/aXZyAxAebc/ZTl5rq+cll18+9Rin
         uh9kP1KUJL61H9ZS+KQ/EOY52kwNrye5P3L3QSM/I6PTpz2l2WVCkMon94LQkNt3qtwe
         Kqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XZ2kilMID1jdVFb3NXkl2ELqxMEbMA2hedlSLEWHaXE=;
        fh=OHg1OspMGTyIlm+cgFOH6gkhRfxtCbDfM24/79AaW7o=;
        b=h1hQuijDjRWiV645gCRX02x6WGp3QtiXGRuPAfrxmU1qOO+5DvZhhrDPwg0eJuFbsT
         SJ03VAVJZL1lZV9il60uTaPIC+jYlIqc/3aW0mvKuVjpdgyRsG14t1iseggHMLsh8YD4
         KqZyffMNKNI24gQhZxyO8wZuPOmp210LBTeqWMrtjYqz8XLPVs+FP5INgwfsVR8qtYh5
         jMoxD0TwEPEvbZ6+/7TLqCGOdCkBIoKXj8zfGMAi7KQXTkyAT80ykmf7Ayn69RIwThit
         rHrnRSBE9JORVNSsP0N4fJtzRGA0WMD7gkVXSHXXQwx6ceDO8bw4My8R3Gq/b13uvP2W
         WzSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784059127; x=1784663927; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XZ2kilMID1jdVFb3NXkl2ELqxMEbMA2hedlSLEWHaXE=;
        b=fGi8qq/kucGNDnd6vWzk2Z/VuQZ/9XKp5am1B9qDjYWpOmmsGEfwjdNl5s8lBPBjVL
         08+s42vAuUqN0KRzeKyx/1PIxgt0r0TggPaZVCtenNPpzN9R0HIfoMw1VEl0rzLGrgWF
         T8PPSguM0JPFTI40QtsFSqVKZaINfwNNdqGzUskoyBIZLxa5R21Gke+wUerucpEbRQkq
         8LD84UiK3AcYIMkaAFd3u8tlhgRy/Qc2W3OGHSD1sFuKLSmFKzi5JSQyMW9t8SMWHp3x
         iIPOWiOIrGYjcDfysPccekvYlXqGbFQLL56JXcFwtSyTt/TPEKUgcabuq0t/YsUrJsyA
         g9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784059127; x=1784663927;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XZ2kilMID1jdVFb3NXkl2ELqxMEbMA2hedlSLEWHaXE=;
        b=e8AYP5+DAJHonjV5p9nIYuj4CdaKiG8zIVA47LTtA2Ln5daMBsfYCORVhQoEE7ZqFO
         s89PNc9l3ifE8prts8TgGrvMureti8Zh1sJXk7KAqOucSQLGY+/dZR1CmRcahq1hNaHc
         K96f7rI0t0rcTh2QW5F5e8mIn7SlbkH5wDCWwF/kV0WCnl9bhsW6H1rOansPIlqLtE/c
         +IiXidndgxg1wSXtU9dYfJsYTRLu9Yq1w6C9P5XkIr+UOYPNBvKLwZQFE8wqUkV4wdO4
         21X2YRKnEcqx9ZVbvZncl8DIbTLeApOQSooJG/Exg8jph/6pKDxXBMuUrlE1eOATqYXr
         Lycw==
X-Gm-Message-State: AOJu0YxJHuTqubQIgSVDwCxl8B7Uiilx5Lga51DvCLVx28usGeC3k8wZ
	UUKXXTdpL1YVDjdRxI93T3Z7MwZSXTehHIFis2aPSt5eotFjat7YiBGrWxyH+LqJXiZUzVs1K5p
	R2RHrP/2PFFaC0R3JKpNEVXDvXLn2mnO74urF7gU=
X-Gm-Gg: AfdE7ck4n7DE6WN4HKf/ueRtxf4fCrHACbnwGz9L1IsNwOI2LfFg0vwffUPLQavzuWB
	ItToXo8VJZFZ++W/HQyOSvs3AeXrb5thR0kGb7nAgbYGuEBMX2HIGpjVRyWWwPS7Ew49aHr3hqT
	uilrhZIfVleIq9rqDPhUZ4jxXTvbKvozImrBXFoRlnRS++jEltDDmQuPbfLiYLGVTDKs/cCwCjn
	atdRR2v+d6IrFajt5gpCnIbsRC3MznjpWzxKf2GR4KIf9dx4u1jeWxQ0Qv36kSMKVpw48pw30Y1
	DH/FQautuF0tjRhzw3oZnO2//EWyT+k=
X-Received: by 2002:a05:6a00:812:b0:847:94bb:30e2 with SMTP id
 d2e1a72fcca58-84a516058f7mr4674736b3a.41.1784059126868; Tue, 14 Jul 2026
 12:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714194717.596193-1-jakubszczudlo40@gmail.com>
In-Reply-To: <20260714194717.596193-1-jakubszczudlo40@gmail.com>
From: =?UTF-8?Q?Jakub_Szczud=C5=82o?= <jakubszczudlo40@gmail.com>
Date: Tue, 14 Jul 2026 21:58:36 +0200
X-Gm-Features: AUfX_myzs711Ch5m3soe1aOBMfdRnDp2aINH4666i4uah2KBLUeUm9QYw3ctKVA
Message-ID: <CA+gq5JjVnLKW1WdEYzy279tqURXqqy+JNWn9zJPfXKGHUP5hCg@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] iio: adc: ti-ads1100: Add support for TI ADS1110
 to ti-ads1100 driver
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, marcelo.schmitt@analog.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, mike.looijmans@topic.nl, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jorge.marques@analog.com, antoniu.miclaus@analog.com, 
	mazziesaccount@gmail.com, jishnu.prakash@oss.qualcomm.com, 
	duje@dujemihanovic.xyz, wens@kernel.org, sakari.ailus@linux.intel.com, 
	linusw@kernel.org
Content-Type: text/plain; charset="UTF-8"

sorry guys I need to resend because of some dumb error

Best regards,
Jakub Szczudlo
