Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160696;
	b=uhqc0hZBfuWlYa5c4HqneuFcLV5JIC4XeVH7tVflNXDCdkaK0b6472nPcga101E1V6L7
	 0rZghctn+n7I2lJjtiXole6lTvpfMnfAH0Axgn5UQBT2nXSinDq0HlNl6CLP2f5idOkOm
	 gQnhdUlGy1TLTZxcfKuXiuuNJHtD0Pj9R2I6nT/BbOspEL7gqcyQZvbmtuZHKgueYyG/S
	 7Snd20kBQsDHas/fevuj1KLfzpjo5SAC4UwMAs0HXaS5bfY0mE2t3GX7QubLEJDiuZxRO
	 Sx1PnM/nEpkmWXIAtuFLhGSv6eyRq4xmu9IFA7x9NTrKl7kdHWt7yYteUOR827nbAig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160696;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rjBvAWHobrA+kloQfAvs2bCx+QwKNtY1uhj8UIBra9k=;
	b=hIcKXYCyLcNYm8XhKx+SGsqWT3fyDQsFmy2YmR+vJ2pSgxiQoQTusvDNfvJllgeoQivA
	 HlpsnZsuLSpzhpWsnB8F8GQQhkiyKobUhzF2NTP/pE8vCBcny5T3NyDyoGKDjPIjc3ZUw
	 R9giTFjsi76VEMwSv01uHBTiCVpGfQA44vbN/F8Ymfej2xogzbcfZ7LiA+P5IsN4X78Fu
	 N6UHPAas7qVBxwJr2/gymJN2YbCGBItyGXtggZ9fCm4InZ/2JtjqL/MW72ZAc2WHLU9Fw
	 8ddH22nAJd23RZOlBexMDhsc/MsQ2hzxR76xpeDSJ6UFdWWlFVG0KggejrY3FAH7gyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p2KBiRV+;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8F4606A325
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 07:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF8F4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p2KBiRV+
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7cc53938a8fso477677137.2
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 23:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160695; x=1795765495; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rjBvAWHobrA+kloQfAvs2bCx+QwKNtY1uhj8UIBra9k=;
        b=p2KBiRV+uBuzYt2Sya7UHxjFoXbozZm4qEkl0/yODZ5zkdvTh2AF49gonzyZ8FDz70
         BhLodB8BE1Ebl41Rz4fOMBIVzDySf5RWwDnVngx2wu5A9Ak6adIJXogq9YwjUTCaE8Hi
         iua9E1cOVEpfv3ViYiSTDivegfasNDoL27tEr5lubdPV9IVJs/xFCZ57gR45qfGF+cVB
         bremeqMDuLPcMTLNKUJ4erVQPUg2a75VbFeqVu6TtlbYjPDPf7BNZMbbl5yii4XYXA6g
         /rl5471lWhIqK1guojVoTYRyR1F9YgTIZHHIctgISL/SmzYjsyORyQATIawZtqq3n056
         H7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160695; x=1795765495;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rjBvAWHobrA+kloQfAvs2bCx+QwKNtY1uhj8UIBra9k=;
        b=xh4T+sUPMXyA9BnWTjEFb59Z/Pd0VGxoFg6ttfqRlgRyDNiT5iujF31hqT/uyIqRxg
         Lb153nlFFxgHDnDnzBKY+ayby5QIAPX3mqC2YqB11yDpr1gdiejxWU/1xWEbOGqL8HvC
         5toYkTxTAmaMOlhAgMmF9Rlgtqnse99mP0u4JPQTMoY0PVQCEn5AEbZCtwfHgNu7vhCw
         6tDhzzXRD4sYp0wc49MYq7sy0PItwqaFhsIUJRC2t5lhVySlwxyiUJrO7zS+qN15EJlU
         XgTDSMFuZrn+ZW+LHTsbYJhHIiSYyl6TT70K3QiYl2ZMhZ2qxJ/Pq5GIEobe1BKVQc54
         +MUw==
X-Forwarded-Encrypted: i=1; AL+hErEPWat+XkGmU4cG27JJI+tvl5+I5Nzj621/2AbuVoDjZcjwAhpAcpNnBjPa7VHzxTMx60iYuCSQqag=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VGK2KBeforFaORaheaFaNEZO4AfonW2mpX9oEZI6LEY70vCBv
	ZfQSD7XEndsjqfRTQeRy//c8k64Vdj6NXihF/U27fT2eZsEoK/M2lg5+
X-Gm-Gg: AZFdTZd3OKUbw7NBzWYxVuCEwcEoupe1Fidkdfd5nBsRZ+9WuSPz7H7pyyBjtLro/my
	9ul/ljXw2uwYiqYzXba9biU/u8QkJ7d+A7Otg03+S1DeGgERzEYXM40D8NQhrjK8iemEYADzx4+
	tTRnIxRF4azrXnKOMTT4yqwJroWbktNwnmstEvuXIB+eyUmITPKHnYYF0RN6SIKJ8q9jL+a6k5z
	jniiNUUY9WzQzXr1fpYE8hsjhVaKtr4a+28QqzSqXCnYf49Y2skxCLmSaYiCORSNkQwdGMCpL9o
	d3SXnSpnx3Nbf3Rch/LbcRUQMXpMvJThEovm6Yq7eVcxAExSMOqp3awttxqGXBTLwC7Uy0pqIQY
	bJ65BDUzdT/bgEP4i60mDH03hYbtk3CwfG0JvrAjKAKfs1ol5tEaMGTe6zfBCUVg6xqoQ+n1ZQu
	Vo/Ifuww3LSjdKN65BWxyfP+DjGqwSTCIpTNwabD6UPxGn1I7mJtKeKRMKZqAv50rtutkRL0Mrk
	HVjJVGGHje67qY6gk6D15oAqXpyPp7sC8tF7wAbO0FWKXATYCwKhKS+7q+1zwK5jpWlGUjpuCzS
	96dL00pj
X-Received: by 2002:a67:e115:0:b0:7a7:19aa:8a88 with SMTP id ada2fe7eead31-7d7396a6e74mr738688137.35.1795160694891;
        Thu, 19 Nov 2026 23:44:54 -0800 (PST)
Received: from fedora ([2a09:bac5:565c:aa::11:204])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6dfc0b22sm2192077241.6.2026.11.19.23.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:44:54 -0800 (PST)
From: =?UTF-8?q?Oscar=20Alejandro=20S=C3=A1nchez=20Lucero?= <aleszlucero@gmail.com>
To: zhujun2@cmss.chinamobile.com
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	knaack.h@gmx.de,
	linux-iio@vger.kernel.org,
	=?UTF-8?q?Oscar=20Alejandro=20S=C3=A1nchez=20Lucero?= <aleszlucero@gmail.com>
Subject: Re: [PATCH] tools: iio: Close attribute streams on parse errors
Date: Fri, 20 Nov 2026 01:42:39 -0600
Message-ID: <20261120074417.33563-1-aleszlucero@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120062125.98462-1-zhujun2@cmss.chinamobile.com>
References: <20261120062125.98462-1-zhujun2@cmss.chinamobile.com>
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

Hi Zhu,

I checked both paths in build_channel_array() and find_type_by_name(),
and confirmed that neither cleanup label owns or closes the open FILE
stream on fscanf() failure. Closing them before jumping to cleanup while
preserving the original error code looks right :)

Reviewed-by: Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>
