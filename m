Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427231;
	b=RYpQqZuIRTQdupG9r5ynGajx+qeY1lfas49em9K9zlY7waYZ9x4iPBMTL9ONPuScBLrM
	 9HIr87YrcoeqFSgOX1qYUTUNyF8B90l1a3uccGQsQjm1a3btV3c/fVXh2n7zI6JqSeBUp
	 /csLN6aksxcYtctODkkagUNYdNtPR1Sk8OpG70UjjK6cPbksKQUAXwo49U9zz35rZxNTl
	 0YqAb3v9nicRKTb8WouJirRkwg/Bo9AqiBLh+xKcYbaSbjUHv4Oidb/FEZ3OJoe7S9dJF
	 4o9ILI9rYlIMrWNMpDaB2hL0zQ8q+RT2s1SqC6i+wEXfZjRHeUZH0ttEcLdrCS9TEag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=p+2Z0iAhcp8VOXafcysdCm6gOgr7IJoVThJ4qYkpC4o=;
	b=4KpDMnR7BfyBxEl+kUI9Va/5BFMMO4J2FxLndZiZgCjMplAOZaitKdyVF9029zdvuA3y
	 K9+OpQ6ryHU19Zzs7rtdccmp6pUF2pBPKHnIiPU0ZsTFK2nSkt40Rw8xtoRxorp+yDtR+
	 rLwNjoKeLikIVMe6k+VP+FbouNYv8QPs9ux/uEn63bSHjsJKVmZt4e0f5QkFe9oyE7fIZ
	 WvSwaVABOsPG9LKNx9G9Y7S+qRUNfh1XXSOWJuVfZE7r4BAVqAHevyLf1XV625KlJgIRr
	 cWoTn9kH96D0+ubRFOVQByL+EGO76wzewEWkH+fwbr5K+zz63+8MgcuhvRQU3f8up4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ICpsNtDj;
	arc=none smtp.remote-ip=209.85.167.54
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D2E606A32A
	for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 20:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95D2E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ICpsNtDj
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5bfa7c09c9eso2411997e87.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 12:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794427230; x=1795032030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p+2Z0iAhcp8VOXafcysdCm6gOgr7IJoVThJ4qYkpC4o=;
        b=ICpsNtDjl8RpGDWPxeboydSu/EEH2dc3F1U/ihmVr5TvqmB9GXzkPDgrSdb4pTybmq
         rSXYND5og4GcBCQzlUFJdJ7g1a0Wg25xXHOc0oR5VBOQCimogGtybB77X2IzzJAL4QCY
         u/rPxDk7NZAtRuT5zgOxildkgI8fjUqWbzfA8BpS1lDpmeugNImYN4GZjcm5G/yE5pEa
         Bmh8Ui1PeSQVZNNz0MEFnx4+oVTDI3tlGl04FCJBhH39Bt9Bpi3W0D18XWQJ6YEjdkdF
         oF1V2Lh3uJOAsQow9V6jQCoClk4BzSTaL6w3T4gVUiqgEkTBavTQWVWq12QqWIUd5r1n
         sSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794427230; x=1795032030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p+2Z0iAhcp8VOXafcysdCm6gOgr7IJoVThJ4qYkpC4o=;
        b=gHo7kEbKFmD3vG2yuURtk1y6p6xAXgzZF9zdqyKYH93bx5Cxd7AP0UvfcV/vRuVlz/
         t2lx8FxxVNUgG5mCldMv1x4E7+pAn5qSDPPEcrDqSHElCpfmmk0TRKnSYmWGROlqhve+
         RfOZYqhlKfFtuxwCqWisMlAdl356H8CxmwfM7pEI1HFe7M/v+lBIHcz9qUl/D7JTi/TK
         WZqBfDdtsAXoayRt6MIMKClaWQINGLzgbBK+ikFHiN7QI/lEaTTBEbFEhbcgmcpxspIm
         qbcAJOrv+BGHp2+/TRu0QT1MwrJcw2wg0uoDfryq3XBO7yaOclwid/JbCYHGgtUf5bGH
         v/CQ==
X-Forwarded-Encrypted: i=1; AL+hErELbV9ODthRlCD6NNpTTyBrDyLPZzZC9uB9uenmtt3WhWN/13b+AZVneup9u66P7Kg3YvxYgrQHQYc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BSbSa8o7X14Y2Hiy3yrqwUl+x+xrTSYdYbBOq6EdoxvANyGhu
	dFoA+x1S5KV9nTzcUdc1TWGxSx8T1gAOdquNMzHy40NNiYpm734tKzpY
X-Gm-Gg: AYBFou0UoIbvuQGll343cJRASVr/GK+WOJ15szv08T5CRJy4rfJeTCQ+jYNlcQ9TRnc
	J1rlJ+mdxCnbfjL4sg0ytuVZ6riCNCodqdcrLNGgaDS5qUZ0AmVhObNNQNEriFOqg8psXqjXfau
	rdgUJj7YMMMFRdVWc8WPNwuSn0BHOYUTLTmULxDmDvF5mcMn4qRtYNuQMfag3APPW1iOzOiHV+c
	CK4VLTaUX+0iZWJsOmugTVNBHCeilN8bALvkS87STbXxOfkCQCXPcS1tLKq/mrzsbcipO4Nl3Jd
	NhJp95fyFhRGcb7tEH2cMsH6sdo7ZPPhOA0DG5IwKgLfbEQW2I0WNr7bZxC+B/RBX8NyCbmqtXI
	GfHbj4v+QY9332xpISHRWg6bz/aIvbGXdmrt1Lt0E/Xu5u2ZoPb5UkQeaTNA/qyz4MYA6R1sI2o
	jEzEml/iRbfEam6XbsEmYMc1DaCHqMbIShUNtpApmy4hTf7tVoE2Sj1e73pqrb7rtdVah/+CDtD
	kxkO4nWlsU6V5cnxXxjZnnN3yGEZt41njhbYnJve61DKUhy5GxseTfNQmUVA69haSFVe0jtnZ/9
	z/t6u9kxL5Cpc3NQsw5XQxbnk3d7jE1D+j3e3+GnndDNfgyyzinnrwUrRdz8rdM+VLw9f/l7LHJ
	oEsv1ak7jL8nRcovc/lS45NHpkN5/+F+UAPMD
X-Received: by 2002:a05:6512:b8e:b0:5c1:5cce:7f1d with SMTP id 2adb3069b0e04-5c15d58a87amr1050525e87.9.1794427229586;
        Wed, 11 Nov 2026 12:00:29 -0800 (PST)
Received: from yantra.. (nekmmqtce067ylb1za0-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:5558:447:baa4:a7d8])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157bbe89csm1102957e87.81.2026.11.11.12.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:00:29 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: Re: [PATCH 2/2] iio: pressure: dps310: add a data-ready trigger
Date: Wed, 11 Nov 2026 22:00:25 +0200
Message-ID: <20261111200025.38344-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-208073@kernel.org>
References: <20261110154254.39092-1-zoone.rupert@gmail.com> <20261110154254.39092-3-zoone.rupert@gmail.com> <sashiko-outbox-208073@kernel.org>
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

On Wed, 11 Nov 2026 02:15:48 +0000
sashiko-bot@kernel.org wrote:

> Should dps310_fill_channels() read pressure first and use
> dps310_refresh_temp_locked() like dps310_read_pressure_value() does?

Yes. The wait came with the triggered buffer support, so it is older
than this patch and holds any trigger faster than temperature to the
temperature rate. Fixed on its own:

https://lore.kernel.org/linux-iio/20261111195118.36853-1-zoone.rupert@gmail.com/

With the fix, this trigger keeps up at 8 and 32 Hz with temperature at
1 Hz. I'll mention it in v2.

Rupesh
