Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795671341;
	b=A/bfkPepOGvi6tNmJDZdXN+SK2ycOQVEXGLsem0W80hgTHEsm/Ea52y31xbAjWeDIRC+
	 pHI4VitAbuOCjM3Pfu1TVFLOo2aka/gfYDISV3JAcW+Ui6PHWnIlWvSbohVcFQZs/Nu0t
	 FIH+QNP5KpAkSY/nv5MINaa9bOewZgwLcK4NbC5YepU9PjmyT5aTDw8FkkwYUWjuWUrCT
	 k4PCkOgKv0H5oC51L4t5qAbgOR9kxb9iRKfO3qbVoB69j09mIiVbug79P87zWT9gIB35w
	 CBDID53bwvQYb+lxv6+bYeyeFMhWQoE96dGx9VetlMc1ivdHTyAI99Qk/vlm22qAVfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795671341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=t5d/xSmVguWHOOwwL11eA+wRkCdGaUqbRUc5A9MsbPw=;
	b=tyilqevdc1ghgLAOc6Aqm3WVo5n2hZCFuUuKmi+dpN5KPHmXip+FrDT/u31TuP+iYxiV
	 sZ39cc6Rc3SOGPu3v6SB0cbZfqf1qOXMymR949ja0M2ywMm7lVQ95k9YsjvuifYBEwLeH
	 LMXYFroNKAuDMnPWdoBiGaQcbvpdoHuUSv9PWnkTNzsM9WB07YNHcMUzTEE243kHT1RN/
	 /6tyC7himb2EUX+Pgzn9mtOXXly4006r58MKvuCaKVvCP7KdwJwwaLkRt5itRG3fSt+FW
	 HCI3oGLIj+RKi0ZZNtzXzVwCyWT17Qs01e0Evw11DwxWBcFjCQ2YxJrTy7H+iVRJpDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GVGnL+7U;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F0E606A31E
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 05:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18F0E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GVGnL+7U
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso6122736a91.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 21:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795671340; x=1796276140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t5d/xSmVguWHOOwwL11eA+wRkCdGaUqbRUc5A9MsbPw=;
        b=GVGnL+7UJT9jY2dL6VzbSLPqIBLb9sIj5YhMD/CLlDDA3i7geHCkqRYpuJLj09kXit
         B6f9nDRwQXa7YIOFgWO9q0BgH471cmq8gAY+EbjbXHEC9N8AtQ0MRNNdLEBA3uJqc2Bs
         fxdMq0UihvnkkQgKG9sjQ2j+i6SeMbHV9Tcv0YbPa3XyxRS9oPhnJcLkejiC3qMtKpdo
         thvOx6iBsraSSzjFtqMDh4iaLEpPjXYXyfNIxASts+8iJhpr1TbVQbqN+lBCkI0UjlHg
         98ulby1he/Mx45/k2l6rhztLYZopPx4vRcLixghfPp6cJU/WgilYSDPy3Yo62MY8zBUv
         FxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795671340; x=1796276140;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t5d/xSmVguWHOOwwL11eA+wRkCdGaUqbRUc5A9MsbPw=;
        b=LpFrW3J4YIp2XIQ9tenWsqG0nP+y6tQ5hCl/Zwt46aqImoKn7SdLNCX2BqUWveEe0h
         z/moTZT72ve6vNeLgvDZqxjjppDbwhY0FPG0TvV5FiiNiLGV1zWEShyUDX5c5tlE5hUR
         KNVyIHoJaBV4DKK2KcUkqZyrIYK+CW8INi4UbXOs0rCVm2+fLCDbRQkBVEwCNRbQbl8O
         0+owBvmgNAI/5Gs2a2tMvr+omPi2OWSBnmUaLUpEGLaHJnGD2YCjsV7c2Gnk2G/Em8Ex
         vDzHeKywwrOLlGyAZcaeE5XQcZIt3WfR8faQnRmQzKce+ray3y43hjXAFjSy3cSFkmQJ
         5IDA==
X-Forwarded-Encrypted: i=1; AL+hErFv5dZj9bXFtSEiS94FqRm/TzmBLCeUCJt+V3ssE1TPccybHS65EirYr0YmhifF0NeaAjcydLcLYdk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/J2Orwn86o+Y8w/2hraEltA1zro8GlUghMYi8lQeTobLHyUGMG
	G+UmipNnvKUU6tXZddl728AXIYh4X+Y7Rgshy41SMB9rpgASSLA8a0Oe
X-Gm-Gg: AZFdTZfXeDAZqlBc0hvRgHSdB5UXLbCfmbbu4B8ak3awZSRe7KHNdVqhWpmodshPH1X
	YO3IgWv4zFt0OjVB7KEFPwlJSVvKy2WQ4FUHzpTciQFutaj1ePlQnuiGqWgShU0wM+Gm+MMI20b
	CxcckSasrCttlelpl8zilrRm8N0zCEuytsbH00W3XEKNeMKVL/2+LQ4bLfBT7A7iv5cT94qhDav
	oI0izQc+slLY9lLfOiVgh0Ygd3CaDdeOYJ6UGw8M+QIKa4sJOcmBpaU3Hqu2Umndbvs7jtI3Bmh
	KVPuNORdoXd3gQvxrzZHfHVzWXVlhxreX6A7GyAvXEKhVdY0F2+k9hYK2hDsJ0Y9d9z8TMHuu8i
	2shD6shqqXhSSYbEYzGo2Y7+GkiF804y0luSJ4y9R5dGHTstY+0Vfi3fJI98kSH0+1oT6tbfphl
	wHM8484HUr/7rlCuE+Mx2mdbdKVQGc2v5IjxkYr7uDZJg8EmUSfpeKTevdIV2RefhBHZEG1RHLe
	9vW/6sV87J5sUvB5LsyLIWaX5D1Cj8UcG/d1bG+YyvQZn3hnn+CqxVfL5QXTt9C/vgkDv3eu1o6
	fNEj/3rlouo9oPS7EbpQi17qd6JwvQ5xxdskXvxLoX79a178s1AFh6a1Ksn0q6pDB1C/B0UJ5tp
	kT4SwnnPyyJXR80LogiZCjmBvSiZWs0/FrvFjdQGqGf3QYX0SzZ7mb4XABtH0beqdPahot3WF74
	c7fFP5iLKf1320pgvDKKxGbug=
X-Received: by 2002:a17:90a:e54a:b0:3b0:9310:b255 with SMTP id 98e67ed59e1d1-3b41c961506mr8969271a91.36.1795671340410;
        Wed, 25 Nov 2026 21:35:40 -0800 (PST)
Received: from kapoor ([149.40.62.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d639fdsm34005822a91.10.2026.11.25.21.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:35:39 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Zhiqi Zhang <zhiqizhangg@gmail.com>
Cc: Tomasz Duszynski <tduszyns@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: chemical: pms7003: Reject frames with invalid length
Date: Thu, 26 Nov 2026 11:05:26 +0530
Message-ID: <20261126053526.623714-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126052717.69095-1-zhiqizhangg@gmail.com>
References: <20261126052717.69095-1-zhiqizhangg@gmail.com>
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

On Thu, Nov 26, 2026 at 01:27:17PM +0800, Zhiqi Zhang wrote:
> Reject data lengths shorter than the checksum before storing the expected
> frame length. Keep other lengths up to the frame buffer size accepted so
> short command replies and compatible Plantower measurement frames can
> still complete.

Thanks for the quick respin. With num >= PMS7003_CHECKSUM_LENGTH the
checksum offset in pms7003_frame_is_okay() can no longer go negative,
and the 4-byte command replies and the 20-byte PMS3003 frames still
complete. Applies to iio testing, builds without warnings (W=1) and is
checkpatch --strict clean.

Reviewed-by: Arnav Kapoor <kapoorarnav43@gmail.com>
