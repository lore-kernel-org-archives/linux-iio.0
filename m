Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5324E33F8CA
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 06:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780900977; cv=pass; b=VoXfEmi0ENP0cvEMueFJck0tXJwNoHgC1K8t777kACTJHOpg+nJBqDN5+//VQKGsO0L/Da9k62d65MbYpCaI6ICgiFP6KhDo+x08qw9p5OtcVS1iEv8wyUx7hA3SFF7eZg8BZqcAB5EGaeGSYj3Dh26lfy8o4afx50agLJauEF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780900977; c=relaxed/simple;
	bh=2m4FF1H3Fj16oI4omL3CoQRWVHLdp0v0t4i2u9x4Oos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHgQHvRh3HdGfSmLtXz5qSJ9U4pEPdFRsJosRiEjHJdbnDXcrHfx6BsOZmWxAB/q2+5ptY1QLKBGz94VsmR+KZonz9Cc2RSGbIdsSt1lL0XTFT7hUvQ4b+h3AJSzcTO6M+d3sifNrJSRrlIyYuflA74BZ3U5VIiwMuJmPO/owCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pRC1Vvim; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRC1Vvim"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so34079305e9.3
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 23:42:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780900975; cv=none;
        d=google.com; s=arc-20240605;
        b=drhB9s1HrPnMwMRc0KR280L9KKflBPFnfOLtIiomHUvHEQqqXLpNqXsUmeQN54oQjP
         V5YQUfpzAc5DVZ7S7zomvQJhwMomn8jCC/iZ+1CWwDQtdUN8eDWJDOg3eVuwn8GlO/CE
         Eb9g8spprlGXSDWvhtgsZhH/3ULL8SfNQjpGpLBzS4Z7vd6+sAIQrdTq47vGEYxQyux0
         H8QCAcFTQNFen3F/o13fTu7jWcPkkkrWNMzBWP2stfAtJtUMPkZfkLeFp6imWG4dA4IE
         jTukeLwRlgEP9VcwPVhLP8beoi/j7YXVgvI8iDz8Lyw3trd9Px1vCWxxduv/njg+pjVA
         DGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Iz6UAdLVFbtkbuNnRB62bZTTKNu+1QqVdCcPw9zYptg=;
        fh=aY4WD0+Sk58Cus5m768wrUgk3BgX8E6lSNAph5OmG9Q=;
        b=KYUzmyh1brkK131P+mItS9vH+QkBRIyrsVfxnmVv4EYQKkWvxa+jljaJpLFaT5pM+T
         cNahwpGQ1WzPt7seYkOUvFBo7djV92eQQa7wQDXNdmT8nXHLqdMim3710Rm1CyFtdiVe
         y+mWVchtylhNDVhAxkRwrEkAk4yVBW7SxjnCt+lh+sH0cMCAeK2CYhVxo3pjbM0eStZb
         BnhH+jI4EnO9hKlyUz7VypQX0oNEMcJza1cGZ/lJNtlwvblX6fWgcvECiGMu6p3UIEB/
         ZtK0uKZlUSv1n8avyjfqQR+DCGcZRYZ5wj1DTgpslxHz+W13klWGWFmSZLjYDI+xsuLo
         u6kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780900975; x=1781505775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Iz6UAdLVFbtkbuNnRB62bZTTKNu+1QqVdCcPw9zYptg=;
        b=pRC1Vvim1hjuy1HlLdpq2zcjW1jI+JCylFK3jsStxTZYyiwAkCkIwuCbcU1rrwXuqi
         afkzbA49mrQYcOCqDS+RTB2Jp+/dJS4B47KYDRHz/u6bNL7fMQTAr+6rk4U+wHYA0vXX
         bbNzRwiRUTRNqAmb6VLcduEXBXgxkl0bRyY/2cC6k3EVeT4IW5YrQFQnuZcs0NbLfJx5
         OY6QlKG+vTmYOAWPjhS6LLz3f4/HlKce4BfOzYVEA/2KVznJqlGf1L+Tb/dx+uX2Emu7
         Z/vqKxWwPANRHTyJWO/uhaCHO/hkgw9umcJz5ctPIxH9y03HyetbnfhpVe/+8sRtFj2l
         aakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780900975; x=1781505775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iz6UAdLVFbtkbuNnRB62bZTTKNu+1QqVdCcPw9zYptg=;
        b=F7z3bpPz17aKmATc50gKMKSVJYqLOnnG3MMcDPvLcdGaiGQKxF2a/9PLtKQH0TYOT4
         Kbnv2WYSRAuOq7g/4hAvzFCBgXNhpHtnhs3frEeCwzkQCM7X1BlF1/tLeYRCSAPGM2pP
         fL1gizEH+UcKGBMVUAyll5P0+j97043/vI+NkR2Y8aF0oaLtzBywC+SzdGCibwg5SGjg
         W/G3P/NOOh79/0xvv709pjB3OMltUM13HX0Sd6xBHUIug4uI4MaWsQ5Wx3oLCHEKbjbi
         MFtsGCpzHYqrMMyiln66NmEWiDysRXKrh7fmla7yROlqubuo8awF27o5nHZzi+uX1S96
         FjPw==
X-Gm-Message-State: AOJu0YzRcLVc1Ha0dDjr7svEqwnR+Mp5dBYoh5+OjmbAoosk8smi5TaW
	xHrvdEa2CgBZJnuZRkj4VOolzu0dkw/KPikoLt68ts+RMctt8yIv3wJeiJO1e49aM3R/KGma+Yr
	hbhhWczfxvoXgibJM+dcSIuid43/Ydg8=
X-Gm-Gg: Acq92OE8WJVMzOoqMckxv1xieVypWVj/Bep5KaMLquD+Fj3gC3jKBZIo81EeVEJByNW
	9OSuKQ1I9GnCDLgETeu1jM9qyLV9osikhgpusVUdNhiumuPZSMf6lg3Kq7R+AESkvw+cDdM9q1y
	bqUu9BCe2B8P6B58mjHwIHJ/8CPCtInk14vGLPf+Ji1ekh3xrBFs5ObBs6o3/RDK+aY64CPZKbO
	Zj2sPXuz55EnMXVKOL7xfFRFGvNXKwtG0zz0PWtVDQAzafwVIB6zoj0V+u58Xf3jAktD0NzGtHl
	AQL+adA6mVs0zZcEJ4JAkTEY07nRbaYplJv9NHPMfYmSpKpJpTtPo/1U4eEqAJIdlnFkNNFVV6E
	2TkJM3CJ32NMCYF6vGUP2LTTRSIEja5Gt6qUd6EdtkKpVeNajTdHOAPZg9twurNdVkHCnDJSM2V
	sR6ooS+IWuYj4GmA2e
X-Received: by 2002:a05:600c:c491:b0:490:bb44:3f8b with SMTP id
 5b1f17b1804b1-490c2605385mr236829205e9.17.1780900974731; Sun, 07 Jun 2026
 23:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607183542.368184-1-jakubszczudlo40@gmail.com>
In-Reply-To: <20260607183542.368184-1-jakubszczudlo40@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 8 Jun 2026 08:42:45 +0200
X-Gm-Features: AVVi8CeYykthhWJnSbjswIUaHDB2IApMfmXrVRYFt8ROlX9fi5MSoWFc1nB4A7A
Message-ID: <CALoEA-zogsk8VwXhfZkAPhqJ-dojX=kDoMHRVndQDN26aibvnw@mail.gmail.com>
Subject: Re: [PATCH 0/3] iio: adc: Extend ti-ads1100 driver
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt@analog.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mike.looijmans@topic.nl, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jorge.marques@analog.com, 
	antoniu.miclaus@analog.com, mazziesaccount@gmail.com, 
	jishnu.prakash@oss.qualcomm.com, duje@dujemihanovic.xyz, wens@kernel.org, 
	sakari.ailus@linux.intel.com, linusw@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Jun 2026 at 20:38, Jakub Szczudlo <jakubszczudlo40@gmail.com> wrote:
>
> Extend ADS 1100 driver to support ADS1110, which is a pin-to-pin
> compatible device with higher resolution. This patch also updates the
> device tree bindings and Kconfig description to reflect the new
> supported device.
>
> Signed-off-by: jszczudlo <jakubszczudlo40@gmail.com>

Update your git config to have your full name, you can't have usernames
etc. in your Signed-off-by tag as seen on all patches in this series.

-- 
Kind regards

CJD
