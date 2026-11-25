Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795565319;
	b=1XU67RfhQryHoza/142MGvszn/aCFWYwmzLg+QOzVDz8K8uOs6/mHOeyNHBMjuVTd6Hm
	 8aRCsZdgCvYL+f5+sbd1wtnHv1LQMGd59twYzVIIfvqegc/jk5CiNTyg77GND3Ro19lwE
	 rDrueMwH98T72KeCIhBMYmGbOByBd4zBnukh6z/qncJBC2uWsMhgqTWiCGt8Vcvjffu9i
	 0/LDD9Jo877ApzB0vpwPBnaVApAWXKwNDEsBUmgYZcB0gZ76BONQoHjzLI9Pu8vLL6nF8
	 zb3CY85yLkD22Jofs2FZlyJaWEIAW8wN4F0czOoa1MobbWmCpxn+t/Yj4xOpvfP54BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ZwSPaIIuX4Cl0pDLP0thkg2GYNUaqB0p9k+cHwih3eY=;
	b=AeL0huLptHN8xOqXPybHbtEG6ZRL+bI9VOXsGyTY1vgnc+MGZJ5GkwPPc9r+q2A/jdUt
	 JTC2GbaPBGijFWdUdYWfDHwBG3+3fo4u3GY8J1OjBFTGPpC69y1i1xDWNQdm2qEwmVozo
	 KDFfX+RLM0wLFw6ygJIBHW7YMccGS27wl/daoT51lAEULaVlB+blTr1zMQ5vd8JQCfnEi
	 OlitcXsvtavjGtx2I94jN5ytvJasNK4NOi90NkaX/GOOh+H4Zb+m9VDCUa4NhyGa35qfF
	 IPHOSOk5kIpWQJFYBTKE/UQxNq6IQP1BnX7B7lT1AZwn1oiUK8cPHs1cRCkCQ7p0WZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xmwBrKI4;
	arc=none smtp.remote-ip=74.125.225.136
Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B6C606A31E
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 00:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41B6C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xmwBrKI4
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4bb86801c8fso980485e9.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 16:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795565317; x=1796170117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZwSPaIIuX4Cl0pDLP0thkg2GYNUaqB0p9k+cHwih3eY=;
        b=xmwBrKI4y9gSQCfHQWXQHK5UdgmVg8LEO4WAHLoGZRtYOOSDMd3Z1JW4B4MxIEcXku
         u3OhXWrN58JQqZbS6bFj7+qNeDtaKt1qT9/B5+sRvJdKmplQMVTbGWE5OhomWq1AQhsF
         4TtWxeMdglrGfTnqb2iij/FQiwVetXlyaWEBH2xhPohX+Ess0zCxakgjL0AP7kRdwh4p
         /cAT2AQqktaM/tRtRkEUJTkrI94wUnDHOiXxmCf8ILQCV2iLu5vm63SxOZ307JoR5zLk
         OfHoahKl11B53xVp4+NJJzJIOkpUWc1pfDBXXuYSdtOnNUDum20wPdSTpLue9/1rTgA8
         EiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795565317; x=1796170117;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZwSPaIIuX4Cl0pDLP0thkg2GYNUaqB0p9k+cHwih3eY=;
        b=DqvRb2/P0w5QrFQ+7SjhNkeC3r7VJOJennXmKevhheSVygMdLQD9Qfstg4Cx6yTAOd
         DarnLUQRB2LB9HlsJ98lzLmKFQA8suHVOCxzq3E/JShQ4cb72AW4maH697PbTynsEojm
         HeTIDdX2SrlPKCRVIVmY0Sq/la/rj67Nd4y5qlbPQzN2DFpANmw5+9pzyfjMS5VDp98H
         +2ZK+7uWmQ6BZC14xpfLkeoGuYKoaC0/PF9GiQ7pPdon2+hKDDXTP7DPYFIFtaIK4QV+
         qqhgM/tySKPt3ruftCAb8+PotaK46tHFagaItUEBxQ6AzFRZGkUutvtBAAE+Hkd6S49h
         gvKw==
X-Forwarded-Encrypted: i=1; AL+hErEHV8Rm7BtJdaXR4XeLEI+iLnHy19xdXLQZcLo0xGYvw1JWmNJg5AjZ3/8N1TAxqqYA3xE0Dci2t7o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/J4iBHjiudbIQGUAM9LRrttwkMLZwa8b6Y8MNiW6Qf0nJQlsyQ
	mdeaYE54unrQgDhY2nVVlXmloqTrVTIa0WCjJYMooIhV4AI3M6/O0NO/
X-Gm-Gg: AZFdTZd50EwanpbVTcXu3cUzphRKyAW0tKQm5ElYV3VhYgZxUWXdRQLEuJA6PvPaxiq
	J2QCvZEXZlxVyDEzGM+e9k7gvmg9td702VqeYGljfmduTtc6GDmrHuGAjOzVyAI/o79S2GOSA7w
	GEiKWaK/gb++Mft39JeTblEWvX5Iz/EIEvLzWVvlKW590RslejT5teqH8yJ8woEDokn/Q1g0fJs
	qxQftJd7eClVlUsgY+q0ClxT91bRyFB/pzA/1ggxy3mFYnv6GuQWSeWrskAwKwwA5H0DnPH8cFh
	qkohTSV1vYL1+ma1Q63H+0GkIfHs+91DhhMxaouxof0cdZu80dTgMB8TQ9rNyLQVWoPNUUCR0Oh
	9+7QJv0QV+2aWYi8vG8fjKvb+ndxNIDxYj4CzfzO2ceG0YIwlFKUuYwZhOgipWld9rULXLziJiA
	ZaSur4uwlzleobM58xdvQJpXFwxIMlX/jDDmwjr2BHfz47svmX1EvSiG1+AjbZ2fA6eRYNqXuco
	wpD/1zEdxRaAlpJ1KdJbFOs/wc+E6wI6HkmbIMlBMqRaR9h42RFJ9Hzt1hkSBBoeS134U2rbgG7
	Pfz/y9ndmhPHTirJRBY0yDBG1e+w+FvAArTd
X-Received: by 2002:a05:600c:b8a:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4bb88818156mr326432035e9.16.1795565317475;
        Tue, 24 Nov 2026 16:08:37 -0800 (PST)
Received: from [192.168.1.35] ([39.47.150.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b3a7sm530818065e9.3.2026.11.24.16.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 16:08:37 -0800 (PST)
Message-ID: <543edf51-d9d0-4f18-a977-e557309914f5@gmail.com>
Date: Wed, 25 Nov 2026 05:08:33 +0500
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shehryar Ahmad <shehryar.amd@gmail.com>
Subject: Re: [PATCH] iio: imu: adis_buffer: fix buffer ordering for IIO core
 demultiplexing
To: shehryar.amd@gmail.com
Cc: Antoniu.Miclaus@analog.com, Dragos.Bogdan@analog.com,
 Michael.Hennerich@analog.com, Nuno.Sa@analog.com, Robert.Budai@analog.com,
 andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com,
 radu.sabau@analog.com
References: <20261124213118.63979-1-shehryar.amd@gmail.com>
Content-Language: en-US
In-Reply-To: <20261124213118.63979-1-shehryar.amd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

sorry, this missed adding export symbol for find_channel_from_si()
and fixes tag, will send in v2 shortly :)
