Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795333969;
	b=vHUZx3YciM8RhM2FshuZojfxcBnpCECO0haeahnJ0K5MbLpMalJKf/XMmX1sRWJkcUGK
	 HDU23Fu0ez/Cmh6iF4xBLbtmajZ0EtZAxIgSysmcqK2y3Zo4nfIbL5SLTTHd9I1ms9wQ/
	 vK6C9kvNSAnta2FJID7zvK1EkZHya30cEp+ocJo625UIBup9vXYRd1LqjQWcw0KxP4xcR
	 NI5HV9ALblNo6OKPjcA6OvF22W6jRjKexLy+xBYRoTptUsgvqnkSQWWxmKdvtr8vDlrFW
	 3sphrw2NDxcRb7FRifsIOAjJvaccIVrGkF1DbNz2tplpywsEb1hlPQk8kI9qI5rteXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795333969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ciNlBsmt/ihohJlZfy6Y/766ujih1RX020bU3zC+WcM=;
	b=fZsn7v75DoiCzujMBgtOSNwNlzqtRvnn7co0ydFsCNM6npVTdivwY66rx/ZGXJ6ZScCz
	 xSnZQ9FBjBNUy945MjgHjfXYuMUBDG8Ed+quCAPfa7b5RypPMOTh1vz0Me89vs74lHgJl
	 FKIwUWMcJ2xZcLl4DpgfcIy7MoZ5UB9KM1PZoKWT89SQESxiWUL5E3in8wL8FRQSS5uFL
	 GCZ3cf7xIQhNMc/2fR6MrsZGZcgwSY4nIsMZAt0r1qF4Fc4WgPCIhrNuRiwKYCR8wxXUA
	 CVysGnfJTftoFW1fJrNYnL0mVqpeZpVBj1cWDvp3tqFbuenXRAlyzpoiodZ2/MEVLWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P3EwjdAI;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83334606A320
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 07:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83334606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P3EwjdAI
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c50933bdf4bso538955466b.1
        for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 23:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795333968; x=1795938768; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ciNlBsmt/ihohJlZfy6Y/766ujih1RX020bU3zC+WcM=;
        b=P3EwjdAIWBuYLgL/Ltp4V9bQavyPv6UwTu/fxuJlsGnEVXJXYZ68AHtVcSfrG7mZeQ
         N5ozErcN2MOUyzf8gAx6EGcm/5igi2bDzdvqdcOaWId5XZVMGamXC6JUrqy8utwYfKxX
         sShDpsOzKDXDwvPgkFUrMBeRwZEk3TmZRBlGcf5u/4pHaZC32z8zWvZXmKkf+erQABWI
         RVh5fvOk7Dbv0Tkk4vKSIu4HS1fiZuHrewfI1Qt5wi/5//dmFR8vtbmgug9JDpPtBHys
         y1VrXy00Bb3YqcyZwV4wkSTcs0BPMnO9XVhcpMlGp1rc2LQXHUGizwE9snOgea3rFan6
         5Meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795333968; x=1795938768;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ciNlBsmt/ihohJlZfy6Y/766ujih1RX020bU3zC+WcM=;
        b=KEkPfxH1LSSIq52M4LKVVQJbkhOZlpfBKSPNR+jxIDU85RgKmdLwgC5v/F5LVzQZ3S
         ooIXbV5PeY/8BiXD0lR5dctx5pP2HE4wbLADS8I5/3qpcoxyxjRdpCIGhO6cM1Yhy0Ra
         M0Q9GcK6Dt0VIX3Hm2tKsDlF51tprtfjMNc8eJXZI/e9OBbtdugOn21MYD8vWEu1i4s7
         oFIJUQ8H01D7ynS56LcVIl1m7hjlgDUMCOkluIkAfhEwZGL793/Cj27ZKRwLlwz6YeX3
         Jwh18uS8f124YJt8oBKZJOSLivVk+lkl9RgxN4xY+/Y4E8psY/196bG7PBErtzQlvDj8
         tKDw==
X-Forwarded-Encrypted: i=1; AL+hErEA4ViWtZ79BHZAoZ7Upd7Hic/QiuzSD1xwrjfbqmU24InlE+bjQM+dRBfHteZebJf4rkpzIRRyVZA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YMfITEu7sLa3qWuY15aO8z77U8Db2PU0nM52AjhRFw482ERAI
	nH7MrPkbg3eMfiE8rJ8yMbvfkqrVnwjJuYvO55flhmJsTX4DJCkeagvU
X-Gm-Gg: AZFdTZeXIinELmtu5+5lurLGYLEGzeY0OHeLSuJf/9ANPw2aOb0p/V78Alze5Hpqwhc
	Oq+4nXpwqarUBTAblcZhgzraGleAFptpHfM3BKjgIZeg+oUxiVu9EzKghnCJT6pSQsYITTXGbhn
	/cA/mwHlCQWzWz2p2XG9Ow2gU2hYrH1owYbX++GkfTzaQl8VPazsWOVvt0RycIlpap+pDnYAXGi
	sjRTHg3U4XZmM4qbZDXq5btYiSAocxSvL9PoUxkKJeAKs24TSt2X4GzFfTt7JzkVdIVxrxkaPVF
	jG/0B/bQny4TBTZFYO88sz3AgkKDW7cD1CTR+GtQlsfAvFEu7WQxU8HFPsLU93pz2uFiRvTitEY
	ioYgfI7SdW1DTdeW6ZlbjEqcaaN6qjmwhrRuvSvH4doTKWnCJpie3lSTLKmWqcuRD8z7OVw/J0R
	wDwcexeUQQrQlbgQY/V4WMmS6IWnCErsx6KC8K6p9x27zuGqgomXLWYJwaxieVjiIf9eDYN/Fnu
	daWSz9zAlYdS1xh6xNTSB39x18JB4l46uf7+JGFcjAh+9bF7Ivk0XJ6zjt2rTA8VYJX1UXGrwiQ
	rwPS+mp0Nta5Xnh2/csFlL62kj1E+hWHosx9OZ0U7egoW5c=
X-Received: by 2002:a17:907:7b8c:b0:c42:4557:4532 with SMTP id a640c23a62f3a-c51317e487bmr815867866b.5.1795333967909;
        Sat, 21 Nov 2026 23:52:47 -0800 (PST)
Received: from dl360p ([195.155.168.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae67cbfsm291308966b.14.2026.11.21.23.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 23:52:47 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <crofts@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: proximity: add Imagis ISG5320A
Date: Sun, 22 Nov 2026 10:52:45 +0300
Message-ID: <20261122075245.2916935-1-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121-arrogant-viridian-swift-fb8001@quoll>
References: <20261116074013.355363-1-tadilhusrev@gmail.com> <20261117173333.1853986-1-tadilhusrev@gmail.com> <20261117173333.1853986-2-tadilhusrev@gmail.com> <20261121-arrogant-viridian-swift-fb8001@quoll>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Nov 21, 2026 at 01:23:42PM +0100, Krzysztof Kozlowski wrote:
> Do not attach (thread) your patchsets to some other threads (unrelated
> or older versions). This buries them deep in the mailbox and might
> interfere with applying entire sets.

Understood, sorry. v4 will be sent with b4 as a new thread, not as a
reply to v1.

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Thank you. One thing up front: Jonathan's review of the driver makes
the vdd supply required, so in v4 vdd-supply moves into "required"
here. Since that changes the binding, I'll leave your tag off this
patch and say why below the ---, unless you're happy for me to keep it.

Thanks,
Adil
