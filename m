Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795745976;
	b=nCha8jq+bt6GA4twB3dK/nEoRqnenDqTbAYq1TKGUFYou/TyykSCNDZKwo60kVqvsJ2A
	 lKEMNoKs/9pWOPEfvs0ucX2NQXOIOf+gcmvz5aniI90NAwn4bt72E03nyvvQBkhlgucH+
	 lt7CAykOc0IUuN68kehT5s6MXUmX2CS2XaeNNQGSdOHBx2BTquLzVmrk3WIlua8Ze2lX+
	 X0bkLgKB6Yga5peRc8bJk8Rr1U0LYuPP03iYrp2FA8b4zOMQxvVlvHRiw2UtlD3ISBXPk
	 I7++Q03ykjVy6yaxB5ZpXpZp64C4Ce4Knd7ICZgSypD+LZWrl5waBzzMrcZqQ+aRLTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745976;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Content-Type:Date:
	 Message-ID;
	bh=lEdmfvtDYf59q6HkpOhInvb9oPzLhNZI7PhqbULg+04=;
	b=YrHOn475I/4pAOuF3GbDQD9DIQ5N9Grv+uFC19r7Bh1bnzh8+XQ9yXaWyvmodOL1geyl
	 tErYGnV1dj3hEYnw7oV3zB3iEP5hhvu2QoDJPnEnLysSUCnUCz/YN8c/2M1nal2fvHKXT
	 FR3QhaFOQY5v8lln33yj6DuBbTIeXJdW9T+im84rwJZ/Qw4W3xiAbrLYKCRb6qTfHuqPx
	 1BqQcbCjEIZm94n9u/sREAxx9nO0GNnDwoYLpGkHuOfJTkvN+o0MnDmJlQAdnruNFKaKo
	 zSCnG4TG5hequZiX/LZ+/Xh4nlDqUy6+JA/lV6eeySaJ+qyv2OJccx4ZiipCoRyRL6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RuETlU2K;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F53606A31C
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 02:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44F53606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RuETlU2K
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b421e8d111so5041972a91.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 18:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795745975; x=1796350775; darn=vger.kernel.org;
        h=message-id:date:content-type:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lEdmfvtDYf59q6HkpOhInvb9oPzLhNZI7PhqbULg+04=;
        b=RuETlU2K0Im3LWwSCZsjXpTfzQDYQZzZMMpPj+SbYZ9+PWzz3db55pzowT4+8J8naF
         ztOgPM8LC6rTQTl7QaPZ93E1tNbS4Tq5LJbNb5bljqFAfubbt9TKAjJPweJMLmjahY+p
         Y8pAQkHIPxe6gHSrxYM89LJvA02TOe09B5lhCNSB+UsHmHFfmLqnciaL9Q4pupj+uqpH
         IDAa0flcB3YYM0Hw3VfuY8xDkWh2jrybPzNvCUbTBoi3eUjVvX7Sain9Ag01RoD/4zba
         reC9A02CM7CvjTv4bs+k9LEu7xs0xodivigL2R5dnIHMLR6BshW0mE5KxFac/wcA1EIz
         +2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795745975; x=1796350775;
        h=message-id:date:content-type:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lEdmfvtDYf59q6HkpOhInvb9oPzLhNZI7PhqbULg+04=;
        b=k8oIHv6VyKNWdRmJtL7euGAefyeSjM6vl7kjsfO7+h65VxcUpeEt0VK0TDb81yPd68
         Nlv8yqkQBqxN8XdDt2nxkF+wE920RTvxB+/uCsxBPcODfU6ZkJA4V9njtVtqMBy8s+gr
         whvgDD6ueAzcCs0G1zxt0/Cq8v4vgJTECZQ/rWz9obdSs41L9LyR7FEReFn10f+pi0PA
         Q+inKaWyG7nY6Li6cjsHqJ2novGg1OjlL2h1ldq+ddHF+B7zDSq5dkXjB5ShJ9FXQ1fb
         6wTkvqxjvFAIg+WDtNlgSMBfIU8hDjd/g3GMMyuKAR85x+fwAAomND0AMPQQrsA7c25/
         OsrQ==
X-Forwarded-Encrypted: i=1; AL+hErEyMkcH+fmD1ynOHYoH3vFOFkIYpRlQRxXX/j3N5K/F4AH8cn1X1hqPoBhQm5uKU1P9euYDWgbgmkk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dkRCNCE1QDtLD7G42cY8sW1SijgCTfaqxhbb8u+yc0hdXmkNf
	DffsHFy0Hv1TrA01b/7mAUmBeuJnkV23qisFHj9VeJBjaRkF+0Jps8JA
X-Gm-Gg: AZFdTZcmvrRf7NBiGNFExuD8tbNs2msCmzopLPM+3JhNGG4QnwPG1Maar7pDu91+XRf
	Hu6//Gibn1sJF2u0c+F7GFpoXJ5NcxihFB+em/ZU2Qd3xmXynhKpm/ZBli98qgpZ7jdLEP83TBA
	KNgvukeaB2ckKFKLY0Rpfs67zrboIu2FvsnfRlfZGGvz6oe2yFRqEeZJktdV61vyW73NYwZcJRb
	lWVX0/A5Id1r6xUj7f4nj+xy8Ks4MHMhe7PS4Etc2bRc/YXpISAXqi6XJiE0z8VHTTusW8obHQ4
	4Rxt1MsVyEjsybe/l3h0t524TY5ZMUr58bA7liQKy15ZSKtUrWLZHQV78GgsuR9Ody0eeZT9B3R
	c0UDPnBSqkHbKMP4fTIVFzUIeztH32BvttYHP7ta8kSUUwu6zjcBtMkNlDygGT+C1SqPibAgfhM
	G6Yp9u7pN5dZ8SsxnlEYUGILAsDGOlewZrHmgBmcLARZOWe54r/xZniB6TssqQDY7Ka9pLZWRfq
	VUX33fpzp2UkLOnWOpxbf4Pzx4UB9+FQU/YXVc//LWoVGshbQ+alV6zszJFGN3WwYD80kp4v7ff
	rJttdSsVy8MKR5KuaUBlvCwkDNZoY0lmLDYRuoeJIxqxKLvlxdevzoZRtbje3XELtcuXeSRp2Bo
	=
X-Received: by 2002:a17:90b:4e83:b0:3b3:ff70:4d06 with SMTP id 98e67ed59e1d1-3b41c9b324emr21488621a91.16.1795745975421;
        Thu, 26 Nov 2026 18:19:35 -0800 (PST)
Received: from mac.lan (114-45-165-38.dynamic-ip.hinet.net. [114.45.165.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40a878d50sm37964315a91.11.2026.11.26.18.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 18:19:34 -0800 (PST)
From: Ilia Snezhkov <iasnezhkov@gmail.com>
To: Roman Vivchar <rva333@protonmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-iio@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: adc: mt6359: divide scale by ADC resolution
In-Reply-To: <cLdx9oABQCqAoQThLiQ2oL34p3QMP4Xjq-kkFh6bkQfY16c-wXzqrKm06VYO0rxMkR56vn2ycUamZ7i6zv0metPym3UtZP2DUW-7H1KKyB8=@protonmail.com>
References: <20261126031013.27701-1-iasnezhkov@gmail.com>
 <20261126031013.27701-2-iasnezhkov@gmail.com> <cLdx9oABQCqAoQThLiQ2oL34p3QMP4Xjq-kkFh6bkQfY16c-wXzqrKm06VYO0rxMkR56vn2ycUamZ7i6zv0metPym3UtZP2DUW-7H1KKyB8=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 10:19:29 +0800
Message-ID: <179574596911.3233.3328617859832706425@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list

Hi Roman,

Sorry for missing your series and for respinning v2 too quickly — both
were my mistakes. I checked my other submitted series on lore and
confirmed no other duplicates, and I will give reviewers more time before
respinning going forward.

I will drop patch 1/3 in favor of your series and send a rebased v3 with
only the remaining fix.

Best regards,
Ilia
